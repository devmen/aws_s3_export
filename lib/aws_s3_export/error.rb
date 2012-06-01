module AwsS3Export
  # Example:
  #  def do_some
  #     if no_params?
  #       raise NoParams
  #     end
  #  end
  #
  #  If you need to set custom errors you do this
  #  class CustomError < Error
  #     def initialize
  #       super("Your text gois here")
  #     end
  #  end
  #
  #
  class Error < StandardError; end

  class NoParams < Error
    def initialize
      super("You should set all params like this s3 = AwsS3Export::Export.new(:export_dir => '/your/dir/', :bucket_name =>'your_bucker_name', :prefix => 'dir', :access_key => xxx, :secret_access_key => xxx ) ")
    end
  end

  class NotDir < Error
    def initialize
      super(":export_dir mast be a directory")
    end
  end
end
