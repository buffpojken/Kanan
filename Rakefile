require 'rubygems'
require 'carrierwave'
require 'carrierwave/orm/activerecord'              
require 'rake'
# This is only to support migrations, my belief is that someone already has split this out
# into a separate class in Rails 3! .ds
require 'active_record'


# Add custom support for migrations, since no sane person manages to keep the 
# database current in regards to scheme by hand .ds
desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do  
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end

desc "Runs the Ruby-code in db/seed.rb with the environment loaded, perfect for seeding the database!"
task :seed => :environment do 
  load File.join(*%w[db seed.rb])
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
  require './models/photo_uploader.rb'
  Dir.glob(File.join(*%w[ . models *.rb ])).each do |fi|
    require fi
  end  
end