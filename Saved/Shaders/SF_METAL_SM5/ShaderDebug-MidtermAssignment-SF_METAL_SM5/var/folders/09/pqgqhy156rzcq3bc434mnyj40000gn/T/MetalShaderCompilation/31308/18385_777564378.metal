

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
    char _m19_pad[48];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _182 = {};
constant float4 _184 = {};

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

fragment MainPS_out Main_000047d1_2e58b0da(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = (_244.xyz / float3(_244.w)) - View.View_PreViewTranslation;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 10.0), bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float4 _272 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _275 = (_272.xy * float2(2.0)) - float2(1.0);
    float _309;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _309 = _240.w;
                break;
            }
            else
            {
                float _293 = _240.z;
                _309 = ((_293 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_293 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _313 = fast::min(fast::max((_309 - 24.0) * 0.00022222222469281405210494995117188, 0.0), 1.0);
    float3 _324 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz * float3(0.5, 0.5, 1.0)) + mix(float4(_275, sqrt(fast::clamp(1.0 - dot(_275, _275), 0.0, 1.0)), 1.0).xyz * float3(0.25, 0.25, 1.0), float3(0.0, 0.0, 1.0), float3(_313))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _336 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 5.0), bias(View.View_MaterialTextureMipBias));
    float _338 = mix(0.4000000059604644775390625, 1.0, _336.x);
    float _341 = mix(0.699999988079071044921875, 0.89999997615814208984375, _336.y);
    float4 _346 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _361 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(_346.y + _313, 0.0), 1.0))) * mix(_338, 1.0 - _338, _341), float3(0.0), float3(1.0));
    float _366 = (fast::clamp(_338 * _341, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _367 = in.in_var_PRIMITIVE_ID * 36u;
    uint _368 = _367 + 20u;
    float _416;
    float _417;
    float _418;
    float3 _419;
    float3 _420;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _386 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _390 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float4 _396 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _386, level(0.0));
        float _406 = _396.w;
        _416 = (_366 * _406) + _396.z;
        _417 = (0.5 * _406) + _396.y;
        _418 = _396.x;
        _419 = (_361 * _390.w) + _390.xyz;
        _420 = normalize((_324 * _393.w) + ((_393.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _416 = _366;
        _417 = 0.5;
        _418 = 0.0;
        _419 = _361;
        _420 = _324;
    }
    float3 _430 = fast::clamp((_249 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _441 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_430.x), int(_430.y), int(_430.z), 0).xyz), 0));
    float3 _456 = (((_441.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_430 / float3(_441.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _469;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].z > 0.0)
    {
        _469 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _456, level(0.0)).x;
    }
    else
    {
        _469 = 1.0;
    }
    float3 _483 = ((_419 - (_419 * _418)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _490 = (mix(float3(0.07999999821186065673828125 * _417), _419, float3(_418)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _493 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _498;
    if (_493)
    {
        _498 = _483 + (_490 * 0.449999988079071044921875);
    }
    else
    {
        _498 = _483;
    }
    float3 _500 = select(_490, float3(0.0), bool3(_493));
    float3 _502 = float3(dot(_500, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _519 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _456, level(0.0));
    float _535 = _519.x;
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _538 = _519.y;
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _541 = _519.z;
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _560 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _562 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _564 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _456, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _597 = _184;
    _597.y = (-0.48860299587249755859375) * _420.y;
    float4 _600 = _597;
    _600.z = 0.48860299587249755859375 * _420.z;
    float4 _603 = _600;
    _603.w = (-0.48860299587249755859375) * _420.x;
    float3 _604 = _420 * _420;
    float4 _607 = _182;
    _607.x = (1.09254801273345947265625 * _420.x) * _420.y;
    float4 _610 = _607;
    _610.y = ((-1.09254801273345947265625) * _420.y) * _420.z;
    float4 _615 = _610;
    _615.z = 0.3153919875621795654296875 * ((3.0 * _604.z) - 1.0);
    float4 _618 = _615;
    _618.w = ((-1.09254801273345947265625) * _420.x) * _420.z;
    float4 _622 = _603;
    _622.x = 0.886227548122406005859375;
    float3 _624 = _622.yzw * 2.094395160675048828125;
    float4 _625 = float4(_622.x, _624.x, _624.y, _624.z);
    float4 _626 = _618 * 0.785398185253143310546875;
    float _627 = (_604.x - _604.y) * 0.4290426075458526611328125;
    float3 _633 = float3(0.0);
    _633.x = (dot(float4(_535, _537.xyz), _625) + dot(float4(_537.w, _560.xyz), _626)) + (_560.w * _627);
    float3 _639 = _633;
    _639.y = (dot(float4(_538, _540.xyz), _625) + dot(float4(_540.w, _562.xyz), _626)) + (_562.w * _627);
    float3 _645 = _639;
    _645.z = (dot(float4(_541, _543.xyz), _625) + dot(float4(_543.w, _564.xyz), _626)) + (_564.w * _627);
    float3 _650 = (fast::max(float3(0.0), _645) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _672 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _701;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _700;
        if (any(abs(_249 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _367 + 19u)].xyz + float3(1.0))))
        {
            _700 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _700 = _672;
        }
        _701 = _700;
    }
    else
    {
        _701 = _672;
    }
    float4 _708 = float4(((mix(float3(0.0), _498 + (_500 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_650 * _498) * fast::max(float3(1.0), ((((((_419 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_419 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_419 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _701) * 1.0, 0.0);
    float4 _715;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _714 = _708;
        _714.w = 0.0;
        _715 = _714;
    }
    else
    {
        _715 = _708;
    }
    float2 _719 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _727 = (_420 * 0.5) + float3(0.5);
    float4 _729 = float4(_727.x, _727.y, _727.z, float4(0.0).w);
    _729.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _368)].y;
    float4 _730 = float4(0.0);
    _730.x = _418;
    float4 _731 = _730;
    _731.y = _417;
    float4 _732 = _731;
    _732.z = _416;
    float4 _733 = _732;
    _733.w = 0.50588238239288330078125;
    float4 _745 = float4(_419.x, _419.y, _419.z, float4(0.0).w);
    _745.w = ((log2(((dot(_650, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_502 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_502 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_502 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_719.xyx * _719.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _715 * View.View_PreExposure;
    out.out_var_SV_Target1 = _729;
    out.out_var_SV_Target2 = _733;
    out.out_var_SV_Target3 = _745;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_469, 1.0, 1.0, 1.0);
    return out;
}

