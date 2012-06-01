require 'aws-sdk'
require "aws_s3_export/version"
require "aws_s3_export/config"
require "aws_s3_export/error"
require "aws_s3_export/export"

module AwsS3Export
  def self.extended base
    begin
      require 'aws-sdk'
    rescue LoadError => e
      e.message << " (You may need to install the aws-sdk gem)"
      raise e
    end unless defined?(AWS::Core)
  end
end
