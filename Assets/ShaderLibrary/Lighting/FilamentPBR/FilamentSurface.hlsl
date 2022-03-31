#ifndef FILAMENTSURFACE_INCLUDED
#define FILAMENTSURFACE_INCLUDED


struct FilamentSurface 
{
	float4 BaseColor;

	float3 DiffuseColor;
	float3 Normal;
	float3 Emissive;
	
	float Metallic;
	float Roughness;
	float Reflectance;
	float AmbientOcclusion;


};
FilamentSurface CreateSurface(float4 basecolor, float4 texcol, float3 normal, float3 emissive,
	float metallic, float roughness, float reflectance, float ao) 
{
	FilamentSurface surface;

	float4 baseColor = basecolor * texcol;

	surface.BaseColor = baseColor
	surface.DiffuseColor = (1.0 - metallic) * baseColor.rgb;

	surface.Normal = normal;
	surface.Emissive = emissive;
	surface.Metallic = metallic;
	surface.Roughness = roughness;
	surface.Reflectance = reflectance;
	surface.AmbientOcclusion = ao;

	return surface;

}


#endif