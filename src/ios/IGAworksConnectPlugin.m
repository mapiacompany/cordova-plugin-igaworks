#import <AdSupport/AdSupport.h>
#import <IgaworksCore/IgaworksCore.h>
#import <AdPopcornOfferwall/AdPopcornOfferwall.h>
#import <AdPopcornOfferwall/AdPopcornStyle.h>
#import "IGAworksConnectPlugin.h"


@implementation IGAworksConnectPlugin

    CDVInvokedUrlCommand *_command;

    - (void)pluginInitialize
    {
        if (NSClassFromString(@"ASIdentifierManager")){
            NSUUID *ifa =[[ASIdentifierManager sharedManager]advertisingIdentifier];
            BOOL isAppleAdvertisingTrackingEnalbed = [[ASIdentifierManager sharedManager]isAdvertisingTrackingEnabled];
            [IgaworksCore setAppleAdvertisingIdentifier:[ifa UUIDString] isAppleAdvertisingTrackingEnabled:isAppleAdvertisingTrackingEnalbed];

            NSLog(@"[ifa UUIDString] %@", [ifa UUIDString]);
        }
        
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString *appKey = [mainBundle objectForInfoDictionaryKey:@"IGAworksAppKey"];
        NSString *hashKey = [mainBundle objectForInfoDictionaryKey:@"IGAworksHashKey"];

        // Igaworks appkey, hashkey setting
        [IgaworksCore igaworksCoreWithAppKey:appKey andHashKey:hashKey];
        [IgaworksCore shared].useIgaworksRewardServer = NO;

        // 오퍼월 테마 색상 변경
        [AdPopcornStyle sharedInstance].adPopcornCustomThemeColor = [UIColor blackColor];

        // 오퍼월 타이틀 변경
        [AdPopcornStyle sharedInstance].adPopcornCustomOfferwallTitle = @"마피아 캐시 무료 충전";

        // 오퍼월 타이틀 색상 변경
        [AdPopcornStyle sharedInstance].adPopcornCustomOfferwallTitleColor = [UIColor whiteColor];

        // 오퍼월 Top/bottom bar 색상 변경
        [AdPopcornStyle sharedInstance].adPopcornCustomOfferwallTitleBackgroundColor = [UIColor blackColor];
    }

    - (void)setUserID:(CDVInvokedUrlCommand *)command
    {
        if ([command.arguments count] == 0) {
            // Not enough arguments
            CDVPluginResult *res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
            [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
            return;
        }

        NSString *userID = [command.arguments objectAtIndex:0];
        [IgaworksCore setUserId:userID];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: userID];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }

    - (void)openOfferWall:(CDVInvokedUrlCommand *)command
    {
        [AdPopcornOfferwall openOfferWallWithViewController:self.viewController delegate:self userDataDictionaryForFilter:nil];
        [AdPopcornOfferwall shared].delegate = self;
    }

    - (void)openDialogTypeOfferWall:(CDVInvokedUrlCommand *)command
    {
        [AdPopcornOfferwall openOfferWallWithViewController:self.viewController delegate:self userDataDictionaryForFilter:nil];
        [AdPopcornOfferwall shared].delegate = self;
    }

    /* ADPOPCORN OFFERWAL DELEGATES START */
    -(void)willOpenOfferWall {
        //Offerwall will be opened
    }
    -(void)didOpenOfferWall {
        //Offerwall did opened
    }
    -(void)willCloseOfferWall {
        //Offerwall will bel closed
    }
    -(void)didCloseOfferWall {
        //Offerwall did closed
    }
    /* ADPOPCORN OFFERWAL DELEGATES END */

    -(void)onRewardRequestResult:(BOOL)isSuccess withMessage:(NSString *)message items:(NSArray *)items{

    }

    - (void)onRewardCompleteResult:(BOOL)isSuccess withMessage:(NSString *)message resultCode:(NSInteger)resultCode withCompletedRewardKey:(NSString *)completedRewardKey {
        // RewardCompleteResult resultCode
        //    1 : Succeed
        //    100 : Error
        //    200 : Unknown Exception
        //    1400 : Invalid Appkey
        //    1410 : Incorrect reward server type
        //    3000 : Invalid Hashkey

        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: completedRewardKey];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];

        // 본 델리게이트의 수신 결과가 성공일 때에만 유저에게 리워드 지급 처리를 합니다.
        // 한번 지급 처리한 completedRewardKey 에 대해서는 다시 리워드 지급을 하면 안됩니다.
    }



@end