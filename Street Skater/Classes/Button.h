//
//  Button.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Button : CCSprite <CCTargetedTouchDelegate> {

}
@property (nonatomic) BOOL willScale;

@end
