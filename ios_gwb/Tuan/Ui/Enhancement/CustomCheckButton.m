//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "CustomCheckButton.h"

#define COLOR_WITH_RGBA(__R__, __G__, __B__, __A__) [UIColor colorWithRed:__R__ / 255.0f green:__G__ / 255.0f blue:__B__ / 255.0f alpha:__A__]

#define COLOR_WITH_RGB(__R__, __G__, __B__)	[UIColor colorWithRed:__R__ / 255.0f green:__G__ / 255.0f blue:__B__ / 255.0f alpha:1.0f]

#define COLOR_NAVIGATIONBAR_BG				COLOR_WITH_RGB(36, 138, 18) //COLOR_WITH_RGBA(22, 164, 232, 0.2f)
#define COLOR_DARK_GRAY						COLOR_WITH_RGB(51, 51, 51)
#define COLOR_FRENCH_GRAY					COLOR_WITH_RGB(128, 128, 128)

@interface CustomCheckButton(private)  // 声明一个私有方法, 该方法不允许对象直接使用
- (void)updateTickRect;
@end

@implementation CustomCheckButton
@synthesize flag = _flag;
@synthesize type = _type;
@synthesize uncheckImage = _uncheckImage;
@synthesize checkImage = _checkImage;

- (void)setTextValue:(NSString*)textOne sum:(int)sum tick:(BOOL)tick {
	
     if (!_textOne) {
		 _textOne = [[UILabel alloc] initWithFrame:CGRectZero];
		 _textOne.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
		 _textOne.backgroundColor = [UIColor clearColor];
		 _textOne.shadowColor = [UIColor whiteColor];
		 _textOne.shadowOffset = CGSizeMake(0.0f, 1.0f);
		 [self addSubview:_textOne];
	 }

	_textOne.text = textOne;
	_textOne.frame = [self caculateLabelFrame:_textOne xOffset:30.0f yOffset:2.0f];
		
	if (!_textTwo) {
		_textTwo = [[UILabel alloc] initWithFrame:CGRectZero];
		_textTwo.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		_textTwo.textColor = COLOR_DARK_GRAY;
		_textTwo.backgroundColor = [UIColor clearColor];
		_textTwo.shadowColor = [UIColor whiteColor];
		_textTwo.shadowOffset = CGSizeMake(0.0f, 1.0f);
		[self addSubview:_textTwo];
	}
    
    if (sum < 0) {
        
        _textTwo.hidden = YES;
    } else
    {
        _textTwo.text = [NSString stringWithFormat:@"(%d)", sum];
        _textTwo.frame = [self caculateLabelFrame:_textTwo xOffset:_textOne.frame.origin.x + _textOne.frame.size.width + 5.0f yOffset:3.0f];
    
    }

	if (!_tickRect) {
		_tickRect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_uncheckImage]];
		CGSize size = _tickRect.image.size;
		_tickRect.frame = CGRectMake(self.frame.size.width - size.width - 75.0f, 
									 (self.frame.size.height - size.height) / 2.0f, size.width, size.height);	
		[self addSubview:_tickRect];
	}
	
	[self setTickValue:tick];
}

- (void)setTextValue:(NSString*)textOne textFont:(UIFont*)textFont sum:(int)sum sumFont:(UIFont*)sumFont tick:(BOOL)tick {
	
	if (!_textOne) {
		_textOne = [[UILabel alloc] initWithFrame:CGRectZero];
		_textOne.font = textFont;
		_textOne.textColor = COLOR_DARK_GRAY;
		_textOne.backgroundColor = [UIColor clearColor];
		_textOne.shadowColor = [UIColor whiteColor];
		_textOne.shadowOffset = CGSizeMake(0.0f, 1.0f);
		[self addSubview:_textOne];
	}
	
	_textOne.text = textOne;
	
	if (!_textTwo) {
		_textTwo = [[UILabel alloc] initWithFrame:CGRectZero];
		_textTwo.font = sumFont;
		_textTwo.textColor = COLOR_DARK_GRAY;
		_textTwo.backgroundColor = [UIColor clearColor];
		_textTwo.shadowColor = [UIColor whiteColor];
		_textTwo.shadowOffset = CGSizeMake(0.0f, 1.0f);
		[self addSubview:_textTwo];
	}
	_textTwo.text = [NSString stringWithFormat:@"(%d)", sum];
	
	if (!_tickRect) {
		_tickRect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_uncheckImage]];
		[self addSubview:_tickRect];
	}
	
	[self cacaulateViewFrame]; 
	[self setTickValue:tick];
}

- (void)cacaulateViewFrame {
	
	float width = 0.0f;
	if (self.type == CustomCheckButtonTypeRight) {
		
		width = 5.0f;
		_textOne.frame = [self caculateLabelFrame:_textOne xOffset:width yOffset:0];
		width += _textOne.frame.size.width;
		_textTwo.frame = [self caculateLabelFrame:_textTwo xOffset:width yOffset:3.0f];
		width += _textTwo.frame.size.width + 5.0f;
		if (_tickRect) {
			CGSize size = _tickRect.image.size;
			_tickRect.frame = CGRectMake(width, 
										 (self.frame.size.height - size.height) / 2.0f, size.width, size.height);
			width += _tickRect.frame.size.width + 5.0f;
		}
		
	} else if (self.type == CustomCheckButtonTypeLeft) {
		
		width = 5.0f;
		if (_tickRect) {
			CGSize size = _tickRect.image.size;
			_tickRect.frame = CGRectMake(width, (self.frame.size.height - size.height) / 2.0f, size.width, size.height);
			width += _tickRect.frame.size.width + 8.0f;
		}
		_textOne.frame = [self caculateLabelFrame:_textOne xOffset:width yOffset:3.0f];
		width += _textOne.frame.size.width;
		_textTwo.frame = [self caculateLabelFrame:_textTwo xOffset:_textOne.frame.origin.x + _textOne.frame.size.width + 2.0f yOffset:3.0f];
		width += _textTwo.frame.size.width + 5.0f;
	}
	
	//self.frame = CGRectMake(0.0f, 0.0f, width, self.frame.size.height);
}

- (CGRect)caculateLabelFrame:(UILabel*)label xOffset:(float)xOffset yOffset:(float)yOffset {
	
    UIFont *usefont = label.font;
	
	CGSize maximumLabelSize = CGSizeMake(200.0f, usefont.pointSize);
	CGSize expectedLabelSize = [label.text sizeWithFont:usefont
									  constrainedToSize:maximumLabelSize 
										  lineBreakMode:UILineBreakModeWordWrap];
	
	return CGRectMake(xOffset, (self.frame.size.height - expectedLabelSize.height - yOffset) / 2.0f, expectedLabelSize.width, expectedLabelSize.height + yOffset);
}

- (void)setTickValue:(BOOL)tick {

	if (tick != _flag ) {
		_flag = tick;
		[self updateTickRect];
	}
}

- (void)updateTickRect {
	
	if (!_tickSymbol) {
		_tickSymbol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_checkImage]];
		CGSize size = _tickSymbol.image.size;
		_tickSymbol.frame = CGRectMake(0, 0, size.width, size.height);
		[_tickRect addSubview:_tickSymbol];
	}
    _tickSymbol.hidden = !_flag;
}

- (void)dealloc {
	[_textOne release];
	[_textTwo release];
	[_tickRect release];
	[_tickSymbol release];
    
    [_uncheckImage release];
    [_checkImage release];
	
    [super dealloc];
}


@end
