Pod::Spec.new do |s|
  s.name         = 'FincodeSDK'
  s.version      = '0.0.1'
  s.summary      = 'test'
  s.homepage     = 'http://test.com'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = 'test'

  s.platforms    = { :ios => '4.0' }
  #s.ios.deployment_target = '4.0'
  s.source       = { :git => 'https://okuyama-GMOPG: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@github.com/okuyama-GMOPG/reactnative-test.git', :tag => '#{s.version}' }

  s.vendored_frameworks   = ['Output/FincodeSDK/FincodeSDK.xcframework']
  #s.ios.vendored_frameworks = ['Output/FincodeSDK/FincodeSDK.xcframework']

  #s.frameworks = 'WebKit'

  #s.source_files = '*'
  # 'ios/**/*.{h,m,mm,swift}'
  
  #s.dependency 'Alamofire'

end
