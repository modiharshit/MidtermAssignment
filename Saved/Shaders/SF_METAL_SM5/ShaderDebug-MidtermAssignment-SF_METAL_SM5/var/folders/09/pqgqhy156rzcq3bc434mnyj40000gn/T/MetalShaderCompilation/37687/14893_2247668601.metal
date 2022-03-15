

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
    char _m13_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m14_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m15_pad[48];
    float4 View_SkyLightColor;
    char _m16_pad[124];
    float View_ShowDecalsMask;
    char _m17_pad[184];
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

constant float3 _145 = {};
constant float _146 = {};

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

fragment MainPS_out Main_00003a2d_85f8b379(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float4 _200 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _205 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _210 = (_205.xyz / float3(_205.w)) - View.View_PreViewTranslation;
    float4 _216 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _219 = (_216.xy * float2(2.0)) - float2(1.0);
    float _226 = sqrt(fast::clamp(1.0 - dot(_219, _219), 0.0, 1.0)) + 1.0;
    float2 _227 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _231 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _227, bias(View.View_MaterialTextureMipBias));
    float2 _234 = (_231.xy * float2(2.0)) - float2(1.0);
    float _238 = sqrt(fast::clamp(1.0 - dot(_234, _234), 0.0, 1.0));
    float3 _244 = float3(_219, _226);
    float3 _247 = float3(float4(_234, _238, 1.0).xy * (-1.0), _238);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_244 * dot(_244, _247)) - (_247 * _226)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _227, bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _279 = fast::clamp(_270.xyz, float3(0.0), float3(1.0));
    float _280 = fast::clamp(_274.x, 0.0, 1.0);
    float _285 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _286 = in.in_var_PRIMITIVE_ID * 36u;
    uint _287 = _286 + 20u;
    float _335;
    float _336;
    float _337;
    float3 _338;
    float3 _339;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _305 = ((_200.xy / float2(_200.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _309 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _312 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float4 _315 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _305, level(0.0));
        float _325 = _315.w;
        _335 = (_285 * _325) + _315.z;
        _336 = (0.5 * _325) + _315.y;
        _337 = _315.x;
        _338 = (_279 * _309.w) + _309.xyz;
        _339 = normalize((_259 * _312.w) + ((_312.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _335 = _285;
        _336 = 0.5;
        _337 = 0.0;
        _338 = _279;
        _339 = _259;
    }
    float3 _354 = ((_338 - (_338 * _337)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _361 = (mix(float3(0.07999999821186065673828125 * _336), _338, float3(_337)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _364 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _369;
    if (_364)
    {
        _369 = _354 + (_361 * 0.449999988079071044921875);
    }
    else
    {
        _369 = _354;
    }
    float3 _371 = select(_361, float3(0.0), bool3(_364));
    float3 _373 = float3(dot(_371, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _380 = float3(_280);
    float2 _389 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _394 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _389);
    float4 _396 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_389 + float2(0.0, 0.5)));
    uint _398 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _408 = (_394.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398 + 6u)].xyz;
    float _409 = dot(_408, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _428 = (exp2((_409 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_396 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _398 + 7u)], float4(_339.yzx, 1.0)));
    float4 _439 = float4(_339, 1.0);
    float3 _443 = _145;
    _443.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _439);
    float3 _447 = _443;
    _447.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _439);
    float3 _451 = _447;
    _451.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _439);
    float4 _454 = _439.xyzz * _439.yzzx;
    float3 _458 = _145;
    _458.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _454);
    float3 _462 = _458;
    _462.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _454);
    float3 _466 = _462;
    _466.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _454);
    float3 _480 = (float4(_408 * (_428 / _409), _428).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_451 + _466) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_339.x * _339.x) - (_339.y * _339.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _502 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _531;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _530;
        if (any(abs(_210 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286 + 19u)].xyz + float3(1.0))))
        {
            _530 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_210, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _530 = _502;
        }
        _531 = _530;
    }
    else
    {
        _531 = _502;
    }
    float4 _538 = float4(((mix(float3(0.0), _369 + (_371 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_480 * _369) * fast::max(_380, ((((((_338 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_338 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_338 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280))) + _531) * 1.0, 0.0);
    float4 _545;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _544 = _538;
        _544.w = 0.0;
        _545 = _544;
    }
    else
    {
        _545 = _538;
    }
    float2 _549 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _557 = (_339 * 0.5) + float3(0.5);
    float4 _559 = float4(_557.x, _557.y, _557.z, float4(0.0).w);
    _559.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _287)].y;
    float4 _560 = float4(0.0);
    _560.x = _337;
    float4 _561 = _560;
    _561.y = _336;
    float4 _562 = _561;
    _562.z = _335;
    float4 _563 = _562;
    _563.w = 0.75686275959014892578125;
    float4 _575 = float4(_338.x, _338.y, _338.z, float4(0.0).w);
    _575.w = ((log2(((dot(_480, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_380, ((((((_373 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _280) + ((_373 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _280) + ((_373 * 2.755199909210205078125) + float3(0.69029998779296875))) * _280).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_549.xyx * _549.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _545 * View.View_PreExposure;
    out.out_var_SV_Target1 = _559;
    out.out_var_SV_Target2 = _563;
    out.out_var_SV_Target3 = _575;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

