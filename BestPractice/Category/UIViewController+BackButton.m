//
//  UIViewController+BackButton.m
//  BestPractice
//
//  Created by ZK on 15/10/19.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "Constants.h"
#import "UIViewController+BackButton.h"
#import <objc/runtime.h>

@implementation UIViewController (BackButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swizzled_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling
- (void)swizzled_viewWillAppear:(BOOL)animated {
    [self swizzled_viewWillAppear:animated];
    
    if (![self isKindOfClass:NSClassFromString(@"ViewController")]) {
        UIImage *image = [UIImage imageNamed:@"goBack_blue.png"];
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [leftButton setImage:image forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    NSLog(@"swizzled_viewWillAppear");
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
