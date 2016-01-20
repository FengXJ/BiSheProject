//
//  registerController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/18.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "registerController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegisterTwoController.h"

@interface registerController ()<UITextFieldDelegate>{
    MyAlertView *alertView ;
}

@property(assign, nonatomic) NSInteger timeCount;//倒计时

@property(strong, nonatomic) NSTimer *timer;//计时器

@end

@implementation registerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    self.sureBtn.enabled = NO;
    [self.sureBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    //验证码按钮可用时的颜色
    [self.yanZhengBtn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    
    alertView = [[MyAlertView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)yanZhengMaBtn:(UIButton *)sender {
    if (self.phoneNumTextField.text.length == 11) {
        sender.enabled = NO;
        self.timeCount = 60;
        [self getCode];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        
    }else{
        [alertView myAlertView:self.view meg:@"请输入正确的手机号码"];
    }

}

-(void)getCode{
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
                                         [alertView myAlertView:self.view meg:@"获取验证码失败"];
                                     }
                                     
                                 }];
}
//验证码按钮倒计时
- (void)reduceTime:(NSTimer *)codeTimer {
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.yanZhengBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.yanZhengBtn setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        self.yanZhengBtn.enabled = YES;
        [self.timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
        [self.yanZhengBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.yanZhengBtn setTitle:str forState:UIControlStateNormal];
        self.yanZhengBtn.enabled = NO;
        
    }
}
- (IBAction)sureBtn:(id)sender {
    if (self.phoneNumTextField.text.length != 11 ) {
       //提示框 请输入正确的手机号
        [alertView myAlertView:self.view meg:@"请输入正确的手机号"];
    }else{
        if (self.yanZhengNumTextField.text.length != 4 ){
            //提示框，请输入正确的验证码
            [alertView myAlertView:self.view meg:@"请输入正确的验证码"];
        }else{
            
            
            
            //进入下一页面
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            RegisterTwoController *registerTwoVC = [[RegisterTwoController alloc]init];
            registerTwoVC = [storyBoard instantiateViewControllerWithIdentifier:@"registerTwo"];
            //翻转效果
            [registerTwoVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            
            //传递电话号码
            registerTwoVC.phoneNumStr = self.phoneNumTextField.text;
            [self presentViewController:registerTwoVC animated: YES completion:nil];
            //暂时注销，方便测试
//            
//            [SMSSDK commitVerificationCode:self.yanZhengNumTextField.text phoneNumber:self.phoneNumTextField.text zone:@"86" result:^(NSError *error) {
//                
//                if (!error) {
//                    NSLog(@"验证成功");
//                    //进入下一页面
//                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    RegisterTwoController *registerTwoVC = [[RegisterTwoController alloc]init];
//                    registerTwoVC = [storyBoard instantiateViewControllerWithIdentifier:@"registerTwo"];
//                    //翻转效果
//                    [registerTwoVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                    
//                    //传递电话号码
//                    registerTwoVC.phoneNumStr = self.phoneNumTextField.text;
//                    [self presentViewController:registerTwoVC animated: YES completion:nil];
//                }
//                else
//                {
//                    NSLog(@"错误信息:%@",error);
//                    //弹出提示框 输入信息错误
//                    [alertView myAlertView:self.view meg:@"输入信息错误"];
//                }
//            }];
        }
    }
    
 
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL flag = YES;
    if(textField == self.phoneNumTextField){
        
        if (textField.text.length >= 11 && string.length > range.length) {
            flag = NO;
        }else{
            flag = YES;
        }
        if (textField.text.length == 11) {
            
        }
    }
    if(textField == self.yanZhengNumTextField){
        
        if (textField.text.length >= 4 && string.length > range.length) {
            flag = NO;
        }
        else{
        flag = YES;
        }
    }
    
    if (self.phoneNumTextField.text.length > 1 && self.yanZhengNumTextField.text.length > 1) {
        [self.sureBtn setBackgroundColor:LCHexColor(0xf6b725)];
        self.sureBtn.enabled = YES;
        
    } else {
        if (string.length > 1) {
            [self.sureBtn setBackgroundColor:LCHexColor(0xf6b725)];
            self.sureBtn.enabled = YES;
            
        }else{
            [self.sureBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
            self.sureBtn.enabled = NO;
        }
    }

    return flag;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{

    self.sureBtn.enabled = NO;
    [self.sureBtn setBackgroundColor:LCHexColor(0xf6e4c5)];

    return YES;
}

@end
