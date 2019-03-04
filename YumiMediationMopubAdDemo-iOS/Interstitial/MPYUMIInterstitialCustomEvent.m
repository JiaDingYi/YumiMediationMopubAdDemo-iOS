//
//  MPYUMIInterstitialCustomEvent.m
//  YumiMediationMopubAdDemo-iOS
//
//  Created by Michael Tang on 2019/3/4.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import "MPYUMIInterstitialCustomEvent.h"
#import <YumiMediationSDK/YumiMediationInterstitial.h>

@interface MPYUMIInterstitialCustomEvent() <YumiMediationInterstitialDelegate>

@property (nonatomic)YumiMediationInterstitial *interstitial;

@end

@implementation MPYUMIInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info{
    NSString *placementId =  [info objectForKey:@"placementId"];
    NSString *channelId =  [info objectForKey:@"channelId"];
    NSString *versionId =  [info objectForKey:@"versionId"];
    
    self.interstitial = [[YumiMediationInterstitial alloc] initWithPlacementID:placementId channelID:channelId versionID:versionId rootViewController:nil];
    self.interstitial.delegate = self;
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController{
    if ([self.interstitial isReady]) {
        [self.interstitial present];
        if ([self.delegate respondsToSelector:@selector(interstitialCustomEventWillAppear:)]) {
            [self.delegate interstitialCustomEventWillAppear:self];
        }
        if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidAppear:)]) {
            [self.delegate interstitialCustomEventDidAppear:self];
        }
    }
}
- (BOOL)enableAutomaticImpressionAndClickTracking{
    return YES;
}
#pragma mark: YumiMediationInterstitialDelegate
- (void)yumiMediationInterstitialDidReceiveAd:(YumiMediationInterstitial *)interstitial{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
        [self.delegate interstitialCustomEvent:self didLoadAd:interstitial];
    }
}

/// Tells the delegate that the interstitial ad request failed.
- (void)yumiMediationInterstitial:(YumiMediationInterstitial *)interstitial
                 didFailWithError:(YumiMediationError *)error{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
    }
    
}

/// Tells the delegate that the interstitial is to be animated off the screen.
- (void)yumiMediationInterstitialWillDismissScreen:(YumiMediationInterstitial *)interstitial{
    
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventWillDisappear:)]) {
        [self.delegate interstitialCustomEventWillDisappear:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
        [self.delegate interstitialCustomEventDidDisappear:self];
    }
}

/// Tells the delegate that the interstitial ad has been clicked.
- (void)yumiMediationInterstitialDidClick:(YumiMediationInterstitial *)interstitial{
    if ([self.delegate respondsToSelector:@selector(interstitialCustomEventDidReceiveTapEvent:)]) {
        [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
    }
}
@end
