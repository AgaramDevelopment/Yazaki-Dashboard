//
//  HOMEVC.m
//  Yazaki
//
//  Created by apple on 3/22/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "HOMEVC.h"
#import "PieChartTest.h"
#import "NOTOKPiechartVC.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
@interface HOMEVC ()
{
    CustomNavigationVC *objCustomNavigation;
}
@property (nonatomic,strong) NSMutableArray *ResultHolderArray;
@property (nonatomic,strong) NSDictionary *myslot;
@end

@implementation HOMEVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    datepicker=[[UIDatePicker alloc]init];
    datepicker1=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker1.datePickerMode=UIDatePickerModeDate;
    
    [self.Fromdate_txt setInputView:datepicker];
    [self.Todate_txt setInputView:datepicker1];
    
    UIToolbar *toolbar =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.Fromdate_txt setInputAccessoryView:toolbar];
    
    //Another Dte Picker Tool for Toate Picker
    UIToolbar *toolbar1 =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar1 setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate1)];
    UIBarButtonItem *space1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar1 setItems:[NSArray arrayWithObjects:space1,doneBtn1, nil]];
    [self.Todate_txt setInputAccessoryView:toolbar1];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [NSDate date];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYY-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:now];
    self.Fromdate_txt.text=[NSString stringWithFormat:@"%@",formattedDate];
    
    self.Todate_txt.text=[NSString stringWithFormat:@"%@",formattedDate];
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    
    NSString *baseURL = [NSString stringWithFormat:@"http://192.168.1.49:8097/YazakiService.svc/INITIALIZE/%@/%@",userUpdate,userUpdate1];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {

    NSMutableArray *ResultHolderArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *myslot=[ResultHolderArray objectAtIndex:0];
    NSDictionary *myslot1=[ResultHolderArray objectAtIndex:1];
    self.Ok_lbl.text=[myslot valueForKey:@"NAME"];
    self.notOk_lbl.text=[myslot1 valueForKey:@"NAME"];
    self.CountValues_Green_lbl.text=[myslot valueForKey:@"COUNTVALUE"];
    self.CountValues_Red_lbl.text=[myslot1 valueForKey:@"COUNTVALUE"];
    }
    
    
    
    else{
        //handle received data
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    
}

-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}


-(void) ShowSelectedDate
{  NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    self.Fromdate_txt.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];
    [self.Fromdate_txt resignFirstResponder];
    
    
}

-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"";
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
     [objCustomNavigation.Home_Btn addTarget:self action:@selector(Home_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
}



-(IBAction)Home_Btn:(id)sender
{
    DashboardVC *initView = [[DashboardVC alloc]init];
    initView =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
    [self.navigationController pushViewController:initView animated:YES];
}

//Another Dte Picker Tool for Todate Picker
-(void) ShowSelectedDate1
{  NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"YYY-MM-dd"];
    self.Todate_txt.text=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datepicker1.date]];
    [self.Todate_txt resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generate_btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    NSString *baseURL = [NSString stringWithFormat:@"http://182.74.23.195:8094/YazakiService.svc/INITIALIZE/%@/%@",userUpdate,userUpdate1];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {

    NSMutableArray *ResultHolderArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *myslot=[ResultHolderArray objectAtIndex:0];
    NSDictionary *myslot1=[ResultHolderArray objectAtIndex:1];
    NSString *OKStatus=[myslot valueForKey:@"NAME"];
    self.Ok_lbl.text=OKStatus;
    self.notOk_lbl.text=[myslot1 valueForKey:@"NAME"];
    self.CountValues_Green_lbl.text=[myslot valueForKey:@"COUNTVALUE"];
    self.CountValues_Red_lbl.text=[myslot1 valueForKey:@"COUNTVALUE"];
    
    }
    
    else{
        //handle received data
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    
}



- (IBAction)Clear_btn:(id)sender {
    [self viewDidLoad];
}
- (IBAction)green_btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    
    NSString *test =[NSString stringWithFormat:@"%@",[self.Ok_lbl text]];
    initView.dictObject = test;
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:initView animated:NO completion:nil];
}

- (IBAction)red_btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NOTOKPiechartVC *initView =  (NOTOKPiechartVC*)[storyboard instantiateViewControllerWithIdentifier:@"NOTOKPIE"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    
    NSString *test =[NSString stringWithFormat:@"%@",[self.notOk_lbl text]];
    initView.dictObject = test;
    
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:initView animated:NO completion:nil];
    
}

@end
