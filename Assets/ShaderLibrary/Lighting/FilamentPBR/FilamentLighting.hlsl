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

#endif