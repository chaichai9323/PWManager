#
# Be sure to run `pod lib lint PWManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PWManager'
  s.version          = '12.0.0'
  s.summary          = 'A short description of PWManager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chaichai9323/PWManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chaichai9323' => 'chailintao@laien.io' }
  s.source           = { :git => 'https://github.com/retro-labs/optional-ios-swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.static_framework = true
  s.ios.deployment_target = '13.0'

  dir = ''
  if ENV['PWManager_LocalPath'] == 'true'
    dir = 'PWManager/Classes'
  else
    dir = 'PWManager/PWManager/Classes'
  end
  
  s.source_files = "#{dir}/*.swift"
  
  s.subspec 'normal' do | normal |
    normal.source_files = "#{dir}/Normal/**/*", "#{dir}/*.swift"
  end
  
  s.subspec 'rc' do | rc |
    rc.source_files = "#{dir}/RC/**/*"
    rc.dependency 'IAPManager', '~> 11.0.18'
  end
  
  s.default_subspec = 'rc'
  # s.resource_bundles = {
  #   'PWManager' => ['PWManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
