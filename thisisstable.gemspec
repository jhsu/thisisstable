$LOAD_PATH.unshift 'lib'
require 'thisisstable/version'

Gem::Specification.new do |s|
  s.name              = "thisisstable"
  s.version           = ThisIsStable::Version
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Popularize a gem."
  s.homepage          = "http://github.com/jhsu/thisisstable"
  s.email             = "jhsu@josephhsu.com"
  s.authors           = [ "Joseph Hsu" ]

  s.files             = %w( README.markdown LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.executables       = [ "vouch-gem" ]

  s.description = <<description
description
end
