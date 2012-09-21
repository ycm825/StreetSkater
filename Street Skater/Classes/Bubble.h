//
//  Bubble.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-05-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Bubble : CCNode {

	CCLabelBMFont *letter[14];
	
	CCLabelBMFont *miniLetter[14];

	
	
}
-(void)stopChildActions;
-(void)setBounceStringTo:(NSString *)string;
-(BOOL)isRunningActions;
-(void)setStringTo:(NSString *)string miniString:(NSString *)miniString;
-(void)hideLetters;
@end
