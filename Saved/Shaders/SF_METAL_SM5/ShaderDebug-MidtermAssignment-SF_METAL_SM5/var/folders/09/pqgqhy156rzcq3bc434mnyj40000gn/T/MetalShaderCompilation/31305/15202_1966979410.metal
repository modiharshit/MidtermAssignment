

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

constant float _155 = {};

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

fragment MainPS_out Main_00003b62_753db952(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> LightmapResourceCluster_StaticShadowTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_2 [[texture(7)]], texture2d<float> Material_Texture2D_3 [[texture(8)]], texture2d<float> Material_Texture2D_4 [[texture(9)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float3x3 _197 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = _213.xyz / float3(_213.w);
    float3 _218 = _217 - View.View_PreViewTranslation;
    float2 _222 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _222, bias(View.View_MaterialTextureMipBias));
    float2 _234 = ((normalize(-_217) * _197).xy * ((0.004999999888241291046142578125 * _228.w) + (-0.00449999980628490447998046875))) + _222;
    float4 _238 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float4 _254 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _276 = normalize(_197 * normalize(((float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz + (float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _288 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _293 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _296 = (_288.x + 0.5) * (_293.x + 0.5);
    float4 _299 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _234, bias(View.View_MaterialTextureMipBias));
    float3 _311 = fast::clamp(_299.xyz * mix(0.5, 1.0, _296), float3(0.0), float3(1.0));
    float _312 = fast::clamp(_305.y, 0.0, 1.0);
    float _317 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _305.x + (_296 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _318 = in.in_var_PRIMITIVE_ID * 36u;
    uint _319 = _318 + 20u;
    float _367;
    float _368;
    float _369;
    float3 _370;
    float3 _371;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _337 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _341 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _344 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float4 _347 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _337, level(0.0));
        float _357 = _347.w;
        _367 = (_317 * _357) + _347.z;
        _368 = (0.5 * _357) + _347.y;
        _369 = _347.x;
        _370 = (_311 * _341.w) + _341.xyz;
        _371 = normalize((_276 * _344.w) + ((_344.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _367 = _317;
        _368 = 0.5;
        _369 = 0.0;
        _370 = _311;
        _371 = _276;
    }
    float4 _378 = LightmapResourceCluster_StaticShadowTexture.sample(LightmapResourceCluster_LightMapSampler, in.in_var_TEXCOORD4.zw);
    uint _379 = in.in_var_LIGHTMAP_ID * 15u;
    uint _380 = _379 + 1u;
    float4 _387 = fast::clamp((_378 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _380)]) + ((View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _380)] * (-0.5)) + float4(0.5)), float4(0.0), float4(1.0));
    float3 _404 = ((_370 - (_370 * _369)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _411 = (mix(float3(0.07999999821186065673828125 * _368), _370, float3(_369)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _414 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _419;
    if (_414)
    {
        _419 = _404 + (_411 * 0.449999988079071044921875);
    }
    else
    {
        _419 = _404;
    }
    float3 _421 = select(_411, float3(0.0), bool3(_414));
    float3 _423 = float3(dot(_421, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _430 = float3(_312);
    float2 _439 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _443 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _439);
    float4 _445 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_439 + float2(0.0, 0.5)));
    uint _451 = _379 + 4u;
    uint _456 = _379 + 6u;
    float3 _461 = _443.xyz;
    float3 _489 = ((((_461 * _461) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _451)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _456)].xyz) * ((exp2(((_443.w + ((_445.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _451)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _456)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_445 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379 + 7u)], float4(_371.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _511 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _540;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _539;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318 + 19u)].xyz + float3(1.0))))
        {
            _539 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _539 = _511;
        }
        _540 = _539;
    }
    else
    {
        _540 = _511;
    }
    float4 _547 = float4(((mix(float3(0.0), _419 + (_421 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_489 * _419) * fast::max(_430, ((((((_370 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _312) + ((_370 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _312) + ((_370 * 2.755199909210205078125) + float3(0.69029998779296875))) * _312))) + _540) * 1.0, 0.0);
    float4 _554;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _553 = _547;
        _553.w = 0.0;
        _554 = _553;
    }
    else
    {
        _554 = _547;
    }
    float2 _558 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _566 = (_371 * 0.5) + float3(0.5);
    float4 _568 = float4(_566.x, _566.y, _566.z, float4(0.0).w);
    _568.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _319)].y;
    float4 _569 = float4(0.0);
    _569.x = _369;
    float4 _570 = _569;
    _570.y = _368;
    float4 _571 = _570;
    _571.z = _367;
    float4 _572 = _571;
    _572.w = 0.50588238239288330078125;
    float4 _584 = float4(_370.x, _370.y, _370.z, float4(0.0).w);
    _584.w = ((log2(((dot(_489, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_430, ((((((_423 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _312) + ((_423 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _312) + ((_423 * 2.755199909210205078125) + float3(0.69029998779296875))) * _312).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_558.xyx * _558.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _554 * View.View_PreExposure;
    out.out_var_SV_Target1 = _568;
    out.out_var_SV_Target2 = _572;
    out.out_var_SV_Target3 = _584;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = (View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _379)] * _387) * _387;
    return out;
}

