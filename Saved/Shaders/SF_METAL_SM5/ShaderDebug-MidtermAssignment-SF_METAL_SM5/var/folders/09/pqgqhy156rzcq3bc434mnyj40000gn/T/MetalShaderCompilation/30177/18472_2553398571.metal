

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

constant float4 _166 = {};
constant float3 _167 = {};
constant float _169 = {};
constant float4 _170 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00004828_9831c52b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[0];
    float2 _219 = (gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw;
    float4 _225 = float4((_219 - float2(0.5)) * float2(2.0, -2.0), _169, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float3 _243 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (_219 * 4.0), bias(View.View_MaterialTextureMipBias));
    float3 _251 = _250.xyz;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _268 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _268) : (in.in_var_COLOR1.w < _268)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _279 = fast::clamp(_251, float3(0.0), float3(1.0));
    float _283 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _330;
    float _331;
    float _332;
    float3 _333;
    float3 _334;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _300 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _304 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _307 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _300, level(0.0));
        float _320 = _310.w;
        _330 = (_283 * _320) + _310.z;
        _331 = (0.5 * _320) + _310.y;
        _332 = _310.x;
        _333 = (_279 * _304.w) + _304.xyz;
        _334 = normalize((_243 * _307.w) + ((_307.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _330 = _283;
        _331 = 0.5;
        _332 = 0.0;
        _333 = _279;
        _334 = _243;
    }
    float3 _344 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _355 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_344.x), int(_344.y), int(_344.z), 0).xyz), 0));
    float3 _370 = (((_355.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_344 / float3(_355.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _383;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _383 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _370, level(0.0)).x;
    }
    else
    {
        _383 = 1.0;
    }
    float3 _397 = ((_333 - (_333 * _332)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _404 = (mix(float3(0.07999999821186065673828125 * _331), _333, float3(_332)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _407 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _412;
    if (_407)
    {
        _412 = _397 + (_404 * 0.449999988079071044921875);
    }
    else
    {
        _412 = _397;
    }
    float3 _414 = select(_404, float3(0.0), bool3(_407));
    float3 _416 = float3(dot(_414, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _433 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _370, level(0.0));
    float _449 = _433.x;
    float4 _451 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _452 = _433.y;
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _452) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _455 = _433.z;
    float4 _457 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _455) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _474 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _449) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _476 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _452) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _478 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _370, level(0.0)) * 2.0) - float4(1.0)) * _455) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _511 = _170;
    _511.y = (-0.48860299587249755859375) * _334.y;
    float4 _514 = _511;
    _514.z = 0.48860299587249755859375 * _334.z;
    float4 _517 = _514;
    _517.w = (-0.48860299587249755859375) * _334.x;
    float3 _518 = _334 * _334;
    float4 _521 = _166;
    _521.x = (1.09254801273345947265625 * _334.x) * _334.y;
    float4 _524 = _521;
    _524.y = ((-1.09254801273345947265625) * _334.y) * _334.z;
    float4 _529 = _524;
    _529.z = 0.3153919875621795654296875 * ((3.0 * _518.z) - 1.0);
    float4 _532 = _529;
    _532.w = ((-1.09254801273345947265625) * _334.x) * _334.z;
    float4 _536 = _517;
    _536.x = 0.886227548122406005859375;
    float3 _538 = _536.yzw * 2.094395160675048828125;
    float4 _539 = float4(_536.x, _538.x, _538.y, _538.z);
    float4 _540 = _532 * 0.785398185253143310546875;
    float _541 = (_518.x - _518.y) * 0.4290426075458526611328125;
    float3 _547 = float3(0.0);
    _547.x = (dot(float4(_449, _451.xyz), _539) + dot(float4(_451.w, _474.xyz), _540)) + (_474.w * _541);
    float3 _553 = _547;
    _553.y = (dot(float4(_452, _454.xyz), _539) + dot(float4(_454.w, _476.xyz), _540)) + (_476.w * _541);
    float3 _559 = _553;
    _559.z = (dot(float4(_455, _457.xyz), _539) + dot(float4(_457.w, _478.xyz), _540)) + (_478.w * _541);
    float _588;
    float _589;
    float3 _590;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _575 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _370, level(0.0)).xyz * 2.0) - float3(1.0);
        float _576 = length(_575);
        float3 _579 = _575 / float3(fast::max(_576, 9.9999997473787516355514526367188e-05));
        float _580 = 1.0 - _576;
        float _582 = 1.0 - (_580 * _580);
        _588 = mix(fast::clamp(dot(_579, _334), 0.0, 1.0), 1.0, _582);
        _589 = _576;
        _590 = mix(_579, _334, float3(_582));
    }
    else
    {
        _588 = 1.0;
        _589 = 1.0;
        _590 = _334;
    }
    float4 _594 = float4(_590, 1.0);
    float3 _598 = _167;
    _598.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 0u)], _594);
    float3 _602 = _598;
    _602.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 1u)], _594);
    float3 _606 = _602;
    _606.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 2u)], _594);
    float4 _609 = _594.xyzz * _594.yzzx;
    float3 _613 = _167;
    _613.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 3u)], _609);
    float3 _617 = _613;
    _617.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 4u)], _609);
    float3 _621 = _617;
    _621.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 5u)], _609);
    float3 _636 = ((fast::max(float3(0.0), _559) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_606 + _621) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, 6u)].xyz * ((_590.x * _590.x) - (_590.y * _590.y)))) * View.View_SkyLightColor.xyz) * (_589 * _588));
    float3 _658 = fast::max(mix(_251, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _684;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _683;
        if (any(abs(_235 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _683 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _683 = _658;
        }
        _684 = _683;
    }
    else
    {
        _684 = _658;
    }
    float4 _691 = float4(((mix(float3(0.0), _412 + (_414 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_636 * _412) * fast::max(float3(1.0), ((((((_333 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_333 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_333 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _684) * 1.0, 0.0);
    float4 _698;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _697 = _691;
        _697.w = 0.0;
        _698 = _697;
    }
    else
    {
        _698 = _691;
    }
    float2 _702 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _710 = (_334 * 0.5) + float3(0.5);
    float4 _712 = float4(_710.x, _710.y, _710.z, float4(0.0).w);
    _712.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _713 = float4(0.0);
    _713.x = _332;
    float4 _714 = _713;
    _714.y = _331;
    float4 _715 = _714;
    _715.z = _330;
    float4 _716 = _715;
    _716.w = 0.50588238239288330078125;
    float4 _728 = float4(_333.x, _333.y, _333.z, float4(0.0).w);
    _728.w = ((log2(((dot(_636, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_702.xyx * _702.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _698 * View.View_PreExposure;
    out.out_var_SV_Target1 = _712;
    out.out_var_SV_Target2 = _716;
    out.out_var_SV_Target3 = _728;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_383, 1.0, 1.0, 1.0);
    return out;
}

