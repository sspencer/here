//
//  BigLoginViewController.m
//  Here
//
//  Created by Steve Spencer on 10/22/15.
//  Copyright © 2015 Steve Spencer. All rights reserved.
//

#import "BigLoginViewController.h"

@interface BigLoginViewController () <PFLogInViewControllerDelegate>

@end

@implementation BigLoginViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton;
    self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"805bootcamp"]];
    self.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {

    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login Failed"
                                                                             message:@"The username and password you entered don't match"
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];

    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];

    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    NSString *storyboardId = @"Main";
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [window.rootViewController.storyboard instantiateViewControllerWithIdentifier:storyboardId];
}


@end
