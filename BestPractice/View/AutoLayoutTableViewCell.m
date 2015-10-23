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
#import "Constants.h"

const NSInteger AutoLayoutTableViewCellViewSpace = 8;

@interface AutoLayoutTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stageNoteNameLabel;
@property (nonatomic, strong) UIImageView *canVisitImageView;
@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation AutoLayoutTableViewCell

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
    self.stageNoteNameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:self.stageNoteNameLabel];
    
    self.canVisitImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"canVisit"];
    self.canVisitImageView.image = image;
    [self.contentView addSubview:self.canVisitImageView];
    
    self.imageContainerView = [[ImageContainerView alloc] init];
    [self.contentView addSubview:self.imageContainerView];
    
    self.introductionLabel = [[UILabel alloc] init];
    self.introductionLabel.font = [UIFont systemFontOfSize:14];
    self.introductionLabel.textColor = [UIColor lightGrayColor];
    self.introductionLabel.numberOfLines = 3;
    [self.contentView addSubview:self.introductionLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(AutoLayoutTableViewCellViewSpace);
        make.right.equalTo(self.stageNoteNameLabel.mas_left).offset(-AutoLayoutTableViewCellViewSpace);
        make.height.mas_equalTo(14);
    }];
    
    [self.stageNoteNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.canVisitImageView.mas_left).offset(-AutoLayoutTableViewCellViewSpace);
        make.top.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(44, 12));
    }];
    
    [self.canVisitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.right.mas_equalTo(-AutoLayoutTableViewCellViewSpace);
        make.size.mas_equalTo(image.size);
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
    
    self.imageContainerView.imagesUrl = self.model.pictureList;
    NSNumber *width = [NSNumber numberWithFloat:ScreenWidth - AutoLayoutTableViewCellViewSpace * 2];
    NSNumber *imageContainerViewHeight = [NSNumber numberWithFloat:self.imageContainerView.height];
    [self.imageContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AutoLayoutTableViewCellViewSpace);
        make.width.equalTo(width);
        make.height.equalTo(imageContainerViewHeight);
    }];
    
    self.introductionLabel.text = model.introduction;
    NSDictionary *attributes = @{NSFontAttributeName: self.introductionLabel.font};
    CGSize labelSize = [model.introduction boundingRectWithSize:CGSizeMake(ScreenWidth - AutoLayoutTableViewCellViewSpace * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    [self.introductionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageContainerView);
        make.top.equalTo(self.imageContainerView.mas_bottom).offset(AutoLayoutTableViewCellViewSpace);
        make.right.mas_equalTo(-AutoLayoutTableViewCellViewSpace);
        make.height.mas_equalTo(labelSize.height);
    }];
    
    [self updateConstraintsIfNeeded];
}

@end
