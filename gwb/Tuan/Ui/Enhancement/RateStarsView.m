//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "RateStarsView.h"

@implementation RateStarsView

@synthesize rateCount = _rateCount;

@synthesize target = _target;

@synthesize didRateStar = _didRateStar;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
    }
    return self;
}

//- (void)awakeFromNib {
- (void)setFromNib:(int)count {
	
	_rateCount = count;
	
	self.backgroundColor = [UIColor clearColor];
	
	for (int i = 0; i < 5; i++) {
		
		UIButton *btnStar = [UIButton buttonWithType:UIButtonTypeCustom];
		btnStar.tag = i + 1;
		btnStar.frame = CGRectMake(40.0f * i, 0, 31.5f, 30.0f);
		if (i >= count) {
			[btnStar setBackgroundImage:[UIImage imageNamed:@"star_gray.png"] forState:UIControlStateNormal];
		}else {
			[btnStar setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
		}
		[btnStar addTarget:self action:@selector(click:) forControlEvents:UIControlEventAllEvents];
		
		[self addSubview:btnStar];
	}
}

- (void)click:(UIButton *)sender {
	
	for (int i = 1; i <= _rateCount; i ++) {
		
		UIButton *btnStar = (UIButton *)[self viewWithTag:i];
		[btnStar setBackgroundImage:[UIImage imageNamed:@"star_gray.png"] forState:UIControlStateNormal];
	}
	
	_rateCount = sender.tag;
	
	for (int i = 1; i <= _rateCount; i ++) {
		
		UIButton *btnStar = (UIButton *)[self viewWithTag:i];
		[btnStar setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
	}
	
	if (_target && [_target respondsToSelector:_didRateStar]) {
		
		[_target performSelector:_didRateStar];
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect {
    // Drawing code.
} 
 */

- (void)dealloc {
	
    [super dealloc];
}


@end
