//
//  AutoLayoutViewController.m
//  BestPractice
//
//  Created by ZK on 15/10/16.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "AutoLayoutViewController.h"
#import <Masonry.h>
#import "AutoLayoutViewModel.h"
#import "AutoLayoutModel.h"
#import <MBProgressHUD.h>
#import "AutoLayoutTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface AutoLayoutViewController () <UITableViewDelegate, UITableViewDataSource, AutoLayoutViewModelDelegate, ImageContainerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AutoLayoutViewModel *viewModel;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"一个较为复杂的Cell";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.viewModel = [[AutoLayoutViewModel alloc] init];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
}

#pragma mark - setter & getter
- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.fd_debugLogEnabled = YES;
    self.tableView.rowHeight = 450;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[AutoLayoutTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AutoLayoutTableViewCell class])];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setViewModel:(AutoLayoutViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.viewModel.delegate = self;
    [self.viewModel fetchModelsFromNetworking];
}

- (void)setHud:(MBProgressHUD *)hud {
    _hud = hud;
    
    self.hud.labelText = @"加载中...";
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}

#pragma mark - AutoLayoutViewModelDelegate
- (void)autoLayoutViewModelFetchedModelsFromNetworking {
    self.tableView = [[UITableView alloc] init];
    [self.hud hide:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AutoLayoutTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[AutoLayoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([AutoLayoutTableViewCell class])];
    }
    cell.model = self.viewModel.modelsArr[indexPath.row];
    cell.imageContainerView.delegate = self;
//    cell.fd_enforceFrameLayout = NO;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([AutoLayoutTableViewCell class]) cacheByIndexPath:indexPath configuration:^(AutoLayoutTableViewCell *cell) {
//        cell.model = self.viewModel.modelsArr[indexPath.row];
//    }];
//}

#pragma mark - ImageContainerViewDelegate
- (void)imageContainerView:(ImageContainerView *)imageContainerView tappedImageIndex:(NSInteger)index {
    
}
@end
