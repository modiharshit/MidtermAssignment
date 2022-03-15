

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct type_View
{
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
    char _m1_pad[2480];
    int View_FarShadowStaticMeshLODBias;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_LandscapeContinuousLODParameters
{
    int2 LandscapeContinuousLODParameters_Min;
    int2 LandscapeContinuousLODParameters_Size;
};

struct type_LandscapeParameters
{
    int LandscapeParameters_ComponentBaseX;
    int LandscapeParameters_ComponentBaseY;
    int LandscapeParameters_SubsectionSizeVerts;
    int LandscapeParameters_NumSubsections;
    int LandscapeParameters_LastLOD;
    float4 LandscapeParameters_HeightmapUVScaleBias;
    char _m6_pad[32];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000023d8_a6c0426b(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    uint _112 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _118 = float(View.View_FarShadowStaticMeshLODBias);
    float _122 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _125 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_112)).x + _118, _122)));
    float4 _136 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_112));
    float _137 = _136.x;
    float2 _146 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_125) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _147 = _146.y;
    float _148 = _146.x;
    float4 _152 = float4(_147, _148, 1.0 - _148, 1.0 - _147) * 2.0;
    spvUnsafeArray<int2, 4> _91;
    _91[0] = int2(0, -1);
    _91[1] = int2(-1, 0);
    _91[2] = int2(1, 0);
    _91[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _92;
    for (int _164 = 0; _164 < 4; )
    {
        int2 _178 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_91[_164] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _92[_164] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_178.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_178.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_112)).x + _118, _122));
        _92[_164] = fast::min(_92[_164] + _118, _122);
        _164++;
        continue;
    }
    float4 _207 = (_152 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_112)).x + _118, _122)) + ((float4(1.0) - _152) * float4(_92[0], _92[1], _92[2], _92[3]));
    bool _210 = _148 < _147;
    float _217 = ((_148 + _147) > 1.0) ? (_210 ? _207.w : _207.z) : (_210 ? _207.y : _207.x);
    float _218 = floor(_217);
    float _219 = _217 - _218;
    float2 _224 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_218 - float(_125))));
    float _226 = pow(2.0, -_218);
    float2 _238 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _226) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _226, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _241 = _224 / float2(_238.x);
    float2 _246 = floor(_224 * 0.5) / float2(_238.y);
    float2 _253 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _258 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _264 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_241 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _253) + _258), level(_218 - _137));
    float4 _279 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_246 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _253) + _258), level((_218 + 1.0) - _137));
    float2 _304 = (mix(float2(_264.zw), float2(_279.zw), float2(_219)) * float2(2.0)) - float2(1.0);
    float3 _317 = mix(float3(_241, (((_264.x * 65280.0) + (_264.y * 255.0)) - 32768.0) * 0.0078125), float3(_246, (((_279.x * 65280.0) + (_279.y * 255.0)) - 32768.0) * 0.0078125), float3(_219)) + float3(in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww, 0.0);
    float4 _343 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _317.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _317.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _317.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _349 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_343.x, _343.y, _343.z, _343.w);
    float4 _360;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_349.z < 0.0))
    {
        float4 _358 = _349;
        _358.z = 9.9999999747524270787835121154785e-07;
        float4 _359 = _358;
        _359.w = 1.0;
        _360 = _359;
    }
    else
    {
        _360 = _349;
    }
    float _366 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_304, sqrt(fast::max(1.0 - dot(_304, _304), 0.0)))));
    float4 _391 = _360;
    _391.z = ((_360.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_366) > 0.0) ? (sqrt(fast::clamp(1.0 - (_366 * _366), 0.0, 1.0)) / _366) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _360.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _391;
    return out;
}

