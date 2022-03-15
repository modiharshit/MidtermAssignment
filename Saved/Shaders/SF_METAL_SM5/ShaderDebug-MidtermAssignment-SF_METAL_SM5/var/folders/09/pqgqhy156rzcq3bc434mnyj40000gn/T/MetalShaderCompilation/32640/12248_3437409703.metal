

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
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _129 = {};

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

fragment MainPS_out Main_00002fd8_cce2b5a7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _173 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _184 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _129, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _189 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _193 = _189.xyz / float3(_189.w);
    float3 _194 = _193 - View.View_PreViewTranslation;
    float4 _203 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _209 = ((normalize(-_193) * _173).xy * ((0.0500000007450580596923828125 * _203.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _213 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _209, bias(View.View_MaterialTextureMipBias));
    float2 _216 = (_213.xy * float2(2.0)) - float2(1.0);
    float _223 = sqrt(fast::clamp(1.0 - dot(_216, _216), 0.0, 1.0)) + 1.0;
    float4 _226 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float2 _229 = (_226.xy * float2(2.0)) - float2(1.0);
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _209, bias(View.View_MaterialTextureMipBias));
    float _240 = _238.y;
    float3 _242 = mix(float4(_229, sqrt(fast::clamp(1.0 - dot(_229, _229), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_240));
    float3 _245 = float3(_216, _223);
    float3 _249 = float3(_242.xy * (-1.0), _242.z);
    float3 _261 = normalize(_173 * normalize((((_245 * dot(_245, _249)) - (_249 * _223)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _275 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _238.x, float3(0.0), float3(1.0));
    float _276 = fast::clamp(mix(1.0, 0.0, _240), 0.0, 1.0);
    float _280 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _281 = in.in_var_PRIMITIVE_ID * 36u;
    uint _282 = _281 + 20u;
    float _332;
    float _333;
    float _334;
    float3 _335;
    float3 _336;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _300 = ((_184.xy / float2(_184.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _304 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _307 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float _320 = _310.w;
        _332 = (_280 * _320) + _310.z;
        _333 = (0.5 * _320) + _310.y;
        _334 = (_276 * _320) + _310.x;
        _335 = (_275 * _304.w) + _304.xyz;
        _336 = normalize((_261 * _307.w) + ((_307.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _332 = _280;
        _333 = 0.5;
        _334 = _276;
        _335 = _275;
        _336 = _261;
    }
    float _385;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].z > 0.0)
    {
        float3 _353 = fast::clamp((_194 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _364 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_353.x), int(_353.y), int(_353.z), 0).xyz), 0));
        _385 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_364.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_353 / float3(_364.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _385 = 1.0;
    }
    float3 _399 = ((_335 - (_335 * _334)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _406 = (mix(float3(0.07999999821186065673828125 * _333), _335, float3(_334)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _409 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _414;
    if (_409)
    {
        _414 = _399 + (_406 * 0.449999988079071044921875);
    }
    else
    {
        _414 = _399;
    }
    float3 _423 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _452;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _451;
        if (any(abs(_194 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _281 + 19u)].xyz + float3(1.0))))
        {
            _451 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_194, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _451 = _423;
        }
        _452 = _451;
    }
    else
    {
        _452 = _423;
    }
    float4 _458 = float4((mix(float3(0.0), _414 + (select(_406, float3(0.0), bool3(_409)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _452) * 1.0, 0.0);
    float4 _465;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _464 = _458;
        _464.w = 0.0;
        _465 = _464;
    }
    else
    {
        _465 = _458;
    }
    float2 _469 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _477 = (_336 * 0.5) + float3(0.5);
    float4 _479 = float4(_477.x, _477.y, _477.z, float4(0.0).w);
    _479.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282)].y;
    float4 _480 = float4(0.0);
    _480.x = _334;
    float4 _481 = _480;
    _481.y = _333;
    float4 _482 = _481;
    _482.z = _332;
    float4 _483 = _482;
    _483.w = 0.50588238239288330078125;
    float4 _486 = float4(_335.x, _335.y, _335.z, float4(0.0).w);
    _486.w = (fract(dot(_469.xyx * _469.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _465 * View.View_PreExposure;
    out.out_var_SV_Target1 = _479;
    out.out_var_SV_Target2 = _483;
    out.out_var_SV_Target3 = _486;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_385, 1.0, 1.0, 1.0);
    return out;
}

