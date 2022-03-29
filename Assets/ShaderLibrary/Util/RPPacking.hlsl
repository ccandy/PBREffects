#ifndef RPPACKING_INCLUDED
#define RPPACKING_INCLUDED


float3 DecodeNormal(float4 map, float scale) {
#if defined(UNITY_NO_DXT5nm)
	return UnpackNormalRGB(map, scale);
#else
	return UnpackNormalmapRGorAG(map, scale);
#endif
}
/*
float3 GetNormalTS(float2 baseUV, float scale) {
	float4 map = SAMPLE_TEXTURE2D(_NormalMap, sampler_MainTex, baseUV);
	float3 normal = DecodeNormal(map, scale);
	return normal;
}*/



#endif