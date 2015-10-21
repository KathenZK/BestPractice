//
//  ImageContainerView.m
//  BestPractice
//
//  Created by ZK on 15/10/20.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "ImageContainerView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constants.h"

const NSInteger ImageContainerViewMaxNumberOfImages = 9;

const NSInteger ImageContainerViewBaseTag = 100;

const NSInteger ImageContainerViewNumberOfImagesForRow = 3;

const CGFloat ImageContainerViewImagesSpace = 8;

@implementation ImageContainerView

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSUInteger i = 0; i < ImageContainerViewMaxNumberOfImages; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = ImageContainerViewBaseTag + 1;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapImageView:)];
            [imageView addGestureRecognizer:tapGesture];
            [self addSubview:imageView];
        }
    }
    return self;
}

-(void)setImagesUrl:(NSArray *)imagesUrl {
     NSInteger numberOfImages = imagesUrl.count;
    if (numberOfImages > ImageContainerViewMaxNumberOfImages) {
        NSMutableArray *temImagesUrl = [NSMutableArray  arrayWithCapacity:ImageContainerViewMaxNumberOfImages];
        for (NSInteger i = 0; i < ImageContainerViewMaxNumberOfImages; i++) {
            [temImagesUrl addObject:imagesUrl[i]];
        }
        _imagesUrl = temImagesUrl;
        numberOfImages = ImageContainerViewMaxNumberOfImages;
    } else {
        _imagesUrl = imagesUrl;
    }
    
    CGFloat imageViewSize = (ScreenWidth - (ImageContainerViewNumberOfImagesForRow + 1) * ImageContainerViewImagesSpace) / ImageContainerViewNumberOfImagesForRow;
    for (NSInteger i = 0; i < numberOfImages; i++) {
        UIImageView *imageView = self.subviews[i];
        if (i > numberOfImages) {
            imageView.hidden = YES;
        } else {
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:self.imagesUrl[i] placeholderImage:[UIImage imageNamed:@"diary_place"]];
            if (numberOfImages == 1) {
                imageView.frame = CGRectMake(0, 0, imageViewSize - ImageContainerViewImagesSpace, imageViewSize - ImageContainerViewImagesSpace);
            } else {
                NSInteger row = numberOfImages == 4 ? 2: 3;
                imageView.frame = CGRectMake((i%row) * imageViewSize, (i/row) * imageViewSize, imageViewSize - ImageContainerViewImagesSpace, imageViewSize - ImageContainerViewImagesSpace);
            }
        }
    }
}

- (CGFloat)height {
    UIImageView *lastImageView = self.subviews.lastObject;
    return CGRectGetMaxY(lastImageView.frame);
}

- (void)singleTapImageView:(UITapGestureRecognizer *)tapGesture {
    if ([self.delegate respondsToSelector:@selector(imageContainerView:tappedImageIndex:)]) {
        [self.delegate imageContainerView:self tappedImageIndex:tapGesture.view.tag - ImageContainerViewBaseTag];
    }
}

@end
