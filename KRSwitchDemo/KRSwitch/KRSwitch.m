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
#import <QuartzCore/QuartzCore.h>

@interface KRSwitch ()

- (void)regenerateImages;
- (void)performSwitchToPercent:(float)toPercent;

@end

@interface KRSwitch (fixPrivate)

-(UIImage *)_imageNamedNoCache:(NSString *)_name;
-(void)_exchangeOnOffImage;
-(void)_drawOnOffButtonImageName:(NSString *)_buttonImageName;
-(void)_drawHoveringOnOffButtonImageName:(NSString *)_aHoverImageName;

@end

@implementation KRSwitch (fixPrivate)

-(UIImage *)_imageNamedNoCache:(NSString *)_name
{
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], _name]];
}

-(void)_exchangeOnOffImage
{
    [self _drawOnOffButtonImageName:( self.on ? self._onImageName : self._offImageName )];
}

-(void)_drawOnOffButtonImageName:(NSString *)_buttonImageName
{
    //起迄時的按鈕樣式 ( 56 x 26 )
    UIImage *knobTmpImage = [UIImage imageNamed:_buttonImageName];
    UIImage *knobImageStretch = [knobTmpImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //按鈕 Frame
    CGSize _knobImageSize = knobTmpImage.size;
    CGRect knobRect = CGRectMake(0, 0, _knobImageSize.width, _knobImageSize.height);
    //重繪按鈕圖
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(knobRect.size, NO, scale);
    }
    else
    {
        UIGraphicsBeginImageContext(knobRect.size);
    }
    [knobImageStretch drawInRect:knobRect];
    self.knobImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)_drawHoveringOnOffButtonImageName:(NSString *)_aHoverImageName
{
    //Hover 作用中的按鈕樣式 ( switch_bar_handler_icon.png : 24 x 24 )
    UIImage *knobTmpImage = [self _imageNamedNoCache:_aHoverImageName];
    UIImage *knobImageStretch = [knobTmpImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    CGRect knobRect = CGRectMake(0, 0, knobWidth, [knobImageStretch size].height);
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(knobRect.size, NO, scale);
    }
    else
    {
        UIGraphicsBeginImageContext(knobRect.size);
    }
    [knobImageStretch drawInRect:knobRect];
    self.knobImagePressed = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end

@implementation KRSwitch

@synthesize sliderOff, sliderOn;
@synthesize knobImage, knobImagePressed;
@synthesize endDate;
@synthesize _buttonWidth, _buttonHeight;
@synthesize _backgroundImageName, _hoverImageName, _offImageName, _onImageName, _handleImageName;


//初始化所有參數與圖片
- (void)initCommon
{
    
    if( !self._buttonHeight )
    {
        self._buttonHeight = 25.0f;
    }
    if( !self._buttonWidth )
    {
        self._buttonWidth = 56.0f;
    }
    if( !self._onImageName )
    {
        self._onImageName = @"switch_bar_handle_on.png";
    }
    if( !self._offImageName )
    {
        self._offImageName = @"switch_bar_handle_off.png";
    }
    if( !self._backgroundImageName )
    {
        self._backgroundImageName = @"switch_bar_bg.png";
    }
    if( !self._hoverImageName )
    {
        self._hoverImageName = @"switch_bar_handle_1.png";
    }
    if( !self._handleImageName )
    {
        self._handleImageName = @"switch_bar_handle.png";
    }
    //按鈕圖片的高度
    drawHeight = self._buttonHeight;
	/* It seems that the animation length was changed in iOS 4.0 to animate the switch slower. */
	if(kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_4_0)
    {
		animationDuration = 0.25;
	}
    else
    {
		animationDuration = 0.175;
	}
	self.contentMode = UIViewContentModeRedraw;
    //切換的按鈕圖片寬度
	[self setKnobWidth:self._buttonWidth];
	//[self regenerateImages];
	//設定背景圖
    //sliderOff = [UIImage imageNamed:@"switch_bar_bg.png"];
    self.sliderOff = [self _imageNamedNoCache:self._backgroundImageName];
    //依螢幕解析度做縮放
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
		scale = [[UIScreen mainScreen] scale];
    }
    else
    {
		scale = 1.0f;
	}
    self.opaque = NO;
}

- (id)initWithFrame:(CGRect)aRect
{
	if((self = [super initWithFrame:aRect])){
		//[self initCommon];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder])){
		[self initCommon];
		percent = 1.0;
	}
	return self;
}

