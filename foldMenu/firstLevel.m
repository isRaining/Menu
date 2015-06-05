//
//  firstLevel.m
//  foldMenu
//
//  Created by Code on 15/6/4.
//  Copyright (c) 2015年 Code. All rights reserved.
//

#import "firstLevel.h"
#import "UIImage+MJ.h"
#define buttonWidht [UIScreen mainScreen].bounds.size.width/3
#define buttonHeight 40

@implementation firstLevel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 1.文字颜色
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    // 2.设置箭头
    [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeCenter;
    
    //        [level setBackgroundColor:[UIColor purpleColor]];
    
    // 3.右边的分割线
    UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
    UIImageView *divider = [[UIImageView alloc] initWithImage:img];
    divider.bounds = CGRectMake(0, 0, 2, buttonHeight * 0.7);
    divider.center = CGPointMake(buttonWidht, buttonHeight * 0.5);
    [self addSubview:divider];
    
    // 4.选中时的背景  图片会被拉伸
    [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
}

@end
