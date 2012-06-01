# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require 'aws_s3_export/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Dmitriev"]
  gem.email         = ["sunchess@inbox.ru"]
  gem.description   = %q{Simple gem for export a directory to AWS S3. You set directory, bucket and keys and enjoy it.}
  gem.summary       = %q{Simple gem for export directory to AWS S3}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "aws_s3_export"
  gem.require_paths = ["lib"]
  gem.version       = AwsS3Export::VERSION
  gem.add_dependency("aws-sdk", ">= 1.5.2")
end
