//
//  effectPools.m
//  SimpleVideoFileFilter
//
//  Created by liu on 2018/6/6.
//  Copyright © 2018年 Cell Phone. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "effectPools.h"
#import "effectFilter.h"

@interface EffectPools ()

@end


@implementation EffectPools
EffectFilter* _effects[EFFECT_TYPE_COUNTS];
NSString* _fragment_shader_file[EFFECT_TYPE_COUNTS];
NSString* _vertex_shader_file[EFFECT_TYPE_COUNTS];
NSInteger _current_effect;
NSInteger _current_frame_counts;

-(void) clear{
    _current_effect = -1;
    _current_frame_counts = 0;
    for(int i = 0;i < EFFECT_TYPE_COUNTS; i++) {
        _vertex_shader_file[i] = nil;
        _fragment_shader_file[i] = nil;
        _effects[i] = nil;
    }
}
-(void) init_vertex_shader{//定点着色器shader
    //_vertex_shader_file[EFFECT_TYPE_OUTSOUL] = @"outsoul";
    //_vertex_shader_file[EFFECT_TYPE_SHAKE] = @"shake";
}
-(void) init_fragment_shaders{//片元着色器shader
    _fragment_shader_file[EFFECT_TYPE_OUTSOUL] = @"outsoul";
    _fragment_shader_file[EFFECT_TYPE_SHAKE] = @"shake";
    _fragment_shader_file[EFFECT_TYPE_MULTWONDOW] = @"mult_window";
    _fragment_shader_file[EFFECT_TYPE_BLUR] = @"blur";
}

-(id) init{
    if (!(self = [super init])){
        return nil;
    }
    [self clear];
    [self init_fragment_shaders];
    [self init_vertex_shader];
    for(int i = 0;i < EFFECT_TYPE_COUNTS; i++) {
        _effects[i] = [[EffectFilter alloc] set_vertex_shaderfile:_vertex_shader_file[i] fragment_shaderfile:_fragment_shader_file[i]];
    }
    return self;
}

-(void) update:(NSInteger)frameid{
    if(frameid >= _current_frame_counts ){
        frameid = 0;
    }
    float ratio = 1.0 - (float)frameid*10/(_current_frame_counts);
    
    switch(_current_effect){
        case EFFECT_TYPE_OUTSOUL:
        {
            [self render_outsoul_ratio:ratio render_outsoul_alpha:0.7];
        }
            break;
        case EFFECT_TYPE_SHAKE:
        {
            [self render_shake_ratio:ratio];
        }
            break;
        case EFFECT_TYPE_BLUR:
        {
            [self render_blur_ratio:1.0/150 render_blur_range:0.3];
        }
            break;
        case EFFECT_TYPE_MULTWONDOW:
        {
            [self render_mult_window:frameid%2 ? 4 : 9];//9
        }
            break;
        default:
            break;
    }
}
-(GPUImageFilter*) set_current_effect:(int)effecttype{
    _current_effect = effecttype;
    if (EFFECT_TYPE_COUNTS > effecttype && effecttype >= EFFECT_TYPE_OUTSOUL) {
        return _effects[effecttype];
    }
    return nil;
}

-(void) set_current_frame_counts:(NSInteger)framecounts{
    _current_frame_counts = framecounts;
}

-(GPUImageFilter*) get_effect:(int) effecttype{
    return _effects[effecttype];
}

-(void) render_outsoul_ratio:(float)ratio render_outsoul_alpha:(float)alpha{
    [_effects[EFFECT_TYPE_OUTSOUL] setFloat:ratio forUniformName:@"ratio"];
    [_effects[EFFECT_TYPE_OUTSOUL] setFloat:alpha forUniformName:@"alpha"];
    //CGRect rx = [ UIScreen mainScreen ].bounds;
    //[_effects[EFFECT_TYPE_OUTSOUL] setFloat:rx.size.width forUniformName:@"width"];
    //[_effects[EFFECT_TYPE_OUTSOUL] setFloat:rx.size.height forUniformName:@"height"];
}

-(void) render_shake_ratio:(float)ratio{
    [_effects[EFFECT_TYPE_SHAKE] setFloat:ratio forUniformName:@"ratio"];
}
    
-(void) render_blur_ratio:(float)ratio render_blur_range:(float)range{
    [_effects[EFFECT_TYPE_BLUR] setFloat:ratio forUniformName:@"ratio"];
    [_effects[EFFECT_TYPE_BLUR] setFloat:range forUniformName:@"range"];
}
    
    -(void) render_mult_window:(int)window_counts{
        [_effects[EFFECT_TYPE_MULTWONDOW] setInteger:window_counts forUniformName:@"window_counts"];
    }
    

@end
