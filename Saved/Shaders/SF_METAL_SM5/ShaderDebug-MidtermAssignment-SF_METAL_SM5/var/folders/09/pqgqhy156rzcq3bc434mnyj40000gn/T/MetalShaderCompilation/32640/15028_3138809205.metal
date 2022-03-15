

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
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

fragment MainPS_out Main_00003ab4_bb166d75(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float2 _218 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _224 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float2 _227 = (_224.xy * float2(2.0)) - float2(1.0);
    float2 _235 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _237 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float2 _240 = (_237.xy * float2(2.0)) - float2(1.0);
    float4 _252 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _257 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _259 = (_252.x + 0.5) * _257.x;
    float _261 = fast::min(fast::max(_259, 0.0), 1.0);
    float3 _264 = float3(_261);
    float4 _270 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _208.w;
                break;
            }
            else
            {
                float _281 = _208.z;
                _297 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _312 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_227, sqrt(fast::clamp(1.0 - dot(_227, _227), 0.0, 1.0)), 1.0).xyz, float4(_240, sqrt(fast::clamp(1.0 - dot(_240, _240), 0.0, 1.0)), 1.0).xyz, _264), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _270.x) + _297) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _324 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _218, bias(View.View_MaterialTextureMipBias));
    float4 _326 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _235, bias(View.View_MaterialTextureMipBias));
    float3 _336 = fast::clamp(mix(_324.xyz, _326.xyz, _264) * mix(0.60000002384185791015625, 1.0, _259), float3(0.0), float3(1.0));
    float _341 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _259 * mix(_324.w, _326.w, _261)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _342 = in.in_var_PRIMITIVE_ID * 36u;
    uint _343 = _342 + 20u;
    float _391;
    float _392;
    float _393;
    float3 _394;
    float3 _395;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _361 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _365 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float _381 = _371.w;
        _391 = (_341 * _381) + _371.z;
        _392 = (0.5 * _381) + _371.y;
        _393 = _371.x;
        _394 = (_336 * _365.w) + _365.xyz;
        _395 = normalize((_312 * _368.w) + ((_368.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _391 = _341;
        _392 = 0.5;
        _393 = 0.0;
        _394 = _336;
        _395 = _312;
    }
    float3 _410 = ((_394 - (_394 * _393)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _417 = (mix(float3(0.07999999821186065673828125 * _392), _394, float3(_393)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _420 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _425;
    if (_420)
    {
        _425 = _410 + (_417 * 0.449999988079071044921875);
    }
    else
    {
        _425 = _410;
    }
    float3 _427 = select(_417, float3(0.0), bool3(_420));
    float3 _429 = float3(dot(_427, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _444 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _449 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _444);
    float4 _451 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_444 + float2(0.0, 0.5)));
    uint _457 = in.in_var_LIGHTMAP_ID * 15u;
    uint _458 = _457 + 4u;
    uint _463 = _457 + 6u;
    float3 _468 = _449.xyz;
    float3 _496 = ((((_468 * _468) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].xyz) * ((exp2(((_449.w + ((_451.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _458)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _463)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_451 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _457 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _457 + 7u)], float4(_395.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _518 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _547;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _546;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 19u)].xyz + float3(1.0))))
        {
            _546 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _546 = _518;
        }
        _547 = _546;
    }
    else
    {
        _547 = _518;
    }
    float4 _554 = float4(((mix(float3(0.0), _425 + (_427 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_496 * _425) * fast::max(float3(1.0), ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _547) * 1.0, 0.0);
    float4 _561;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _560 = _554;
        _560.w = 0.0;
        _561 = _560;
    }
    else
    {
        _561 = _554;
    }
    float2 _565 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _573 = (_395 * 0.5) + float3(0.5);
    float4 _575 = float4(_573.x, _573.y, _573.z, float4(0.0).w);
    _575.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].y;
    float4 _576 = float4(0.0);
    _576.x = _393;
    float4 _577 = _576;
    _577.y = _392;
    float4 _578 = _577;
    _578.z = _391;
    float4 _579 = _578;
    _579.w = 0.75686275959014892578125;
    float4 _591 = float4(_394.x, _394.y, _394.z, float4(0.0).w);
    _591.w = ((log2(((dot(_496, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_429 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_429 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_429 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_565.xyx * _565.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _561 * View.View_PreExposure;
    out.out_var_SV_Target1 = _575;
    out.out_var_SV_Target2 = _579;
    out.out_var_SV_Target3 = _591;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

