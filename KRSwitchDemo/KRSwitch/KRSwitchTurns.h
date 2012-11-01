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


#import "KRSwitch.h"

@interface KRSwitchTurns : KRSwitch {
	UILabel *onText;
	UILabel *offText;
    CGFloat buttonHeight;
    CGFloat buttonWidth;
}

@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonWidth;

//-(id)initWithFrame:(CGRect)frame buttonHeight:(CGFloat)_pressButtonHeight buttonWidth:(CGFloat)_pressButtonWidth;

/*
 * 設定文字
 */
-(void)setOnText:(NSString *)_onText offText:(NSString *)_offText;
/*
 * 設定 ON / OFF 圖片來源名稱
 */
-(void)setOnImageName:(NSString *)_anOnImageName offImageName:(NSString *)_anOffImageName;
/*
 * 設定背景圖片來源名稱
 */
-(void)setBackgroundImageName:(NSString *)_aBackgroundImageName;
/*
 * 設定在點擊、拖拉作用中的 Handle 按鈕圖片來源名稱
 */
-(void)setHoverImageName:(NSString *)_aHoverImageName;
/*
 * 設定在點擊、拖拉作用的預設 Handle 按鈕圖片來源名稱
 */
-(void)setHandleImageName:(NSString *)_aHandleImageName;
/*
 * 設定在點擊、拖拉作用的 Handle 按鈕圖片 Width / Height
 */
-(void)setHandleButtonWidth:(CGFloat)_handleButtonWidth handleButtonHeight:(CGFloat)_handleButtonHeight;

/*
 * 上述條件都設定完後，執行本函式
 */
-(void)runGeneral;


@end
