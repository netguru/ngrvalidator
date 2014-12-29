#  NGRValidator
#
#  Created by Patryk Kaczmarek on 29.12.2014.
#  Copyright (c) 2014 Netguru Sp. z o.o. All rights reserved.
#

Pod::Spec.new do |s|

  s.name         = "ngrvalidator"
  s.version      = "0.1.0"
  s.summary      = "Simple validator for iOS."

  s.description  = "NGRValidator allows you to validate your data in way you want! It's easy to read (even via non-developers), centralized and complex solution to validate your model just in few lines of code!"

  s.homepage      = "https://github.com/netguru/ngrvalidator"
  s.license       = { :type => 'MIT', :file => 'LICENSE.md' }

  s.authors       = {'Patryk Kaczmarek' => 'patryk.kaczmarek@netguru.pl'}
  s.source        = { :git => 'https://github.com/netguru/ngrvalidator.git', :tag => s.version.to_s }

  s.platform      = :ios, '7.0'
  s.source_files  = 'NGRValidator/NGRValidator/**/*.{h,m}'
  s.requires_arc  = true

end
