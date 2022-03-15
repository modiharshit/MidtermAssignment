

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
    char _m12_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[188];
    float View_ShowDecalsMask;
    char _m14_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m15_pad[48];
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

constant float _114 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000279a_dbd94087(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _166 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _114, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _171 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _176 = (_171.xyz / float3(_171.w)) - View.View_PreViewTranslation;
    float3 _184 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _193 = in.in_var_PRIMITIVE_ID * 36u;
    uint _194 = _193 + 20u;
    float _239;
    float _240;
    float _241;
    float3 _242;
    float3 _243;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _194)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _212 = ((_166.xy / float2(_166.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _219 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _212, level(0.0));
        float4 _222 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _212, level(0.0));
        float _231 = _222.w;
        _239 = (View.View_RoughnessOverrideParameter.x * _231) + _222.z;
        _240 = (0.5 * _231) + _222.y;
        _241 = _222.x;
        _242 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _212, level(0.0)).xyz;
        _243 = normalize((_184 * _219.w) + ((_219.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _239 = View.View_RoughnessOverrideParameter.x;
        _240 = 0.5;
        _241 = 0.0;
        _242 = float3(0.0);
        _243 = _184;
    }
    float _292;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _194)].z > 0.0)
    {
        float3 _260 = fast::clamp((_176 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _271 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_260.x), int(_260.y), int(_260.z), 0).xyz), 0));
        _292 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_271.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_260 / float3(_271.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _292 = 1.0;
    }
    float3 _306 = ((_242 - (_242 * _241)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _313 = (mix(float3(0.07999999821186065673828125 * _240), _242, float3(_241)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _316 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _321;
    if (_316)
    {
        _321 = _306 + (_313 * 0.449999988079071044921875);
    }
    else
    {
        _321 = _306;
    }
    float3 _330 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _359;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _358;
        if (any(abs(_176 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _193 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _193 + 19u)].xyz + float3(1.0))))
        {
            _358 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_176, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _358 = _330;
        }
        _359 = _358;
    }
    else
    {
        _359 = _330;
    }
    float4 _365 = float4((mix(float3(0.0), _321 + (select(_313, float3(0.0), bool3(_316)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _359) * 1.0, 0.0);
    float4 _372;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _371 = _365;
        _371.w = 0.0;
        _372 = _371;
    }
    else
    {
        _372 = _365;
    }
    float2 _376 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _384 = (_243 * 0.5) + float3(0.5);
    float4 _386 = float4(_384.x, _384.y, _384.z, float4(0.0).w);
    _386.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _194)].y;
    float4 _387 = float4(0.0);
    _387.x = _241;
    float4 _388 = _387;
    _388.y = _240;
    float4 _389 = _388;
    _389.z = _239;
    float4 _390 = _389;
    _390.w = 0.50588238239288330078125;
    float4 _393 = float4(_242.x, _242.y, _242.z, float4(0.0).w);
    _393.w = (fract(dot(_376.xyx * _376.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _372 * View.View_PreExposure;
    out.out_var_SV_Target1 = _386;
    out.out_var_SV_Target2 = _390;
    out.out_var_SV_Target3 = _393;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_292, 1.0, 1.0, 1.0);
    return out;
}

