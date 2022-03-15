

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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _175 = {};
constant float3 _176 = {};
constant float _178 = {};
constant float4 _179 = {};

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

fragment MainPS_out Main_00004e0e_cd13790d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _236 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _178, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float _262 = sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)) + 1.0;
    float4 _265 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float3 _277 = float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _280 = float3(_255, _262);
    float3 _284 = float3(_277.xy * (-1.0), _277.z);
    float3 _296 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_280 * dot(_280, _284)) - (_284 * _262)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _308 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _313 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _322 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _326 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_308.x + 0.5) * (_313.x + 0.5))) * _322.xyz, float3(0.0), float3(1.0));
    float _327 = fast::clamp(_322.w, 0.0, 1.0);
    float _331 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _332 = in.in_var_PRIMITIVE_ID * 36u;
    uint _333 = _332 + 20u;
    float _381;
    float _382;
    float _383;
    float3 _384;
    float3 _385;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _351 = ((_236.xy / float2(_236.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _355 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _358 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float4 _361 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _351, level(0.0));
        float _371 = _361.w;
        _381 = (_331 * _371) + _361.z;
        _382 = (_327 * _371) + _361.y;
        _383 = _361.x;
        _384 = (_326 * _355.w) + _355.xyz;
        _385 = normalize((_296 * _358.w) + ((_358.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _381 = _331;
        _382 = _327;
        _383 = 0.0;
        _384 = _326;
        _385 = _296;
    }
    float3 _395 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _406 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_395.x), int(_395.y), int(_395.z), 0).xyz), 0));
    float3 _421 = (((_406.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_395 / float3(_406.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _434;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333)].z > 0.0)
    {
        _434 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _421, level(0.0)).x;
    }
    else
    {
        _434 = 1.0;
    }
    float3 _448 = ((_384 - (_384 * _383)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _455 = (mix(float3(0.07999999821186065673828125 * _382), _384, float3(_383)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _458 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _463;
    if (_458)
    {
        _463 = _448 + (_455 * 0.449999988079071044921875);
    }
    else
    {
        _463 = _448;
    }
    float3 _465 = select(_455, float3(0.0), bool3(_458));
    float3 _467 = float3(dot(_465, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _484 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _421, level(0.0));
    float _500 = _484.x;
    float4 _502 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _500) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _503 = _484.y;
    float4 _505 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _506 = _484.z;
    float4 _508 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _525 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _500) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _527 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _503) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _529 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _421, level(0.0)) * 2.0) - float4(1.0)) * _506) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _562 = _179;
    _562.y = (-0.48860299587249755859375) * _385.y;
    float4 _565 = _562;
    _565.z = 0.48860299587249755859375 * _385.z;
    float4 _568 = _565;
    _568.w = (-0.48860299587249755859375) * _385.x;
    float3 _569 = _385 * _385;
    float4 _572 = _175;
    _572.x = (1.09254801273345947265625 * _385.x) * _385.y;
    float4 _575 = _572;
    _575.y = ((-1.09254801273345947265625) * _385.y) * _385.z;
    float4 _580 = _575;
    _580.z = 0.3153919875621795654296875 * ((3.0 * _569.z) - 1.0);
    float4 _583 = _580;
    _583.w = ((-1.09254801273345947265625) * _385.x) * _385.z;
    float4 _587 = _568;
    _587.x = 0.886227548122406005859375;
    float3 _589 = _587.yzw * 2.094395160675048828125;
    float4 _590 = float4(_587.x, _589.x, _589.y, _589.z);
    float4 _591 = _583 * 0.785398185253143310546875;
    float _592 = (_569.x - _569.y) * 0.4290426075458526611328125;
    float3 _598 = float3(0.0);
    _598.x = (dot(float4(_500, _502.xyz), _590) + dot(float4(_502.w, _525.xyz), _591)) + (_525.w * _592);
    float3 _604 = _598;
    _604.y = (dot(float4(_503, _505.xyz), _590) + dot(float4(_505.w, _527.xyz), _591)) + (_527.w * _592);
    float3 _610 = _604;
    _610.z = (dot(float4(_506, _508.xyz), _590) + dot(float4(_508.w, _529.xyz), _591)) + (_529.w * _592);
    float _639;
    float _640;
    float3 _641;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _626 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _421, level(0.0)).xyz * 2.0) - float3(1.0);
        float _627 = length(_626);
        float3 _630 = _626 / float3(fast::max(_627, 9.9999997473787516355514526367188e-05));
        float _631 = 1.0 - _627;
        float _633 = 1.0 - (_631 * _631);
        _639 = mix(fast::clamp(dot(_630, _385), 0.0, 1.0), 1.0, _633);
        _640 = _627;
        _641 = mix(_630, _385, float3(_633));
    }
    else
    {
        _639 = 1.0;
        _640 = 1.0;
        _641 = _385;
    }
    float4 _645 = float4(_641, 1.0);
    float3 _649 = _176;
    _649.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _645);
    float3 _653 = _649;
    _653.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _645);
    float3 _657 = _653;
    _657.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _645);
    float4 _660 = _645.xyzz * _645.yzzx;
    float3 _664 = _176;
    _664.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _660);
    float3 _668 = _664;
    _668.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _660);
    float3 _672 = _668;
    _672.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _660);
    float3 _687 = ((fast::max(float3(0.0), _610) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_657 + _672) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_641.x * _641.x) - (_641.y * _641.y)))) * View.View_SkyLightColor.xyz) * (_640 * _639));
    float3 _709 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _738;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _737;
        if (any(abs(_246 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _332 + 19u)].xyz + float3(1.0))))
        {
            _737 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _737 = _709;
        }
        _738 = _737;
    }
    else
    {
        _738 = _709;
    }
    float4 _745 = float4(((mix(float3(0.0), _463 + (_465 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_687 * _463) * fast::max(float3(1.0), ((((((_384 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_384 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_384 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _738) * 1.0, 0.0);
    float4 _752;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _751 = _745;
        _751.w = 0.0;
        _752 = _751;
    }
    else
    {
        _752 = _745;
    }
    float2 _756 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _764 = (_385 * 0.5) + float3(0.5);
    float4 _766 = float4(_764.x, _764.y, _764.z, float4(0.0).w);
    _766.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _333)].y;
    float4 _767 = float4(0.0);
    _767.x = _383;
    float4 _768 = _767;
    _768.y = _382;
    float4 _769 = _768;
    _769.z = _381;
    float4 _770 = _769;
    _770.w = 0.50588238239288330078125;
    float4 _782 = float4(_384.x, _384.y, _384.z, float4(0.0).w);
    _782.w = ((log2(((dot(_687, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_467 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_467 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_467 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_756.xyx * _756.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _752 * View.View_PreExposure;
    out.out_var_SV_Target1 = _766;
    out.out_var_SV_Target2 = _770;
    out.out_var_SV_Target3 = _782;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_434, 1.0, 1.0, 1.0);
    return out;
}

