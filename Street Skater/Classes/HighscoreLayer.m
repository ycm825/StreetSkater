//
//  HighscoreLayer.m
//  SkateTap
//
//  Created by Daniel Grönlund on 2011-07-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighscoreLayer.h"
#define kBackButton 1
#define kMyScores 2
#define kTopScores 3
#define kLoadMore 4

@implementation HighscoreLayer
@synthesize score;
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
				
		CCSprite *bkgnd = [CCSprite spriteWithFile:@"background.png"];
		
		[self addChild:bkgnd];
		
		bkgnd.position = ccp(240,160);
		//[self requestScore:kQueryAllTime];
		
		//[self showAlert];
		self.visible = YES;
		
		scrollNode = [CCNode node];
		[self addChild:scrollNode];
		
		Button *back =[Button spriteWithFile:@"backButton.png"];
		[self addChild:back z:1 tag:kBackButton];
		back.position = ccp( (back.contentSize.width / 2 ),  (back.contentSize.height / 2));
		
		Button *myScores =[Button spriteWithFile:@"myScoreButton.png"];
		[self addChild:myScores z:1 tag:kMyScores];
		myScores.position = ccp(back.position.x + (back.contentSize.width / 2) + (myScores.contentSize.width / 2 ),  (myScores.contentSize.height / 2));
		
		Button *top =[Button spriteWithFile:@"topButton.png"];
		[self addChild:top z:1 tag:kTopScores];
		top.position = ccp(myScores.position.x + (myScores.contentSize.width / 2 ) + (top.contentSize.width / 2),  (top.contentSize.height / 2));
		
		[self scheduleUpdate];
		positionOffset = 0;
		
		
		more = [Button spriteWithFile:@"loadMore.png"];
		[self addChild:more z:1 tag:kLoadMore];
		more.position = ccp(top.position.x  + (top.contentSize.width / 2) + (more.contentSize.width / 2),  (more.contentSize.height / 2));

		more.opacity = 0;
		
	}
	
	return self;
	
}

-(void)buttonTapped:(Button*)btn {
	
	if(btn.tag == kLoadMore && btn.opacity == 255){
		[self cleanAll];
		
		scrollNode.position = ccp(scrollNode.position.x, 0);
		
		[self requestScore:currentFlags offset:positionOffset+50];
		
		id fad = [CCEaseInOut actionWithAction:[CCFadeOut actionWithDuration:.5] rate:2];
		[more runAction:fad];
		
	}
	
	if(btn.tag == kBackButton){
		
		[self unscheduleUpdate];
		self.visible = NO;
		
	}
	
	if(btn.tag == kMyScores){
		[self cleanAll];
		
		[self requestScore:kQueryFlagByDevice offset:0];
		
		
	}
	
	if(btn.tag == kTopScores){
		[self cleanAll];
		
		[self requestScore:kQueryAllTime offset:0];
		
		
	}

}
- (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array 
{
	id objectInstance;
	NSUInteger indexKey = 0;
	
	NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
	for (objectInstance in array) {
		[mutableDictionary setObject:objectInstance forKey:[NSNumber numberWithInt:indexKey]];
		indexKey++;
	}
	
	return (NSDictionary *)[mutableDictionary autorelease];
}

- (void)onEnter {
	
	[super onEnter];
	
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches: YES];
	
	self.isTouchEnabled = YES;
	
}


- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
	if(!self.visible)return NO;
	
	touchDown = YES;
	
	CGPoint location = [touch locationInView: [touch view]];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	firstTouch = location.y;
	return YES;
	
}

- (void)ccTouchMoved:(UITouch*)touch withEvent:(UIEvent*)event
{
	
	//UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	//scrollNode.position = ccp(scrollNode.position.x, scrollNode.position.y  +( location.y -firstTouch) );
	
	ySpeed = location.y -firstTouch;
	
	firstTouch = location.y;
}


- (void)ccTouchEnded:(UITouch*)touch withEvent:(UIEvent*)event
{
	
	if(scrollNode.position.y < 0){
		
		id move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:.3 position:ccp(scrollNode.position.x, 0)] rate:2];
		[scrollNode runAction:move];
		ySpeed = 0;
		
		
	}
	
	
	
	
	if(scrollNode.position.y > ([scrollNode.children count] * 30) - 250){
		
		id move = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:.3 position:ccp(scrollNode.position.x, ([scrollNode.children count] * 30)- 250)] rate:2];
		[scrollNode runAction:move];
		ySpeed = 0;
		
	}
	
	CGPoint location = [touch locationInView: [touch view]];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	touchDown = NO;
	
}

