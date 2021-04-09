Pod::Spec.new do |s|

  s.name             = "NDLoading"
  s.version          = "1.0.0-rc-1"
  s.summary          = "Loading for iOS"
  
  s.homepage         = "https://github.com/dhnghia22/NDLoading"
  s.license          = 'MIT'
  s.author           = { "Nghia Dinh" => "dhnghia22@gmail.com" }
  s.source           = { :git => "https://github.com/dhnghia22/NDLoading.git", :tag => s.version.to_s }

  s.platform     = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version = "5.0" 
  s.source_files = 'NDLoading/Source/*.swift', 'NDLoading/Source/Loading/*.swift', 'NDLoading/Source/LoadingContentView/*.swift'
  s.resources    =  ['NDLoading/Source/NDHUD.bundle']

end
