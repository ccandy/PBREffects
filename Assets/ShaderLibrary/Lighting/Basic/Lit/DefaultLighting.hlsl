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
	float3 diffuseCol = diffuse * light.LightColor;
	

	return diffuseCol;
}

float CaculatePhong(DefaultSurface surface, DefaultLight light, float3 viewDir) 
{
	float3 normalDir = surface.Normal;
	float3 lightDir = light.LightDirection;

	float3 refDir = reflect(-lightDir, normalDir);
	float phong = DotMax(refDir, viewDir, 0.0001);

	float edge = fwidth(phong);

	float smoothPhong = smoothstep(-edge, edge, phong);

	return phong;
}

float CalculateBlinnPhong(DefaultSurface surface, DefaultLight light, float3 viewDir) 
{
	float3 normalDir = surface.Normal;
	float3 lightDir = light.LightDirection;

	float3 halfVector = normalize(viewDir + lightDir);
	float blinnPhong = Dot(halfVector, normalDir);

	return blinnPhong;
}

float3 CalcuateSepc(DefaultSurface surface, DefaultLight light, float3 viewDir)
{
	float3 normal = surface.Normal;
	float3 lightDir = light.LightDirection;

	float phong = CaculatePhong(surface, light, viewDir);
	float shinness = surface.Shinness;

	float pShinness = pow(phong, shinness);
	float specStrength = surface.SpecStrength;
	float3 specColor = light.LightColor * pShinness *surface.SpecStrength;

	return specColor;
}



#endif