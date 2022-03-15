

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
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002c36_83330c31(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    uint _123 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _129 = float(View.View_FarShadowStaticMeshLODBias);
    float _133 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _136 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_123)).x + _129, _133)));
    float4 _147 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_123));
    float _148 = _147.x;
    float2 _157 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_136) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _158 = _157.y;
    float _159 = _157.x;
    float4 _163 = float4(_158, _159, 1.0 - _159, 1.0 - _158) * 2.0;
    spvUnsafeArray<int2, 4> _102;
    _102[0] = int2(0, -1);
    _102[1] = int2(-1, 0);
    _102[2] = int2(1, 0);
    _102[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _103;
    for (int _175 = 0; _175 < 4; )
    {
        int2 _189 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_102[_175] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _103[_175] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_189.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_189.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_123)).x + _129, _133));
        _103[_175] = fast::min(_103[_175] + _129, _133);
        _175++;
        continue;
    }
    float4 _218 = (_163 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_123)).x + _129, _133)) + ((float4(1.0) - _163) * float4(_103[0], _103[1], _103[2], _103[3]));
    bool _221 = _159 < _158;
    float _228 = ((_159 + _158) > 1.0) ? (_221 ? _218.w : _218.z) : (_221 ? _218.y : _218.x);
    float _229 = floor(_228);
    float _230 = _228 - _229;
    float2 _235 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_229 - float(_136))));
    float _237 = pow(2.0, -_229);
    float2 _250 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _237) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _237, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _253 = _235 / float2(_250.x);
    float2 _258 = floor(_235 * 0.5) / float2(_250.y);
    float2 _265 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _270 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _276 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_253 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _265) + _270), level(_229 - _148));
    float _288 = _229 + 1.0;
    float4 _291 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_258 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _265) + _270), level(_288 - _148));
    float2 _306 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float4 _311 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_253 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _306), level(_229));
    float4 _316 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_258 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _306), level(_288));
    float3 _356 = mix(float3(_253 + float2((((_311.x * 65280.0) + (_311.y * 255.0)) - 32768.0) * 0.00390625, (((_311.z * 65280.0) + (_311.w * 255.0)) - 32768.0) * 0.00390625), (((_276.x * 65280.0) + (_276.y * 255.0)) - 32768.0) * 0.0078125), float3(_258 + float2((((_316.x * 65280.0) + (_316.y * 255.0)) - 32768.0) * 0.00390625, (((_316.z * 65280.0) + (_316.w * 255.0)) - 32768.0) * 0.00390625), (((_291.x * 65280.0) + (_291.y * 255.0)) - 32768.0) * 0.0078125), float3(_230));
    float2 _366 = (mix(float2(_276.zw), float2(_291.zw), float2(_230)) * float2(2.0)) - float2(1.0);
    float2 _375 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _379 = _356 + float3(_375, 0.0);
    float4 _405 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _379.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _379.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _379.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _411 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_405.x, _405.y, _405.z, _405.w);
    float4 _422;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_411.z < 0.0))
    {
        float4 _420 = _411;
        _420.z = 9.9999999747524270787835121154785e-07;
        float4 _421 = _420;
        _421.w = 1.0;
        _422 = _421;
    }
    else
    {
        _422 = _411;
    }
    float _428 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_366, sqrt(fast::max(1.0 - dot(_366, _366), 0.0)))));
    float4 _453 = _422;
    _453.z = ((_422.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_428) > 0.0) ? (sqrt(fast::clamp(1.0 - (_428 * _428), 0.0, 1.0)) / _428) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _422.w;
    float2 _454 = _356.xy;
    float2 _461 = ((_454 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _306;
    float2 _465 = (((_454 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _265) + _270;
    out.out_var_TEXCOORD0 = (_454 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _375;
    out.out_var_TEXCOORD1 = float4(_461.x, _461.y, _465.x, _465.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _405.xyz;
    out.gl_Position = _453;
    return out;
}

