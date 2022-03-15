

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
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

constant float _129 = {};

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
    float4 in_var_TEXCOORD4 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
    uint in_var_LIGHTMAP_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00002ceb_e73e5e27(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _178 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _129, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _183 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _188 = (_183.xyz / float3(_183.w)) - View.View_PreViewTranslation;
    float3 _196 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _207 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _208 = in.in_var_PRIMITIVE_ID * 36u;
    uint _209 = _208 + 20u;
    float _258;
    float _259;
    float _260;
    float3 _261;
    float3 _262;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _227 = ((_178.xy / float2(_178.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _231 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _234 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float4 _237 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _227, level(0.0));
        float _247 = _237.w;
        _258 = (_207 * _247) + _237.z;
        _259 = (0.5 * _247) + _237.y;
        _260 = _247 + _237.x;
        _261 = (float3(1.0) * _231.w) + _231.xyz;
        _262 = normalize((_196 * _234.w) + ((_234.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _258 = _207;
        _259 = 0.5;
        _260 = 1.0;
        _261 = float3(1.0);
        _262 = _196;
    }
    float3 _277 = ((_261 - (_261 * _260)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _284 = (mix(float3(0.07999999821186065673828125 * _259), _261, float3(_260)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _287 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _292;
    if (_287)
    {
        _292 = _277 + (_284 * 0.449999988079071044921875);
    }
    else
    {
        _292 = _277;
    }
    float3 _294 = select(_284, float3(0.0), bool3(_287));
    float3 _296 = float3(dot(_294, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _311 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _316 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _311);
    float4 _318 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_311 + float2(0.0, 0.5)));
    uint _324 = in.in_var_LIGHTMAP_ID * 15u;
    uint _325 = _324 + 4u;
    uint _330 = _324 + 6u;
    float3 _335 = _316.xyz;
    float3 _363 = ((((_335 * _335) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330)].xyz) * ((exp2(((_316.w + ((_318.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _325)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _330)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_318 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _324 + 7u)], float4(_262.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _385 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _414;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _413;
        if (any(abs(_188 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _208 + 19u)].xyz + float3(1.0))))
        {
            _413 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_188, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _413 = _385;
        }
        _414 = _413;
    }
    else
    {
        _414 = _385;
    }
    float4 _421 = float4(((mix(float3(0.0), _292 + (_294 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_363 * _292) * fast::max(float3(1.0), ((((((_261 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_261 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_261 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _414) * 1.0, 0.0);
    float4 _428;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _427 = _421;
        _427.w = 0.0;
        _428 = _427;
    }
    else
    {
        _428 = _421;
    }
    float2 _432 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _440 = (_262 * 0.5) + float3(0.5);
    float4 _442 = float4(_440.x, _440.y, _440.z, float4(0.0).w);
    _442.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _209)].y;
    float4 _443 = float4(0.0);
    _443.x = _260;
    float4 _444 = _443;
    _444.y = _259;
    float4 _445 = _444;
    _445.z = _258;
    float4 _446 = _445;
    _446.w = 0.75686275959014892578125;
    float4 _458 = float4(_261.x, _261.y, _261.z, float4(0.0).w);
    _458.w = ((log2(((dot(_363, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_432.xyx * _432.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _428 * View.View_PreExposure;
    out.out_var_SV_Target1 = _442;
    out.out_var_SV_Target2 = _446;
    out.out_var_SV_Target3 = _458;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

