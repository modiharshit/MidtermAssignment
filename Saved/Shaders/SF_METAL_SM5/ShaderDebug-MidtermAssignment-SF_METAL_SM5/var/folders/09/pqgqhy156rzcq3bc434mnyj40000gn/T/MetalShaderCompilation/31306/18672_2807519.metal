

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
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

fragment MainPS_out Main_000048f0_002ad6df(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    bool _321;
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float _263 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _263) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float _283 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _288 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_283, _263) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _291 = (_288.xy * float2(2.0)) - float2(1.0);
    float4 _303 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_263, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _306 = (_303.xy * float2(2.0)) - float2(1.0);
    float _341;
    switch (0u)
    {
        default:
        {
            _321 = View.View_ViewToClip[3u].w < 1.0;
            if (_321)
            {
                _341 = _230.w;
                break;
            }
            else
            {
                float _325 = _230.z;
                _341 = ((_325 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_325 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _353 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_283, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _356 = (_353.xy * float2(2.0)) - float2(1.0);
    float4 _369 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _372 = (_369.xy * float2(2.0)) - float2(1.0);
    float _405;
    switch (0u)
    {
        default:
        {
            if (_321)
            {
                _405 = _230.w;
                break;
            }
            else
            {
                float _389 = _230.z;
                _405 = ((_389 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_389 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _419 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz + (float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_291, sqrt(fast::clamp(1.0 - dot(_291, _291), 0.0, 1.0)), 1.0).xyz + float4(_306, sqrt(fast::clamp(1.0 - dot(_306, _306), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_341 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_356, sqrt(fast::clamp(1.0 - dot(_356, _356), 0.0, 1.0)), 1.0).xyz + (float4(_372, sqrt(fast::clamp(1.0 - dot(_372, _372), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_405 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _430 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _434 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _435 = in.in_var_PRIMITIVE_ID * 36u;
    uint _436 = _435 + 20u;
    float _485;
    float _486;
    float _487;
    float3 _488;
    float3 _489;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _436)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _454 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _458 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _454, level(0.0));
        float4 _461 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _454, level(0.0));
        float4 _464 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _454, level(0.0));
        float _474 = _464.w;
        _485 = (_434 * _474) + _464.z;
        _486 = (0.5 * _474) + _464.y;
        _487 = _474 + _464.x;
        _488 = (_430 * _458.w) + _458.xyz;
        _489 = normalize((_419 * _461.w) + ((_461.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _485 = _434;
        _486 = 0.5;
        _487 = 1.0;
        _488 = _430;
        _489 = _419;
    }
    bool _499 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _505;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _435 + 18u)].w > 0.0) && _499)
    {
        _505 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _505 = 1.0;
    }
    float _552;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _436)].z > 0.0)
    {
        float3 _520 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _531 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_520.x), int(_520.y), int(_520.z), 0).xyz), 0));
        _552 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_531.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_520 / float3(_531.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _552 = _505;
    }
    float3 _566 = ((_488 - (_488 * _487)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _573 = (mix(float3(0.07999999821186065673828125 * _486), _488, float3(_487)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _576 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _581;
    if (_576)
    {
        _581 = _566 + (_573 * 0.449999988079071044921875);
    }
    else
    {
        _581 = _566;
    }
    float3 _583 = select(_573, float3(0.0), bool3(_576));
    float3 _585 = float3(dot(_583, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _671;
    if (_499)
    {
        float4 _621 = _172;
        _621.y = (-0.48860299587249755859375) * _489.y;
        float4 _624 = _621;
        _624.z = 0.48860299587249755859375 * _489.z;
        float4 _627 = _624;
        _627.w = (-0.48860299587249755859375) * _489.x;
        float3 _628 = _489 * _489;
        float4 _631 = _170;
        _631.x = (1.09254801273345947265625 * _489.x) * _489.y;
        float4 _634 = _631;
        _634.y = ((-1.09254801273345947265625) * _489.y) * _489.z;
        float4 _639 = _634;
        _639.z = 0.3153919875621795654296875 * ((3.0 * _628.z) - 1.0);
        float4 _642 = _639;
        _642.w = ((-1.09254801273345947265625) * _489.x) * _489.z;
        float4 _646 = _627;
        _646.x = 0.886227548122406005859375;
        float3 _648 = _646.yzw * 2.094395160675048828125;
        float4 _649 = float4(_646.x, _648.x, _648.y, _648.z);
        float4 _650 = _642 * 0.785398185253143310546875;
        float _651 = (_628.x - _628.y) * 0.4290426075458526611328125;
        float3 _657 = float3(0.0);
        _657.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _649) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _650)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _651);
        float3 _663 = _657;
        _663.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _649) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _650)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _651);
        float3 _669 = _663;
        _669.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _649) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _650)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _651);
        _671 = fast::max(float3(0.0), _669);
    }
    else
    {
        _671 = float3(0.0);
    }
    float3 _674 = _671 * View.View_IndirectLightingColorScale;
    float3 _696 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _725;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _724;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _435 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _435 + 19u)].xyz + float3(1.0))))
        {
            _724 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _724 = _696;
        }
        _725 = _724;
    }
    else
    {
        _725 = _696;
    }
    float4 _732 = float4(((mix(float3(0.0), _581 + (_583 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_674 * _581) * fast::max(float3(1.0), ((((((_488 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_488 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_488 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _725) * 1.0, 0.0);
    float4 _739;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _738 = _732;
        _738.w = 0.0;
        _739 = _738;
    }
    else
    {
        _739 = _732;
    }
    float2 _743 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _751 = (_489 * 0.5) + float3(0.5);
    float4 _753 = float4(_751.x, _751.y, _751.z, float4(0.0).w);
    _753.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _436)].y;
    float4 _754 = float4(0.0);
    _754.x = _487;
    float4 _755 = _754;
    _755.y = _486;
    float4 _756 = _755;
    _756.z = _485;
    float4 _757 = _756;
    _757.w = 0.50588238239288330078125;
    float4 _769 = float4(_488.x, _488.y, _488.z, float4(0.0).w);
    _769.w = ((log2(((dot(_674, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_585 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_585 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_585 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_743.xyx * _743.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _739 * View.View_PreExposure;
    out.out_var_SV_Target1 = _753;
    out.out_var_SV_Target2 = _757;
    out.out_var_SV_Target3 = _769;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_552, 1.0, 1.0, 1.0);
    return out;
}

