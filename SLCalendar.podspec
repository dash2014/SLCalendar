Pod::Spec.new do |s|
s.name     = 'SLCalendar'
s.version  = '1.0'
s.license  = 'BSD'
s.summary  = 'An open source for Calendar'
s.homepage = 'https://github.com/dash2014/SLCalendar'
s.author   = { 'selector' => 'dash007@163.com' }
s.source   = { :git => 'https://github.com/dash2014/SLCalendar.git', :tag => "#{s.version}" }

s.source_files = 'SLCalendar/**/*.{h,m}'
s.resources = 'SLCalendar/**/*.xib'
s.requires_arc = true
s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }

s.ios.deployment_target = '8.0'

end
