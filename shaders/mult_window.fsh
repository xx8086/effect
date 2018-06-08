
precision mediump float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;

vec2 mapuv(vec2 uv,float xLength){
    float rate = (1.0 - 2.0 * xLength);
    vec2 center = vec2(0.5, 0.5);
    vec2 distance = center - textureCoordinate;
    float x = uv.x + center.x*(-distance.x/center.x) * rate;
    float y = uv.y + center.y*(-distance.y/center.y) * rate;

    return vec2(x, y);
}

void main(void){
    float fstep = 0.5;
    vec2 tex = mapuv(textureCoordinate, 0.25);
    //vec4 sample_1 = texture2D(inputImageTexture, vec2(tex.x - fstep, tex.y + fstep));
    //vec4 sample_2 = texture2D(inputImageTexture, vec2(tex.x + fstep, tex.y + fstep));
    //vec4 sample_3 = texture2D(inputImageTexture, vec2(tex.x - fstep, tex.y - fstep));
    //vec4 sample_4 = texture2D(inputImageTexture, vec2(tex.x + fstep, tex.y - fstep));
    vec4 sample_tex;
    if(tex.x > 0.5 && tex.y < 0.5){
        sample_tex = texture2D(inputImageTexture, vec2(tex.x - fstep, tex.y + fstep));
    }
    else if(tex.x < 0.5 && tex.y < 0.5){
        sample_tex = texture2D(inputImageTexture, vec2(tex.x + fstep, tex.y + fstep));
    }
    else if(tex.x > 0.5 && tex.y > 0.5){
        sample_tex = texture2D(inputImageTexture, vec2(tex.x - fstep, tex.y - fstep));
    }
    else if(tex.x < 0.5 && tex.y > 0.5){
        sample_tex = texture2D(inputImageTexture, vec2(tex.x + fstep, tex.y - fstep));
    }

    gl_FragColor = sample_tex;
}
