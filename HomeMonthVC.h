//
//  HomeMonthVC.h
//  Yazaki
//
//  Created by apple on 3/23/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMonthVC : UIViewController

{
    UIDatePicker * datepicker;
    UIDatePicker * datepicker1;
}
@property (weak, nonatomic) IBOutlet UIView *FromMonth_view;
@property (weak, nonatomic) IBOutlet UIView *TomonthView;
@property (weak, nonatomic) IBOutlet UITextField *FromMonth_txt;
@property (weak, nonatomic) IBOutlet UITextField *Tomonth_txt;
- (IBAction)GenerateMonth_Btn:(id)sender;
- (IBAction)ClearMonth_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ok_lbl;
@property (weak, nonatomic) IBOutlet UILabel *notOk_lbl;

- (IBAction)red_Month_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *greenib_btn;
@property (weak, nonatomic) IBOutlet UIButton *redib_btn;
@property (weak, nonatomic) IBOutlet UILabel *CountValues_Green_lbl;

@property (weak, nonatomic) IBOutlet UILabel *CountValues_Red_lbl;
- (IBAction)Green_Month_btn:(id)sender;

@end
