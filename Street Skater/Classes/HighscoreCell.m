//
//  HighscoreCell.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighscoreCell.h"


@implementation HighscoreCell
@synthesize name,score;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		nameLabel = [CCLabelBMFont labelWithString:@"" fntFile:@"bad.fnt"];

		scoreLabel = [CCLabelBMFont labelWithString:@"" fntFile:@"bad.fnt"];
		
		nameLabel2 = [CCLabelBMFont labelWithString:@"" fntFile:@"bad2.fnt"];
		
		scoreLabel2 = [CCLabelBMFont labelWithString:@"" fntFile:@"bad2.fnt"];

		nameLabel.scale = .75;
		scoreLabel.scale = .75;		
		[self addChild:nameLabel];
		[self addChild:scoreLabel];
		
		nameLabel.anchorPoint = ccp(0,1);
		scoreLabel.anchorPoint = ccp(1,1);

		nameLabel.position = ccp(20, 0);
		scoreLabel.position = ccp(460, 0);
		
		nameLabel2.scale = .75;
		scoreLabel2.scale = .75;		
		[self addChild:nameLabel2];
		[self addChild:scoreLabel2];
		
		nameLabel2.anchorPoint = ccp(0,1);
		scoreLabel2.anchorPoint = ccp(1,1);
		
		nameLabel2.position = ccp(20, 0);
		scoreLabel2.position = ccp(460, 0);
		
		
		
	}
	return self;
	
}

-(void)setScoreForName:(NSString *)n score:(int)s myScore:(BOOL)b{
	[nameLabel2 setString:n];
	
	[scoreLabel2 setString:[NSString stringWithFormat:@"%d",s]];
	
	
}

-(void)setScoreForName:(NSString *)n score:(int)s {
	
	[nameLabel setString:n];
	
	[scoreLabel setString:[NSString stringWithFormat:@"%d",s]];
	
	
}


-(void)dealloc {
	
	[super dealloc];
	
}
@end
