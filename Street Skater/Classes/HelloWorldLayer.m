//
//  HelloWorldLayer.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-04-18.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"


#define maxSpeed 35
#define kFireTag 60
#define kFeedBack 36

// HelloWorldLayer implementation



@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
	
}

// on "init" you need to initialize your instance

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		[[CCTextureCache sharedTextureCache]addImage:@"graphicsSheet.png"];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"graphicsSheet.plist"];
		
		
		self.isTouchEnabled = YES;
		
		sae = [SimpleAudioEngine sharedEngine];
		
		[sae preloadBackgroundMusic:@"music.mp3"];
		
		[sae preloadEffect:@"skateSound1.wav"];
		[sae preloadEffect:@"skateJumpSound.wav"];
		
		[sae preloadEffect:@"dead1.wav"];
		[sae preloadEffect:@"resume.wav"];
		
		[sae preloadEffect:@"pause1.wav"];
		
		[sae preloadEffect:@"dead2.wav"];
		
		[sae preloadEffect:@"hitEnemy.wav"];
		
		[sae preloadEffect:@"throw.wav"];
		//[[SimpleAudioEngine sharedEngine]preloadEffect:@"click.wav"];
		
		[sae playBackgroundMusic:@"music.mp3" loop:YES];
		/*
		[[CCTextureCache sharedTextureCache] addImage:@"board1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"bomb.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"cloud1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cloud2.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cloud3.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cloud4.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cloud5.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cloud7.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon1.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon2.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon3.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon4.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon5.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon6.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon7.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon8.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon9.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon10.png"];
		
		
		[[CCTextureCache sharedTextureCache] addImage:@"weapon11.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon12.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon13.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon14.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon15.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon16.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon17.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"weapon18.png"];
		
		
		[[CCTextureCache sharedTextureCache] addImage:@"cone1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cone2.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cone3.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cone4.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"cone5.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"btn1.png"];		
		
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead2.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead3.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead4.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead5.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead6.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead7.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead8.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyHead9.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"enemyBody1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyBody2.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyBody3.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyBody4.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"enemyBody5.png"];
		
		[[CCTextureCache sharedTextureCache] addImage:@"specs1.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"specs2.png"];
		[[CCTextureCache sharedTextureCache] addImage:@"specs3.png"];
		
		 */
		
		
		CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
		[self addChild:background];
		background.position = ccp(240,160);
		//background.scale = 10;
		
		cloudNode = [CCNode node];
		[self addChild:cloudNode];
		
		for(int i = 0; i < 5; i ++){
			
			CCSprite * cloud = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"cloud%d.png",1 + arc4random() % 5]];
			
			[cloudNode addChild:cloud];
			
			cloud.position = ccp((lastXX + 100 + arc4random() % 200) , arc4random() % 200);
			lastXX = cloud.position.x;
			
		}
		
		CCNode *effectsNode = [CCNode node];
		[self addChild:effectsNode];
		
		controllerNode = [CCNode node];
		[effectsNode addChild:controllerNode];
		effectsNode.scale = .4;
		
		pauseButton = [Button spriteWithSpriteFrameName:@"pauseButton.png"];
		[self addChild:pauseButton z:0 tag:1];
		pauseButton.position = ccp(450,300 );
		
		maps = [[NSMutableArray alloc] init];
		
		CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"map1.tmx"];
		
		currentCollisionMap = map;
		controllerNode.position = ccp(controllerNode.position.x, -500) ;
		
		collisionLayer = [currentCollisionMap layerNamed:@"top"];
		
		for( CCSpriteBatchNode* child in [map children] ) {
			
			[[child texture] setAntiAliasTexParameters];
			
		}
		
		[controllerNode addChild:map];
		
		for(int i = 2 ; i <= 8;i++){
			
			CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:[NSString stringWithFormat:@"map%d.tmx",i]];
			
			controllerNode.position = ccp(controllerNode.position.x, -50) ;
			
			for( CCSpriteBatchNode* child in [map children] ) {
				
				[[child texture] setAntiAliasTexParameters];
				
			}
			
			map.visible = NO;
			[controllerNode addChild:map];
			[maps addObject:map];
			
		}
		
		wheels = [CCSprite spriteWithSpriteFrameName:@"wheels.png"];
		wheels.position = ccp(48,140);
		[self addChild:wheels];
		
		skater = [CCSprite spriteWithSpriteFrameName:@"skater.png"];
		[self addChild:skater];
		int offset = ySpeed;
		
		if(offset > 10)offset = 10;
		if(offset < -10)offset = -10;
		
		skater.position = ccp(50 + skater.rotation * .4, 176 -  ((skater.position.x - offset) - offset)  * .1 );
		
		//	skater.scale = .4;
		
		[self loadNewMapData];
		
		ySpeed = 1;
		currentMaps = 1;
		
		self.isTouchEnabled = YES;
		xSpeed = 25;
		
		enemy = [Enemy spriteWithSpriteFrameName:@"blank.png"];
		[controllerNode addChild:enemy];
		enemy.visible = YES;
		
		enemy.position = ccp(1200,100);
		enemy.currentCollisionMap1 = currentCollisionMap;
		
		enemy.scale = 2.5;
		
		shoe1 = [CCSprite spriteWithSpriteFrameName:@"shoe1.png"];
		[skater addChild:shoe1];
		shoe1.position = ccp(shoe1.contentSize.width / 2, shoe1.contentSize.height / 2);
		
		shoe2 = [CCSprite spriteWithSpriteFrameName:@"shoe2.png"];
		[skater addChild:shoe2];
		shoe2.position = ccp(shoe2.contentSize.width / 2, shoe2.contentSize.height / 2);
		
		bodyCntrlNode = [CCNode node];
		[skater addChild:bodyCntrlNode];
		
		body = [CCSprite spriteWithSpriteFrameName:@"body.png"];
		[bodyCntrlNode addChild:body];
		
		arm = [CCSprite spriteWithSpriteFrameName:@"arm.png"];
		[body addChild:arm z:-1];
		arm.anchorPoint = ccp(0.2,.8);
		arm.position = ccp(29,57);
		
		body.position = ccp(body.contentSize.width / 2, body.contentSize.height / 2);
		
		headCntrlNode = [CCNode node];
		[skater addChild:headCntrlNode];
		
		NSString *headString = [NSString stringWithFormat:@"enemyHead%d.png", 1 + arc4random() % 20];
		
		head = [CCSprite spriteWithSpriteFrameName:headString];
		
		//head = [CCSprite spriteWithFile:@"head2.png"];
		[headCntrlNode addChild:head];
		//head.position = ccp(head.contentSize.width / 2, head.contentSize.height / 2);
		
		head.position = ccp(body.contentSize.width / 2, (body.contentSize.height / 2));
		
		if(arc4random() % 2 == 1){
			
			NSString *specString = [NSString stringWithFormat:@"specs%d.png",1 + arc4random() % 4];
			
			specs = [CCSprite spriteWithSpriteFrameName:specString];
			[headCntrlNode addChild:specs];
			
		}else{
			
			specs = [CCSprite spriteWithSpriteFrameName:@"specs1.png"];
			[headCntrlNode addChild:specs];
			specs.visible = NO;
			
		}
		
		specs.position = ccp(body.contentSize.width / 2, (body.contentSize.height / 2));
		
		[enemy loadNewMapData1];
		
		//fireButton = [CCSprite spriteWithFile:@"fireButton.png"];
		//[self addChild:fireButton];
		//fireButton.position = ccp(45,45);
		
		
		
		Button *fireBtn = [Button spriteWithSpriteFrameName:@"btn2.png"];
		
		[self addChild:fireBtn z:0 tag:kFireTag];
		
		fireBtn.willScale = NO;
		
		
		//fireBtn.position = ccp(480 - (fireBtn.contentSize.width / 2) -15 ,5 +  (fireBtn.contentSize.height / 2));
		
		fireBtn.position = ccp( 45 , 45);
		
		
		weapons = [[NSMutableArray alloc] init];
		bones = [[NSMutableArray alloc] init];
		
		for (int i = 0; i < 2; i ++){
			Weapon *weapon = [Weapon spriteWithSpriteFrameName:@"weapon1.png"];
			weapon.visible = NO;
			[controllerNode addChild:weapon];
            
            weapon.delegate = self;
			
			[weapons addObject:weapon];
			
		}
		
		for (int i = 0; i < 6; i ++){
			
			Bone *bone = [Bone spriteWithSpriteFrameName:@"blank.png"];
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			[controllerNode addChild:bone];
			bone.position = ccp(100* i,900);
			bone.scale = 2.5;
			bone.visible = NO;
			[bones addObject:bone];
			
		}
		
		bomb = [Bone spriteWithSpriteFrameName:@"blank.png"];
		[controllerNode addChild:bomb];
		bomb.visible = NO;
		bomb.scale = 2.5;
		
		scores = [CCLabelBMFont labelWithString:@"0" fntFile:@"bad.fnt"];
		
		scores.anchorPoint = ccp(0,1);
		[self addChild:scores];
		scores.position = ccp(15,315);	
		scores.scale = .7;
		score = 0;
		
		addedScores = [CCLabelBMFont labelWithString:@"+0" fntFile:@"bad.fnt"];
		addedScores.visible = NO;
		[self addChild:addedScores];
		
		splash = [CCSprite spriteWithSpriteFrameName:@"splash.png"];
		
		[self addChild:splash];
		splash.position = ccp(240,160);
		
		//[self scheduleUpdate];
		[self schedule:@selector(pausedGameTime) interval:1/60];
		paused = YES;
		
		bub = [Bubble node];
		[self addChild:bub];
		bub.position = ccp(300,160);
		
		[bub setStringTo:@"" miniString:@""];
		
		randomPowerWords = [[NSMutableArray alloc] init];
		
		[randomPowerWords insertObject:@"BoOya!" atIndex:0];
		
		[randomPowerWords insertObject:@"Yeah!" atIndex:0];
		
		[randomPowerWords insertObject:@"Got 'em!" atIndex:0];
		
		[randomPowerWords insertObject:@"Awesome!" atIndex:0];
		
		[randomPowerWords insertObject:@"BAdasS!" atIndex:0];
		
		[randomPowerWords insertObject:@"Woohaa!" atIndex:0];
		
		[randomPowerWords insertObject:@"Radical!" atIndex:0];
		
		[randomPowerWords insertObject:@"POW-Wow!" atIndex:0];
		
		[randomPowerWords insertObject:@"Boo0o0Om!" atIndex:0];
		
		[randomPowerWords insertObject:@"ShazAam!" atIndex:0];
		
		[randomPowerWords insertObject:@"BAda-bOom!" atIndex:0];
		
		[randomPowerWords insertObject:@"DiiIng!" atIndex:0];
		
		[randomPowerWords insertObject:@"BulLseye!" atIndex:0];
		
		[randomPowerWords insertObject:@"Wicked!" atIndex:0];
		
		
		randomDissWords = [[NSMutableArray alloc] init];
		
		[randomDissWords insertObject:@"Whoa!?" atIndex:0];
		
		[randomDissWords insertObject:@"LoSeR!" atIndex:0];
		
		[randomDissWords insertObject:@"Ouchie!" atIndex:0];
		
		[randomDissWords insertObject:@"Got hurt?" atIndex:0];
		
		[randomDissWords insertObject:@"BOo-HoO?" atIndex:0];
		
		[randomDissWords insertObject:@"Fatality" atIndex:0];
		
		[randomDissWords insertObject:@"N0Ob!" atIndex:0];
		
		[randomDissWords insertObject:@"Whopped!" atIndex:0];
		
		[randomDissWords insertObject:@"PatheTic" atIndex:0];
		
		
		
		
		bulletHitParticles =  [[CCParticleFireworks alloc] initWithTotalParticles:400];
		bulletHitParticles.texture = [[CCTextureCache sharedTextureCache] addImage:@"Particle.png"];
		bulletHitParticles.emissionRate = 0;
		bulletHitParticles.angleVar = 0;
		bulletHitParticles.gravity = ccp(0,-500);
		
		ccColor4F startColorV = {1,1,1,0};
		
		ccColor4F bulletPartColor = {1.0f,1.0f,1.0f,0.0f};
		
		bulletHitParticles.startColor = bulletPartColor;
		bulletHitParticles.startColorVar = startColorV;
		
		bulletHitParticles.life = 0.25f;
		bulletHitParticles.lifeVar = 0.05;
		bulletHitParticles.speed = 450;
		bulletHitParticles.speedVar = 100;
		bulletHitParticles.lifeVar = 0.05;
		
		[self addChild:bulletHitParticles];
		
		tap = [CCLabelBMFont labelWithString:@"Tap To Restart" fntFile:@"bad.fnt"];
		tap.position = ccp(240, 100);
		tap.visible = NO;
		highScoreBtn.visible = NO;
		tap.scale = .65;
		[self addChild:tap];
		
		skateSoundTic = 400-20; 
		
		[[CCTextureCache sharedTextureCache]addImage:@"playButton.png"];
		[[CCTextureCache sharedTextureCache]addImage:@"pauseButton.png"];
		
		highScoreBtn = [Button spriteWithSpriteFrameName:@"highscoreImage.png"];
		highScoreBtn.position = ccp(240,40);
		[self addChild:highScoreBtn z:0 tag:2];
		highScoreBtn.visible = NO;
		
		highscores = [[HighscoreLayer alloc]init];
		[self addChild:highscores z:5];
		
		highscores.visible = NO;
		
		sfx = [Button spriteWithSpriteFrameName:@"sfxOn.png"];
		[self addChild:sfx z:0 tag:6];
		sfx.visible = NO;
		
		music = [Button spriteWithSpriteFrameName:@"musicOn.png"];
		[self addChild:music z:0 tag:5];
		music.visible = NO;
		
		[[CCTextureCache sharedTextureCache]addImage:@"musicOff.png"];
		[[CCTextureCache sharedTextureCache]addImage:@"sfxOff.png"];	
		
		sfx.position = ccp(480- 100, 120 );
		music.position = ccp(480- 200, 120 );
		
		[bub setBounceStringTo:@"Street SkatER"];
		[tap setString:@"Tap to start"];
		tap.scale = 0;
		CCEaseInOut *s = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.4 scale:.65]rate:2];
		CCEaseInOut *s2 = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.4 scale:.6]rate:2];
		
		[tap runAction:[CCRepeatForever actionWithAction:[CCSequence actions:s,s2,nil]]];
		
		tap.visible = YES;
		
		credz = [CCSprite spriteWithSpriteFrameName:@"credz.png"];
		
		[self addChild:credz z:5];
		credz.position = ccp(240, (credz.contentSize.height / 2) + 5);
		credz.visible = NO;
		credz.opacity = 0;
		
		feedback = [Button spriteWithSpriteFrameName:@"feedback.png"];
		feedback.position = ccp(480-140,50);
		[self addChild:feedback z:0 tag:kFeedBack];
		feedback.visible = NO;
		
        thumb1 = [CCSprite spriteWithSpriteFrameName:@"x2.png"];
        
        [self addChild:thumb1];
       
        
        thumb1.position = ccp(28,270);
        thumb1.scale = 0;
        
        [[[CCDirector sharedDirector]openGLView]setMultipleTouchEnabled:YES];
        
        
	}
	return self;
}

