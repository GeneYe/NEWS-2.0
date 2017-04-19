//
//  MenuTopView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/7.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "MenuTopView.h"

@implementation MenuTopView

+ (instancetype)createMenuTopViewWithFrame:(CGRect)frame{
    
    MenuTopView *menuTopView = [[[NSBundle mainBundle] loadNibNamed:@"MenuTopView" owner:nil options:nil] objectAtIndex:0];
    
    menuTopView.frame = frame;
    
    menuTopView.userHeaderImageView.layer.cornerRadius = 18;
    menuTopView.userHeaderImageView.layer.masksToBounds = YES;
    
    [menuTopView.longinButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    [menuTopView.collectionButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    [menuTopView.messageButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    [menuTopView.configButton setTitleColor:GYFontColor forState:UIControlStateNormal];
    
    return menuTopView;
}

- (IBAction)clickUserHeaderButton:(UIButton *)sender {
}
- (IBAction)clickLoginButton:(UIButton *)sender {
}
- (IBAction)clickCollectionButton:(UIButton *)sender {
}
- (IBAction)clickMessageButton:(UIButton *)sender {
}
- (IBAction)clickConfigButton:(UIButton *)sender {
}

@end
