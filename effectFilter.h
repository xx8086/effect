//
//  effectFilter.h
//  SimpleVideoFileFilter
//
//  Created by liu on 2018/6/6.
//  Copyright © 2018年 Cell Phone. All rights reserved.
//

#ifndef effectFilter_h
#define effectFilter_h
#import "GPUImage.h"

@interface EffectFilter : GPUImageFilter
- (id)set_vertex_shaderfile:(NSString *)vertex_shader fragment_shaderfile:(NSString *)fragment_shader;
@end

#endif /* effectFilter_h */
