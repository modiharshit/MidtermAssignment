

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
    char _m15_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m17_pad[124];
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

constant float3 _155 = {};
constant float _156 = {};

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

fragment MainPS_out Main_00004224_87515531(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_SkyOcclusionTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[2];
    float3x3 _200 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _216 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = _216.xyz / float3(_216.w);
    float3 _221 = _220 - View.View_PreViewTranslation;
    float2 _225 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _231 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _225, bias(View.View_MaterialTextureMipBias));
    float2 _237 = ((normalize(-_220) * _200).xy * ((0.004999999888241291046142578125 * _231.w) + (-0.00449999980628490447998046875))) + _225;
    float4 _241 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float4 _257 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float3 _279 = normalize(_200 * normalize(((float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz + (float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _291 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _299 = (_291.x + 0.5) * (_296.x + 0.5);
    float4 _302 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _237, bias(View.View_MaterialTextureMipBias));
    float3 _314 = fast::clamp(_302.xyz * mix(0.5, 1.0, _299), float3(0.0), float3(1.0));
    float _315 = fast::clamp(_308.y, 0.0, 1.0);
    float _320 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _308.x + (_299 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _321 = in.in_var_PRIMITIVE_ID * 36u;
    uint _322 = _321 + 20u;
    float _370;
    float _371;
    float _372;
    float3 _373;
    float3 _374;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _340 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _344 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _340, level(0.0));
        float _360 = _350.w;
        _370 = (_320 * _360) + _350.z;
        _371 = (0.5 * _360) + _350.y;
        _372 = _350.x;
        _373 = (_314 * _344.w) + _344.xyz;
        _374 = normalize((_279 * _347.w) + ((_347.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _370 = _320;
        _371 = 0.5;
        _372 = 0.0;
        _373 = _314;
        _374 = _279;
    }
    float3 _389 = ((_373 - (_373 * _372)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _396 = (mix(float3(0.07999999821186065673828125 * _371), _373, float3(_372)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _399 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _404;
    if (_399)
    {
        _404 = _389 + (_396 * 0.449999988079071044921875);
    }
    else
    {
        _404 = _389;
    }
    float3 _406 = select(_396, float3(0.0), bool3(_399));
    float3 _408 = float3(dot(_406, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _415 = float3(_315);
    float2 _424 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _429 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _424);
    float4 _431 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_424 + float2(0.0, 0.5)));
    uint _437 = in.in_var_LIGHTMAP_ID * 15u;
    uint _438 = _437 + 4u;
    uint _443 = _437 + 6u;
    float3 _448 = _429.xyz;
    float _500;
    float _501;
    float3 _502;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float4 _484 = LightmapResourceCluster_SkyOcclusionTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.xy);
        float _488 = _484.w;
        float _489 = _488 * _488;
        float3 _491 = normalize(((_484.xyz * 2.0) - float3(1.0)).xyz);
        float _492 = 1.0 - _489;
        float _494 = 1.0 - (_492 * _492);
        _500 = mix(fast::clamp(dot(_491, _374), 0.0, 1.0), 1.0, _494);
        _501 = _489;
        _502 = mix(_491, _374, float3(_494));
    }
    else
    {
        _500 = 1.0;
        _501 = 1.0;
        _502 = _374;
    }
    float4 _506 = float4(_502, 1.0);
    float3 _510 = _155;
    _510.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 0u)], _506);
    float3 _514 = _510;
    _514.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 1u)], _506);
    float3 _518 = _514;
    _518.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 2u)], _506);
    float4 _521 = _506.xyzz * _506.yzzx;
    float3 _525 = _155;
    _525.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 3u)], _521);
    float3 _529 = _525;
    _529.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 4u)], _521);
    float3 _533 = _529;
    _533.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 5u)], _521);
    float3 _548 = (((((_448 * _448) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _438)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _443)].xyz) * ((exp2(((_429.w + ((_431.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _438)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _443)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_431 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _437 + 7u)], float4(_374.yzx, 1.0))))) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_518 + _533) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, 6u)].xyz * ((_502.x * _502.x) - (_502.y * _502.y)))) * View.View_SkyLightColor.xyz) * (_501 * _500));
    float3 _570 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _599;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _598;
        if (any(abs(_221 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321 + 19u)].xyz + float3(1.0))))
        {
            _598 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_221, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _598 = _570;
        }
        _599 = _598;
    }
    else
    {
        _599 = _570;
    }
    float4 _606 = float4(((mix(float3(0.0), _404 + (_406 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_548 * _404) * fast::max(_415, ((((((_373 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _315) + ((_373 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _315) + ((_373 * 2.755199909210205078125) + float3(0.69029998779296875))) * _315))) + _599) * 1.0, 0.0);
    float4 _613;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _612 = _606;
        _612.w = 0.0;
        _613 = _612;
    }
    else
    {
        _613 = _606;
    }
    float2 _617 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _625 = (_374 * 0.5) + float3(0.5);
    float4 _627 = float4(_625.x, _625.y, _625.z, float4(0.0).w);
    _627.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _322)].y;
    float4 _628 = float4(0.0);
    _628.x = _372;
    float4 _629 = _628;
    _629.y = _371;
    float4 _630 = _629;
    _630.z = _370;
    float4 _631 = _630;
    _631.w = 0.75686275959014892578125;
    float4 _643 = float4(_373.x, _373.y, _373.z, float4(0.0).w);
    _643.w = ((log2(((dot(_548, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_415, ((((((_408 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _315) + ((_408 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _315) + ((_408 * 2.755199909210205078125) + float3(0.69029998779296875))) * _315).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_617.xyx * _617.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _613 * View.View_PreExposure;
    out.out_var_SV_Target1 = _627;
    out.out_var_SV_Target2 = _631;
    out.out_var_SV_Target3 = _643;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

