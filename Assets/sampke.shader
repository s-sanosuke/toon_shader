Shader "VertexInputSimple" {
	Properties {
		_Color ("Color", Color) = (0,1,0,1)
	}
    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
         
            struct v2f {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };

            fixed4 _Color;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = _Color*0.5;
                //v.normal * 0.5 + 0.5;
                //o.color.a = 0.1;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target { 
            	return i.color; 

            }
            ENDCG
        }
    } 
}