

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
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
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

fragment MainPS_out Main_00003739_a5855c04(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(0)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(2)]], texture2d<float> LightmapResourceCluster_LightMapTexture [[texture(3)]], texture2d<float> Material_Texture2D_0 [[texture(4)]], texture2d<float> Material_Texture2D_1 [[texture(5)]], texture2d<float> Material_Texture2D_2 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(0)]], sampler LightmapResourceCluster_LightMapSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[1];
    float4 _202 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _206 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _211 = (_206.xyz / float3(_206.w)) - View.View_PreViewTranslation;
    float2 _212 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _218 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _212, bias(View.View_MaterialTextureMipBias));
    float2 _221 = (_218.xy * float2(2.0)) - float2(1.0);
    float4 _233 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _260;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _260 = _202.w;
                break;
            }
            else
            {
                float _244 = _202.z;
                _260 = ((_244 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_244 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _265 = fast::min(fast::max(((mix(-2000.0, 2000.0, _233.x) + _260) - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0);
    float3 _276 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_221, sqrt(fast::clamp(1.0 - dot(_221, _221), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_265)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _287 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _212, bias(View.View_MaterialTextureMipBias));
    float4 _291 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _212, bias(View.View_MaterialTextureMipBias));
    float3 _297 = fast::clamp(_287.xyz, float3(0.0), float3(1.0));
    float _298 = fast::clamp(_287.x, 0.0, 1.0);
    float _299 = fast::clamp(_291.w, 0.0, 1.0);
    float _304 = (fast::clamp(mix(_291.x, 0.300000011920928955078125, _265), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _305 = in.in_var_PRIMITIVE_ID * 36u;
    uint _306 = _305 + 20u;
    float _354;
    float _355;
    float _356;
    float3 _357;
    float3 _358;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _324 = ((_202.xy / float2(_202.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _328 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float _344 = _334.w;
        _354 = (_304 * _344) + _334.z;
        _355 = (_298 * _344) + _334.y;
        _356 = _334.x;
        _357 = (_297 * _328.w) + _328.xyz;
        _358 = normalize((_276 * _331.w) + ((_331.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _354 = _304;
        _355 = _298;
        _356 = 0.0;
        _357 = _297;
        _358 = _276;
    }
    float3 _373 = ((_357 - (_357 * _356)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (mix(float3(0.07999999821186065673828125 * _355), _357, float3(_356)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float3 _390 = select(_380, float3(0.0), bool3(_383));
    float3 _392 = float3(dot(_390, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _399 = float3(_299);
    float2 _408 = in.in_var_TEXCOORD4.xy * float2(1.0, 0.5);
    float4 _413 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, _408);
    float4 _415 = LightmapResourceCluster_LightMapTexture.sample(LightmapResourceCluster_LightMapSampler, (_408 + float2(0.0, 0.5)));
    uint _421 = in.in_var_LIGHTMAP_ID * 15u;
    uint _422 = _421 + 4u;
    uint _427 = _421 + 6u;
    float3 _432 = _413.xyz;
    float3 _460 = ((((_432 * _432) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].xyz) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _427)].xyz) * ((exp2(((_413.w + ((_415.w * 0.0039215688593685626983642578125) - 0.00196078442968428134918212890625)) * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _422)].w) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _427)].w) - 0.0185813605785369873046875) * fast::max(0.0, dot((_415 * View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421 + 5u)]) + View_LightmapSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _421 + 7u)], float4(_358.yzx, 1.0))))) * View.View_IndirectLightingColorScale;
    float3 _482 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _511;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _510;
        if (any(abs(_211 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 19u)].xyz + float3(1.0))))
        {
            _510 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_211, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _510 = _482;
        }
        _511 = _510;
    }
    else
    {
        _511 = _482;
    }
    float4 _518 = float4(((mix(float3(0.0), _388 + (_390 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_460 * _388) * fast::max(_399, ((((((_357 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _299) + ((_357 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _299) + ((_357 * 2.755199909210205078125) + float3(0.69029998779296875))) * _299))) + _511) * 1.0, 0.0);
    float4 _525;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _524 = _518;
        _524.w = 0.0;
        _525 = _524;
    }
    else
    {
        _525 = _518;
    }
    float2 _529 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _537 = (_358 * 0.5) + float3(0.5);
    float4 _539 = float4(_537.x, _537.y, _537.z, float4(0.0).w);
    _539.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].y;
    float4 _540 = float4(0.0);
    _540.x = _356;
    float4 _541 = _540;
    _541.y = _355;
    float4 _542 = _541;
    _542.z = _354;
    float4 _543 = _542;
    _543.w = 0.75686275959014892578125;
    float4 _555 = float4(_357.x, _357.y, _357.z, float4(0.0).w);
    _555.w = ((log2(((dot(_460, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_399, ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _299) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _299) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * _299).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_529.xyx * _529.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _525 * View.View_PreExposure;
    out.out_var_SV_Target1 = _539;
    out.out_var_SV_Target2 = _543;
    out.out_var_SV_Target3 = _555;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(0.0);
    return out;
}