-(void)showThumb {
    
    if(hitsWithoutMisses < 7){
        
    hitsWithoutMisses ++;
        
        [thumb1 stopAllActions];
        
        if(hitsWithoutMisses > 1){
        
        id scal1  = [CCEaseElasticIn actionWithAction:[CCScaleTo actionWithDuration:.7 scale:0]];
        
        id fun = [CCCallFunc actionWithTarget:self selector:@selector(changeThumb)];
        
        id scal2  = [CCEaseElasticOut actionWithAction:[CCScaleTo actionWithDuration:.7 scale:.8]];
        
        id seq = [CCSequence actions:scal1,fun,scal2,nil];
        
        [thumb1 runAction:seq];
            
        }else{
            
             [self changeThumb];
              id scal2  = [CCEaseElasticOut actionWithAction:[CCScaleTo actionWithDuration:.7 scale:.8]];
            
            [thumb1 runAction:scal2];
            
        }
                
    }
       
}

-(void)changeThumb {
    
    [thumb1 setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"x%d.png",hitsWithoutMisses + 1]]];
    
}


-(void)missed {
    
    [thumb1 stopAllActions];
           
    id scal1  = [CCEaseElasticIn actionWithAction:[CCScaleTo actionWithDuration:.7 scale:0]];
  
    hitsWithoutMisses = 0;
    
    [thumb1 runAction:scal1];
  
    
    
}


