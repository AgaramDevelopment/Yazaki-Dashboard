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

@interface QuoteMgtVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objQUMArray;
    NSMutableArray *CustomerArray ;
    NSMutableArray *DetailsArray;
    NSMutableArray *Plantarray;
}

@end

@implementation QuoteMgtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objQUMArray=[[NSMutableArray alloc]init];
    Plantarray  =[[NSMutableArray alloc]init];
     DetailsArray  =[[NSMutableArray alloc]init];
     CustomerArray  =[[NSMutableArray alloc]init];
   NSString * baseURL = [NSString stringWithFormat:@"%@/QUOTEMANAGEMENT/COSTINGINITIALIZE/''/''",BaseURL];
    
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
    objCustomNavigation.lbl_titleName.text=@"";
    [objCustomNavigation.Logout_Btn setHidden:YES];
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    return [objQUMArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"QuoteMgtcell";
    
    QuoteMgtcell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[QuoteMgtcell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    NSDictionary * plan =[Plantarray objectAtIndex:indexPath.row];
    NSDictionary * customername =[CustomerArray objectAtIndex:indexPath.row];
    
    cell.plan_lbl.text =[plan valueForKey:@"PLANTNAME"];
    cell.customername_lbl.text = [customername valueForKey:@"CUSTOMERNAME"];
    return cell;
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
