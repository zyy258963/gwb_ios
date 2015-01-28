/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageViewActive.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "SDWebImageManager.h"
#import "UIImage+Resize.h"

@implementation UIImageViewActive

@synthesize indicatorView;
@synthesize imageRetrieved = _imageRetrieved;

- (void)setImageWithURL:(NSURL *)url
{
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2, 20, 20);
        indicatorView.alpha = 1.0;
        [self addSubview:indicatorView];
        [self bringSubviewToFront:indicatorView];
    }
    _imageRetrieved = NO;
    [indicatorView startAnimating];
    
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    if (placeholder) {
        self.image = placeholder;
    }

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{

    
    if (image.size.width > 10 && image.size.height > 10)
    {
        _imageRetrieved = YES;
        self.image = image;
    }
    
    [indicatorView stopAnimating];
    [indicatorView removeFromSuperview];
    [indicatorView release];
    indicatorView = nil;
    
    
}

@end