-(void) showEmail {
	CCDirector *director = [CCDirector sharedDirector];
	[director pause];
	[director stopAnimation];
	[director.openGLView setUserInteractionEnabled:NO];
	
	
	// This takes my dictionary that stores level data, and creates xml data that we will attach to the email
	
	NSString *error = [[NSString alloc] init];
	
	
	NSLog(@"Error: %@", error);
	
	// This creates the level thumbnail, which we will include in the email as well
	// There is probably a better way to do this
	
	
	
	// Read back the level thumbnail so we can attach the PNG to the email
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//NSString *documentsDirectory	= [paths objectAtIndex:0];
	//NSString *fullPath = [documentsDirectory stringByAppendingPathComponent: @"mylevel.png"];
	//NSData *imageData = [NSData dataWithContentsOfFile: fullPath];
	
	// The actual mail window call
	mailComposer = [[UIViewController alloc] init];
	[mailComposer setView:[[CCDirector sharedDirector] openGLView]];
	[mailComposer setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	[picker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	picker.mailComposeDelegate = self;
	
	[picker setToRecipients:[NSArray arrayWithObject:@"meganinja.support@gmail.com"]];
	[picker setSubject: @"Feedback / Suggestion for Street Skater"];
	
	/*
	 [picker addAttachmentData: imageData mimeType:@"image/png" fileName: @"mylevel.png"];
	 [picker addAttachmentData: levelData mimeType:@"text/xml" fileName: @"mylevel.plist"];
	 */
	// Fill out the email body text
	//NSString *content = @"Blah blah.\n";
	//NSString *pageLink = @"http://mylink.com";
	//NSString *iTunesLink = @"http://iTunes.com/mylevellink";
	//NSString *emailBody = [NSString stringWithFormat: @"Sent from <a href = '%@'>Fun Game</a> on iPhone. <a href = '%@'>Download</a> yours from AppStore now!", pageLink, iTunesLink];
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:YES];
	
	[mailComposer presentModalViewController:picker animated:YES];
	
	[picker shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
	
	[picker release];
}

// Dismisses the email composition interface when users tap Cancel or Send.

-(void) mailComposeController: (MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed – Unknown Error  "
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
			
			break;
	}
	
	[mailComposer dismissModalViewControllerAnimated:NO];
	
	
	// Force game back to landscape mode.  If you don't weird things happen
	[[UIApplication sharedApplication] setStatusBarOrientation: CCDeviceOrientationLandscapeLeft animated:NO];
	
	CCDirector *director = [CCDirector sharedDirector];
	[director.openGLView setUserInteractionEnabled:YES];
	[director startAnimation];
	
	//[director resume];
	
	/*
	 [UIView beginAnimations:nil context:NULL];
	 [UIView setAnimationDuration:0.0f];
	 [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[CCDirector sharedDirector] openGLView] cache:YES];
	 [UIView commitAnimations];
	 */
	[mailComposer.view.superview removeFromSuperview];
	
	[director setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	
}

-(void)changeApperance {
	
	NSString *headString = [NSString stringWithFormat:@"enemyHead%d.png", 1 + arc4random() % 20];
	
	[head setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:headString]];
	
	if(arc4random() % 2 == 1){
		
		
		specs.visible = YES;
		
		NSString *specString = [NSString stringWithFormat:@"specs%d.png",1 + arc4random() % 4];
		
		[specs setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:specString]];
		
		
		
	}else{
		
		[specs setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"specs1.png"]];	
		specs.visible = NO;
		
	}
	
}

