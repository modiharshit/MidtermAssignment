

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

constant float3 _151 = {};
constant float _152 = {};

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

fragment MainPS_out Main_00003bcb_600c3988(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _195 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _152, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _215 = _211.xyz / float3(_211.w);
    float3 _216 = _215 - View.View_PreViewTranslation;
    float4 _225 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _231 = ((normalize(-_215) * _195).xy * ((0.0599999986588954925537109375 * _225.x) + (-0.021600000560283660888671875))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _235 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _231, bias(View.View_MaterialTextureMipBias));
    float2 _238 = (_235.xy * float2(2.0)) - float2(1.0);
    float3 _254 = normalize(_195 * normalize((float4(_238, sqrt(fast::clamp(1.0 - dot(_238, _238), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _266 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125), bias(View.View_MaterialTextureMipBias));
    float4 _271 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0030000000260770320892333984375), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _231, bias(View.View_MaterialTextureMipBias));
    float _287 = _284.w;
    float3 _292 = fast::clamp(_284.xyz * ((_266.x + 0.5) * ((_271.x + 0.5) * (_276.x + 0.5))), float3(0.0), float3(1.0));
    float _293 = fast::clamp(_287 * 4.0, 0.0, 1.0);
    float _298 = (fast::clamp(fast::min(fast::max(mix(1.0, -1.75, _287), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _299 = in.in_var_PRIMITIVE_ID * 36u;
    uint _300 = _299 + 20u;
    float _348;
    float _349;
    float _350;
    float3 _351;
    float3 _352;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _318 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _322 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float _338 = _328.w;
        _348 = (_298 * _338) + _328.z;
        _349 = (_293 * _338) + _328.y;
        _350 = _328.x;
        _351 = (_292 * _322.w) + _322.xyz;
        _352 = normalize((_254 * _325.w) + ((_325.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _348 = _298;
        _349 = _293;
        _350 = 0.0;
        _351 = _292;
        _352 = _254;
    }
    float3 _367 = ((_351 - (_351 * _350)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.07999999821186065673828125 * _349), _351, float3(_350)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _401 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _406 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _401);
    float4 _408 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_401 + float2(0.0, 0.5)));
    uint _410 = in.in_var_LIGHTMAP_ID * 15u;
    float3 _420 = (_406.xyz * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410 + 4u)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410 + 6u)].xyz;
    float _421 = dot(_420, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375));
    float _440 = (exp2((_421 * 16.0) - 8.0) - 0.00390625) * fast::max(0.0, dot((_408 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _410 + 7u)], float4(_352.yzx, 1.0)));
    float4 _451 = float4(_352, 1.0);
    float3 _455 = _151;
    _455.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _451);
    float3 _459 = _455;
    _459.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _451);
    float3 _463 = _459;
    _463.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _451);
    float4 _466 = _451.xyzz * _451.yzzx;
    float3 _470 = _151;
    _470.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _466);
    float3 _474 = _470;
    _474.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _466);
    float3 _478 = _474;
    _478.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _466);
    float3 _492 = (float4(_420 * (_440 / _421), _440).xyz * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_463 + _478) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_352.x * _352.x) - (_352.y * _352.y)))) * View.View_SkyLightColor.xyz) * 1.0);
    float3 _514 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _543;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _542;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 19u)].xyz + float3(1.0))))
        {
            _542 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _542 = _514;
        }
        _543 = _542;
    }
    else
    {
        _543 = _514;
    }
    float4 _550 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_492 * _382) * fast::max(float3(1.0), ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _543) * 1.0, 0.0);
    float4 _557;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _556 = _550;
        _556.w = 0.0;
        _557 = _556;
    }
    else
    {
        _557 = _550;
    }
    float2 _561 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _569 = (_352 * 0.5) + float3(0.5);
    float4 _571 = float4(_569.x, _569.y, _569.z, float4(0.0).w);
    _571.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].y;
    float4 _572 = float4(0.0);
    _572.x = _350;
    float4 _573 = _572;
    _573.y = _349;
    float4 _574 = _573;
    _574.z = _348;
    float4 _575 = _574;
    _575.w = 0.75686275959014892578125;
    float4 _587 = float4(_351.x, _351.y, _351.z, float4(0.0).w);
    _587.w = ((log2(((dot(_492, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_561.xyx * _561.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _557 * View.View_PreExposure;
    out.out_var_SV_Target1 = _571;
    out.out_var_SV_Target2 = _575;
    out.out_var_SV_Target3 = _587;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

