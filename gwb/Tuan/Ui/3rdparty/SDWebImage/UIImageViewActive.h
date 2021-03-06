/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <UIKit/UIKit.h>
#import "SDWebImageManagerDelegate.h"

@interface UIImageViewActive:UIImageView <SDWebImageManagerDelegate> {
    
    UIActivityIndicatorView *indicatorView;
    BOOL _imageRetrieved;
}

@property(nonatomic, retain)UIActivityIndicatorView *indicatorView;
@property(nonatomic, readonly)BOOL imageRetrieved;

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end
