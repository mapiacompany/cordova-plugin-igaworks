#import <Foundation/Foundation.h>
#import "NaverThirdPartyConstantsForApp.h"
#import "NaverThirdPartyLoginConnection.h"
#import "NLoginThirdPartyOAuth20InAppBrowserViewController.h"
#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface IGAworksConnectPlugin : CDVPlugin
	- (void)login:(CDVInvokedUrlCommand *)command;
	- (void)oauth20ConnectionDidOpenInAppBrowserForOAuth:(NSURLRequest *)request;
	- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode;
	- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken;
	- (void)oauth20ConnectionDidFinishDeleteToken;
	- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error;
    - (void) presentWebviewControllerWithRequest:(NSURLRequest *)urlRequest;
@end