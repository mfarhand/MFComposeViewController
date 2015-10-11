//
//  MFSheetView.m
//  MFComposeViewController
//
//  Created by Mohamad Farhand on 10/11/15.
//  Copyright © 2015 ideveloper. All rights reserved.
//

#import "MFSheetView.h"

@implementation MFSheetView
@synthesize delegate,textView;


- (void)drawRect:(CGRect)rect {
    [self.containerView setClipsToBounds:YES];
    [[self.containerView layer]setCornerRadius:6];
    [self.naigationBarView setBackgroundColor:[UIColor redColor]];
}



- (void)cancelButtonPressed
{
    id<MFComposeSheetViewDelegate> localDelegate = self.delegate;
    if ([localDelegate respondsToSelector:@selector(cancelButtonPressed)])
        [localDelegate cancelButtonPressed];
}

- (void)postButtonPressed
{
    id<MFComposeSheetViewDelegate> localDelegate = self.delegate;
    if ([localDelegate respondsToSelector:@selector(DoneButtonPressed)])
        [localDelegate DoneButtonPressed];
}

- (IBAction)cancelAction:(id)sender {
    [self cancelButtonPressed];
}

- (IBAction)doneAction:(id)sender {
    [self postButtonPressed];
}

@end
