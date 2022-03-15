

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

constant float _118 = {};

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

fragment MainPS_out Main_000028be_e20cb971(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _170 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _118, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _175 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _180 = (_175.xyz / float3(_175.w)) - View.View_PreViewTranslation;
    float3 _188 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _199 = (0.64999997615814208984375 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _200 = in.in_var_PRIMITIVE_ID * 36u;
    uint _201 = _200 + 20u;
    float _250;
    float _251;
    float _252;
    float3 _253;
    float3 _254;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _219 = ((_170.xy / float2(_170.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _223 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _219, level(0.0));
        float4 _226 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _219, level(0.0));
        float4 _229 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _219, level(0.0));
        float _239 = _229.w;
        _250 = (_199 * _239) + _229.z;
        _251 = (0.5 * _239) + _229.y;
        _252 = _239 + _229.x;
        _253 = (float3(0.180000007152557373046875) * _223.w) + _223.xyz;
        _254 = normalize((_188 * _226.w) + ((_226.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _250 = _199;
        _251 = 0.5;
        _252 = 1.0;
        _253 = float3(0.180000007152557373046875);
        _254 = _188;
    }
    float _303;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].z > 0.0)
    {
        float3 _271 = fast::clamp((_180 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _282 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_271.x), int(_271.y), int(_271.z), 0).xyz), 0));
        _303 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_282.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_271 / float3(_282.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _303 = 1.0;
    }
    float4 _305 = float4(0.0);
    _305.x = 1.0;
    float4 _306 = _305;
    _306.y = 0.0;
    float3 _320 = ((_253 - (_253 * _252)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _327 = (mix(float3(0.07999999821186065673828125 * _251), _253, float3(_252)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _330 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _335;
    if (_330)
    {
        _335 = _320 + (_327 * 0.449999988079071044921875);
    }
    else
    {
        _335 = _320;
    }
    float3 _344 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _373;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _372;
        if (any(abs(_180 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _200 + 19u)].xyz + float3(1.0))))
        {
            _372 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_180, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _372 = _344;
        }
        _373 = _372;
    }
    else
    {
        _373 = _344;
    }
    float4 _379 = float4((mix(float3(0.0), _335 + (select(_327, float3(0.0), bool3(_330)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _373) * 1.0, 0.0);
    float4 _386;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _385 = _379;
        _385.w = 0.0;
        _386 = _385;
    }
    else
    {
        _386 = _379;
    }
    float2 _390 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _398 = (_254 * 0.5) + float3(0.5);
    float4 _400 = float4(_398.x, _398.y, _398.z, float4(0.0).w);
    _400.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _201)].y;
    float4 _401 = float4(0.0);
    _401.x = _252;
    float4 _402 = _401;
    _402.y = _251;
    float4 _403 = _402;
    _403.z = fast::clamp(_250, 0.0, 0.996078431606292724609375);
    float4 _404 = _403;
    _404.w = 0.517647087574005126953125;
    float4 _407 = float4(_253.x, _253.y, _253.z, float4(0.0).w);
    _407.w = (fract(dot(_390.xyx * _390.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _386 * View.View_PreExposure;
    out.out_var_SV_Target1 = _400;
    out.out_var_SV_Target2 = _404;
    out.out_var_SV_Target3 = _407;
    out.out_var_SV_Target4 = _306;
    out.out_var_SV_Target5 = float4(_303, 1.0, 1.0, 1.0);
    return out;
}

