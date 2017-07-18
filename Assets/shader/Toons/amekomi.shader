Shader "Custom/amekomi" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_LinColor ("Lin Color", Color) = (1,1,1,1)
		_Texture ("Texture",2D)="White"{}
	}
	SubShader {
		Pass{
		Tags { "LightMode"="ForwardBase" }		
		Cull Back
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
    gl_Position    = gl_ModelViewProjectionMatrix * gl_Vertex;
	}
	  #endif
 	 #ifdef FRAGMENT
  	void main() {
	float  dotScale = 1.59;
	         
    vec2 v = gl_FragCoord.xy * dotScale;
    float f = (sin(v.x) * 0.5 + 0.5) + (sin(v.y) * 0.5 + 0.5);
   
    float s;
    if(vDiffuse > 0.6){
        s = 1.0;
    gl_FragColor = texture2D(_Texture,vec2(textureCoord)) * vec4(vColor.rgb*2.0, 1.0);
    }else if(vDiffuse > 0.1){
        s = 0.6;
    gl_FragColor = texture2D(_Texture,vec2(textureCoord)) * vec4(vColor.rgb*(vDiffuse + vec3(f))*0.6, 1.0);
    }else{
        s = 0.6;
    gl_FragColor = texture2D(_Texture,vec2(textureCoord)) * vec4(vColor.rgb *(vDiffuse + vec3(f))*-0.5, 1.0);
  	}
//    gl_FragColor = texture2D(_Texture,vec2(textureCoord)) * vec4(vColor.rgb *(vDiffuse + vec3(f))*s, 1.0);
      
    	}
	
       #endif

		ENDGLSL
	
	}
	Pass {
            Tags {"LightMode" = "ForwardBase"}
		 Cull Front
		GLSLPROGRAM
		#include "UnityCG.glslinc"
		
	 	uniform vec4 _LinColor;
		varying vec3 vNormal;
		varying vec4 vColor;
		varying vec3 lightDirection;
		
		#ifdef VERTEX
	   void main(){
	   vec3 pos=vec3(gl_Vertex);

	        pos +=gl_Normal *0.0003;
	       vNormal = gl_Normal;
	       vColor = _LinColor;
	       lightDirection = normalize(vec3(_WorldSpaceLightPos0));
	       gl_Position = gl_ModelViewProjectionMatrix * vec4(pos,1.0);	 
		}
	    #endif
	    	
     	#ifdef FRAGMENT
	    void main() {
	       gl_FragColor =_LinColor;
	      }
          #endif
		ENDGLSL
	 } 
	}
}