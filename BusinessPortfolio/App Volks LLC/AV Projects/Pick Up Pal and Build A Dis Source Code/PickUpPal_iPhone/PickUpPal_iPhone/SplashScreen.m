//
//  SplashScreen.m
//  PicAPal
//
//  Created by USER USER on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashScreen.h"
#import "HomeScreenView.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "SDZServices.h"
#import "SDZDeviceService.h"
#import "UIDevice+Resolutions.h"
#import "SDZDeviceServiceExample.h"
#import "ShopView.h"
#import "APPObject.h"

extern NSString *strSoapRequest;

@implementation SplashScreen
@synthesize imageViewSplash,strCurrentElement;
@synthesize delegateApp;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.navigationController setNavigationBarHidden:YES];
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        NSLog(@"UIDevice_iPhoneTallerHiRes ");
        
        
        
        }
       
  // [self performSelector:@selector(toGetPreview) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(toGetPreview)];
    // Do any additional setup after loading the view from its nib.
}


-(void)homeScreen
{

    HomeScreenView *homeScreenView=[[HomeScreenView alloc]init];
    [self.navigationController pushViewController:homeScreenView animated:YES];
    
}


#pragma mark - webservice To get Preview data 
-(void)toGetPreview
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
        
        [self performSelector:@selector(homeScreen) withObject:nil afterDelay:2.0];       
        //  [alertView release];
    }else {
        SDZDeviceService* service = [SDZDeviceService service];
        service.logging = YES;
        NSString *udid =[APPObject createUUID];
        udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [service Savedeviceinfo:self action:@selector(GetFeedsByUserIDHandler:) deviceId:udid appName:@"IPhonePickUpPal"];
    }
    
}


#pragma Mark - handler
- (void) GetFeedsByUserIDHandler: (id) value {
    
    // Handle errors
    
    if([value isKindOfClass:[NSError class]]) {
        // NSLog(@"%@", value);
        [self performSelector:@selector(homeScreen) withObject:nil afterDelay:1.0];
        //---- Set view user inter action anable when image posting failed --------
        return;
        
    }
    
    if([value isKindOfClass:[SoapFault class]]) {
        
        //NSLog(@"%@", value);
       [self performSelector:@selector(homeScreen) withObject:nil afterDelay:1.0];
        //---- Set view user inter action anable when image posting failed --------
        
              
        return;
        
    }
    
    
    //  NSLog(@"SaveMedia returned the value: %@", result);// i基于古代的经典著作圣经
    NSString *result1= [strSoapRequest stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *result2= [result1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSLog(@"result2  %@",result2);
    NSData *aData = [[NSData alloc] initWithData:[result2 dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:aData];//dataUsingEncoding: NSASCIIStringEncoding];
    
    [parser setDelegate:self];
    
    [parser parse];

    
}

#pragma  Mark -  parser Delegate 


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"Table"]) {
        
        [delegateApp.arrayPopInfo addObject:attributeDict];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
//    for (int i=0; i<[delegateApp.arrayPopInfo count]; i++) {
//        
//        NSString *strShowPopUp=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Location"]];
//        if ([strShowPopUp isEqualToString:@"Upon Loading"]) {
//            
//            NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
//            if ([strLink isEqualToString:@"Store"]) {
//                CheckPopUp=YES;
//                checkStore=YES;
//                UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//                
//                [alert show];
//                
//                
//            }else
//            {
//                CheckPopUp=YES;
//                strURl=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
//                UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
//                
//                [alert show];
//                
//            }            
//        }
//    }
//    
//    if (CheckPopUp==NO) {
        [self performSelector:@selector(homeScreen)];
   // }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//#pragma Mark - Alert View delegate 
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    NSString *strButtonTitle=[alertView buttonTitleAtIndex:buttonIndex];
//    if ([strButtonTitle isEqualToString:@"Yes"]) {
//        
//        if (checkStore==YES) {
//            ShopView *sV=[[ShopView alloc]init];
//            [self presentModalViewController:sV animated:YES];
//            [self performSelector:@selector(Home) withObject:nil afterDelay:1.0];
//            
//        }else
//        {
//            NSString *urlstring = [[NSString alloc] initWithFormat:@"%@",strURl];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
//            [self performSelector:@selector(homeScreen)];
//            return;
//        }
//    }else
//    {
//        [self performSelector:@selector(homeScreen)];
//    }
//    
//}

//-(void)Home
//{
//    HomeScreenView *homeScreenView=[[HomeScreenView alloc]init];
//    [self.navigationController pushViewController:homeScreenView animated:NO];
//}



@end
