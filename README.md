 

 To use: 
  1. Import the .h file into your error handler class.
 
  2. Instantiate the view: MPC_Notification *alert = [[MPC_Notification alloc]initWithTitle:message:alertImage:backgroundColor:textColor:];
 
  3. Display the alert view: [alert display];
 
  The display will auto dismiss after 4.0 seconds. Any UIGesture will also trigger a dismiss.
  
  If you include an image asset, use either a 36 x 36 image (at 3 resolutions) or a single pdf vector image. 
 
  Defaults:
  Pass nil as the image argument if you want only text.
  Pass nil for the background color if you want the default burgundy color
  Pass nil for the text color for white text
 
 **Don't forget to display the view after creating it. The view is added to the view hierarchy when instantiated and is not deallocated until after it has been displayed 