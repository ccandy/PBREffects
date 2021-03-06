Shader "URPEffect/Unlit/Diffuse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", color) = (1,1,1,1)
    }
    SubShader
    {
        Tags 
        { 
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        LOD 100
        HLSLINCLUDE
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Assets\ShaderLibrary/Lighting/Basic/Unlit/Unlit.hlsl"
        ENDHLSL
        Pass
        {
            Tags 
            { 
                "LightMode" = "UniversalForward" 
            }
            HLSLPROGRAM
            #pragma vertex VertProgram
            #pragma fragment FragProgram
            #pragma multi_compile_instancing
            ENDHLSL
        }
    }
}
