
#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface IGAworksConnectPlugin : CDVPlugin <AdPopcornOfferwallClientRewardDelgate>
- (void)setUserID:(CDVInvokedUrlCommand *)command;
- (void)openOfferWall:(CDVInvokedUrlCommand *)command;
- (void)openDialogTypeOfferWall:(CDVInvokedUrlCommand *)command;
@end
