//
//  cloudmineViewController.m
//  cloudmine-singly-test
//
//  Created by Nikko Schaff on 11/2/12.
//  Copyright (c) 2012 cloudmine. All rights reserved.
//

#import "cloudmineViewController.h"
#import <CloudMine/CloudMine.h>

@interface cloudmineViewController ()

@end

@implementation cloudmineViewController

@synthesize statusLabel = _statusLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)login:(id)sender {
    CMUser *user = [[CMUser alloc] initWithUserId:@"test@example.com" andPassword:@"my-password"];
    
    // TODO reimplement with initWithSocial
    // TODO link in view
    
    [user loginWithCallback:^(CMUserAccountResult resultCode, NSArray *messages) {
        switch(resultCode) {
            case CMUserAccountLoginSucceeded:
                // success! the user now has a session token
                _statusLabel.text = @"Login succeded!";
      //          NSString *token = user.token;
                break;
            case CMUserAccountLoginFailedIncorrectCredentials:
                // the users credentials were invalid
                _statusLabel.text = @"Login failed!";
                break;

            default:
                break;
        }
    }];
    
    // Set the user property on CMStore. This user will be used for all user-level calls from this point on.
    //store.user = user;
}

/**
 <Requirements>
 
 Developer creates an app on whatever social service they want to use
 Developer puts the client id / client secret in the CloudMine dashboard
 Developer loads the CloudMine social log in end point in a web view
 Redirects to Singly
 Redirects to social service log in page
 User logs in
 Redirects to Singly
 Redirects to CloudMine
 Developer makes a GET to CloudMine social completed end point, receives back session token and user profile information.
 
 Here is a kinda rough design spec for this task:
 * Developer calls a single method, specifying the service to log into and a response callback for handling success and failure (model after existing responses in CloudMine iOS library)
 * User logs in to the social service through a web view, if and only if they haven't already logged in
 ** If user has already logged in, they should remain in the calling view. The response should still fire
 * Response should provide convenience method for getting the returned user profile and session token
 * The first url to load looks like:
 http://api-beta.cloudmine.me/v1/app/c1a562ee1e6f4a478803e7b51babe287/account/social/login/*token*?service=facebook&apikey=27D924936D2C7D422D58B919B9F23653&challenge=*challenge*
 Where the token is a randomly generated string and the challenge is a randomly generated string. Also, the c1a562.... is the application identifier, 27D924.... is the API key, and the service is the service to log into.
 You can replace the service value with any one of the following:
 fitbit, gcontacts, zeo, foursquare, meetup, github, runkeeper, twitter, google, gdocs, bodymedia, dropbox, yammer, linkedin, gplus, tumblr, flickr, wordpress, withings, gmail, instagram, facebook
 For testing, you can use the specified app id and api key. The only services set up at the moment are github and twitter.
 The second URL to do a GET to looks like
 http://api-beta.cloudmine.me/v1/app/c1a562ee1e6f4a478803e7b51babe287/account/social/login/status/*token*?challenge=*challenge*
 and returns JSON in the form of: {"finished":true,"expires":"Mon, 29 Oct 2012 19:52:43 GMT","session_token":"cfa0d93492d04ac680e94aa76b91d1a9","profile":{"__type__":"user","__id__":"e73ee79182b14a75a2fddd050c6e6bcf","__services__":["twitter","github"]}}
 
 
 For design purposes, the expected future behavior includes:
 * Include a CloudMine session token with the request to link to a specific account
 * Delete cookie created when logging in
 * Make social requests to other endpoints, to retrieve data or 8post updates
 
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
