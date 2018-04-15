//
//  MPC_Notification.m

//  Created by Michael Critchley on 8/15/16.
// Copyright (c) 2017, Mike Critchley. All rights reserved.

//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#import "MPC_Notification.h"


@interface MPC_Notification ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (nonatomic, assign) CGFloat alertHeight;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat textXOffset;
@property (nonatomic, assign) CGFloat notchedPhoneYOffset;
@property (nonatomic, assign) CGFloat notchedPhoneXOffset;
@property (nonatomic, assign) CGFloat displayInterval;
@property (nonatomic, assign) BOOL viewWasDismissed;

@end

@implementation MPC_Notification

#pragma mark - Custom Init

-(instancetype) initWithTitle:(NSString *)alertTitle
                      message:(NSString *)alertMessage
                   alertImage:(UIImage * _Nullable)alertImage //@1x image should be 36px X 36px.
                  displayTime:(CGFloat) displayTime
{

    //1. Make sure another view with tag 595847 is not in the heirarchy
    UIView *view = [[[[UIApplication sharedApplication]delegate]window] viewWithTag:595847];
    if (view) {return nil;}
    
    //2. Call to super init
    if (self = [super initWithFrame:CGRectZero]) {
        
        //3. Initialize variables
        [self _configureiVarsWithImage:alertImage displayTime:displayTime];
        
        //4. Resize frame as required (to account for iPhoneX and notched devices)
        [self setFrame:[self _frameAfterReset]];
        
        //5. Build view
        self.backgroundColor = [UIColor colorWithRed:0.733 green:0.192 blue:0.357 alpha:1];
        
        if (alertImage) { [self addSubview:[self imageViewWithImage:alertImage]];}
        if (alertTitle) {[self addSubview:[self _title:alertTitle]]; }
        [self addSubview:[self _message:alertMessage]];
        [self addGestureRecognizer:[self tap]];
        [self addGestureRecognizer:[self pan]];
        [self setTag:595847];
        
        //6. Add the subview to the application window
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
    }

    return self;
}

#pragma mark - Initial Setup
- (void)_configureiVarsWithImage:(UIImage *)alertImage displayTime:(CGFloat)displayTime {
    //2. Set global variables.
    self.displayInterval = (displayTime == 0) ? 4 : displayTime;
    self.alertHeight = 64;
    self.viewWidth = [UIScreen mainScreen].bounds.size.width;
    self.textXOffset = alertImage ? 64 : 15; //Slides text to left if no image
    self.viewWasDismissed = NO; //Flag set when dismiss is called
    self.notchedPhoneYOffset = 0;
}
- (CGRect)_frameAfterReset {
    
    //Adjust for iPhoneX
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets i = [[[UIApplication sharedApplication]delegate]window].safeAreaInsets;
        //Only need to adjust if in portrait on iPhoneX (landscape is 0 offest)
        if (i.top > 0 || i.right > 0) {
            
            _notchedPhoneYOffset = i.top > 0 ? 24 : 0;
            _notchedPhoneXOffset = i.left > 0 ? 24 : 0;
            _alertHeight += _notchedPhoneYOffset;
        }
    }
    return  CGRectMake(0, -(self.alertHeight), self.viewWidth, self.alertHeight);
}

#pragma mark - Setters for public properties

- (void)setAlertTitleColor:(UIColor *)alertTitleColor
{
    _alertTitleColor = alertTitleColor;
    if (!self.titleLabel) {return;}
    self.titleLabel.textColor = alertTitleColor;
}

- (void)setAlertTitleFont:(UIFont *)alertTitleFont
{
    _alertTitleFont = alertTitleFont;
    if (!self.titleLabel) {return;}
    self.titleLabel.font = alertTitleFont;
}

- (void)setAlertMessageColor:(UIColor *)alertMessageColor
{
    _alertMessageColor = alertMessageColor;
    self.messageLabel.textColor = alertMessageColor;
}

- (void)setAlertMessageFont:(UIFont *)alertMessageFont
{
    _alertMessageFont = alertMessageFont;
    self.messageLabel.font = alertMessageFont;
}

- (void)setAlertBackgroundColor:(UIColor *)alertBackgroundColor
{
    _alertBackgroundColor = alertBackgroundColor;
    self.backgroundColor = alertBackgroundColor;
}

