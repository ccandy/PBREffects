#ifndef FILAMENTLIGHTING_INCLUDED
#define FILAMENTLIGHTING_INCLUDED

float DGGX(FilamentSurface surface, PBRLight light, float3 viewDir) 
{
	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;
	float3 halfVector = normalize(viewDir + lightDir);

	float roughness = surface.Roughness;
	float roughness2 = Pow2(roughness);

	float NdotH = Dot(normal, halfVector);
	float NdotH2 = Pow2(NdotH);

	float a = NdotH * roughness;
	float k = roughness / (1 - NdotH2 + roughness2);

	float k2 = Pow2(k);

	float ggx = k2 * (1 / PI);

	return ggx;
}

float SmithGGX(FilamentSurface surface, PBRLight light, float3 viewDir)
{
	float roughness = surface.Roughness;
	float a2 = Pow2(roughness);

	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;
	float NdotL = Dot(normal, lightDir);
	float NdotV = Dot(normal, viewDir);

	float NdotL2 = Pow2(NdotL);
	float NdotV2 = Pow2(NdotV);

	float GGXV = NdotL * sqrt(NdotV2 * (1 - a2) + a2);
	float GGXL = NdotV * sqrt(NdotL2 * (1 - a2) + a2);

	float sggx = 0.5 / (GGXV + GGXL);

	return sggx;
}

float SmithGGXFast(FilamentSurface surface, PBRLight light, float3 viewDir) 
{
	float a = surface.Roughness;

	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;
	float NdotL = Dot(normal, lightDir);
	float NdotV = Dot(normal, viewDir);

	float GGXV = NdotL * sqrt(NdotV * (1 - a) + a);
	float GGXL = NdotV * sqrt(NdotL * (1 - a) + a);

	float sggx = 0.5 / (GGXV + GGXL);

	return sggx;
	
}

#endif