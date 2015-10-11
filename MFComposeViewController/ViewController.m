//
//  ViewController.m
//  MFComposeViewController
//
//  Created by Mohamad Farhand on 10/11/15.
//  Copyright © 2015 ideveloper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    UIColor *myFaveColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    self.view.backgroundColor = myFaveColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hanleTap:(UIGestureRecognizer*)gest
{
    [self addCaption];
}

#pragma mark Caption

-(void)addCaption
{
    MFComposeViewController * composeViewController = [[MFComposeViewController alloc]initWithNibName:@"MFComposeViewController" bundle:[NSBundle mainBundle]];
    composeViewController.delegate = self;
    composeViewController.textOfTextView = @"some string";
    [self.view addSubview:composeViewController.view];
//    [self.navigationController.view addSubview:composeViewController.view]; // if you have navigation Controller
    
}


-(void)rightButtonPressed:(MFComposeViewController *)vc
{
    NSLog(@"\n Text : %@",vc.sheetView.textView.text);
    [vc.view removeFromSuperview];
    
}
-(void)leftButtonPressed:(MFComposeViewController *)vc

{
    [vc dismiss];
}


@end
