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
    _fragment_shader_file[EFFECT_TYPE_LIGHTING] = @"lighting";
    _fragment_shader_file[EFFECT_TYPE_INVERSION] = @"inversion";
    _fragment_shader_file[EFFECT_TYPE_VORTEX] = @"vortex";
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
    frameid = frameid * 10;
    if(frameid >= _current_frame_counts ){
        frameid = 0;
    }
    float ratio = 1.0 - (float)frameid/(_current_frame_counts);
    
    switch(_current_effect){
        case EFFECT_TYPE_OUTSOUL:
            [self render_outsoul_ratio:ratio render_outsoul_alpha:0.7];
            break;
        case EFFECT_TYPE_SHAKE:
            [self render_shake_ratio:ratio];
            break;
        default:
            break;
    }
}
-(void) set_current_effect:(int)effecttype{
    _current_effect = effecttype;
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
    CGRect rx = [ UIScreen mainScreen ].bounds;
    [_effects[EFFECT_TYPE_OUTSOUL] setFloat:rx.size.width forUniformName:@"width"];
    [_effects[EFFECT_TYPE_OUTSOUL] setFloat:rx.size.height forUniformName:@"height"];
}

-(void) render_shake_ratio:(float)ratio{
    [_effects[EFFECT_TYPE_SHAKE] setFloat:ratio forUniformName:@"ratio"];
}


@end
