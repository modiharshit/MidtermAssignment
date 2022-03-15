

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

constant float4 _170 = {};
constant float4 _172 = {};

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

fragment MainPS_out Main_000045ce_50bd2c78(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = _233.xyz / float3(_233.w);
    float3 _238 = _237 - View.View_PreViewTranslation;
    float4 _246 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _249 = (_246.xy * float2(2.0)) - float2(1.0);
    float4 _261 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _288;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _288 = _229.w;
                break;
            }
            else
            {
                float _272 = _229.z;
                _288 = ((_272 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_272 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _304 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_249, sqrt(fast::clamp(1.0 - dot(_249, _249), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _261.x) + _288) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _316 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _321 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _330 = (_316.x + 0.5) * ((_321.x + 0.5) * (_326.x + 0.5));
    float4 _334 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _336 = _334.xyz * _330;
    float _338 = _336.x;
    float _342 = _336.y;
    float _346 = _336.z;
    float _355 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_237)))), 9.9999997473787516355514526367188e-05);
    float3 _364 = fast::clamp(mix(_336 * 0.5, float3((_338 <= 0.0) ? 0.0 : pow(_338, 0.4000000059604644775390625), (_342 <= 0.0) ? 0.0 : pow(_342, 0.4000000059604644775390625), (_346 <= 0.0) ? 0.0 : pow(_346, 0.4000000059604644775390625)), float3((_355 <= 0.0) ? 0.0 : pow(_355, 3.0))), float3(0.0), float3(1.0));
    float _369 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _330 * _334.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _370 = in.in_var_PRIMITIVE_ID * 36u;
    uint _371 = _370 + 20u;
    float _419;
    float _420;
    float _421;
    float3 _422;
    float3 _423;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _389 = ((_229.xy / float2(_229.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _393 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float4 _396 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float4 _399 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _389, level(0.0));
        float _409 = _399.w;
        _419 = (_369 * _409) + _399.z;
        _420 = (0.5 * _409) + _399.y;
        _421 = _399.x;
        _422 = (_364 * _393.w) + _393.xyz;
        _423 = normalize((_304 * _396.w) + ((_396.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _419 = _369;
        _420 = 0.5;
        _421 = 0.0;
        _422 = _364;
        _423 = _304;
    }
    bool _433 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _439;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 18u)].w > 0.0) && _433)
    {
        _439 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _439 = 1.0;
    }
    float _486;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].z > 0.0)
    {
        float3 _454 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _465 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_454.x), int(_454.y), int(_454.z), 0).xyz), 0));
        _486 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_465.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_454 / float3(_465.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _486 = _439;
    }
    float3 _500 = ((_422 - (_422 * _421)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _507 = (mix(float3(0.07999999821186065673828125 * _420), _422, float3(_421)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _510 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _515;
    if (_510)
    {
        _515 = _500 + (_507 * 0.449999988079071044921875);
    }
    else
    {
        _515 = _500;
    }
    float3 _517 = select(_507, float3(0.0), bool3(_510));
    float3 _519 = float3(dot(_517, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _605;
    if (_433)
    {
        float4 _555 = _172;
        _555.y = (-0.48860299587249755859375) * _423.y;
        float4 _558 = _555;
        _558.z = 0.48860299587249755859375 * _423.z;
        float4 _561 = _558;
        _561.w = (-0.48860299587249755859375) * _423.x;
        float3 _562 = _423 * _423;
        float4 _565 = _170;
        _565.x = (1.09254801273345947265625 * _423.x) * _423.y;
        float4 _568 = _565;
        _568.y = ((-1.09254801273345947265625) * _423.y) * _423.z;
        float4 _573 = _568;
        _573.z = 0.3153919875621795654296875 * ((3.0 * _562.z) - 1.0);
        float4 _576 = _573;
        _576.w = ((-1.09254801273345947265625) * _423.x) * _423.z;
        float4 _580 = _561;
        _580.x = 0.886227548122406005859375;
        float3 _582 = _580.yzw * 2.094395160675048828125;
        float4 _583 = float4(_580.x, _582.x, _582.y, _582.z);
        float4 _584 = _576 * 0.785398185253143310546875;
        float _585 = (_562.x - _562.y) * 0.4290426075458526611328125;
        float3 _591 = float3(0.0);
        _591.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _585);
        float3 _597 = _591;
        _597.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _585);
        float3 _603 = _597;
        _603.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _583) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _584)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _585);
        _605 = fast::max(float3(0.0), _603);
    }
    else
    {
        _605 = float3(0.0);
    }
    float3 _608 = _605 * View.View_IndirectLightingColorScale;
    float3 _630 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _659;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _658;
        if (any(abs(_238 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370 + 19u)].xyz + float3(1.0))))
        {
            _658 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _658 = _630;
        }
        _659 = _658;
    }
    else
    {
        _659 = _630;
    }
    float4 _666 = float4(((mix(float3(0.0), _515 + (_517 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_608 * _515) * fast::max(float3(1.0), ((((((_422 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_422 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_422 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _659) * 1.0, 0.0);
    float4 _673;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _672 = _666;
        _672.w = 0.0;
        _673 = _672;
    }
    else
    {
        _673 = _666;
    }
    float2 _677 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _685 = (_423 * 0.5) + float3(0.5);
    float4 _687 = float4(_685.x, _685.y, _685.z, float4(0.0).w);
    _687.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _371)].y;
    float4 _688 = float4(0.0);
    _688.x = _421;
    float4 _689 = _688;
    _689.y = _420;
    float4 _690 = _689;
    _690.z = _419;
    float4 _691 = _690;
    _691.w = 0.50588238239288330078125;
    float4 _703 = float4(_422.x, _422.y, _422.z, float4(0.0).w);
    _703.w = ((log2(((dot(_608, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_519 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_519 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_519 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_677.xyx * _677.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _673 * View.View_PreExposure;
    out.out_var_SV_Target1 = _687;
    out.out_var_SV_Target2 = _691;
    out.out_var_SV_Target3 = _703;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_486, 1.0, 1.0, 1.0);
    return out;
}

