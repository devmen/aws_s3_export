# AwsS3Export
Simple gem for export a directory to AWS S3. You set directory, bucket and keys and enjoy it.

## Installation

Add this line to your application's Gemfile:

    gem 'aws_s3_export'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws_s3_export

## Usage

creat file export.rb and pust code below

    #simple script for usage
    require 'rubygems'
    require 'aws_s3_export'

    s3 = AwsS3Export::Export.new(:export_dir => 'a/directory/on/ours/computer', :bucket_name =>'your-bucket-name',
                                 :prefix => 'a/prefix/in/your/bucket', :access_key => "XXX",
                                 :secret_access_key => "XXX" )

    s3.run

Run from console: $ ruby export.rb
And you should will see:


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
