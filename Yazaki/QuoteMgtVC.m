//
//  QuoteMgtVC.m
//  Yazaki
//
//  Created by APPLE on 30/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "QuoteMgtVC.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "QuoteMgtcell.h"
#import "QuoteVarientVC.h"
#import "DashboardVC.h"

@interface QuoteMgtVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objQUMArray;
    NSMutableArray *CustomerArray ;
    NSMutableArray *DetailsArray;
    NSMutableArray *Plantarray;
    BOOL isPlantTbl;
    BOOL isCustomerTbl;
    
}

@property (nonatomic,strong) NSString * plantCodeStr;

@property (nonatomic,strong) NSString *customCodeStr;
@end

@implementation QuoteMgtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    self.tbl_select.layer.borderWidth = 2.0;
    self.tbl_select.layer.borderColor = [UIColor colorWithRed:(223/255.0f) green:(37/255.0f) blue:(13/255.0f) alpha:1.0f].CGColor;
    
    objQUMArray=[[NSMutableArray alloc]init];
    Plantarray  =[[NSMutableArray alloc]init];
     DetailsArray  =[[NSMutableArray alloc]init];
     CustomerArray  =[[NSMutableArray alloc]init];
    self.tbl_select.hidden=YES;
    
    [self webService:@"SELECT" :@"SELECT"];
    
    
    
//   NSString * baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/''/''",BaseURL];
//    
//    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLResponse *response;
//    NSError *error;
//    
//    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (responseData != nil) {
//        
//        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
//        CustomerArray =   [_serviceResponse objectForKey:@"CostingInitializeCustomer"];
//        //NSDictionary *myslot=[CustomerArray objectAtIndex:0];
//        
//         DetailsArray =   [_serviceResponse objectForKey:@"CostingInitializeDetails"];
//       // NSDictionary *myslot1=[DetailsArray objectAtIndex:0];
//        
//       Plantarray =   [_serviceResponse objectForKey:@"CostingInitializePlant"];
//       // NSDictionary *myslot2=[Plantarray objectAtIndex:0];
//        objQUMArray=[_serviceResponse copy];
//        
//    }
//    else{
//        //handle received data
//        //self.legend_ok_view.hidden=YES;
//        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
//        
//    }

    
}

-(void)webService:(NSString *) Plantcode : (NSString *)customercode
{
    NSString * baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/%@/%@",BaseURL,Plantcode,customercode];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        CustomerArray =   [_serviceResponse objectForKey:@"CostingInitializeCustomer"];
        //NSDictionary *myslot=[CustomerArray objectAtIndex:0];
        
        DetailsArray =   [_serviceResponse objectForKey:@"CostingInitializeDetails"];
        // NSDictionary *myslot1=[DetailsArray objectAtIndex:0];
        
        Plantarray =   [_serviceResponse objectForKey:@"CostingInitializePlant"];
        // NSDictionary *myslot2=[Plantarray objectAtIndex:0];
        objQUMArray=[_serviceResponse copy];
        
    }
    else{
        //handle received data
        //self.legend_ok_view.hidden=YES;
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }

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

-(IBAction)Home_Btn:(id)sender
{
    DashboardVC *initView = [[DashboardVC alloc]init];
    initView =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
    [self.navigationController pushViewController:initView animated:YES];
}

-(IBAction)didClickPlantCode:(id)sender
{
    if(isPlantTbl== NO)
    {
        self.tbl_select.hidden=NO;
        self.selectTblYposition.constant = self.plantcode_view.frame.origin.y-10;
        isPlantTbl =YES;
        [self.tbl_select reloadData];
    }
    else{
        
        self.tbl_select.hidden=YES;
        isPlantTbl =NO;
    }
}

-(IBAction)didClickCustomerCode:(id)sender
{
    if(isCustomerTbl== NO)
    {
        self.tbl_select.hidden=NO;
        self.selectTblYposition.constant =self.customcode_view.frame.size.height+15;
        isCustomerTbl =YES;
        [self.tbl_select reloadData];
    }
    else{
        
        self.tbl_select.hidden=YES;
        isCustomerTbl =NO;
    }

}

-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.tbl_select .hidden == NO)
    {
        if(isPlantTbl==YES)
        {
            return [Plantarray count];
        }
        else
        {
           return [CustomerArray count];
        }
    }
    else
    {
        return [DetailsArray count];
    }//count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"QuoteMgtcell";
    
    if(self.tbl_select .hidden == YES)
    {
    QuoteMgtcell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[QuoteMgtcell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    //NSDictionary * plan =[Plantarray objectAtIndex:indexPath.row];
    NSDictionary * DetailsDic =[DetailsArray objectAtIndex:indexPath.row];
    
    cell.plan_lbl.text =[DetailsDic valueForKey:@"PLANTNAME"];
    cell.customername_lbl.text = [DetailsDic valueForKey:@"CUSTOMERNAME"];
    cell.startproject_lbl.text = [DetailsDic valueForKey:@"STARTOFPROJECT"];
    cell.endproject_lbl.text    = [DetailsDic valueForKey:@"ENDOFPROJECT"];
    return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        }
        
        NSDictionary * plan =[Plantarray objectAtIndex:indexPath.row];
        NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text =(isPlantTbl == YES)?[plan valueForKey:@"PLANTNAME"]:[customername valueForKey:@"CUSTOMERNAME"];
       cell.textLabel.font=[UIFont fontWithName:@"RAJDHANI-BOLD" size:cell.textLabel.font.pointSize];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tbl_select .hidden == YES)
    {
        
        NSDictionary  * detaildic   =[DetailsArray objectAtIndex:indexPath.row];
         QuoteVarientVC * objQuotevarient = [[QuoteVarientVC alloc]init];
        objQuotevarient =  (QuoteVarientVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuoteVarientvc"];
        objQuotevarient.plantCode=[detaildic valueForKey:@"PLANTNAME"];
        objQuotevarient.customCode =[detaildic valueForKey:@"CUSTOMERNAME"];
        objQuotevarient.programname = [detaildic valueForKey:@"PROGRAMNAME"];
        [self.navigationController pushViewController:objQuotevarient animated:YES];
    }
    else
    {
        if(isPlantTbl==YES)
        {
            NSDictionary * plantDic = [Plantarray objectAtIndex:indexPath.row];
            self.plant_lbl.text=[plantDic valueForKey:@"PLANTNAME"];
            self.plantCodeStr  =[plantDic valueForKey:@"PLANTCODE"];
            isPlantTbl=NO;
        }
        else if(isCustomerTbl==YES)
        {
            NSDictionary * plantDic = [CustomerArray objectAtIndex:indexPath.row];
            self.custom_lbl.text=[plantDic valueForKey:@"CUSTOMERNAME"];
            self.customCodeStr=[plantDic valueForKey:@"CUSTOMERCODE"];
            isCustomerTbl=NO;
        }
        self.tbl_select.hidden=YES;
    }
    
}

-(IBAction)didClickGeneralBtnAction:(id)sender
{
    self.plantCodeStr=([self.plantCodeStr isEqualToString:@""] || self.plantCodeStr==nil)?@"''":self.plantCodeStr;
    
    self.customCodeStr=([self.customCodeStr isEqualToString:@""] || self.customCodeStr==nil)?@"''":self.customCodeStr;
    [self webService:self.plantCodeStr : self.customCodeStr];
    
    [self.Quote_tbl reloadData];
    
}

-(IBAction)didClickClearBtnAction:(id)sender
{
    [self webService:@"''" :@"''"];
    
}



-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
