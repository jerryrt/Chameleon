//
//  MPMoviePlayerControllerView.h
//  MediaPlayer
//
//  Created by Shen Slavik on 3/5/13.
//
//

#import <UIKit/UIKit.h>
#import "MPMovieProgressBar.h"
#import "MPVolumeBar.h"
#import "AVPlayerItem+PlaybackStatusAfx.h"

@interface MPMoviePlayerCtrlPanel : UIView

@property(nonatomic,readonly,assign) UIButton* playButton;
@property(nonatomic,readonly,assign) MPMovieProgressBar* progressBar;
@property(nonatomic,readonly,assign) UIButton* fullscreenButton;
@property(nonatomic,readonly,assign) UILabel* currentTimeLabel;
@property(nonatomic,readonly,assign) UILabel* durationTimeLabel;
@property(nonatomic,readonly,assign) MPVolumeBar* volumeBar;

- (void)showTimeState:(MPPlaybackTimeState)time;

@end
