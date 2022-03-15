

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000037ed_73d50b06(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _228 = (_225.xy * float2(2.0)) - float2(1.0);
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float _278;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _278 = _209.w;
                break;
            }
            else
            {
                float _262 = _209.z;
                _278 = ((_262 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_262 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _282 = fast::min(fast::max((_278 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _293 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_228, sqrt(fast::clamp(1.0 - dot(_228, _228), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_282))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _305 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _307 = mix(0.4000000059604644775390625, 1.0, _305.x);
    float _310 = mix(0.699999988079071044921875, 0.89999997615814208984375, _305.y);
    float4 _315 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _330 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_315.y + _282, 0.0), 1.0))) * mix(_307, 1.0 - _307, _310), float3(0.0), float3(1.0));
    float _335 = (fast::clamp(_307 * _310, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _336 = in.in_var_PRIMITIVE_ID * 36u;
    uint _337 = _336 + 20u;
    float _385;
    float _386;
    float _387;
    float3 _388;
    float3 _389;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _355 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _359 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _362 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _355, level(0.0));
        float _375 = _365.w;
        _385 = (_335 * _375) + _365.z;
        _386 = (0.5 * _375) + _365.y;
        _387 = _365.x;
        _388 = (_330 * _359.w) + _359.xyz;
        _389 = normalize((_293 * _362.w) + ((_362.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _385 = _335;
        _386 = 0.5;
        _387 = 0.0;
        _388 = _330;
        _389 = _293;
    }
    float3 _404 = ((_388 - (_388 * _387)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _411 = (mix(float3(0.07999999821186065673828125 * _386), _388, float3(_387)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _414 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _419;
    if (_414)
    {
        _419 = _404 + (_411 * 0.449999988079071044921875);
    }
    else
    {
        _419 = _404;
    }
    float3 _421 = select(_411, float3(0.0), bool3(_414));
    float3 _423 = float3(dot(_421, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _438 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _443 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _438);
    float4 _445 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_438 + float2(0.0, 0.5)));
    uint _447 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _457 = (_443.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447 + 6u)].xyz;
    float _458 = dot(_457, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _477 = (exp2((_458 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_445 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _447 + 7u)], float4(_389.yzx, 1.0)));
    float3 _487 = float4(_457 * (_477 / _458), _477).xyz * View.View_IndirectLightingColorScale;
    float3 _509 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _538;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _537;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _336 + 19u)].xyz + float3(1.0))))
        {
            _537 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _537 = _509;
        }
        _538 = _537;
    }
    else
    {
        _538 = _509;
    }
    float4 _545 = float4(((mix(float3(0.0), _419 + (_421 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_487 * _419) * fast::max(float3(1.0), ((((((_388 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_388 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_388 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _538) * 1.0, 0.0);
    float4 _552;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _551 = _545;
        _551.w = 0.0;
        _552 = _551;
    }
    else
    {
        _552 = _545;
    }
    float2 _556 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _564 = (_389 * 0.5) + float3(0.5);
    float4 _566 = float4(_564.x, _564.y, _564.z, float4(0.0).w);
    _566.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _337)].y;
    float4 _567 = float4(0.0);
    _567.x = _387;
    float4 _568 = _567;
    _568.y = _386;
    float4 _569 = _568;
    _569.z = _385;
    float4 _570 = _569;
    _570.w = 0.75686275959014892578125;
    float4 _582 = float4(_388.x, _388.y, _388.z, float4(0.0).w);
    _582.w = ((log2(((dot(_487, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_556.xyx * _556.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _552 * View.View_PreExposure;
    out.out_var_SV_Target1 = _566;
    out.out_var_SV_Target2 = _570;
    out.out_var_SV_Target3 = _582;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

