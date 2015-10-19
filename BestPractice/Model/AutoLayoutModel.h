//
//  AutoLayoutModel.h
//  BestPractice
//
//  Created by ZK on 15/10/16.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoLayoutModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *stageNoteName;
@property (nonatomic, assign, getter=isCanVisit) BOOL canVisit;
@property (nonatomic, strong) NSArray *pictureList;
@property (nonatomic, copy) NSString *introduction;

@end
