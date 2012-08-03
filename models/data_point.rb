class DataPoint < ActiveRecord::Base
  
  def self.get(key)
    self.where(["data_key = ?", key]).order("created_at desc").limit(1).first
  end

end