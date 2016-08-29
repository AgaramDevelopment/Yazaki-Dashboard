//
//  ProductionDetailsVC.h
//  Yazaki
//
//  Created by Lexicon on 29/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionVC.h"

@interface ProductionDetailsVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSString *LineName;
@property(strong,nonatomic)NSString * PlantName;
@property(strong,nonatomic)NSString *lineCode;
@property(strong,nonatomic)NSString *PlantCode;
@property(strong,nonatomic)NSString *FromStr;
@property(strong,nonatomic)NSString * ToStr;
@property (strong, nonatomic) IBOutlet UILabel *PlantNameload;
@property (strong, nonatomic) IBOutlet UILabel *lineNameLoad;
@property (strong, nonatomic) IBOutlet UITableView *tablview;
@end
