class CreatePhotos < ActiveRecord::Migration
  
  def self.up
    create_table :photos do |t|
      t.string    :photo
      t.string    :temperature
      t.integer   :ride_no
      t.string    :ride_time
      t.timestamps
    end    
  end
  
  def self.down
    drop_table 'photos'
  end
  
end