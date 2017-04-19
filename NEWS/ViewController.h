//
//  ViewController.h
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MeunViewController.h"
#import "Theme_RootViewController.h"

@interface ViewController : UIViewController


- (instancetype)initWithHomeViewController:(HomeViewController *)homeViewController
                        MenuViewController:(MeunViewController *)menuViewController;


@end

