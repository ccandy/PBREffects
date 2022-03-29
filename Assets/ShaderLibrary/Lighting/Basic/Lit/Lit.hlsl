#ifndef LIT_INCLUDED
#define LIT_INCLUDED

#include "DefaultSurface.hlsl"
#include "DefaultLight.hlsl"
#include "DefaultLighting.hlsl"
#include "Assets/ShaderLibrary/Util/RPPacking.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _Color;
float _Shinness;
float _SpecStrength;
float _NormalScale;
CBUFFER_END

float _UseNormalMap;

TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

TEXTURE2D(_NormalMap);


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
	float4 map = SAMPLE_TEXTURE2D(_NormalMap, sampler_MainTex, input.uv);
	float3 normal = input.normal;

	DefaultSurface surface = CreateRegularSurface(_Color, texCol, normal, _Shinness, _SpecStrength, _NormalScale);
	DefaultLight light = CreateDefaultLight(_MainLightColor.rgb, _MainLightPosition);
	//normal = GetNormalTS(input.uv);
//#if defined(_NORMAL_MAP)
//	surface.Normal = DecodeNormal(map, surface.NormalScale);
//#endif

	if (_UseNormalMap == 1) 
	{
		surface.Normal = DecodeNormal(map, surface.NormalScale);
	}

	float3 diffuseColor = CalcuateDiffuseColor(surface, light);

	float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - input.posWS);
	float3 spec = CalcuateSepc(surface, light, viewDir);

	float4 finalCol = float4(diffuseColor + spec,1) *surface.BaseColor;
	return finalCol * PI;
}

#endif