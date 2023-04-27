#
# Be sure to run `pod lib lint PWManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PWManager'
  s.version          = '16.0.0'
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
  
  s.subspec "normal" do | normal |
    normal.source_files = "#{dir}/Classes/Normal/**/*", "#{dir}/Classes/*.swift", "#{dir}/Classes/UIComponents/*.swift"
  end
  
  s.subspec "rc" do | rc |
    rc.source_files = "#{dir}/Classes/RC/**/*", "#{dir}/Classes/*.swift", "#{dir}/Classes/UIComponents/*.swift"
    rc.dependency 'IAPManager', '~> 11.0.19'
  end
  
  s.subspec "template" do | view |
    arr = view.name.split("/")
    paywallid = arr[arr.count - 1]
    view.source_files = "#{dir}/Classes/Paywalls/template/*_#{paywallid}.swift"
    view.resource_bundles = {
      "#{s.name}_#{paywallid}" => ["#{dir}/Assets/#{paywallid}/*"]
    }
    view.dependency "SnapKit"
    view.dependency "Components", "~> 0.1.0"
  end
  
  Dir.entries("#{dir}/Assets").each do | proj |
    if proj =~ /\A\w/ and proj != "template"
      Dir.entries("#{dir}/Assets/#{proj}").each do | paywall |
        cls = "PWManager.#{proj}_#{paywall}"
        content = "import Foundation\nextension #{cls}: PWManagerImageProtocol {\n\tvar R: Resources<#{cls}> {\n\t\treturn Resources<#{cls}>(bundle: Self.resBundle, language: dataModel.language, font: dataModel.fontConfig)\n\t}\n\tpublic struct Image: PWManagerImageDataType {\n\t\tstatic var bundle: PWManager.PaywallView.Type = #{cls}.self\n"
        if paywall =~ /\A\w/
          Dir.glob("#{dir}/Assets/#{proj}/#{paywall}/Assets.xcassets/**/*.imageset").each do | astname |
            imagename = File.basename(astname, ".imageset")
            content += "\t\tstatic var #{imagename}: UIImage? { UIImage(named: #function, in: Self.bundle.resBundle, compatibleWith: nil) }\n"
          end
          content += "\t}\n}\n"
          File.open("./#{dir}/Classes/Paywalls/#{proj}/#{paywall}/#{proj}_#{paywall}+Resource.swift", "w+") do |f| f.syswrite(content) end
        end
      end
    end
  end
  
  Dir.entries("#{dir}/Assets").each do | folder |
    if folder =~ /\A\w/ and folder != "template"
      s.subspec folder do | proj |
        subdir = proj.name.split("/")[1]
        Dir.entries("#{dir}/Assets/#{subdir}").each do | dirname |
          if dirname =~ /\A\w/
            proj.subspec dirname do | view |
              tmparr = view.name.split("/")
              paywallid = tmparr[tmparr.count - 1]
              view.source_files = "#{dir}/Classes/Paywalls/#{subdir}/#{paywallid}/*.swift"
              view.resource_bundles = {
                "#{s.name}_#{subdir}_#{paywallid}" => ["#{dir}/Assets/#{subdir}/#{paywallid}/*"]
              }
              view.dependency "SnapKit"
              view.dependency "Components", "~> 0.1.0"
            end
          end
        end
      end
    end
  end
  s.default_subspec = "rc"
end