-(void)buttonTapped:(Button*)btn {
	
	if(![[CCDirector sharedDirector]isPaused]){
		if(btn.tag == kFireTag && btn.visible){
			if(!dead && !paused){
				for(Weapon *weapon in weapons){
					
					if(!weapon.visible){
						weapon.position = [controllerNode convertToNodeSpace:ccp(skater.position.x,skater.position.y + 20)];
						
						weapon.visible = YES;
						
						id rot = [CCRotateTo actionWithDuration:.0 angle:-170];
						id rot2 = [CCEaseOut actionWithAction:[CCRotateTo actionWithDuration:.2 angle:0] rate:2.0];
						
						[arm runAction:[CCSequence actions:rot,rot2, nil]];
						
						[weapon throwWithSpeed:xSpeed];
						[sae playEffect:@"throw.wav"];
						
						break;
						
					}
				}
				
			}
			
		}
		
		if(btn.tag == 2 && btn.visible){
			if(deadCount > 30){
				
				btn.visible = NO;
				
				highscores.score = score;
				highscores.visible = YES;
				[highscores showAlert];
				[highscores cleanAll];
				[highscores requestScore:kQueryAllTime offset:0];
				//[highscores scheduleUpdate];
				
			}
			
		}
		
	}
	
	if(btn.tag == 5){
		
		[sae playEffect:@"pause1.wav"];
		
		if([sae backgroundMusicVolume] == 1){
			[btn setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"musicOff.png"]];
			[sae setBackgroundMusicVolume:0];

		}else{
			[btn setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"musicOn.png"]];
			[sae setBackgroundMusicVolume:1];
		}
		
	
	}
	if(btn.tag == 6){
		[sae playEffect:@"pause1.wav"];
		
		if([sae effectsVolume] == 1){
			[btn setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"sfxOff.png"]];
			[sae effectsVolume:0];
			
		}else{
			[btn setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"sfxOn.png"]];
			[sae effectsVolume:1];
		}
		
		
		
	}
	
	if(btn.tag == kFeedBack){
		[self showEmail];
	}
	if(btn.tag == 1){
		if(!paused){
			
			[Appirater userDidSignificantEvent:YES];
			
			[sae playEffect:@"pause1.wav"];
			paused = YES;
			feedback.visible = YES;
			sfx.visible = YES;
			music.visible = YES;
			//[btn setTexture:[[CCTextureCache sharedTextureCache]textureForKey:@"playButton.png"]];
			[btn setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"playButton.png"]];
			//[self unscheduleUpdate];
			
			[[CCDirector sharedDirector] pause];
			[sae pauseBackgroundMusic];
			[sae stopEffect:skateSound];
		}else{
			sfx.visible = NO;
			feedback.visible = NO;
			music.visible = NO;
			[btn setDisplayFrame: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"pauseButton.png"]];
			
			[sae playEffect:@"resume.wav"];
			paused = NO;		
			[[CCDirector sharedDirector] resume];
			[sae resumeBackgroundMusic];
			//[self scheduleUpdate];
		}
		
	}
	
}
-(void)resetGame {
	[self changeApperance];
	skateSoundTic = 400;
	
	bomb.visible = NO;
	
	deadCount = 0;
	[enemy update];
	
	dead = NO;
	
	skater.scale = 1;
	wheels.scale = 1;
	
	score = 0;
	resetingSpeed = YES;
	
	skater.visible = YES;
	highScoreBtn.visible = NO;
}

-(void)explodeSkater {
	if(!paused){
        
        
        [self missed];
		
		id scal = [CCEaseExponentialOut actionWithAction:[CCScaleTo actionWithDuration:.2 scale:0]];
		[skater runAction:scal];
		id scal2 = [CCEaseExponentialOut actionWithAction:[CCScaleTo actionWithDuration:.2 scale:0]];

		[wheels runAction:scal2];
		
		dead = YES;
		
		[sae stopEffect:skateSound];
		[tap setString:@"Tap to restart"];
		tap.scale = 0;
		id s = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.4 scale:.65]rate:2];
		id s2 = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.4 scale:.6]rate:2];
		
		[tap runAction:[CCRepeatForever actionWithAction:[CCSequence actions:s,s2,nil]]];
		
		tap.visible = YES;
		highScoreBtn.visible = YES;
		
		if([bub isRunningActions])[bub stopChildActions];
		
		[bub setBounceStringTo:[randomDissWords objectAtIndex: arc4random() % [randomDissWords count]]];
		
	}
	
	for(int i = 0; i < 400; i ++){
		bulletHitParticles.gravity = ccp(0,-2000);
		bulletHitParticles.life = .5;
		bulletHitParticles.startSizeVar = 10;
		bulletHitParticles.endSize = 0;
		bulletHitParticles.speedVar = 200;
		bulletHitParticles.lifeVar = 1;
		bulletHitParticles.position = skater.position;
		
		bulletHitParticles.angle = arc4random() % 360;
		
		[bulletHitParticles addParticle];
		
	}
	
}

-(void)pausedGameTime {
	
	startTic ++;
	
	if(startTic == 30){
		
		credz.visible = YES;
		credz.opacity = 0;
		
		id f = [CCEaseInOut actionWithAction:[CCFadeIn actionWithDuration:.5] rate:2];
		[credz runAction:f];
		
	}
	
	if(!paused){
		
		[sae playEffect:@"resume.wav"];
		if(splash.parent == self){
		id fad = [CCFadeOut actionWithDuration:.5];
		[splash runAction:fad];
		id fad2 = [CCFadeOut actionWithDuration:.5];

		[credz runAction: fad2 ];
		}	
		
		id sc = [CCScaleTo actionWithDuration:.17 scale:0];
		
		[tap stopAllActions];
		[tap cleanup];
		[tap runAction:sc];
		[bub hideLetters];
		
		[self unschedule:@selector(pausedGameTime)];
		[self schedule:@selector(time2)];
		
		id blink = [CCFadeOut actionWithDuration:.0];
		
		id blink2 = [CCFadeIn actionWithDuration:.0];
		
		id del = [CCDelayTime actionWithDuration:.5];
		
		id seq = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		
		[skater runAction:seq];
		id seq2 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq3 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq4 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq5 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq6 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq7 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];
		id seq8 = [CCSequence actions:blink,del,blink2,del,blink,del,blink2,nil];

		[head runAction:seq2];	
		[wheels runAction:seq3];	
		
		[body runAction:seq4];	
		[arm runAction:seq5];	
		[specs runAction:seq6];	
		
		[shoe1 runAction:seq7];	
		[shoe2 runAction:seq8];	
		
	}
	
}

