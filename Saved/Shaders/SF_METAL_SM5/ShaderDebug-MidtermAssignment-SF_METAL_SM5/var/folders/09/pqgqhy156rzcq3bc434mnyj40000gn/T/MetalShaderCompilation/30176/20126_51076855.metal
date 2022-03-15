

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
    char _m17_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
    float4 View_SkyLightColor;
    char _m19_pad[124];
    float View_ShowDecalsMask;
    char _m20_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m21_pad[48];
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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _181 = {};
constant float3 _182 = {};
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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD1_0 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004e9e_030b5ef7(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD1 = {};
    in_var_TEXCOORD1[0] = in.in_var_TEXCOORD1_0;
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float4 _244 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = (_248.xyz / float3(_248.w)) - View.View_PreViewTranslation;
    float4 _261 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _264 = (_261.xy * float2(2.0)) - float2(1.0);
    float3 _281 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_264, sqrt(fast::clamp(1.0 - dot(_264, _264), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _293 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _295 = mix(0.4000000059604644775390625, 1.0, _293.x);
    float4 _299 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _324;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _324 = _244.w;
                break;
            }
            else
            {
                float _308 = _244.z;
                _324 = ((_308 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_308 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _328 = fast::min(fast::max((_324 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _329 = _299.y;
    float4 _333 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD1[0].x, in_var_TEXCOORD1[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _335 = _333.y;
    float3 _348 = fast::clamp(float3(mix(_295, 1.0 - _295, mix(_329, 1.0, _328)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_335 + mix(_329, 0.0, _328), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _353 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _335) + mix(mix(0.699999988079071044921875, 1.0, _329), 1.0, _328), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _400;
    float _401;
    float _402;
    float3 _403;
    float3 _404;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _370 = ((_244.xy / float2(_244.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _374 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _377 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _370, level(0.0));
        float _390 = _380.w;
        _400 = (_353 * _390) + _380.z;
        _401 = (0.5 * _390) + _380.y;
        _402 = _380.x;
        _403 = (_348 * _374.w) + _374.xyz;
        _404 = normalize((_281 * _377.w) + ((_377.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _400 = _353;
        _401 = 0.5;
        _402 = 0.0;
        _403 = _348;
        _404 = _281;
    }
    float3 _414 = fast::clamp((_253 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _425 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_414.x), int(_414.y), int(_414.z), 0).xyz), 0));
    float3 _440 = (((_425.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_414 / float3(_425.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _453;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _453 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _440, level(0.0)).x;
    }
    else
    {
        _453 = 1.0;
    }
    float3 _467 = ((_403 - (_403 * _402)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _474 = (mix(float3(0.07999999821186065673828125 * _401), _403, float3(_402)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
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
    float4 _503 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _440, level(0.0));
    float _519 = _503.x;
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _522 = _503.y;
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _525 = _503.z;
    float4 _527 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _544 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _546 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _548 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _440, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _581 = _184;
    _581.y = (-0.48860299587249755859375) * _404.y;
    float4 _584 = _581;
    _584.z = 0.48860299587249755859375 * _404.z;
    float4 _587 = _584;
    _587.w = (-0.48860299587249755859375) * _404.x;
    float3 _588 = _404 * _404;
    float4 _591 = _181;
    _591.x = (1.09254801273345947265625 * _404.x) * _404.y;
    float4 _594 = _591;
    _594.y = ((-1.09254801273345947265625) * _404.y) * _404.z;
    float4 _599 = _594;
    _599.z = 0.3153919875621795654296875 * ((3.0 * _588.z) - 1.0);
    float4 _602 = _599;
    _602.w = ((-1.09254801273345947265625) * _404.x) * _404.z;
    float4 _606 = _587;
    _606.x = 0.886227548122406005859375;
    float3 _608 = _606.yzw * 2.094395160675048828125;
    float4 _609 = float4(_606.x, _608.x, _608.y, _608.z);
    float4 _610 = _602 * 0.785398185253143310546875;
    float _611 = (_588.x - _588.y) * 0.4290426075458526611328125;
    float3 _617 = float3(0.0);
    _617.x = (dot(float4(_519, _521.xyz), _609) + dot(float4(_521.w, _544.xyz), _610)) + (_544.w * _611);
    float3 _623 = _617;
    _623.y = (dot(float4(_522, _524.xyz), _609) + dot(float4(_524.w, _546.xyz), _610)) + (_546.w * _611);
    float3 _629 = _623;
    _629.z = (dot(float4(_525, _527.xyz), _609) + dot(float4(_527.w, _548.xyz), _610)) + (_548.w * _611);
    float _658;
    float _659;
    float3 _660;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _645 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _440, level(0.0)).xyz * 2.0) - float3(1.0);
        float _646 = length(_645);
        float3 _649 = _645 / float3(fast::max(_646, 9.9999997473787516355514526367188e-05));
        float _650 = 1.0 - _646;
        float _652 = 1.0 - (_650 * _650);
        _658 = mix(fast::clamp(dot(_649, _404), 0.0, 1.0), 1.0, _652);
        _659 = _646;
        _660 = mix(_649, _404, float3(_652));
    }
    else
    {
        _658 = 1.0;
        _659 = 1.0;
        _660 = _404;
    }
    float4 _664 = float4(_660, 1.0);
    float3 _668 = _182;
    _668.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _664);
    float3 _672 = _668;
    _672.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _664);
    float3 _676 = _672;
    _676.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _664);
    float4 _679 = _664.xyzz * _664.yzzx;
    float3 _683 = _182;
    _683.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _679);
    float3 _687 = _683;
    _687.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _679);
    float3 _691 = _687;
    _691.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _679);
    float3 _706 = ((fast::max(float3(0.0), _629) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_676 + _691) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_660.x * _660.x) - (_660.y * _660.y)))) * View.View_SkyLightColor.xyz) * (_659 * _658));
    float3 _728 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _754;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _753;
        if (any(abs(_253 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _753 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _753 = _728;
        }
        _754 = _753;
    }
    else
    {
        _754 = _728;
    }
    float4 _761 = float4(((mix(float3(0.0), _482 + (_484 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_706 * _482) * fast::max(float3(1.0), ((((((_403 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_403 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_403 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _754) * 1.0, 0.0);
    float4 _768;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _767 = _761;
        _767.w = 0.0;
        _768 = _767;
    }
    else
    {
        _768 = _761;
    }
    float2 _772 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _780 = (_404 * 0.5) + float3(0.5);
    float4 _782 = float4(_780.x, _780.y, _780.z, float4(0.0).w);
    _782.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _783 = float4(0.0);
    _783.x = _402;
    float4 _784 = _783;
    _784.y = _401;
    float4 _785 = _784;
    _785.z = _400;
    float4 _786 = _785;
    _786.w = 0.50588238239288330078125;
    float4 _798 = float4(_403.x, _403.y, _403.z, float4(0.0).w);
    _798.w = ((log2(((dot(_706, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_486 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_486 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_486 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_772.xyx * _772.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _768 * View.View_PreExposure;
    out.out_var_SV_Target1 = _782;
    out.out_var_SV_Target2 = _786;
    out.out_var_SV_Target3 = _798;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_453, 1.0, 1.0, 1.0);
    return out;
}

