#ifndef DEFAULTLITGHT_INCLUDED
#define DEFAULTLITGHT_INCLUDED

struct DefaultLight 
{
	float4 LightColor;
	float3 LightPosition;
	float3 LightDirection;
};

DefaultLight CreateDefaultLight(float4 lightColor, float4 lightPosition) 
{
	DefaultLight light;
	
	light.LightColor = lightColor;
	light.LightPosition = lightPosition.xyz;
	light.LightDir = normalize(lightPosition.xyz);
	
	return light;
}


#endif