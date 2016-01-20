//
//  RegisterTwoController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/20.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "RegisterTwoController.h"

@interface RegisterTwoController ()<UITextFieldDelegate>{
    MyAlertView *alertView ;
}


@end

@implementation RegisterTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    self.sureBtn.enabled = NO;
    [self.sureBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    alertView = [[MyAlertView alloc]init];
    
    self.pwdAgainText.delegate = self;
    self.pwdTextField.delegate = self;
    self.userNameTextField.delegate = self;
    self.saveTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
     [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)sureBtn:(id)sender {
    //两次密码不一致
    if (![self.pwdTextField.text isEqual: self.pwdAgainText.text]) {
        [alertView myAlertView:self.view meg:@"两次密码不一致"];
    }else{
        //存储用户信息
        
    }
}
//限制输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.userNameTextField.text.length > 1 && self.pwdTextField.text.length > 1 && self.pwdAgainText.text.length > 1 && self.saveTextField.text.length > 1) {
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
    
    if(textField == self.pwdTextField||textField == self.pwdAgainText){
        
        if (textField.text.length >= 16 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }
    if(textField == self.userNameTextField||textField == self.saveTextField ){
        
        if (textField.text.length >= 10 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }
   
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField == self.pwdTextField ||textField == self.pwdAgainText){
        
        if (textField.markedTextRange == nil && textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    if(textField == self.userNameTextField){
        
        if (textField.markedTextRange == nil && textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.sureBtn.enabled = NO;
    [self.sureBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    
    return YES;
}
@end
