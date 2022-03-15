

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

vertex Main_out Main_000027bc_f07b0542(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    uint _121 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _127 = float(View.View_FarShadowStaticMeshLODBias);
    float _131 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _134 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_121)).x + _127, _131)));
    float4 _145 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_121));
    float _146 = _145.x;
    float2 _155 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_134) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _156 = _155.y;
    float _157 = _155.x;
    float4 _161 = float4(_156, _157, 1.0 - _157, 1.0 - _156) * 2.0;
    spvUnsafeArray<int2, 4> _100;
    _100[0] = int2(0, -1);
    _100[1] = int2(-1, 0);
    _100[2] = int2(1, 0);
    _100[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _101;
    for (int _173 = 0; _173 < 4; )
    {
        int2 _187 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_100[_173] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _101[_173] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_187.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_187.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_121)).x + _127, _131));
        _101[_173] = fast::min(_101[_173] + _127, _131);
        _173++;
        continue;
    }
    float4 _216 = (_161 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_121)).x + _127, _131)) + ((float4(1.0) - _161) * float4(_101[0], _101[1], _101[2], _101[3]));
    bool _219 = _157 < _156;
    float _226 = ((_157 + _156) > 1.0) ? (_219 ? _216.w : _216.z) : (_219 ? _216.y : _216.x);
    float _227 = floor(_226);
    float _228 = _226 - _227;
    float2 _233 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_227 - float(_134))));
    float _235 = pow(2.0, -_227);
    float2 _248 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _235) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _235, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _251 = _233 / float2(_248.x);
    float2 _256 = floor(_233 * 0.5) / float2(_248.y);
    float2 _263 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _268 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _274 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_251 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _263) + _268), level(_227 - _146));
    float4 _289 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_256 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _263) + _268), level((_227 + 1.0) - _146));
    float3 _304 = mix(float3(_251, (((_274.x * 65280.0) + (_274.y * 255.0)) - 32768.0) * 0.0078125), float3(_256, (((_289.x * 65280.0) + (_289.y * 255.0)) - 32768.0) * 0.0078125), float3(_228));
    float2 _314 = (mix(float2(_274.zw), float2(_289.zw), float2(_228)) * float2(2.0)) - float2(1.0);
    float2 _323 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _327 = _304 + float3(_323, 0.0);
    float4 _353 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _327.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _327.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _327.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _359 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_353.x, _353.y, _353.z, _353.w);
    float4 _370;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_359.z < 0.0))
    {
        float4 _368 = _359;
        _368.z = 9.9999999747524270787835121154785e-07;
        float4 _369 = _368;
        _369.w = 1.0;
        _370 = _369;
    }
    else
    {
        _370 = _359;
    }
    float _376 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_314, sqrt(fast::max(1.0 - dot(_314, _314), 0.0)))));
    float2 _395 = _304.xy;
    float2 _408 = ((_395 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _412 = (((_395 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _263) + _268;
    out.out_var_TEXCOORD0 = (_395 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _323;
    out.out_var_TEXCOORD1 = float4(_408.x, _408.y, _412.x, _412.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _370.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_376) > 0.0) ? (sqrt(fast::clamp(1.0 - (_376 * _376), 0.0, 1.0)) / _376) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _353.xyz;
    out.gl_Position = _370;
    return out;
}

