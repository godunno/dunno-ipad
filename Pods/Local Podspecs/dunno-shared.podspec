Pod::Spec.new do |s|
  s.name         = "dunno-shared"
  s.version      = "1.3"
  s.summary      = 'Common classes to iPad and iPhone module'
  s.homepage     = "https://github.com/godunno/dunno-shared"
  s.license      = 'MIT'
  s.author       = { 'Fagner Moura' => 'fagnermoura@gmail.com' }
  

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files  = 'dunno-shared', 'dunno-shared/**/*.{h,m}'
  s.public_header_files = 'dunno-shared/**/*.h'

  s.dependency 'JSONModel'
  s.dependency 'libPusher'
  s.dependency 'Reachability'

end
