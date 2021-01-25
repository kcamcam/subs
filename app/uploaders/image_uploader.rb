# https://github.com/carrierwaveuploader/carrierwave
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.name}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # Processing methods: https://github.com/carrierwaveuploader/carrierwave#processing-methods-mini_magick

  # Resize to fit keeps the original aspect ratio.
  process convert: 'png'
  process resize_to_fit: [400, 400]

  # Resize to fill crops if the aspect ratio requires it.
  version :thumb do
    process resize_to_fill: [64, 64]
  end

  version :preview do
    process resize_to_limit: [128, 128]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # only allow images to be uploaded
  def content_type_whitelist
    %r{image/}
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{model.name.underscore}.png" if original_filename
  end
end
