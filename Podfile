platform :ios, '8.0'
use_frameworks!

target 'Connect' do
  pod 'MonkeyKitUI', :git => 'https://github.com/Criptext/Monkey-UI-iOS.git', :branch => '7.4.1'
  pod 'RealmSwift'
  pod 'SDWebImage', '~> 3.8.1'
  pod 'Whisper', :git => 'https://github.com/hyperoslo/Whisper.git'
  pod 'MonkeyKit', :path => '~/Documents/Git/talktolk-iOS-SDK'
  pod 'Material', '~> 2.0'
  pod 'Alamofire', '~> 4.4'
  pod 'Unbox'
  pod 'SwiftSpinner'
  pod 'lottie-ios'
  pod 'Fabric'
  pod 'Crashlytics'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
