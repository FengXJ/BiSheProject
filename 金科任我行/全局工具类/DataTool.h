//
//  dataTool.h
//  金科任我行
//
//  Created by 冯学杰 on 16/1/20.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject

//根据条件，查询model
+(NSArray *)selectModel:(NSString *)model request:(NSString *)requestStr;


@end
