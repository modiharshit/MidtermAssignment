

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
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000023bd_71ebd36f(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    uint _113 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _119 = float(View.View_FarShadowStaticMeshLODBias);
    float _123 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _126 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_113)).x + _119, _123)));
    float4 _137 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_113));
    float _138 = _137.x;
    float2 _147 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_126) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _148 = _147.y;
    float _149 = _147.x;
    float4 _153 = float4(_148, _149, 1.0 - _149, 1.0 - _148) * 2.0;
    spvUnsafeArray<int2, 4> _92;
    _92[0] = int2(0, -1);
    _92[1] = int2(-1, 0);
    _92[2] = int2(1, 0);
    _92[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _93;
    for (int _165 = 0; _165 < 4; )
    {
        int2 _179 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_92[_165] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _93[_165] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_179.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_179.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_113)).x + _119, _123));
        _93[_165] = fast::min(_93[_165] + _119, _123);
        _165++;
        continue;
    }
    float4 _208 = (_153 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_113)).x + _119, _123)) + ((float4(1.0) - _153) * float4(_93[0], _93[1], _93[2], _93[3]));
    bool _211 = _149 < _148;
    float _218 = ((_149 + _148) > 1.0) ? (_211 ? _208.w : _208.z) : (_211 ? _208.y : _208.x);
    float _219 = floor(_218);
    float _220 = _218 - _219;
    float2 _225 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_219 - float(_126))));
    float _227 = pow(2.0, -_219);
    float2 _239 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _227) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _227, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _242 = _225 / float2(_239.x);
    float2 _247 = floor(_225 * 0.5) / float2(_239.y);
    float2 _254 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _259 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _265 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_242 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _254) + _259), level(_219 - _138));
    float4 _280 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_247 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _254) + _259), level((_219 + 1.0) - _138));
    float2 _305 = (mix(float2(_265.zw), float2(_280.zw), float2(_220)) * float2(2.0)) - float2(1.0);
    float3 _318 = mix(float3(_242, (((_265.x * 65280.0) + (_265.y * 255.0)) - 32768.0) * 0.0078125), float3(_247, (((_280.x * 65280.0) + (_280.y * 255.0)) - 32768.0) * 0.0078125), float3(_220)) + float3(in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww, 0.0);
    float4 _344 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _318.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _318.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _318.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _350 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_344.x, _344.y, _344.z, _344.w);
    float4 _361;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_350.z < 0.0))
    {
        float4 _359 = _350;
        _359.z = 9.9999999747524270787835121154785e-07;
        float4 _360 = _359;
        _360.w = 1.0;
        _361 = _360;
    }
    else
    {
        _361 = _350;
    }
    float _367 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float3(_305, sqrt(fast::max(1.0 - dot(_305, _305), 0.0)))));
    out.out_var_TEXCOORD6 = _361.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_367) > 0.0) ? (sqrt(fast::clamp(1.0 - (_367 * _367), 0.0, 1.0)) / _367) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _361;
    return out;
}

