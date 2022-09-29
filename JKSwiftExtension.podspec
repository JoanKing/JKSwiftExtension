#
# Be sure to run `pod lib lint JKSwiftExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 项目名
  s.name             = 'JKSwiftExtension'
  # 版本号
  s.version          = '2.2.1'
  # 简单描述
  s.summary          = 'Swift版本的一个扩展'
  # 详细介绍
  s.description      = '这是Swift版本扩展的一个详细的使用，可以参考里面的用法'
  # 项目的getub地址，只支持HTTP和HTTPS地址，不支持ssh的地址
  s.homepage         = 'https://github.com/JoanKing/JKSwiftExtension'
  # listen文件的类型
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 作者和邮箱
  s.author           = { 'JoanKing' => 'jkironman@163.com' }
  # 多媒体介绍地址
  s.social_media_url   = "https://github.com/JoanKing"
  # git仓库的https地址
  s.source           = { :git => 'https://github.com/JoanKing/JKSwiftExtension.git', :tag => s.version.to_s }
  # 最低要求的系统版本
  s.ios.deployment_target = '9.0'
  # swift 支持的版本
  s.swift_version = '5.0'
  # 要求是ARC
  s.requires_arc = true
  # 表示源文件的路径，这个路径是相对podspec文件而言的。（这属性下面单独讨论）
  s.source_files = 'Sources/Classes/**/*'
  # 动态库所使用的资源文件存放位置，放在Resources文件夹中
  s.resource_bundles = {
      'JKSwiftExtension' => ['Sources/Assets/*.png']
  }

  # 在这个属性中声明过的.h文件能够使用<>方法联想调用（这个是可选属性）
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # 需要用到的frameworks，不需要加.frameworks后缀。（这个没有用到也可以不填）
  # s.frameworks = 'UIKit', 'MapKit'
  # 依赖关系，该项目所依赖的其他库
  # s.dependency 'Kingfisher'
  
end
