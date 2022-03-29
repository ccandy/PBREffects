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
CBUFFER_END

TEXTURE2D(_MainTex);
SAMPLER(sampler_MainTex);

TEXTURE2D(_NormalMap);

float3 DecodeNormal(float4 sample, float scale) {
#if defined(UNITY_NO_DXT5nm)
	return UnpackNormalRGB(sample, scale);
#else
	return UnpackNormalmapRGorAG(sample, scale);
#endif
}

float3 GetNormalTS(float2 baseUV) {
	float4 map = SAMPLE_TEXTURE2D(_NormalMap, sampler_MainTex, baseUV);
	//float scale = INPUT_PROP(_NormalScale);
	float3 normal = DecodeNormal(map, 3);
	return normal;
}



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
	//normal = GetNormalTS(input.uv);
	normal = GetNormalTS(input.uv);

	DefaultSurface surface = CreateRegularSurface(_Color, texCol, normal, _Shinness, _SpecStrength);
	DefaultLight light = CreateDefaultLight(_MainLightColor.rgb, _MainLightPosition);

	float3 diffuseColor = CalcuateDiffuseColor(surface, light);

	float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - input.posWS);
	float3 spec = CalcuateSepc(surface, light, viewDir);

	float4 finalCol = float4(diffuseColor + spec,1) *surface.BaseColor;
	return finalCol * PI;
}

#endif