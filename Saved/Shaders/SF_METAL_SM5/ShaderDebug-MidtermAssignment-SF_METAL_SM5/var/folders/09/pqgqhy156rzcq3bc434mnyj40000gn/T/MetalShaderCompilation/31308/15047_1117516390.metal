

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
    char _m13_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[48];
    float4 View_SkyLightColor;
    char _m15_pad[124];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _150 = {};
constant float3 _151 = {};

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

fragment MainPS_out Main_00003ac7_429bf266(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float3x3 _195 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = _211.xyz / float3(_211.w);
    float3 _216 = _215 - View.View_PreViewTranslation;
    float2 _220 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _226 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _220, bias(View.View_MaterialTextureMipBias));
    float2 _232 = ((normalize(-_215) * _195).xy * ((0.00999999977648258209228515625 * _226.w) + (-0.004999999888241291046142578125))) + _220;
    float4 _236 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float2 _239 = (_236.xy * float2(2.0)) - float2(1.0);
    float4 _252 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float3 _274 = normalize(_195 * normalize(((float4(_239, sqrt(fast::clamp(1.0 - dot(_239, _239), 0.0, 1.0)), 1.0).xyz + (float4(_255, sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _286 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _294 = (_286.x + 0.5) * (_291.x + 0.5);
    float4 _297 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float4 _303 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _232, bias(View.View_MaterialTextureMipBias));
    float3 _309 = fast::clamp(_297.xyz * mix(0.5, 1.0, _294), float3(0.0), float3(1.0));
    float _310 = fast::clamp(_303.y, 0.0, 1.0);
    float _315 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _303.x + (_294 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _316 = in.in_var_PRIMITIVE_ID * 36u;
    uint _317 = _316 + 20u;
    float _365;
    float _366;
    float _367;
    float3 _368;
    float3 _369;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _335 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _339 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float4 _345 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _335, level(0.0));
        float _355 = _345.w;
        _365 = (_315 * _355) + _345.z;
        _366 = (0.5 * _355) + _345.y;
        _367 = _345.x;
        _368 = (_309 * _339.w) + _339.xyz;
        _369 = normalize((_274 * _342.w) + ((_342.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _365 = _315;
        _366 = 0.5;
        _367 = 0.0;
        _368 = _309;
        _369 = _274;
    }
    float _418;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].z > 0.0)
    {
        float3 _386 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _397 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_386.x), int(_386.y), int(_386.z), 0).xyz), 0));
        _418 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_397.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_386 / float3(_397.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _418 = 1.0;
    }
    float3 _432 = ((_368 - (_368 * _367)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _439 = (mix(float3(0.07999999821186065673828125 * _366), _368, float3(_367)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _442 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _447;
    if (_442)
    {
        _447 = _432 + (_439 * 0.449999988079071044921875);
    }
    else
    {
        _447 = _432;
    }
    float4 _453 = float4(_369, 1.0);
    float3 _457 = _151;
    _457.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _453);
    float3 _461 = _457;
    _461.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _453);
    float3 _465 = _461;
    _465.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _453);
    float4 _468 = _453.xyzz * _453.yzzx;
    float3 _472 = _151;
    _472.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _468);
    float3 _476 = _472;
    _476.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _468);
    float3 _480 = _476;
    _480.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _468);
    float3 _515 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _544;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _543;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _316 + 19u)].xyz + float3(1.0))))
        {
            _543 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _543 = _515;
        }
        _544 = _543;
    }
    else
    {
        _544 = _515;
    }
    float4 _551 = float4(((mix(float3(0.0), _447 + (select(_439, float3(0.0), bool3(_442)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_465 + _480) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_369.x * _369.x) - (_369.y * _369.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _447) * fast::max(float3(_310), ((((((_368 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _310) + ((_368 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _310) + ((_368 * 2.755199909210205078125) + float3(0.69029998779296875))) * _310))) + _544) * 1.0, 0.0);
    float4 _558;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _557 = _551;
        _557.w = 0.0;
        _558 = _557;
    }
    else
    {
        _558 = _551;
    }
    float2 _562 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _570 = (_369 * 0.5) + float3(0.5);
    float4 _572 = float4(_570.x, _570.y, _570.z, float4(0.0).w);
    _572.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317)].y;
    float4 _573 = float4(0.0);
    _573.x = _367;
    float4 _574 = _573;
    _574.y = _366;
    float4 _575 = _574;
    _575.z = _365;
    float4 _576 = _575;
    _576.w = 0.50588238239288330078125;
    float4 _579 = float4(_368.x, _368.y, _368.z, float4(0.0).w);
    _579.w = (fract(dot(_562.xyx * _562.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _558 * View.View_PreExposure;
    out.out_var_SV_Target1 = _572;
    out.out_var_SV_Target2 = _576;
    out.out_var_SV_Target3 = _579;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_418, 1.0, 1.0, 1.0);
    return out;
}