//設定按鈕樣式
- (void)setKnobWidth:(float)aFloat
{
	knobWidth = roundf(aFloat); // whole pixels only
	endcapWidth = roundf(knobWidth / 2.0);
    //起迄時的按鈕樣式 ( 56 x 26 )
    [self _drawOnOffButtonImageName:self._handleImageName];
    //Hover 作用中的按鈕樣式 ( 舊圖是 switch_bar_handler_icon.png : 24 x 24 )
    [self _drawHoveringOnOffButtonImageName:self._hoverImageName];
}

- (float)knobWidth
{
	return knobWidth;
}

/*
 * Nothing else here function.
 */
//移動時的遮罩( 目前是針對 On 時才觸發，暫時用不到 )
- (void)regenerateImages
{
	CGRect boundsRect = self.bounds;
    UIImage* onSwitchImage = [self _imageNamedNoCache:@"switch_bar_background.png"];
    UIImage *sliderOnBase = [onSwitchImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    CGRect sliderOnRect = boundsRect;
	sliderOnRect.size.height = [sliderOnBase size].height;
	if(UIGraphicsBeginImageContextWithOptions != NULL)
		UIGraphicsBeginImageContextWithOptions(sliderOnRect.size, NO, scale);
	else
		UIGraphicsBeginImageContext(sliderOnRect.size);
	[sliderOnBase drawInRect:sliderOnRect];
	self.sliderOn = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
}

- (void)drawUnderlayersInRect:(CGRect)aRect withOffset:(float)offset inTrackWidth:(float)trackWidth
{
    
}

- (void)drawRect:(CGRect)rect
{
	CGRect boundsRect = self.bounds;
    boundsRect.size.height = drawHeight;
	if(!CGSizeEqualToSize(boundsRect.size, lastBoundsSize)){
		//[self regenerateImages];
		lastBoundsSize = boundsRect.size;
	}
    float width = boundsRect.size.width;
	float drawPercent = percent;
	if(((width - knobWidth) * drawPercent) < 3)
		drawPercent = 0.0;
	if(((width - knobWidth) * drawPercent) > (width - knobWidth - 3))
		drawPercent = 1.0;
    /*
     * Crash for MRC ?! Why ?! T3T ...
     * 因為指標沒有使用 @property(retain)，造成提早 release ... 才會這樣，
     * 而 ARC 則是交由系統管理 Memory，所以能正常運行。
     */    
	if(endDate){
		NSTimeInterval interval = [endDate timeIntervalSinceNow];
		if(interval < 0.0){
			endDate = nil;
		} else {
			if(percent == 1.0)
				drawPercent = cosf((interval / animationDuration) * (M_PI / 2.0));
			else
				drawPercent = 1.0 - cosf((interval / animationDuration) * (M_PI / 2.0));
			[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.0];
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	{
		CGContextSaveGState(context);
		UIGraphicsPushContext(context);
        
		{
			CGRect sliderOffRect = boundsRect;
			sliderOffRect.size.height = [self.sliderOff size].height;
			[self.sliderOff drawInRect:sliderOffRect];
		}
        
		if(drawPercent > 0.0 && drawPercent < 1.0){
			float onWidth = self.knobWidth / 2 + ((width - self.knobWidth / 2) - self.knobWidth / 2) * drawPercent;
			CGRect sourceRect = CGRectMake(0, 0, onWidth * scale, [self.sliderOn size].height * scale);
			CGRect drawOnRect = CGRectMake(0, 0, onWidth, [self.sliderOn size].height);
			CGImageRef sliderOnSubImage = CGImageCreateWithImageInRect([self.sliderOn CGImage], sourceRect);
			CGContextSaveGState(context);
			CGContextScaleCTM(context, 1.0, -1.0);
			CGContextTranslateCTM(context, 0.0, -drawOnRect.size.height);
			CGContextDrawImage(context, drawOnRect, sliderOnSubImage);
			CGContextRestoreGState(context);
            //CGContextRelease(context);
			CGImageRelease(sliderOnSubImage);
		}
        
        if(drawPercent == 1.0){
			float onWidth = [sliderOn size].width;
			CGRect sourceRect = CGRectMake(0, 0, onWidth * scale, [self.sliderOn size].height * scale);
			CGRect drawOnRect = CGRectMake(0, 0, onWidth, [self.sliderOn size].height);
			CGImageRef sliderOnSubImage = CGImageCreateWithImageInRect([self.sliderOn CGImage], sourceRect);
			CGContextSaveGState(context);
			CGContextScaleCTM(context, 1.0, -1.0);
			CGContextTranslateCTM(context, 0.0, -drawOnRect.size.height);
			CGContextDrawImage(context, drawOnRect, sliderOnSubImage);
			CGContextRestoreGState(context);
            //CGContextRelease(context);
			CGImageRelease(sliderOnSubImage);
		}
		
		{
			CGContextSaveGState(context);
			UIGraphicsPushContext(context);
			CGRect insetClipRect = CGRectInset(boundsRect, 4, 4);
			UIRectClip(insetClipRect);
			[self drawUnderlayersInRect:rect
							 withOffset:drawPercent * (boundsRect.size.width - self.knobWidth)
						   inTrackWidth:(boundsRect.size.width - self.knobWidth)];
			UIGraphicsPopContext();
			CGContextRestoreGState(context);
            //CGContextRelease(context);
		}
		
		{
			CGContextScaleCTM(context, 1.0, -1.0);
			CGContextTranslateCTM(context, 0.0, -boundsRect.size.height);
			CGPoint location = boundsRect.origin;
			UIImage *imageToDraw = self.knobImage;
			if(self.highlighted)
				imageToDraw = self.knobImagePressed;
			
            float xlocation;
            
            if(drawPercent == 0.0)
            {
                xlocation = location.x - 1 + roundf(drawPercent * (boundsRect.size.width - self.knobWidth + 2));
            }
            else
            {
                xlocation = location.x - 1 + roundf(drawPercent * (boundsRect.size.width - self.knobWidth + 2));
                xlocation = xlocation < 0.0 ? 0.0 : xlocation;
            }
			CGRect drawOnRect = CGRectMake(xlocation, location.y-1, self.knobWidth, [self.knobImage size].height);
			CGContextDrawImage(context, drawOnRect, [imageToDraw CGImage]);
		}
		UIGraphicsPopContext();
		CGContextRestoreGState(context);
	}
    //CGContextRelease(context);
    UIGraphicsEndImageContext();
}

//1). 點下去的那一刻，每次事件都一定會先觸發這裡
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.highlighted = YES;
	oldPercent = percent;
	endDate = nil;
	mustFlip = YES;
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventTouchDown];
	return YES;
}

//2). 按鈕持續移動中才會觸發，點擊換按鈕時，不會觸發這裡 ( 同 TouchMoved )
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint point = [touch locationInView:self];
	percent = (point.x - knobWidth / 2.0) / (self.bounds.size.width - knobWidth);
	if(percent < 0.0)
		percent = 0.0;
	if(percent > 1.0)
		percent = 1.0;
	if((oldPercent < 0.25 && percent > 0.5) || (oldPercent > 0.75 && percent < 0.5))
		mustFlip = NO;
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventTouchDragInside];
	return YES;
}

