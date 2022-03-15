

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
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
    char _m5_pad[1452];
    int View_FarShadowStaticMeshLODBias;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
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

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float2 out_var_TEXCOORD0 [[user(locn2)]];
    float4 out_var_TEXCOORD1 [[user(locn3)]];
    float4 out_var_TEXCOORD2 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_000028a5_665b6ddf(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    MainVertexShader_out out = {};
    uint _122 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _128 = float(View.View_FarShadowStaticMeshLODBias);
    float _132 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _135 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_122)).x + _128, _132)));
    float4 _146 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_122));
    float _147 = _146.x;
    float2 _156 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_135) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _157 = _156.y;
    float _158 = _156.x;
    float4 _162 = float4(_157, _158, 1.0 - _158, 1.0 - _157) * 2.0;
    spvUnsafeArray<int2, 4> _95;
    _95[0] = int2(0, -1);
    _95[1] = int2(-1, 0);
    _95[2] = int2(1, 0);
    _95[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _96;
    for (int _174 = 0; _174 < 4; )
    {
        int2 _188 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_95[_174] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _96[_174] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_188.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_188.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_122)).x + _128, _132));
        _96[_174] = fast::min(_96[_174] + _128, _132);
        _174++;
        continue;
    }
    float4 _217 = (_162 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_122)).x + _128, _132)) + ((float4(1.0) - _162) * float4(_96[0], _96[1], _96[2], _96[3]));
    bool _220 = _158 < _157;
    float _227 = ((_158 + _157) > 1.0) ? (_220 ? _217.w : _217.z) : (_220 ? _217.y : _217.x);
    float _228 = floor(_227);
    float2 _234 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_228 - float(_135))));
    float _236 = pow(2.0, -_228);
    float2 _249 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _236) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _236, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _252 = _234 / float2(_249.x);
    float2 _257 = floor(_234 * 0.5) / float2(_249.y);
    float2 _264 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _269 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _275 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_252 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _264) + _269), level(_228 - _147));
    float _287 = _228 + 1.0;
    float4 _290 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_257 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _264) + _269), level(_287 - _147));
    float2 _305 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float4 _310 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_252 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _305), level(_228));
    float4 _315 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, (((_257 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _305), level(_287));
    float3 _355 = mix(float3(_252 + float2((((_310.x * 65280.0) + (_310.y * 255.0)) - 32768.0) * 0.00390625, (((_310.z * 65280.0) + (_310.w * 255.0)) - 32768.0) * 0.00390625), (((_275.x * 65280.0) + (_275.y * 255.0)) - 32768.0) * 0.0078125), float3(_257 + float2((((_315.x * 65280.0) + (_315.y * 255.0)) - 32768.0) * 0.00390625, (((_315.z * 65280.0) + (_315.w * 255.0)) - 32768.0) * 0.00390625), (((_290.x * 65280.0) + (_290.y * 255.0)) - 32768.0) * 0.0078125), float3(_227 - _228));
    float2 _357 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _361 = _355 + float3(_357, 0.0);
    float3 _378 = ((Primitive.Primitive_LocalToWorld[0u].xyz * _361.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _361.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _361.zzz);
    float2 _387 = _355.xy;
    float2 _394 = ((_387 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _305;
    float2 _398 = (((_387 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _264) + _269;
    float4 _408 = View.View_TranslatedWorldToClip * float4(_378 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _417 = _408;
    _417.z = _408.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _408.w) : 0.0);
    out.gl_Position = _417;
    out.out_var_TEXCOORD6 = _408;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_378 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PrevPreViewTranslation), 1.0);
    out.out_var_TEXCOORD0 = (_387 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _357;
    out.out_var_TEXCOORD1 = float4(_394.x, _394.y, _398.x, _398.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    return out;
}

