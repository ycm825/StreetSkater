//
//  Enemy.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

#define maxSpeed 30

@implementation Enemy
@synthesize ySpeed,xSpeed,yTile,xTile,desiredY,currentCollisionMap1,offsetX,originalPosition,willJump;
@synthesize head,body,specs,skaterXSpeed,goingUpHill;

-(id)init {
    
	if( (self=[super init])) {
		
		skater = [CCSprite spriteWithSpriteFrameName:@"skater.png"];
		[self addChild:skater z:1 ];
		wheels = [CCSprite spriteWithSpriteFrameName:@"wheels.png"];
		[skater addChild:wheels z:-1];
		
		skater.position = ccp(	skater.position.x,	skater.position.y + 10);
		wheels.position = ccp(wheels.position.x +(wheels.contentSize.width / 2) +5, wheels.position.y + 13);
		xSpeed = 20;
		
		shoe1 = [CCSprite spriteWithSpriteFrameName:@"shoe1.png"];
		shoe2 = [CCSprite spriteWithSpriteFrameName:@"shoe2.png"];
		
		body = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"enemyBody%d.png", 1 + arc4random() % 5]];

		NSString *headString = [NSString stringWithFormat:@"enemyHead%d.png", 1 + arc4random() % 20];
	
		head = [CCSprite spriteWithSpriteFrameName:headString];
		
		[skater addChild:shoe1];
		[skater addChild:shoe2];
		
		CCNode *bd = [CCNode node];
		[skater addChild:bd];
		CCNode *hd = [CCNode node];
		[skater addChild:hd];
		
		bodyCntrlNode = [CCNode node];
		headCntrlNode = [CCNode node];
		[bd addChild:bodyCntrlNode];
		[hd addChild:headCntrlNode];
		
		[bodyCntrlNode addChild:body];
		[headCntrlNode addChild:head];
		
		if(arc4random() % 2 == 1){
			
			NSString *specString = [NSString stringWithFormat:@"specs%d.png",1 + arc4random() % 4];
		
			specs = [CCSprite spriteWithSpriteFrameName:specString];
			[headCntrlNode addChild:specs];

		}else{
			
			specs = [CCSprite spriteWithSpriteFrameName:@"specs1.png"];
			[headCntrlNode addChild:specs];
			specs.visible = NO;

		}
		
		shoe1.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);
		shoe2.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);

		body.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);

		head.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);

		specs.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);

		
		
	}
	return self;
}

-(void)kill {
	
	dead = YES;
	
	body.visible = YES;
	head.visible = YES;
	specs.visible = YES;
	shoe1.visible = YES;
	shoe2.visible = YES;
		
}

-(void)didGetHit {
	

	id moveHead = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(15,0)] rate:2.0];

	id moveBody = [CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(6,0)] rate:2.0];

	if([headCntrlNode.parent numberOfRunningActions] == 0){
	CCSequence *hSeq = [CCSequence actions:moveHead,[moveHead reverse],nil];
	[headCntrlNode.parent runAction:hSeq];
	
	CCSequence *bSeq = [CCSequence actions:moveBody,[moveBody reverse],nil];
	[bodyCntrlNode.parent runAction:bSeq];
		
	}
	
	
}

-(void)jumpWithPower:(float)power {
	
	int x = ((self.position.x - currentCollisionMap1.position.x)) / currentCollisionMap1.tileSize.width;
	float fract = ((((self.position.x) -10) - (x * (currentCollisionMap1.tileSize.width))) -currentCollisionMap1.position.x) / currentCollisionMap1.tileSize.width;

	int yPosition = ((mapPoints[x].y) + ((mapPoints[x+1].y - mapPoints[x].y) * fract) +75 ) + currentCollisionMap1.position.y;

	desiredY = (currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height) - (yPosition - currentCollisionMap1.position.y) / currentCollisionMap1.tileSize.height;

	int y = (currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height) - ((self.position.y - currentCollisionMap1.position.y) / currentCollisionMap1.tileSize.height);
	yTile = y;
	if(desiredY - y <= 1 && ySpeed == 0){
	
	ySpeed = 0;
	jumpFactor = power;
	
	beganLoadingForJump = YES;
	
	jumpCount = power;
		if([skater numberOfRunningActions] == 0){
	id rot =[CCSpawn actions:[CCEaseInOut actionWithAction:[CCRotateTo actionWithDuration:.1 angle:skater.rotation-13 ]rate:2.0] , [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.03 position:ccp(0,-8)] rate:2.0], nil ];
	
	//id rot2 = [CCEaseIn actionWithAction:[CCRotateTo actionWithDuration:.2 angle:0 ]rate:1.0];
	
	CCSequence *seq = [CCSequence actions:rot,nil];
	
	[skater runAction:seq];
	
		}
		
		if([body numberOfRunningActions] == 0){
	id moveBod = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(0,-3)]rate:2.0];
	
	CCSequence *bodySequence = [CCSequence actions:moveBod,[moveBod reverse],nil];
	[body runAction:bodySequence];
		}
		
	if([head numberOfRunningActions] == 0){
		
	id moveHead = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(0,-6)]rate:2.0];
	
	CCSequence *headSequence = [CCSequence actions:moveHead,[moveHead reverse],nil];
	

		[head runAction:headSequence];
		
		id moveSpecs = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(0,-6)]rate:2.0];

		CCSequence *headSequence2 = [CCSequence actions:moveSpecs,[moveSpecs reverse],nil];
		[specs runAction:headSequence2];
	}
		if([shoe1 numberOfRunningActions] == 0){
		id moveFeet = [CCEaseExponentialInOut actionWithAction:[CCMoveBy actionWithDuration:.0 position:ccp(-3,-1)]];
	
	id moveFeet5 = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.3 position:ccp(3,1)] rate:2.0];
	
	
	CCSequence *feetSeq = [CCSequence actions:moveFeet,moveFeet5,nil];
	[shoe1 runAction:feetSeq]; 
		}
		if([shoe2 numberOfRunningActions] == 0){
	id moveFeet2 = [CCEaseExponentialInOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(0,0)]];
	CCSequence *feetSeq2 = [CCSequence actions:moveFeet2,[moveFeet2 reverse],nil];
	[shoe2 runAction:feetSeq2]; 
			
		}
	
	}
	
}



