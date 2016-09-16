 
The MPC_Notification is a drop-in class that will display slide down alerts similar to a UILocalNotification. The image is optional and is passed to the class when you instantiate it. The title and subtitle text are customizable, as is the textColor and backgroundColor. 

To ensure that alerts do not cascade and cover each other up, the view will only return a view object if a notification is not already in the view hierarchy.
 
<h3>To use:</h3>
 
  1. Locate and copy the MPC_Notification.h and .m files. in this repo (or from the downloaded / cloned repo) at: MPC_NotificationDemo > MPC_NotificationFiles
 
  2. Import the .h file into your error handler class.
 
  3. Instantiate the view: MPC_Notification *alert = [[MPC_Notification alloc]initWithTitle:message:alertImage:backgroundColor:textColor:];
 
  4. Display the alert view: if (alert) [alert display];
 
  **The display will auto dismiss after 4.0 seconds. Any UIGesture will also trigger a dismiss.
  
  **If you include an image asset, use either a 36 x 36 image (at 3 resolutions) or a single pdf vector image. 
 
<h3>Defaults:</h3>

  Pass nil as the image argument if you want only text.

  Pass nil for the background color if you want the default burgundy color

  Pass nil for the text color for white text
 
 **Don't forget to display the view after creating it. The view is added to the view hierarchy when instantiated and is not deallocated until after it has been displayed 
