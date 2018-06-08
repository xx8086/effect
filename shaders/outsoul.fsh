
precision mediump float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform float ratio;
//uniform float width;
//uniform float height;

//输入uv返回映射之后的uv,xLength为边框的大小
/*
vec2 mapuv(float2 uv,float xLength){
    vec2 newuv;
    float rate=(1-2*xLength)/1;
    if(uv.x>xLength&&uv.x<(1-xLength)&&uv.y>xLength&&uv.y<(1-xLength))
    {
        newuv.x=(uv.x-xLength)/rate;
        newuv.y=(uv.y-xLength)/rate;
    }
    else
    {
        newuv.x=uv.x;
        newuv.y=uv.y;
    }
    return newuv;
}
 */
void main(void)
{
    vec2 center = vec2(0.5, 0.5);
    vec2 distance = center - textureCoordinate;
    float x=center.x+ center.x*(-distance.x/center.x) * ratio;
    float y=center.y+ center.y*(-distance.y/center.y) * ratio;
    vec2 tex = vec2(x,y);
    
    vec4 sample_tex = texture2D(inputImageTexture, textureCoordinate);
    vec4 sample_offset = texture2D(inputImageTexture, tex);
    gl_FragColor = vec4(mix(sample_tex, sample_offset, 0.4));
}

