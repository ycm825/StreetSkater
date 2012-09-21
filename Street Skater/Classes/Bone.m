//
//  Bone.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bone.h"

#define maxSpeed 30

@implementation Bone
@synthesize ySpeed,xSpeed,yTile,xTile,desiredY,currentCollisionMap1,offsetX,originalPosition,willJump,yOffset;

-(id)init{
	
	if( (self=[super init])) {
		
		skater = [CCSprite spriteWithSpriteFrameName:@"blank.png"];
		[self addChild:skater z:1];
		
	}
	return self;
}

-(void)setTheTextue:(CCTexture2D*)texture {
	
	//skater.texture = texture;
	//[skater setTextureRect:CGRectMake(0, 0, skater.textureRect.size.width, skater.textureRect.size.height)];

	
}

-(void)kill {
	
	dead = YES;
		
}

-(void)didGetHit {
	
	
	
	
}


-(void)blink {
	
	id delay = [CCDelayTime actionWithDuration:.15];
	id fadeIn = [CCFadeIn actionWithDuration:.05];
	id fadeOut = [CCFadeOut actionWithDuration:.05];
	
	[skater runAction:[CCSequence actions:fadeIn,delay,fadeOut,delay,fadeIn,delay,fadeOut,delay,fadeIn,nil]];
	
	
}

-(void)changeApperance {
	
}

-(void)update {
	

	if(xSpeed > 0)xSpeed = xSpeed * .98;
	
	if(dead){
		
		xSpeed = xSpeed * .99;
		
	}
	
	//if(xSpeed != 20)xSpeed = xSpeed -(xSpeed -20) * -001;
	
	push = push * .80;
	
	xSpeed = xSpeed + push;
	
	int offset = ySpeed;
	
	if(offset > 10)offset = 10;
	if(offset < -10)offset = -10;
	
	skater.position = ccp(skater.rotation * .3, -30 + yOffset -  ((skater.position.x - offset) - offset)  * .1 );
	
	//[currentCollisionMap1 convertToNodeSpace:self.position].x
	int x = ((self.position.x - currentCollisionMap1.position.x)) / currentCollisionMap1.tileSize.width;
	
	xTile = x;
	
	int y = (currentCollisionMap1.contentSize.height / currentCollisionMap1.tileSize.height) - ((self.position.y - currentCollisionMap1.position.y) / currentCollisionMap1.tileSize.height);
	
	yTile = y;
	float fract = ((((self.position.x) -10) - (x * (currentCollisionMap1.tileSize.width))) -currentCollisionMap1.position.x) / currentCollisionMap1.tileSize.width;
	
	int yPosition = ((mapPoints[x].y) + ((mapPoints[x+1].y - mapPoints[x].y) * fract) +75 ) + currentCollisionMap1.position.y;
	
	
	
	if(self.position.y - ySpeed < yPosition){
		ySpeed = -(ySpeed / 2);
		if(skater.texture == [[CCTextureCache sharedTextureCache] textureForKey:@"bomb.png"]){
			
			ySpeed = 0;	
			
		}
	}
	
	
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
			
		}
		
	}else{
		
	
		
		if(x < (currentCollisionMap1.contentSize.width / currentCollisionMap1.tileSize.width) -1 && x > 0){
			
			if((mapPoints[x+1].y - mapPoints[x].y) > 0){
				
				ySpeed -= 2;
				
				//xSpeed -= .1;
				
			}else if((mapPoints[x+1].y - mapPoints[x].y) < 0){
				
				xSpeed += .1;
				
				
			}else{
				
				
				
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
