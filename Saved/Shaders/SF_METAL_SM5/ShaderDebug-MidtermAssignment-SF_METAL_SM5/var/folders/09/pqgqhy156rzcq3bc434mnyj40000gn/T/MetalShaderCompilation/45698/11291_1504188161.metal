

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
    float4 LandscapeParameters_WeightmapUVScaleBias;
    char _m7_pad[16];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float out_var_TEXCOORD8 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002c1b_59a81701(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    uint _124 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _130 = float(View.View_FarShadowStaticMeshLODBias);
    float _134 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _137 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_124)).x + _130, _134)));
    float4 _148 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_124));
    float _149 = _148.x;
    float2 _158 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_137) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _159 = _158.y;
    float _160 = _158.x;
    float4 _164 = float4(_159, _160, 1.0 - _160, 1.0 - _159) * 2.0;
    spvUnsafeArray<int2, 4> _103;
    _103[0] = int2(0, -1);
    _103[1] = int2(-1, 0);
    _103[2] = int2(1, 0);
    _103[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _104;
    for (int _176 = 0; _176 < 4; )
    {
        int2 _190 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_103[_176] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _104[_176] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_190.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_190.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_124)).x + _130, _134));
        _104[_176] = fast::min(_104[_176] + _130, _134);
        _176++;
        continue;
    }
    float4 _219 = (_164 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_124)).x + _130, _134)) + ((float4(1.0) - _164) * float4(_104[0], _104[1], _104[2], _104[3]));
    bool _222 = _160 < _159;
    float _229 = ((_160 + _159) > 1.0) ? (_222 ? _219.w : _219.z) : (_222 ? _219.y : _219.x);
    float _230 = floor(_229);
    float _231 = _229 - _230;
    float2 _236 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_230 - float(_137))));
    float _238 = pow(2.0, -_230);
    float2 _251 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _238) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _238, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _254 = _236 / float2(_251.x);
    float2 _259 = floor(_236 * 0.5) / float2(_251.y);
    float2 _266 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _271 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _277 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_254 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _266) + _271), level(_230 - _149));
    float _289 = _230 + 1.0;
    float4 _292 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_259 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _266) + _271), level(_289 - _149));
    float2 _307 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float4 _312 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_254 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _307), level(_230));
    float4 _317 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_259 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _307), level(_289));
    float3 _357 = mix(float3(_254 + float2((((_312.x * 65280.0) + (_312.y * 255.0)) - 32768.0) * 0.00390625, (((_312.z * 65280.0) + (_312.w * 255.0)) - 32768.0) * 0.00390625), (((_277.x * 65280.0) + (_277.y * 255.0)) - 32768.0) * 0.0078125), float3(_259 + float2((((_317.x * 65280.0) + (_317.y * 255.0)) - 32768.0) * 0.00390625, (((_317.z * 65280.0) + (_317.w * 255.0)) - 32768.0) * 0.00390625), (((_292.x * 65280.0) + (_292.y * 255.0)) - 32768.0) * 0.0078125), float3(_231));
    float2 _367 = (mix(float2(_277.zw), float2(_292.zw), float2(_231)) * float2(2.0)) - float2(1.0);
    float2 _376 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _380 = _357 + float3(_376, 0.0);
    float4 _406 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _380.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _380.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _380.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _412 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_406.x, _406.y, _406.z, _406.w);
    float4 _423;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_412.z < 0.0))
    {
        float4 _421 = _412;
        _421.z = 9.9999999747524270787835121154785e-07;
        float4 _422 = _421;
        _422.w = 1.0;
        _423 = _422;
    }
    else
    {
        _423 = _412;
    }
    float _429 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_367, sqrt(fast::max(1.0 - dot(_367, _367), 0.0)))));
    float2 _448 = _357.xy;
    float2 _455 = ((_448 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _307;
    float2 _459 = (((_448 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _266) + _271;
    out.out_var_TEXCOORD0 = (_448 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _376;
    out.out_var_TEXCOORD1 = float4(_455.x, _455.y, _459.x, _459.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _423.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_429) > 0.0) ? (sqrt(fast::clamp(1.0 - (_429 * _429), 0.0, 1.0)) / _429) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _406.xyz;
    out.gl_Position = _423;
    return out;
}

