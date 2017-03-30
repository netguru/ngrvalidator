#
#  Podfile
#

# Pod sources
source 'https://github.com/CocoaPods/Specs.git'

# Initial configuration
use_frameworks!
inhibit_all_warnings!

def testing_pods
    pod 'Expecta', '1.0.5'
    pod 'Specta',  '1.0.5'
    pod 'Quick', '1.1.0'
    pod 'Nimble', '6.1.0'
end

target 'NGRValidatorTests-iOS' do
    platform :ios, '9.0'
    testing_pods
end

target 'NGRValidatorTests-MacOS' do
    platform :osx, '10.11.4'
    testing_pods
end
