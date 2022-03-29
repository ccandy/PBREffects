#ifndef DEFAULTLIGHTING_INCLUDED
#define DEFAULTLIGHTING_INCLUDED

float CalcuateDiffuse(DefaultSurface surface, DefaultLight light) 
{
	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;

	return DotMax(normal, lightDir, 0.0001);
}

float3 CalcuateDiffuseColor(DefaultSurface surface, DefaultLight light) 
{
	float diffuse = CalcuateDiffuse(surface, light);
	return diffuse * light.LightColor;
}

float CaculatePhong(DefaultSurface surface, DefaultLight light, float3 viewDir) 
{
	float3 normalDir = surface.Normal;
	float3 lightDir = light.LightDirection;

	float3 refDir = reflect(-lightDir, normalDir);
	float phong = Dot(refDir, viewDir);
	return phong;
}

float3 CalcuateSepc(DefaultSurface surface, DefaultLight light, float3 viewDir)
{
	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;

	float phong = CaculatePhong(surface, light, viewDir);
	float shinness = surface.Shinness;

	float pShinness = pow(phong, shinness);
	float specStrength = surface.SpecStrength;
	float3 specColor = light.LightColor * pShinness * surface.SpecStrength;

	return specColor;
}



#endif