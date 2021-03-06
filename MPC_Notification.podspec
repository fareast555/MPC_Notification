Pod::Spec.new do |spec|
spec.name             = 'MPC_Notification'
spec.version          = '1.1.3'
spec.summary          = 'A highly customizable slide-down alert similar to a UILocalNotification.'
spec.description      = 'This CocoaPod allows you to display highly customizable in-app alerts. Alerts are dismissable with taps or pans.'

spec.homepage         = 'https://github.com/fareast555/MPC_Notification'
spec.license          = { :type => 'BSD', :file => 'license.txt' }
spec.author           = { 'Mike Critchley' => 'critchley55@yahoo.co.jp' }
spec.source           = { :git => 'https://github.com/fareast555/MPC_Notification.git', :tag => spec.version.to_s }


spec.ios.deployment_target = '10.0'
spec.requires_arc = true


spec.source_files = 'MPC_NotificationDemo/MPC_NotificationFiles/MPC_Notification.{h,m}'

spec.frameworks = 'UIKit'
end
