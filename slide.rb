require 'sinatra'
require 'sinatra/respond_to'
require 'jsonify'
require 'jsonify/tilt'
                            
Sinatra::Application.register Sinatra::RespondTo
                 
set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "views") }

helpers do
  def jsonify(*args) render(:jsonify, *args) end
end
   

get '/' do 
   respond_to do |page|
     page.html{ erb :main }  
     page.js{ jsonify :main }
   end
end         

get '/about' do 
  respond_to do |page|
    page.html{ erb :about }
  end
end