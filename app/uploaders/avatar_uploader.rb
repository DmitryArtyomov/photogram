class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimetypeFu
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    'avatars'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process resize_to_fill: [268, 268]
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  def content_type_whitelist
    /image\//
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    @name ||= "#{secure_token}#{File.extname(super)}" if original_filename.present?
  end

  def size_range
    1..20.megabytes
  end

  protected

  def md5(filename)
    Digest::MD5.hexdigest(filename + Time.now.to_i.to_s)
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, md5(original_filename))
  end

end
