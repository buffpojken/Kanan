class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :file

  process :resize_to_fit => [1170, nil]

  def store_dir
    "system/photos/#{model.id}/"
  end

end