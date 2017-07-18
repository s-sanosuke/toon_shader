Shader "Custom/NewSurfaceShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
	Pass{
	GLSLPROGRAM
	#include "UnityCG.glslinc"
	
	#ifdef VERTEX
	void main(){
	gl_Position= gl_ModelViewProjectionMatrix * gl_Vertex;
	}
	#endif
	
	
	#ifdef FRAGMENT
	void main(){
	gl_FragColor = vec4(0.0,1.0,11,110);
	}
	#endif
	ENDGLSL
	}
	
	}
//	Fallback "Diffus sbe"
}
