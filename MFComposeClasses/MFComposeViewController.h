//
//  MFComposeViewController.h
//  MFCompose
//
//  Created by Mohamad Farhand on 9/29/15.
//  Copyright © 2015 ideveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSheetView.h"
#import <QuartzCore/QuartzCore.h>

@class MFComposeViewController;
@protocol MFComposeViewControllerDelegate <NSObject>
-(void)leftButtonPressed:(MFComposeViewController*)vc;
-(void)rightButtonPressed:(MFComposeViewController*)vc;
@end


@class MFComposeViewController;
@interface MFComposeViewController : UIViewController<UITextViewDelegate,MFComposeSheetViewDelegate>

@property (strong, nonatomic) IBOutlet MFSheetView *sheetView;
@property (strong ,nonatomic) NSString * textOfTextView;
@property (weak, readwrite, nonatomic) id<MFComposeViewControllerDelegate> delegate;

-(void)dismiss;


@end

