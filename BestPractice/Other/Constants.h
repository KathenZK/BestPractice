//
//  Constants.h
//  BestPractice
//
//  Created by ZK on 15/10/19.
//  Copyright © 2015年 ZK. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* Constants_h */