-(void)time2 {
	
	pTime += 1;
	if(pTime == 1)[self update:1];
	
	if(pTime == 140){
		[self unschedule:@selector(time2)];
		[self scheduleUpdate];
		
	}
	
}

-(void)loadNewMapData {
	
	int lastX;
	for(int x = 0; x < currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width; x++){
		
		for(int y1 = 0; y1 < currentCollisionMap.contentSize.height / currentCollisionMap.tileSize.height;y1 ++){
			
			if([[currentCollisionMap layerNamed:@"top"] tileGIDAt:ccp(x,y1)] != 0){
				
				//NSLog(@"%f", y1 * currentCollisionMap.tileSize.height);
				
				mapPoints[x] = ccp(x * currentCollisionMap.tileSize.width,y1 * currentCollisionMap.tileSize.height );
				
				break;
				
			}
			
		}
		lastX = x;
	}
	
	
	for(int f = lastX; f < lastX + 3; f ++){
		
		mapPoints[f] = mapPoints[lastX];
		
	}
	
}

- (void)onEnter {
	
	[super onEnter];
	
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches: NO];
	
	self.isTouchEnabled = YES;
	
}



-(void)explodeEnemy {
	
    [self showThumb];
    
	[sae playEffect:@"hitEnemy.wav"];
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
			//[bone setTheTextue:[[CCTextureCache sharedTextureCache] textureForKey:@"board1.png"]];
			[bone setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"board1.png"]];
			
			bone.yOffset = 20;
			bone.xSpeed = enemy.xSpeed +  5;
			bone.ySpeed = enemy.ySpeed;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y);
			
			bone.visible = YES;	
			
			break;
		}
		
	}
	
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
			//[bone setTheTextue:enemy.head.texture];
			[bone setDisplayFrame:enemy.head.displayedFrame];

			bone.xSpeed = enemy.xSpeed + arc4random() % 10;
			bone.ySpeed = enemy.ySpeed - 5 - arc4random() % 5;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y + 120);
			
			bone.visible = YES;	
			
			break;
		}
		
	}
	
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
			//[bone setTheTextue:enemy.specs.texture];
			[bone setDisplayFrame:enemy.specs.displayedFrame];

			bone.yOffset = -10;
			
			bone.xSpeed = enemy.xSpeed + arc4random() % 10;
			bone.ySpeed = enemy.ySpeed - 5 - arc4random() % 5;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y + 130);
			
			bone.visible = enemy.specs.visible;
			
			break;
		}
		
	}
	
	
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
			//[bone setTheTextue:enemy.body.texture];
			[bone setDisplayFrame:enemy.body.displayedFrame];

			bone.yOffset = 30;
			
			bone.xSpeed = enemy.xSpeed + 3 ;
			bone.ySpeed = enemy.ySpeed - 2;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y + 50);
			
			bone.visible = YES;	
			
			break;
		}
		
	}
	
	
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
			//[bone setTheTextue:[[CCTextureCache sharedTextureCache] textureForKey:@"shoe1.png"]];
			[bone setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"shoe1.png"]];

			bone.yOffset = 50;
			bone.xSpeed = enemy.xSpeed +5 ;
			bone.ySpeed = enemy.ySpeed ;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y + 10);
			
			bone.visible = YES;	
			
			break;
		}
		
	}
	
	for(Bone *bone in bones){
		
		if(!bone.visible){
			
		//	[bone setTheTextue:[[CCTextureCache sharedTextureCache] textureForKey:@"shoe2.png"]];
			[bone setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"shoe2.png"]];

			bone.yOffset = 50;
			bone.xSpeed = enemy.xSpeed +5;
			bone.ySpeed = enemy.ySpeed;
			bone.currentCollisionMap1 = enemy.currentCollisionMap1;
			[bone loadNewMapData1];
			bone.position = ccp(enemy.position.x,enemy.position.y + 10);
			
			bone.visible = YES;	
			
			break;
			
		}
		
	}
	
	
	enemy.position = ccp(skater.position.x - 500, skater.position.y - 3000);
	
	//enemy.position = ccp(-enemy.parent.position.x + 1200 , skater.position.y + 5000);
	enemy.xSpeed = xSpeed +10 ;
	
}

-(void)resetEnemy {
	
	enemy.position = ccp(-enemy.parent.position.x + 1200 , skater.position.y + 5000);
	enemy.xSpeed = xSpeed  +10 ;	
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	
	if(highscores.visible || [[CCDirector sharedDirector]isPaused])return NO;
	if(dead){
		
		return YES;
		
	}
	//[self explodeSkater];
	
	if(paused){
		
		paused = NO;
		
		
		return NO;
		
	}
	if(pTime <  140)return NO;
	CGPoint location = [touch locationInView: [touch view]];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	
	//CGRect fireButtonRect = CGRectMake(fireButton.position.x -fireButton.contentSize.width  / 2, fireButton.position.y- fireButton.contentSize.height / 2, fireButton.contentSize.width , fireButton.contentSize.height);
	
	
	//[enemy changeApperance];
	
	int x = ([currentCollisionMap convertToNodeSpace:skater.position].x) / currentCollisionMap.tileSize.width;
	
	int y = (currentCollisionMap.contentSize.height / currentCollisionMap.tileSize.height) - ([currentCollisionMap convertToNodeSpace:ccp(50,140)].y / currentCollisionMap.tileSize.height);
	int desiredY = (mapPoints[x].y) / currentCollisionMap.tileSize.height;
	
	if(desiredY - y <= 2 && !fallThrough){ 
		
		ySpeed = 0;
		jumpFactor = 4;
		
		beganLoadingForJump = YES;
		
		jumpCount = 25;
		
		[sae  stopEffect: skateSound];
		
		skateSoundTic = 0;
		
		[sae  playEffect:@"skateJumpSound.wav"];
		
				
		if([skater numberOfRunningActions] == 0){
			
			id rot =[CCSpawn actions:[CCEaseInOut actionWithAction:[CCRotateTo actionWithDuration:.1 angle:skater.rotation-13 ]rate:2.0] , [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.03 position:ccp(0,-8)] rate:2.0], nil ];
			
			id rot2 = [CCEaseIn actionWithAction:[CCRotateTo actionWithDuration:.2 angle:0 ] rate:1.0];
			
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

			
		CCSequence *headSequence2 = [CCSequence actions:moveSpecs,[moveSpecs reverse],nil];; 
		
		[specs runAction:headSequence2];
			
		}
		
		id moveFeet = [CCEaseExponentialInOut actionWithAction:[CCMoveBy actionWithDuration:.0 position:ccp(-3,-1)]];
		id moveFeet5 = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.3 position:ccp(3,1)] rate:2.0];
		
		
		CCSequence *feetSeq = [CCSequence actions:moveFeet,moveFeet5,nil];
		if([shoe1 numberOfRunningActions] == 0)[shoe1 runAction:feetSeq]; 
		
		id moveFeet2 = [CCEaseExponentialInOut actionWithAction:[CCMoveBy actionWithDuration:.1 position:ccp(0,0)]];
		CCSequence *feetSeq2 = [CCSequence actions:moveFeet2,[moveFeet2 reverse],nil];
		if([shoe2 numberOfRunningActions] == 0)[shoe2 runAction:feetSeq2]; 
		
		return YES;
	}	
	
	return NO;
	
}


