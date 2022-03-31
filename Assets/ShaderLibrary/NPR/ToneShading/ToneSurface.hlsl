#ifndef TONESURFACE_INCLUDED
#define TONESURFACE_INCLUDED

struct ToneSurface 
{
	float4 BaseColor;
	float4 TexColor;
	float3 Normal;

	float BlueColor;
	float YellowColor;

	float Alpha;
	float Beta;

	float SpecStrength;
	float Shinness;
};

ToneSurface CreateSurface(float4 basecolor, float4 texcolor, float3 normal, 
	float bluecolor, float yellowcolor, float alpha, float beta,
	float specstrength, float shinness) 
{
	ToneSurface surface;

	surface.BaseColor = basecolor;
	surface.TexColor = texcolor;
	surface.Normal = normal;
	surface.BlueColor = bluecolor;
	surface.YellowColor = yellowcolor;
	surface.Alpha = alpha;
	surface.Beta = beta;
	surface.SpecStrength = specstrength;
	surface.Shinness = shinness;
	return surface;
}

#endif