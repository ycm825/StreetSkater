//
//  HighscoreLayer.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocoslive.h"
#import "cocos2d.h"
#import "Globals.h"
#import "HighscoreCell.h"
#import "Button.h"


@interface HighscoreLayer : CCLayer <CCTargetedTouchDelegate>{

	bool wifiAlert;
	UITextField *nameField;
	int score;
	int firstTouch;
	
	CCNode *scrollNode;
	
	float ySpeed;
	
	int positionOffset;
	
	bool touchDown;
	
	tQueryFlags currentFlags;
	Button *more;
}

-(void)cleanAll;
-(void)buttonTapped:(Button*)btn;

@property (nonatomic) int score;
-(void)showAlert;
-(void)showWifiAlert;
-(void) postScoreWithName:(NSString *)name;
-(void)requestScore:(tQueryFlags)flag offset:(int)offset;

@end
