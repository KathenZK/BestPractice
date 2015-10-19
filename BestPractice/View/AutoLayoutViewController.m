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

@interface AutoLayoutViewController () <UITableViewDelegate, UITableViewDataSource, AutoLayoutViewModelDelegate>

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
    [self.view addSubview:self.tableView];
    
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
    AutoLayoutTableViewCell *cell = [AutoLayoutTableViewCell autoLayoutTableViewCellWithTableView:tableView];
    cell.model = self.viewModel.modelsArr[indexPath.row];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView fd_heightForCellWithIdentifier:@"AutoLayoutTableViewCell" cacheByIndexPath:indexPath configuration:^(AutoLayoutTableViewCell *cell) {
//        cell.model = self.viewModel.modelsArr[indexPath.row];
//    }];
//}


@end