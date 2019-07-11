//
//  APTBadgeButton.m
//   Example
//
//  Created by Alena Belyaeva on 11/4/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTBadgeButton.h"
#import "APTColorList.h"

static CGFloat const kAPTBadgeButtonHeightBadgeLabel = 16.0;

@interface APTBadgeButton ()

@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UIView *badgeContainerView;

@end

@implementation APTBadgeButton

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBadge];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupBadge];
    }
    return self;
}

#pragma mark - Public

- (void)setBadgeString:(NSString *)badgeString {
    self.badgeLabel.text = badgeString;
    self.badgeContainerView.hidden = badgeString.length == 0;
}

#pragma mark - Private

- (void)setupBadge {
    self.badgeContainerView = [UIView new];
    self.badgeContainerView.layer.cornerRadius = kAPTBadgeButtonHeightBadgeLabel / 2.0;
    self.badgeContainerView.clipsToBounds = YES;
    self.badgeContainerView.backgroundColor = [APTColorList redBadgeColor];

    self.badgeContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.badgeContainerView];
	
    [self.badgeContainerView.leftAnchor constraintEqualToAnchor: self.centerXAnchor constant:40.0].active = YES;
    [self.badgeContainerView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor].active = YES;
    [self.badgeContainerView.heightAnchor constraintEqualToConstant: kAPTBadgeButtonHeightBadgeLabel].active = YES;
    [self.badgeContainerView.widthAnchor constraintGreaterThanOrEqualToConstant:kAPTBadgeButtonHeightBadgeLabel].active = YES;
    self.badgeContainerView.hidden = YES;
    
    self.badgeLabel = [UILabel new];
    self.badgeLabel.font = [UIFont systemFontOfSize:10];
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.badgeContainerView addSubview:self.badgeLabel];
    
    [self.badgeLabel.leftAnchor constraintEqualToAnchor: self.badgeContainerView.leftAnchor constant:3].active = YES;
    [self.badgeLabel.rightAnchor constraintEqualToAnchor: self.badgeContainerView.rightAnchor constant:-3].active = YES;
    [self.badgeLabel.bottomAnchor constraintEqualToAnchor: self.badgeContainerView.bottomAnchor constant:0].active = YES;
    [self.badgeLabel.topAnchor constraintEqualToAnchor: self.badgeContainerView.topAnchor constant:0].active = YES;
}

@end
