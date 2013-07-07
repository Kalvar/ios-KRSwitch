//
//  ViewController.m
//  KRSwitchDemo
//
//  ilovekalvar@gmail.com
//
//  Created by Kuo-Ming Lin on 2012/11/01.
//  Copyright (c) 2012年 Kuo-Ming Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRSwitchTurns.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)_change:(id)sender
{
    NSLog(@"switch changed !");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    for( int i = 1; i<= 20; ++i )
    {
        KRSwitchTurns *krSwitchTurns = [[KRSwitchTurns alloc] initWithFrame:CGRectMake(72, 20 * i, 75, 26)];
        //[krSwitchTurns setOnText:@"ON" offText:@"OFF"];
        [krSwitchTurns setOnImageName:@"switch_bar_handle_on.png" offImageName:@"switch_bar_handle_off.png"];
        [krSwitchTurns setBackgroundImageName:@"switch_bar_bg.png"];
        [krSwitchTurns setHoverImageName:@"switch_bar_handle_1.png"];
        [krSwitchTurns setHandleImageName:@"switch_bar_handle.png"];
        [krSwitchTurns setHandleButtonWidth:56.0f handleButtonHeight:25.0f];
        [krSwitchTurns runGeneral];
        //要先設定 ON / OFF
        [krSwitchTurns setOn:YES];
        //再設定 Target / Method，才不會一開始就因為值有改變，而重複執行了這裡的函式
        [krSwitchTurns addTarget:self action:@selector(_change:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:krSwitchTurns];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
