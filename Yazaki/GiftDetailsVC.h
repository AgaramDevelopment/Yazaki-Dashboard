//
//  GiftDetailsVC.h
//  Yazaki
//
//  Created by Lexicon on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftDetailsVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString* categoryID;
@property (strong, nonatomic) NSString*GiftType;
@property (strong, nonatomic) NSString*categoryname;
@property (strong, nonatomic) IBOutlet UILabel *category_lbl;
@end
