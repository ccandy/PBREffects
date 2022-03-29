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


#endif