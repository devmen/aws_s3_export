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

creat file export.rb and paste code below:

    #simple script for usage
    require 'rubygems'
    require 'aws_s3_export'

    s3 = AwsS3Export::Export.new(:export_dir => 'a/directory/on/ours/computer', :bucket_name =>'your-bucket-name',
                                 :prefix => 'a/prefix/in/your/bucket', :access_key => "XXX",
                                 :secret_access_key => "XXX" )

    s3.run

Run from console: $ ruby export.rb
And you should will see something like this:

    Work in .
    Work in ..
    Work in 1
    File '1/large/IMG_0298.JPG' has saved
    File '1/medium/IMG_0298.JPG' has savd
    File '1/micro/IMG_0298.JPG' has saved
    File '1/original/IMG_0298.JPG' has saved
    File '1/slide_Show/IMG_0298.JPG' has saved
    File '1/small/IMG_0298.JPG' has saved
    File '1/small_149/IMG_0298.JPG' has saved
    File '1/smaller/IMG_0298.JPG' has saved
    Work in 11
    File '11/large/IMG_3518.JPG' has saved
    File '11/medium/IMG_3518.JPG' has saved
    File '11/micro/IMG_3518.JPG' has saved
    File '11/original/IMG_3518.JPG' has saved
    File '11/slide_Show/IMG_3518.JPG' has saved
    File '11/small/IMG_3518.JPG' has saved

If set prefix then in bucket you will have
  prefix_name/1/large/IMG_0298.JPG


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
