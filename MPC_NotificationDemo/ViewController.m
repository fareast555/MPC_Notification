//
//  ViewController.m
//  MPC_NotificationDemo
//
//  Created by Michael Critchley on 9/13/16.
//  Copyright © 2016 Michael Critchley. All rights reserved.
//

#import "ViewController.h"
#import "MPC_Notification.h"

@interface ViewController ()<MPC_NotificationDelegate>

@end;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)alertWithImage:(id)sender {
    
    //1. Create the notification
    MPC_Notification *imageAlert = [[MPC_Notification alloc]initWithTitle:@"Alert with an awesome image"
                                                                  message:@"No network connection \nSecond line here"
                                                               alertImage:[UIImage imageNamed:@"alertExclamation"]
                                                              displayTime:2.0];
    
    //2. You can choose to set the delegate to receive a callback if the user taps the view
    imageAlert.delegate = self;
    
    //3. Display alert
    if (imageAlert) {
         [imageAlert display];
    }
}

#pragma mark - MPC_NotificationDelegate
- (void)userDidTapMPC_NotificationView:(MPC_Notification *)MPC_Notification
{
    NSLog(@"%s called", __FUNCTION__);
    //This would be the place to push or present another view if necessary.
}

- (IBAction)alertNoImage:(id)sender {
    
    MPC_Notification *imageAlert = [[MPC_Notification alloc]initWithTitle:@"Alert with no image!"
                                                                  message:@"Error explanation etc here \nSecond line here"
                                                               alertImage:nil
                                                              displayTime:2.0];
    
    //You can choose to set the delegate to receive a callback if the user taps the view
    imageAlert.delegate = self;
    
    if (imageAlert) {
        [imageAlert display];
    }
}


@end
