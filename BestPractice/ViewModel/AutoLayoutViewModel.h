//
//  AutoLayoutViewModel.h
//  BestPractice
//
//  Created by ZK on 15/10/16.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AutoLayoutViewModelDelegate <NSObject>

@optional
- (void)autoLayoutViewModelFetchedModelsFromNetworking;

@end

@interface AutoLayoutViewModel : NSObject

@property (nonatomic, strong) NSArray *modelsArr;
@property (nonatomic, strong) id <AutoLayoutViewModelDelegate>delegate;;

- (void)fetchModelsFromNetworking;

@end
