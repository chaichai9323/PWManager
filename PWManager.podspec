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
    dir = 'PWManager'
  else
    dir = 'PWManager/PWManager'
  end
  
  s.subspec 'normal' do | normal |
    normal.source_files = "#{dir}/Classes/Normal/**/*", "#{dir}/Classes/*.swift"
  end
  
  s.subspec 'rc' do | rc |
    rc.source_files = "#{dir}/Classes/RC/**/*", "#{dir}/Classes/*.swift"
    rc.dependency 'IAPManager', '~> 11.0.19'
  end
  
  s.subspec 'u8enjsbh' do | view |
    arr = view.name.split('/')
    paywallid = arr[arr.count - 1]
    view.source_files = "#{dir}/Classes/Paywalls/*_#{paywallid}.swift"
    view.resource_bundles = {
      "#{s.name}_#{paywallid}" => ["#{dir}/Assets/#{paywallid}/*"]
    }
    view.dependency 'SnapKit'
  end
  s.subspec 'template' do | view |
    arr = view.name.split('/')
    paywallid = arr[arr.count - 1]
    view.source_files = "#{dir}/Classes/Paywalls/*_#{paywallid}.swift"
    view.resource_bundles = {
      "#{s.name}_#{paywallid}" => ["#{dir}/Assets/#{paywallid}/*"]
    }
    view.dependency 'SnapKit'
  end
  
  s.default_subspec = 'rc'
end
