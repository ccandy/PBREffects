#ifndef	NPREFFEC_INCLUDED
#define NPREFFECT_INCLUDED

CBUFFER_START(UnityPerMaterial)
float4 _MainTex_ST;
float4 _Color;
CBUFFER_END

struct VertexInput 
{
	float4 posOS : POSITION;
	float2 uv : TEXCOORD0;
	float3 normal:NORMAL;
};

struct VertexOutput 
{
	float2 uv : TEXCOORD0;
	float4 posCS : SV_POSITION;
	float3 normal:TEXCOORD1;
	//float3 posWS:TEXCOORD2;
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
	return 1;
}

#endif