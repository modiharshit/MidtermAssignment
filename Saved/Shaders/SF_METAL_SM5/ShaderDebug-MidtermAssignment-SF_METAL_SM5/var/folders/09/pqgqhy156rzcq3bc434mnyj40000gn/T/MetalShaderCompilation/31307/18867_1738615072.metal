

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _181 = {};
constant float4 _183 = {};

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

fragment MainPS_out Main_000049b3_67a12920(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], texture2d<float> Material_Texture2D_4 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _240 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _244 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _249 = (_244.xyz / float3(_244.w)) - View.View_PreViewTranslation;
    float2 _250 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _256 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float2 _259 = (_256.xy * float2(2.0)) - float2(1.0);
    float3 _275 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_259, sqrt(fast::clamp(1.0 - dot(_259, _259), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (_250 * float2(0.25)), bias(View.View_MaterialTextureMipBias));
    float2 _290 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _295 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_290 * 0.2134999930858612060546875), bias(View.View_MaterialTextureMipBias));
    float4 _300 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (_290 * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float _327;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _327 = _240.w;
                break;
            }
            else
            {
                float _311 = _240.z;
                _327 = ((_311 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_311 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float4 _335 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _338 = mix(_295.x + 0.5, _300.x + 0.5, fast::min(fast::max((_327 - 24.0) * 0.0009765625, 0.0), 1.0)) * (_335.x + 0.5);
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float4 _356 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _250, bias(View.View_MaterialTextureMipBias));
    float3 _362 = fast::clamp(fast::min(fast::max(((_343.xyz * mix(0.60000002384185791015625, 1.0, _338)) * mix(0.1500000059604644775390625, 0.699999988079071044921875, _287.x)) * Material.Material_VectorExpressions[3].xyz, float3(0.0)), float3(1.0)), float3(0.0), float3(1.0));
    float _363 = fast::clamp(_356.y, 0.0, 1.0);
    float _368 = (fast::clamp(mix(-0.300000011920928955078125, 1.0, _356.x + (_338 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _369 = in.in_var_PRIMITIVE_ID * 36u;
    uint _370 = _369 + 20u;
    float _418;
    float _419;
    float _420;
    float3 _421;
    float3 _422;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _388 = ((_240.xy / float2(_240.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _392 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _388, level(0.0));
        float4 _395 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _388, level(0.0));
        float4 _398 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _388, level(0.0));
        float _408 = _398.w;
        _418 = (_368 * _408) + _398.z;
        _419 = (0.5 * _408) + _398.y;
        _420 = _398.x;
        _421 = (_362 * _392.w) + _392.xyz;
        _422 = normalize((_275 * _395.w) + ((_395.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _418 = _368;
        _419 = 0.5;
        _420 = 0.0;
        _421 = _362;
        _422 = _275;
    }
    float3 _432 = fast::clamp((_249 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _443 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_432.x), int(_432.y), int(_432.z), 0).xyz), 0));
    float3 _458 = (((_443.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_432 / float3(_443.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _471;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370)].z > 0.0)
    {
        _471 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _458, level(0.0)).x;
    }
    else
    {
        _471 = 1.0;
    }
    float3 _485 = ((_421 - (_421 * _420)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _492 = (mix(float3(0.07999999821186065673828125 * _419), _421, float3(_420)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _495 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _500;
    if (_495)
    {
        _500 = _485 + (_492 * 0.449999988079071044921875);
    }
    else
    {
        _500 = _485;
    }
    float3 _502 = select(_492, float3(0.0), bool3(_495));
    float3 _504 = float3(dot(_502, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _511 = float3(_363);
    float4 _522 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _458, level(0.0));
    float _538 = _522.x;
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _541 = _522.y;
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _544 = _522.z;
    float4 _546 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _544) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _563 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _565 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _567 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _458, level(0.0)) * 2.0) - float4(1.0)) * _544) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _600 = _183;
    _600.y = (-0.48860299587249755859375) * _422.y;
    float4 _603 = _600;
    _603.z = 0.48860299587249755859375 * _422.z;
    float4 _606 = _603;
    _606.w = (-0.48860299587249755859375) * _422.x;
    float3 _607 = _422 * _422;
    float4 _610 = _181;
    _610.x = (1.09254801273345947265625 * _422.x) * _422.y;
    float4 _613 = _610;
    _613.y = ((-1.09254801273345947265625) * _422.y) * _422.z;
    float4 _618 = _613;
    _618.z = 0.3153919875621795654296875 * ((3.0 * _607.z) - 1.0);
    float4 _621 = _618;
    _621.w = ((-1.09254801273345947265625) * _422.x) * _422.z;
    float4 _625 = _606;
    _625.x = 0.886227548122406005859375;
    float3 _627 = _625.yzw * 2.094395160675048828125;
    float4 _628 = float4(_625.x, _627.x, _627.y, _627.z);
    float4 _629 = _621 * 0.785398185253143310546875;
    float _630 = (_607.x - _607.y) * 0.4290426075458526611328125;
    float3 _636 = float3(0.0);
    _636.x = (dot(float4(_538, _540.xyz), _628) + dot(float4(_540.w, _563.xyz), _629)) + (_563.w * _630);
    float3 _642 = _636;
    _642.y = (dot(float4(_541, _543.xyz), _628) + dot(float4(_543.w, _565.xyz), _629)) + (_565.w * _630);
    float3 _648 = _642;
    _648.z = (dot(float4(_544, _546.xyz), _628) + dot(float4(_546.w, _567.xyz), _629)) + (_567.w * _630);
    float3 _653 = (fast::max(float3(0.0), _648) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _675 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _704;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _703;
        if (any(abs(_249 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _369 + 19u)].xyz + float3(1.0))))
        {
            _703 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_249, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _703 = _675;
        }
        _704 = _703;
    }
    else
    {
        _704 = _675;
    }
    float4 _711 = float4(((mix(float3(0.0), _500 + (_502 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_653 * _500) * fast::max(_511, ((((((_421 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _363) + ((_421 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _363) + ((_421 * 2.755199909210205078125) + float3(0.69029998779296875))) * _363))) + _704) * 1.0, 0.0);
    float4 _718;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _717 = _711;
        _717.w = 0.0;
        _718 = _717;
    }
    else
    {
        _718 = _711;
    }
    float2 _722 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _730 = (_422 * 0.5) + float3(0.5);
    float4 _732 = float4(_730.x, _730.y, _730.z, float4(0.0).w);
    _732.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _370)].y;
    float4 _733 = float4(0.0);
    _733.x = _420;
    float4 _734 = _733;
    _734.y = _419;
    float4 _735 = _734;
    _735.z = _418;
    float4 _736 = _735;
    _736.w = 0.50588238239288330078125;
    float4 _748 = float4(_421.x, _421.y, _421.z, float4(0.0).w);
    _748.w = ((log2(((dot(_653, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_511, ((((((_504 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _363) + ((_504 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _363) + ((_504 * 2.755199909210205078125) + float3(0.69029998779296875))) * _363).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_722.xyx * _722.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _718 * View.View_PreExposure;
    out.out_var_SV_Target1 = _732;
    out.out_var_SV_Target2 = _736;
    out.out_var_SV_Target3 = _748;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_471, 1.0, 1.0, 1.0);
    return out;
}

