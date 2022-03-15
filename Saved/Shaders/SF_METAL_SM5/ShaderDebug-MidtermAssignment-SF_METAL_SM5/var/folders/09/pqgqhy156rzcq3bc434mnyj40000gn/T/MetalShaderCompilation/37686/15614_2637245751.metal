

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
    char _m18_pad[48];
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

constant float4 _157 = {};
constant float _159 = {};
constant float4 _160 = {};

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

fragment MainPS_out Main_00003cfe_9d312d37(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _218 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _159, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _223 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _228 = (_223.xyz / float3(_223.w)) - View.View_PreViewTranslation;
    uint _229 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _273 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if ((_273.w - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _280 = fast::clamp(_273.xyz, float3(0.0), float3(1.0));
    float _284 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _285 = _229 + 20u;
    float _333;
    float _334;
    float _335;
    float3 _336;
    float3 _337;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _303 = ((_218.xy / float2(_218.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _307 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float _323 = _313.w;
        _333 = (_284 * _323) + _313.z;
        _334 = (0.5 * _323) + _313.y;
        _335 = _313.x;
        _336 = (_280 * _307.w) + _307.xyz;
        _337 = normalize((_262 * _310.w) + ((_310.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _333 = _284;
        _334 = 0.5;
        _335 = 0.0;
        _336 = _280;
        _337 = _262;
    }
    bool _347 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _353;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 18u)].w > 0.0) && _347)
    {
        _353 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _353 = 1.0;
    }
    float _400;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].z > 0.0)
    {
        float3 _368 = fast::clamp((_228 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _379 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_368.x), int(_368.y), int(_368.z), 0).xyz), 0));
        _400 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_379.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_368 / float3(_379.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _400 = _353;
    }
    float3 _414 = ((_336 - (_336 * _335)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _421 = (mix(float3(0.07999999821186065673828125 * _334), _336, float3(_335)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _424 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _429;
    if (_424)
    {
        _429 = _414 + (_421 * 0.449999988079071044921875);
    }
    else
    {
        _429 = _414;
    }
    float3 _431 = select(_421, float3(0.0), bool3(_424));
    float3 _433 = float3(dot(_431, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _519;
    if (_347)
    {
        float4 _469 = _160;
        _469.y = (-0.48860299587249755859375) * _337.y;
        float4 _472 = _469;
        _472.z = 0.48860299587249755859375 * _337.z;
        float4 _475 = _472;
        _475.w = (-0.48860299587249755859375) * _337.x;
        float3 _476 = _337 * _337;
        float4 _479 = _157;
        _479.x = (1.09254801273345947265625 * _337.x) * _337.y;
        float4 _482 = _479;
        _482.y = ((-1.09254801273345947265625) * _337.y) * _337.z;
        float4 _487 = _482;
        _487.z = 0.3153919875621795654296875 * ((3.0 * _476.z) - 1.0);
        float4 _490 = _487;
        _490.w = ((-1.09254801273345947265625) * _337.x) * _337.z;
        float4 _494 = _475;
        _494.x = 0.886227548122406005859375;
        float3 _496 = _494.yzw * 2.094395160675048828125;
        float4 _497 = float4(_494.x, _496.x, _496.y, _496.z);
        float4 _498 = _490 * 0.785398185253143310546875;
        float _499 = (_476.x - _476.y) * 0.4290426075458526611328125;
        float3 _505 = float3(0.0);
        _505.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _497) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _498)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _499);
        float3 _511 = _505;
        _511.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _497) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _498)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _499);
        float3 _517 = _511;
        _517.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _497) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _498)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _499);
        _519 = fast::max(float3(0.0), _517);
    }
    else
    {
        _519 = float3(0.0);
    }
    float3 _522 = _519 * View.View_IndirectLightingColorScale;
    float3 _544 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _573;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _572;
        if (any(abs(_228 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _229 + 19u)].xyz + float3(1.0))))
        {
            _572 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_228, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _572 = _544;
        }
        _573 = _572;
    }
    else
    {
        _573 = _544;
    }
    float4 _580 = float4(((mix(float3(0.0), _429 + (_431 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_522 * _429) * fast::max(float3(1.0), ((((((_336 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_336 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_336 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _573) * 1.0, 0.0);
    float4 _587;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _586 = _580;
        _586.w = 0.0;
        _587 = _586;
    }
    else
    {
        _587 = _580;
    }
    float2 _591 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _599 = (_337 * 0.5) + float3(0.5);
    float4 _601 = float4(_599.x, _599.y, _599.z, float4(0.0).w);
    _601.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].y;
    float4 _602 = float4(0.0);
    _602.x = _335;
    float4 _603 = _602;
    _603.y = _334;
    float4 _604 = _603;
    _604.z = _333;
    float4 _605 = _604;
    _605.w = 0.50588238239288330078125;
    float4 _617 = float4(_336.x, _336.y, _336.z, float4(0.0).w);
    _617.w = ((log2(((dot(_522, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_433 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_433 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_433 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_591.xyx * _591.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _587 * View.View_PreExposure;
    out.out_var_SV_Target1 = _601;
    out.out_var_SV_Target2 = _605;
    out.out_var_SV_Target3 = _617;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_400, 1.0, 1.0, 1.0);
    return out;
}

