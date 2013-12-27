//
//  UIInternalMovieView.h
//  MediaPlayer
//
//  Created by Michael Dales on 08/07/2011.
//  Copyright 2011 Digital Flapjack Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MPMoviePlayerController.h"
#import <UIKit/UIViewAdapter.h>

@class AVPlayer;
@class AVPlayerLayer;

@interface UIInternalMovieView : UIView 

@property (nonatomic, retain) AVPlayer * movie;
@property (nonatomic, readonly ) AVPlayerLayer* movieLayer;
@property (nonatomic, assign) MPMovieScalingMode scalingMode;

@end
