#
#  Be sure to run `pod spec lint FloatyPanel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "FloatyPanel"
    s.version      = "0.0.1"
    s.summary      = "A short description of FloatyPanel."

    s.description  = <<-DESC
TODO: Add long description of the pod here.
                     DESC

    s.homepage         = 'https://github.com/Shayimpagne/FloatyPanel'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Emir Shayymov' => 'emchigg5@gmail.com' }
    s.source           = { :git => 'https://github.com/Shayimpagne/FloatyPanel.git', :tag => s.version.to_s }

    s.ios.deployment_target = '11.0'
    s.static_framework = true
    s.source_files = 'FloatyPanel/**/*'
    s.swift_version = '4.0'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC'
    }

end
