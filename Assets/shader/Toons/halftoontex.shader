Shader "Custom/halftoontex" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Texture ("Texture",2D)="White"{}
	}
	SubShader {
		Pass{
		Tags { "LightMode"="ForwardBase" }		
		
		GLSLPROGRAM
		#include "UnityCG.glslinc"
		
	uniform  vec4 _Color;
	uniform  vec4 _MainTex;
	uniform  sampler2D _Texture;
	varying  vec4 textureCoord;
	varying   vec4 vColor;
	varying   float vDiffuse;   
      
        #ifdef VERTEX
	void main(void){
	
	vec3 lightDirection = normalize(vec3(_WorldSpaceLightPos0));    
//    vec3  invLight = normalize(_World2Object * _Object2Light).xyz;
    vec3  invLight = normalize(_World2Object * vec4(lightDirection, 0.0)).xyz;
    vDiffuse = clamp(dot(gl_Normal, invLight), 0.0, 1.0);
    vColor = _Color;
    textureCoord = gl_MultiTexCoord0;
//    gl_Position = mvpMatrix * vec4(position, 1.0);
//    vec3 surfaceNormal = normalize(vec3(_Object2World * vec4(gl_Normal,0.0)));
//    float diffu  = clamp(dot(surfaceNormal, lightDirection), 0.1, 1.0);
//    vColor         = _Color * vec4(vec3(diffu), 1.0);
    gl_Position    = gl_ModelViewProjectionMatrix * gl_Vertex;
	}
	  #endif
	  
//	precision mediump float;
//	
//	varying float vDiffuse;
//	varying vec4  vColor;
	        #ifdef FRAGMENT
  	void main() {
	float  dotScale = 1.5;
	         
    vec2 v = gl_FragCoord.xy * dotScale;
    float f = (sin(v.x) * 0.5 + 0.5) + (sin(v.y) * 0.5 + 0.5);
   
    float s;
    if(vDiffuse > 0.6){
        s = 1.0;
    }else if(vDiffuse > 0.2){
        s = 0.6;
    }else{
        s = 0.4;
    }
    
//    gl_FragColor = vec4(texture2D(_Texture,vec2(textureCoord) * (vDiffuse + vec3(f)) * s, 1.0);

    gl_FragColor = texture2D(_Texture,vec2(textureCoord)) * vec4(vColor.rgb *(vDiffuse + vec3(f)) * s, 1.0);

		}
	
       #endif

		ENDGLSL
	
	}
	}
}