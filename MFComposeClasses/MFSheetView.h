//
//  MFSheetView.h
//  MFComposeViewController
//
//  Created by Mohamad Farhand on 10/11/15.
//  Copyright © 2015 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MFComposeSheetViewDelegate;

@interface MFSheetView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *rightButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *leftButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *backgroungView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) id<MFComposeSheetViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *naigationBarView;


- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@protocol MFComposeSheetViewDelegate <NSObject>

- (void)cancelButtonPressed;
- (void)DoneButtonPressed;

@end
