Shader "URPEffect/Unlit/Cutout"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", color) = (1,1,1,1)
        _Cutoff("Cutoff", Float) = 0.5
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "TransparentCutout"
            "Queue" = "AlphaTest"
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        HLSLINCLUDE
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Assets\ShaderLibrary/Lighting/Basic/Unlit/UnlitCutout.hlsl"
        ENDHLSL
        LOD 100

        Pass
        {
            Tags
            {
                "LightMode" = "UniversalForward"
            }
            HLSLPROGRAM
            #pragma vertex VertProgram
            #pragma fragment FragProgram
            ENDHLSL
        }
    }
}
