#ifndef CELSHADING_INCLUDED
#define CELSHADING_INCLUDED

float3 CalcuateCelDiffuse(CelSurface surface, PBRLight light)
{

	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;
	float3 baseColor = surface.BaseColor.rgb;
	float3 shadowColor = surface.ShadowColor.rgb;

	float halfLambert = dot(normal, lightDir) * 0.5 + 0.5;
	float threshold = surface.Threshold;
	float shadowSmooth = surface.ShadowSmooth;

	float ramp = smoothstep(0, shadowSmooth, halfLambert - threshold);
	float3 diffuse = lerp(shadowColor, baseColor, ramp);
	
	float3 diffuseColor = diffuse * light.LightColor;

	return diffuseColor;

}

#endif