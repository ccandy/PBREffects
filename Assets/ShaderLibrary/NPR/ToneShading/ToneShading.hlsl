#ifndef TONGSHADING_INCLUDED
#define TONGSHADING_INCLUDED

float3 CalcuateToneDiffuse(ToneSurface surface, PBRLight light) 
{
	float3 baseColor = surface.BaseColor.rgb;
	float3 texColor = surface.TexColor.rgb;

	float3 kd = baseColor * texColor;

	float3 blueColor = float3(0, 0, surface.BlueColor);
	float3 yellowColor = float3(surface.YellowColor, surface.YellowColor, 0);

	float alpha = surface.Alpha;
	float beta = surface.Beta;

	float3 kcool = blueColor + alpha * kd;
	float3 kwarm = yellowColor + alpha * kd;

	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;

	float diffuse = Dot(normal, lightDir);
	diffuse = (diffuse * 0.5 + 0.5);

	float3 finalCol = light.LightColor * (diffuse * kcool + (1 - diffuse) * kwarm);
	return finalCol;
}

#endif