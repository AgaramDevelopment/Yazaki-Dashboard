//
//  QuoteVarientVC.m
//  Yazaki
//
//  Created by APPLE on 31/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "QuoteVarientVC.h"
#import "CustomNavigationVC.h"
#import "QuoteVarientCell.h"
#import "Common.h"
#import "QuoteAmount.h"
#import "DashboardVC.h"
#import "Theme.h"


@interface QuoteVarientVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objVarientArray;
    Theme * theme;
}

@end

@implementation QuoteVarientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objVarientArray =[[NSMutableArray alloc]init];
    [self webService:self.plantCode :self.customCode :self.programname];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Quote Management_Varient";
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
    theme =[[Theme alloc]init];
    [theme loadingIcon:self.view];
    NSString * baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGVARIANT/%@/%@/%@",BaseURL,Plantcode,customercode,programname];
    
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        objVarientArray =   [_serviceResponse objectForKey:@"COSTINGDETAILS"];

    }
    else{
        //handle received data
        //self.legend_ok_view.hidden=YES;
        [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
        
    }
    [theme removeLoadingIcon];
    
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
    
    return [objVarientArray count];
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"QuoteVarientCell";
    
    QuoteVarientCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[QuoteVarientCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
        }
        
        NSDictionary * VarientDic =[objVarientArray objectAtIndex:indexPath.row];
       // NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
        
        cell.lbl_varientname.text =[VarientDic valueForKey:@"VARIANTNAME"];
        cell.lbl_varientcode.text = [VarientDic valueForKey:@"VARIANTCODE"];
        cell.lbl_plant.text =[VarientDic valueForKey:@"PLANTNAME"];
        cell.lbl_CustomerName.text =[VarientDic valueForKey:@"CUSTOMERNAME"];
        cell.lbl_MixRatio.text =[VarientDic valueForKey:@"MIXRATIO"];
        return cell;
   }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        QuoteAmount * objQuoteAmount = [[QuoteAmount alloc]init];
        objQuoteAmount =  (QuoteAmount *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuoteAmount"];
       NSDictionary * AmountDic =[objVarientArray objectAtIndex:indexPath.row];
       objQuoteAmount.plantCode=[AmountDic valueForKey:@"PLANTNAME"];
       objQuoteAmount.customCode =[AmountDic valueForKey:@"CUSTOMERNAME"];
       objQuoteAmount.programname = [AmountDic valueForKey:@"PROGRAMNAME"];
        [self.navigationController pushViewController:objQuoteAmount animated:YES];
   
    
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
