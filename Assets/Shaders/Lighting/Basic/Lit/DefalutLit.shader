Shader "Unlit/DefalutLit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", color) = (1,1,1,1)
        _Shinness("Shiness", float) = 32
        _SpecStrength("Spec Strength", float) = 5
    }
    SubShader
    {
        Tags 
        { 
            "RenderType" = "Opaque"
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        LOD 100

        Pass
        {
            HLSLINCLUDE
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include "Assets/ShaderLibrary/Util/MathFunction.hlsl"
                #include "Assets/ShaderLibrary/Lighting/Basic/Lit/Lit.hlsl"
            ENDHLSL
        }
    }
}
