

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

constant float4 _162 = {};
constant float _164 = {};
constant float4 _165 = {};

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

fragment MainPS_out Main_0000405f_36a5b282(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _219 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _164, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _224 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _229 = (_224.xyz / float3(_224.w)) - View.View_PreViewTranslation;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float _245 = sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)) + 1.0;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _260 = float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _263 = float3(_238, _245);
    float3 _267 = float3(_260.xy * (-1.0), _260.z);
    float3 _279 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_263 * dot(_263, _267)) - (_267 * _245)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _291 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _309 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_291.x + 0.5) * (_296.x + 0.5))) * _305.xyz, float3(0.0), float3(1.0));
    float _310 = fast::clamp(_305.w, 0.0, 1.0);
    float _314 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _315 = in.in_var_PRIMITIVE_ID * 36u;
    uint _316 = _315 + 20u;
    float _364;
    float _365;
    float _366;
    float3 _367;
    float3 _368;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _334 = ((_219.xy / float2(_219.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _338 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _341 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _334, level(0.0));
        float _354 = _344.w;
        _364 = (_314 * _354) + _344.z;
        _365 = (_310 * _354) + _344.y;
        _366 = _344.x;
        _367 = (_309 * _338.w) + _338.xyz;
        _368 = normalize((_279 * _341.w) + ((_341.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _364 = _314;
        _365 = _310;
        _366 = 0.0;
        _367 = _309;
        _368 = _279;
    }
    bool _378 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _384;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 18u)].w > 0.0) && _378)
    {
        _384 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _384 = 1.0;
    }
    float _431;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].z > 0.0)
    {
        float3 _399 = fast::clamp((_229 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _410 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_399.x), int(_399.y), int(_399.z), 0).xyz), 0));
        _431 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_410.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_399 / float3(_410.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _431 = _384;
    }
    float3 _445 = ((_367 - (_367 * _366)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _452 = (mix(float3(0.07999999821186065673828125 * _365), _367, float3(_366)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _455 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _460;
    if (_455)
    {
        _460 = _445 + (_452 * 0.449999988079071044921875);
    }
    else
    {
        _460 = _445;
    }
    float3 _462 = select(_452, float3(0.0), bool3(_455));
    float3 _464 = float3(dot(_462, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _550;
    if (_378)
    {
        float4 _500 = _165;
        _500.y = (-0.48860299587249755859375) * _368.y;
        float4 _503 = _500;
        _503.z = 0.48860299587249755859375 * _368.z;
        float4 _506 = _503;
        _506.w = (-0.48860299587249755859375) * _368.x;
        float3 _507 = _368 * _368;
        float4 _510 = _162;
        _510.x = (1.09254801273345947265625 * _368.x) * _368.y;
        float4 _513 = _510;
        _513.y = ((-1.09254801273345947265625) * _368.y) * _368.z;
        float4 _518 = _513;
        _518.z = 0.3153919875621795654296875 * ((3.0 * _507.z) - 1.0);
        float4 _521 = _518;
        _521.w = ((-1.09254801273345947265625) * _368.x) * _368.z;
        float4 _525 = _506;
        _525.x = 0.886227548122406005859375;
        float3 _527 = _525.yzw * 2.094395160675048828125;
        float4 _528 = float4(_525.x, _527.x, _527.y, _527.z);
        float4 _529 = _521 * 0.785398185253143310546875;
        float _530 = (_507.x - _507.y) * 0.4290426075458526611328125;
        float3 _536 = float3(0.0);
        _536.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _528) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _529)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _530);
        float3 _542 = _536;
        _542.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _528) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _529)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _530);
        float3 _548 = _542;
        _548.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _528) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _529)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _530);
        _550 = fast::max(float3(0.0), _548);
    }
    else
    {
        _550 = float3(0.0);
    }
    float3 _553 = _550 * View.View_IndirectLightingColorScale;
    float3 _575 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _604;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _603;
        if (any(abs(_229 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _315 + 19u)].xyz + float3(1.0))))
        {
            _603 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_229, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _603 = _575;
        }
        _604 = _603;
    }
    else
    {
        _604 = _575;
    }
    float4 _611 = float4(((mix(float3(0.0), _460 + (_462 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_553 * _460) * fast::max(float3(1.0), ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _604) * 1.0, 0.0);
    float4 _618;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _617 = _611;
        _617.w = 0.0;
        _618 = _617;
    }
    else
    {
        _618 = _611;
    }
    float2 _622 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _630 = (_368 * 0.5) + float3(0.5);
    float4 _632 = float4(_630.x, _630.y, _630.z, float4(0.0).w);
    _632.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316)].y;
    float4 _633 = float4(0.0);
    _633.x = _366;
    float4 _634 = _633;
    _634.y = _365;
    float4 _635 = _634;
    _635.z = _364;
    float4 _636 = _635;
    _636.w = 0.50588238239288330078125;
    float4 _648 = float4(_367.x, _367.y, _367.z, float4(0.0).w);
    _648.w = ((log2(((dot(_553, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_464 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_464 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_464 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_622.xyx * _622.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _618 * View.View_PreExposure;
    out.out_var_SV_Target1 = _632;
    out.out_var_SV_Target2 = _636;
    out.out_var_SV_Target3 = _648;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_431, 1.0, 1.0, 1.0);
    return out;
}

