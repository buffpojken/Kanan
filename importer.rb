#coding:utf-8
require 'mini_magick'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'active_record'
require 'listen'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :database => 'kanan_dev', 
  :username => 'root', 
  :password => ''
)           
require './models/photo_uploader.rb'           
Dir.glob(File.dirname(__FILE__)+"/models/*.rb").each do |fi|
  require fi
end
Listen.to('test/testinput') do |modified, added, removed|
  added.each do |file_path|
    ride    = Photo.find_by_id(File.basename(file_path))    
    image   = MiniMagick::Image.open(file.path)
    splash  = MiniMagick::Image.open('resources/splash.png')
    
    image.resize "800x600"
    image = image.composite(splash) do |c|
      c.gravity 'NorthWest'
      c << "-geometry +40+320"
    end  
    image.combine_options do |image|
      image << "-font resources/Averia-Regular.ttf -pointsize 60 -size 450x -gravity northwest -stroke '#fff' -fill '#fff' -strokewidth 2 -annotate 0x0+20+22 '" + (ride.temperature.to_f/1000.0) + "°" + "'"
      image << "-font resources/Averia-Regular.ttf -pointsize 60 -size 450x -gravity northeast -stroke '#fff' -fill '#fff' -strokewidth 2 -annotate 0x0+20+22 '" + "#" + ride.ride_no.to_s + "'"
      image << "-font resources/Averia-Regular.ttf -pointsize 60 -size 450x -gravity southeast -stroke '#86358B' -fill '#86358B' -strokewidth 2 -annotate 0x0+20+22 '" + ride.total_ride_time.to_s + "'"
    end          
    filepath = File.join('tmp', 'photos', rand(100000).to_s+".jpg")
    image.write(filepath)
    file    = File.open(filepath, 'r')       
    ride.photo = file
    ride.save
    puts "Done!"
  end
end