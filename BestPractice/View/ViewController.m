//
//  ViewController.m
//  BestPractice
//
//  Created by ZK on 15/10/14.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "AutoLayoutViewController.h"
#import <Masonry.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"BestPractice";
    self.tableView = [[UITableView alloc] init];
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (NSArray *)dataArr {
    return  @[@"一个使用了Masonry设计的复杂Cell", @"2", @"3"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutViewController *vc = [[AutoLayoutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
