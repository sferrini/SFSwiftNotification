Pod::Spec.new do |s|
  s.name             = "SFSwiftNotification"
  s.version          = "0.0.3"
  s.summary          = "Simple custom user notifications (UIView subclass)"
  s.homepage         = "https://github.com/sferrini/SFSwiftNotification"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Simone Ferrini" => "sferrini@hotmail.it" }
  s.source           = { :git => "https://github.com/sferrini/SFSwiftNotification.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Simone_Ferrini'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes/*.swift'
end
