

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
    char _m1_pad[320];
    float4x4 View_ViewToClip;
    char _m2_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m3_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m5_pad[48];
    float3 View_PreViewTranslation;
    char _m6_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m8_pad[68];
    float View_PreExposure;
    char _m9_pad[72];
    float View_OutOfBoundsMask;
    char _m10_pad[48];
    float View_MaterialTextureMipBias;
    char _m11_pad[1024];
    float3 View_VolumetricFogInvGridSize;
    float3 View_VolumetricFogGridZParams;
};

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
};

struct type_TranslucentBasePass
{
    char _m0_pad[1836];
    float TranslucentBasePass_Shared_Fog_ApplyVolumetricFog;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

struct MainPS_out
{
    float4 out_var_SV_Target0 [[color(0)]];
};

struct MainPS_in
{
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD1 [[user(locn2), flat]];
    float4 in_var_TEXCOORD2 [[user(locn3)]];
    float4 in_var_TEXCOORD3_0 [[user(locn4)]];
    float4 in_var_PARTICLE_SUBUVS [[user(locn5)]];
    float4 in_var_TEXCOORD7 [[user(locn6)]];
};

fragment MainPS_out Main_0000208e_e416c6dc(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_TranslucentBasePass& TranslucentBasePass [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<float> TranslucentBasePass_Shared_Fog_IntegratedLightScattering [[texture(0)]], texture2d<float> TranslucentBasePass_SceneTextures_SceneDepthTexture [[texture(1)]], texture2d<float> Material_Texture2D_0 [[texture(2)]], texture2d<float> Material_Texture2D_1 [[texture(3)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler TranslucentBasePass_SceneTextures_PointClampSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _140 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _144 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _149 = (_144.xyz / float3(_144.w)) - View.View_PreViewTranslation;
    float4 _159 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, ((float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 6.0) + float2(in.in_var_TEXCOORD1.x)), bias(View.View_MaterialTextureMipBias));
    float4 _167 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.xy);
    float4 _169 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, in.in_var_PARTICLE_SUBUVS.zw);
    float4 _171 = mix(_167, _169, float4(in.in_var_TEXCOORD10.w));
    float _186 = _171.x;
    float _197 = _140.w;
    float4 _207 = TranslucentBasePass_SceneTextures_SceneDepthTexture.sample(TranslucentBasePass_SceneTextures_PointClampSampler, (((_140.xy / float2(_197)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz), level(0.0));
    float _208 = _207.x;
    float _238;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _238 = _197;
                break;
            }
            else
            {
                float _231 = _140.z;
                _238 = ((_231 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_231 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _244 = fast::clamp(fast::min(fast::max(fast::min(fast::max((_186 <= 0.0) ? 0.0 : pow(_186, in.in_var_TEXCOORD1.y + 1.0), 0.0), 1.0) * in.in_var_TEXCOORD2.w, 0.0), 1.0) * fast::min(fast::max(((((_208 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_208 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w))) - _238) * 0.01666666753590106964111328125, 0.0), 1.0), 0.0, 1.0);
    bool _247 = TranslucentBasePass.TranslucentBasePass_Shared_Fog_ApplyVolumetricFog > 0.0;
    float4 _296;
    if (_247)
    {
        float4 _254 = View.View_WorldToClip * float4(_149, 1.0);
        float _255 = _254.w;
        float4 _284;
        if (_247)
        {
            _284 = TranslucentBasePass_Shared_Fog_IntegratedLightScattering.sample(View_SharedBilinearClampedSampler, float3(((_254.xy / float2(_255)).xy * float2(0.5, -0.5)) + float2(0.5), (log2((_255 * View.View_VolumetricFogGridZParams.x) + View.View_VolumetricFogGridZParams.y) * View.View_VolumetricFogGridZParams.z) * View.View_VolumetricFogInvGridSize.z), level(0.0));
        }
        else
        {
            _284 = float4(0.0, 0.0, 0.0, 1.0);
        }
        _296 = float4(_284.xyz + (in.in_var_TEXCOORD7.xyz * _284.w), _284.w * in.in_var_TEXCOORD7.w);
    }
    else
    {
        _296 = in.in_var_TEXCOORD7;
    }
    float3 _297 = fast::max(mix((float3(fast::min(fast::max(mix(-0.20000000298023223876953125, 1.0, _159.x), 0.0), 1.0)) + _171.xyz) * in.in_var_TEXCOORD2.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float _324;
    float3 _325;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        bool _312 = any(abs(_149 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0)));
        float3 _322;
        if (_312)
        {
            _322 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_149, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _322 = _297;
        }
        _324 = _312 ? 1.0 : _244;
        _325 = _322;
    }
    else
    {
        _324 = _244;
        _325 = _297;
    }
    float4 _333 = float4((_325 * _296.w) + _296.xyz, _324);
    float3 _337 = _333.xyz * View.View_PreExposure;
    out.out_var_SV_Target0 = float4(_337.x, _337.y, _337.z, _333.w);
    return out;
}

