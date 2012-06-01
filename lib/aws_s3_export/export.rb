module AwsS3Export

  class Export
    def initialize(options = {})
      @config = Config.new(options)
    end

    def run
      set_config

      # Create the basic S3 object
      s3 = AWS::S3.new

      # Load up the 'bucket' we want to store things in
      bucket = s3.buckets[@config.bucket_name]

      # If the bucket doesn't exist, create it
      unless bucket.exists?
        puts "Need to make bucket #{bucket_name}.."
        s3.buckets.create(bucket_name)
      end

      Dir.entries(@config.export_dir).each do |dir|
        save_file_or_dir(dir_or_file)
      end

    end

    private
    def save_file(file)
      if !@config.prefix.empty?
        prefix = "#{@config.prefix}/"
      else
        prefix = ""
      end
      # Grab a reference to an object in the bucket with the name we require
      object = bucket.objects["#{prefix}#{file}"]

      # Write a local file to the aforementioned object on S3
      object.write(:file => File.expand_path(@config.export_dir, file))

      puts "File '#{file}' has saved"
    end

    def save_file_or_dir(name, path = "")
      return if name[0,1] == '.'
      file_name_with_path = path + name
      save_file(name) if file?(file_name_with_path)
      # See if we need to recurse...
      if directory?(file_name_with_path)
        my_base = name + '/'
        Dir.foreach(File.expand_path(@config.export_dir, my_base)) { |e| save_file_or_dir(e, my_base) }
      end
    end

    def file?(file)
      fstat = File.stat(File.expand_path(@config.export_dir, file))
      fstat.file? || fstat.symlink?
    end

    def directory?(dir)
      fstat = File.stat(File.expand_path(@config.export_dir, dir))
      fstat.directory?
    end

    def set_config
      AWS.config(
        :access_key_id => @config.access_key,
        :secret_access_key => @config.secret_access_key
      )
    end

  end

end

