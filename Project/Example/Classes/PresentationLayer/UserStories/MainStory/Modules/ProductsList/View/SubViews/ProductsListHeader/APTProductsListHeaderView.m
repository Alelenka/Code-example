//
//  APTProductsListHeaderView.m
//   Example
//
//  Created by Alena Belyaeva on 11/3/18.
//  Copyright © 2018 . All rights reserved.
//

#import "APTProductsListHeaderView.h"

static CGFloat const LineWidth = 1.0;

@interface APTProductsListHeaderView()

@property (nonatomic, strong) CALayer *topLineLayer;
@property (nonatomic, strong) CALayer *bottomLineLayer;
@property (nonatomic, strong) CALayer *centerLineLayer;

@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation APTProductsListHeaderView

#pragma mark - LifeCycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self configureLayers];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configureLayers];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateFrameLayers];
}

#pragma mark - Private

- (void)configureLayers {
    CGFloat const lineWidth = LineWidth / [UIScreen mainScreen].scale;
  
    self.lineColor = [[UIColor blackColor] colorWithAlphaComponent:0.16f];
    
    self.topLineLayer = [CALayer layer];
    self.topLineLayer.frame = CGRectMake(0, 0, self.bounds.size.width, lineWidth);
    self.topLineLayer.backgroundColor = self.lineColor.CGColor;
    [self.layer addSublayer:self.topLineLayer];
    
    self.bottomLineLayer = [CALayer layer];
    self.bottomLineLayer.frame = CGRectMake(0, self.bounds.size.height - lineWidth, self.bounds.size.width, lineWidth);
    self.bottomLineLayer.backgroundColor = self.lineColor.CGColor;
    [self.layer addSublayer:self.bottomLineLayer];
    
    self.centerLineLayer = [CALayer layer];
    self.centerLineLayer.frame = CGRectMake((self.bounds.size.width + lineWidth ) / 2.0f , 0, lineWidth, self.bounds.size.height);
    self.centerLineLayer.backgroundColor = self.lineColor.CGColor;
    [self.layer addSublayer:self.centerLineLayer];
}

- (void)updateFrameLayers {
    CGFloat const lineWidth = LineWidth / [UIScreen mainScreen].scale;

    self.topLineLayer.frame = CGRectMake(0, 0, self.bounds.size.width, lineWidth);
    self.bottomLineLayer.frame = CGRectMake(0, self.bounds.size.height - lineWidth, self.bounds.size.width, lineWidth);
    self.centerLineLayer.frame = CGRectMake((self.bounds.size.width + lineWidth ) / 2.0f , 0, lineWidth, self.bounds.size.height);
}

@end
