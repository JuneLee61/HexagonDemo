source 'ssh://git@oa.yolanda.hk:22022/ios/QNSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'HexagonDemo' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for HexagonDemo

#pod 'Reveal-SDK', '~> 10'
pod 'QNModuleGroup', '0.3.9.bate.2',:subspecs => ['Fitbit']
pod 'Firebase/Messaging'
pod 'Firebase/Analytics'
pod 'Firebase/Crashlytics'

pod 'ReactiveObjC', '~> 3.1.0'
pod 'PromisesObjC'

  target 'HexagonDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HexagonDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
