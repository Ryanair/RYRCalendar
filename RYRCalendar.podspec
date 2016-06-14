#
# Be sure to run `pod lib lint RYRCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'RYRCalendar'
s.version          = '0.1.0'
s.summary          = 'Light and simple calendar for your app written in Swift 2.2'
s.homepage         = 'https://github.com/Ryanair/RYRCalendar'
s.screenshots      = 'https://github.com/Ryanair/RYRCalendar/raw/master/Images/ryrcalendar_multiple_selection.png', 'https://github.com/Ryanair/RYRCalendar/raw/master/Images/ryrcalendar_single_selection.png'
s.license          = { :type => 'Apache', :file => 'LICENSE' }
s.author           = { 'Miquel, Aram' => 'miquela@ryanair.com' }
s.source           = { :git => 'https://github.com/Ryanair/RYRCalendar.git', :branch => 'master' }
s.ios.deployment_target = '8.0'
s.source_files     = 'RYRCalendar/Classes/**/*'
s.resource_bundle  = { 'RYRCalendar' => 'RYRCalendar/Assets/*' }
s.frameworks       = 'UIKit'
end
