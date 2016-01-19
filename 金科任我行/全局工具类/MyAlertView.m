//
//  MyAlertView.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/19.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView


-(void)myAlertView:(UIView*)bgView meg:(NSString*)meg{
    
    self.alertView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-70, SCREEN_HEIGHT/2-15, 140, 30)];
    self.alertView .backgroundColor = [UIColor blackColor];
    self.alertView .hidden = NO;
    [bgView addSubview:self.alertView ];
    
    
    UILabel *megLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 30)];
    megLabel.textAlignment = NSTextAlignmentCenter;
    megLabel.textColor = [UIColor whiteColor];
    megLabel.font = [LCFont systemFontOfSize:12];
    megLabel.text = meg;
    [self.alertView  addSubview:megLabel];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(xiaoShi:) userInfo:nil repeats:NO];
    
}
-(void)xiaoShi:(id)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.alertView.hidden = YES;
    }];
    [sender invalidate];
    
}
@end
