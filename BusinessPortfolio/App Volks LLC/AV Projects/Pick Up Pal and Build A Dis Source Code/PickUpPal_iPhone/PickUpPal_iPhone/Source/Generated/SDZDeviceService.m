/*
	SDZDeviceService.m
	The implementation classes and methods for the DeviceService web service.
	Generated by SudzC.com
*/

#import "SDZDeviceService.h"
				
#import "Soap.h"
	

/* Implementation of the service */
				
@implementation SDZDeviceService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://appvolks.com/deviceservice.asmx";
			self.namespace = @"http://tempuri.org/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZDeviceService*) service {
		return [SDZDeviceService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZDeviceService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[SDZDeviceService alloc] initWithUsername:username andPassword:password];
	}

		
	/* Returns BOOL.  */
	- (SoapRequest*) SaveSharedJoke: (id <SoapDelegate>) handler target: (NSString*) target subject: (NSString*) subject joke: (NSString*) joke sharedby: (NSString*) sharedby sharedfrom: (NSString*) sharedfrom deviceType: (NSString*) deviceType
	{
		return [self SaveSharedJoke: handler action: nil target: target subject: subject joke: joke sharedby: sharedby sharedfrom: sharedfrom deviceType: deviceType];
	}

	- (SoapRequest*) SaveSharedJoke: (id) _target action: (SEL) _action target: (NSString*) target subject: (NSString*) subject joke: (NSString*) joke sharedby: (NSString*) sharedby sharedfrom: (NSString*) sharedfrom deviceType: (NSString*) deviceType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: target forName: @"target"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: subject forName: @"subject"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: joke forName: @"joke"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: sharedby forName: @"sharedby"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: sharedfrom forName: @"sharedfrom"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: deviceType forName: @"deviceType"]];
		NSString* _envelope = [Soap createEnvelope: @"SaveSharedJoke" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/SaveSharedJoke" postData: _envelope deserializeTo: @"BOOL"];
		[_request send];
		return _request;
	}

	/* Returns BOOL.  */
	- (SoapRequest*) IncrementAppVisitCount: (id <SoapDelegate>) handler appname: (NSString*) appname deviceType: (NSString*) deviceType
	{
		return [self IncrementAppVisitCount: handler action: nil appname: appname deviceType: deviceType];
	}

	- (SoapRequest*) IncrementAppVisitCount: (id) _target action: (SEL) _action appname: (NSString*) appname deviceType: (NSString*) deviceType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: appname forName: @"appname"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: deviceType forName: @"deviceType"]];
		NSString* _envelope = [Soap createEnvelope: @"IncrementAppVisitCount" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IncrementAppVisitCount" postData: _envelope deserializeTo: @"BOOL"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) Savedeviceinfo: (id <SoapDelegate>) handler deviceId: (NSString*) deviceId appName: (NSString*) appName
	{
		return [self Savedeviceinfo: handler action: nil deviceId: deviceId appName: appName];
	}

	- (SoapRequest*) Savedeviceinfo: (id) _target action: (SEL) _action deviceId: (NSString*) deviceId appName: (NSString*) appName
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: deviceId forName: @"deviceId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: appName forName: @"appName"]];
		NSString* _envelope = [Soap createEnvelope: @"Savedeviceinfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/Savedeviceinfo" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	