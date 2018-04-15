#MPC_Notification 
The MPC_Notification (Objective-C) displays slide down alerts similar to a UILocalNotification. The image is optional and is passed to the class when you instantiate it. The alert title and alert message text is customizable, as is the textColor, font, and backgroundColor. They will look something like these:

![Alert with image](https://github.com/fareast555/MPC_Notification/blob/master/alert_withImage.png)


![Alert with no image](https://github.com/fareast555/MPC_Notification/blob/master/alert_noImage.png)

To ensure that alerts do not cascade and cover each other up, the view will only return a view object if a notification is not already in the view hierarchy. As a result, do not attempt to stack notifications.

## Requirements

* iOS 9.0+
* ARC

## Installation

Download this repo and copy the MPC_Notification{.h/.m} files into your project, or

### [CocoaPods](https://cocoapods.org/)

```ruby
# For latest release, add this to your podfile
pod 'MPC_Notification', '~> 0.2.1'
```
 
<h3>To use:</h3>
 
  1. Import the .h file into your error handler class.
 
  2. Instantiate the view: 
  ```objectivec
   MPC_Notification *alert = [[MPC_Notification alloc]initWithTitle:message:alertImage:displayTime:];
```

  3. Customize public properties as required
  ```objectivec
  @property (strong, nonatomic) UIColor * _Nullable alertTitleColor;
  @property (strong, nonatomic) UIColor * _Nullable alertMessageColor;
  @property (strong, nonatomic) UIFont * _Nullable alertTitleFont;
  @property (strong, nonatomic) UIFont * _Nullable alertMessageFont;
  @property (strong, nonatomic) UIColor * _Nullable alertBackgroundColor;
```
 
  4. Display the alert view: 
  ```objectivec
    if (alert) [alert display];
```

 Do not add this alert to your own hierarchy. The alert will do everything for you.

  5. For a delegate callback on tap or pan gestures, subscribe to the delegate 
  ```objectivec
   <MPC_NotificationDelegate>
```

Set the delegate on the instantiated view: 
  ```objectivec
   myNotification.delegate = self
```

Then implement the delegate method 
  ```objectivec
   -(void)userDidTapMPC_NotificationView:
```
 
  **The display will auto dismiss after the display time is reached. Any UIGesture will also trigger a dismiss.
  
  **If you include an image asset, use either a 36 x 36 image (at 3 resolutions) or a single pdf vector image. 
 
<h3>Defaults:</h3>

  Pass nil as the image argument if you want only text.

  Pass nil as an alertTitle to display longer alert messages of up to two lines. This class will center the label accordingly for you.

<h3>Version Update History:</h3>
  ~> 0.2.0 Added a delegate callback when user taps notification (Pushed to CocoaPods 20 Sept 2017)

  ~> 0.2.1 Notifications now display correctly on iPhoneX, either flush with the top but showing below the notch in portrait, or regular height, but indented right if in landscape. Non-notched phone types are unaffected by this update. Enjoy! (Pushed to CocoaPods 16 April 2018)