//
//  GiftVCViewController.h
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftVCViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSString * selectType;
@property (nonatomic,strong) NSString *Tittle;


@property (strong, nonatomic) IBOutlet UILabel *validFrom_lbl;
@property (strong, nonatomic) IBOutlet UILabel *validTo_lbl;
- (IBAction)selectPuropose_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *select_purpose_lbl;
@property (strong, nonatomic) IBOutlet UIButton *green_outelet_tbtn;
- (IBAction)Green_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *display_greenCountValue_lbl;
@property (strong, nonatomic) IBOutlet UITableView *tablview;
@end
