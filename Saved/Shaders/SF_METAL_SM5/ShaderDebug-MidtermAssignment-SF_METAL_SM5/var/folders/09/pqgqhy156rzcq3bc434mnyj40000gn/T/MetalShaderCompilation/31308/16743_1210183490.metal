

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

constant float4 _166 = {};
constant float _168 = {};
constant float4 _169 = {};

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

fragment MainPS_out Main_00004167_4821ef42(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _212 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _223 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _228 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = _228.xyz / float3(_228.w);
    float3 _233 = _232 - View.View_PreViewTranslation;
    float4 _242 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _248 = ((normalize(-_232) * _212).xy * ((0.0599999986588954925537109375 * _242.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float3 _271 = normalize(_212 * normalize((float4(_255, sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _283 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _293 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _301 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _248, bias(View.View_MaterialTextureMipBias));
    float _304 = _301.w;
    float3 _309 = fast::clamp(_301.xyz * ((_283.x + 0.5) * ((_288.x + 0.5) * (_293.x + 0.5))), float3(0.0), float3(1.0));
    float _310 = fast::clamp(_304 * 4.0, 0.0, 1.0);
    float _315 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _304), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _316 = in.in_var_PRIMITIVE_ID * 36u;
    uint _317 = _316 + 20u;
    float _365;
    float _366;
    float _367;
    float3 _368;
    float3 _369;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _335 = ((_223.xy / float2(_223.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _339 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float4 _345 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float _355 = _345.w;
        _365 = (_315 * _355) + _345.z;
        _366 = (_310 * _355) + _345.y;
        _367 = _345.x;
        _368 = (_309 * _339.w) + _339.xyz;
        _369 = normalize((_271 * _342.w) + ((_342.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _365 = _315;
        _366 = _310;
        _367 = 0.0;
        _368 = _309;
        _369 = _271;
    }
    bool _379 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _385;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316 + 18u)].w > 0.0) && _379)
    {
        _385 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _385 = 1.0;
    }
    float _432;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].z > 0.0)
    {
        float3 _400 = fast::clamp((_233 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _411 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_400.x), int(_400.y), int(_400.z), 0).xyz), 0));
        _432 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_411.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_400 / float3(_411.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _432 = _385;
    }
    float3 _446 = ((_368 - (_368 * _367)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _453 = (mix(float3(0.07999999821186065673828125 * _366), _368, float3(_367)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _456 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _461;
    if (_456)
    {
        _461 = _446 + (_453 * 0.449999988079071044921875);
    }
    else
    {
        _461 = _446;
    }
    float3 _463 = select(_453, float3(0.0), bool3(_456));
    float3 _465 = float3(dot(_463, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _551;
    if (_379)
    {
        float4 _501 = _169;
        _501.y = (-0.48860299587249755859375) * _369.y;
        float4 _504 = _501;
        _504.z = 0.48860299587249755859375 * _369.z;
        float4 _507 = _504;
        _507.w = (-0.48860299587249755859375) * _369.x;
        float3 _508 = _369 * _369;
        float4 _511 = _166;
        _511.x = (1.09254801273345947265625 * _369.x) * _369.y;
        float4 _514 = _511;
        _514.y = ((-1.09254801273345947265625) * _369.y) * _369.z;
        float4 _519 = _514;
        _519.z = 0.3153919875621795654296875 * ((3.0 * _508.z) - 1.0);
        float4 _522 = _519;
        _522.w = ((-1.09254801273345947265625) * _369.x) * _369.z;
        float4 _526 = _507;
        _526.x = 0.886227548122406005859375;
        float3 _528 = _526.yzw * 2.094395160675048828125;
        float4 _529 = float4(_526.x, _528.x, _528.y, _528.z);
        float4 _530 = _522 * 0.785398185253143310546875;
        float _531 = (_508.x - _508.y) * 0.4290426075458526611328125;
        float3 _537 = float3(0.0);
        _537.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _531);
        float3 _543 = _537;
        _543.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _531);
        float3 _549 = _543;
        _549.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _529) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _530)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _531);
        _551 = fast::max(float3(0.0), _549);
    }
    else
    {
        _551 = float3(0.0);
    }
    float3 _554 = _551 * View.View_IndirectLightingColorScale;
    float3 _576 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _605;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _604;
        if (any(abs(_233 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316 + 19u)].xyz + float3(1.0))))
        {
            _604 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_233, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _604 = _576;
        }
        _605 = _604;
    }
    else
    {
        _605 = _576;
    }
    float4 _612 = float4(((mix(float3(0.0), _461 + (_463 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_554 * _461) * fast::max(float3(1.0), ((((((_368 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_368 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_368 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _605) * 1.0, 0.0);
    float4 _619;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _618 = _612;
        _618.w = 0.0;
        _619 = _618;
    }
    else
    {
        _619 = _612;
    }
    float2 _623 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _631 = (_369 * 0.5) + float3(0.5);
    float4 _633 = float4(_631.x, _631.y, _631.z, float4(0.0).w);
    _633.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].y;
    float4 _634 = float4(0.0);
    _634.x = _367;
    float4 _635 = _634;
    _635.y = _366;
    float4 _636 = _635;
    _636.z = _365;
    float4 _637 = _636;
    _637.w = 0.50588238239288330078125;
    float4 _649 = float4(_368.x, _368.y, _368.z, float4(0.0).w);
    _649.w = ((log2(((dot(_554, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_465 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_465 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_465 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_623.xyx * _623.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _619 * View.View_PreExposure;
    out.out_var_SV_Target1 = _633;
    out.out_var_SV_Target2 = _637;
    out.out_var_SV_Target3 = _649;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_432, 1.0, 1.0, 1.0);
    return out;
}

