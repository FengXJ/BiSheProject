//
//  LoginController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/18.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "LoginController.h"
#import "HomeController.h"
#import "registerController.h"

@interface LoginController ()<UITextFieldDelegate>{
    MyAlertView *alertView;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    //验证码按钮可用时的颜色
    
    alertView = [[MyAlertView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtn:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    registerController *registerVC = [[registerController alloc]init];
    registerVC = [storyBoard instantiateViewControllerWithIdentifier:@"register"];
    //翻转效果
    [registerVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:registerVC animated: YES completion:nil];
}

- (IBAction)loginBtn:(id)sender {
    [self enterHomeVC];
}

-(void)enterHomeVC{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_nor.png"],[UIImage imageNamed:@"tab_me_nor.png"],[UIImage imageNamed:@"tab_qworld_nor.png"],[UIImage imageNamed:@"tab_recent_nor.png"], nil];
    NSMutableArray * selectedArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_press.png"],[UIImage imageNamed:@"tab_me_press.png"],[UIImage imageNamed:@"tab_qworld_press.png"],[UIImage imageNamed:@"tab_recent_press.png"], nil];
    NSMutableArray * titles = [[NSMutableArray alloc]initWithObjects:@"首页",@"消息",@"发现",@"个人", nil];
    
    
    HomeController * vc1 = [[HomeController alloc]init];
    //    XMTwoViewController * vc2 = [[XMTwoViewController alloc]init];
    //    XMThreeViewController * vc3 = [[XMThreeViewController alloc]init];
    //    XMFourViewController * vc4 = [[XMFourViewController alloc]init];
    
    //    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    //    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    //
    //
    self.tabBar = [[XMTabBarController alloc]initWithTabBarSelectedImages:selectedArray normalImages:array titles:titles];
    self.tabBar.showCenterItem = YES;
    self.tabBar.centerItemImage = [UIImage imageNamed:@"btn_release.png"];
    //    self.tabBar.viewControllers = @[vc1,nav2,nav3,vc4];
    self.tabBar.viewControllers = @[vc1];
    self.tabBar.textColor = [UIColor redColor];
    [self.tabBar tabBarBadgeValue:345 item:2];
    [self.tabBar tabBarBadgeValue:3 item:1];
    
    //    self.tabBar.xm_centerViewController = [[XMTestViewController alloc] init];
    self.window.rootViewController = self.tabBar;
    [self.window makeKeyAndVisible];
}

//限制输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.userNameTextField.text.length > 1 && self.pwdTextField.text.length > 1) {
        [self.loginBtn setBackgroundColor:LCHexColor(0xf6b725)];
        self.loginBtn.enabled = YES;
        
    } else {
        if (string.length > 1) {
            [self.loginBtn setBackgroundColor:LCHexColor(0xf6b725)];
            self.loginBtn.enabled = YES;
            
        }else{
            [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
            self.loginBtn.enabled = NO;
        }
    }
    
    if(textField == self.userNameTextField||textField == self.pwdTextField){
        
        if (textField.text.length >= 16 && string.length > range.length) {
            return NO;
        }else{
            return YES;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField == self.pwdTextField ||textField == self.userNameTextField){
        
        if (textField.markedTextRange == nil && textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }

}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    
    return YES;
}
@end
