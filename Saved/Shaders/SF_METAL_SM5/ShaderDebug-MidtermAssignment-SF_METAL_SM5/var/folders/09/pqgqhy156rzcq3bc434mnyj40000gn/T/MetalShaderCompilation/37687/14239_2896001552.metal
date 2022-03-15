

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

fragment MainPS_out Main_0000379f_ac9d7a10(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _199 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _146, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _204 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _209 = (_204.xyz / float3(_204.w)) - View.View_PreViewTranslation;
    float4 _215 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _218 = (_215.xy * float2(2.0)) - float2(1.0);
    float _225 = sqrt(fast::clamp(1.0 - dot(_218, _218), 0.0, 1.0)) + 1.0;
    float2 _226 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _230 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float2 _233 = (_230.xy * float2(2.0)) - float2(1.0);
    float _237 = sqrt(fast::clamp(1.0 - dot(_233, _233), 0.0, 1.0));
    float3 _243 = float3(_218, _225);
    float3 _246 = float3(float4(_233, _237, 1.0).xy * (-1.0), _237);
    float3 _258 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_243 * dot(_243, _246)) - (_246 * _225)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _269 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _226, bias(View.View_MaterialTextureMipBias));
    float4 _273 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _278 = fast::clamp(_269.xyz, float3(0.0), float3(1.0));
    float _279 = fast::clamp(_273.x, 0.0, 1.0);
    float _284 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _285 = in.in_var_PRIMITIVE_ID * 36u;
    uint _286 = _285 + 20u;
    float _334;
    float _335;
    float _336;
    float3 _337;
    float3 _338;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _304 = ((_199.xy / float2(_199.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _308 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float4 _314 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _304, level(0.0));
        float _324 = _314.w;
        _334 = (_284 * _324) + _314.z;
        _335 = (0.5 * _324) + _314.y;
        _336 = _314.x;
        _337 = (_278 * _308.w) + _308.xyz;
        _338 = normalize((_258 * _311.w) + ((_311.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _334 = _284;
        _335 = 0.5;
        _336 = 0.0;
        _337 = _278;
        _338 = _258;
    }
    float4 _345 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _346 = in.in_var_LIGHTMAP_ID * 15u;
    uint _347 = _346 + 1u;
    float4 _354 = fast::clamp((_345 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _347)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _347)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _371 = ((_337 - (_337 * _336)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _378 = (mix(float3(0.07999999821186065673828125 * _335), _337, float3(_336)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _381 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _386;
    if (_381)
    {
        _386 = _371 + (_378 * 0.449999988079071044921875);
    }
    else
    {
        _386 = _371;
    }
    float3 _388 = select(_378, float3(0.0), bool3(_381));
    float3 _390 = float3(dot(_388, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _397 = float3(_279);
    float2 _406 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _410 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _406);
    float4 _412 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_406 + float2(0.0, 0.5)));
    uint _418 = _346 + 4u;
    uint _423 = _346 + 6u;
    float3 _428 = _410.xyz;
    float3 _456 = ((((_428 * _428) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _423)].xyz) * ((exp2(((_410.w + ((_412.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _418)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _423)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_412 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346 + 7u)], float4(_338.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _478 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _507;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _506;
        if (any(abs(_209 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285 + 19u)].xyz + float3(1.0))))
        {
            _506 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_209, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _506 = _478;
        }
        _507 = _506;
    }
    else
    {
        _507 = _478;
    }
    float4 _514 = float4(((mix(float3(0.0), _386 + (_388 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_456 * _386) * fast::max(_397, ((((((_337 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _279) + ((_337 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _279) + ((_337 * 2.755199909210205078125) + float3(0.69029998779296875))) * _279))) + _507) * 1.0, 0.0);
    float4 _521;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _520 = _514;
        _520.w = 0.0;
        _521 = _520;
    }
    else
    {
        _521 = _514;
    }
    float2 _525 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _533 = (_338 * 0.5) + float3(0.5);
    float4 _535 = float4(_533.x, _533.y, _533.z, float4(0.0).w);
    _535.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _286)].y;
    float4 _536 = float4(0.0);
    _536.x = _336;
    float4 _537 = _536;
    _537.y = _335;
    float4 _538 = _537;
    _538.z = _334;
    float4 _539 = _538;
    _539.w = 0.50588238239288330078125;
    float4 _551 = float4(_337.x, _337.y, _337.z, float4(0.0).w);
    _551.w = ((log2(((dot(_456, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_397, ((((((_390 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _279) + ((_390 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _279) + ((_390 * 2.755199909210205078125) + float3(0.69029998779296875))) * _279).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_525.xyx * _525.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _521 * View.View_PreExposure;
    out.out_var_SV_Target1 = _535;
    out.out_var_SV_Target2 = _539;
    out.out_var_SV_Target3 = _551;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _346)] * _354) * _354;
    return out;
}

