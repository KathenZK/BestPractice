//
//  AutoLayoutViewModel.m
//  BestPractice
//
//  Created by ZK on 15/10/16.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "Constants.h"
#import "AutoLayoutViewModel.h"
#import <AFNetworking.h>
#import "AutoLayoutModel.h"
#import <MJExtension.h>

@interface AutoLayoutViewModel ()

@end

@implementation AutoLayoutViewModel

- (void)fetchModelsFromNetworking {
    [self loadData:[@1 integerValue]];
}

- (void)loadData:(NSInteger)page {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",nil];
    
    NSString *url = [NSString stringWithFormat:@"http://beta.home.ddmap.com/homeServer/diary/list.do?sort=&stageCode=-1&page=%zd&rows=10&osType=1&fromType=3", page];
    NSLog(@"url---:%@", url);
    
    __block NSMutableArray *tempModelsArr = [NSMutableArray arrayWithCapacity:10];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        if (responseObject) {
            tempModelsArr = [AutoLayoutModel objectArrayWithKeyValuesArray:[responseObject valueForKey:@"resultList"]];
            if (tempModelsArr.count > 0) {
                self.modelsArr = tempModelsArr;
                
                if ([self.delegate respondsToSelector:@selector(autoLayoutViewModelFetchedModelsFromNetworking)]) {
                    [self.delegate autoLayoutViewModelFetchedModelsFromNetworking];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
