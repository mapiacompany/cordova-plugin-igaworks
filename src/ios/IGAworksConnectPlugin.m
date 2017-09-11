#import "NaverThirdPartyConstantsForApp.h"
#import "NLoginThirdPartyOAuth20InAppBrowserViewController.h"
#import "NaverLoginPlugin.h"

@implementation IGAworksConnectPlugin

CDVInvokedUrlCommand *_command;

- (void)pluginInitialize
{
    NaverThirdPartyLoginConnection *thirdConn = [NaverThirdPartyLoginConnection getSharedInstance];
    thirdConn.delegate = self;
    [thirdConn setIsNaverAppOauthEnable:YES];
    [thirdConn setIsInAppOauthEnable:YES];
    [thirdConn setServiceUrlScheme:kServiceAppUrlScheme];
    [thirdConn setConsumerKey:kConsumerKey];
    [thirdConn setConsumerSecret:kConsumerSecret];
    [thirdConn setAppName:kServiceAppName];

}

- (void)login:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [[NaverThirdPartyLoginConnection getSharedInstance] requestThirdPartyLogin];
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode
{
    [self.commandDelegate runInBackground:^{
        NSString *accessToken = [[NaverThirdPartyLoginConnection getSharedInstance] accessToken];

        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: accessToken];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)oauth20ConnectionDidOpenInAppBrowserForOAuth:(NSURLRequest *)request
{
    [self presentWebviewControllerWithRequest:request];
}

- (void) presentWebviewControllerWithRequest:(NSURLRequest *)urlRequest   {
    // FormSheet모달위에 FullScreen모달이 뜰 떄 애니메이션이 이상하게 동작하여 애니메이션이 없도록 함
    NLoginThirdPartyOAuth20InAppBrowserViewController *inAppBrowserViewController = [[NLoginThirdPartyOAuth20InAppBrowserViewController alloc] initWithRequest:urlRequest];
    inAppBrowserViewController.parentOrientation = (UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
    [self.viewController presentViewController:inAppBrowserViewController animated:NO completion:nil];
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken
{
    [self.commandDelegate runInBackground:^{
        NSString *accessToken = [[NaverThirdPartyLoginConnection getSharedInstance] accessToken];

        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: accessToken];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}
- (void)oauth20ConnectionDidFinishDeleteToken
{

}
- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error
{

}

@end