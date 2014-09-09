//
// HotShareQuery.h
// ZLdisk
//
// Created by zhang zuochen on 12-06-01.
// Copyright 2012年 AMG-TECH All rights reserved.
//

#import "ShowMoreCell.h"

#define kShowMoreXoffset 35.0f
#define kIndicatorViewXoffset 15.0f
#define kIndicatorViewTag 10

@implementation ShowMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier bgcolor:[UIColor clearColor]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier bgcolor:(UIColor*)bgColor {
	
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIView *myContentView = self.contentView;
        myContentView.backgroundColor = [UIColor clearColor];
		
		// description
        _showMoreText = [[UILabel alloc] initWithFrame:CGRectZero];
        _showMoreText.backgroundColor = [UIColor clearColor];
        _showMoreText.textColor = [UIColor darkGrayColor];
        _showMoreText.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
		_showMoreText.text = @"                     加载更多...";
        _showMoreText.textAlignment = NSTextAlignmentCenter;
        [myContentView addSubview:_showMoreText];
		
		_description = [[UILabel alloc] initWithFrame:CGRectZero];
        _description.backgroundColor = [UIColor clearColor];
        _description.textColor = [UIColor darkGrayColor];
        _description.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
        _description.textAlignment = NSTextAlignmentCenter;
        [myContentView addSubview:_description];
		[_description release];
		
		UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		indicatorView.frame = CGRectZero;
		indicatorView.tag = kIndicatorViewTag;
		indicatorView.alpha = 0.0;
		[myContentView addSubview:indicatorView];
		[indicatorView release];
    }
	
    return self;
}

- (void)setcontents:(int)number sum:(int)sum {
	
    _description.text = [NSString stringWithFormat:@"          当前显示 %d 条 共 %d 条", number, sum];
}

- (void)showIndicator:(BOOL)show {
	
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.contentView viewWithTag:kIndicatorViewTag];
	
	if (indicatorView) {
		
		if (show) {
			indicatorView.alpha = 1.0f;
			[indicatorView startAnimating];
			
		} else {
			
			indicatorView.alpha = 0.0f;
			[indicatorView stopAnimating];	
		}
	}
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGRect bounds = [self contentView].bounds;

	_showMoreText.frame = [self showMoreTextRect:bounds.size.height width:bounds.size.width];
	
	float yOffset = _showMoreText.frame.origin.y + _showMoreText.frame.size.height;
	_description.frame = [self descriptionTextRect:_showMoreText.frame.origin.x yOffset:yOffset];
	
	UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.contentView viewWithTag:kIndicatorViewTag];
	
	if (indicatorView) {
        indicatorView.frame = CGRectMake(kIndicatorViewXoffset, (bounds.size.height - 25.0f) / 2.0f, 25.0f, 25.0);
	}
}

- (CGRect)showMoreTextRect:(float)height width:(float)width {
	
    UIFont *useFont = _showMoreText.font;
	CGSize maximumLabelSize = CGSizeMake(400.0f, useFont.xHeight + useFont.ascender + useFont.descender);
	CGSize expectedLabelSize = [_showMoreText.text sizeWithFont:useFont
											  constrainedToSize:maximumLabelSize 
												  lineBreakMode:UILineBreakModeWordWrap];

	float y = (height-expectedLabelSize.height * 2) / 2.0f ;
	return CGRectMake(kShowMoreXoffset + 10.0f, y, expectedLabelSize.width, expectedLabelSize.height);
}

- (CGRect)descriptionTextRect:(float)xOffset yOffset:(float)yOffset {
	
    UIFont *useFont = _description.font;
	CGSize maximumLabelSize = CGSizeMake(400.0f, useFont.xHeight + useFont.ascender + useFont.descender);
	CGSize expectedLabelSize = [_description.text sizeWithFont:useFont
											 constrainedToSize:maximumLabelSize 
												 lineBreakMode:UILineBreakModeWordWrap];
	
	return CGRectMake(kShowMoreXoffset + 10.0f, yOffset, expectedLabelSize.width, expectedLabelSize.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
}

-(void) setCellBackgroundColor:(UIColor *) bgColor {
	
    self.contentView.backgroundColor = bgColor;
}

- (void)dealloc {
    [super dealloc];
}

@end
