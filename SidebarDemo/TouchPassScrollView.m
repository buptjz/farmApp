//
//  TouchPassScrollView.m
//  SidebarDemo
//
//  Created by WangJZ on 15/5/17.
//  Copyright (c) 2015年 AppCoda. All rights reserved.
//

#import "TouchPassScrollView.h"

@implementation TouchPassScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    NSLog(@"用户点击了scroll上的视图%@,是否开始滚动scroll",view);
    //返回yes 是不滚动 scroll 返回no 是滚动scroll
    return NO;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    
    NSLog(@"用户点击的视图 %@",view);
    
    //NO scroll不可以滚动 YES scroll可以滚动
    return NO;
}

@end