//5). 最初開始事件 / 最後結束事件
- (void)finishEvent
{
	self.highlighted = NO;
	endDate = nil;
	float toPercent = roundf(1.0 - oldPercent);
	if(!mustFlip){
		if(oldPercent < 0.25){
			if(percent > 0.5)
				toPercent = 1.0;
			else
				toPercent = 0.0;
		}
		if(oldPercent > 0.75){
			if(percent < 0.5)
				toPercent = 0.0;
			else
				toPercent = 1.0;
		}
	}
	[self performSwitchToPercent:toPercent];
    [self _exchangeOnOffImage];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
	[self finishEvent];
}

//4). 準備結束 
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self finishEvent];
}

- (BOOL)isOn
{
	return percent > 0.5;
}

- (void)setOn:(BOOL)aBool
{
	[self setOn:aBool animated:NO];
}

- (void)setOn:(BOOL)aBool animated:(BOOL)animated
{
	if(animated){
		float toPercent = aBool ? 1.0 : 0.0;
		if((percent < 0.5 && aBool) || (percent > 0.5 && !aBool))
			[self performSwitchToPercent:toPercent];
	} else {
		percent = aBool ? 1.0 : 0.0;
		[self setNeedsDisplay];
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
    [self _exchangeOnOffImage];
}

//3). 實現開關動作
- (void)performSwitchToPercent:(float)toPercent
{
	self.endDate = [NSDate dateWithTimeIntervalSinceNow:fabsf(percent - toPercent) * animationDuration];
	percent = toPercent;
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	[self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
