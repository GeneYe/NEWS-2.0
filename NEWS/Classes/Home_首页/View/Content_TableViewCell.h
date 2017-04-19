//
//  Content_TableViewCell.h
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Content_Model.h"
#import <UIImageView+WebCache.h>

@interface Content_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *title_image;

@property (weak, nonatomic) IBOutlet UILabel *title_Label;

@property (nonatomic,strong)UIColor *cellBackgroundColor;

+ (instancetype)createTitleAndImageCellWithTableView:(UITableView *)tableView Model:(Content_Model *)model;

@end
