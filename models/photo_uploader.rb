class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :file

  process :resize_to_fit => [1170, nil]

  def store_dir
    File.join(File.dirname(__FILE__), "..", "public", "system/photos/#{model.id}/")
  end                                                                            
  
  def cache_dir
    File.join(File.dirname(__FILE__), "..", "public", "tmp/photos/#{model.id}/")    
  end

  def default_url
    "http://www.etechmag.com/wp-content/uploads/2012/02/Anonymous...jpg"
  end
end