
#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import <IgaworksCore/IgaworksCore.h>
#import <AdPopcornOfferwall/AdPopcornOfferwall.h>
#import <AdPopcornOfferwall/AdPopcornStyle.h>
#import <Cordova/CDV.h>
#import "AppDelegate.h"

@interface IGAworksConnectPlugin : CDVPlugin <AdPopcornOfferwallDelegate, AdPopcornOfferwallClientRewardDelegate>
- (void)setUserID:(CDVInvokedUrlCommand *)command;
- (void)openOfferWall:(CDVInvokedUrlCommand *)command;
- (void)openDialogTypeOfferWall:(CDVInvokedUrlCommand *)command;
@end
