module AwsS3Export
  #
  # creat file export.rb and paste code below:

  #     #simple script for usage
  #     require 'rubygems'
  #     require 'aws_s3_export'

  #     s3 = AwsS3Export::Export.new(:export_dir => 'a/directory/on/ours/computer', :bucket_name =>'your-bucket-name',
  #                                  :prefix => 'a/prefix/in/your/bucket', :access_key => "XXX",
  #                                  :secret_access_key => "XXX" )

  #     s3.run

  # Run from console: $ ruby export.rb
  # And you should will see something like this:

  #     Work in .
  #     Work in ..
  #     Work in 1
  #     File '1/large/IMG_0298.JPG' has saved
  #     File '1/medium/IMG_0298.JPG' has savd
  #     File '1/micro/IMG_0298.JPG' has saved
  #     File '1/original/IMG_0298.JPG' has saved
  #     File '1/slide_Show/IMG_0298.JPG' has saved
  #     File '1/small/IMG_0298.JPG' has saved
  #     File '1/small_149/IMG_0298.JPG' has saved
  #     File '1/smaller/IMG_0298.JPG' has saved
  #     Work in 11
  #     File '11/large/IMG_3518.JPG' has saved
  #     File '11/medium/IMG_3518.JPG' has saved
  #     File '11/micro/IMG_3518.JPG' has saved
  #     File '11/original/IMG_3518.JPG' has saved
  #     File '11/slide_Show/IMG_3518.JPG' has saved
  #     File '11/small/IMG_3518.JPG' has saved

  # If set prefix then in bucket you will have
  #   prefix_name/1/large/IMG_0298.JPG


  class Export
    def initialize(options = {})
      @config = Config.new(options)
    end

    def run
      set_config

      # Create the basic S3 object
      @s3 = AWS::S3.new

      # Load up the 'bucket' we want to store things in
      @bucket = @s3.buckets[@config.bucket_name]

      # If the bucket doesn't exist, create it
      unless @bucket.exists?
        puts "Need to make bucket #{@config.bucket_name}.."
        @s3.buckets.create(@config.bucket_name)
      end

      Dir.entries(@config.export_dir).each do |dir_or_file|
        puts "Work in #{dir_or_file}"
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
      object = @bucket.objects["#{prefix}#{file}"]
      
      #overwrite file?
      if object.exists? and !@config.rewrite_existing_files
        puts "Skip writing file '#{file}'. If you want to rewrete file set option 'rewrite_existing_files' to true"
        return
      end

      # Write a local file to the aforementioned object on S3
      if object.write(:file => File.expand_path(file, @config.export_dir), :acl => @config.acl)
        puts "File '#{file}' has saved"
      else
        puts "Somthing wrong! File '#{file}' not save"
      end
    end

    def save_file_or_dir(name, path = "")
      return if name[0,1] == '.'
      file_name_with_path = path + name
      save_file(file_name_with_path) if file?(file_name_with_path)
      # See if we need to recurse...
      if directory?(file_name_with_path)
        my_base = file_name_with_path + '/'
        Dir.foreach(File.expand_path(my_base, @config.export_dir)) { |e| save_file_or_dir(e, my_base) }
      end
    end

    def file?(file)
      fstat = File.stat(File.expand_path(file, @config.export_dir))
      fstat.file?
    end

    def directory?(dir)
      fstat = File.stat(File.expand_path(dir, @config.export_dir))
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

