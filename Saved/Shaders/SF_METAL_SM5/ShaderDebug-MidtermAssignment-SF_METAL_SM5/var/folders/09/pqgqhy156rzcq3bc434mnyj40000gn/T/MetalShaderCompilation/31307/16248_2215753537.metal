

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
    float View_UnlitViewmodeMask;
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _159 = {};
constant float _161 = {};
constant float4 _162 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003f78_8411b741(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _216 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _161, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _235 = (_232.xy * float2(2.0)) - float2(1.0);
    float3 _251 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_235, sqrt(fast::clamp(1.0 - dot(_235, _235), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _263 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _277 = (_263.x + 0.5) * ((_268.x + 0.5) * (_273.x + 0.5));
    float4 _283 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _289 = fast::clamp(mix(float3(0.5), float3(1.0), float3(_277)) * _283.xyz, float3(0.0), float3(1.0));
    float _294 = (fast::clamp(mix(0.5, 0.300000011920928955078125, _277 * _283.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _295 = in.in_var_PRIMITIVE_ID * 36u;
    uint _296 = _295 + 20u;
    float _345;
    float _346;
    float _347;
    float3 _348;
    float3 _349;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _314 = ((_216.xy / float2(_216.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _318 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float _334 = _324.w;
        _345 = (_294 * _334) + _324.z;
        _346 = (0.5 * _334) + _324.y;
        _347 = _334 + _324.x;
        _348 = (_289 * _318.w) + _318.xyz;
        _349 = normalize((_251 * _321.w) + ((_321.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _345 = _294;
        _346 = 0.5;
        _347 = 1.0;
        _348 = _289;
        _349 = _251;
    }
    bool _359 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _365;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 18u)].w > 0.0) && _359)
    {
        _365 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _365 = 1.0;
    }
    float _412;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].z > 0.0)
    {
        float3 _380 = fast::clamp((_226 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _391 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_380.x), int(_380.y), int(_380.z), 0).xyz), 0));
        _412 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_391.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_380 / float3(_391.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _412 = _365;
    }
    float3 _426 = ((_348 - (_348 * _347)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _433 = (mix(float3(0.07999999821186065673828125 * _346), _348, float3(_347)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _436 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _441;
    if (_436)
    {
        _441 = _426 + (_433 * 0.449999988079071044921875);
    }
    else
    {
        _441 = _426;
    }
    float3 _443 = select(_433, float3(0.0), bool3(_436));
    float3 _445 = float3(dot(_443, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _531;
    if (_359)
    {
        float4 _481 = _162;
        _481.y = (-0.48860299587249755859375) * _349.y;
        float4 _484 = _481;
        _484.z = 0.48860299587249755859375 * _349.z;
        float4 _487 = _484;
        _487.w = (-0.48860299587249755859375) * _349.x;
        float3 _488 = _349 * _349;
        float4 _491 = _159;
        _491.x = (1.09254801273345947265625 * _349.x) * _349.y;
        float4 _494 = _491;
        _494.y = ((-1.09254801273345947265625) * _349.y) * _349.z;
        float4 _499 = _494;
        _499.z = 0.3153919875621795654296875 * ((3.0 * _488.z) - 1.0);
        float4 _502 = _499;
        _502.w = ((-1.09254801273345947265625) * _349.x) * _349.z;
        float4 _506 = _487;
        _506.x = 0.886227548122406005859375;
        float3 _508 = _506.yzw * 2.094395160675048828125;
        float4 _509 = float4(_506.x, _508.x, _508.y, _508.z);
        float4 _510 = _502 * 0.785398185253143310546875;
        float _511 = (_488.x - _488.y) * 0.4290426075458526611328125;
        float3 _517 = float3(0.0);
        _517.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _509) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _510)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _511);
        float3 _523 = _517;
        _523.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _509) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _510)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _511);
        float3 _529 = _523;
        _529.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _509) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _510)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _511);
        _531 = fast::max(float3(0.0), _529);
    }
    else
    {
        _531 = float3(0.0);
    }
    float3 _534 = _531 * View.View_IndirectLightingColorScale;
    float3 _556 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _585;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _584;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 19u)].xyz + float3(1.0))))
        {
            _584 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _584 = _556;
        }
        _585 = _584;
    }
    else
    {
        _585 = _556;
    }
    float4 _592 = float4(((mix(float3(0.0), _441 + (_443 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_534 * _441) * fast::max(float3(1.0), ((((((_348 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_348 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_348 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _585) * 1.0, 0.0);
    float4 _599;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _598 = _592;
        _598.w = 0.0;
        _599 = _598;
    }
    else
    {
        _599 = _592;
    }
    float2 _603 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _611 = (_349 * 0.5) + float3(0.5);
    float4 _613 = float4(_611.x, _611.y, _611.z, float4(0.0).w);
    _613.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].y;
    float4 _614 = float4(0.0);
    _614.x = _347;
    float4 _615 = _614;
    _615.y = _346;
    float4 _616 = _615;
    _616.z = _345;
    float4 _617 = _616;
    _617.w = 0.50588238239288330078125;
    float4 _629 = float4(_348.x, _348.y, _348.z, float4(0.0).w);
    _629.w = ((log2(((dot(_534, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_445 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_445 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_445 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_603.xyx * _603.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _599 * View.View_PreExposure;
    out.out_var_SV_Target1 = _613;
    out.out_var_SV_Target2 = _617;
    out.out_var_SV_Target3 = _629;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_412, 1.0, 1.0, 1.0);
    return out;
}

