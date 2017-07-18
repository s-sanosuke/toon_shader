﻿Shader "Custom/fon" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_SpecularColor("Specular Color",Color)=(1,1,1,1)
		_SpecularExponent("Specular Exponent",Float)=3
	}
	SubShader {
	Pass{
		Tags { "LightMode"="ForwardBase" }		
		GLSLPROGRAM
#include "UnityCG.glslinc"
uniform vec4 _LightColor0;


		
	        uniform vec4 _Color;
	        uniform vec4 _SpecularColor;
	        uniform float _SpecularExponent;
	        
	        varying vec4 color;

	        #ifdef VERTEX
	        void main() {	            
	            vec3 ambientLight = gl_LightModel.ambient.xyz * vec3(_Color);

	            vec3 surfaceNormal = normalize((_Object2World * vec4(gl_Normal, 0.0)).xyz);
	            vec3 lightDirectionNormal = normalize(_WorldSpaceLightPos0.xyz);
	            vec3 diffuseReflection = _LightColor0.xyz * _Color.xyz * max(0.0, dot(surfaceNormal, lightDirectionNormal));

                vec3 viewDirectionNormal = normalize((vec4(_WorldSpaceCameraPos, 1.0) - _Object2World * gl_Vertex).xyz);
				vec3 specularReflection = _LightColor0.xyz * _SpecularColor.xyz
					* pow(max(0.0, dot(reflect(-lightDirectionNormal, surfaceNormal), viewDirectionNormal)), _SpecularExponent);              

	            color = vec4(ambientLight + diffuseReflection + specularReflection, 1.0);
	            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
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
	//FallBack "Diffuse"
}
