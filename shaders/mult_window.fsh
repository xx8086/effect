

precision mediump float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform float ratio;

void main(void)
{
    vec4 sample_offset;
    vec4 sample_tex;
    vec2 tex = textureCoordinate;
    if (tex.x < 0.5) {
        tex.x = tex.x + ratio;
    }
    else{
        tex.x = tex.x - ratio;
    }
    if (tex.y < 0.5) {
        tex.y = tex.y + ratio;
    }
    else{
        tex.y = tex.y - ratio;
    }
    
    sample_offset = texture2D(inputImageTexture, tex);
    gl_FragColor = sample_offset;
}
