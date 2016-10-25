//
//  ScrapDetailVC.m
//  Yazaki
//
//  Created by APPLE on 29/08/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ScrapDetailVC.h"
#import "CustomNavigationVC.h"
#import "Common.h"
#import "ScrapCell.h"
#import "Theme.h"


@interface ScrapDetailVC ()
{
    CustomNavigationVC * objCustomNavigation;
    NSMutableArray * objCatagory;
    Theme * theme;
}

@end

@implementation ScrapDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objCatagory=[[NSMutableArray alloc]init];
   
    theme =[[Theme alloc]init];
   
    [theme loadingIcon:self.view];
   NSString * baseURL = [NSString stringWithFormat:@"%@/SCRAP/SCRAPDETAILED/%@/%@/%@/%@/%@",BaseURL,self.selectplancode,self.SelectareaCode,self.STATUS,self.fromDate,self.Todate];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {
        
        _serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        objCatagory=[_serviceResponse objectForKey:@"ScrapAreaDetailed"];
        
        
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
-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"Scrap_Detailed List";
    [objCustomNavigation.Logout_Btn setHidden:YES];
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [objCatagory count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ScrapCell";
    
    ScrapCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[ScrapCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    NSDictionary * objDic=[objCatagory objectAtIndex:indexPath.row];
    
       cell.plan_lbl.text = [objDic valueForKey:@"PlantName"];
    cell.lineName_lbl.text =[objDic valueForKey:@"LineName"];
    cell.processName_lbl.text =[objDic valueForKey:@"ProcessName"];
    cell.weight_lbl.text =[objDic valueForKey:@"Weight"];
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
