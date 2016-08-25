//
//  testing2.m
//  Yazaki
//
//  Created by apple on 3/31/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "testing2.h"
#import "EMpTableViewCell.h"
@interface testing2 ()
@property (strong, nonatomic) NSMutableArray *TestingArray;
@end

@implementation testing2
@synthesize passcategory;
@synthesize passcatID;
@synthesize passSTATUS;
@synthesize passfromDate;
@synthesize passTodate;
@synthesize passcategory1;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURL = [NSString stringWithFormat:@"http://192.168.1.49:8097/YazakiService.svc/EMPLOYEEDETAILS/%@/%@/%@/%@/%@",passSTATUS,passcategory,passcatID,passfromDate,passTodate];
    NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (responseData != nil) {

    NSDictionary *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    self.TestingArray=[serviceResponse objectForKey:@"EMPLOYEE"];
    
    self.status_lbl.text=passSTATUS;
    self.session_lbl.text=passcategory;
    self.category_lbl.text=passcategory1;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{ return [self.TestingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EMpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                             forIndexPath:indexPath];
    
    NSDictionary *test=[self.TestingArray objectAtIndex:indexPath.row];
    cell.id_lbl.text = [test valueForKey:@"ID"];
    cell.name_lbl.text=[test valueForKey:@"NAME"];
    cell.Accesstime_lbl.text=[test valueForKey:@"ACCESSTIME"];
    return cell;
}


@end