- (void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	
	
}

- (void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	
	
	if(highscores.visible || [[CCDirector sharedDirector]isPaused])return  ;
	
	if(dead){
		
		if(deadCount > 30){
			
			[bub hideLetters];	
			
			[sae playEffect:@"dead2.wav"];
			
			id sc = [CCScaleTo actionWithDuration:.17 scale:0];
			
			[tap stopAllActions];
			[tap cleanup];
			[tap runAction:sc];
			
            
            [self missed];
			
			[self resetGame];
			
			enemy.position = ccp(skater.position.x - 500, skater.position.y - 3000);
			
		}
	}else{
		
		
		
	}
	
	beganLoadingForJump = NO;
	
	
	
}

-(void)dead:(ccTime)delta {
	
	controllerNode.position = ccp(controllerNode.position.x + xSpeed, controllerNode.position.y);
	skater.position = ccp(skater.position.x, skater.position.y - ySpeed);
	
	if(ySpeed == 0)ySpeed = 2;
	xSpeed = xSpeed * .97;
	ySpeed += .35;
	
}

-(void)update:(ccTime)delta {
	
	
	
	enemy.skaterXSpeed = xSpeed;
	
	if(!dead)skateSoundTic += 1;
	
	if(skateSoundTic > 400){
		
		[sae  stopEffect: skateSound];
		
		skateSound = [sae playEffect:@"skateSound1.wav"];
		
		skateSoundTic = 0;
	}
	
	if(resetingSpeed && xSpeed < 25){
		
		xSpeed += 2;
	}else if(resetingSpeed){
		resetingSpeed = NO;	
	}
	
	if(dead){
		
		xSpeed = xSpeed * .97;
		deadCount += 1;
		if(deadCount == 25){
			
			[Appirater userDidSignificantEvent:YES];
			
		}
		
	}
	
	score += (xSpeed / 15) * (hitsWithoutMisses +1);
	
	[scores setString:[NSString stringWithFormat:@"%d",score]];
 	
	if(bomb.position.x + controllerNode.position.x < -150){
		bomb.visible = NO;
		
	}
	
	
	CGRect skRect = CGRectMake(60, 160, 20, 100);
	
	CGRect coneRect = CGRectMake(((bomb.position.x + controllerNode.position.x) * .4)- 20, ((bomb.position.y + controllerNode.position.y) * .4) -20, 40, 50);
	
	
	if(CGRectIntersectsRect(skRect, coneRect) && !dead){
		
		[sae playEffect:@"dead1.wav"];
		
		[self explodeSkater];
		
		
	}
	
	if(arc4random() % 30 == 10 && bomb.visible == NO && enemy.position.x + controllerNode.position.x < 1200 && enemy.desiredY - enemy.yTile <= 1 ){
		
		bomb.position = enemy.position;
		bomb.visible = YES;
		bomb.opacity = 255;
		bomb.scale = 2.5;
		[bomb setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"bomb.png"]];
		[bomb setTheTextue:[[CCTextureCache sharedTextureCache] textureForKey:@"bomb.png"]];
		bomb.yOffset = 30;
		
		bomb.currentCollisionMap1 = enemy.currentCollisionMap1;
		[bomb loadNewMapData1];
		bombDropCount = 1;
		
		[bomb blink];
		
	}
	
	if(bombDropCount != 0){
		bomb.position = enemy.position;
		
	}
	if(bomb.visible && bombDropCount > 0){
		
		bombDropCount += 1;
		
		
		
		if(bombDropCount > 60 && enemy.desiredY - enemy.yTile <= 1  && enemy.rotation <= 0){
			if(enemy.goingUpHill){
				bombDropCount = 58;
			}else{
				bombDropCount = 0;
			}
		}
		
	}
	
	//[bomb update];
	
	for(Bone *bone in bones){
		
		if(bone.visible){
			[bone update];
			
			if(bone.position.x + controllerNode.position.x < -100 ){
				
				bone.visible = NO;
				
				
			}
		}
		
	}
	for(CCSprite *cloud in [cloudNode children]){
		
		if(cloud.position.x + (cloud.textureRect.size.width / 2) + cloudNode.position.x < 0){
			
			if(arc4random() % 15 != 4){
				[cloud setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:[NSString stringWithFormat:@"cloud%d.png",1 + arc4random() % 5]]];	
			//	cloud.texture = [[CCTextureCache sharedTextureCache] textureForKey:[NSString stringWithFormat:@"cloud%d.png",1 + arc4random() % 5]];
			//	[cloud setTextureRect:CGRectMake(0, 0, cloud.texture.contentSize.width, cloud.texture.contentSize.height)];
				
			}else{
				
				[cloud setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:@"cloud7.png"]];	

				//cloud.texture = [[CCTextureCache sharedTextureCache] textureForKey:@"cloud7.png"];
				
				//cloud.textureRect = CGRectMake(cloud.contentSize.width / 2, cloud.contentSize.height / 2, cloud.contentSize.width, cloud.contentSize.height);
				//[cloud setTextureRect:CGRectMake(0, 0, cloud.texture.contentSize.width, cloud.texture.contentSize.height)];
				
			}
			cloud.position = ccp((lastXX + 100 + arc4random() % 200) , -cloudNode.position.y + 100 + arc4random() % 200);
			lastXX = cloud.position.x;
			
		}
		
	}
	
	cloudNode.position = ccp(controllerNode.position.x * .05, controllerNode.position.y * .1);
	
	CGRect enemyRect = CGRectMake(enemy.position.x - 60,enemy.position.y +10,60,140);
	for(Weapon *weapon in weapons){
		if(weapon.visible && weapon.position.x < -weapon.parent.position.x + 1200){
			
			CGRect weaponRect = CGRectMake(weapon.position.x - 15,weapon.position.y - 15,30,30);
			
			
			
			CGRect enemyJumpRect = CGRectMake(enemy.position.x - 400,enemy.position.y - 200 ,100,400);
			
			if(CGRectIntersectsRect(enemyJumpRect, weaponRect)  && weapon.xSpeed > 0){
				
				if(arc4random() % 3 == 1){
					enemy.willJump = YES;
				}
			}
			if(CGRectIntersectsRect(enemyRect, weaponRect)){
				[enemy didGetHit];
				if(![bub isRunningActions])[bub setStringTo:[randomPowerWords objectAtIndex: arc4random() % [randomPowerWords count]] miniString:[NSString stringWithFormat:@"+%d",1000 * (hitsWithoutMisses +1)]];
				[self explodeEnemy];
				[weapon didHit];
				
				score += 1000 * (hitsWithoutMisses +1);
				
				id scal = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.15 scale:1] rate:2.0];
				
				id scal2 = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.15 scale:.6] rate:2.0];
				
				id scal3 = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.1 scale:.7] rate:2.0];
				
				[scores runAction:[CCSequence actions:scal,scal2,scal3,nil]];
				
			}
		}
	}
	for(Weapon *weapon in weapons){
		
		if(weapon.visible)[weapon update];
		
		if((weapon.position.y + controllerNode.position.y)  < -100)weapon.visible = NO;
		
	}
	enemy.offsetX =  currentCollisionMap.position.x;
	if(!dead){
		[enemy update];
	}
	
	if(dead){
		
		if(enemy.position.x < -enemy.parent.position.x + 1400){
			[enemy update];
		}
		
	}
	wheels.rotation = skater.rotation * 1.1;
	
	wheels.position = ccp(48 - skater.rotation * .0,147);
	
	bodyCntrlNode.position = ccp((skater.rotation) * .4,-(skater.rotation) * .1);
	
	headCntrlNode.position = ccp((skater.rotation) * .6,-(skater.rotation) * .1);
	
	bodyCntrlNode.rotation = -(skater.rotation) * .4;
	
	headCntrlNode.rotation = -(skater.rotation) * .4;
	
	int offset = ySpeed;
	
	if(offset > 10)offset = 10;
	if(offset < -10)offset = -10;
	
	skater.position = ccp(50 + skater.rotation * .4, 183 -  ((skater.position.x - offset) - offset)  * .1 );
	
	if(xSpeed > maxSpeed)xSpeed = xSpeed * .999;
	
	if(beganLoadingForJump){
		
		ySpeed -= jumpFactor;
		if(floor(jumpFactor) == 0)beganLoadingForJump = NO;
	}
	
	jumpFactor = jumpFactor * .80;
	
	if(jumpPower != 0){
		jumpPower = jumpPower * .75;
	}
	
	//skater.rotation = skater.rotation * .80;
	
	int x = ([currentCollisionMap convertToNodeSpace:skater.position].x) / currentCollisionMap.tileSize.width;
	
	int y = (currentCollisionMap.contentSize.height / currentCollisionMap.tileSize.height) - ([currentCollisionMap convertToNodeSpace:ccp(50,140)].y / currentCollisionMap.tileSize.height);
	
	if(enemy.currentCollisionMap1 == currentCollisionMap && enemy.xTile == currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width ){
		
		enemy.currentCollisionMap1 = lastMap;
		
		[enemy loadNewMapData1];
		
	}
	
	for(Bone *bone in bones){
		if(bone.visible){
			
			
			if(bone.currentCollisionMap1 == currentCollisionMap && bone.xTile == currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width ){
				
				bone.currentCollisionMap1 = lastMap;
				
				[bone loadNewMapData1];
				
			}	
			
			
		}
		
	}
	
	if(currentMaps == 2 &&  x == currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width){
		
		willDissapear.visible = YES;
		willDissapear = currentCollisionMap;
		
		currentMaps -= 1;
		
		currentCollisionMap = lastMap;
		
		collisionLayer = [lastMap layerNamed:@"top"];
		
		[self loadNewMapData];
		
		x = ([currentCollisionMap convertToNodeSpace:skater.position].x) / currentCollisionMap.tileSize.width;
		
		y = (currentCollisionMap.contentSize.height / currentCollisionMap.tileSize.height) - ([currentCollisionMap convertToNodeSpace:ccp(50,140)].y / currentCollisionMap.tileSize.height);
		
	}
	
	if([controllerNode convertToWorldSpace:ccp(willDissapear.position.x + willDissapear.contentSize.width,0)].x < 0 && willDissapear.visible){
		
		willDissapear.visible = NO;
		
		[maps addObject:willDissapear];
		
	}
	
	int desiredY = (mapPoints[x].y) / currentCollisionMap.tileSize.height;
	
	if(desiredY < y && (!fallThrough)){
		
		ySpeed = 0;
		
		
	}
	
	//NSLog(@"%d, %d",y,desiredY);
	
	float fract = (([currentCollisionMap convertToNodeSpace:skater.position].x -10) - (x * currentCollisionMap.tileSize.width)) / currentCollisionMap.tileSize.width;
	
	int yPosition = (mapPoints[x].y - 170 - currentCollisionMap.position.y) + ((mapPoints[x+1].y - mapPoints[x].y) * fract) ;
	
	controllerNode.position = ccp(controllerNode.position.x -xSpeed, controllerNode.position.y );
	//xSpeed += .01;
	
	if([[currentCollisionMap layerNamed:@"top"] tileGIDAt:ccp(x,desiredY)] == 26){
		
		fallThrough = YES;
		
		controllerNode.position = ccp(controllerNode.position.x, controllerNode.position.y +  ySpeed );
		
	}else{
		
		fallThrough = NO;
		
	}
	
	if(yPosition - controllerNode.position.y < -50 && !fallThrough){
		
		[self unscheduleUpdate];
		ySpeed = ySpeed *.4;
		fallThrough = YES;
		
		[self schedule:@selector(dead:)];
		
		
		
	}
	
	if([self convertToNodeSpace:enemy.position].x  + controllerNode.position.x <= 300 && enemy.xSpeed < xSpeed){
		
		enemy.xSpeed = xSpeed;
		
	}
	
	if([self convertToNodeSpace:enemy.position].x  + controllerNode.position.x <= 600 && enemy.xSpeed < xSpeed +3){
		
		enemy.xSpeed -= (enemy.xSpeed -(xSpeed +3)) / 30;
		
	}
	
	if(controllerNode.position.y + ySpeed < yPosition){
		
		
		controllerNode.position = ccp(controllerNode.position.x, controllerNode.position.y +  ySpeed );
		if( (desiredY - y) <= 2 && ((skater.rotation - ((mapPoints[x+1].y - mapPoints[x].y) * .3 )) / 3)  > -5 && ((skater.rotation - ((mapPoints[x+1].y - mapPoints[x].y) * .5 )) / 3)  < 5)skater.rotation -= (skater.rotation - ((mapPoints[x+1].y - mapPoints[x].y) * 1.2 )) * .01;
		if((desiredY - y) >= 2 && skater.rotation < 0)skater.rotation = skater.rotation * .95;
	}else if(!fallThrough){
		
		
		if(ySpeed > 3){
			skateSoundTic = 398;
		}
		
		if(ySpeed > 3 &&  [head numberOfRunningActions] == 0 &&  [body numberOfRunningActions] == 0 ){
			
			id moveBod = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 6)]rate:2.0];
			
			CCSequence *bodySequence = [CCSequence actions:moveBod,[moveBod reverse],nil];
			[body runAction:bodySequence];
			
			id moveHead = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 4)]rate:2.0];
			
			CCSequence *headSequence = [CCSequence actions:moveHead,[moveHead reverse],nil];
			[head runAction:headSequence];	
			
			
			id moveSpecs = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.15 position:ccp(0,-ySpeed / 4)]rate:2.0];

			
			CCSequence *headSequence2 = [CCSequence actions:moveSpecs,[moveSpecs reverse],nil];; 
			[specs runAction:headSequence2];
			
		}
		
		if(ySpeed < 3 && ySpeed > 0 &&  [head numberOfRunningActions] == 0 &&  [body numberOfRunningActions] == 0 ){
			
			id moveBod = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 2)]rate:2.0];
			
			CCSequence *bodySequence = [CCSequence actions:moveBod,[moveBod reverse],nil];
			[body runAction:bodySequence];
			
			id moveHead = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 1)]rate:2.0];
			
			CCSequence *headSequence = [CCSequence actions:moveHead,[moveHead reverse],nil];
			[head runAction:headSequence];	
			
			id moveSpecs = [CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:.2 position:ccp(0,-ySpeed / 1)]rate:2.0];

			
			CCSequence *headSequence2 = [CCSequence actions:moveSpecs,[moveSpecs reverse],nil];; 
			[specs runAction:headSequence2];
			
		}
		
		
		if(x+3 < (currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width)){
			
		}else{
			
		}
		
		if(!blackOut){
			
			ySpeed = (yPosition -controllerNode.position.y) ;
			
			if((desiredY - y) <= 1 && x <  (currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width))skater.rotation -= (skater.rotation - ((mapPoints[x+1].y - mapPoints[x].y) * .4 )) * .5;
			
			if((mapPoints[x+1].y - mapPoints[x].y) > 0){
				
				if(!dead)xSpeed += .5;
				//ySpeed += 5;
				
				
			}
			
			if((mapPoints[x+1].y - mapPoints[x].y) < 0){
				
				xSpeed = xSpeed * .995;
				if(xSpeed < 25 && !dead)xSpeed = 25;
				//ySpeed += 4;
				
			}
			
			
			
			
			
			if([self convertToNodeSpace:enemy.position].x  + controllerNode.position.x >= 1400 && enemy.xSpeed > xSpeed){
				
				if(!dead)enemy.xSpeed -=4;
				
			}
			
			if([self convertToNodeSpace:enemy.position].x  + controllerNode.position.x >= 1400 && enemy.xSpeed > xSpeed){
				
				CCTMXTiledMap *map = [maps objectAtIndex:arc4random() % [maps count]];
				
				enemy.position = ccp(skater.position.x-800,skater.position.y);
				enemy.currentCollisionMap1 = map;
				[enemy loadNewMapData1];
				
				enemy.xSpeed = xSpeed / 2;
				
				[enemy changeApperance];
				
			}
			
		}else{
			
			skater.rotation = skater.rotation * .8;
			
		}
		
		if(x >  1 && x < (currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width) - 5)blackOut = NO;
		
		if(!fallThrough && controllerNode.position.y - yPosition > -30 && controllerNode.position.y - yPosition < 30 )controllerNode.position = ccp(controllerNode.position.x, yPosition);
		
	}
	
	if(x >= 0 && x < (currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width) -1){
		
		//xSpeed += .01;
		
		if(controllerNode.position.y > yPosition){
			
			
			//jumpPower += (controllerNode.position.y - yPosition);
			
			if(!fallThrough)controllerNode.position = ccp(controllerNode.position.x, yPosition);
			
			//ySpeed = 0;
			
		}else{
			
			
			if(jumpPower != 0){
				
				controllerNode.position = ccp(controllerNode.position.x , controllerNode.position.y - jumpPower);
				
			}
			
			
		}
		
		if(!beganLoadingForJump)ySpeed += 1.0;
		
	}
	
	if(currentMaps == 1 && [controllerNode convertToWorldSpace:ccp(currentCollisionMap.position.x + (currentCollisionMap.contentSize.width ), 0) ].x  < 700 ){
		
		int fx = (currentCollisionMap.contentSize.width / currentCollisionMap.tileSize.width) -1;
		
		int lastY = ((currentCollisionMap.contentSize.height / currentCollisionMap.tileSize.height)) - (mapPoints[fx].y / currentCollisionMap.tileSize.height);
		
		CCTMXTiledMap *map = [maps objectAtIndex:arc4random() % [maps count]];
		int newY;
		
		for(int y = 0; y < (map.contentSize.height / map.tileSize.height) -1; y ++){
			
			if([[map layerNamed:@"top"] tileGIDAt:ccp(0, y)] != 0){
				
				newY = ((map.contentSize.height / map.tileSize.height)) - y;
				
				break;	
			}
		}
		
		map.position = ccp(currentCollisionMap.position.x + (currentCollisionMap.contentSize.width) ,currentCollisionMap.position.y  - ( (newY - lastY)   * currentCollisionMap.tileSize.height));
		
		currentMaps += 1;
		
		[maps removeObject:map];
		
		lastMap = map;
		lastMap.visible = YES;
		
		
		if(enemy.position.x + controllerNode.position.x < 0 ){
			
			//enemy.position = ccp(skater.position.x-800,skater.position.y);
			enemy.position = ccp(map.position.x - 200, map.position.y-1000);
			enemy.currentCollisionMap1 = map;
			
			[enemy loadNewMapData1];
			
		}
		
	}
	
	//	NSLog(@"%f",[controllerNode convertToWorldSpace:currentCollisionMap.position].x + (currentCollisionMap.contentSize.width / 2));
	
}

-(float)gimmexSpeed {
	
	return xSpeed;
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"graphicsSheet.plist"];
	[[CCTextureCache sharedTextureCache] removeTexture:@"graphicsSheet.png"];
	
	
	
	 [maps release];
	 [weapons release];
	 [bones release];
	 [randomPowerWords release];
	 [randomDissWords release];
	 [bulletHitParticles release];
	 [highscores release];
	
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end


