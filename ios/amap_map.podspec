#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint amap_map.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'amap_map'
  s.version          = '1.0.3'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin for AMap.
                       DESC
  s.homepage         = 'https://github.com/kuloud/amap_map'
  s.license          = { :type => 'Apache License, Version 2.0', :file => '../LICENSE' }
  s.author           = { 'kuloud' => 'kuloud@outlook.com' }
  s.source           = { :git => 'https://github.com/kuloud/amap_map.git', :tag => 'v1.0.3' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AMap3DMap'
  s.static_framework = true
  s.platform = :ios, '12.0'

  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
