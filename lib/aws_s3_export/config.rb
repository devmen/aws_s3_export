module AwsS3Export
  #
  # Set config for export:
  # s3_config = AwsS3Export::Config.new(:export_dir => '/your/dir/', :bucket_name =>'your_bucker_name', :prefix => "dir", :access_key => xxx, :secret_access_key => xxx )
  #
  # :export_dir - directory of files or directories for export
  # :prefix - prefix for saving to s3
  # :bucket_name - name of bucket s3
  # :access_key - access key id of s3
  # :secret_access_key - secret access key of s3
  #
  # Get config for example the export_dir:
  # s3_config.export_dir #=> /your/dir/
  #

  class Config
    attr_reader :access_key, :secret_access_key, :export_dir, :bucket_name, :prefix

    def initialize(options = {})
      validation_options.each do |o|
        raise NoParams.new if options[o].empty?
      end

      raise NotDir.new unless File.stat(options[:export_dir]).directory?

      @access_key = options[:access_key]
      @secret_access_key = options[:secret_access_key]
      @export_dir = options[:export_dir] || "./" # the current directory
      @bucket_name = options[:bucket_name]
      @prefix = options[:prefix] || ""
    end

    private
    def validation_options
      Array.new(:access_key, :secret_access_key, :bucket_name)
    end

  end
end

