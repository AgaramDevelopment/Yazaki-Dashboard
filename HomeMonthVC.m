//
//  HomeMonthVC.m
//  Yazaki
//
//  Created by apple on 3/23/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "HomeMonthVC.h"
#import "PieChartTest.h"
#import "NOTOKPiechartVC.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "Common.h"
@interface HomeMonthVC ()
{
    CustomNavigationVC *objCustomNavigation;
}
@property (nonatomic,strong) NSMutableArray *ResultHolderArray;
@end

@implementation HomeMonthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    datepicker=[[UIDatePicker alloc]init];
    datepicker1=[[UIDatePicker alloc]init];
    
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker1.datePickerMode=UIDatePickerModeDate;
    
    
    
    // [self.ok_lbl.text:datepicker];
    [self.FromMonth_txt setInputView:datepicker];
    [self.Tomonth_txt setInputView:datepicker1];
    
    UIToolbar *toolbar =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate)];
    
    UIBarButtonItem *space =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.FromMonth_txt setInputAccessoryView:toolbar];
    
    //Another Dte Picker Tool for Toate Picker
    UIToolbar *toolbar1 =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar1 setTintColor:[UIColor grayColor]];
    //  datepicker.backgroundColor=[UIColor blueColor];
    // toolbar.backgroundColor=[UIColor b];
    UIBarButtonItem *doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowSelectedDate1)];
    UIBarButtonItem *space1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar1 setItems:[NSArray arrayWithObjects:space1,doneBtn1, nil]];
    [self.Tomonth_txt setInputAccessoryView:toolbar1];
    
    //showing current Month
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [NSDate date];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM-YYY"];
    NSString *formattedDate = [dateFormatter stringFromDate:now];
    self.FromMonth_txt.text=[NSString stringWithFormat:@"%@",formattedDate];
    self.Tomonth_txt.text=[NSString stringWithFormat:@"%@",formattedDate];
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
    
    NSString *baseURL;
    if([self.selectType isEqualToString: @"Canteen"])
    {
      baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/''/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Production"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/BOXINITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Scrap"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Efficiency"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Quote Management"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/COSTINGINITIALIZE/%@/%@",BaseURL,self.selectType,@"",@""];
    }
    
    else if ([self.selectType isEqualToString: @"Training"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Gate Pass"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    else if ([self.selectType isEqualToString: @"Gift"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/GIFTINITIALIZE",BaseURL,self.selectType];
    }
    
    else if ([self.selectType isEqualToString: @"Project Management"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    else if ([self.selectType isEqualToString: @"Attendance"])
    {
        baseURL = [NSString stringWithFormat:@"%@/%@/INITIALIZE/%@/%@",BaseURL,self.selectType,userUpdate,userUpdate1];
    }
    
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
 
    NSMutableArray *ResultHolderArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *myslot=[ResultHolderArray objectAtIndex:0];
    NSDictionary *myslot1=[ResultHolderArray objectAtIndex:1];
    
    self.ok_lbl.text=[myslot valueForKey:@"NAME"];
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
    [formatter setDateFormat:@"MM-YYY"];
    self.FromMonth_txt.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datepicker.date]];
    [self.FromMonth_txt resignFirstResponder];
}

//Another Dte Picker Tool for Toate Picker
-(void) ShowSelectedDate1
{  NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"MM-YYY"];
    self.Tomonth_txt.text=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datepicker1.date]];
    [self.Tomonth_txt resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)GenerateMonth_Btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
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
    
    self.ok_lbl.text=[myslot valueForKey:@"NAME"];
    self.notOk_lbl.text=[myslot1 valueForKey:@"NAME"];
    
    self.CountValues_Green_lbl.text=[myslot valueForKey:@"COUNTVALUE"];
    self.CountValues_Red_lbl.text=[myslot1 valueForKey:@"COUNTVALUE"];
    }
    
    else{
        //handle received data

            //handle received data
            [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
       
    }

}



- (IBAction)ClearMonth_btn:(id)sender {
    [self viewDidLoad];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"";
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
      [objCustomNavigation.Home_Btn addTarget:self action:@selector(Home_Btn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)Home_Btn:(id)sender
{
DashboardVC *initView = [[DashboardVC alloc]init];
initView =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
[self.navigationController pushViewController:initView animated:YES];
}



- (IBAction)red_Month_btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NOTOKPiechartVC *initView =  (NOTOKPiechartVC*)[storyboard instantiateViewControllerWithIdentifier:@"NOTOKPIE"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    
    NSString *test =[NSString stringWithFormat:@"%@",[self.notOk_lbl text]];
    initView.dictObject = test;
    
    [self.navigationController pushViewController:initView animated:YES];
    
}


- (IBAction)Green_Month_btn:(id)sender {
    
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    
    NSString *test =[NSString stringWithFormat:@"%@",[self.ok_lbl text]];
    initView.dictObject = test;
    
   [self.navigationController pushViewController:initView animated:YES];
    
}
@end
