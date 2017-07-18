Shader "Custom/ToonTex" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_LinColor ("Lin Color", Color) = (1,1,1,1)
		_Texture ("Texture",2D)="White"{}
		_MainTex ("Main",2D)="White"{}
	}
	SubShader {
			
		Pass{
		Tags { "LightMode"="ForwardBase" }	
		Cull Back
		GLSLPROGRAM
		#include "UnityCG.glslinc"

		uniform mat4 mvpMatrix;
		varying vec3 vNormal;
		varying vec4 vColor;
		varying vec3 lightDirection;
		uniform  vec4 _Color;
		uniform sampler2D _Texture;
		uniform sampler2D _MainTex;
		varying  vec4 textureCoord;
		
		 #ifdef VERTEX
		 void main(){
	       vec3 pos = vec3(gl_Vertex);
//	       vNormal = gl_Normal;
	       vNormal = normalize(vec3(_Object2World * vec4(gl_Normal,0.0)));
	       vColor = _Color;
	       textureCoord = gl_MultiTexCoord1;
	       lightDirection = normalize(vec3(_WorldSpaceLightPos0));
	       gl_Position = gl_ModelViewProjectionMatrix * vec4(pos,1.0);	 
		 }
		 #endif
		 
		  #ifdef FRAGMENT
	     void main() {
	       	vec3 invLight= normalize(_World2Object*vec4(lightDirection,0.0)).xyz;
//	       	float diffuse = clamp(dot(vNormal,invLight),0.0,1.0);
	       	float diffuse = clamp(dot(vNormal,lightDirection),0.1,1.0);
	       	vec4 smpColor =texture2D(_Texture,vec2(diffuse,0.1));
	       	gl_FragColor = texture2D(_MainTex,vec2(textureCoord))*vColor*smpColor;
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
