//
//  ViewController.m
//  MPC_NotificationDemo
//
//  Created by Michael Critchley on 9/13/16.
//  Copyright © 2016 Michael Critchley. All rights reserved.
//

#import "ViewController.h"
#import "MPC_Notification.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)alertWithImage:(id)sender {
    
    //1. Create the notification
    MPC_Notification *imageAlert = [[MPC_Notification alloc]initWithTitle:@"Alert with an image!" message:@"No network connection" alertImage:[UIImage imageNamed:@"alertExclamation"] backgroundColor:nil textColor:nil];
    
    //2. Display alert
    [imageAlert display];
    
}


- (IBAction)alertNoImage:(id)sender {
    
    MPC_Notification *imageAlert = [[MPC_Notification alloc]initWithTitle:@"Alert with no image!" message:@"Error explanation etc here" alertImage:nil backgroundColor:nil textColor:nil];
    
    [imageAlert display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
