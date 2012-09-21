//
//  Weapon.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol WeaponDelegate <NSObject>

-(void)missed;
-(void)showThumb;

@end

@interface Weapon : CCSprite {

	bool gotHit;
	int number;
    
    BOOL didHit;
    int lifeCount;
}
@property (assign) id <WeaponDelegate> delegate;

-(void)throwWithSpeed:(float)withSpeed;
-(void)update;
-(void)didHit;
@property (nonatomic) float ySpeed;
@property (nonatomic) float xSpeed;
@end
