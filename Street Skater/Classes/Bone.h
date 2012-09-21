//
//  Bone.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Bone : CCSprite {
	
	CGPoint mapPoints[35];
	
	CCSprite *skater;
	
	BOOL dead;
	
	BOOL beganLoadingForJump;
	
	int jumpCount;
	float jumpFactor;
	int push;
	
}

- (void)kill;
- (void)loadNewMapData1;
- (void)update;
- (void)setTheTextue:(CCTexture2D *)texture;

@property (nonatomic) int yOffset;

@property (nonatomic) float ySpeed;
@property (nonatomic) float xSpeed;

@property (nonatomic) int yTile;
@property (nonatomic) int xTile;

@property (nonatomic) int offsetX;

@property (nonatomic) int desiredY;

@property (nonatomic,assign) CCTMXTiledMap *currentCollisionMap1;

@property (nonatomic) CGPoint originalPosition;

@property (nonatomic) BOOL willJump;

-(CGRect)collisionRect;

@end
