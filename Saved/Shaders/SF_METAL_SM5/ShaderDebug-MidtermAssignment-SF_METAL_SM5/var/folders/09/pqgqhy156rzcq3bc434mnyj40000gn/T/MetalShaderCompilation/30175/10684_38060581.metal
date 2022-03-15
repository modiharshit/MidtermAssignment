

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float _117 = {};

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

fragment MainPS_out Main_000029bc_0244c225(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float2 _163 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _169 = float4((_163 - float2(0.5)) * float2(2.0, -2.0), _117, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _174 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _179 = (_174.xyz / float3(_174.w)) - View.View_PreViewTranslation;
    float3 _187 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _194 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_163 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _195 = _194.xyz;
    float3 _203 = fast::clamp(_195, float3(0.0), float3(1.0));
    float _207 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _208 = in.in_var_PRIMITIVE_ID * 36u;
    uint _209 = _208 + 20u;
    float _257;
    float _258;
    float _259;
    float3 _260;
    float3 _261;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _227 = ((_169.xy / float2(_169.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _231 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _234 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _237 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float _247 = _237.w;
        _257 = (_207 * _247) + _237.z;
        _258 = (0.5 * _247) + _237.y;
        _259 = _237.x;
        _260 = (_203 * _231.w) + _231.xyz;
        _261 = normalize((_187 * _234.w) + ((_234.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _257 = _207;
        _258 = 0.5;
        _259 = 0.0;
        _260 = _203;
        _261 = _187;
    }
    float _310;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].z > 0.0)
    {
        float3 _278 = fast::clamp((_179 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _289 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_278.x), int(_278.y), int(_278.z), 0).xyz), 0));
        _310 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_289.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_278 / float3(_289.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _310 = 1.0;
    }
    float3 _324 = ((_260 - (_260 * _259)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _331 = (mix(float3(0.07999999821186065673828125 * _258), _260, float3(_259)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _334 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _339;
    if (_334)
    {
        _339 = _324 + (_331 * 0.449999988079071044921875);
    }
    else
    {
        _339 = _324;
    }
    float3 _348 = fast::max(mix(_195, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _377;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _376;
        if (any(abs(_179 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 19u)].xyz + float3(1.0))))
        {
            _376 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_179, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _376 = _348;
        }
        _377 = _376;
    }
    else
    {
        _377 = _348;
    }
    float4 _383 = float4((mix(float3(0.0), _339 + (select(_331, float3(0.0), bool3(_334)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _377) * 1.0, 0.0);
    float4 _390;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _389 = _383;
        _389.w = 0.0;
        _390 = _389;
    }
    else
    {
        _390 = _383;
    }
    float2 _394 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _402 = (_261 * 0.5) + float3(0.5);
    float4 _404 = float4(_402.x, _402.y, _402.z, float4(0.0).w);
    _404.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].y;
    float4 _405 = float4(0.0);
    _405.x = _259;
    float4 _406 = _405;
    _406.y = _258;
    float4 _407 = _406;
    _407.z = _257;
    float4 _408 = _407;
    _408.w = 0.50588238239288330078125;
    float4 _411 = float4(_260.x, _260.y, _260.z, float4(0.0).w);
    _411.w = (fract(dot(_394.xyx * _394.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _390 * View.View_PreExposure;
    out.out_var_SV_Target1 = _404;
    out.out_var_SV_Target2 = _408;
    out.out_var_SV_Target3 = _411;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_310, 1.0, 1.0, 1.0);
    return out;
}

