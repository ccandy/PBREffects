#ifndef OUTLINEEFFECT_INCLUDED
#define OUTLINEEFFECT_INCLUDED

float2 GetVertexExtend(float3 normalDir, float outlinewidth, float w) 
{
	float4 scaleScreenParams = GetScaledScreenParams();
	float scaleX = abs(scaleScreenParams.x / scaleScreenParams.y);

	float3 normalCS = TransformWorldToHClipDir(normalDir);
	normalCS *= w;
	float2 extendDis = normalize(normalCS.xy) * (outlinewidth * 0.01);
	extendDis.x /= scaleX;

	return extendDis;
}


#endif