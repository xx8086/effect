
precision mediump float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform float ratio;

void main(void){
    vec2 center = vec2(0.5, 0.5);
    vec2 distance = center - textureCoordinate;
    float x = center.x + center.x*(-distance.x/center.x) * ratio;
    float y = center.y + center.y*(-distance.y/center.y) * ratio;
    vec2 tex = vec2(x,y);
    
    //vec2 sample_left = texture2D ( inputImageTexture, vec2 ( tex.x - fStep, tex.y - fStep ) );
    //vec2 sample_right = texture2D ( inputImageTexture, vec2 ( tex.x + fStep, tex.y + fStep ) );
    lowp vec4 sample_tex = texture2D(inputImageTexture, tex);
    gl_FragColor = sample_tex;
}
