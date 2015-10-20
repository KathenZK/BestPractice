//
//  ImageContainerView.m
//  BestPractice
//
//  Created by ZK on 15/10/20.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "ImageContainerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

/**
 *  ImageContainerView 上可显示图片的最大个数
 */
const NSInteger ImageContainerViewMaxNumberOfImages = 9;

/**
 *  ImageContainerView 上创建的 UIImageView 的 tag 的基数
 */
const NSInteger ImageContainerViewBaseTag = 100;

const NSInteger ImageContainerViewNumberOfImagesForRow = 3;

const CGFloat ImageContainerViewImagesSpace = 8;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ImageContainerView

/**
 *  ImagesUrl 的 setter 方法
 *
 *  @param imagesUrl 所有图片的 URL
 */
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
    
    [self setupViewWithImagesCount:numberOfImages];
}

/**
 *  根据图片个数创建 UIImageView
 *
 *  @param count 图片个数
 */
- (void)setupViewWithImagesCount:(NSInteger)count {
    CGFloat imageViewSize = (ScreenWidth - (ImageContainerViewNumberOfImagesForRow + 1) * ImageContainerViewImagesSpace) / ImageContainerViewNumberOfImagesForRow;
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = ImageContainerViewBaseTag + 1;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapImageView:)];
        [imageView addGestureRecognizer:tapGesture];
        [imageView sd_setImageWithURL:self.imagesUrl[i] placeholderImage:[UIImage imageNamed:@"diary_place"]];
        imageView.frame = CGRectMake(i * imageViewSize, i * imageViewSize, imageViewSize, imageViewSize);
#warning todo
        [self addSubview:imageView];
    }
}

/**
 *  点击 UIImageView 时的响应方法
 *
 *  @param tapGesture 添加到 UIImageView 手势
 */
- (void)singleTapImageView:(UITapGestureRecognizer *)tapGesture {
    if ([self.delegate respondsToSelector:@selector(imageContainerView:tappedImageIndex:)]) {
        [self.delegate imageContainerView:self tappedImageIndex:tapGesture.view.tag - ImageContainerViewBaseTag];
    }
}

@end
