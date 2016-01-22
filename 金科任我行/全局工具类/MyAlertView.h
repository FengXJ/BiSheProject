//
//  MyAlertView.h
//  金科任我行
//
//  Created by 冯学杰 on 16/1/19.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView

@property (strong,nonatomic) UIView *alertView;
/**
 *  出现一个2S的View 用作提示
 *
 *  @param bgView 加入的背景View
 *  @param meg    提示信息
 */
-(void)myAlertView:(UIView*)bgView meg:(NSString*)meg;

@end
