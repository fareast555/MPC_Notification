//
//  MPC_Notification.h

//  Created by Michael Critchley on 8/15/16.
//  Copyright (c) 2017, Mike Critchley. All rights reserved.

//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


/***********

 The MPC_Notification will display slide down alerts similar to a UILocalNotification. The image is optional and is passed to the class when you instantiate it. The title and subtitle text are customizable, as is the textColor and backgroundColor.
 
 To show your alert, call [myMPCNotification display]. Do not set your instance of MPC_Notification to your hierarchy directly.

 If you include an image asset, use either a 36 x 36 image (including 2x and 3x resolutions) or a single pdf vector image.

***********/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPC_Notification : UIView

/**
 Set properties after creating an instance of MPC_Notification in the calling controller.
 */
@property (strong, nonatomic) UIColor * _Nullable alertTitleColor;
@property (strong, nonatomic) UIColor * _Nullable alertMessageColor;
@property (strong, nonatomic) UIFont * _Nullable alertTitleFont;
@property (strong, nonatomic) UIFont * _Nullable alertMessageFont;
@property (strong, nonatomic) UIColor * _Nullable alertBackgroundColor;

/**
 Set alertTitle to nil to allow for 2-line messages.
 */
-(instancetype) initWithTitle:(NSString * _Nullable)alertTitle
                      message:(NSString *)alertMessage
                   alertImage:(UIImage * _Nullable)alertImage //@1x image should be 36px X 36px.
                  displayTime:(CGFloat) displayTime;
/**
 Display the alert view. The display will auto dismiss after "displayTime" seconds has passed. Any user-initiated UIGesture will also dismiss the alert.
 */
- (void) display;

@end

NS_ASSUME_NONNULL_END
