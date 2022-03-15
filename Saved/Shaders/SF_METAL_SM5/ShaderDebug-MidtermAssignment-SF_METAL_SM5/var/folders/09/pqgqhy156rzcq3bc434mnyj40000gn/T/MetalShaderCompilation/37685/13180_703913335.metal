

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float _142 = {};

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

fragment MainPS_out Main_0000337c_29f4dd77(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _194 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _142, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _199 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _204 = (_199.xyz / float3(_199.w)) - View.View_PreViewTranslation;
    float4 _210 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _213 = (_210.xy * float2(2.0)) - float2(1.0);
    float3 _229 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_213, sqrt(fast::clamp(1.0 - dot(_213, _213), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _240 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _247 = _240.y;
    float _253 = _240.z;
    float _256 = _240.x;
    float3 _274 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_247)), Material.Material_VectorExpressions[7].xyz, float3(_253)) * _256, float3(0.0), float3(1.0));
    float _275 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _247), Material.Material_ScalarExpressions[0].w, _253), 0.0, 1.0);
    float _276 = fast::clamp(_256, 0.0, 1.0);
    float _281 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _247), Material.Material_ScalarExpressions[1].z, _253), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _282 = in.in_var_PRIMITIVE_ID * 36u;
    uint _283 = _282 + 20u;
    float _333;
    float _334;
    float _335;
    float3 _336;
    float3 _337;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _301 = ((_194.xy / float2(_194.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _305 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _308 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float4 _311 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _301, level(0.0));
        float _321 = _311.w;
        _333 = (_281 * _321) + _311.z;
        _334 = (0.5 * _321) + _311.y;
        _335 = (_275 * _321) + _311.x;
        _336 = (_274 * _305.w) + _305.xyz;
        _337 = normalize((_229 * _308.w) + ((_308.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _333 = _281;
        _334 = 0.5;
        _335 = _275;
        _336 = _274;
        _337 = _229;
    }
    float3 _352 = ((_336 - (_336 * _335)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _359 = (mix(float3(0.07999999821186065673828125 * _334), _336, float3(_335)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _362 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _367;
    if (_362)
    {
        _367 = _352 + (_359 * 0.449999988079071044921875);
    }
    else
    {
        _367 = _352;
    }
    float3 _369 = select(_359, float3(0.0), bool3(_362));
    float3 _371 = float3(dot(_369, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _378 = float3(_276);
    float2 _387 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _392 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _387);
    float4 _394 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_387 + float2(0.0, 0.5)));
    uint _400 = in.in_var_LIGHTMAP_ID * 15u;
    uint _401 = _400 + 4u;
    uint _406 = _400 + 6u;
    float3 _411 = _392.xyz;
    float3 _439 = ((((_411 * _411) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _401)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406)].xyz) * ((exp2(((_392.w + ((_394.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _401)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _406)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_394 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _400 + 7u)], float4(_337.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _461 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _490;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _489;
        if (any(abs(_204 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _282 + 19u)].xyz + float3(1.0))))
        {
            _489 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_204, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _489 = _461;
        }
        _490 = _489;
    }
    else
    {
        _490 = _461;
    }
    float4 _497 = float4(((mix(float3(0.0), _367 + (_369 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_439 * _367) * fast::max(_378, ((((((_336 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _276) + ((_336 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _276) + ((_336 * 2.755199909210205078125) + float3(0.69029998779296875))) * _276))) + _490) * 1.0, 0.0);
    float4 _504;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _503 = _497;
        _503.w = 0.0;
        _504 = _503;
    }
    else
    {
        _504 = _497;
    }
    float2 _508 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _516 = (_337 * 0.5) + float3(0.5);
    float4 _518 = float4(_516.x, _516.y, _516.z, float4(0.0).w);
    _518.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _283)].y;
    float4 _519 = float4(0.0);
    _519.x = _335;
    float4 _520 = _519;
    _520.y = _334;
    float4 _521 = _520;
    _521.z = _333;
    float4 _522 = _521;
    _522.w = 0.75686275959014892578125;
    float4 _534 = float4(_336.x, _336.y, _336.z, float4(0.0).w);
    _534.w = ((log2(((dot(_439, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_378, ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _276) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _276) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * _276).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_508.xyx * _508.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _504 * View.View_PreExposure;
    out.out_var_SV_Target1 = _518;
    out.out_var_SV_Target2 = _522;
    out.out_var_SV_Target3 = _534;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

