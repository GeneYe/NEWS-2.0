//
//  MeunViewController.h
//  NEWS
//
//  Created by Gene_Ye on 2016/10/31.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBottomView.h"

@protocol MeunViewControllerDelegate <NSObject>

@end

@interface MeunViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *themeViewControllersArray;

@property (nonatomic,assign)BOOL isDark;

@property (nonatomic,strong)MenuBottomView *menuBottomView;

@end
