

Pod::Spec.new do |s|

 s.name         = "ZHLog"
 s.version      = "0.1"
 s.summary      = "Printing tools for iOS"
 s.homepage     = "https://github.com/zhuozhuo"
 s.license      = "MIT"
 s.license      = { :type => "MIT", :file => "LICENSE" }
 s.author             = { "Mr.jiang" => "414816566@qq.com" }
 s.platform     = :ios, "7.0"
 s.source       = { :git => "https://github.com/zhuozhuo/ZHLog.git", :tag => s.version }
 s.source_files  = "Classed/*.{h,m}"
 s.requires_arc = true

end
