Shader "Custom/Fog"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _FogColor("FogColor",Color) = (1,1,1,1)
        _Tex("Texture", 2D) = "Bump"{}
        _NormalMap("Normal",2D) = "Bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
       
        #pragma surface Maincolor Lambert finalcolor:Fogcolor vertex:Vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _Tex;
        sampler2D _NormalMap;

        struct Input
        {
            float2 uv_Tex;
             float2 _NormalMap;
             half fog;
        };

        fixed4 _Color;
        fixed4 _FogColor;

void Vert(inout appdata_full v, out Input data)
		{
		UNITY_INITIALIZE_OUTPUT(Input,data);
		float4 hpos = UnityObjectToClipPos(v.vertex);
		hpos.xy /= hpos.w;
		data.fog = min(1, dot(hpos.xy,hpos.xy)*0.5);

		}

		void Fogcolor(Input IN,SurfaceOutput o, inout fixed4 color)
		{
		fixed3 fogcolor = _FogColor.rgb;
		#ifdef UNITY_PASS_FORWARDADD
		fogcolor = 0;
		#endif
		color.rgb = lerp(color.rgb,fogcolor,IN.fog);
		}

		void Maincolor(Input IN, inout SurfaceOutput o)
		{
		// albedo is a reference to the surface image and rgb of our model
		// we are setting the models surface to the color of our texture2d and matching the texture to our models UV mapping
		o.Albedo = tex2D(_Tex, IN.uv_Tex).rgb * _Color;

		//_NormalMap is in reference to the bump map in Properties
		// UnpackNormal is required because the file is currently compressed, we need to decompress to get the true value from the image
		// bump maps are visible when light reflects off
		// the light is bounced off at angles according to the image RGB or XYZ Value
		// this makes the image look like it has depth
		o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));

		
		}

        // // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // // #pragma instancing_options assumeuniformscaling
        // UNITY_INSTANCING_BUFFER_START(Props)
        //     // put more per-instance properties here
        // UNITY_INSTANCING_BUFFER_END(Props)

        // void surf (Input IN, inout SurfaceOutputStandard o)
        // {
        //     // Albedo comes from a texture tinted by color
        //     fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
        //     o.Albedo = c.rgb;
        //     // Metallic and smoothness come from slider variables
        //     o.Metallic = _Metallic;
        //     o.Smoothness = _Glossiness;
        //     o.Alpha = c.a;
        // }
        ENDCG
    }
    FallBack "Diffuse"
}
