/*
 Copyright (c) 2010 Robert Chin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

/*
 * Modified by ilovekalvar@gmail.com on 2012/11/01.
 */


#import "KRSwitchTurns.h"


@implementation KRSwitchTurns

@synthesize buttonHeight, buttonWidth;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if( self ){
        // ... 
    }
    return self;
}

-(void)dealloc{
    
    [super dealloc];
}

//- (void)initCommon
//{
//    //self._buttonHeight = 25.0f;
//    //self._buttondWidth = 56.0f;
//	[super initCommon];
//}

#pragma Methods
-(void)setOnText:(NSString *)_onText offText:(NSString *)_offText
{
    if( !_onText ){
        _onText = @"ON";
    }
    if( !_offText ){
        _offText = @"OFF";
    }
    //設定背景的 On / Off 文字
    onText = [UILabel new];
	onText.text = NSLocalizedString(_onText, @"Switch localized string");
	onText.textColor = [UIColor whiteColor];
	onText.font = [UIFont boldSystemFontOfSize:14];
	onText.shadowColor = [UIColor colorWithRed:104.0/255 green:73.0/255 blue:54.0/255 alpha:1.0];
    onText.shadowOffset = CGSizeMake(0, 1);
	
	offText = [UILabel new];
	offText.text = NSLocalizedString(_offText, @"Switch localized string");
	offText.textColor = [UIColor colorWithRed:104.0/255 green:73.0/255 blue:54.0/255 alpha:1.0];
	offText.font = [UIFont boldSystemFontOfSize:14];
	offText.shadowColor = [UIColor whiteColor];
    offText.shadowOffset = CGSizeMake(0, 1);
}

-(void)setOnImageName:(NSString *)_anOnImageName offImageName:(NSString *)_anOffImageName{
    self._onImageName  = _anOnImageName;
    self._offImageName = _anOffImageName;
}

-(void)setBackgroundImageName:(NSString *)_aBackgroundImageName{
    self._backgroundImageName = _aBackgroundImageName;
}

-(void)setHandleImageName:(NSString *)_aHandleImageName{
    self._handleImageName = _aHandleImageName;
}

-(void)setHoverImageName:(NSString *)_aHoverImageName{
    self._hoverImageName = _aHoverImageName;
}

-(void)setHandleButtonWidth:(CGFloat)_handleButtonWidth handleButtonHeight:(CGFloat)_handleButtonHeight{
    self._buttonHeight = _handleButtonHeight;
    self._buttonWidth  = _handleButtonWidth;
}

-(void)runGeneral{
    [super initCommon];
}
#pragma Delegates
/*
 * 這裡會在移動按鈕時，不斷的進行重繪
 */
- (void)drawUnderlayersInRect:(CGRect)aRect withOffset:(float)offset inTrackWidth:(float)trackWidth
{
    {
        CGRect textRect = [self bounds];
        textRect.size = CGSizeMake(63, 23);
        textRect.origin.x += 36.0 + (offset - trackWidth);
        textRect.origin.y = textRect.origin.y;
        [onText drawTextInRect:textRect];
    }
    
    {
        CGRect textRect = [self bounds];
        textRect.size = CGSizeMake(63, 23);
        textRect.origin.y = textRect.origin.y;
        textRect.origin.x += (offset + trackWidth) - 12.0;
        [offText drawTextInRect:textRect];
    }
}

@end
