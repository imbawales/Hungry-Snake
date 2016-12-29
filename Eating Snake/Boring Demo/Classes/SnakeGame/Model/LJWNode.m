//
//  LJWNode.m
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import "LJWNode.h"

@implementation LJWNode

+(instancetype)nodeWithCenterPoint:(CGPoint) centerPoint{
 
    LJWNode *node = [[LJWNode alloc] init];
    node.centerPoint = centerPoint;
    return node;
}

@end
