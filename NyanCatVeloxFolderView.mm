#import "VeloxFolderViewProtocol.h"
#import "Velox.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PSVeloxFolderView : UIView <VeloxFolderViewProtocol, AVAudioPlayerDelegate> {
	AVAudioPlayer *nyanAudio;
	UIImageView *nyanCatImages;
}
@property (nonatomic,retain) AVAudioPlayer *nyanAudio;
@property (nonatomic, retain) UIImageView *nyanCatImages;
@end

@implementation PSVeloxFolderView
@synthesize nyanAudio, nyanCatImages;

- (UIView *)initWithFrame:(CGRect)aFrame
{
	self = [super initWithFrame:aFrame];
   	if (self) {
    	int numberOfFrames = 12;
    	NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:numberOfFrames];
    	
    	for (int i = 1; numberOfFrames >= i; i++)
    	{
    		// list of images to create animation
       		[imagesArray addObject:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"/Library/Velox/Plugins/NyanCatVelox.bundle/Nyancat%i.png", i]]];
    	}
    
    	nyanCatImages = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)] autorelease]; // size of images
    	nyanCatImages.animationImages = imagesArray; 
    	nyanCatImages.animationDuration = 1;
    
    	[nyanCatImages startAnimating];
    	[self addSubview:nyanCatImages];
    	[[objc_getClass("Velox") sharedManager] setCustomNotchImage:[UIImage imageWithContentsOfFile:@"/Library/Velox/Plugins/NyanCatVelox.bundle/notch.png"]];
    	[nyanCatImages startAnimating];
    	[self addSubview:nyanCatImages];
    	
    	[self performSelector:@selector(playSound)]; // Play Nyan Cat Music
	}
    return self;
}

- (void)playSound
{
	NSURL *url = [NSURL fileURLWithPath:@"/Library/Velox/Plugins/NyanCatVelox.bundle/nyan-looped.mp3"]; // where music file is located
	self.nyanAudio = [AVAudioPlayer alloc];
	 if ([nyanAudio initWithContentsOfURL:url error:NULL])
    		[nyanAudio autorelease];
   	 else {
	 	if ([nyanAudio initWithContentsOfURL:url error:NULL])
    			[nyanAudio autorelease];
   	 else {
    		[nyanAudio release];
    		nyanAudio = nil;
   	 }
   
  	 [nyanAudio setNumberOfLoops:-1]; // infinity loop
   	 [nyanAudio setDelegate:self];
   	 [nyanAudio play]; // play sound

}

- (void)dealloc
{
	[self.nyanAudio stop]; // stop playing music
	[self.nyanAudio release]; // release music
	[super dealloc];
}

+ (int)folderHeight
{
	return 320.0f; // So the animation size is 320x320 pixel
}

@end
