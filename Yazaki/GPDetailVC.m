//
//  GPDetailVC.m
//  Yazaki
//
//  Created by APPLE on 01/09/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "GPDetailVC.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "DashboardVC.h"
#import "GPDetailCell.h"

@interface GPDetailVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * detaliArray;
}

@end

@implementation GPDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    detaliArray =[[NSMutableArray alloc]init];
    [self webService];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Gate Pass_Detailed List";
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

-(void)webService
{
    NSString * baseURL = [NSString stringWithFormat:@"%@/GATEENTRY/FETCHVISITORSINDIVIDUALDETAILS/%@/%@/%@/%@/%@/%@",BaseURL,self.plantCode,self.GateCode,self.fromDate,self.Todate,self.vistorType,self.vistorID];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        detaliArray =   [_serviceResponse objectForKey:@"VisitorIndividualDetails"];
        
    }
    else{
        //handle received data
        //self.legend_ok_view.hidden=YES;
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
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
    
    return [detaliArray count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"GPDetailCell";
    
    GPDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[GPDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * ProjectDic =[detaliArray objectAtIndex:indexPath.row];
    
    cell.gate_lbl.text =[ProjectDic valueForKey:@"GateName"];
    cell.plant_lbl.text = [ProjectDic valueForKey:@"PlantName"];
     cell.name_lbl.text = [ProjectDic valueForKey:@"Name"];
     cell.companyName_lbl.text = [ProjectDic valueForKey:@"CompanyName"];
     cell.purpose_lbl.text = [ProjectDic valueForKey:@"Purpose"];
    
    return cell;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    ProjectTask * objQuoteAmount = [[ProjectTask alloc]init];
    //    objQuoteAmount =  (ProjectTask *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProjectTask"];
    //    NSDictionary * AmountDic =[objProjectMgtArray objectAtIndex:indexPath.row];
    //    objQuoteAmount.projectname=[AmountDic valueForKey:@"PROJECTNAME"];
    //    objQuoteAmount.totalTask =[AmountDic valueForKey:@"TOTALTASK"];
    //    objQuoteAmount.completedTask = [AmountDic valueForKey:@"COMPLETEDTASK"];
    //    objQuoteAmount.pendingTask = [AmountDic valueForKey:@"PENDINGTASK"];
    //    objQuoteAmount.objprojectcode=[AmountDic valueForKey:@"PROJECTCODE"];
    //    [self.navigationController pushViewController:objQuoteAmount animated:YES];
    
    
}

-(IBAction)Back_BtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
