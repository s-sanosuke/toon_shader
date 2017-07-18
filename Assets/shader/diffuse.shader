// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/diffuse" {
	Properties {
		_Color ("Color", Color) = (0,1,0,1)
	}
	SubShader {
		Pass {
			Tags { "LightMode" = "ForwardBase" }
			
			CGPROGRAM

			#pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            //#include "UnityShaderVariables.cginc"
            //#include "AutoLight.cginc"  
            //#include "Lighting.cginc"
         
	        struct appdata {
       	    	float4 vertex : POSITION;
        	    float4 texcoord1 : TEXCOORD1;
        	    float3 normal : NORMAL;
            };

        	struct v2f {
           		float4 pos : SV_POSITION;
            	float4 uv : TEXCOORD0;
            	float4 color : COLOR;
        	};
        	fixed4 _LightColor0;
	       	fixed4 _Color;

        	v2f vert (appdata v) {
            	v2f o;
            	o.pos = UnityObjectToClipPos(v.vertex);
            	float4 sfn1= float4(v.normal,0.0);
            	float4 sfn2= mul(unity_ObjectToWorld,sfn1); //行列の計算にはmulを使う。
            	float3 SFN = normalize(float3(sfn2.xyz));
            	float3 light = float3(_WorldSpaceLightPos0.xyz);
            	float3 LDN= normalize(light);
            	float3 DFR= float3(_LightColor0.xyz)*float3(_Color.xyz)*max(0.0,dot(SFN,LDN));
            	o.color = float4(DFR,1.0);
            	//o.uv = float4( v.texcoord1.xy, 0, 0 );
            	return o;
        	}

        	fixed4 frag (v2f i) : SV_Target { 
            	return i.color; 

            }
	        ENDCG
         }
	} 
//	FallBack "Diffuse"
}
