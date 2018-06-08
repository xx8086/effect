//
//  effectFilter.m
//  SimpleVideoFileFilter
//
//  Created by liu on 2018/6/6.
//  Copyright © 2018年 Cell Phone. All rights reserved.
//

#import "effectFilter.h"
@implementation EffectFilter

- (id) init{
    if (!(self = [super init])){
        return nil;
    }
    return self;
}

- (id)set_vertex_shaderfile:(NSString *)vertex_shader fragment_shaderfile:(NSString *)fragment_shader{
    NSString *vertex_string = nil;
    NSString *fragment_string = nil;
    if(nil != vertex_shader){
        NSString *vertexShaderPathname = [[NSBundle mainBundle] pathForResource:vertex_shader ofType:@"vsh"];
        vertex_string = [NSString stringWithContentsOfFile:vertexShaderPathname encoding:NSUTF8StringEncoding error:nil];
    }else{
        vertex_string = kGPUImageVertexShaderString;
    }
    if(nil != fragment_shader){
        NSString *fragmentShaderPathname = [[NSBundle mainBundle] pathForResource:fragment_shader ofType:@"fsh"];
        fragment_string = [NSString stringWithContentsOfFile:fragmentShaderPathname encoding:NSUTF8StringEncoding error:nil];
    }else{
        fragment_string = kGPUImagePassthroughFragmentShaderString;
    }
    
    
    if (!(self = [self initWithVertexShaderFromString:vertex_string fragmentShaderFromString:fragment_string])){
        return nil;
    }
    return self;
}

@end
