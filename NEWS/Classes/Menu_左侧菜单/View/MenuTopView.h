//
//  MenuTopView.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/7.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UIButton *longinButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;

+ (instancetype)createMenuTopViewWithFrame:(CGRect)frame;

@end
