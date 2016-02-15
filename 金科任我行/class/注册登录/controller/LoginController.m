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
#import "UserInformationViewController.h"

#import "UMComUMengLoginHandler.h"
#import "UMComUserAccount.h"
#import "UMComPushRequest.h"




@interface LoginController ()<UITextFieldDelegate,LoginSuccesEnterHome>{
    MyAlertView *alertView;
}

@property (strong,nonatomic)NSString *userLoginStr;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.jpg"]];
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    //验证码按钮可用时的颜色
    
    alertView = [[MyAlertView alloc]init];
    [self enterHomeVC];
//    [self isLogin];
}
-(void)isLogin{
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    NSString *userStr = [ userLogin objectForKey:@"userLogin"];
    if (userStr != nil) {
        UMComLoginManager *uMComLoginManager = [[UMComLoginManager alloc]init];
        uMComLoginManager.loginSuccesEnterHomeDelgate = self;
        //登录微社区
        [self weiSheQuFromUserDefaults];
    }
    
    
}

-(void)LoginSuccesEnterHomeVC{
    [self enterHomeVC];
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
     [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //判断coredata里数据帐号密码是否正确
    NSArray *resultArr = [DataTool selectModel:@"UserZhangHu" request:[NSString stringWithFormat:@"name = '%@' AND pwd = '%@'",self.userNameTextField.text,self.pwdTextField.text]];
    if (resultArr.count != 0) {
            //登录微社区
            [self weiSheQu];
            //记录已登录信息
            [self saveUserLoginMeg];
            //这里应该延迟
            [self enterHomeVC];
    }else{
        //用户名或密码错误
        [alertView myAlertView:self.view meg:@"用户名或密码错误"];
    }
    
    
}

-(void)enterHomeVC{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_nor.png"],[UIImage imageNamed:@"tab_me_nor.png"],[UIImage imageNamed:@"tab_qworld_nor.png"],[UIImage imageNamed:@"tab_recent_nor.png"], nil];
    NSMutableArray * selectedArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"tab_buddy_press.png"],[UIImage imageNamed:@"tab_me_press.png"],[UIImage imageNamed:@"tab_qworld_press.png"],[UIImage imageNamed:@"tab_recent_press.png"], nil];
    NSMutableArray * titles = [[NSMutableArray alloc]initWithObjects:@"首页",@"消息",@"发现",@"个人", nil];
    
    
    HomeController * vc1 = [[HomeController alloc]init];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UserInformationViewController *vc4 = [[UserInformationViewController alloc]init];
    vc4 = [storyBoard instantiateViewControllerWithIdentifier:@"userInformationVC"];

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
    self.tabBar.viewControllers = @[vc1,vc4];
    self.tabBar.textColor = [UIColor redColor];
    [self.tabBar tabBarBadgeValue:345 item:2];
    [self.tabBar tabBarBadgeValue:3 item:1];
    
    //    self.tabBar.xm_centerViewController = [[XMTestViewController alloc] init];
    self.window.rootViewController = self.tabBar;
    [self.window makeKeyAndVisible];
}
//用NSUserDefaults存储已登录用户名
-(void)saveUserLoginMeg{
    //将NSString 对象存储到 NSUserDefaults 中
    NSString *userLoginStr = self.userNameTextField.text;
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    [userLogin setObject:userLoginStr forKey:@"userLogin"];
}



//登录微社区
-(void)weiSheQu{
//    UMComUserAccount *userAccount = [[UMComUserAccount alloc] initWithSnsType:UMComSnsTypeSelfAccount];     //使用UMComSnsTypeSelfAccount代表自定义登录，该枚举类型必须和安卓SDK保持一致，否则会出现不能对应同一用户的问题
//    userAccount.usid = self.userNameTextField.text;//必填
//    userAccount.name = self.userNameTextField.text;//必填
//    userAccount.icon_url = nil; //登录用户头像
//    // 将数据传递给友盟微社区SDK
//    
//    [UMComLoginManager loginWithLoginViewController:self userAccount:userAccount];//self表示当前登录页面
    UMComLoginManager *uMComLoginManager =[[UMComLoginManager alloc]init];
    [uMComLoginManager loginWeiShequId:self.userNameTextField.text];
}

//从UserDefaults读取已登录用户信息 登录微社区
-(void)weiSheQuFromUserDefaults{
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    self.userLoginStr = [ userLogin objectForKey:@"userLogin"];
    
    UMComLoginManager *uMComLoginManager =[[UMComLoginManager alloc]init];
    [uMComLoginManager loginWeiShequId:self.userLoginStr];

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
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:LCHexColor(0xf6e4c5)];
    
    return YES;
}
@end
