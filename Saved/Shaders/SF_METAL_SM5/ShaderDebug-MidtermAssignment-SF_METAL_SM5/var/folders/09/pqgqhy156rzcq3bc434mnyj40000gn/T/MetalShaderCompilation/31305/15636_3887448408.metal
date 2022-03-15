

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
    char _m13_pad[36];
    float View_GameTime;
    char _m14_pad[8];
    float View_MaterialTextureMipBias;
    char _m15_pad[28];
    float View_UnlitViewmodeMask;
    char _m16_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m17_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
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

fragment MainPS_out Main_00003d14_e7b5c158(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _217 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _221 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _226 = (_221.xyz / float3(_221.w)) - View.View_PreViewTranslation;
    float2 _233 = float2(View.View_GameTime * (-0.02999999932944774627685546875), View.View_GameTime * (-0.0199999995529651641845703125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.0500000007450580596923828125, 0.07999999821186065673828125));
    float4 _239 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float2 _242 = (_239.xy * float2(2.0)) - float2(1.0);
    float _249 = sqrt(fast::clamp(1.0 - dot(_242, _242), 0.0, 1.0)) + 1.0;
    float _257 = sin(((_226.x * 0.006666666828095912933349609375) + (View.View_GameTime * Material.Material_ScalarExpressions[0].x)) * 1.256637096405029296875);
    float4 _264 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_257 * (-0.0599999986588954925537109375), _257 * (-0.039999999105930328369140625)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.180000007152557373046875, 0.1500000059604644775390625))), bias(View.View_MaterialTextureMipBias));
    float2 _267 = (_264.xy * float2(2.0)) - float2(1.0);
    float3 _276 = float4(_267, sqrt(fast::clamp(1.0 - dot(_267, _267), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _279 = float3(_242, _249);
    float3 _283 = float3(_276.xy * (-1.0), _276.z);
    float3 _287 = (_279 * dot(_279, _283)) - (_283 * _249);
    float _289 = _287.z + 1.0;
    float2 _293 = float2(View.View_GameTime * (-0.070000000298023223876953125)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75);
    float4 _295 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _293, bias(View.View_MaterialTextureMipBias));
    float2 _298 = (_295.xy * float2(2.0)) - float2(1.0);
    float4 _310 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _337;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _337 = _217.w;
                break;
            }
            else
            {
                float _321 = _217.z;
                _337 = ((_321 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_321 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _344 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _310.x) + _337) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _345 = mix(float4(_298, sqrt(fast::clamp(1.0 - dot(_298, _298), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _344);
    float3 _350 = float3(_287.xy, _289);
    float3 _354 = float3(_345.xy * (-1.0), _345.z);
    float3 _366 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_350 * dot(_350, _354)) - (_354 * _289)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _377 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _293, bias(View.View_MaterialTextureMipBias));
    float4 _379 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _233, bias(View.View_MaterialTextureMipBias));
    float3 _394 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_377.x * _379.x, 0.0), 1.0))), Material.Material_VectorExpressions[4].xyz, _344), float3(0.0), float3(1.0));
    float _398 = (0.100000001490116119384765625 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _399 = in.in_var_PRIMITIVE_ID * 36u;
    uint _400 = _399 + 20u;
    float _448;
    float _449;
    float _450;
    float3 _451;
    float3 _452;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _400)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _418 = ((_217.xy / float2(_217.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _422 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _418, level(0.0));
        float4 _425 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _418, level(0.0));
        float4 _428 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _418, level(0.0));
        float _438 = _428.w;
        _448 = (_398 * _438) + _428.z;
        _449 = (0.5 * _438) + _428.y;
        _450 = _428.x;
        _451 = (_394 * _422.w) + _422.xyz;
        _452 = normalize((_366 * _425.w) + ((_425.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _448 = _398;
        _449 = 0.5;
        _450 = 0.0;
        _451 = _394;
        _452 = _366;
    }
    float3 _467 = ((_451 - (_451 * _450)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _474 = (mix(float3(0.07999999821186065673828125 * _449), _451, float3(_450)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _477 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _482;
    if (_477)
    {
        _482 = _467 + (_474 * 0.449999988079071044921875);
    }
    else
    {
        _482 = _467;
    }
    float3 _484 = select(_474, float3(0.0), bool3(_477));
    float3 _486 = float3(dot(_484, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _501 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _506 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _501);
    float4 _508 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_501 + float2(0.0, 0.5)));
    uint _514 = in.in_var_LIGHTMAP_ID * 15u;
    uint _515 = _514 + 4u;
    uint _520 = _514 + 6u;
    float3 _525 = _506.xyz;
    float3 _553 = ((((_525 * _525) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _515)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _520)].xyz) * ((exp2(((_506.w + ((_508.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _515)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _520)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_508 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _514 + 7u)], float4(_452.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _575 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _604;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _603;
        if (any(abs(_226 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _399 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _399 + 19u)].xyz + float3(1.0))))
        {
            _603 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_226, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _603 = _575;
        }
        _604 = _603;
    }
    else
    {
        _604 = _575;
    }
    float4 _611 = float4(((mix(float3(0.0), _482 + (_484 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_553 * _482) * fast::max(float3(1.0), ((((((_451 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_451 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_451 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _604) * 1.0, 0.0);
    float4 _618;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _617 = _611;
        _617.w = 0.0;
        _618 = _617;
    }
    else
    {
        _618 = _611;
    }
    float2 _622 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _630 = (_452 * 0.5) + float3(0.5);
    float4 _632 = float4(_630.x, _630.y, _630.z, float4(0.0).w);
    _632.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _400)].y;
    float4 _633 = float4(0.0);
    _633.x = _450;
    float4 _634 = _633;
    _634.y = _449;
    float4 _635 = _634;
    _635.z = _448;
    float4 _636 = _635;
    _636.w = 0.75686275959014892578125;
    float4 _648 = float4(_451.x, _451.y, _451.z, float4(0.0).w);
    _648.w = ((log2(((dot(_553, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_486 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_486 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_486 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_622.xyx * _622.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _618 * View.View_PreExposure;
    out.out_var_SV_Target1 = _632;
    out.out_var_SV_Target2 = _636;
    out.out_var_SV_Target3 = _648;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

