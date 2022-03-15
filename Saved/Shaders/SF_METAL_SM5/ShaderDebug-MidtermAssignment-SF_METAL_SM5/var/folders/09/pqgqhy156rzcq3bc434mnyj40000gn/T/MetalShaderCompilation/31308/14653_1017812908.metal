

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
    char _m16_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
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

fragment MainPS_out Main_0000393d_3caa97ac(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    bool _288;
    float4 _197 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _201 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _206 = (_201.xyz / float3(_201.w)) - View.View_PreViewTranslation;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float _230 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _235 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _230) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float _250 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_250, _230) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_230, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _273 = (_270.xy * float2(2.0)) - float2(1.0);
    float _308;
    switch (0u)
    {
        default:
        {
            _288 = View.View_ViewToClip[3u].w < 1.0;
            if (_288)
            {
                _308 = _197.w;
                break;
            }
            else
            {
                float _292 = _197.z;
                _308 = ((_292 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_292 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _320 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_250, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _323 = (_320.xy * float2(2.0)) - float2(1.0);
    float4 _336 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _339 = (_336.xy * float2(2.0)) - float2(1.0);
    float _372;
    switch (0u)
    {
        default:
        {
            if (_288)
            {
                _372 = _197.w;
                break;
            }
            else
            {
                float _356 = _197.z;
                _372 = ((_356 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_356 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _386 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_221, sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0)), 1.0).xyz + (float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz + float4(_273, sqrt(fast::clamp(1.0 - dot(_273, _273), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_308 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_323, sqrt(fast::clamp(1.0 - dot(_323, _323), 0.0, 1.0)), 1.0).xyz + (float4(_339, sqrt(fast::clamp(1.0 - dot(_339, _339), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_372 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _397 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _401 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _402 = in.in_var_PRIMITIVE_ID * 36u;
    uint _403 = _402 + 20u;
    float _452;
    float _453;
    float _454;
    float3 _455;
    float3 _456;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _421 = ((_197.xy / float2(_197.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _425 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float4 _428 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float4 _431 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _421, level(0.0));
        float _441 = _431.w;
        _452 = (_401 * _441) + _431.z;
        _453 = (0.5 * _441) + _431.y;
        _454 = _441 + _431.x;
        _455 = (_397 * _425.w) + _425.xyz;
        _456 = normalize((_386 * _428.w) + ((_428.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _452 = _401;
        _453 = 0.5;
        _454 = 1.0;
        _455 = _397;
        _456 = _386;
    }
    float _505;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].z > 0.0)
    {
        float3 _473 = fast::clamp((_206 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _484 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_473.x), int(_473.y), int(_473.z), 0).xyz), 0));
        _505 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_484.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_473 / float3(_484.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _505 = 1.0;
    }
    float3 _519 = ((_455 - (_455 * _454)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _526 = (mix(float3(0.07999999821186065673828125 * _453), _455, float3(_454)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _529 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _534;
    if (_529)
    {
        _534 = _519 + (_526 * 0.449999988079071044921875);
    }
    else
    {
        _534 = _519;
    }
    float3 _543 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _572;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _571;
        if (any(abs(_206 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _402 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _402 + 19u)].xyz + float3(1.0))))
        {
            _571 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_206, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _571 = _543;
        }
        _572 = _571;
    }
    else
    {
        _572 = _543;
    }
    float4 _578 = float4((mix(float3(0.0), _534 + (select(_526, float3(0.0), bool3(_529)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _572) * 1.0, 0.0);
    float4 _585;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _584 = _578;
        _584.w = 0.0;
        _585 = _584;
    }
    else
    {
        _585 = _578;
    }
    float2 _589 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _597 = (_456 * 0.5) + float3(0.5);
    float4 _599 = float4(_597.x, _597.y, _597.z, float4(0.0).w);
    _599.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _403)].y;
    float4 _600 = float4(0.0);
    _600.x = _454;
    float4 _601 = _600;
    _601.y = _453;
    float4 _602 = _601;
    _602.z = _452;
    float4 _603 = _602;
    _603.w = 0.50588238239288330078125;
    float4 _606 = float4(_455.x, _455.y, _455.z, float4(0.0).w);
    _606.w = (fract(dot(_589.xyx * _589.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _585 * View.View_PreExposure;
    out.out_var_SV_Target1 = _599;
    out.out_var_SV_Target2 = _603;
    out.out_var_SV_Target3 = _606;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_505, 1.0, 1.0, 1.0);
    return out;
}

