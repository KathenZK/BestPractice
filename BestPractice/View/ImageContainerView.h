//
//  ImageContainerView.h
//  BestPractice
//
//  Created by ZK on 15/10/20.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageContainerView;

@protocol ImageContainerViewDelegate <NSObject>

@optional
- (void)imageContainerView:(ImageContainerView *)imageContainerView tappedImageIndex:(NSInteger)index;

@end


@interface ImageContainerView : UIView

@property (nonatomic, weak) id<ImageContainerViewDelegate> delegate;
@property (nonatomic, strong) NSArray *imagesUrl;

@end
