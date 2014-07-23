Pod::Spec.new do |s|
  s.name          = "CocoaHoedown"
  s.version       = "0.1.0"
  s.summary       = "Objective-C wrapper for hoedown, which renders HTML from Markdown."
  s.description   = <<-DESC
                    Objective-C wrapper for hoedown, which renders HTML from Markdown.
                    DESC
  s.homepage      = "https://github.com/js/CocoaHoedown"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Johan Sørensen" => "johan@johansorensen.com" }
  s.source        = { :git => "https://github.com/js/CocoaHoedown.git" }
  s.source_files  = "CocoaHoedown/*.{h,m}"
  s.exclude_files = "Vendor", "ExampleApp", "CocoaHoedown.xcodeproj", "CocoaHoedown.xcworkspace", "CocoaHoedownTests"
  s.requires_arc  = true

  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

  s.dependency "hoedown", "~> 2.0.0"
end
