//
//  QTMovie+PlaybackStatusAfx.m
//  MediaPlayer
//
//  Created by Shen Slavik on 3/5/13.
//
//

#import "AVPlayerItem+PlaybackStatusAfx.h"

@implementation AVPlayerItem (PlaybackStatusAfx)

-(NSTimeInterval)maxSecondsLoaded {
    NSArray * timeRangeArray = self.loadedTimeRanges;
    
    if (timeRangeArray.count <= 0)
        return 0.0f;
    
    CMTimeRange aTimeRange = [[timeRangeArray objectAtIndex:0] CMTimeRangeValue];
    
    double startTime = CMTimeGetSeconds(aTimeRange.start);
    double loadedDuration = CMTimeGetSeconds(aTimeRange.duration);
    
    // FIXME: shoule we sum up all sections to have a total playable duration,
    // or we just use first section as whole?
    
//    NSLog(@"get time range, its start is %f seconds, its duration is %f seconds.", startTime, loadedDuration);
    
    
    return (NSTimeInterval)(startTime + loadedDuration);
}

-(NSTimeInterval)durationSecond {
    return CMTimeGetSeconds(self.duration);
}

-(NSTimeInterval)playedSeconds {
    return CMTimeGetSeconds(self.currentTime);
}

-(void)setPlayedSeconds:(NSTimeInterval)seconds {

    NSTimeInterval max = [self maxSecondsLoaded];
    if( seconds > max ) {
        // abort when try to set over the max
        return;
    } else if ( seconds < 0 ) {
        seconds = 0;
    }

    CMTime newTime = CMTimeMakeWithSeconds(seconds, 1);
    [self seekToTime:newTime];

}

-(CGFloat)percentLoaded
{
    NSTimeInterval tMaxLoaded = self.maxSecondsLoaded;
    NSTimeInterval tDuration = self.durationSecond;
    
    if( tDuration > 0.0f ) {
        return (CGFloat) tMaxLoaded/tDuration;
    }
    
    return 0.0f;
}

-(CGFloat)percentPlayed {

    NSTimeInterval tCurrentTime = self.playedSeconds;
    NSTimeInterval tDuration = self.durationSecond;
    
    if( tDuration > 0.0f ) {
        return (CGFloat) tCurrentTime/tDuration;
    }
    
    return 0.0f;

}

-(void)gotoPercent:(CGFloat)percent {

    NSLog(@"goto percent: %0.2f", percent);

    NSTimeInterval duration = [self durationSecond];
    NSTimeInterval newTime = duration*percent;
    
    NSLog(@"goto time: %0.2f", newTime);
    
    [self setPlayedSeconds:newTime];
    
}


-(MPPlaybackTimeState)playbackTimeState {

    NSTimeInterval tMaxLoaded = self.maxSecondsLoaded;
    NSTimeInterval tDuration = self.durationSecond;
    NSTimeInterval tCurrentTime = self.playedSeconds;
    
    MPPlaybackTimeState state;
    state.duration = tDuration;
    state.maxLoaded = tMaxLoaded;
    state.current = tCurrentTime;

    if( tDuration > 0.0f ) {
        state.percentLoaded = (CGFloat) tMaxLoaded/tDuration;
        state.percentPlayed = (CGFloat) tCurrentTime/tDuration;
    }
    
    return state;
    
}


@end
