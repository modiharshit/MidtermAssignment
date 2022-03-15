

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

constant float _138 = {};

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

fragment MainPS_out Main_00003159_b6708a42(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _191 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _138, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _196 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _201 = (_196.xyz / float3(_196.w)) - View.View_PreViewTranslation;
    float3 _209 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _223 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _233 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _240 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_223.x + 0.5) * ((_228.x + 0.5) * (_233.x + 0.5)))), float3(0.0), float3(1.0));
    float _244 = (0.4000000059604644775390625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    uint _246 = _245 + 20u;
    float _295;
    float _296;
    float _297;
    float3 _298;
    float3 _299;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_191.xy / float2(_191.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        _295 = (_244 * _284) + _274.z;
        _296 = (0.5 * _284) + _274.y;
        _297 = _284 + _274.x;
        _298 = (_240 * _268.w) + _268.xyz;
        _299 = normalize((_209 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _295 = _244;
        _296 = 0.5;
        _297 = 1.0;
        _298 = _240;
        _299 = _209;
    }
    float3 _314 = ((_298 - (_298 * _297)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _321 = (mix(float3(0.07999999821186065673828125 * _296), _298, float3(_297)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _324 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _329;
    if (_324)
    {
        _329 = _314 + (_321 * 0.449999988079071044921875);
    }
    else
    {
        _329 = _314;
    }
    float3 _331 = select(_321, float3(0.0), bool3(_324));
    float3 _333 = float3(dot(_331, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _348 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _353 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _348);
    float4 _355 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_348 + float2(0.0, 0.5)));
    uint _361 = in.in_var_LIGHTMAP_ID * 15u;
    uint _362 = _361 + 4u;
    uint _367 = _361 + 6u;
    float3 _372 = _353.xyz;
    float3 _400 = ((((_372 * _372) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _362)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367)].xyz) * ((exp2(((_353.w + ((_355.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _362)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _367)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_355 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _361 + 7u)], float4(_299.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _422 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _451;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _450;
        if (any(abs(_201 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _450 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_201, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _450 = _422;
        }
        _451 = _450;
    }
    else
    {
        _451 = _422;
    }
    float4 _458 = float4(((mix(float3(0.0), _329 + (_331 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_400 * _329) * fast::max(float3(1.0), ((((((_298 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_298 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_298 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _451) * 1.0, 0.0);
    float4 _465;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _464 = _458;
        _464.w = 0.0;
        _465 = _464;
    }
    else
    {
        _465 = _458;
    }
    float2 _469 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _477 = (_299 * 0.5) + float3(0.5);
    float4 _479 = float4(_477.x, _477.y, _477.z, float4(0.0).w);
    _479.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _480 = float4(0.0);
    _480.x = _297;
    float4 _481 = _480;
    _481.y = _296;
    float4 _482 = _481;
    _482.z = _295;
    float4 _483 = _482;
    _483.w = 0.75686275959014892578125;
    float4 _495 = float4(_298.x, _298.y, _298.z, float4(0.0).w);
    _495.w = ((log2(((dot(_400, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_469.xyx * _469.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _465 * View.View_PreExposure;
    out.out_var_SV_Target1 = _479;
    out.out_var_SV_Target2 = _483;
    out.out_var_SV_Target3 = _495;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

