//
//  MPC_Notification.m

//  Created by Michael Critchley on 8/15/16.
//  Copyright © 2016 Michael Critchley. All rights reserved.
//  Free to use, share, tweak and twist. 

#import "MPC_Notification.h"

@interface MPC_Notification ()

@property (strong, nonatomic) UIImage *alertImage;
@property (strong, nonatomic) UIColor *textColor;
@property (nonatomic, assign) CGFloat alertHeight;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat textXOffset;
@property (nonatomic, assign) BOOL viewWasDismissed;

@end

@implementation MPC_Notification

#pragma mark - Custom Init

-(instancetype) initWithTitle:(NSString *)alertTitle
                      message:(NSString *)alertMessage
                   alertImage:(UIImage *)alertImage
              backgroundColor:(UIColor *)backgroundColor
                    textColor:(UIColor *)textColor
{

    //1. Make sure another view is not in the heirarchy
    UIView *view = [[[[UIApplication sharedApplication]delegate]window] viewWithTag:5];
    if (view) {
        return nil;
    }
    
    //2. Set global variables.
    self.alertImage = alertImage ? alertImage : nil;
    self.textColor = textColor ? textColor : [UIColor whiteColor];
    self.alertHeight = 64;
    self.viewWidth = [UIScreen mainScreen].bounds.size.width;
    self.textXOffset = self.alertImage ? 64 : 15; //Slides text to left if no image
    self.viewWasDismissed = NO; //Flag set when dismiss is called
    
    //3. Call to super using main window width
    if (self = [super initWithFrame:CGRectMake(0, -self.alertHeight, self.viewWidth, self.alertHeight)])
    {
        //4. Build view
        self.backgroundColor = backgroundColor ? backgroundColor : [UIColor colorWithRed:0.733 green:0.192 blue:0.357 alpha:1];
        
        if (self.alertImage) {
            [self addSubview:[self imageView]];
        }
        
        [self addSubview:[self title:alertTitle]];
        [self addSubview:[self message:alertMessage]];
        [self addGestureRecognizer:[self tap]];
        [self addGestureRecognizer:[self pan]];
        [self setTag:5];
        
        //5. Add the subview to the application window
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        
    }
    
    return self;
}


#pragma mark - Images, views, and gestures

- (UIImageView *) imageView
{
    CGRect viewRect = CGRectMake(15, 14, 36, 36);
    UIImageView *view = [[UIImageView alloc]initWithFrame:viewRect];
    [view setImage:self.alertImage];
    return view;
}

- (UILabel *)title:(NSString *)alertTitle
{
    UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textXOffset, 14, self.frame.size.width-(self.textXOffset + 10), 20)];
    [alertLabel setText: alertTitle];
    [alertLabel setTextColor: self.textColor];
    UIFont *bold = [UIFont fontWithName:@"Avenir-Heavy" size:self.viewWidth > 321 ? 15.5 : 13];
    [alertLabel setFont:bold];
    return alertLabel;
}

- (UILabel *)message:(NSString *)alertMessage
{
    UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textXOffset, 32, self.frame.size.width-(self.textXOffset + 10), 20)];
    [alertLabel setText:alertMessage];
    [alertLabel setTextColor:self.textColor];
    UIFont *light = [UIFont fontWithName:@"Avenir-Light" size:self.viewWidth > 321 ? 13.5 : 11.5];
    [alertLabel setFont: light];
    return alertLabel;
}

- (UITapGestureRecognizer *)tap
{
    return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_dismissView:)];
}

- (UIPanGestureRecognizer *)pan
{
    return [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_dismissView:)];
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
    float time = 4.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
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
    self.alertImage = nil;
    self.textColor = nil;
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
