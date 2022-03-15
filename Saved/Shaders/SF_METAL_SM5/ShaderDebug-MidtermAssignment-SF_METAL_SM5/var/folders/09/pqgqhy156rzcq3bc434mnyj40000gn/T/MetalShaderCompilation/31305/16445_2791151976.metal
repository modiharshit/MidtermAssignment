

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
    char _m16_pad[612];
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[48];
    float4 View_SkyLightColor;
    char _m18_pad[124];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
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

constant float3 _152 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000403d_a65d9968(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    bool _302;
    float4 _211 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _215 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _220 = (_215.xyz / float3(_215.w)) - View.View_PreViewTranslation;
    float4 _232 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * (-0.100000001490116119384765625), View.View_GameTime * (-0.0500000007450580596923828125)) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)), bias(View.View_MaterialTextureMipBias));
    float2 _235 = (_232.xy * float2(2.0)) - float2(1.0);
    float _244 = View.View_GameTime * 0.0500000007450580596923828125;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.039999999105930328369140625, _244) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5)), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float _264 = View.View_GameTime * (-0.02999999932944774627685546875);
    float4 _269 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_264, _244) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125)), bias(View.View_MaterialTextureMipBias));
    float2 _272 = (_269.xy * float2(2.0)) - float2(1.0);
    float4 _284 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_244, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _287 = (_284.xy * float2(2.0)) - float2(1.0);
    float _322;
    switch (0u)
    {
        default:
        {
            _302 = View.View_ViewToClip[3u].w < 1.0;
            if (_302)
            {
                _322 = _211.w;
                break;
            }
            else
            {
                float _306 = _211.z;
                _322 = ((_306 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_306 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _334 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(_264, View.View_GameTime * (-0.0089999996125698089599609375)) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625)), bias(View.View_MaterialTextureMipBias));
    float2 _337 = (_334.xy * float2(2.0)) - float2(1.0);
    float4 _350 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(View.View_GameTime * 0.02999999932944774627685546875, 0.0) + (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.07999999821186065673828125, 0.039999999105930328369140625))), bias(View.View_MaterialTextureMipBias));
    float2 _353 = (_350.xy * float2(2.0)) - float2(1.0);
    float _386;
    switch (0u)
    {
        default:
        {
            if (_302)
            {
                _386 = _211.w;
                break;
            }
            else
            {
                float _370 = _211.z;
                _386 = ((_370 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_370 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _400 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_235, sqrt(fast::clamp(1.0 - dot(_235, _235), 0.0, 1.0)), 1.0).xyz + (float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float4(_272, sqrt(fast::clamp(1.0 - dot(_272, _272), 0.0, 1.0)), 1.0).xyz + float4(_287, sqrt(fast::clamp(1.0 - dot(_287, _287), 0.0, 1.0)), 1.0).xyz, float3(fast::min(fast::max((_322 - 300.0) * 0.0011111111380159854888916015625, 0.0), 1.0))), float4(_337, sqrt(fast::clamp(1.0 - dot(_337, _337), 0.0, 1.0)), 1.0).xyz + (float4(_353, sqrt(fast::clamp(1.0 - dot(_353, _353), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0)), float3(fast::min(fast::max((_386 - 500.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _411 = fast::clamp(Material.Material_VectorExpressions[4].xyz, float3(0.0), float3(1.0));
    float _415 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _416 = in.in_var_PRIMITIVE_ID * 36u;
    uint _417 = _416 + 20u;
    float _466;
    float _467;
    float _468;
    float3 _469;
    float3 _470;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _417)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _435 = ((_211.xy / float2(_211.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _439 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _435, level(0.0));
        float4 _442 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _435, level(0.0));
        float4 _445 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _435, level(0.0));
        float _455 = _445.w;
        _466 = (_415 * _455) + _445.z;
        _467 = (0.5 * _455) + _445.y;
        _468 = _455 + _445.x;
        _469 = (_411 * _439.w) + _439.xyz;
        _470 = normalize((_400 * _442.w) + ((_442.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _466 = _415;
        _467 = 0.5;
        _468 = 1.0;
        _469 = _411;
        _470 = _400;
    }
    float _519;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _417)].z > 0.0)
    {
        float3 _487 = fast::clamp((_220 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _498 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_487.x), int(_487.y), int(_487.z), 0).xyz), 0));
        _519 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_498.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_487 / float3(_498.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _519 = 1.0;
    }
    float3 _533 = ((_469 - (_469 * _468)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _540 = (mix(float3(0.07999999821186065673828125 * _467), _469, float3(_468)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _543 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _548;
    if (_543)
    {
        _548 = _533 + (_540 * 0.449999988079071044921875);
    }
    else
    {
        _548 = _533;
    }
    float4 _554 = float4(_470, 1.0);
    float3 _558 = _152;
    _558.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _554);
    float3 _562 = _558;
    _562.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _554);
    float3 _566 = _562;
    _566.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _554);
    float4 _569 = _554.xyzz * _554.yzzx;
    float3 _573 = _152;
    _573.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _569);
    float3 _577 = _573;
    _577.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _569);
    float3 _581 = _577;
    _581.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _569);
    float3 _615 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _644;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _643;
        if (any(abs(_220 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _416 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _416 + 19u)].xyz + float3(1.0))))
        {
            _643 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_220, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _643 = _615;
        }
        _644 = _643;
    }
    else
    {
        _644 = _615;
    }
    float4 _651 = float4(((mix(float3(0.0), _548 + (select(_540, float3(0.0), bool3(_543)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((((fast::max(float3(0.0), (_566 + _581) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_470.x * _470.x) - (_470.y * _470.y)))) * View.View_SkyLightColor.xyz) * 1.0) * _548) * fast::max(float3(1.0), ((((((_469 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_469 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_469 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _644) * 1.0, 0.0);
    float4 _658;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _657 = _651;
        _657.w = 0.0;
        _658 = _657;
    }
    else
    {
        _658 = _651;
    }
    float2 _662 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _670 = (_470 * 0.5) + float3(0.5);
    float4 _672 = float4(_670.x, _670.y, _670.z, float4(0.0).w);
    _672.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _417)].y;
    float4 _673 = float4(0.0);
    _673.x = _468;
    float4 _674 = _673;
    _674.y = _467;
    float4 _675 = _674;
    _675.z = _466;
    float4 _676 = _675;
    _676.w = 0.50588238239288330078125;
    float4 _679 = float4(_469.x, _469.y, _469.z, float4(0.0).w);
    _679.w = (fract(dot(_662.xyx * _662.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _658 * View.View_PreExposure;
    out.out_var_SV_Target1 = _672;
    out.out_var_SV_Target2 = _676;
    out.out_var_SV_Target3 = _679;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_519, 1.0, 1.0, 1.0);
    return out;
}

