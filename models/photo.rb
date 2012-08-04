class Photo < ActiveRecord::Base
  
  mount_uploader :photo, PhotoUploader
                
  # 64,7 m

  def total_ride_time
    return self.ride_time.to_f/1000.0
  end

end