## Screen Shot

<img src="https://dl.dropbox.com/u/83663874/GitHubs/KRSwitch-1.png" alt="KRSwitch" title="KRSwitch" style="margin: 20px;" class="center" />

## Supports

KRSwitch supports ARC.

## How To Get Started

KRSwitch can customize the UISwitch. 

``` objective-c
#import "KRSwitchTurns.h"

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
        //Setup ON / OFF here first.
        [krSwitchTurns setOn:YES];
        //Then setup here second.
        [krSwitchTurns addTarget:self action:@selector(_change:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:krSwitchTurns];
    }
}
```

## Version

KRSwitch now is V0.9.1 beta.

## License

KRSwitch is available under the MIT license ( or Whatever you wanna do ). See the LICENSE file for more info.
