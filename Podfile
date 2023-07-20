platform :ios, '14.0'

target 'kurs.kz' do
  use_frameworks!
  pod 'SkyFloatingLabelTextField'
  pod 'CHIOTPField'

  # individual page control
  pod 'CHIOTPField/One'
  pod 'CHIOTPField/Two'
  pod 'CHIOTPField/Three'
  pod 'CHIOTPField/Four'
  pod 'SwiftLint'
  pod 'GoogleMaps', '8.0.0'
  

  post_install do |installer|
      installer.generated_projects.each do |project|
        project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
          end
        end
      end
    end
end
