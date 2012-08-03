class CreateDatapoint < ActiveRecord::Migration
  
  def self.up
    create_table :data_points do |t|
      t.string    :data_key
      t.string    :data_value
      t.timestamps
    end    
  end
  
  def self.down
    drop_table 'photos'
  end
  
end