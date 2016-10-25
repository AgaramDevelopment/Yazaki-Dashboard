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
#import "ProductionVC.h"
#import "EfficiencyLineVC.h"
#import "AppDelegate.h"
#import "Theme.h"

@interface HomeMonthVC ()
{
    CustomNavigationVC *objCustomNavigation;
    NSString *selectPlantCode;
    BOOL isScrap;
    AppDelegate * appDelegate;
    Theme * theme;
}

@property (nonatomic,strong) NSDictionary*ResultHolderDict;
@property (nonatomic,strong) NSMutableArray *planArray;
@property (nonatomic,strong) NSDictionary *myslot;
@property (nonatomic,strong) NSDictionary *planDict;


@end

@implementation HomeMonthVC
@synthesize ResultHolderDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
   self.tableView.layer.borderWidth = 2.0;
   self.tableView.layer.borderColor = [UIColor colorWithRed:(223/255.0f) green:(37/255.0f) blue:(13/255.0f) alpha:1.0f].CGColor;
    _planArray=[[NSMutableArray alloc]init];
    datepicker=[[UIDatePicker alloc]init];
    datepicker1=[[UIDatePicker alloc]init];
    ResultHolderDict=[[NSDictionary alloc]init];
    
    datepicker.datePickerMode=UIDatePickerModeDate;
    datepicker1.datePickerMode=UIDatePickerModeDate;
     self.tableView.hidden=YES;
    
    
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
    
    self.redCircle_view.hidden=NO;
    self.greenviewXposition.constant=13;
    
        
    self.redib_btn.layer.cornerRadius=70;
    self.redib_btn.layer.masksToBounds=YES;
    
    self.greenib_btn.layer.cornerRadius=70;
    self.greenib_btn.layer.masksToBounds=YES;
    isScrap=NO;
    
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
    
    [self CommonWebserviceMethod:userUpdate :userUpdate1];

    
}

