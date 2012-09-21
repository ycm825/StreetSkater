//
//  Button.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Button.h"


@implementation Button
@synthesize willScale;


-(id)init{
	
	if( (self=[super init])) {
		self.willScale = YES;
	}
	return self;
}


- (void)onEnter {
	
	[super onEnter];
	
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	
	
	
}
- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(!self.parent.visible)return NO;
	if(!self.visible)return NO;
	
	CGPoint location = [touch locationInView: [touch view]];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	
	CGRect fireButtonRect = CGRectMake((self.position.x -self.contentSize.width  / 2) -5, (self.position.y- self.contentSize.height / 2) -5, self.contentSize.width +10 , self.contentSize.height +10);
	
	if(CGRectContainsPoint(fireButtonRect, location)){
		
		if(self.willScale){
			self.scale = 1.1;
		}else{
			//self.texture = [[CCTextureCache sharedTextureCache]textureForKey:@"btn1.png"];	
			[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"btn1.png"] ];
		}
		return YES;
		
	}
	
	return NO;
	
}

	- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent*)event
	{
		
		//UITouch *touch = [touches anyObject];
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		
		CGRect fireButtonRect = CGRectMake((self.position.x -self.contentSize.width  / 2) -5, (self.position.y- self.contentSize.height / 2) -5, self.contentSize.width +10 , self.contentSize.height +10);
		
		if(CGRectContainsPoint(fireButtonRect, location)){
			
			if(self.willScale){
				self.scale = 1.1;
			
			
			}else{
							[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"btn1.png"] ];
				//self.texture = [[CCTextureCache sharedTextureCache]textureForKey:@"btn1.png"];	
			}
		}else{
			
			if(self.willScale){
				self.scale = 1;
			}else{
							[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"btn2.png"] ];
				//self.texture = [[CCTextureCache sharedTextureCache]textureForKey:@"btn2.png"];	
			}
		}
		
	}


	- (void)ccTouchEnded:(UITouch*)touch withEvent:(UIEvent*)event
	{
			
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		CGRect fireButtonRect = CGRectMake((self.position.x -self.contentSize.width  / 2) -5, (self.position.y- self.contentSize.height / 2) -5, self.contentSize.width +10 , self.contentSize.height +10);
		
		if(CGRectContainsPoint(fireButtonRect, location)){
			
			if(self.willScale){
				self.scale = 1;
				
			}else{
							[self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"btn2.png"] ];
			//	self.texture = [[CCTextureCache sharedTextureCache]textureForKey:@"btn2.png"];	
			}
				[self.parent buttonTapped:self];
		}else{
		
		}
		
	}


-(void)dealloc {

	[super dealloc];	
}

@end
