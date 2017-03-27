#
#  Podfile
#

# Pod sources
source 'https://github.com/CocoaPods/Specs.git'

# Initial configuration

inhibit_all_warnings!

def testing_pods
    pod 'Expecta', '1.0.5'
    pod 'Specta',  '1.0.5'
end

target 'NGRValidatorTests-iOS' do
    platform :ios, '7.0'
    testing_pods
end

target 'NGRValidatorTests-MacOS' do
    platform :osx, '10.10'
    testing_pods
end
