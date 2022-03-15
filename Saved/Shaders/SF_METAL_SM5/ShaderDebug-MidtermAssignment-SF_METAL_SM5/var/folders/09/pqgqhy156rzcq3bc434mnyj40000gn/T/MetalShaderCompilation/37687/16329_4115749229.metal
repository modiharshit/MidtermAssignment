

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

constant float4 _160 = {};
constant float _162 = {};
constant float4 _163 = {};

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

fragment MainPS_out Main_00003fc9_f551596d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _162, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _222 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _227 = (_222.xyz / float3(_222.w)) - View.View_PreViewTranslation;
    float4 _233 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _236 = (_233.xy * float2(2.0)) - float2(1.0);
    float _243 = sqrt(fast::clamp(1.0 - dot(_236, _236), 0.0, 1.0)) + 1.0;
    float2 _244 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _248 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float _255 = sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0));
    float3 _261 = float3(_236, _243);
    float3 _264 = float3(float4(_251, _255, 1.0).xy * (-1.0), _255);
    float3 _276 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_261 * dot(_261, _264)) - (_264 * _243)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _287 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _296 = fast::clamp(_287.xyz, float3(0.0), float3(1.0));
    float _297 = fast::clamp(_291.x, 0.0, 1.0);
    float _302 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _303 = in.in_var_PRIMITIVE_ID * 36u;
    uint _304 = _303 + 20u;
    float _352;
    float _353;
    float _354;
    float3 _355;
    float3 _356;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _322 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _326 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _329 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _322, level(0.0));
        float _342 = _332.w;
        _352 = (_302 * _342) + _332.z;
        _353 = (0.5 * _342) + _332.y;
        _354 = _332.x;
        _355 = (_296 * _326.w) + _326.xyz;
        _356 = normalize((_276 * _329.w) + ((_329.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _352 = _302;
        _353 = 0.5;
        _354 = 0.0;
        _355 = _296;
        _356 = _276;
    }
    bool _366 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 18u)].w > 0.0) && _366)
    {
        _372 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _372 = 1.0;
    }
    float _419;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].z > 0.0)
    {
        float3 _387 = fast::clamp((_227 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _398 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_387.x), int(_387.y), int(_387.z), 0).xyz), 0));
        _419 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_398.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_387 / float3(_398.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _419 = _372;
    }
    float3 _433 = ((_355 - (_355 * _354)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _440 = (mix(float3(0.07999999821186065673828125 * _353), _355, float3(_354)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _443 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _448;
    if (_443)
    {
        _448 = _433 + (_440 * 0.449999988079071044921875);
    }
    else
    {
        _448 = _433;
    }
    float3 _450 = select(_440, float3(0.0), bool3(_443));
    float3 _452 = float3(dot(_450, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _459 = float3(_297);
    float3 _539;
    if (_366)
    {
        float4 _489 = _163;
        _489.y = (-0.48860299587249755859375) * _356.y;
        float4 _492 = _489;
        _492.z = 0.48860299587249755859375 * _356.z;
        float4 _495 = _492;
        _495.w = (-0.48860299587249755859375) * _356.x;
        float3 _496 = _356 * _356;
        float4 _499 = _160;
        _499.x = (1.09254801273345947265625 * _356.x) * _356.y;
        float4 _502 = _499;
        _502.y = ((-1.09254801273345947265625) * _356.y) * _356.z;
        float4 _507 = _502;
        _507.z = 0.3153919875621795654296875 * ((3.0 * _496.z) - 1.0);
        float4 _510 = _507;
        _510.w = ((-1.09254801273345947265625) * _356.x) * _356.z;
        float4 _514 = _495;
        _514.x = 0.886227548122406005859375;
        float3 _516 = _514.yzw * 2.094395160675048828125;
        float4 _517 = float4(_514.x, _516.x, _516.y, _516.z);
        float4 _518 = _510 * 0.785398185253143310546875;
        float _519 = (_496.x - _496.y) * 0.4290426075458526611328125;
        float3 _525 = float3(0.0);
        _525.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _519);
        float3 _531 = _525;
        _531.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _519);
        float3 _537 = _531;
        _537.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _517) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _518)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _519);
        _539 = fast::max(float3(0.0), _537);
    }
    else
    {
        _539 = float3(0.0);
    }
    float3 _542 = _539 * View.View_IndirectLightingColorScale;
    float3 _564 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _593;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _592;
        if (any(abs(_227 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _303 + 19u)].xyz + float3(1.0))))
        {
            _592 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_227, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _592 = _564;
        }
        _593 = _592;
    }
    else
    {
        _593 = _564;
    }
    float4 _600 = float4(((mix(float3(0.0), _448 + (_450 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_542 * _448) * fast::max(_459, ((((((_355 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _297) + ((_355 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _297) + ((_355 * 2.755199909210205078125) + float3(0.69029998779296875))) * _297))) + _593) * 1.0, 0.0);
    float4 _607;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _606 = _600;
        _606.w = 0.0;
        _607 = _606;
    }
    else
    {
        _607 = _600;
    }
    float2 _611 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _619 = (_356 * 0.5) + float3(0.5);
    float4 _621 = float4(_619.x, _619.y, _619.z, float4(0.0).w);
    _621.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _304)].y;
    float4 _622 = float4(0.0);
    _622.x = _354;
    float4 _623 = _622;
    _623.y = _353;
    float4 _624 = _623;
    _624.z = _352;
    float4 _625 = _624;
    _625.w = 0.50588238239288330078125;
    float4 _637 = float4(_355.x, _355.y, _355.z, float4(0.0).w);
    _637.w = ((log2(((dot(_542, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_459, ((((((_452 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _297) + ((_452 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _297) + ((_452 * 2.755199909210205078125) + float3(0.69029998779296875))) * _297).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_611.xyx * _611.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _607 * View.View_PreExposure;
    out.out_var_SV_Target1 = _621;
    out.out_var_SV_Target2 = _625;
    out.out_var_SV_Target3 = _637;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_419, 1.0, 1.0, 1.0);
    return out;
}

