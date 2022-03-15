

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
    char _m0_pad[704];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m1_pad[288];
    float4 View_ScreenPositionScaleBias;
    char _m2_pad[48];
    float3 View_PreViewTranslation;
    char _m3_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m5_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m10_pad[8];
    float View_OutOfBoundsMask;
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _152 = {};
constant float _153 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
    float4 out_var_SV_Target1 [[color(1)]];
    float4 out_var_SV_Target2 [[color(2)]];
    float4 out_var_SV_Target3 [[color(3)]];
    float4 out_var_SV_Target4 [[color(4)]];
    float4 out_var_SV_Target5 [[color(5)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    float4 in_var_TEXCOORD4 [[user(locn4)]];
    uint in_var_PRIMITIVE_ID [[user(locn5)]];
    uint in_var_LIGHTMAP_ID [[user(locn6)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000038e1_45e28f17(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_3 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _153, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _221 = (_216.xyz / float3(_216.w)) - View.View_PreViewTranslation;
    uint _222 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _236 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _247 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _236.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _265 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _285 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _285) : (PrimitiveDither.PrimitiveDither_LODFactor < _285)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _258.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _300 = fast::clamp(_258.xyz, float3(0.0), float3(1.0));
    float _305 = (fast::clamp(_236.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _315 = (fast::clamp(float4(_265.xyz, _152).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _316 = _222 + 20u;
    float3 _365;
    float _366;
    float _367;
    float _368;
    float3 _369;
    float3 _370;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _334 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _338 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float _346 = _338.w;
        float _354 = _344.w;
        _365 = _315 * _346;
        _366 = (_305 * _354) + _344.z;
        _367 = (0.5 * _354) + _344.y;
        _368 = _344.x;
        _369 = (_300 * _346) + _338.xyz;
        _370 = normalize((_247 * _341.w) + ((_341.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _365 = _315;
        _366 = _305;
        _367 = 0.5;
        _368 = 0.0;
        _369 = _300;
        _370 = _247;
    }
    float3 _374 = sqrt(fast::clamp(_365, float3(0.0), float3(1.0)));
    float4 _376 = float4(_374.x, _374.y, _374.z, float4(0.0).w);
    _376.w = 1.0;
    float3 _384 = ((_369 - (_369 * _368)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _391 = (mix(float3(0.07999999821186065673828125 * _367), _369, float3(_368)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _394 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _399;
    if (_394)
    {
        _399 = _384 + (_391 * 0.449999988079071044921875);
    }
    else
    {
        _399 = _384;
    }
    float3 _401 = select(_391, float3(0.0), bool3(_394));
    float3 _403 = float3(dot(_401, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _418 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _423 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _418);
    float4 _425 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_418 + float2(0.0, 0.5)));
    uint _431 = in.in_var_LIGHTMAP_ID * 15u;
    uint _432 = _431 + 4u;
    uint _437 = _431 + 6u;
    float3 _442 = _423.xyz;
    float3 _449 = ((_442 * _442) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].xyz;
    float _451 = exp2(((_423.w + ((_425.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].w) - 0.0185813605785369873046875;
    float4 _459 = (_425 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _431 + 7u)];
    float3 _480 = (_449 * (_451 * fast::max(0.0, dot(_459, float4(_370.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _505 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _534;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _533;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _222 + 19u)].xyz + float3(1.0))))
        {
            _533 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _533 = _505;
        }
        _534 = _533;
    }
    else
    {
        _534 = _505;
    }
    float4 _541 = float4(((mix(float3(0.0), _399 + (_401 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_480 * _399) + (((_449 * (_451 * fast::max(0.0, dot(_459, float4(-_370.yzx, 1.0))))) * View.View_IndirectLightingColorScale) * _365)) * fast::max(float3(1.0), ((((((_369 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_369 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_369 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _534) * 1.0, 0.0);
    float4 _548;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _547 = _541;
        _547.w = 0.0;
        _548 = _547;
    }
    else
    {
        _548 = _541;
    }
    float2 _552 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _560 = (_370 * 0.5) + float3(0.5);
    float4 _562 = float4(_560.x, _560.y, _560.z, float4(0.0).w);
    _562.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].y;
    float4 _563 = float4(0.0);
    _563.x = _368;
    float4 _564 = _563;
    _564.y = _367;
    float4 _565 = _564;
    _565.z = _366;
    float4 _566 = _565;
    _566.w = 0.776470601558685302734375;
    float4 _578 = float4(_369.x, _369.y, _369.z, float4(0.0).w);
    _578.w = ((log2(((dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_552.xyx * _552.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _548 * View.View_PreExposure;
    out.out_var_SV_Target1 = _562;
    out.out_var_SV_Target2 = _566;
    out.out_var_SV_Target3 = _578;
    out.out_var_SV_Target4 = _376;
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

