//
//  Enemy.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Enemy : CCSprite {

CGPoint mapPoints[35];

	CCSprite *skater;
	
	CCSprite *shoe;
	CCSprite *body;
	CCSprite *head;
	CCSprite *shoe1;
	CCSprite *shoe2;
	
	CCSprite *specs;
	
	CCSprite *wheels;
	
	CCNode *headCntrlNode;
	CCNode *bodyCntrlNode;

	BOOL dead;
	
	BOOL beganLoadingForJump;
	
	
	
	int jumpCount;
	float jumpFactor;
	int push;
	
}

@property (nonatomic) float skaterXSpeed;

- (void)kill;
- (void)loadNewMapData1;
-(void)jumpWithPower:(float)power;
-(void)didGetHit;
-(void)update;
-(void)changeApperance;
@property (nonatomic) float ySpeed;
@property (nonatomic) float xSpeed;

@property (nonatomic) int yTile;
@property (nonatomic) int xTile;

@property (nonatomic) int offsetX;

@property (nonatomic) int desiredY;

@property (nonatomic,assign) CCTMXTiledMap *currentCollisionMap1;

@property (nonatomic) CGPoint originalPosition;

@property (nonatomic) BOOL willJump;


@property (nonatomic,assign) CCSprite *head;

@property (nonatomic,assign) CCSprite *body;

@property (nonatomic,assign) CCSprite *specs;


@property (nonatomic) BOOL goingUpHill;

-(CGRect)collisionRect;

@end
