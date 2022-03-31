#ifndef FILAMENTSURFACE_INCLUDED
#define FILAMENTSURFACE_INCLUDED


struct FilamentSurface 
{
	float4 BaseColor;

	float3 DiffuseColor;
	float3 Normal;
	float3 Emissive;
	float3 BaseF0;

	float Metallic;
	float PerceptualRoughness;
	float Roughness;
	float Reflectance;
	float AmbientOcclusion;


};
FilamentSurface CreateSurface(float4 basecolor, float4 texcol, float3 normal, float3 emissive,
	float metallic, float perceptualroughness, float reflectance, float ao)
{
	FilamentSurface surface;

	float4 baseColor = basecolor * texcol;

	surface.BaseColor = baseColor;
	surface.DiffuseColor = (1.0 - metallic) * basecolor.rgb;

	surface.Normal = normal;
	surface.Emissive = emissive;
	surface.Metallic = metallic;
	surface.PerceptualRoughness = perceptualroughness;
	surface.Roughness = Pow2(perceptualroughness);
	surface.Reflectance = reflectance;

	float ref = reflectance;
	float3 f0 = 0.16 * ref * (1 - metallic) + baseColor.rgb * metallic;
	surface.BaseF0 = f0;
	
	surface.AmbientOcclusion = ao;

	return surface;

}


#endif