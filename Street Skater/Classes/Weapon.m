//
//  Weapon.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-05-03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Weapon.h"



@implementation Weapon
@synthesize ySpeed,xSpeed,delegate;
-(id)init {
	
	if( (self=[super init])) {
		
		
		xSpeed = 20 + arc4random() % 10;
		
		ySpeed = 10;
		
		
	}
	return self;
	
}

-(void)didHit {
    
	if(xSpeed > 0 && !gotHit){
		xSpeed = (xSpeed / 8);
		ySpeed -= 10;
        
	}
    didHit = YES;
	gotHit = YES;
}

-(void)throwWithSpeed:(float)uSpeed {
    
    didHit = NO;
    
    lifeCount = 0;
	
	int n = 0 + arc4random() % 19;
	
	if(n == 3 || n == 4 || n == 5 || n == 6){
	int b = 1 + arc4random() % 18;
	//self.texture = [[CCTextureCache sharedTextureCache] textureForKey:[NSString stringWithFormat:@"weapon%d.png",b ]];
		[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"weapon%d.png",b]]];

		number = b;
	}else{
		if(n == 0){
			
			int f = 1 + arc4random() % 5;
			//self.texture = [[CCTextureCache sharedTextureCache] textureForKey:[NSString stringWithFormat:@"cone%d.png",f]];	
			[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"cone%d.png",f]]];
		}else{
			[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"weapon%d.png",n]]];

		//self.texture = [[CCTextureCache sharedTextureCache] textureForKey:[NSString stringWithFormat:@"weapon%d.png",n]];	
		}
			number = n;
	}
	
	
	//self.texture = [[CCTextureCache sharedTextureCache] textureForKey:[NSString stringWithFormat:@"weapon%d.png",11]];	

	xSpeed = 20 + (uSpeed);
	//if(self.texture == [[CCTextureCache sharedTextureCache]textureForKey:@"weapon2.png"])
	//if(self.texture == [[CCTextureCache sharedTextureCache]textureForKey:@"weapon8.png"])self.rotation = -90;
		self.rotation = 0;
	ySpeed = 8 + arc4random() % 6;
	gotHit =  NO;

}

-(void)update{
	
	if(gotHit){
		self.rotation -= 5;

	}else{
		self.rotation += 2.5;
		if(number == 8)self.rotation += 4;
		if(number == 14)self.rotation += 10;
		if(number == 15)self.rotation += 8;
		
		if(number == 9)self.rotation += 6;
		if(number == 10)self.rotation += 6;
		if(number == 13)self.rotation += 6;
		if(number == 3)self.rotation += 6;

		if(number == 17)self.rotation += 6;
		if(number == 1)self.rotation += 6;
		if(number == 12)self.rotation += 6;
		if(number == 7)self.rotation += 6;
		if(number == 16)self.rotation += 6;
		//if(number == 0)self.rotation += 1;

		
		if(number ==2)self.rotation -= .5;
		if(number ==11)self.rotation -= 1.5;


	}
	
	self.position = ccp(self.position.x + xSpeed, self.position.y + ySpeed);
	if(self.position.x > -self.parent.position.x +1250){
		self.visible = NO;	
		
	}
    
    
    lifeCount ++;
    
    if(lifeCount == 45 && !didHit){
        
        [self.delegate missed];
        
    }
	
	ySpeed -= .6;
	
	
}


-(void)dealloc {
	
	[super dealloc];
	
}


@end
