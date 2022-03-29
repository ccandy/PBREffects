#ifndef LIT_INCLUDED
#define LIT_INCLUDED

#include "DefaultSurface.hlsl"
#include "DefaultLight.hlsl"
#include "Lighting.hlsl"

CBUFFER_START(UnityPerMaterial)
	float4 _MainTex_ST;
	float4 _Color;
	float _Shinness;
	float _SpecStrength;
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
	float3 normal = input.normal;

	DefaultSurface surface = CreateRegularSurface(_Color, texCol, normal, _Shinness, _SpecStrength);
	DefaultLight light = CreateDefaultLight(_MainLightColor.rgb, _MainLightPosition);

	float3 diffuseColor = CalcuateDiffuseColor(surface, light);

	float4 finalCol = float4(diffuseColor,1) *surface.BaseColor;
	return finalCol;
}

#endif