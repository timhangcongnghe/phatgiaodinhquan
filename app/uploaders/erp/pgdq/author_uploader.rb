module Erp
  module Pgdq
    class AuthorUploader < CarrierWave::Uploader::Base
      include CarrierWave::MiniMagick
      storage :file
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
      
      version :system do
        process resize_to_fill: [150, 150]
      end
      
      version :detail_1x do
        process resize_to_fill: [140, 140]
      end
      
      version :detail_2x do
        process resize_to_fill: [280, 280]
      end
    end
  end
end