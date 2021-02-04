module Erp
  module Pgdq
    class ArticleUploader < CarrierWave::Uploader::Base
      include CarrierWave::MiniMagick
      storage :file
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
      version :system do
        process resize_to_fill: [150, 150]
      end
      
      version :detail do
        process resize_to_fill: [780, 470]
      end
      
      version :listing do
        process resize_to_fill: [390, 220]
      end
      
      version :listing_300x169 do
        process resize_to_fill: [300, 169]
      end
      
      version :listing_768x432 do
        process resize_to_fill: [768, 432]
      end
      
      version :listing_1024x576 do
        process resize_to_fill: [1024, 576]
      end
      
      version :sidebar do
        process resize_to_fill: [220, 150]
      end
    end
  end
end