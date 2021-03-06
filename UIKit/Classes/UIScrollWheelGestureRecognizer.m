/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UIScrollWheelGestureRecognizer.h"
#import "UIPanGestureRecognizer.h"
#import "UIGestureRecognizerSubclass.h"
#import "UITouch+UIPrivate.h"
#import "UIEvent.h"
#import "UIView.h"

@implementation UIScrollWheelGestureRecognizer

- (CGPoint)translationInView:(UIView *)view
{
    return _translation;
}

- (void)setTranslation:(CGPoint)translation inView:(UIView *)view
{
    _translation = translation;
}

- (void)_discreteGestures:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForGestureRecognizer:self] anyObject];
    if (self.state == UIGestureRecognizerStatePossible && [touch _gesture] == _UITouchDiscreteGestureScrollWheel) {
        [self setTranslation:[touch _delta] inView:touch.view];
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    if( _delegateHas.shouldRecognizeSimultaneouslyWithGestureRecognizer ) {
        if( ![_delegate gestureRecognizer:self shouldRecognizeSimultaneouslyWithGestureRecognizer:preventingGestureRecognizer] ) {
            return YES;
        }
    }

    if( [preventingGestureRecognizer isKindOfClass:[self class]] ||
        [preventingGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] ) {
        UIView* superview = preventingGestureRecognizer.view.superview;
        UIView* v = self.view;
        while( superview ) {
            if( superview == v ) {
                return YES;
            }
            superview = superview.superview;
        }
        
//        UIGestureRecognizerState state = preventingGestureRecognizer.state;
//        if( UIGestureRecognizerStateBegan == state ||
//            UIGestureRecognizerStateChanged == state ||
//            UIGestureRecognizerStateEnded == state ) {
//            return YES;
//        }
    
    }
    return NO;
}

@end
