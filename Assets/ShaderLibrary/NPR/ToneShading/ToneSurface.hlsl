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
};

ToneSurface CreateSurface(float4 basecolor, float4 texcolor, float3 normal, float bluecolor, float yellowcolor, float alpha, float beta) 
{
	ToneSurface surface;

	surface.BaseColor = basecolor;
	surface.TexColor = texcolor;
	surface.Normal = normal;
	surface.BlueColor = bluecolor;
	surface.YellowColor = yellowcolor;
	surface.Alpha = alpha;
	surface.Beta = beta;

	return surface;
}

#endif