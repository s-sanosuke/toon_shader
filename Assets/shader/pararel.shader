Shader "Custom/pararel" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Pass{

//		Tags { "LightMode"="PrepassFinal" }		
		 		Tags { "LightMode"="ForwardBase" }		
		
		GLSLPROGRAM
//		#include "UnityCG.cginc"
		#include "UnityCG.glslinc"
		
//	uniform  vec3 position;
//	uniform  vec3 normal;
	uniform  vec4 _Color;
//	uniform   mat4 mvpMatrix;
//	uniform   mat4 invMatrix;
// 	uniform	  vec3 invLight;
//	uniform   vec3 lightDirection;
	varying   vec4 color;
	
      #ifdef VERTEX
	void main(void){
	
	vec3 lightDirection = normalize(vec3(_WorldSpaceLightPos0));
//	vec3 lightDirection = normalize(vec3(_Light2World));

//    vec3  invLight = normalize(_World2Object * _Object2Light).xyz;
    vec3  invLight = normalize(_World2Object * vec4(lightDirection, 0.0)).xyz;
    vec3 surfaceNormal = normalize(vec3(_Object2World * vec4(gl_Normal,0.0)));
    float diffu  = clamp(dot(surfaceNormal, lightDirection), 0.1, 1.0);
//   	 float diffu  =dot(gl_Normal,invLight); 
     color         = _Color * vec4(vec3(diffu), 1.0);		
        gl_Position    = gl_ModelViewProjectionMatrix * gl_Vertex;
	}
	  #endif
	  
	        #ifdef FRAGMENT
	         void main() {
	           gl_FragColor = color;
	        }
	          #endif

		ENDGLSL
	
		}
	}
}