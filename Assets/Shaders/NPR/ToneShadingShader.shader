Shader "URPEffect/ToneShadingShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        _OutlineColor("Outline Color", Color) = (1,1,1,1)
        _OutlineWidth("Outline Width", float) = 1
        _BlueColor("Blue Color", Range(0,1)) = 0.5
        _YellowColor("Yellow Color", Range(0,1)) = 0.5

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
            #include "Assets/ShaderLibrary/NPR/NPREffect.hlsl"
            //Assets\ShaderLibrary\NPR
        ENDHLSL

        Pass
        {
            Cull Back
            Tags { "LightMode" = "UniversalForward" }
            HLSLPROGRAM
            #pragma vertex VertProgram
            #pragma fragment FragProgram
            ENDHLSL
        }
    }
}
