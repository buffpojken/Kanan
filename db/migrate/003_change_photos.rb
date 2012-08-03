class ChangePhotos < ActiveRecord::Migration 

  def self.up
    add_column :photos, :timestamp_1, :integer
    add_column :photos, :timestamp_2, :integer
    add_column :photos, :timestamp_3, :integer    
    remove_column :photos, :ride_time
    add_column :photos, :ride_time, :integer
  end
  
  def self.down
    remove_column :photos, :timestamp_1
    remove_column :photos, :timestamp_2
    remove_column :photos, :timestamp_3
    remove_column :photos, :ride_time
    add_column :photos, :ride_time, :datetime
  end  

end