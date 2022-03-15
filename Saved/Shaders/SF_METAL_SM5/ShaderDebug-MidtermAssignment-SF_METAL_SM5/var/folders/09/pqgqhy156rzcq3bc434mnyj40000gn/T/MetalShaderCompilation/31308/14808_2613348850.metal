

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
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

constant float _150 = {};

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

fragment MainPS_out Main_000039d8_9bc489f2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _192 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _203 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _208 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _212 = _208.xyz / float3(_208.w);
    float3 _213 = _212 - View.View_PreViewTranslation;
    float2 _217 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _223 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _217, bias(View.View_MaterialTextureMipBias));
    float2 _229 = ((normalize(-_212) * _192).xy * ((0.00999999977648258209228515625 * _223.w) + (-0.008000000379979610443115234375))) + _217;
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float2 _236 = (_233.xy * float2(2.0)) - float2(1.0);
    float3 _252 = normalize(_192 * normalize((float4(_236, sqrt(fast::clamp(1.0 - dot(_236, _236), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _264 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _269 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _274 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _278 = (_264.x + 0.5) * ((_269.x + 0.5) * (_274.x + 0.5));
    float4 _281 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float4 _287 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _229, bias(View.View_MaterialTextureMipBias));
    float3 _292 = fast::clamp(_281.xyz * mix(0.5, 1.0, _278), float3(0.0), float3(1.0));
    float _293 = fast::clamp(_287.y, 0.0, 1.0);
    float _298 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _278 * _287.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _299 = in.in_var_PRIMITIVE_ID * 36u;
    uint _300 = _299 + 20u;
    float _348;
    float _349;
    float _350;
    float3 _351;
    float3 _352;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _318 = ((_203.xy / float2(_203.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _322 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _325 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float4 _328 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _318, level(0.0));
        float _338 = _328.w;
        _348 = (_298 * _338) + _328.z;
        _349 = (0.5 * _338) + _328.y;
        _350 = _328.x;
        _351 = (_292 * _322.w) + _322.xyz;
        _352 = normalize((_252 * _325.w) + ((_325.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _348 = _298;
        _349 = 0.5;
        _350 = 0.0;
        _351 = _292;
        _352 = _252;
    }
    float4 _359 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _360 = in.in_var_LIGHTMAP_ID * 15u;
    uint _361 = _360 + 1u;
    float4 _368 = fast::clamp((_359 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _385 = ((_351 - (_351 * _350)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _392 = (mix(float3(0.07999999821186065673828125 * _349), _351, float3(_350)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _395 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _400;
    if (_395)
    {
        _400 = _385 + (_392 * 0.449999988079071044921875);
    }
    else
    {
        _400 = _385;
    }
    float3 _402 = select(_392, float3(0.0), bool3(_395));
    float3 _404 = float3(dot(_402, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _411 = float3(_293);
    float2 _420 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _424 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _420);
    float4 _426 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_420 + float2(0.0, 0.5)));
    uint _432 = _360 + 4u;
    uint _437 = _360 + 6u;
    float3 _442 = _424.xyz;
    float3 _470 = ((((_442 * _442) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].xyz) * ((exp2(((_424.w + ((_426.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _432)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_426 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360 + 7u)], float4(_352.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _492 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _521;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _520;
        if (any(abs(_213 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _299 + 19u)].xyz + float3(1.0))))
        {
            _520 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_213, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _520 = _492;
        }
        _521 = _520;
    }
    else
    {
        _521 = _492;
    }
    float4 _528 = float4(((mix(float3(0.0), _400 + (_402 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_470 * _400) * fast::max(_411, ((((((_351 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _293) + ((_351 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _293) + ((_351 * 2.755199909210205078125) + float3(0.69029998779296875))) * _293))) + _521) * 1.0, 0.0);
    float4 _535;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _534 = _528;
        _534.w = 0.0;
        _535 = _534;
    }
    else
    {
        _535 = _528;
    }
    float2 _539 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _547 = (_352 * 0.5) + float3(0.5);
    float4 _549 = float4(_547.x, _547.y, _547.z, float4(0.0).w);
    _549.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _300)].y;
    float4 _550 = float4(0.0);
    _550.x = _350;
    float4 _551 = _550;
    _551.y = _349;
    float4 _552 = _551;
    _552.z = _348;
    float4 _553 = _552;
    _553.w = 0.50588238239288330078125;
    float4 _565 = float4(_351.x, _351.y, _351.z, float4(0.0).w);
    _565.w = ((log2(((dot(_470, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_411, ((((((_404 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _293) + ((_404 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _293) + ((_404 * 2.755199909210205078125) + float3(0.69029998779296875))) * _293).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_539.xyx * _539.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _535 * View.View_PreExposure;
    out.out_var_SV_Target1 = _549;
    out.out_var_SV_Target2 = _553;
    out.out_var_SV_Target3 = _565;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _360)] * _368) * _368;
    return out;
}

