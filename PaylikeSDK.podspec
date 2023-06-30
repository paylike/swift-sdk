Pod::Spec.new do |s|
  s.name             = 'PaylikeSDK'
  s.swift_version    = '5.0'
  s.ios.deployment_target = '13.0'
  s.version          = '0.1.0'
  s.summary          = 'This library includes the high level components providing complete payment forms to use the Paylike ecosystem.'
  s.description      = <<-DESC
  This library includes the high level components providing complete payment forms to use the Paylike ecosystem.
                        DESC

  s.homepage         = 'https://github.com/paylike/swift-sdk'
  s.license          = { :type => 'BSD-3', :file => 'LICENSE' }
  s.author           = { 'Paylike.io' => 'info@paylike.io' }
  s.source           = {
      :git => 'https://github.com/paylike/swift-sdk.git',
      :tag => s.version.to_s
  }
  s.source_files = 'Sources/PaylikeSDK/**/*'
  s.resource_bundles = {
    'PaylikeSDK' => ['Sources/PaylikeSDK/Resources/**']
  }
  s.dependency 'PaylikeEngine'
end
