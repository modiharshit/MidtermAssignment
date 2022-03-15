

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[20];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[36];
    float View_SkyLightApplyPrecomputedBentNormalShadowingFlag;
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _183 = {};
constant float4 _184 = {};
constant float3 _185 = {};
constant float _187 = {};
constant float4 _188 = {};
constant float3 _189 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00005bb5_ce298ce1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _251 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _187, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _256 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _261 = (_256.xyz / float3(_256.w)) - View.View_PreViewTranslation;
    uint _262 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _276 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _287 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _276.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _298 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _325 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _325) : (PrimitiveDither.PrimitiveDither_LODFactor < _325)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _298.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _340 = fast::clamp(_298.xyz, float3(0.0), float3(1.0));
    float _345 = (fast::clamp(_276.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _355 = (fast::clamp(float4(_305.xyz, _183).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _356 = _262 + 20u;
    float3 _405;
    float _406;
    float _407;
    float _408;
    float3 _409;
    float3 _410;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _374 = ((_251.xy / float2(_251.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _378 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _381 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _374, level(0.0));
        float _386 = _378.w;
        float _394 = _384.w;
        _405 = _355 * _386;
        _406 = (_345 * _394) + _384.z;
        _407 = (0.5 * _394) + _384.y;
        _408 = _384.x;
        _409 = (_340 * _386) + _378.xyz;
        _410 = normalize((_287 * _381.w) + ((_381.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _405 = _355;
        _406 = _345;
        _407 = 0.5;
        _408 = 0.0;
        _409 = _340;
        _410 = _287;
    }
    float3 _420 = fast::clamp((_261 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _431 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_420.x), int(_420.y), int(_420.z), 0).xyz), 0));
    float3 _446 = (((_431.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_420 / float3(_431.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _459;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].z > 0.0)
    {
        _459 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _446, level(0.0)).x;
    }
    else
    {
        _459 = 1.0;
    }
    float3 _462 = sqrt(fast::clamp(_405, float3(0.0), float3(1.0)));
    float4 _464 = float4(_462.x, _462.y, _462.z, float4(0.0).w);
    _464.w = 1.0;
    float3 _472 = ((_409 - (_409 * _408)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _479 = (mix(float3(0.07999999821186065673828125 * _407), _409, float3(_408)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _482 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _487;
    if (_482)
    {
        _487 = _472 + (_479 * 0.449999988079071044921875);
    }
    else
    {
        _487 = _472;
    }
    float3 _489 = select(_479, float3(0.0), bool3(_482));
    float3 _491 = float3(dot(_489, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _508 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _446, level(0.0));
    float _524 = _508.x;
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _527 = _508.y;
    float4 _529 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _530 = _508.z;
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _530) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _553 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _530) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _557 = float4(_524, _526.xyz);
    float4 _562 = float4(_526.w, _549.xyz);
    float _563 = _549.w;
    float4 _567 = float4(_527, _529.xyz);
    float4 _572 = float4(_529.w, _551.xyz);
    float _573 = _551.w;
    float4 _577 = float4(_530, _532.xyz);
    float4 _582 = float4(_532.w, _553.xyz);
    float _583 = _553.w;
    float4 _586 = _188;
    _586.y = (-0.48860299587249755859375) * _410.y;
    float4 _589 = _586;
    _589.z = 0.48860299587249755859375 * _410.z;
    float4 _592 = _589;
    _592.w = (-0.48860299587249755859375) * _410.x;
    float3 _593 = _410 * _410;
    float4 _596 = _184;
    _596.x = (1.09254801273345947265625 * _410.x) * _410.y;
    float4 _599 = _596;
    _599.y = ((-1.09254801273345947265625) * _410.y) * _410.z;
    float4 _604 = _599;
    _604.z = 0.3153919875621795654296875 * ((3.0 * _593.z) - 1.0);
    float4 _607 = _604;
    _607.w = ((-1.09254801273345947265625) * _410.x) * _410.z;
    float4 _611 = _592;
    _611.x = 0.886227548122406005859375;
    float3 _613 = _611.yzw * 2.094395160675048828125;
    float4 _614 = float4(_611.x, _613.x, _613.y, _613.z);
    float4 _615 = _607 * 0.785398185253143310546875;
    float _616 = (_593.x - _593.y) * 0.4290426075458526611328125;
    float3 _622 = float3(0.0);
    _622.x = (dot(_557, _614) + dot(_562, _615)) + (_563 * _616);
    float3 _628 = _622;
    _628.y = (dot(_567, _614) + dot(_572, _615)) + (_573 * _616);
    float3 _634 = _628;
    _634.z = (dot(_577, _614) + dot(_582, _615)) + (_583 * _616);
    float3 _637 = -_410;
    float _638 = _637.y;
    float4 _640 = _188;
    _640.y = (-0.48860299587249755859375) * _638;
    float _641 = _637.z;
    float4 _643 = _640;
    _643.z = 0.48860299587249755859375 * _641;
    float _644 = _637.x;
    float4 _646 = _643;
    _646.w = (-0.48860299587249755859375) * _644;
    float3 _647 = _637 * _637;
    float4 _650 = _184;
    _650.x = (1.09254801273345947265625 * _644) * _638;
    float4 _653 = _650;
    _653.y = ((-1.09254801273345947265625) * _638) * _641;
    float4 _658 = _653;
    _658.z = 0.3153919875621795654296875 * ((3.0 * _647.z) - 1.0);
    float4 _661 = _658;
    _661.w = ((-1.09254801273345947265625) * _644) * _641;
    float4 _665 = _646;
    _665.x = 0.886227548122406005859375;
    float3 _667 = _665.yzw * 2.094395160675048828125;
    float4 _668 = float4(_665.x, _667.x, _667.y, _667.z);
    float4 _669 = _661 * 0.785398185253143310546875;
    float _670 = (_647.x - _647.y) * 0.4290426075458526611328125;
    float3 _676 = _189;
    _676.x = (dot(_557, _668) + dot(_562, _669)) + (_563 * _670);
    float3 _682 = _676;
    _682.y = (dot(_567, _668) + dot(_572, _669)) + (_573 * _670);
    float3 _688 = _682;
    _688.z = (dot(_577, _668) + dot(_582, _669)) + (_583 * _670);
    float _718;
    float _719;
    float3 _720;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _705 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _446, level(0.0)).xyz * 2.0) - float3(1.0);
        float _706 = length(_705);
        float3 _709 = _705 / float3(fast::max(_706, 9.9999997473787516355514526367188e-05));
        float _710 = 1.0 - _706;
        float _712 = 1.0 - (_710 * _710);
        _718 = mix(fast::clamp(dot(_709, _410), 0.0, 1.0), 1.0, _712);
        _719 = _706;
        _720 = mix(_709, _410, float3(_712));
    }
    else
    {
        _718 = 1.0;
        _719 = 1.0;
        _720 = _410;
    }
    float4 _724 = float4(_720, 1.0);
    float3 _728 = _185;
    _728.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _724);
    float3 _732 = _728;
    _732.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _724);
    float3 _736 = _732;
    _736.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _724);
    float4 _739 = _724.xyzz * _724.yzzx;
    float3 _743 = _185;
    _743.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _739);
    float3 _747 = _743;
    _747.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _739);
    float3 _751 = _747;
    _751.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _739);
    float4 _766 = float4(_644, _638, _641, 1.0);
    float3 _769 = _189;
    _769.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _766);
    float3 _772 = _769;
    _772.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _766);
    float3 _775 = _772;
    _775.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _766);
    float4 _778 = _766.xyzz * _766.yzzx;
    float3 _781 = _189;
    _781.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _778);
    float3 _784 = _781;
    _784.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _778);
    float3 _787 = _784;
    _787.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _778);
    float3 _800 = ((fast::max(float3(0.0), _634) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_736 + _751) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_720.x * _720.x) - (_720.y * _720.y)))) * View.View_SkyLightColor.xyz) * (_719 * _718));
    float3 _824 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _853;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _852;
        if (any(abs(_261 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _262 + 19u)].xyz + float3(1.0))))
        {
            _852 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_261, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _852 = _824;
        }
        _853 = _852;
    }
    else
    {
        _853 = _824;
    }
    float4 _860 = float4(((mix(float3(0.0), _487 + (_489 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_800 * _487) + ((((fast::max(float3(0.0), _688) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_775 + _787) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_644 * _644) - (_638 * _638)))) * View.View_SkyLightColor.xyz) * _719)) * _405)) * fast::max(float3(1.0), ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _853) * 1.0, 0.0);
    float4 _867;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _866 = _860;
        _866.w = 0.0;
        _867 = _866;
    }
    else
    {
        _867 = _860;
    }
    float2 _871 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _879 = (_410 * 0.5) + float3(0.5);
    float4 _881 = float4(_879.x, _879.y, _879.z, float4(0.0).w);
    _881.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356)].y;
    float4 _882 = float4(0.0);
    _882.x = _408;
    float4 _883 = _882;
    _883.y = _407;
    float4 _884 = _883;
    _884.z = _406;
    float4 _885 = _884;
    _885.w = 0.525490224361419677734375;
    float4 _897 = float4(_409.x, _409.y, _409.z, float4(0.0).w);
    _897.w = ((log2(((dot(_800, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_491 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_491 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_491 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_871.xyx * _871.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _867 * View.View_PreExposure;
    out.out_var_SV_Target1 = _881;
    out.out_var_SV_Target2 = _885;
    out.out_var_SV_Target3 = _897;
    out.out_var_SV_Target4 = _464;
    out.out_var_SV_Target5 = float4(_459, 1.0, 1.0, 1.0);
    return out;
}

