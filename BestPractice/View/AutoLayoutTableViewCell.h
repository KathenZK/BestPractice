//
//  AutoLayoutTableViewCell.h
//  BestPractice
//
//  Created by ZK on 15/10/19.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoLayoutModel.h"
#import "ImageContainerView.h"

@interface AutoLayoutTableViewCell : UITableViewCell

@property (nonatomic, strong) AutoLayoutModel *model;
@property (nonatomic, strong) ImageContainerView *imageContainerView;

@end
