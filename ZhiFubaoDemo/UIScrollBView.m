//
//  UIScrollBView.m
//  ZhiFubaoDemo
//
//  Created by 王金东 on 2017/7/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "UIScrollBView.h"

@implementation UIScrollBView{
    CGFloat _contentOffsetY;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return [super hitTest:point withEvent:event];
}


- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    self.contentOffset = CGPointMake(0, contentOffsetY);
}

@end
