//
//  OnlyTextTableViewCell.h
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes_Model.h"

@interface OnlyTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)createOnlyTextTableViewCellWithTableView:(UITableView *)tableView Model:(Themes_Model *)model;

@end
