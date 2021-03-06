require 'sinatra'
require 'sinatra/respond_to'
require 'sinatra/content_for'
require 'jsonify'
require 'jsonify/tilt'
require 'active_record'
require 'will_paginate'
require 'will_paginate/active_record'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'
                            
Sinatra::Application.register Sinatra::RespondTo
                 
set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "views") }
                     
require './models/photo_uploader.rb'  
Dir.glob(File.dirname(__FILE__)+"/lib/*.rb").each do |fi|
  require fi
end
Dir.glob(File.dirname(__FILE__)+"/models/*.rb").each do |fi|
  require fi
end

helpers do
  def jsonify(*args) render(:jsonify, *args) end
end

before '/|photos' do 
  authorize!
end
      
after do
  ActiveRecord::Base.clear_active_connections!
end

get '/' do  
  @photos   = Photo.where(["photo is not null"]).order("created_at desc").paginate(:per_page => 6, :page => 1)
  @data     = Photo.order("created_at desc").limit(3)  
  @toplist  = Photo.order("ride_time").limit(3)
  @temp     = DataPoint.get("temperature")
   respond_to do |page|
     page.html{ erb :main }  
     page.js{ jsonify :main }
   end
end            

get '/refresh' do 
  @data     = Photo.order("created_at desc").limit(3)  
  respond_to do |format|     
    format.html{ erb :list, {:locals => {:list => @data}, :layout => false} }    
  end
end

get '/stream' do 
  @data  = Photo.where(["photo is not null"]).order("RAND()").limit(1).first
  respond_to do |page|
    page.html{ erb :stream }                   
    page.js{ "#{params[:callback]}(#{{:image => {:url => "http://kanan.vassaro.net" + @data.photo.url}}.to_json})" }
  end
end           

get '/fastest' do 
  @data = Photo.order("ride_time").limit(1).first   
  puts @data.inspect
  respond_to do |page|
    page.html{(@data.ride_time / 1000.0).to_s}
    page.txt{(@data.ride_time / 1000.0).to_s}
  end
end

get '/about' do 
  respond_to do |page|
    page.html{ erb :about }
  end
end

get '/photos' do        
  @photos = Photo.where(["photo is not null"]).order("created_at desc").paginate(:per_page => 6, :page => (params[:page] || 2))
  headers('X-More-Content' => @photos.next_page.to_s)
  respond_to do |page|                                      
    page.html{ erb :photos, :layout => false }
  end
end                                     

get '/counter' do 
  (Photo.last.ride_no+1).to_s+".jpg"
end

post '/photo' do 
  photo = Photo.create({
    :photo        => params[:file], 
    :temperature  => params[:temperature], 
    :ride_no      => params[:ride_no], 
    :ride_time    => params[:ride_time]
  })                                  
  respond_to do |page|
    if photo && photo.errors.empty? 
      page.html{ status(201) }
      page.xml{ status(201) }
      page.js{ status(201) }
    else
      page.html{ status(400) }
      page.xml{ status(400) }
      page.js{ status(400) }
    end
  end    
end  

get '/admin' do    
  if params[:admin] == "djupingar"
    erb :admin
  else
    "Not Found"
  end
end

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :database => 'kanan_dev', 
  :username => 'root', 
  :password => ''
)
