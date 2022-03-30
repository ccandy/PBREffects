#ifndef PBRLIGHT_INCLUDED
#define PBRLIGHT_INCLUDED

struct PBRLight 
{
	float3 LightColor;
	float3 LightPosition;
	float3 LightDirection;
};

PBRLight CreatePBRLight(float4 lightcolor, float4 lightpos) 
{
	PBRLight light;

	light.LightColor = lightcolor.rgb;
	light.LightPosition = lightpos.xyz;
	light.LightDirection = normalize(lightpos.xyz);

	return light;
}

#endif