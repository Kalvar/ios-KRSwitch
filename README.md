## Screen Shot

<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRSwitch-1.png" alt="KRSwitch" title="KRSwitch" style="margin: 20px;" class="center" />

## Supports

KRSwitch supports MRC ( Manual Reference Counting ), if you did want it support to ARC, that just use Xode tool to auto convert to ARC. ( Xcode > Edit > Refactor > Convert to Objective-C ARC )

## How To Get Started

KRSwitch can customize the UISwitch. 

``` objective-c
-(void)_change:(id)sender{
    NSLog(@"Switch Changed !");
}

- (void)viewDidLoad
{
	KRSwitchTurns *krSwitchTurns = [[KRSwitchTurns alloc] initWithFrame:CGRectMake(72, 20, 75, 26)];
	[krSwitchTurns setOnText:@"ON" offText:@"OFF"];
	[krSwitchTurns setOnImageName:@"btn_switchBar_handle_on.png" offImageName:@"btn_switchBar_handle_off.png"];
	[krSwitchTurns setBackgroundImageName:@"btn_switchBar_bg.png"];
	[krSwitchTurns setHoverImageName:@"btn_switchBar_handle_1.png"];
	[krSwitchTurns setHandleImageName:@"btn_switchBar_handle.png"];
	[krSwitchTurns setHandleButtonWidth:56.0f handleButtonHeight:25.0f];
	[krSwitchTurns runGeneral];
	[krSwitchTurns setOn:YES];
	[krSwitchTurns addTarget:self action:@selector(_change:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:krSwitchTurns];
	[krSwitchTurns release];
    [super viewDidLoad];
}
```

## Version

KRSwitch now is V0.9 beta.

## License

KRSwitch is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
