//
//  Street_SkaterAppDelegate.h
//  Street Skater
//
//  Created by Daniel Grönlund on 2011-07-31.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appirater.h"

@class RootViewController;

@interface Street_SkaterAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
