#ifndef FILAMENTSURFACE_INCLUDED
#define FILAMENTSURFACE_INCLUDED


struct FilamentSurface 
{
	float4 BaseColor;
	
	float3 Emissive;
	
	float Metallic;
	float Roughness;
	float Reflectance;
	float AmbientOcclusion;


};
FilamentSurface CreateSurface(float4 basecolor, float4 texcol, float3 emissive,
	float metallic, float roughness, float reflectance, float ao) 
{
	FilamentSurface surface;

	surface.BaseColor = basecolor * texcol;
	surface.Emissive = emissive;
	surface.Metallic = metallic;
	surface.Roughness = roughness;
	surface.Reflectance = reflectance;
	surface.AmbientOcclusion = ao;

	return surface;

}


#endif