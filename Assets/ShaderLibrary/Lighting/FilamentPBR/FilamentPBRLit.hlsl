#ifndef FILAMENTPBRLIT_INCLUDED
#define FILAMENTPBRLIT_INCLUDED

#include "Assets/ShaderLibrary/Util/MathFunction.hlsl"
#include "Assets\ShaderLibrary\Lighting\FilamentPBR\FilamentSurface.hlsl"
#include "Assets/ShaderLibrary/Lighting/PBRLit/PBRLight.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _Color;
float4 _Emissive;
float _Metallic;
float _Roughness;
float _Reflectance;
float _AmbientOcclusion;
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
	float3 posWS:TEXCOORD2;
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
	output.posWS = posWS.xyz;

	return output;
}

float4 FragProgram(VertexOutput input) : SV_Target
{
	float4 texCol = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
	float3 normal = input.normal;
	
	FilamentSurface surface = CreateSurface(_Color, texCol, normal, _Emissive.rgb,
		_Metallic, _Roughness, _Reflectance, _AmbientOcclusion);
	PBRLight light = CreatePBRLight(_MainLightColor, _MainLightPosition);

	float4 finalCol = surface.BaseColor;

	return finalCol;
}


#endif