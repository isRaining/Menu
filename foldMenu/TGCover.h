//
//  TGCover.h
//  美团练习1
//
//  Created by app26 on 14-7-28.
//  Copyright (c) 2014年 app26. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGCover : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;
@end
