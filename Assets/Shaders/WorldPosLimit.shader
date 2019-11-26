Shader "Custom/WorldPosLimit"
{
    Properties
    {
        _Color("Color",color) = (1,1,1,1)
        _ThreshColor ("ThreshColor", Color) = (1,1,1,1)
        _level ("level",float) = 1.5
        _Blur ("Blur", Range(0, 10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        Fog {Mode Off}
        Tags {"Lightmode" = "Always"}
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            float3 Colors;
            float3 worldPos;
        };

        float4 _Color;
        float4 _ThreshColor;
        float _level;
        float _Blur;
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
          //  + cos(IN.worldPos.z*2)
            float l = _level + sin(IN.worldPos.x+_Time.y) * cos(IN.worldPos.z+_Time.y);
            o.Albedo = lerp(_ThreshColor, _Color, smoothstep(l-_Blur*.5, l+_Blur*.5, IN.worldPos.y));
        
            // Albedo comes from a texture tinted by color

        o.Albedo *= saturate(_Color + IN.worldPos.y);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
