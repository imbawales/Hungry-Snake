//
//  LJWNode.h
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJWNode : NSObject

//中心点坐标
@property(nonatomic, assign)CGPoint centerPoint;

/*提供初始化方法*/
+(instancetype)nodeWithCenterPoint:(CGPoint) centerPoint;


@end
