Shader "URPEffect/CelShadingShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        _OutlineColor("Outline Color", Color) = (1,1,1,1)
        _ShadowColor("Shadow Color", Color) = (1,1,1,1)
        _RimColor("Rim Color", Color) = (1,1,1,1)
        _ShadowSmooth("Shadow Smooth", float) = 0.2
        _OutlineWidth("Outline Width", float) = 1
        _Threshold("Threshold", float) = 0.5
        _SpecStrength("Spec Strength", float) = 5
        _Shinness("Shinness", float) = 32
        _Cutout("Cut out", Range(0,1)) = 0.5
        
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="Opaque" 
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        LOD 100
        HLSLINCLUDE
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Assets/ShaderLibrary/NPR/NPREffect.hlsl"
            //Assets\ShaderLibrary\NPR
        ENDHLSL
        //Front pass
        Pass
        {
            Cull Back
            Tags { "LightMode" = "UniversalForward" }
            HLSLPROGRAM
            #pragma vertex VertProgram
            #pragma fragment FragProgram
            ENDHLSL
        }
        //BackPass
        
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
