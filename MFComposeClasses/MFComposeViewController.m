//
//  MFComposeViewController.m
//  MFCompose
//
//  Created by Mohamad Farhand on 9/29/15.
//  Copyright © 2015 ideveloper. All rights reserved.
//

#import "MFComposeViewController.h"
#define MAX_LENGTH 140 // Whatever your limit is
#define SCREEN_WIDTH (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.height)
#define IOS_VERSION_LOWER_THAN_8 (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)

@interface MFComposeViewController ()

@end

@implementation MFComposeViewController
@synthesize delegate,textOfTextView;

//-(instancetype)init
//{
//    self = [super initWithNibName:@"MFComposeViewController" bundle:nil];
//    if (self) {
//     //self.textView.text = @"";
//    }
//    return self;
//    
//}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect tempFrame = self.sheetView.frame;
    int width  = SCREEN_WIDTH;
    int height = SCREEN_HEIGHT;
    tempFrame.size.width = width;
    tempFrame.size.height = height;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <8.0 && UIDeviceOrientationIsLandscape([[UIDevice currentDevice]orientation])) {
        tempFrame.size.width = [UIScreen mainScreen].bounds.size.height;
        tempFrame.size.height = [UIScreen mainScreen].bounds.size.width;
        
    }
    [self.sheetView setFrame:tempFrame];
    
    if ([[[UIDevice currentDevice]systemName]floatValue] <8.0)
    {
        self.sheetView.topConstraint.constant = 35;
        [self.view updateConstraints];
    }
    [self.sheetView setDelegate:self];
    [self.sheetView.textView setDelegate:self];
    [self.sheetView.textView setText:self.textOfTextView];
    [self.sheetView.leftButtonItem setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.sheetView.rightButtonItem setTitle:@"Done" forState:UIControlStateNormal];
    self.sheetView.textView.returnKeyType = UIReturnKeyDone;
    [self.sheetView.textView becomeFirstResponder];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    [self.sheetView.backgroungView setBackgroundColor:[UIColor grayColor]];
    [self.sheetView.backgroungView setAlpha:0.9];
    [self showAnimated:YES withCompletion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.delegate rightButtonPressed:self];
        return NO;
    }
    
    text = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSString *newText = [ textView.text stringByReplacingCharactersInRange: range withString:text];
    if( [newText length]<= MAX_LENGTH ){
        textView.text = newText;
        return NO;
    }
    // case where text length > MAX_LENGTH
    textView.text = [ newText substringToIndex: MAX_LENGTH ];
    return NO;
    
}


-(void)DoneButtonPressed
{
    [self.delegate rightButtonPressed:self];

}
-(void)cancelButtonPressed
{
    [self.delegate leftButtonPressed:self];

}

-(void)hanleTap:(UIGestureRecognizer*)gest
{
    [self.delegate rightButtonPressed:self];
}


- (void)showAnimated:(BOOL)animated withCompletion:(void (^)(void))completion {
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.20, 1.20, 1.00)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.00)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.00, 1.00, 1.00)]];
    transformAnimation.keyTimes = @[@0.0, @0.5, @1.0];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.5;
    opacityAnimation.toValue = @1.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[transformAnimation, opacityAnimation, opacityAnimation];
    animationGroup.duration = 0.2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    [self.sheetView.layer addAnimation:animationGroup forKey:@"showAlert"];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationGroup.duration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        if (completion) {
            completion();
        }
    });
}


-(void)dismiss
{
    [self.view removeFromSuperview];
}


@end
