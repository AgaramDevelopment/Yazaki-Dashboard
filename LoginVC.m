//  LoginVC.m
//  Yazaki
//
//  Created by apple on 3/22/16.
//  Copyright (c) 2016 apple. All rights reserved.
//


#import "LoginVC.h"
#import "HOMEVC.h"
#import "DashboardVC.h"
#import "AppDelegate.h"
#import "CustomNavigationVC.h"
#import "Common.h"

@interface LoginVC ()
{
    CustomNavigationVC *objCustomNavigation;
}
@end

@implementation LoginVC
-(IBAction)login:(id)sender{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate showLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *userUpdate =[NSString stringWithFormat:@"%@",[Usernamefileld text]];
        NSString *userUpdate1 =[NSString stringWithFormat:@"%@",[PasswordField text]];
        
        NSString *baseURL = [NSString stringWithFormat:@"%@/LOGIN/%@/%@",BaseURL,userUpdate,userUpdate1];
        NSURL *url = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;

        NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
         if (responseData != nil) {
        NSMutableArray *serviceResponse=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"got response==%@", serviceResponse);
    
             
        NSDictionary *template=[[serviceResponse valueForKey:@"Login_DC"] objectAtIndex:0];
        
        NSString *test=[template objectForKey:@"ValidState"];
        
        NSString *helloString = @"1";
        
        if ([test isEqual:helloString]) {
            NSMutableArray * objDashboardArray=[serviceResponse valueForKey:@"DashboardDetails"];
            [self moveToView:objDashboardArray];
           
        }
        
        else{
            
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Incorrect Uername/Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [delegate hideLoading];
            
            [alert2 show];
            [self alertView1:alert2 didDismissWithButtonIndex:alert2];
            
        }}
        
        
         else{
             //handle received data
                 [self showDialog:@"Please Check Your Internet Connection" andTitle:@"No Internet Connection"];
             [delegate hideLoading];
         }
    });
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customnavigationmethod];
    [objCustomNavigation.Home_Btn setHidden:YES];
     [objCustomNavigation.Btn_Back setHidden:YES];
    
}


-(void)viewDidAppear:(BOOL)animated {
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)moveToView :(NSMutableArray *) dashBoardCatagory{
    
    
    DashboardVC *dashBoardVC = [[DashboardVC alloc]init];
    dashBoardVC =  (DashboardVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboardvc"];
    dashBoardVC.dashBoardList=dashBoardCatagory;
    [self.navigationController pushViewController:dashBoardVC animated:YES];
    

}





-(void) showDialog:(NSString*) message andTitle:(NSString*) title{
    UIAlertView *alertDialog = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertDialog show];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigationVC alloc] initWithNibName:@"CustomNavigationVC" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.lbl_titleName.text=@"";
    [objCustomNavigation.Btn_Back addTarget:self action:@selector(Back_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) alertView1:(UIAlertView *)alertView1 didDismissWithButtonIndex:(NSInteger)buttonIndex
{
 
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LoginVC *initView =  (LoginVC*)[storyboard instantiateViewControllerWithIdentifier:@"loginvc"];
//    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:initView animated:NO completion:nil];
}


@end

