//
//  ChangeUserInformationViewController.m
//  金科任我行
//
//  Created by 冯学杰 on 16/2/17.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "ChangeUserInformationViewController.h"

@interface ChangeUserInformationViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    NSArray *xueyuans ;
    
    //学院选择pickerview 确定选择按钮 选择的学院名
    UIPickerView *piker;
    UIButton *selectBtn;
    NSString *xueYuanSelect;
    
}

@end

@implementation ChangeUserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [self uiInit];
}

//加载学院plist文件
-(void)xueYuanPlist{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[mainBundle pathForResource:@"xueYuan" ofType:@"plist"]];
    xueyuans = [dic allKeys];
}

//初始化UI
-(void)uiInit{
    self.nameTiShi.hidden = YES;//昵称长度提示框隐藏
    
    piker = [[UIPickerView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2-100, SCREEN_WIDTH-40, 200)];
    piker.dataSource=self;
    piker.delegate=self;
    piker.showsSelectionIndicator=YES;
    piker.backgroundColor = [UIColor grayColor];
    piker.alpha = .9;
    piker.hidden = YES;
    [self xueYuanPlist];
    [self.view addSubview: piker];
    
    selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40-50, piker.y-30, 50, 30)];
    selectBtn.hidden = YES;
    [selectBtn setTitle:@"确定" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(sureXueYuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - pickerview
-(void)sureXueYuan{
    
    [UIView animateWithDuration:0.3 animations:^{
        piker.hidden = YES;
        selectBtn.hidden = YES;
        [self.xueyuan setTitle:xueYuanSelect forState:UIControlStateNormal];
    }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    xueYuanSelect = xueyuans[row];
}
//一共多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}
//每列对应多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //2.返回当前列对应的行数
    return xueyuans.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    NSString *str = xueyuans[row];
    return str;
}

#pragma mark - Button事件

- (IBAction)backBtn:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)sureBtn:(id)sender {
}
- (IBAction)xueYuanBtn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        piker.hidden = NO;
        selectBtn.hidden = NO;
    }];
}

#pragma mark - textField
//限制字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.nicheng == textField)
    {
        if ([toBeString length] > 12) {
            textField.text = [toBeString substringToIndex:13];
            self.nameTiShi.hidden = NO;
            return NO;
            
        }else{
            self.nameTiShi.hidden = YES;
        }
    }
    
    if (self.nianling == textField)
    {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:3];
            
            return NO;
            
        }else{
            
        }
    }
    
    return YES;
}
//判断文字长度
-  (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return (strlength+1)/2;
    
}

@end
