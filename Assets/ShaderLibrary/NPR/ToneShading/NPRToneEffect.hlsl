#ifndef NPRTONEEFFECT_INCLUDED
#define NPRTONEEFFECT_INCLUDED

#include "Assets/ShaderLibrary/Util/MathFunction.hlsl"
#include "Assets/ShaderLibrary/NPR/ToneShading/ToneSurface.hlsl"
#include "Assets/ShaderLibrary/Lighting/PBRLit/PBRLight.hlsl"
#include "Assets/ShaderLibrary/NPR/Outline/OutlineEffect.hlsl"
#include "Assets/ShaderLibrary/NPR/ToneShading/ToneShading.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _Color;
float4 _OutlineColor;
float _OutlineWidth;
float _BlueColor;
float _YellowColor;
float _Alpha;
float _Beta;
CBUFFER_END

float _Cutout;

TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

struct VertexInput
{
	float4 posOS : POSITION;

	float2 uv : TEXCOORD0;
	float3 normal:NORMAL;

	UNITY_VERTEX_INPUT_INSTANCE_ID

};

struct VertexOutput
{
	float2 uv : TEXCOORD0;
	float4 posCS : SV_POSITION;
	float3 normal:TEXCOORD1;
	float4 posWS:TEXCOORD2;
};


VertexOutput VertProgram(VertexInput input)
{
	VertexOutput output;

	output.posCS = TransformObjectToHClip(input.posOS.xyz);
	output.uv = TRANSFORM_TEX(input.uv, _MainTex);

	float3 normal = TransformObjectToWorldNormal(input.normal);
	normal = normalize(normal);
	output.normal = normal;

	float4x4 objectToWorld = GetObjectToWorldMatrix();
	float4 posWS = mul(objectToWorld, input.posOS);
	output.posWS = posWS;

	return output;
}

float4 FragProgram(VertexOutput input) : SV_Target
{
	return 1;
}

//outline
VertexOutput VertOutlineProgram(VertexInput input)
{
	VertexOutput output;

	output.posCS = TransformObjectToHClip(input.posOS.xyz);
	output.uv = TRANSFORM_TEX(input.uv, _MainTex);

	float3 normal = TransformObjectToWorldNormal(input.normal);
	normal = normalize(normal);
	output.normal = normal;

	float2 extendDis = GetVertexExtend(normal, _OutlineWidth, output.posCS.w);
	output.posCS.xy += extendDis;

	return output;
}

float4 FragOutlineProgram(VertexOutput input) : SV_Target
{
	float4 texCol = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
	clip(texCol.a - _Cutout);
	return _OutlineColor;
}

#endif