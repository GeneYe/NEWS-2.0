//
//  MenuThemeListHomeTitleTableViewCell.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeTitle_Model.h"

@interface MenuThemeListHomeTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuListThemeHomeTitle;


+ (instancetype)createMenuThemeListHomeTitleWithTableView:(UITableView *)tableView Model:(ThemeTitle_Model *)model;


@end
