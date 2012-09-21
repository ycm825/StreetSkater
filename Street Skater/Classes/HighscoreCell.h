//
//  HighscoreCell.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HighscoreCell : CCNode {

	CCLabelBMFont *nameLabel;
	
	CCLabelBMFont *scoreLabel;
	
	CCLabelBMFont *nameLabel2;
	CCLabelBMFont *scoreLabel2;	
}

@property (nonatomic,assign) NSString *name;
@property (nonatomic) int score;

-(void)setScoreForName:(NSString *)n score:(int)s;
-(void)setScoreForName:(NSString *)n score:(int)s myScore:(BOOL)b;


@end
