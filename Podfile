platform :ios, '8.0'
use_frameworks!

target 'Connect' do
  pod 'MonkeyKitUI', :path => '~/Workspace/Monkey-UI-iOS'
  pod 'RealmSwift', '~> 1.1.0'
  pod 'SDWebImage', '~> 3.8.1'
  pod 'Whisper', :git => 'https://github.com/hyperoslo/Whisper.git'
  pod 'MonkeyKit', :path => '~/Workspace/Monkey-SDK-iOS’
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
