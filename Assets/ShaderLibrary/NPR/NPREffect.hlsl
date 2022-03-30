#ifndef NPREFFECT_INCLUDED
#define NPREFFECT_INCLUDED

#include "Assets/ShaderLibrary/NPR/Outline.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _Color;
float4 _OutlineColor;
float _OutlineWidth;

CBUFFER_END

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
};

VertexOutput VertProgram(VertexInput input)
{
	VertexOutput output;

	output.posCS = TransformObjectToHClip(input.posOS.xyz);
	output.uv = TRANSFORM_TEX(input.uv, _MainTex);

	float3 normal = TransformObjectToWorldNormal(input.normal);
	normal = normalize(normal);
	output.normal = normal;

	return output;
}

float4 FragProgram(VertexOutput input) : SV_Target
{
	float4 texCol = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
	float4 finalCol = texCol * _Color;

	return finalCol;
}

VertexOutput VertOutlineProgram(VertexInput input)
{
	VertexOutput output;

	output.posCS = TransformObjectToHClip(input.posOS.xyz);
	output.uv = TRANSFORM_TEX(input.uv, _MainTex);

	float3 normal = TransformObjectToWorldNormal(input.normal);
	normal = normalize(normal);
	output.normal = normal;

	float2 extendDis = GetVertexExtend(normal, _OutlineWidth);
	output.posCS.xy += extendDis;// *output.posCS.w;

	return output;
}

float4 FragOutlineProgram(VertexOutput input) : SV_Target
{
	return _OutlineColor;
}

#endif