-(void) requestScore:(tQueryFlags)flag offset:(int)offset{
    // create a Request object for the game "DemoGame"
    // You need to implement the Score Request Delegate
    CLScoreServerRequest *request = [[CLScoreServerRequest alloc] initWithGameName:@"Street Skater" delegate:self];
	
	/* use kQueryFlagIgnore to request World scores */
	tQueryFlags flags = flag;
	
	/* or use kQueryFlagCountry to request the best scores of your country */
	// tQueryFlags flags = kQueryFlagByCountry;
	
	// request the first 15 scores ( offset:0 limit:15)
	// request AllTime best scores (this is the only supported option in v0.1
	// request the scores for the category "easy"
	
	[request requestScores:kQueryAllTime limit:50 offset:offset flags:flags category:@"classic"];
	
	positionOffset = offset;
	
	currentFlags = flags;
  	
	// Release. It won't be freed from memory until the connection fails or suceeds
	
	[request release];
	
}

// ScoreRequest delegate
-(void) scoreRequestOk: (id) sender {
    // the scores are stored in a
	
	wifiAlert = NO;
	
	NSArray *scores = [sender parseScores];
	
	NSMutableArray *mutable = [NSMutableArray arrayWithArray:scores];
	
	//NSLog(@"%@",[mutable objectAtIndex:1]);
	
	// use the property (retain is needed)
	globalScores = mutable;
	[globalScores retain];
	
	for (int i = 0; i < [globalScores count]; i++){
		
		NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
		
		[d setDictionary:[globalScores objectAtIndex:i]];

		//NSLog(@"%@",[d objectForKey:@"cc_playername"]);
		
		HighscoreCell  * cell = [HighscoreCell node];
		
		NSString *test =[d objectForKey:@"usr_device_id"];
		NSString *test2 =[[UIDevice currentDevice] uniqueIdentifier];
		
		if( [test isEqualToString:test2] ){

			[cell  setScoreForName:[NSString stringWithFormat:@"%d. %@",[[d objectForKey:@"position"]intValue] +1 ,[d objectForKey:@"cc_playername"]] score:[[d objectForKey:@"cc_score"]intValue] myScore:YES];
			cell.position = ccp(0, 310 - i * 30);
		
		}else{
			
		[cell  setScoreForName:[NSString stringWithFormat:@"%d. %@",[[d objectForKey:@"position"]intValue] +1 ,[d objectForKey:@"cc_playername"]] score:[[d objectForKey:@"cc_score"]intValue]];
		cell.position = ccp(0, 310 - i * 30);
			
		}
		
		[scrollNode addChild:cell];
		
	}
	
	scrollNode.position = ccp(scrollNode.position.x, 0);
	ySpeed = 0;
	//[table reloadData];	
	
    // Display them as you wish: using a UITableView,
    // a custom CocosNode, etc...
	
	
	
}

-(void)update:(ccTime)dt {
	
	scrollNode.position = ccp(scrollNode.position.x, scrollNode.position.y + ySpeed);
	
	ySpeed = ySpeed * 0.92;
	
	if(scrollNode.position.y < 0 && !touchDown && [scrollNode numberOfRunningActions] == 0){
	
		
		scrollNode.position = ccp(scrollNode.position.x, 0);
		ySpeed = 0;
		
	}
	
	
	if(scrollNode.position.y > ([scrollNode.children count] * 30) - 250 && [scrollNode numberOfRunningActions] == 0){
		
		
		scrollNode.position = ccp(scrollNode.position.x, ([scrollNode.children count] * 30) -250);
		ySpeed = 0;
		
	}
	
	if(scrollNode.position.y > ([scrollNode.children count] * 30) - 300  && [scrollNode.children count] >= 50){
		
		if([more numberOfRunningActions] == 0 && more.opacity == 0){
			
			id fad = [CCEaseInOut actionWithAction:[CCFadeIn actionWithDuration:.5] rate:2];
			[more runAction:fad];
			
		}
		
	}
	
	if(scrollNode.position.y < ([scrollNode.children count] * 30) - 300){
		
		if([more numberOfRunningActions] == 0 && more.opacity == 255){
			
			id fad = [CCEaseInOut actionWithAction:[CCFadeOut actionWithDuration:.5] rate:2];
			[more runAction:fad];
			
		}
		
	}
	
}

