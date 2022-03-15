

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
    float4 in_var_TEXCOORD4 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
    uint in_var_LIGHTMAP_ID [[user(locn5)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003d29_4990fd9b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _213 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _217 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _222 = (_217.xyz / float3(_217.w)) - View.View_PreViewTranslation;
    float2 _223 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _229 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float2 _232 = (_229.xy * float2(2.0)) - float2(1.0);
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_232, sqrt(fast::clamp(1.0 - dot(_232, _232), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_223 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _263 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _268 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_263 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_263 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _300;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _300 = _213.w;
                break;
            }
            else
            {
                float _284 = _213.z;
                _300 = ((_284 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_284 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _308 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _311 = mix(_268.x + 0.5, _273.x + 0.5, fast::min(fast::max((_300 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_308.x + 0.5);
    float4 _316 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _223, bias(View.View_MaterialTextureMipBias));
    float3 _335 = fast::clamp(fast::min(fast::max(((_316.xyz * mix(0.60000002384185791015625, 1.0, _311)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _260.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _336 = fast::clamp(_329.y, 0.0, 1.0);
    float _341 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _329.x + (_311 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _342 = in.in_var_PRIMITIVE_ID * 36u;
    uint _343 = _342 + 20u;
    float _391;
    float _392;
    float _393;
    float3 _394;
    float3 _395;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _361 = ((_213.xy / float2(_213.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _365 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _361, level(0.0));
        float _381 = _371.w;
        _391 = (_341 * _381) + _371.z;
        _392 = (0.5 * _381) + _371.y;
        _393 = _371.x;
        _394 = (_335 * _365.w) + _365.xyz;
        _395 = normalize((_248 * _368.w) + ((_368.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _391 = _341;
        _392 = 0.5;
        _393 = 0.0;
        _394 = _335;
        _395 = _248;
    }
    float4 _402 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _403 = in.in_var_LIGHTMAP_ID * 15u;
    uint _404 = _403 + 1u;
    float4 _411 = fast::clamp((_402 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _404)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _428 = ((_394 - (_394 * _393)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _435 = (mix(float3(0.07999999821186065673828125 * _392), _394, float3(_393)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _438 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _443;
    if (_438)
    {
        _443 = _428 + (_435 * 0.449999988079071044921875);
    }
    else
    {
        _443 = _428;
    }
    float3 _445 = select(_435, float3(0.0), bool3(_438));
    float3 _447 = float3(dot(_445, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _454 = float3(_336);
    float2 _463 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _467 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _463);
    float4 _469 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_463 + float2(0.0, 0.5)));
    uint _475 = _403 + 4u;
    uint _480 = _403 + 6u;
    float3 _485 = _467.xyz;
    float3 _513 = ((((_485 * _485) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _475)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _480)].xyz) * ((exp2(((_467.w + ((_469.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _475)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _480)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_469 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403 + 7u)], float4(_395.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _535 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _564;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _563;
        if (any(abs(_222 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _342 + 19u)].xyz + float3(1.0))))
        {
            _563 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_222, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _563 = _535;
        }
        _564 = _563;
    }
    else
    {
        _564 = _535;
    }
    float4 _571 = float4(((mix(float3(0.0), _443 + (_445 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_513 * _443) * fast::max(_454, ((((((_394 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _336) + ((_394 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _336) + ((_394 * 2.755199909210205078125) + float3(0.69029998779296875))) * _336))) + _564) * 1.0, 0.0);
    float4 _578;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _577 = _571;
        _577.w = 0.0;
        _578 = _577;
    }
    else
    {
        _578 = _571;
    }
    float2 _582 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _590 = (_395 * 0.5) + float3(0.5);
    float4 _592 = float4(_590.x, _590.y, _590.z, float4(0.0).w);
    _592.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _343)].y;
    float4 _593 = float4(0.0);
    _593.x = _393;
    float4 _594 = _593;
    _594.y = _392;
    float4 _595 = _594;
    _595.z = _391;
    float4 _596 = _595;
    _596.w = 0.50588238239288330078125;
    float4 _608 = float4(_394.x, _394.y, _394.z, float4(0.0).w);
    _608.w = ((log2(((dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_454, ((((((_447 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _336) + ((_447 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _336) + ((_447 * 2.755199909210205078125) + float3(0.69029998779296875))) * _336).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_582.xyx * _582.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _578 * View.View_PreExposure;
    out.out_var_SV_Target1 = _592;
    out.out_var_SV_Target2 = _596;
    out.out_var_SV_Target3 = _608;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _403)] * _411) * _411;
    return out;
}

