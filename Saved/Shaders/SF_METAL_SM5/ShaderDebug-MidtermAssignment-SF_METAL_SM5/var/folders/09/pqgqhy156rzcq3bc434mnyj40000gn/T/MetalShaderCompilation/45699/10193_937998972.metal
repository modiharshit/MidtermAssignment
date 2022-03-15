

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

vertex Main_out Main_000027d1_37e8ba7c(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    uint _120 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _126 = float(View.View_FarShadowStaticMeshLODBias);
    float _130 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _133 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_120)).x + _126, _130)));
    float4 _144 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_120));
    float _145 = _144.x;
    float2 _154 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_133) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _155 = _154.y;
    float _156 = _154.x;
    float4 _160 = float4(_155, _156, 1.0 - _156, 1.0 - _155) * 2.0;
    spvUnsafeArray<int2, 4> _99;
    _99[0] = int2(0, -1);
    _99[1] = int2(-1, 0);
    _99[2] = int2(1, 0);
    _99[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _100;
    for (int _172 = 0; _172 < 4; )
    {
        int2 _186 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_99[_172] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _100[_172] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_186.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_186.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_120)).x + _126, _130));
        _100[_172] = fast::min(_100[_172] + _126, _130);
        _172++;
        continue;
    }
    float4 _215 = (_160 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_120)).x + _126, _130)) + ((float4(1.0) - _160) * float4(_100[0], _100[1], _100[2], _100[3]));
    bool _218 = _156 < _155;
    float _225 = ((_156 + _155) > 1.0) ? (_218 ? _215.w : _215.z) : (_218 ? _215.y : _215.x);
    float _226 = floor(_225);
    float _227 = _225 - _226;
    float2 _232 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_226 - float(_133))));
    float _234 = pow(2.0, -_226);
    float2 _247 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _234) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _234, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _250 = _232 / float2(_247.x);
    float2 _255 = floor(_232 * 0.5) / float2(_247.y);
    float2 _262 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _267 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _273 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_250 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _262) + _267), level(_226 - _145));
    float4 _288 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_255 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _262) + _267), level((_226 + 1.0) - _145));
    float3 _303 = mix(float3(_250, (((_273.x * 65280.0) + (_273.y * 255.0)) - 32768.0) * 0.0078125), float3(_255, (((_288.x * 65280.0) + (_288.y * 255.0)) - 32768.0) * 0.0078125), float3(_227));
    float2 _313 = (mix(float2(_273.zw), float2(_288.zw), float2(_227)) * float2(2.0)) - float2(1.0);
    float2 _322 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _326 = _303 + float3(_322, 0.0);
    float4 _352 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _326.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _326.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _326.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _358 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_352.x, _352.y, _352.z, _352.w);
    float4 _369;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_358.z < 0.0))
    {
        float4 _367 = _358;
        _367.z = 9.9999999747524270787835121154785e-07;
        float4 _368 = _367;
        _368.w = 1.0;
        _369 = _368;
    }
    else
    {
        _369 = _358;
    }
    float _375 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_313, sqrt(fast::max(1.0 - dot(_313, _313), 0.0)))));
    float4 _400 = _369;
    _400.z = ((_369.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_375) > 0.0) ? (sqrt(fast::clamp(1.0 - (_375 * _375), 0.0, 1.0)) / _375) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _369.w;
    float2 _401 = _303.xy;
    float2 _414 = ((_401 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _418 = (((_401 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _262) + _267;
    out.out_var_TEXCOORD0 = (_401 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _322;
    out.out_var_TEXCOORD1 = float4(_414.x, _414.y, _418.x, _418.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _352.xyz;
    out.gl_Position = _400;
    return out;
}

