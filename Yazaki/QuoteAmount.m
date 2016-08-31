//
//  QuoteAmount.m
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "QuoteAmount.h"
#import "Common.h"
#import "CustomNavigationVC.h"
#import "QuoteAmountCell.h"
#import "DashboardVC.h"

@interface QuoteAmount ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objQuoteAmountArray;
}

@end

@implementation QuoteAmount

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objQuoteAmountArray =[[NSMutableArray alloc]init];
    [self webService:self.plantCode :self.customCode:self.programname];
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

-(void)webService:(NSString *) Plantcode : (NSString *) customercode:  (NSString *) programname
{
    NSString * baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGQUOTEDAMOUNT/%@/%@/%@",BaseURL,Plantcode,customercode,programname];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        objQuoteAmountArray =   [_serviceResponse objectForKey:@"QUOTEDDETAILS"];
        
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
    
    return [objQuoteAmountArray count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"QuoteAmountCell";
    
    QuoteAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[QuoteAmountCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * VarientDic =[objQuoteAmountArray objectAtIndex:indexPath.row];
    // NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
    
    cell.lbl_suppliername.text =[VarientDic valueForKey:@"SUPPLIERNAME"];
    cell.lbl_currency.text = [VarientDic valueForKey:@"CURRENCYNAME"];
    cell.lbl_plant.text =[VarientDic valueForKey:@"PLANTNAME"];
    cell.lbl_Cost.text =[VarientDic valueForKey:@"COST"];
    cell.lbl_price.text =[VarientDic valueForKey:@"PRICE"];
    return cell;
}

- (void)tableView:( UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    
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
