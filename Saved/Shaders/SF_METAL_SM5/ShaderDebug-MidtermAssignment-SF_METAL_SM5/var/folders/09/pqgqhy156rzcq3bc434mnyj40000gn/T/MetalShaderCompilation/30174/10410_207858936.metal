

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
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000028aa_0c63acf8(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    uint _117 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _123 = float(View.View_FarShadowStaticMeshLODBias);
    float _127 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _130 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_117)).x + _123, _127)));
    float4 _141 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_117));
    float _142 = _141.x;
    float2 _151 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_130) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _152 = _151.y;
    float _153 = _151.x;
    float4 _157 = float4(_152, _153, 1.0 - _153, 1.0 - _152) * 2.0;
    spvUnsafeArray<int2, 4> _96;
    _96[0] = int2(0, -1);
    _96[1] = int2(-1, 0);
    _96[2] = int2(1, 0);
    _96[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _97;
    for (int _169 = 0; _169 < 4; )
    {
        int2 _183 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_96[_169] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _97[_169] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_183.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_183.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_117)).x + _123, _127));
        _97[_169] = fast::min(_97[_169] + _123, _127);
        _169++;
        continue;
    }
    float4 _212 = (_157 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_117)).x + _123, _127)) + ((float4(1.0) - _157) * float4(_97[0], _97[1], _97[2], _97[3]));
    bool _215 = _153 < _152;
    float _222 = ((_153 + _152) > 1.0) ? (_215 ? _212.w : _212.z) : (_215 ? _212.y : _212.x);
    float _223 = floor(_222);
    float _224 = _222 - _223;
    float2 _229 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_223 - float(_130))));
    float _231 = pow(2.0, -_223);
    float2 _243 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _231) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _231, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _246 = _229 / float2(_243.x);
    float2 _251 = floor(_229 * 0.5) / float2(_243.y);
    float2 _258 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _263 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _269 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_246 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _258) + _263), level(_223 - _142));
    float _281 = _223 + 1.0;
    float4 _284 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_251 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _258) + _263), level(_281 - _142));
    float2 _299 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float4 _304 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_246 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _299), level(_223));
    float4 _309 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_251 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _299), level(_281));
    float2 _359 = (mix(float2(_269.zw), float2(_284.zw), float2(_224)) * float2(2.0)) - float2(1.0);
    float3 _372 = mix(float3(_246 + float2((((_304.x * 65280.0) + (_304.y * 255.0)) - 32768.0) * 0.00390625, (((_304.z * 65280.0) + (_304.w * 255.0)) - 32768.0) * 0.00390625), (((_269.x * 65280.0) + (_269.y * 255.0)) - 32768.0) * 0.0078125), float3(_251 + float2((((_309.x * 65280.0) + (_309.y * 255.0)) - 32768.0) * 0.00390625, (((_309.z * 65280.0) + (_309.w * 255.0)) - 32768.0) * 0.00390625), (((_284.x * 65280.0) + (_284.y * 255.0)) - 32768.0) * 0.0078125), float3(_224)) + float3(in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww, 0.0);
    float4 _398 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _372.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _372.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _372.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _404 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_398.x, _398.y, _398.z, _398.w);
    float4 _415;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_404.z < 0.0))
    {
        float4 _413 = _404;
        _413.z = 9.9999999747524270787835121154785e-07;
        float4 _414 = _413;
        _414.w = 1.0;
        _415 = _414;
    }
    else
    {
        _415 = _404;
    }
    float _421 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_359, sqrt(fast::max(1.0 - dot(_359, _359), 0.0)))));
    out.out_var_TEXCOORD6 = _415.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_421) > 0.0) ? (sqrt(fast::clamp(1.0 - (_421 * _421), 0.0, 1.0)) / _421) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _415;
    return out;
}

