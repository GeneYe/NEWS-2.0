//
//  MenuThemeTitleListTableViewCell.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/10.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeTitle_Model.h"

@interface MenuThemeTitleListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *MenuThemeListTitle;

+ (instancetype)createMeunThemeListExceptHomeWithTableView:(UITableView *)tableView Model:(ThemeTitle_Model *)model;

@end
