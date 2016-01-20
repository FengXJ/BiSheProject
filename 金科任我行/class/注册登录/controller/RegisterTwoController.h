//
//  RegisterTwoController.h
//  金科任我行
//
//  Created by 冯学杰 on 16/1/20.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTwoController : UIViewController

@property(nonatomic,copy) NSString *phoneNumStr;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdAgainText;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UITextField *saveTextField;

@end
