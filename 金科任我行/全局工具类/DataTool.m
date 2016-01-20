//
//  dataTool.m
//  金科任我行
//
//  Created by 冯学杰 on 16/1/20.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "DataTool.h"
#import "AppDelegate.h"

@implementation DataTool
+(NSArray *)selectModel:(NSString *)model request:(NSString *)requestStr{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:model inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    [request setPredicate: [NSPredicate predicateWithFormat:requestStr]];
    NSError *error2 = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
    
    return result;
    
}
@end
