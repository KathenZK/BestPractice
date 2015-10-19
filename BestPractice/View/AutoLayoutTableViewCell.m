//
//  AutoLayoutTableViewCell.m
//  BestPractice
//
//  Created by ZK on 15/10/19.
//  Copyright © 2015年 ZK. All rights reserved.
//

#import "AutoLayoutTableViewCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AutoLayoutTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stageNoteNameLabel;
@property (nonatomic, strong) UIImageView *canVisitImageView;
@property (nonatomic, strong) NSArray *pictureList;
@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation AutoLayoutTableViewCell

+ (instancetype)autoLayoutTableViewCellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"AutoLayoutTableViewCell";
    AutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AutoLayoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.titleLabel];
    
    self.stageNoteNameLabel = [[UILabel alloc] init];
    self.stageNoteNameLabel.font = [UIFont systemFontOfSize:10];
    self.stageNoteNameLabel.textAlignment = NSTextAlignmentCenter;
    self.stageNoteNameLabel.layer.cornerRadius = 3;
    self.stageNoteNameLabel.layer.borderWidth = 0.5;
    self.stageNoteNameLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:self.stageNoteNameLabel];
    
    self.canVisitImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"canVisit"];
    self.canVisitImageView.image = image;
    [self.contentView addSubview:self.canVisitImageView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@8);
        make.right.equalTo(self.stageNoteNameLabel.mas_left).offset(-8);
        make.height.equalTo(@14);
    }];
    
    [self.stageNoteNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.canVisitImageView.mas_left).offset(-8);
        make.top.equalTo(self.titleLabel);
        make.height.equalTo(@12);
        make.width.equalTo(@44);
    }];
    
    [self.canVisitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.equalTo(@-8);
        NSNumber *width = [NSNumber numberWithFloat:image.size.width];
        NSNumber *height = [NSNumber numberWithFloat:image.size.height];
        make.width.equalTo(width);
        make.height.equalTo(height);
    }];
    
}

- (void)setModel:(AutoLayoutModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.stageNoteNameLabel.text = model.stageNoteName;
    
    if (model.isCanVisit) {
        self.canVisitImageView.hidden = NO;
    } else {
        self.canVisitImageView.hidden = YES;
    }
}
@end
