//
//  LoginController.h
//  金科任我行
//
//  Created by 冯学杰 on 16/1/18.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMTabBarController.h"


@interface LoginController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *findPwdBtn;

@property (weak, nonatomic) IBOutlet UIButton *weiboLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *weixinLoginBtn;

@property (nonatomic, strong) XMTabBarController * tabBar;

@property (strong, nonatomic) UIWindow *window;

@end
