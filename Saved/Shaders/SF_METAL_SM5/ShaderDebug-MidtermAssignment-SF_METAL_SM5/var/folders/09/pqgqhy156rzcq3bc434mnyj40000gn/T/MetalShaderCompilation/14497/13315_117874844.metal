

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
    char _m0_pad[64];
    float4x4 View_WorldToClip;
    char _m1_pad[576];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[352];
    float3 View_PreViewTranslation;
    char _m3_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    char _m7_pad[16];
    float View_OutOfBoundsMask;
    char _m8_pad[24];
    float View_CullingSign;
    char _m9_pad[52];
    float View_UnlitViewmodeMask;
    char _m10_pad[32];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeMin;
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
    char _m12_pad[508];
    float View_RenderingReflectionCaptureMask;
    char _m13_pad[48];
    float4 View_SkyLightColor;
    char _m14_pad[320];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_TranslucentSelfShadow
{
    float4x4 TranslucentSelfShadow_WorldToShadowMatrix;
    float4 TranslucentSelfShadow_ShadowUVMinMax;
    char _m2_pad[16];
    float4 TranslucentSelfShadow_DirectionalLightColor;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float3 _133 = {};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    float4 in_var_TEXCOORD7 [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003403_0706a09c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(3)]], constant type_TranslucentSelfShadow& TranslucentSelfShadow [[buffer(4)]], constant type_Material& Material [[buffer(5)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientInner [[texture(1)]], texture3d<float> TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter [[texture(2)]], texture2d<float> TranslucentSelfShadow_Transmission0 [[texture(3)]], texture2d<float> TranslucentSelfShadow_Transmission1 [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler Material_Texture2D_0Sampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _175 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _180 = (_175.xyz / float3(_175.w)) - View.View_PreViewTranslation;
    uint _181 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _197 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _181 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _208 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float3 _213 = float3(in_var_TEXCOORD0[0].xy, 0.0);
    float3 _214 = dfdx(_213);
    float _215 = dot(_214, _214);
    float3 _216 = dfdy(_213);
    float _217 = dot(_216, _216);
    float _225 = 1.0 / sqrt((abs(_215 - _217) > 9.9999997473787516355514526367188e-06) ? ((_215 >= _217) ? _215 : _217) : _217);
    float3 _234 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _235 = fast::clamp((((_208.x + (-0.5)) * mix(0.0, 0.0500000007450580596923828125, _225)) + 0.5) * fast::min(fast::max(mix(0.0, 0.004999999888241291046142578125, _225), 0.0), 1.0), 0.0, 1.0);
    float3 _242 = (_234 * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _249 = (float3(0.039999999105930328369140625) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _252 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _257;
    if (_252)
    {
        _257 = _242 + (_249 * 0.449999988079071044921875);
    }
    else
    {
        _257 = _242;
    }
    float _260 = _197.x;
    float _261 = _197.y;
    float4 _263 = float4(_260, _261, _197.z, 1.0);
    float3 _267 = _133;
    _267.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _263);
    float3 _271 = _267;
    _271.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _263);
    float3 _275 = _271;
    _275.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _263);
    float4 _278 = _263.xyzz * _263.yzzx;
    float3 _282 = _133;
    _282.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _278);
    float3 _286 = _282;
    _286.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _278);
    float3 _290 = _286;
    _290.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _278);
    bool _320 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _369;
    if (_320)
    {
        float4 _327 = View.View_WorldToClip * float4(_180, 1.0);
        float _328 = _327.w;
        float4 _357;
        if (_320)
        {
            _357 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_327.xy / float2(_328)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_328 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _357 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _369 = float4(_357.xyz + (in.in_var_TEXCOORD7.xyz * _357.w), _357.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _369 = in.in_var_TEXCOORD7;
    }
    float3 _377 = (_180 - View.View_TranslucencyLightingVolumeMin[0].xyz) * View.View_TranslucencyLightingVolumeInvSize[0].xyz;
    float3 _390 = fast::clamp((float3(0.5) - abs(_377 - float3(0.5))) * 6.0, float3(0.0), float3(1.0));
    float4 _404 = mix(TranslucentBasePass_TranslucencyLightingVolumeAmbientOuter.sample(View_SharedBilinearClampedSampler, ((_180 - View.View_TranslucencyLightingVolumeMin[1].xyz) * View.View_TranslucencyLightingVolumeInvSize[1].xyz), level(0.0)), TranslucentBasePass_TranslucencyLightingVolumeAmbientInner.sample(View_SharedBilinearClampedSampler, _377, level(0.0)), float4((_390.x * _390.y) * _390.z));
    float _411 = _404.w;
    float3 _413 = float4(_404.x * 0.886227548122406005859375, _404.y * 0.886227548122406005859375, _404.z * 0.886227548122406005859375, _411).xyz;
    float3 _479;
    if (TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.w > 0.0)
    {
        float4 _427 = TranslucentSelfShadow.TranslucentSelfShadow_WorldToShadowMatrix * float4(_180, 1.0);
        float2 _431 = _427.xy / float2(_427.w);
        float _432 = _427.z;
        float4 _435 = TranslucentSelfShadow_Transmission0.sample(View_SharedBilinearClampedSampler, _431, level(0.0));
        float3 _439 = float3(6.283185482025146484375, 12.56637096405029296875, 18.84955596923828125) * _432;
        bool2 _464 = _431 < TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.xy;
        bool2 _466 = _431 > TranslucentSelfShadow.TranslucentSelfShadow_ShadowUVMinMax.zw;
        _479 = _257 * fast::max(_413 - ((TranslucentSelfShadow.TranslucentSelfShadow_DirectionalLightColor.xyz * _411) * (float3(1.0) - select(fast::clamp(exp((float3((((_435.x * _432) * 0.5) + dot((sin(_439) * _435.yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) + dot(((float3(1.0) - cos(_439)) * TranslucentSelfShadow_Transmission1.sample(View_SharedBilinearClampedSampler, _431, level(0.0)).yzw) * float3(0.1566874682903289794921875, 0.0747561156749725341796875, 0.046092070639133453369140625), float3(1.0))) * float3(-1.0, -1.2004802227020263671875, -1.700680255889892578125)) * 2.0), float3(0.0), float3(1.0)), float3(1.0), bool3(any(bool2(_464.x || _466.x, _464.y || _466.y)))))), float3(0.0));
    }
    else
    {
        _479 = _257 * _413;
    }
    float3 _486 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _516;
    float3 _517;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _504 = any(abs(_180 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _181 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _181 + 19u)].xyz + float3(1.0)));
        float3 _514;
        if (_504)
        {
            _514 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_180, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _514 = _486;
        }
        _516 = _504 ? 1.0 : _235;
        _517 = _514;
    }
    else
    {
        _516 = _235;
        _517 = _486;
    }
    float4 _527 = float4((((mix(_479, _257 + (select(_249, float3(0.0), bool3(_252)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_275 + _290) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_260 * _260) - (_261 * _261)))) * View.View_SkyLightColor.xyz) * 1.0) * _257) * fast::max(float3(1.0), ((((((_234 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_234 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_234 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _517) * _369.w) + _369.xyz, _516);
    float3 _531 = _527.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_531.x, _531.y, _531.z, _527.w);
    return out;
}

