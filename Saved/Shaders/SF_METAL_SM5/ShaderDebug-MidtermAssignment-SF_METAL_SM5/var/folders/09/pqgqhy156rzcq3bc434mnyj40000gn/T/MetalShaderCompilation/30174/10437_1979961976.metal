

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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000028c5_7603d278(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    uint _116 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _122 = float(View.View_FarShadowStaticMeshLODBias);
    float _126 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _129 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_116)).x + _122, _126)));
    float4 _140 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_116));
    float _141 = _140.x;
    float2 _150 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_129) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _151 = _150.y;
    float _152 = _150.x;
    float4 _156 = float4(_151, _152, 1.0 - _152, 1.0 - _151) * 2.0;
    spvUnsafeArray<int2, 4> _95;
    _95[0] = int2(0, -1);
    _95[1] = int2(-1, 0);
    _95[2] = int2(1, 0);
    _95[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _96;
    for (int _168 = 0; _168 < 4; )
    {
        int2 _182 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_95[_168] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _96[_168] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_182.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_182.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_116)).x + _122, _126));
        _96[_168] = fast::min(_96[_168] + _122, _126);
        _168++;
        continue;
    }
    float4 _211 = (_156 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_116)).x + _122, _126)) + ((float4(1.0) - _156) * float4(_96[0], _96[1], _96[2], _96[3]));
    bool _214 = _152 < _151;
    float _221 = ((_152 + _151) > 1.0) ? (_214 ? _211.w : _211.z) : (_214 ? _211.y : _211.x);
    float _222 = floor(_221);
    float _223 = _221 - _222;
    float2 _228 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_222 - float(_129))));
    float _230 = pow(2.0, -_222);
    float2 _242 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _230) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _230, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _245 = _228 / float2(_242.x);
    float2 _250 = floor(_228 * 0.5) / float2(_242.y);
    float2 _257 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _262 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _268 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_245 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _257) + _262), level(_222 - _141));
    float _280 = _222 + 1.0;
    float4 _283 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_250 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _257) + _262), level(_280 - _141));
    float2 _298 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float4 _303 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_245 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _298), level(_222));
    float4 _308 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_250 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _298), level(_280));
    float2 _358 = (mix(float2(_268.zw), float2(_283.zw), float2(_223)) * float2(2.0)) - float2(1.0);
    float3 _371 = mix(float3(_245 + float2((((_303.x * 65280.0) + (_303.y * 255.0)) - 32768.0) * 0.00390625, (((_303.z * 65280.0) + (_303.w * 255.0)) - 32768.0) * 0.00390625), (((_268.x * 65280.0) + (_268.y * 255.0)) - 32768.0) * 0.0078125), float3(_250 + float2((((_308.x * 65280.0) + (_308.y * 255.0)) - 32768.0) * 0.00390625, (((_308.z * 65280.0) + (_308.w * 255.0)) - 32768.0) * 0.00390625), (((_283.x * 65280.0) + (_283.y * 255.0)) - 32768.0) * 0.0078125), float3(_223)) + float3(in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww, 0.0);
    float4 _397 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _371.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _371.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _371.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _403 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_397.x, _397.y, _397.z, _397.w);
    float4 _414;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_403.z < 0.0))
    {
        float4 _412 = _403;
        _412.z = 9.9999999747524270787835121154785e-07;
        float4 _413 = _412;
        _413.w = 1.0;
        _414 = _413;
    }
    else
    {
        _414 = _403;
    }
    float _420 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_358, sqrt(fast::max(1.0 - dot(_358, _358), 0.0)))));
    float4 _445 = _414;
    _445.z = ((_414.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_420) > 0.0) ? (sqrt(fast::clamp(1.0 - (_420 * _420), 0.0, 1.0)) / _420) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _414.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _445;
    return out;
}

