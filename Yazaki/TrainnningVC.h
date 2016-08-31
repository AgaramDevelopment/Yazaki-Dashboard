//
//  TrainnningVC.h
//  Yazaki
//
//  Created by Lexicon on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainnningVC : UIViewController
@property (strong,nonatomic) NSString * selectType;
@property (strong, nonatomic) IBOutlet UIButton *trainning_Outletbtn;
- (IBAction)traingTouch_btn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *traingDisplay_lbl;
@end
