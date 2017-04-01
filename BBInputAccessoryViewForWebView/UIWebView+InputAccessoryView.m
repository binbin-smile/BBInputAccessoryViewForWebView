//
//  UIWebView+InputAccessoryView.m
//  AAA
//
//  Created by yibin on 2017/3/31.
//  Copyright © 2017年 yibin. All rights reserved.
//

#import "UIWebView+InputAccessoryView.h"

#import <objc/runtime.h>

static const char * const accessoryViewClassName = "UIWebBrowserViewMinusAccessoryView";
static Class hackedWebViewAccessoryViewClass = Nil;
static void *accessoryViewKey = &accessoryViewKey;

@implementation UIWebView (InputAccessoryView)

#pragma mark - Associated Object

- (void)setAccessoryView:(UIView *)accessoryView
{
    objc_setAssociatedObject(self, &accessoryViewKey, accessoryView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)accessoryView
{
    return objc_getAssociatedObject(self, &accessoryViewKey);
}

- (void)reloadCustomedInputViews
{
    UIView *browserView = nil;
    for (UIView *view in self.scrollView.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UIWebBrowserView"]) {
            browserView = view;
        }
    }
    if (!hackedWebViewAccessoryViewClass) {
        hackedWebViewAccessoryViewClass = objc_duplicateClass([browserView class], accessoryViewClassName, 0);
        id accessoryViewBlock = ^{
            return self.accessoryView;
        };
        IMP accessoryViewImp = imp_implementationWithBlock(accessoryViewBlock);
        class_replaceMethod(hackedWebViewAccessoryViewClass, @selector(inputAccessoryView), accessoryViewImp, "@@:");
        objc_registerClassPair(hackedWebViewAccessoryViewClass);
    }
    object_setClass(browserView, hackedWebViewAccessoryViewClass);
    [browserView reloadInputViews];
}

@end
