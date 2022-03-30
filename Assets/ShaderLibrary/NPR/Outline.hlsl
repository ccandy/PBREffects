#ifndef OUTLINE_INCLUDED
#define OUTLINE_INCLUDED

float2 GetVertexExtend(float3 normalDir, float outlinewidth) 
{
	float4 scaleScreenParams = GetScaledScreenParams();
	float scaleX = abs(scaleScreenParams.x / scaleScreenParams.y);

	float3 normalCS = TransformWorldToHClipDir(normalDir);
	float2 extendDis = normalize(normalCS.xy) * (outlinewidth * 0.01);
	extendDis.x / scaleX;

	return extendDis;
}


#endif