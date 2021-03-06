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
        _Cutout("Cut out", Range(0,1)) = 0.5
        _Alpha("Alpha", Range(0,1)) = 0.5
        _Beta("Beta", Range(0,1)) = 0.5
        _SpecStrength("Spec Strength", float) = 5
        _Shinness("Shinness", float) = 32
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
            #include "Assets/ShaderLibrary/NPR/ToneShading/NPRToneEffect.hlsl"
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

        Pass
        {
            Cull Front
            Tags { "LightMode" = "SRPDefaultUnlit" }
            HLSLPROGRAM
            #pragma vertex VertOutlineProgram
            #pragma fragment FragOutlineProgram
            ENDHLSL
        }
    }
}
