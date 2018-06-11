precision mediump float;
varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform int colour;
void main(){
    vec3 colors[7];
    colors[0] = vec3(0.733, 1.0, 1.0);
    colors[1] = vec3(1.0, 0.85, 0.725);
    colors[2] = vec3(0.0, 0.803, 0.803);
    colors[3] = vec3(0.498, 1.0, 0.831);
    colors[4] = vec3(0.117, 0.564, 1.0);
    colors[5] = vec3(1.0, 0.25, 0.25);
    colors[6] = vec3(1.0, 0.27, 0.0);

    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    vec3 color = mix(textureColor.rgb, colors[colour], 0.4);
    gl_FragColor = vec4(color, textureColor.w);
}
