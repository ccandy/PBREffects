#ifndef RPPACKING_INCLUDED
#define RPPACKING_INCLUDED


float3 DecodeNormal(float4 map, float scale) {
#if defined(UNITY_NO_DXT5nm)
	return UnpackNormalRGB(map, scale);
#else
	return UnpackNormalmapRGorAG(map, scale);
#endif
}

#endif