-(void)CommonWebserviceMethod:(NSString *)userUpdate :(NSString *)userUpdate1
{
    NSString * baseURL;
    NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
    if([self.selectType isEqualToString: @"2"])
    {
        baseURL = [NSString stringWithFormat:@"%@/CANTEEN/INITIALIZE/%@/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"3"])
    {
        baseURL = [NSString stringWithFormat:@"%@/PRODUCTION/BOXINITIALIZE/%@/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"4"])
    {
        baseURL = [NSString stringWithFormat:@"%@/SCRAP/SCRAPINITIALIZE/%@/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"5"])
    {
        baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/EFFICIENCYINITIALIZE",BaseURL];
        
        
        
        [self WebserviceMethod:baseURL];
    }
    
    else if ([self.selectType isEqualToString: @"6"])
    {
        baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/''/''",BaseURL];
        [self WebserviceMethod:baseURL];
    }
    

    
    else if ([self.selectType isEqualToString: @"8"])
    {
        plancode =([plancode isEqualToString:@"''"])?@"select":plancode;
        baseURL = [NSString stringWithFormat:@"%@/GATEENTRY/INITIALIZEGATEENTRYDASHBOARD/%@/select/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
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
    theme=[[Theme alloc]init];
    [theme loadingIcon:self.view];
    NSURL *url = [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        ResultHolderDict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        
        [self ResponDataValue :ResultHolderDict:self.selectType];
    
    }
    else{
        //handle received data
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    [theme removeLoadingIcon];

}

-(void)ResponDataValue:(NSDictionary *) responsData:(NSString *) selectOptionType
{
    if([selectOptionType isEqualToString: @"2"])
    {
        NSArray *temp =   [responsData objectForKey:@"Initialize_Ok"];
        NSDictionary *myslot=[temp objectAtIndex:0];
        
        NSArray *temp1 =   [responsData objectForKey:@"Initialize_NotOk"];
        NSDictionary *myslot1=[temp1 objectAtIndex:0];
        
        self.ok_lbl.text=[myslot objectForKey:@"NAME"];
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

         self.ok_lbl.text=@"TOTAL QUANTITY";
       
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
        self.ok_lbl.text=@"ACTUALQUANTITY";
        
        self.CountValues_Green_lbl.text=[myslot valueForKey:@"ACTUALQUANTITY"];
        
        _planArray=[responsData objectForKey:@"DTPlants"];
        
        
    }
    
    else if ([selectOptionType isEqualToString: @"5"])
    {
        NSArray * temp =   [responsData objectForKey:@"EfficiencyTotalEfficiencyDetails"];
        NSDictionary * myslot=[temp objectAtIndex:0];
        
       // NSArray *temp1 =   [responsData objectForKey:@"Initialize_NotOk"];
        //NSDictionary *myslot1=[temp1 objectAtIndex:0];
        
        self.ok_lbl.text= @"DIRECTEFFICIENCY";          //[myslot objectForKey:@"NAME"];
        self.notOk_lbl.text= @"INDIRECTEFFICIENCY";                          //[myslot1 objectForKey:@"NAME"];
        self.CountValues_Green_lbl.text=[myslot objectForKey:@"DIRECTEFFICIENCY"];
        self.CountValues_Red_lbl.text=[myslot objectForKey:@"INDIRECTEFFICIENCY"];
       
            _planArray=[responsData objectForKey:@"PlantDetails"];
        
            self.redCircle_view.hidden=NO;
            self.greenviewXposition.constant= 20; //(self.view.frame.size.width)/4;
      
//            self.ok_lbl.text=@"TOTAL EFFICIENCY";
//            
//            self.CountValues_Green_lbl.text=@"0";
        
    }
    
    
    else if ([selectOptionType isEqualToString: @"6"])
    {
        
    }
  
    else if ([selectOptionType isEqualToString: @"8"])
    {
        NSArray *temp =   [responsData objectForKey:@"Visitors"];
        if(temp.count == 1)
        {
            self.redCircle_view.hidden=YES;
            self.greenviewXposition.constant=(self.view.frame.size.width)/3;
        }
        NSDictionary *myslot=[temp objectAtIndex:0];
        
//        NSArray *temp1 =   [responsData objectForKey:@"Initialize_NotOk"];
//        NSDictionary *myslot1=[temp1 objectAtIndex:0];
        
        self.ok_lbl.text=@"TotalVisitor";
        //self.notOk_lbl.text=[myslot1 objectForKey:@"NAME"];
        self.CountValues_Green_lbl.text=[myslot objectForKey:@"TotalVisitor"];
        //self.CountValues_Red_lbl.text=[myslot1 objectForKey:@"COUNTVALUE"];
        _planArray=[responsData objectForKey:@"Plants"];
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
  
    
    [self CommonWebserviceMethod :userUpdate :userUpdate1];
    
    if ([_selectType isEqualToString: @"5"]) {
    //    EFFICIENCY/PLANTEFFICIENCY/{PLANTCODE}/{FROMDATE}/{TODATE}
        NSString * baseURL;
        NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
        theme =[[Theme alloc]init];
        [theme loadingIcon:self.view];
        baseURL = [NSString stringWithFormat:@"%@/EFFICIENCY/PLANTEFFICIENCY/%@/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
        
        NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (responseData != nil) {
            
            ResultHolderDict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            
            NSArray *temp =   [ResultHolderDict objectForKey:@"plantEfficiencyes"];
            
            if(temp.count == 1)
            {
                self.redCircle_view.hidden=NO;
                self.greenviewXposition.constant=(self.view.frame.size.width)/3;
            }
            if(temp.count>0)
            {
            NSDictionary *myslot=[temp objectAtIndex:0];
            self.ok_lbl.text=@"TOTAL EFFICIENCY";
            
            self.CountValues_Green_lbl.text=[myslot valueForKey:@"AVG"];
            }
            
        }
        else{
            //handle received data
            [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
            
        }
        [theme removeLoadingIcon];
        

    }
}


- (IBAction)ClearMonth_btn:(id)sender {
    selectPlantCode= nil;
    [self viewDidLoad];
    
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=self.Tittle;
    [objCustomNavigation.Logout_Btn setHidden:YES];
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
   if([self.selectType isEqualToString: @"5"]){
        if (![self.CountValues_Green_lbl.text  isEqual: @"0"])
        {
            
            EfficiencyLineVC *initView =  (EfficiencyLineVC*)[storyboard instantiateViewControllerWithIdentifier:@"effeciencyLine"];
            NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
            initView.fromstr = userUpdate;
            initView.tostr = userUpdate1;
            initView.selectPlantCode=plancode;
            initView.Tittle =self.Tittle;
            [self.navigationController pushViewController:initView animated:YES];
        }
        
    }
   else{
//    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
//    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //if([self.selectType isEqualToString: @"2"]){
    
    NOTOKPiechartVC *initView =  (NOTOKPiechartVC*)[storyboard instantiateViewControllerWithIdentifier:@"NOTOKPIE"];
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    initView.selectPlantCode=selectPlantCode;
    NSString *test =[NSString stringWithFormat:@"%@",[self.notOk_lbl text]];
    initView.dictObject = test;
    
    [self.navigationController pushViewController:initView animated:YES];
   }
    //}
    
//    else if ([self.selectType isEqualToString:@"4"])
//    {
//        NOTOKPiechartVC *initView =  (NOTOKPiechartVC*)[storyboard instantiateViewControllerWithIdentifier:@"NOTOKPIE"];
//        initView.str1 = userUpdate;
//        initView.str2 = userUpdate1;
//        initView.selectPlantCode=selectPlantCode;
//        NSString *test =[NSString stringWithFormat:@"%@",[self.notOk_lbl text]];
//        initView.dictObject = test;
//        
//        [self.navigationController pushViewController:initView animated:YES];
//    }
    
}


- (IBAction)Green_Month_btn:(id)sender {
    
    NSString *userUpdate =[NSString stringWithFormat:@"%@",[_FromMonth_txt text]];
    NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[_Tomonth_txt text]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
      if([self.selectType isEqualToString: @"2"]){
    
    PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
          NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
    initView.str1 = userUpdate;
    initView.str2 = userUpdate1;
    initView.selectPlantCode=plancode;
    initView.selectType     =self.selectType;
          initView.Tittle         =self.Tittle;
    NSString *test =[NSString stringWithFormat:@"%@",[self.ok_lbl text]];
    initView.dictObject = test;
    
   [self.navigationController pushViewController:initView animated:YES];
    
      }
    
    
   else if([self.selectType isEqualToString: @"5"]){
         if (![self.CountValues_Green_lbl.text  isEqual: @"0"])
         {
        
        EfficiencyLineVC *initView =  (EfficiencyLineVC*)[storyboard instantiateViewControllerWithIdentifier:@"effeciencyLine"];
        NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
        initView.fromstr = userUpdate;
        initView.tostr = userUpdate1;
        initView.selectPlantCode=plancode;
             initView.Tittle =self.Tittle;
      [self.navigationController pushViewController:initView animated:YES];
         }
       
    }
    
    
    else if ([self.selectType isEqualToString:@"4"])
    {
        NSString * baseURL;
        NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
        
        if(isScrap == NO)
        {
            theme = [[Theme alloc]init];
            [theme loadingIcon:self.view];
        baseURL = [NSString stringWithFormat:@"%@/SCRAP/SCRAPTYPE/%@/%@/%@",BaseURL,plancode,userUpdate,userUpdate1];
        NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;
        
        NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (responseData != nil) {
            
            

            isScrap=YES;
            
            ResultHolderDict=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            NSArray *temp =   [ResultHolderDict objectForKey:@"Avoidable"];
            NSDictionary *myslot;
            if(temp.count > 0)
            {
               myslot=[temp objectAtIndex:0];
               self.redCircle_view.hidden=NO;
               self.redib_btn.backgroundColor=[UIColor colorWithRed:(40/255.0f) green:(113/255.0f) blue:(42/255.0f) alpha:1.0f];
                
               self.greenviewXposition.constant=13;
            }
            NSArray *temp1 =   [ResultHolderDict objectForKey:@"unAvoidable"];
            NSDictionary *myslot1=[temp1 objectAtIndex:0];
            
            self.ok_lbl.text=([[myslot objectForKey:@"SESSIONVALUE"] isEqualToString:@""] || [myslot objectForKey:@"SESSIONVALUE"]==nil)?@"Avoidable":[myslot objectForKey:@"SESSIONVALUE"];
            
            self.notOk_lbl.text=([[myslot1 objectForKey:@"SESSIONVALUE"] isEqualToString:@""] || [myslot1 objectForKey:@"SESSIONVALUE"]==nil)?@"Un Avoidable":[myslot1 objectForKey:@"SESSIONVALUE"];
            
            self.CountValues_Green_lbl.text=([[myslot objectForKey:@"COUNTVALUE"] isEqualToString:@""] || [myslot objectForKey:@"COUNTVALUE"]==nil)?@"0KG":[myslot objectForKey:@"COUNTVALUE"];
            
            self.CountValues_Red_lbl.text=([[myslot1 objectForKey:@"COUNTVALUE"]isEqualToString:@""] || [myslot1 objectForKey:@"COUNTVALUE"])?@"0KG":[myslot1 objectForKey:@"COUNTVALUE"];
            //_planArray=[ResultHolderDict objectForKey:@"SESSIONVALUE"];
            
            
        }
        else{
                    //handle received data
                    [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
                    
                }

            [theme removeLoadingIcon];
        }
        else{
            
            isScrap=NO;
            PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
            initView.str1 = userUpdate;
            initView.str2 = userUpdate1;
               NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
            initView.selectPlantCode=plancode;
            initView.selectType     =self.selectType;
            initView.selectValuetype=self.ok_lbl.text;
           
            NSString *test =[NSString stringWithFormat:@"%@",[self.ok_lbl text]];
            initView.dictObject = test;
            initView.selectAvoidablecode =([test isEqualToString:@"Avoidable"])?@"1":@"0";
            initView.Tittle =self.Tittle;
            [self.navigationController pushViewController:initView animated:YES];
            
        }

    }
    
    
    
    if([self.selectType isEqualToString: @"3"]){
        if (![self.CountValues_Green_lbl.text  isEqual: @"0"])
        {
        
        ProductionVC *initView =  (ProductionVC*)[storyboard instantiateViewControllerWithIdentifier:@"Productionvc"];
        initView.FromStr = userUpdate;
        initView.ToStr = userUpdate1;
        initView.selectPlantCode=selectPlantCode;
            initView.Tittle =self.Tittle;
       [self.navigationController pushViewController:initView animated:YES];
        }
        
    }
    
    if([self.selectType isEqualToString: @"8"]){
        
        if(![self.CountValues_Green_lbl.text isEqualToString:@"0"])
        {
        PieChartTest *initView =  (PieChartTest*)[storyboard instantiateViewControllerWithIdentifier:@"piecharttest"];
        NSString * plancode =(selectPlantCode == nil)?@"SELECT":selectPlantCode;
        initView.str1 = userUpdate;
        initView.str2 = userUpdate1;
        initView.selectPlantCode=plancode;
        initView.selectType     =self.selectType;
        NSString *test =[NSString stringWithFormat:@"%@",[self.ok_lbl text]];
        initView.dictObject = test;
            initView.Tittle =self.Tittle;
        
        [self.navigationController pushViewController:initView animated:YES];
        }
        
    }
}

- (IBAction)touch_plant_btn:(id)sender {
    
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
    cell.textLabel.text =[_planDict valueForKey:@"PLANTNAME"];
    cell.textLabel.font=[UIFont fontWithName:@"RAJDHANI-BOLD" size:cell.textLabel.font.pointSize];
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.plant_lbl.text =cell.textLabel.text;
    _planDict=[_planArray objectAtIndex:indexPath.row];
    selectPlantCode= self.plant_lbl.text;
    selectPlantCode=[_planDict valueForKey:@"PLANTCODE"];
    
    self.tableView.hidden=YES;
  
    
}




@end
