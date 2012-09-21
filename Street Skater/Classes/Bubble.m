//
//  Bubble.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bubble.h"


@implementation Bubble

-(id)init{
	
	if( (self=[super init])) {
	
		for(int i = 0 ; i < 14; i ++){
			
			letter[i] = [CCLabelBMFont labelWithString:@"a" fntFile:@"bFont.fnt"];
			
			letter[i].position = ccp(30 * i, 0);
			[self addChild:letter[i] z:i];
			
			miniLetter[i] = [CCLabelBMFont labelWithString:@"a" fntFile:@"bad.fnt"];
			
			miniLetter[i].position = ccp(30 * i, -30);
			[self addChild:miniLetter[i] z:i];
			
		
		}
		
	}
	return self;
}


-(void)setBounceStringTo:(NSString *)string {
	
	
	
	int u = [string length];
	
	self.position = ccp(240- ((u / 2) * 30) +25, 160 );
	
	for(int i = 0 ; i < 14; i ++){
		
		letter[i].position = ccp(30 * i, 400);

		if(i < u){
			
			letter[i].scale = 1;
			
			float tt = i *.06;
			
			float tt2 = i * .001;
			
			id del = [CCDelayTime actionWithDuration:tt  ];
			
			id del2 = [CCDelayTime actionWithDuration:tt2 ];
			
			id scal = [CCEaseBounceOut actionWithAction:[CCMoveTo actionWithDuration:1.5 position:ccp(letter[i ].position.x, -10)]];
			
		//	id scal2 = [CCEaseElasticIn actionWithAction:[CCScaleTo actionWithDuration:1 scale:0]];
			
			[letter[i] runAction:[CCSequence actions:del,scal,nil]];
			
			unichar testChar = [string characterAtIndex:i];
			letter[i].string = [NSString stringWithFormat:@"%c",testChar];
			letter[i].contentSize = CGSizeMake(letter[i].contentSize.width -4, letter[i].contentSize.height-4);
			
		}else{
			
			letter[i].string = @"";

		}
		
		
	}	
	
}


-(void)stopChildActions {
	
	
	for (CCNode *node in [self children]){
		
		[node stopAllActions];	
		[node cleanup];
	}
	
	for(int i = 0 ; i < 14; i ++){
		float tt = i *.01;
		
		id del = [CCDelayTime actionWithDuration:tt ];
		
		id scal2 = [CCEaseElastic actionWithAction:[CCScaleTo actionWithDuration:.15 scale:0]];
		
		[miniLetter[i] runAction:[CCSequence actions:del,scal2,nil]];
		
		
	}
	
}
	
	
-(BOOL)isRunningActions {
	
	for (CCNode *node in [self children]){
		
		if([node numberOfRunningActions] != 0){
			return YES;
		}
	}
	
	return NO;
}
-(void)hideLetters {
	
	
	for(int i = 0 ; i < 14; i ++){
	
	float tt = i *.01;
	
	id del = [CCDelayTime actionWithDuration:tt ];

		id scal1 = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.1 scale:1.5] rate:2];
	id scal2 = [CCEaseElastic actionWithAction:[CCScaleTo actionWithDuration:.15 scale:0]];
 
	[letter[i] runAction:[CCSequence actions:del,scal1,scal2,nil]];
		
		
	}
	
}

-(void)setStringTo:(NSString *)string miniString:(NSString *)miniString {
	
	int u = [string length];
	int u2 = [miniString length];

	self.position = ccp(240- ((u / 2) * 30) +25, 160 );

	for(int i = 0 ; i < 14; i ++){
		
		if(i < u){
			
			letter[i].scale = 0;
			miniLetter[i].scale = 0;

			float tt = i *.06;
			
			float tt2 = i * .001;
			
			id del = [CCDelayTime actionWithDuration:tt ];
			
			id del2 = [CCDelayTime actionWithDuration:tt2 ];

			id scal = [CCEaseElasticOut actionWithAction:[CCScaleTo actionWithDuration:1 scale:1]];

			id scal2 = [CCEaseElasticIn actionWithAction:[CCScaleTo actionWithDuration:1 scale:0]];

			id seq = [CCSequence actions:del,scal,del2,scal2,nil];
			
			
			[letter[i] runAction:seq];
			
			
			unichar testChar = [string characterAtIndex:i];
			letter[i].string = [NSString stringWithFormat:@"%c",testChar];
			letter[i].contentSize = CGSizeMake(letter[i].contentSize.width -4, letter[i].contentSize.height-4);
			
			if(i < u2){
				
				unichar testChar2 = [miniString characterAtIndex:i];
				miniLetter[i].string = [NSString stringWithFormat:@"%c",testChar2];
				miniLetter[i].contentSize = CGSizeMake(miniLetter[i].contentSize.width -4, miniLetter[i].contentSize.height-4);
				
				id del11 = [CCDelayTime actionWithDuration:tt ];
				
				id del211 = [CCDelayTime actionWithDuration:tt2 ];
				
				id scal11 = [CCEaseElasticOut actionWithAction:[CCScaleTo actionWithDuration:1 scale:1]];
				
				id scal211 = [CCEaseElasticIn actionWithAction:[CCScaleTo actionWithDuration:1 scale:0]];
				
				id seq11 = [CCSequence actions:del11,scal11,del211,scal211,nil];
				
				[miniLetter[i] runAction:seq11];
				
			}else{
				
				miniLetter[i].string = @"";
			
				
			}
			
		}else{
			miniLetter[i].string = @"";
			letter[i].string = @"";

		}
		
		letter[i].position = ccp((30 * i), arc4random() % 10);
	
		miniLetter[i].position = ccp((( u / 2) * 30) + ((i - 4) * 20) ,-50);

		
	}	
	
}


-(void)dealloc {
	
	[super dealloc];
	
}


@end
