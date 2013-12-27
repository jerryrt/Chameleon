//
//  QTMovie+PlaybackStatusAfx.h
//  MediaPlayer
//
//  Created by Shen Slavik on 3/5/13.
//
//

#import <AVFoundation/AVFoundation.h>

struct MPPlaybackTimeState {
  CGFloat percentLoaded;
  CGFloat percentPlayed;
  NSTimeInterval duration;
  NSTimeInterval maxLoaded;
  NSTimeInterval current;
};

typedef struct MPPlaybackTimeState MPPlaybackTimeState;


@interface AVPlayerItem(IdlingAdditions)

-(NSTimeInterval)maxTimeLoaded;
-(BOOL)isPlaying;

@end

@interface AVPlayerItem (PlaybackStatusAfx)

-(NSTimeInterval)maxSecondsLoaded;
-(NSTimeInterval)durationSecond;

-(NSTimeInterval)playedSeconds;
-(void)setPlayedSeconds:(NSTimeInterval)seconds;

-(void)gotoPercent:(CGFloat)percent;
-(CGFloat)percentLoaded;
-(CGFloat)percentPlayed;

-(MPPlaybackTimeState)playbackTimeState;

@end
