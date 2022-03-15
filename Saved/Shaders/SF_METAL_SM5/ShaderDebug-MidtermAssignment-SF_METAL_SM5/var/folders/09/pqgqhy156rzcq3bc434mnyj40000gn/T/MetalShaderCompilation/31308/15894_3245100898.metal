

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
    spvUnsafeArray<float4, 5> Material_VectorExpressions;
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

fragment MainPS_out Main_00003e16_c16c4f62(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    bool _298;
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    float4 _228 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _231 = (_228.xy * float2(2.0)) - float2(1.0);
    float _240 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _240) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _248 = (_245.xy * float2(2.0)) - float2(1.0);
    float _260 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_260, _240) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float4 _280 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_240, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _283 = (_280.xy * float2(2.0)) - float2(1.0);
    float _318;
    switch (0u)
    {
        default:
        {
            _298 = View.View_ViewToClip[3u].w < 1.0;
            if (_298)
            {
                _318 = _207.w;
                break;
            }
            else
            {
                float _302 = _207.z;
                _318 = ((_302 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_302 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _330 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_260, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _333 = (_330.xy * float2(2.0)) - float2(1.0);
    float4 _346 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _349 = (_346.xy * float2(2.0)) - float2(1.0);
    float _382;
    switch (0u)
    {
        default:
        {
            if (_298)
            {
                _382 = _207.w;
                break;
            }
            else
            {
                float _366 = _207.z;
                _382 = ((_366 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_366 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _396 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_231, sqrt(fast::clamp(1.0 - dot(_231, _231), 0.0, 1.0)), 1.0).xyz + (float4(_248, sqrt(fast::clamp(1.0 - dot(_248, _248), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz + float4(_283, sqrt(fast::clamp(1.0 - dot(_283, _283), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_318 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_333, sqrt(fast::clamp(1.0 - dot(_333, _333), 0.0, 1.0)), 1.0).xyz + (float4(_349, sqrt(fast::clamp(1.0 - dot(_349, _349), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_382 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _407 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _411 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _412 = in.in_var_PRIMITIVE_ID * 36u;
    uint _413 = _412 + 20u;
    float _462;
    float _463;
    float _464;
    float3 _465;
    float3 _466;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _413)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _431 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _435 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _431, level(0.0));
        float4 _438 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _431, level(0.0));
        float4 _441 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _431, level(0.0));
        float _451 = _441.w;
        _462 = (_411 * _451) + _441.z;
        _463 = (0.5 * _451) + _441.y;
        _464 = _451 + _441.x;
        _465 = (_407 * _435.w) + _435.xyz;
        _466 = normalize((_396 * _438.w) + ((_438.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _462 = _411;
        _463 = 0.5;
        _464 = 1.0;
        _465 = _407;
        _466 = _396;
    }
    float3 _481 = ((_465 - (_465 * _464)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _488 = (mix(float3(0.07999999821186065673828125 * _463), _465, float3(_464)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _491 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _496;
    if (_491)
    {
        _496 = _481 + (_488 * 0.449999988079071044921875);
    }
    else
    {
        _496 = _481;
    }
    float3 _498 = select(_488, float3(0.0), bool3(_491));
    float3 _500 = float3(dot(_498, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float2 _515 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _520 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _515);
    float4 _522 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_515 + float2(0.0, 0.5)));
    uint _528 = in.in_var_LIGHTMAP_ID * 15u;
    uint _529 = _528 + 4u;
    uint _534 = _528 + 6u;
    float3 _539 = _520.xyz;
    float3 _567 = ((((_539 * _539) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _529)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _534)].xyz) * ((exp2(((_520.w + ((_522.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _529)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _534)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_522 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _528 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _528 + 7u)], float4(_466.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _589 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _618;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _617;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _412 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _412 + 19u)].xyz + float3(1.0))))
        {
            _617 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _617 = _589;
        }
        _618 = _617;
    }
    else
    {
        _618 = _589;
    }
    float4 _625 = float4(((mix(float3(0.0), _496 + (_498 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_567 * _496) * fast::max(float3(1.0), ((((((_465 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_465 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_465 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _618) * 1.0, 0.0);
    float4 _632;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _631 = _625;
        _631.w = 0.0;
        _632 = _631;
    }
    else
    {
        _632 = _625;
    }
    float2 _636 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _644 = (_466 * 0.5) + float3(0.5);
    float4 _646 = float4(_644.x, _644.y, _644.z, float4(0.0).w);
    _646.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _413)].y;
    float4 _647 = float4(0.0);
    _647.x = _464;
    float4 _648 = _647;
    _648.y = _463;
    float4 _649 = _648;
    _649.z = _462;
    float4 _650 = _649;
    _650.w = 0.75686275959014892578125;
    float4 _662 = float4(_465.x, _465.y, _465.z, float4(0.0).w);
    _662.w = ((log2(((dot(_567, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_500 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_500 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_500 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_636.xyx * _636.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _632 * View.View_PreExposure;
    out.out_var_SV_Target1 = _646;
    out.out_var_SV_Target2 = _650;
    out.out_var_SV_Target3 = _662;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

