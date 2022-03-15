

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m11_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m12_pad[48];
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

fragment MainPS_out Main_000029e3_10471142(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], texture2d<float> Material_Texture2D_2 [[texture(4)]], texture2d<float> Material_Texture2D_3 [[texture(5)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _169 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _174 = (_169.xyz / float3(_169.w)) - View.View_PreViewTranslation;
    float4 _180 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _183 = (_180.xy * float2(2.0)) - float2(1.0);
    float _187 = sqrt(fast::clamp(1.0 - dot(_183, _183), 0.0, 1.0));
    float3 _195 = float3(float4(_183, _187, 1.0).xy * (-1.0), _187);
    float3 _199 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _195)) - (_195 * 2.0);
    float4 _215 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _233 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _237 = float3(_215.x);
    float4 _242 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _246 = float3(_215.z);
    float3 _249 = float3(_215.w);
    float3 _264 = fast::clamp(mix(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_215.y)), _233.xyz * float3(0.2249999940395355224609375), _237), _242.xyz * float3(0.25), _246), float3(0.0), _249), float3(0.0), float3(1.0));
    float _265 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _246), float3(0.0), _249).x, 0.0, 1.0);
    uint _271 = in.in_var_PRIMITIVE_ID * 36u;
    uint _272 = _271 + 20u;
    float _322;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _272)].z > 0.0)
    {
        float3 _290 = fast::clamp((_174 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _301 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_290.x), int(_290.y), int(_290.z), 0).xyz), 0));
        _322 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_301.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_290 / float3(_301.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _322 = 1.0;
    }
    float3 _334 = ((_264 - (_264 * _265)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _341 = (mix(float3(0.039999999105930328369140625), _264, float3(_265)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _344 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _349;
    if (_344)
    {
        _349 = _334 + (_341 * 0.449999988079071044921875);
    }
    else
    {
        _349 = _334;
    }
    float3 _358 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _387;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _386;
        if (any(abs(_174 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _271 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _271 + 19u)].xyz + float3(1.0))))
        {
            _386 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_174, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _386 = _358;
        }
        _387 = _386;
    }
    else
    {
        _387 = _358;
    }
    float4 _393 = float4((mix(float3(0.0), _349 + (select(_341, float3(0.0), bool3(_344)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _387) * 1.0, 0.0);
    float4 _400;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _399 = _393;
        _399.w = 0.0;
        _400 = _399;
    }
    else
    {
        _400 = _393;
    }
    float2 _405 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _413 = ((normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_199 / float3(sqrt(dot(_199, _199)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0) * 0.5) + float3(0.5);
    float4 _415 = float4(_413.x, _413.y, _413.z, float4(0.0).w);
    _415.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _272)].y;
    float4 _416 = float4(0.0);
    _416.x = _265;
    float4 _417 = _416;
    _417.y = 0.5;
    float4 _418 = _417;
    _418.z = (fast::clamp(mix(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.550000011920928955078125, 0.75, _233.x)), _237), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _242.x)), _246), float3(0.100000001490116119384765625), _249).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _419 = _418;
    _419.w = 0.50588238239288330078125;
    float4 _422 = float4(_264.x, _264.y, _264.z, float4(0.0).w);
    _422.w = (fract(dot(_405.xyx * _405.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _400 * View.View_PreExposure;
    out.out_var_SV_Target1 = _415;
    out.out_var_SV_Target2 = _419;
    out.out_var_SV_Target3 = _422;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_322, 1.0, 1.0, 1.0);
    return out;
}