-(void)changeApperance {
	
	if(!body.visible){
		
		body.visible = YES;
		head.visible = YES;
		specs.visible = YES;
		shoe1.visible = YES;
		shoe2.visible = YES;
		
	}
	NSString *headString = [NSString stringWithFormat:@"enemyHead%d.png", 1 + arc4random() % 20];
	
	//head.texture = [[CCTextureCache sharedTextureCache] textureForKey:headString];
	[head setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:headString]];


	NSString *bodyString = [NSString stringWithFormat:@"enemyBody%d.png", 1 + arc4random() % 5];
	[body setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:bodyString]];

	//body.texture = [[CCTextureCache sharedTextureCache] textureForKey:bodyString];

	if(arc4random() % 2 == 1){
		
		NSString *specString = [NSString stringWithFormat:@"specs%d.png",1 + arc4random() % 4];
		[specs setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:specString]];

		//specs.texture = [[CCTextureCache sharedTextureCache]textureForKey:specString];
		specs.visible = YES;
	}else{
		[specs setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"specs1.png"]];

		//specs.texture = [[CCTextureCache sharedTextureCache]textureForKey:@"specs1.png"];
		specs.visible = NO;
	}
	
}

-(void)update {
	/*
	if(self.position.x + self.parent.position.x > 1324){
		
		self.xSpeed = self.skaterXSpeed;
		self.position  = ccp(-self.parent.position.x + 1284, self.position.y);
		
		//NSLog(@"YEAH");	
		[self loadNewMapData1];
		
	}
	*/
	
	if(xSpeed > maxSpeed)xSpeed = xSpeed * .999;

	if(willJump == YES){
		
		
		[self jumpWithPower:4];
		willJump = NO;
	}
	if(beganLoadingForJump){
		
	ySpeed -= jumpFactor;
	if(floor(jumpFactor) == 0)beganLoadingForJump = NO;
		
	}
	jumpFactor = jumpFactor * .80;

	if(dead){
		
		xSpeed = xSpeed * .99;
	
	}
	
	bodyCntrlNode.position = ccp((skater.rotation) * .4,-(skater.rotation) * .1);
	
	headCntrlNode.position = ccp((skater.rotation) * .6,-(skater.rotation) * .1);
	
	bodyCntrlNode.rotation = -(skater.rotation) * .4;
	
	headCntrlNode.rotation = -(skater.rotation) * .4;
	
	
	//if(xSpeed != 20)xSpeed = xSpeed -(xSpeed -20) * -001;
	
	push = push * .80;
	
	xSpeed = xSpeed + push;
	
	int offset = ySpeed;
	
	if(offset > 10)offset = 10;
	if(offset < -10)offset = -10;
	
	
	wheels.rotation = -skater.rotation * .15;
	
	wheels.position = ccp(((wheels.contentSize.width / 2) +7) - skater.rotation * .01,15);
	
	skater.position = ccp(skater.rotation * .3, 25 -  ((skater.position.x - offset) - offset)  * .1 );
	
		//[currentCollisionMap1 convertToNodeSpace:self.position].x
	int x = ((self.position.x - currentCollisionMap1.position.x)) / currentCollisionMap1.tileSize.width;
	
	xTile = x;
	
	
	int y = (currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height) - ((self.position.y - currentCollisionMap1.position.y) / currentCollisionMap1.tileSize.height);
	
	yTile = y;
	float fract = ((((self.position.x) -10) - (x * (currentCollisionMap1.tileSize.width))) -currentCollisionMap1.position.x) / currentCollisionMap1.tileSize.width;
	
	int yPosition = ((mapPoints[x].y) + ((mapPoints[x+1].y - mapPoints[x].y) * fract) +75 ) + currentCollisionMap1.position.y;
	
	//NSLog(@"%d , %f",x,mapPoints[x].y);
	
	
	if(desiredY - y <= 1){
		
		if(x < (currentCollisionMap1.contentSize.width / currentCollisionMap1.tileSize.width) -1 && x > 0){
			
			if((mapPoints[x+1].y-mapPoints[x].y) > 0){
			//	skater.rotation = -(mapPoints[x+1].y-mapPoints[x].y) * .5;
				
				skater.rotation = skater.rotation -(skater.rotation  +20) *.35;
				
			}else if((mapPoints[x-1].y-mapPoints[x].y) > 0 && desiredY - y == 0){
				//skater.rotation = -(mapPoints[x+1].y-mapPoints[x].y) * .5;
				
				skater.rotation = skater.rotation -(skater.rotation  -20) *.35;
				
			}else if((mapPoints[x+1].y-mapPoints[x].y) == 0 && ySpeed >=0){
				
				skater.rotation = skater.rotation * .5;
				
			}
			
		}
		
	}
	
	if(self.position.y - ySpeed > yPosition){
		
		self.position = ccp(self.position.x +xSpeed , self.position.y -ySpeed );
		
		if(desiredY - y > 0){
			
			ySpeed += .8;
			
			skater.rotation = skater.rotation *.95;
			
		}else{
			
		}
		
		}else{
		
			if(ySpeed < 3 &&  [head numberOfRunningActions] == 0 &&  [body numberOfRunningActions] == 0 ){
				
				id moveBod = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 6)]rate:2.0];
				
				CCSequence *bodySequence = [CCSequence actions:moveBod,[moveBod reverse],nil];
				[body runAction:bodySequence];
				
				id moveHead = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 4)]rate:2.0];
				
				CCSequence *headSequence = [CCSequence actions:moveHead,[moveHead reverse],nil];
				[head runAction:headSequence];	
			
				
				id moveHead2 = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 4)]rate:2.0];
				
				CCSequence *headSequence2 = [CCSequence actions:moveHead2,[moveHead2 reverse],nil];
				
				[specs runAction:headSequence2];
				
			}
			
			if(ySpeed > 3 && ySpeed > 0 &&  [head numberOfRunningActions] == 0 &&  [body numberOfRunningActions] == 0 ){
				
				id moveBod = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 4)]rate:2.0];
				
				CCSequence *bodySequence = [CCSequence actions:moveBod,[moveBod reverse],nil];
				[body runAction:bodySequence];
				
				id moveHead = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 2)]rate:2.0];
				
				CCSequence *headSequence = [CCSequence actions:moveHead,[moveHead reverse],nil];
				[head runAction:headSequence];	
				
				id moveHead2 = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 2)]rate:2.0];
				
				CCSequence *headSequence2 = [CCSequence actions:moveHead2,[moveHead2 reverse],nil];
				
				[specs runAction:headSequence2];
			}
			
			
			if(x < (currentCollisionMap1.contentSize.width / currentCollisionMap1.tileSize.width) -1 && x > 0){

			self.goingUpHill = NO;
				
			if((mapPoints[x+1].y - mapPoints[x].y) > 0){
				
				ySpeed -= 2;
				self.goingUpHill = YES;	
				xSpeed = xSpeed *.995;
				
			}else if((mapPoints[x+1].y - mapPoints[x].y) < 0){
				
				xSpeed += .1;
				
			}else{
				
			ySpeed = 0;
			
			}
			
			}
		
		self.position = ccp( self.position.x + xSpeed , yPosition );	
		
	}
	
	desiredY = (currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height) - (yPosition - currentCollisionMap1.position.y) / currentCollisionMap1.tileSize.height;
	
	
	if(desiredY == yTile){
		
	}
		
}

-(void)loadNewMapData1 {
	int lastX;
	for(int x1 = 0; x1 < currentCollisionMap1.contentSize.width / currentCollisionMap1.tileSize.width; x1++){
		
		for(int y1 = 0; y1 < currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height;y1 ++){
			
			if([[currentCollisionMap1 layerNamed:@"top"] tileGIDAt:ccp(x1,y1)] != 0){
				
				//NSLog(@"%f", y1 * currentCollisionMap.tileSize.height);
				
				mapPoints[x1] = ccp(x1 * currentCollisionMap1.tileSize.width, currentCollisionMap1.contentSize.height -( y1 * currentCollisionMap1.tileSize.height ));
				
				break;
				
			}
			
		}
		lastX = x1;
	}
	
	for(int f = lastX; f < lastX + 3; f ++){
		
		mapPoints[f] = mapPoints[lastX];
		
	}
	
}

-(CGRect)collisionRect {
	
	return CGRectMake(self.position.x  - self.contentSize.width / 2, self.position.y - self.contentSize.height / 2, self.contentSize.width , self.contentSize.height);
	
}

-(void)dealloc {
	
	[super dealloc];
	
}

@end
