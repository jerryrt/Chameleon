//
//  UIInternalMovieView.m
//  MediaPlayer
//
//  Created by Michael Dales on 08/07/2011.
//  Copyright 2011 Digital Flapjack Ltd. All rights reserved.
//

#import "UIInternalMovieView.h"

#import <AVFoundation/AVFoundation.h>
@interface UIInternalMovieView()

@end

@implementation UIInternalMovieView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if( self ) {
        self.userInteractionEnabled = NO;
        self.scalingMode = MPMovieScalingModeAspectFit;
    }
    
    return self;

}

- (AVPlayerLayer*)movieLayer {
    return (AVPlayerLayer*)self.layer;
}

- (void)setMovie:(AVPlayer *)movie {

    if( _movie ) {
        [_movie pause];
        [_movie release];
        [self.movieLayer setPlayer:nil];
    }
    _movie = [movie retain];
    if( _movie ) {
        [self.movieLayer setPlayer:_movie];
    }

}

///////////////////////////////////////////////////////////////////////////////
//
- (void)dealloc
{
    self.movie = nil;
    [super dealloc];
}

- (void)setScalingMode:(MPMovieScalingMode)scalingMode {

    if( _scalingMode != scalingMode ) {
        _scalingMode = scalingMode;
        
        NSString* gravity = kCAGravityResizeAspect;
        if( MPMovieScalingModeFill == _scalingMode ) {
            gravity = kCAGravityResizeAspectFill;
        } else if( MPMovieScalingModeFill == _scalingMode ) {
            gravity = kCAGravityResize;
        }
        self.layer.contentsGravity = gravity;
    }

}

@end
