

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _146 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003342_033a48d6(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _198 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _203 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _208 = (_203.xyz / float3(_203.w)) - View.View_PreViewTranslation;
    float4 _212 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _215 = (_212.xy * float2(2.0)) - float2(1.0);
    float3 _231 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_215, sqrt(fast::clamp(1.0 - dot(_215, _215), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _266 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _266) : (PrimitiveDither.PrimitiveDither_LODFactor < _266)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _277 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _278 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _279 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _280 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _285 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _286 = in.in_var_PRIMITIVE_ID * 36u;
    uint _287 = _286 + 20u;
    float _337;
    float _338;
    float _339;
    float3 _340;
    float3 _341;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _305 = ((_198.xy / float2(_198.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _309 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _312 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float _325 = _315.w;
        _337 = (_285 * _325) + _315.z;
        _338 = (_279 * _325) + _315.y;
        _339 = (_278 * _325) + _315.x;
        _340 = (_277 * _309.w) + _309.xyz;
        _341 = normalize((_231 * _312.w) + ((_312.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _337 = _285;
        _338 = _279;
        _339 = _278;
        _340 = _277;
        _341 = _231;
    }
    float3 _356 = ((_340 - (_340 * _339)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _363 = (mix(float3(0.07999999821186065673828125 * _338), _340, float3(_339)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _366 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _371;
    if (_366)
    {
        _371 = _356 + (_363 * 0.449999988079071044921875);
    }
    else
    {
        _371 = _356;
    }
    float3 _373 = select(_363, float3(0.0), bool3(_366));
    float3 _375 = float3(dot(_373, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _382 = float3(_280);
    float2 _391 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _396 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _391);
    float4 _398 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_391 + float2(0.0, 0.5)));
    uint _400 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _410 = (_396.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 6u)].xyz;
    float _411 = dot(_410, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _430 = (exp2((_411 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_398 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 7u)], float4(_341.yzx, 1.0)));
    float3 _440 = float4(_410 * (_430 / _411), _430).xyz * View.View_IndirectLightingColorScale;
    float3 _462 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _491;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _490;
        if (any(abs(_208 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 19u)].xyz + float3(1.0))))
        {
            _490 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_208, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _490 = _462;
        }
        _491 = _490;
    }
    else
    {
        _491 = _462;
    }
    float4 _498 = float4(((mix(float3(0.0), _371 + (_373 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_440 * _371) * fast::max(_382, ((((((_340 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_340 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_340 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280))) + _491) * 1.0, 0.0);
    float4 _505;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _504 = _498;
        _504.w = 0.0;
        _505 = _504;
    }
    else
    {
        _505 = _498;
    }
    float2 _509 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _517 = (_341 * 0.5) + float3(0.5);
    float4 _519 = float4(_517.x, _517.y, _517.z, float4(0.0).w);
    _519.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].y;
    float4 _520 = float4(0.0);
    _520.x = _339;
    float4 _521 = _520;
    _521.y = _338;
    float4 _522 = _521;
    _522.z = _337;
    float4 _523 = _522;
    _523.w = 0.75686275959014892578125;
    float4 _535 = float4(_340.x, _340.y, _340.z, float4(0.0).w);
    _535.w = ((log2(((dot(_440, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_382, ((((((_375 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_375 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_375 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_509.xyx * _509.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _505 * View.View_PreExposure;
    out.out_var_SV_Target1 = _519;
    out.out_var_SV_Target2 = _523;
    out.out_var_SV_Target3 = _535;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

