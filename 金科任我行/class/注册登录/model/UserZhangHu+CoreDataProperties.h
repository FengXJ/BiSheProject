//
//  UserZhangHu+CoreDataProperties.h
//  金科任我行
//
//  Created by 冯学杰 on 16/1/20.
//  Copyright © 2016年 冯学杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserZhangHu.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserZhangHu (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *nicheng;
@property (nullable, nonatomic, retain) NSString *pwd;
@property (nullable, nonatomic, retain) NSString *qianming;
@property (nullable, nonatomic, retain) NSString *save;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSString *touxiang;
@property (nullable, nonatomic, retain) NSString *xueyuan;

@end

NS_ASSUME_NONNULL_END
