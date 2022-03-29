#ifndef DEFAULTLITGHT_INCLUDED
#define DEFAULTLITGHT_INCLUDED

struct DefaultLight 
{
	float3 LightColor;
	float3 LightPosition;
	float3 LightDirection;
};

DefaultLight CreateDefaultLight(float3 lightColor, float4 lightPosition) 
{
	DefaultLight light;
	
	light.LightColor = lightColor;
	light.LightPosition = lightPosition.xyz;
	light.LightDirection = normalize(lightPosition.xyz);
	
	return light;
}


#endif