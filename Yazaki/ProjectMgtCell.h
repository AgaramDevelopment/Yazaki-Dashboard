//
//  ProjectMgtCell.h
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectMgtCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel * lbl_projectcode;
@property (nonatomic,strong) IBOutlet UILabel * lbl_projectname;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Customercode;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Startdate;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Enddate;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Totaltask;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Completedtask;
@property (nonatomic,strong) IBOutlet UILabel * lbl_Pendingtask;

@end
