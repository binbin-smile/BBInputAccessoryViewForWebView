//
//  UIWebView+InputAccessoryView.h
//  AAA
//
//  Created by yibin on 2017/3/31.
//  Copyright © 2017年 yibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (InputAccessoryView)

@property(nonatomic, strong) UIView *accessoryView;
- (void)reloadCustomedInputViews;

@end
