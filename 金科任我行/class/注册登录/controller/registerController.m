//
//  registerController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/18.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "registerController.h"
#import <SMS_SDK/SMSSDK.h>

@interface registerController ()<UITextFieldDelegate>

@end

@implementation registerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)yanZhengMaBtn:(id)sender {

    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTextField.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                     
                                     }];
}

- (IBAction)sureBtn:(id)sender {
 
    [SMSSDK commitVerificationCode:self.yanZhengNumTextField.text phoneNumber:self.phoneNumTextField.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
        }
        else
        {
            NSLog(@"错误信息:%@",error);
        }
    }];
    
}
@end
