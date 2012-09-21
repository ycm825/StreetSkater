//
//  HelloWorldLayer.h
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-18.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Enemy.h"
#import "Weapon.h"
#import "Bone.h"
#import "SimpleAudioEngine.h"
#import "Bubble.h"
#import "Button.h"
#import "HighscoreLayer.h"
// HelloWorldLayer
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "Appirater.h"
#import "RootViewController.h"



@interface HelloWorldLayer : CCLayer  <MFMailComposeViewControllerDelegate , WeaponDelegate>
{
	int pauseTimeCount;
	int currentHeightLevel;
	CCNode *controllerNode;
	
	float xSpeed;
	float ySpeed; 
	CCSprite *skater;
	
	CCSprite *shoe;
	CCSprite *body;
	CCSprite *head;
	CCSprite *shoe1;
	CCSprite *shoe2;
	CCSprite *specs;
	
	CCNode *bodyCntrlNode;
	CCNode *headCntrlNode;
	
	CCSprite *skateBoarder;
	
	CCTMXLayer *collisionLayer;
	
	CCTMXTiledMap *currentCollisionMap;
	int downHill;
	
	NSMutableArray *maps;
	
	int currentMaps;
	
	CCTMXTiledMap *lastMap;
	
	float jumpPlower;
	
	BOOL beganLoadingForJump;
	
	float jumpPower;
	BOOL rampTakenCareOf;
	BOOL canJump;
	CCSprite *shadow;
	
	CCTMXTiledMap *willDissapear;
	
	float gravityForce;
	CCSprite *wheels;
	
	BOOL blackOut;
	
	BOOL fallThrough;
	
	float loadingJumpPower;
	
	int lastYposition;
	
	float xSpeed2;
	
	float jumpFactor;
	
	CGPoint mapPoints[35];
	
	Enemy *enemy;
	
	int lastYpos; 
	
	int jumpCount;
	
	CCSprite *fireButton;
	
	CCNode *cloudNode;
	
	CCSprite *arm;
	
	int lastXX;
	
	CCSprite *arm1;
	int bombDropCount;
	Bone *bomb;
	NSMutableArray *weapons;
	NSMutableArray *bones;
	
	Bubble *bub;
	
	CCLabelBMFont *scores;
	
	int score;
	
	CCLabelBMFont *addedScores;
	
	BOOL paused;
	CCSprite *splash;
	
	int pTime;
	
	NSMutableArray *randomPowerWords;
	
	NSMutableArray *randomDissWords;
	
 	CCParticleFireworks *bulletHitParticles;
	BOOL dead;
	int deadCount;
	
	BOOL resetingSpeed;
	CCLabelBMFont *tap;
	
	float skateSoundTic;
	
	ALuint skateSound;
	Button *pauseButton;
	
	Button *highScoreBtn;
	HighscoreLayer *highscores;
	
	Button *sfx;
	Button *music;
	CCSprite *credz;
	int startTic;
	Button *feedback;
	
	UIViewController *mailComposer;
	
	CCSprite *ttt;
    
    int hitsWithoutMisses;
    
    CCSprite *thumb1;
    CCSprite *thumb2;
    CCSprite *thumb3;

    int bonus;
}

-(void)changeThumb;
-(void)changeApperance;
-(void)buttonTapped:(Button*)btn;
-(float)gimmexSpeed;
-(void)loadNewMapData;
-(void)resetGame;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end


