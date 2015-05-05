//
//  TwitterHelper.m
//  Wishlu
//
//  Created by Ashish on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterHelper.h"
#import "SA_OAuthTwitterEngine.h"

//////iCouponz - IOS
//#define kOAuthConsumerKey @ "7CxzRLBPPYJnnRlosQV2VQ";
//#define kOAuthConsumerSecret @"DtmvAnECcVrzm71n8Cpr44tuEW0gWAHh60WRUWY";


#define kOAuthConsumerKey		@"diVmyOW40U7kp21Hp3CcQ"//		
#define kOAuthConsumerSecret	@"O55qOQBhcm15Bkr4dnc6nHQkHbKMlhLZrXTSm5kpiNQ"  //

//Consumer key	diVmyOW40U7kp21Hp3CcQ
//Consumer secret	O55qOQBhcm15Bkr4dnc6nHQkHbKMlhLZrXTSm5kpiNQ

@implementation TwitterHelper
@synthesize delegate;
@synthesize _engine;
@synthesize  usernamee,authDataa;


static TwitterHelper* sharedInstance = nil;

+(TwitterHelper*) sharedController
{
	if(sharedInstance==nil)
	{
		sharedInstance = [[TwitterHelper alloc] init];
	}
	return sharedInstance;
}

-(id) init
{
	if(self=[super init])
	{
		//action = FAT_NO_ACTION;
	}
	return self;
}

-(void)sendUpdate:(NSString *)status{
    
    [_engine sendUpdate:status];
}


- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
    usernamee=[username copy];
    authDataa=[data copy];
    
    NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: data forKey: @"authData"];
    [defaults setObject: username forKey: @"twitterUserName"];
    NSMutableArray *twitterAuthData = [NSMutableArray arrayWithArray:[data componentsSeparatedByString:@"&"]];
    [defaults setObject: twitterAuthData forKey: @"twitterAuthData"];
    //    NSString *userBirthDate = [_engine getUserInformationForEmail:usernamee];
    //    [defaults setObject:userBirthDate  forKey: @"TWEmailDetail"];
	[defaults synchronize];
    
    NSLog(@"value of userName %@",username);
    NSLog(@"value of authData %@",data);
    //NSLog(@"value of authData %@",[defaults valueForKey:@"TWEmailDetail"]);
    //[_engine getUserInformationForEmail:@""];//TWusername
    
    [delegate TwitterDidLogin:data userName:username successfully:YES];
    
}

-(NSString *) getUserInformationFor:(NSString *)usernameOIid{
    
    return [_engine getUserInformationFor:usernameOIid];
}

-(NSString *) getusername{
    return [_engine username];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	NSLog(@"authData=%@",[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"]);
    return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

-(void) logOut{
    usernamee=@"";
    authDataa=@"";
    NSUserDefaults        *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey: @"authData"];
    [defaults synchronize];
    
    [_engine performSelector:@selector(clearCookiesOfTwitter) withObject:nil afterDelay:1.0 ];
}




-(void)clear
{
    
    NSString *_APIDomain=@"https://twitter.com/statuses/update.xml";
    BOOL _secureConnection;
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", 
                           (_secureConnection) ? @"https" : @"http", 
                           _APIDomain];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSEnumerator *enumerator = [[cookieStorage cookiesForURL:url] objectEnumerator];
    NSHTTPCookie *cookie = nil;
    while ((cookie = [enumerator nextObject])) {
        [cookieStorage deleteCookie:cookie];
    }

}
//========================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
    [delegate TwitterRequestSuccessfully:YES];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
    [delegate TwitterRequestSuccessfully:NO];
}

-(void)authenticatePerson
{
    NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	NSLog(@"authData = %@",[defaults objectForKey:@"authData"]);
    NSLog(@"username=%@",usernamee);
    if([usernamee length]==0){  
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
//        [_engine requestRequestToken];
		_engine.consumerKey    = kOAuthConsumerKey;
		_engine.consumerSecret = kOAuthConsumerSecret;	
        
        
        UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
        
        if (controller){
            [delegate TwitterLoad:controller];
        }
	}else{
        NSLog(@"value of userName %@",usernamee);
        [delegate TwitterDidLogin:authDataa userName:usernamee successfully:YES];
    }
}	

@end
