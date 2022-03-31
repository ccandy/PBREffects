Shader "URPEffect/FilamentPBRLit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", color) = (1,1,1,1)
        _Emissive("Emissive", color) = (1,1,1,1)
        _Metallic("Metallic", Range(0,1)) = 0
        _PerceptualRoughness("Roughness", Range(0, 1)) = 0
        _Reflectance("Reflectance", Range(0, 1)) = 0
        _AmbientOcclusion("Ambient Occlusion", Range(0,1)) = 0
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
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
             #include "Assets/ShaderLibrary/Lighting/FilamentPBR/FilamentPBRLit.hlsl"
        ENDHLSL
        Pass
        {
            Tags { "LightMode" = "UniversalForward" }
            HLSLPROGRAM
            #pragma vertex VertProgram
            #pragma fragment FragProgram
            ENDHLSL
        }
    }
}
