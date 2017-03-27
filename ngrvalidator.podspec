#
#  NGRValidator
#
#  Created by Patryk Kaczmarek on 29.12.2014.
#  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
#

Pod::Spec.new do |s|

  s.name         = "ngrvalidator"
  s.version      = "1.3.0"
  s.summary      = "Centralized and comprehensive validator for iOS"

  s.description  = "NGRValidator is an Objective-C 3rd party library for iOS and OSX. It allows you to validate the data in the way that you want. It's an easy to read, centralized, and comprehensive solution to validating any Objective-C model in just a few lines of code."

  s.homepage      = "https://github.com/netguru/ngrvalidator"
  s.license       = { :type => 'MIT', :file => 'MD/LICENSE.md' }

  s.authors       = {'Patryk Kaczmarek' => 'patryk.kaczmarek@netguru.pl'}
  s.source        = { :git => 'https://github.com/netguru/ngrvalidator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc  = true

  s.source_files  = 'NGRValidator/NGRValidator/**/*.{h,m}'
  s.header_dir    = 'NGRValidator'
  s.private_header_files = 'NGRValidator/NGRValidator/Headers/Private/*'
  s.preserve_paths = 'Scripts/*'

end