- (void)showAlert {
	
	UIAlertView* dialog = [[[UIAlertView alloc] init] retain]; 
	[dialog setDelegate:self]; 
	[dialog setTitle:@"Enter Name"]; 
	[dialog setMessage:@" "];
	[dialog addButtonWithTitle:@"OK"]; 
	nameField = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 30.0, 245.0, 25.0)]; 
	[nameField setBackgroundColor:[UIColor whiteColor]]; 
	[dialog addSubview:nameField]; 
	
	[dialog show]; 
	[dialog release]; 
	[nameField becomeFirstResponder];
	[nameField release]; 
	
}
-(void)cleanAll {
	
	[scrollNode removeAllChildrenWithCleanup:YES];
	
}


- (void)showWifiAlert {
	
	nameField.text = @"";
	UIAlertView* dialog = [[[UIAlertView alloc] init] retain]; 
	[dialog setDelegate:self]; 
	[dialog setTitle:@"Connection fail"]; 
	[dialog setMessage:@" "];
	[dialog addButtonWithTitle:@"OK"];
	[dialog show]; 
	[dialog release]; 
	
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex: (NSInteger)buttonIndex{
	
	if(!wifiAlert){
		if(nameField.text != @""){
			[self postScoreWithName:[nameField text]];
			
			
			/*
			[item1 setIsEnabled:NO];
			item1.visible = NO;
			[item2 setIsEnabled:YES];
			item2.visible = YES;
			 */
		}
		
	}else{
		
		
	}
	
	
	
}

-(void) scoreRequestFail: (id) sender {
	wifiAlert = YES;
	[self showWifiAlert];
    // request failed. Display an error message.
}


-(void) postScoreWithName:(NSString *)name {
    // Create que "post" object for the game "DemoGame"
    // The gameKey is the secret key that is generated when you create you game in cocos live.
	
	if([name isEqualToString:@""])name = @"Anonymous";
	if([name isEqualToString:@" "])name = @"Anonymous";
	if([name isEqualToString:@"  "])name = @"Anonymous";
	if([name isEqualToString:@"   "])name = @"Anonymous";

    if(name == nil){
		
	}else{
		
		CLScoreServerPost *server = [[CLScoreServerPost alloc] initWithGameName:@"Street Skater" gameKey:@"6c07e42ddcb2dc3409e38b4d0f223dd1" delegate:self];
		
		NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
		
		// usr_ are fields that can be modified.
		// set score
		
		[dict setObject: [NSNumber numberWithInt: score ] forKey:@"cc_score"];
		
		// set playername
		[dict setObject:name forKey:@"cc_playername"];

		[dict setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"usr_device_id"];

		// cc_ are fields that cannot be modified. cocos fields
		// set category... it can be "easy", "medium", whatever you want.
		[dict setObject:@"classic" forKey:@"cc_category"];
		
		[server sendScore:dict];
		
		// Release. It won't be freed from memory until the connection fails or suceeds
		[server release];
		
	}
}

// PostScore Delegate
-(void) scorePostOk: (id) sender {
	wifiAlert = NO;
	
	[self cleanAll];
	
	[self requestScore:kQueryAllTime offset:0];
	
	
    // Score post successful
}

-(void) scoreRequestRankOk: (id) sender {
	
	
}
-(void) scoreRequestRankFail: (id) sender {
	
	
}


-(void) scorePostFail: (id) sender {
    // score post failed
    tPostStatus status = [sender postStatus];
    if( status == kPostStatusPostFailed ) {
		
        // an error with the server ?
		
		wifiAlert = YES;
		
		[self showWifiAlert];
        // try again
		
    }else if( status == kPostStatusConnectionFailed ) { 
		
        // a error establishing the connection ?
        // turn-on wifi, and then try again
		
		wifiAlert = YES;
		[self showWifiAlert];
    }
}



- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
