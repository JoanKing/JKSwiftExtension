#
# Be sure to run `pod lib lint JKSwiftExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKSwiftExtension'
  s.version          = '0.2.4'
  s.summary          = 'Swift版本的一个扩展'
  s.description      = '这是Swift版本扩展的一个详细的使用，可以参考里面的用法'

  s.homepage         = 'https://github.com/JoanKing/JKSwiftExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JoanKing' => 'jkironman@163.com' }
  s.source           = { :git => 'https://github.com/JoanKing/JKSwiftExtension.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'JKSwiftExtension/Classes/**/*'
  # swift 支持的版本
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'JKSwiftExtension' => ['JKSwiftExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
  
end
