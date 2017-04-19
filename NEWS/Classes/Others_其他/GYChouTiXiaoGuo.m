//
//  GYChouTiXiaoGuo.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/13.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "GYChouTiXiaoGuo.h"

@implementation GYChouTiXiaoGuo

+ (void)chouTiHideWithChouTiView:(UIView *)chouTiView homeView:(UIView *)homeView{
    
    [UIView animateWithDuration:0.3 animations:^{

        chouTiView.RL_x = -Menu_Width;
        homeView.RL_x = 0;
    }];
}

+ (void)chouTiAppearWithChouTiView:(UIView *)chouTiView homeView:(UIView *)homeView{
    [UIView animateWithDuration:0.3 animations:^{

        chouTiView.RL_x = 0;
        homeView.RL_x = Menu_Width;
    }];
}

@end
