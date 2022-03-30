#ifndef PBRSURFACE_INCLUDED
#define PBRSURFACE_INCLUDED

struct PBRSurface 
{
	float4 BaseColor;
	float3 Normal;
	float3 BaseF0;

	float Roughness;
	float Metallic;
};

PBRSurface CreateSurface(float4 baseColor, float4 texCol, float3 normal, float roughness, float metallic) 
{
	PBRSurface surface;

	surface.BaseColor = baseColor * texCol;
	surface.Normal = normal;

	surface.Roughness = roughness;
	surface.Metallic = metallic;

	float3 baseF0 = float3(0.04, 0.04, 0.04);
	float3 col = surface.BaseColor.rgb;
	surface.BaseF0 = lerp(baseF0, col, metallic);

	return surface;
}



#endif