#pragma mark - Images, views, and gestures

- (UIImageView *) imageViewWithImage:(UIImage *)alertImage
{
    CGRect viewRect = CGRectMake(15 + self.notchedPhoneXOffset, 14 + self.notchedPhoneYOffset, 36, 36);
    UIImageView *view = [[UIImageView alloc]initWithFrame:viewRect];
    [view setImage:alertImage];
    return view;
}

- (UILabel *)_title:(NSString *)alertTitle
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textXOffset + self.notchedPhoneXOffset, 14 + self.notchedPhoneYOffset, self.frame.size.width-(self.textXOffset + self.notchedPhoneXOffset + 10), 20)];
    [self.titleLabel setText: alertTitle];
    [self.titleLabel setTextColor: [UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:self.viewWidth > 321 ? 15.5 : 13]];
    return self.titleLabel;
}


- (UILabel *)_message:(NSString *)alertMessage
{
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textXOffset  + self.notchedPhoneXOffset, 32 + self.notchedPhoneYOffset, self.frame.size.width-(self.textXOffset + self.notchedPhoneXOffset + 10), 20)];
    self.messageLabel.numberOfLines = self.titleLabel ? 1 : 2;
    [self.messageLabel setText:alertMessage];
    [self.messageLabel setTextColor:[UIColor whiteColor]];
    [self.messageLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:self.viewWidth > 321 ? 13.5 : 11.5]];
    if (!self.titleLabel) {
        [self _verticallyCenterLabel:self.messageLabel];
    }
    return self.messageLabel;
}

- (UILabel *)_verticallyCenterLabel:(UILabel *)messageLabel
{
    //1. Get the x origin
    CGFloat x = messageLabel.frame.origin.x;
    
    //2. Resize the frame to fit (does not affect x origin)
    [messageLabel sizeToFit];
    
    //3. Set the new centered frame
    [messageLabel setFrame:CGRectMake(x, ((self.alertHeight) - messageLabel.frame.size.height) / 2, messageLabel.frame.size.width, messageLabel.frame.size.height + self.notchedPhoneYOffset)];
    
    return messageLabel;
}

- (UITapGestureRecognizer *)tap
{
    return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_userGestureDetected:)];
}

- (UIPanGestureRecognizer *)pan
{
    return [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_userGestureDetected:)];
}

#pragma mark - Informing delegate of user action
- (void)_userGestureDetected:(UIGestureRecognizer *)gesture
{
    //1. Limit pan gesture recognition to initial gesture state
    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]] && gesture.state != UIGestureRecognizerStateBegan)
        return;
    
    //2. Update delegate on main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate userDidTapMPC_NotificationView:self];
        
        //3. Call to dismiss self, passing the gesture recognizer
        [self _dismissView:gesture];
    });
    
}

#pragma mark - Display and Dismiss notification view

- (void)display
{
    //1. Move the status bar below the view
    [self _statusBarToBottom];
    
    //2. Slide down the alert
    [UIView animateWithDuration:0.5 animations:^{
       
        CGRect shiftFrame = self.frame;
        shiftFrame.origin.y +=self.alertHeight;
        self.frame = shiftFrame;
    }];
    
    //3. Call dismiss timer
    [self _timedDismiss];
}

- (void)_timedDismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.displayInterval * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self _dismissView:nil];
    });
}

- (void)_dismissView:(id)gesture
{
    
    //1. Return if dismissed has been called
    if (self.viewWasDismissed) {
        return;
    } else self.viewWasDismissed = YES;
    
    
    //2. Get main queue for UI update
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //3. Slide up the view and call for cleanup
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect shiftFrame = self.frame;
            shiftFrame.origin.y -=self.alertHeight;
            self.frame = shiftFrame;
            
        } completion:^(BOOL finished) {
            [self _cleanUp];
        }];
    });
    
    //4. Make status bar visible near the end of the animation
    [self performSelector:@selector(_statusBarToTop) withObject:nil afterDelay:0.3];
    
}

- (void)_cleanUp
{
    [self removeFromSuperview];
}

- (void)_statusBarToBottom
{
    [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar+1];
}

- (void)_statusBarToTop
{
    [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelNormal];
}

@end
