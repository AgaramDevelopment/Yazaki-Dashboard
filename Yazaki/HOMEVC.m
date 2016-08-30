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
#import "Common.h"
#import "ProductionVC.h"
@interface HOMEVC ()
{
    CustomNavigationVC *objCustomNavigation;
      NSString *selectPlantCode;
}
@property (nonatomic,strong) NSMutableArray *planArray;
@property (nonatomic,strong) NSDictionary *myslot;
@property (nonatomic,strong) NSDictionary *ResultHolderDict;
@property (nonatomic,strong) NSDictionary *planDict;

@end

@implementation HOMEVC
@synthesize ResultHolderDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    self.tableView.hidden=YES;
    datepicker=[[UIDatePicker alloc]init];
    datepicker1=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker1.datePickerMode=UIDatePickerModeDate;
    
    _planArray=[[NSMutableArray alloc]init];
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
    
    
    self.redib_Btn.backgroundColor=[UIColor colorWithRed:(51/255.0f) green:(188/255.0f) blue:(8/255.0f) alpha:1.0f];
    
    NSString *baseURL;
 
    if([self.selectType isEqualToString: @"2"])
    {
        baseURL = [NSString stringWithFormat:@"%@/CANTEEN/INITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"3"])
    {
        baseURL = [NSString stringWithFormat:@"%@/PRODUCTION/BOXINITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"4"])
    {
        baseURL = [NSString stringWithFormat:@"%@/SCRAP/SCRAPINITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"5"])
    {
        baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/EFFICIENCYINITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"6"])
    {
        baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/''/''",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"7"])
    {
        baseURL = [NSString stringWithFormat:@"%@/TRAINING/TRAININGDASHBOARDINITIALIZE",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"8"])
    {
        baseURL = [NSString stringWithFormat:@"%@/GATEENTRY/INITIALIZEGATEENTRYDASHBOARD/''/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"9"])
    {
        baseURL = [NSString stringWithFormat:@"%@/GIFT/GIFTINITIALIZE",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"10"])
    {
        baseURL = [NSString stringWithFormat:@"%@/PROJECTMANAGEMENT/INITIALIZEPROJECTMANGEMENT",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    else if ([self.selectType isEqualToString: @"12"])
    {
        baseURL = [NSString stringWithFormat:@"%@/Attendance/INITIALIZE/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    
}

-(void)WebserviceMethod:(NSString *)URL
{
    
    NSURL *url = [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        ResultHolderDict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        [self ResponDataValue:ResultHolderDict:self.selectType];
        
        
        
        
    }
    else{
        //handle received data
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    
}

-(void)ResponDataValue:(NSDictionary *) responsData:(NSString *) selectOptionType
{
    if([selectOptionType isEqualToString: @"2"])
    {
        NSArray *temp =   [responsData objectForKey:@"Initialize_Ok"];
        NSDictionary *myslot=[temp objectAtIndex:0];
        
        NSArray *temp1 =   [responsData objectForKey:@"Initialize_NotOk"];
        NSDictionary *myslot1=[temp1 objectAtIndex:0];
        
        self.Ok_lbl.text=[myslot objectForKey:@"NAME"];
        self.notOk_lbl.text=[myslot1 objectForKey:@"NAME"];
        self.CountValues_Green_lbl.text=[myslot objectForKey:@"COUNTVALUE"];
        self.CountValues_Red_lbl.text=[myslot1 objectForKey:@"COUNTVALUE"];
        _planArray=[responsData objectForKey:@"PlantDetails"];
        
    }
    
    else if ([selectOptionType isEqualToString: @"3"])
    {
        NSArray *temp =   [responsData objectForKey:@"ACTUALQTY"];
        
        if(temp.count == 1)
        {
            self.redCircle_view.hidden=YES;
            self.greenviewXposition.constant=(self.view.frame.size.width)/3;
        }
        
        self.Ok_lbl.text=@"TOTAL QUANTITY";
        
        self.CountValues_Green_lbl.text=[temp valueForKey:@"ACTUALQTY"];
        
        _planArray=[responsData objectForKey:@"BoxInitializePlant"];
    }
    
    else if ([selectOptionType isEqualToString: @"4"])
    {
        NSArray *temp =   [responsData objectForKey:@"ActualQuantitys"];
        
        if(temp.count == 1)
        {
            self.redCircle_view.hidden=YES;
            self.greenviewXposition.constant=(self.view.frame.size.width)/3;
        }
        NSDictionary *myslot=[temp objectAtIndex:0];
        self.Ok_lbl.text=@"ACTUALQUANTITY";
        
        self.CountValues_Green_lbl.text=[myslot valueForKey:@"ACTUALQUANTITY"];
        
        _planArray=[responsData objectForKey:@"DTPlants"];
        
        
    }

    
    else if ([selectOptionType isEqualToString: @"5"])
    {
        
    }
    
    else if ([selectOptionType isEqualToString: @"6"])
    {
        
    }
    
    else if ([selectOptionType isEqualToString: @"7"])
    {
        
    }
    
    else if ([selectOptionType isEqualToString: @"8"])
    {
    }
    
    else if ([selectOptionType isEqualToString: @"9"])
    {
        //_planArray=[responsData objectForKey:@"GiftLocation"];
    }
    
    else if ([selectOptionType isEqualToString: @"10"])
    {
        
    }
    else if ([selectOptionType isEqualToString: @"12"])
    {
        
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
    [objCustomNavigation.Logout_Btn setHidden:YES];
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
    NSString *baseURL;
    if([self.selectType isEqualToString: @"2"])
    {
        
        baseURL = [NSString stringWithFormat:@"%@/CANTEEN/INITIALIZE/%@/%@/%@",BaseURL,selectPlantCode,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"3"])
    {
        baseURL = [NSString stringWithFormat:@"%@/PRODUCTION/BOXINITIALIZE/%@/%@/%@",BaseURL,selectPlantCode,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"4"])
    {
        baseURL = [NSString stringWithFormat:@"%@/SCRAP/SCRAPINITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"5"])
    {
        baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/EFFICIENCYINITIALIZE/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"6"])
    {
        baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/''/''",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"7"])
    {
        baseURL = [NSString stringWithFormat:@"%@/TRAINING/TRAININGDASHBOARDINITIALIZE",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"8"])
    {
        baseURL = [NSString stringWithFormat:@"%@/GATEENTRY/INITIALIZEGATEENTRYDASHBOARD/''/''/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"9"])
    {
        baseURL = [NSString stringWithFormat:@"%@/GIFT/GIFTINITIALIZE",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"10"])
    {
        baseURL = [NSString stringWithFormat:@"%@/PROJECTMANAGEMENT/INITIALIZEPROJECTMANGEMENT",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    else if ([self.selectType isEqualToString: @"12"])
    {
        baseURL = [NSString stringWithFormat:@"%@/Attendance/INITIALIZE/%@/%@",BaseURL,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
}



- (IBAction)Clear_btn:(id)sender {
    [self viewDidLoad];
}

- (IBAction)green_btn:(id)sender {
    
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
     if([self.selectType isEqualToString: @"2"]){
        PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
             initView.selectPlantCode=selectPlantCode;
    NSString *test =[NSString stringWithFormat:@"%@",[self.Ok_lbl text]];
    initView.dictObject = test;
    [self.navigationController pushViewController:initView animated:YES];
     }
    
    if([self.selectType isEqualToString: @"3"]){
        
        ProductionVC *initView =  (ProductionVC*)[storyboard instantiateViewControllerWithIdentifier:@"Productionvc"];
        initView.FromStr = userUpdate;
        initView.ToStr = userUpdate1;
        initView.selectPlantCode=selectPlantCode;
        [self.navigationController pushViewController:initView animated:YES];
        
    }
    
    
    
}

- (IBAction)red_btn:(id)sender {
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_Fromdate_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Todate_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     if([self.selectType isEqualToString: @"2"]){
    NOTOKPiechartVC *initView =  (NOTOKPiechartVC*)[storyboard instantiateViewControllerWithIdentifier:@"NOTOKPIE"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
             initView.selectPlantCode=selectPlantCode;
        NSString *test =[NSString stringWithFormat:@"%@",[self.notOk_lbl text]];
    initView.dictObject = test;
       [self.navigationController pushViewController:initView animated:YES];
     }
    
}

- (IBAction)Plant_touch_btn:(id)sender {
    
    
    if (self.tableView.hidden ==YES) {
        
        self.tableView.hidden=NO;
        
    }
    else
        self.tableView.hidden=YES;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_planArray count];
}





- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    _planDict=[_planArray objectAtIndex:indexPath.row];
    cell.textLabel.text =[_planDict objectForKey:@"PLANTNAME"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.plant_lbl.text =cell.textLabel.text;
    _planDict=[_planArray objectAtIndex:indexPath.row];
    selectPlantCode= self.plant_lbl.text;
    selectPlantCode=[_planDict objectForKey:@"PLANTCODE"];
    
    self.tableView.hidden=YES;
    
    
}

@end
