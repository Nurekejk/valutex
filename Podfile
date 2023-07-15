platform :ios, '10.0'

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

  post_install do |installer|
      installer.generated_projects.each do |project|
        project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
          end
        end
      end
    end
end
