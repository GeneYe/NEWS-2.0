//
//  ViewController.m
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (instancetype)initWithHomeViewController:(HomeViewController *)homeViewController MenuViewController:(MeunViewController *)menuViewController{
    
    if (self = [super init]) {
        //抽屉菜单视图控制器
        [self addChildViewController:menuViewController];
        menuViewController.view.frame = CGRectMake(-Menu_Width, 0, Menu_Width, Screen_Height);
        [self.view addSubview:menuViewController.view];
        
        //主页视图控制器
        UINavigationController *home_NavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
        home_NavigationController.view.frame = [UIScreen mainScreen].bounds;
        home_NavigationController.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:home_NavigationController];
        [self.view addSubview:home_NavigationController.view];
        
        //抽屉菜单基础视图控制管理器
//        [self addChildViewController:theme_RootViewConroller];
//        theme_RootViewConroller.view.frame = [UIScreen mainScreen].bounds;
        
//        UINavigationController *theme_NavigationController = [[UINavigationController alloc] initWithRootViewController:Theme_RootViewConroller];
//        
//        theme_NavigationController.view.frame = [UIScreen mainScreen].bounds;
//        theme_NavigationController.view.backgroundColor = [UIColor whiteColor];
//        [self addChildViewController:theme_NavigationController];

    }
    
    return self;
}



















@end
