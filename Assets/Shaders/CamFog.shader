Shader "Custom/CamFog"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _color("Tint",Color) = (1,1,1,1)
	    _Fogcolor("Fog color",Color) =(0,0,0,0)
        _Depth("depth strength",float) = 1.0
        _Distance("depth distance",float) = -0.09
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
//  Tags { "RenderType"="Transparent" "Queue"="Transparent" }
//         LOD 200
       
//         ZWrite Off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct Input
            {
                half fog;
            };
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };
            v2f vert (appdata_base v)
            {
                v2f o;
              //  o.pos = UnityObjectToClipPos (v.vertex);
               // o.uv = ComputeScreenPos (o.pos);
               o.uv = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_DEPTH(o.uv);
                o.pos = v.vertex;
                return o;
            }
            // half4 frag2(v2f T) : SV_Target
            // {
            // UNITY_OUTPUT_DEPTH(T.uv);
            // }

// void Fogcolor(Input IN,SurfaceOutput o, inout fixed4 color)
// 		{
// 		fixed3 fogcolor = _Fogcolor.rgb;
// 		#ifdef UNITY_PASS_FORWARDADD
// 		fogcolor = 0;
// 		#endif
// 		color.rgb = lerp(color.rgb,fogcolor,IN.fog);
// 		}
            sampler2D _MainTex;
            sampler2D _CameraDepthTexture; 
            half _Depth;
            half _Distance;
            fixed4 _color;
            fixed4 _Fogcolor;

            fixed4 frag(v2f i) : SV_Target
            {
                // float2 uv = i.uv.xy / i.uv.y;
                // half lin = LinearEyeDepth(tex2D(_CameraDepthTexture,uv).r);
                // half dist = i.uv.y - _Distance;
                // half depth = lin - dist;
                // return lerp (half4(1,1,1,0),_color,saturate(depth * _Depth));
				float2 direction = float2(cos(_Distance * UNITY_PI * 2), sin(_Distance * UNITY_PI * 2));
				 float l = _Depth + sin(_Distance+_Time.y) * cos(_Distance+_Time.y);
               fixed4 col = tex2D(_MainTex, + direction* _Time.x * _Distance )* _color;
			   col = lerp(_color, _Fogcolor, smoothstep(l-_Distance*.5, l+_Distance*.5, _Distance));
             //  float camdepth =tex2D(_CameraDepthTexture,col);
              //  fixed4 coldepth = tex2D(_MainTex,camdepth)
              //  float4 _CameraDepthTexture = float4(i.uv,i.vertex)
             ////   just invert the colors
             //  col.r = coldepth.r * camdepth  ;
             //  col.g = coldepth.g *camdepth   ;
             //  col.b = coldepth.b *camdepth  ;
             //  col.rgb = 1*coldepth.rgb;		 
               return col;
            }
            ENDCG
        }
    }
     FallBack "Diffuse"
}
