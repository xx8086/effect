//
//  effectPools.h
//  SimpleVideoFileFilter
//
//  Created by liu on 2018/6/6.
//  Copyright © 2018年 Cell Phone. All rights reserved.
//

#ifndef effectPools_h
#define effectPools_h
#import "GPUImage.h"

enum EffectType {
    EFFECT_TYPE_OUTSOUL = 0,
    EFFECT_TYPE_SHAKE = 1,
    EFFECT_TYPE_LIGHTING = 2,
    EFFECT_TYPE_INVERSION = 3,
    EFFECT_TYPE_VORTEX = 4,
    EFFECT_TYPE_MULTWONDOW = 5,
    EFFECT_TYPE_COUNTS,
} ;

@interface EffectPools : NSObject 
-(GPUImageFilter*) get_effect:(int)effecttype;
-(GPUImageFilter*) set_current_effect:(int)effecttype;
-(void) set_current_frame_counts:(NSInteger)framecounts;
-(void) update:(NSInteger)frameid;
@end

#endif /* effectPools_h */
