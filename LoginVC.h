//
//  LoginVC.h
//  Yazaki
//
//  Created by apple on 3/22/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
{ IBOutlet UITextField *Usernamefileld;
    IBOutlet UITextField *PasswordField;
    NSDictionary *authenticationDict;
}
-(IBAction)login:(id)sender;

@end
