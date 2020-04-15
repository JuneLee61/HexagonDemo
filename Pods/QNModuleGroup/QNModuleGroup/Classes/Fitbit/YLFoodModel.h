//
//  YLFoodModel.h
//  QNModuleGroup_healthKit
//
//  Created by JuneLee on 2019/7/23.
//  Copyright © 2019 service@qnniu.com. All rights reserved.
//  食物数据模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// fitbit的膳食类型： Meal type. 1=Breakfast; 2=Morning Snack; 3=Lunch; 4=Afternoon Snack; 5=Dinner; 7=Anytime.
// 为了数值对应，特定类型的值
typedef NS_ENUM(NSUInteger, YLMealType) {
    YLMealTypeBreakfast = 1,//早餐
    YLMealTypeLunch = 3,    //午餐
    YLMealTypeDinner = 5,   //晚餐
    YLMealTypeSnacks = 7,   //小食
};

@interface YLFoodModel : NSObject
/** 时间(格式:yyyy-MM-dd) */
@property (nonatomic, strong) NSString *date;
/** 食物名字 */
@property (nonatomic, strong) NSString *foodName;
/** 饮食类型 */
@property (nonatomic, assign) YLMealType mealType;
/** 卡路里 */
@property (nonatomic, assign) int calories;
/** 碳水化合物 */
@property (nonatomic, assign) int carbs;
/** 脂肪 */
@property (nonatomic, assign) float fat;
/** 蛋白质 */
@property (nonatomic, assign) int protein;
/** 膳食纤维 */
@property (nonatomic, assign) int fiber;
/** 钠 */
@property (nonatomic, assign) int sodium;

@end

NS_ASSUME_NONNULL_END
