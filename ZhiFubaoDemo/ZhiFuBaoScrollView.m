//
//  ZhiFuBaoScrollView.m
//  ZhiFubaoDemo
//
//  Created by 王金东 on 2017/7/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ZhiFuBaoScrollView.h"

@implementation ZhiFuBaoScrollView{
    BOOL _add;
    CGPoint _contentOffset;
    CGPoint _startPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    
    if(!_add){
        self.delegate = (id)self;
    
        CGRect headFrame = self.headView.frame;
        headFrame.size.width = self.frame.size.width;
        self.headView.frame = headFrame;
        [self addSubview:self.headView];
        
        CGRect contentFrame = self.headView.frame;
        contentFrame.origin.y = headFrame.size.height;
        contentFrame.size.width = self.frame.size.width;
        contentFrame.size.height = self.frame.size.height * 5 - self.headView.frame.size.height;
        self.contentView.frame = contentFrame;
        self.contentView.clipsToBounds = NO;
        //self.contentView.scrollEnabled = NO;
        [self addSubview:self.contentView];
        
        self.contentSize = CGSizeMake(0, self.frame.size.height * 5);
        self.scrollIndicatorInsets = UIEdgeInsetsMake(self.headView.frame.size.height, 0, 0, 0);
        
        //[self.contentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
   
        
       
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    if (y <= 0) {
        CGRect newFrame = self.headView.frame;
        newFrame.origin.y = y;
        self.headView.frame = newFrame;
        
        newFrame = self.contentView.frame;
        newFrame.origin.y = y + self.headView.frame.size.height;
        self.contentView.frame = newFrame;
        
        //偏移量给到tableview，tableview自己来滑动
        CGPoint offset = self.contentView.contentOffset;
        offset.y = y;
        self.contentView.contentOffset = offset;
        
        //滑动太快有时候不正确，这里是保护imageView 的frame为正确的。
        //newFrame = self.imageView.frame;
        //newFrame.origin.y = 0;
        //self.imageView.frame = newFrame;
    } else {
        //视差处理
        //CGRect newFrame = self.imageView.frame;
        //newFrame.origin.y = y/2;
        //self.imageView.frame = newFrame;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 松手时判断是否刷新
    CGFloat y = scrollView.contentOffset.y;
    if (y < - 65) {
        //[self.tableView startRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[self.tableView endRefreshing];
        });
    }
}


#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    CGFloat offsetY = self.contentView.contentOffset.y;
    if(offsetY < 0) offsetY = 0;
    
    CGRect headFrame = self.headView.frame;
    headFrame.origin.y = -offsetY;
    self.headView.frame = headFrame;
    
}
@end
