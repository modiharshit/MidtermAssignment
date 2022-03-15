

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

constant float4 _169 = {};
constant float3 _170 = {};
constant float _172 = {};
constant float4 _173 = {};

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

fragment MainPS_out Main_000049be_2472edd5(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _172, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = (_235.xyz / float3(_235.w)) - View.View_PreViewTranslation;
    float3 _248 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _262 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _267 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _272 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float3 _279 = fast::clamp(float3(mix(1.0, 0.89999997615814208984375, (_262.x + 0.5) * ((_267.x + 0.5) * (_272.x + 0.5)))), float3(0.0), float3(1.0));
    float _283 = (0.25 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _284 = in.in_var_PRIMITIVE_ID * 36u;
    uint _285 = _284 + 20u;
    float _334;
    float _335;
    float _336;
    float3 _337;
    float3 _338;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _303 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _307 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _310 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float4 _313 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _303, level(0.0));
        float _323 = _313.w;
        _334 = (_283 * _323) + _313.z;
        _335 = (0.5 * _323) + _313.y;
        _336 = _323 + _313.x;
        _337 = (_279 * _307.w) + _307.xyz;
        _338 = normalize((_248 * _310.w) + ((_310.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _334 = _283;
        _335 = 0.5;
        _336 = 1.0;
        _337 = _279;
        _338 = _248;
    }
    float3 _348 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _359 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_348.x), int(_348.y), int(_348.z), 0).xyz), 0));
    float3 _374 = (((_359.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_348 / float3(_359.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _387;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].z > 0.0)
    {
        _387 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _374, level(0.0)).x;
    }
    else
    {
        _387 = 1.0;
    }
    float3 _401 = ((_337 - (_337 * _336)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _408 = (mix(float3(0.07999999821186065673828125 * _335), _337, float3(_336)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _411 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _416;
    if (_411)
    {
        _416 = _401 + (_408 * 0.449999988079071044921875);
    }
    else
    {
        _416 = _401;
    }
    float3 _418 = select(_408, float3(0.0), bool3(_411));
    float3 _420 = float3(dot(_418, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _437 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _374, level(0.0));
    float _453 = _437.x;
    float4 _455 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _453) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _456 = _437.y;
    float4 _458 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _456) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _459 = _437.z;
    float4 _461 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _459) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _478 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _453) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _480 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _456) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _482 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _374, level(0.0)) * 2.0) - float4(1.0)) * _459) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _515 = _173;
    _515.y = (-0.48860299587249755859375) * _338.y;
    float4 _518 = _515;
    _518.z = 0.48860299587249755859375 * _338.z;
    float4 _521 = _518;
    _521.w = (-0.48860299587249755859375) * _338.x;
    float3 _522 = _338 * _338;
    float4 _525 = _169;
    _525.x = (1.09254801273345947265625 * _338.x) * _338.y;
    float4 _528 = _525;
    _528.y = ((-1.09254801273345947265625) * _338.y) * _338.z;
    float4 _533 = _528;
    _533.z = 0.3153919875621795654296875 * ((3.0 * _522.z) - 1.0);
    float4 _536 = _533;
    _536.w = ((-1.09254801273345947265625) * _338.x) * _338.z;
    float4 _540 = _521;
    _540.x = 0.886227548122406005859375;
    float3 _542 = _540.yzw * 2.094395160675048828125;
    float4 _543 = float4(_540.x, _542.x, _542.y, _542.z);
    float4 _544 = _536 * 0.785398185253143310546875;
    float _545 = (_522.x - _522.y) * 0.4290426075458526611328125;
    float3 _551 = float3(0.0);
    _551.x = (dot(float4(_453, _455.xyz), _543) + dot(float4(_455.w, _478.xyz), _544)) + (_478.w * _545);
    float3 _557 = _551;
    _557.y = (dot(float4(_456, _458.xyz), _543) + dot(float4(_458.w, _480.xyz), _544)) + (_480.w * _545);
    float3 _563 = _557;
    _563.z = (dot(float4(_459, _461.xyz), _543) + dot(float4(_461.w, _482.xyz), _544)) + (_482.w * _545);
    float _592;
    float _593;
    float3 _594;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _579 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _374, level(0.0)).xyz * 2.0) - float3(1.0);
        float _580 = length(_579);
        float3 _583 = _579 / float3(fast::max(_580, 9.9999997473787516355514526367188e-05));
        float _584 = 1.0 - _580;
        float _586 = 1.0 - (_584 * _584);
        _592 = mix(fast::clamp(dot(_583, _338), 0.0, 1.0), 1.0, _586);
        _593 = _580;
        _594 = mix(_583, _338, float3(_586));
    }
    else
    {
        _592 = 1.0;
        _593 = 1.0;
        _594 = _338;
    }
    float4 _598 = float4(_594, 1.0);
    float3 _602 = _170;
    _602.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _598);
    float3 _606 = _602;
    _606.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _598);
    float3 _610 = _606;
    _610.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _598);
    float4 _613 = _598.xyzz * _598.yzzx;
    float3 _617 = _170;
    _617.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _613);
    float3 _621 = _617;
    _621.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _613);
    float3 _625 = _621;
    _625.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _613);
    float3 _640 = ((fast::max(float3(0.0), _563) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_610 + _625) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_594.x * _594.x) - (_594.y * _594.y)))) * View.View_SkyLightColor.xyz) * (_593 * _592));
    float3 _662 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _691;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _690;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _284 + 19u)].xyz + float3(1.0))))
        {
            _690 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _690 = _662;
        }
        _691 = _690;
    }
    else
    {
        _691 = _662;
    }
    float4 _698 = float4(((mix(float3(0.0), _416 + (_418 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_640 * _416) * fast::max(float3(1.0), ((((((_337 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_337 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_337 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _691) * 1.0, 0.0);
    float4 _705;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _704 = _698;
        _704.w = 0.0;
        _705 = _704;
    }
    else
    {
        _705 = _698;
    }
    float2 _709 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _717 = (_338 * 0.5) + float3(0.5);
    float4 _719 = float4(_717.x, _717.y, _717.z, float4(0.0).w);
    _719.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _285)].y;
    float4 _720 = float4(0.0);
    _720.x = _336;
    float4 _721 = _720;
    _721.y = _335;
    float4 _722 = _721;
    _722.z = _334;
    float4 _723 = _722;
    _723.w = 0.50588238239288330078125;
    float4 _735 = float4(_337.x, _337.y, _337.z, float4(0.0).w);
    _735.w = ((log2(((dot(_640, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_420 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_420 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_420 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_709.xyx * _709.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _705 * View.View_PreExposure;
    out.out_var_SV_Target1 = _719;
    out.out_var_SV_Target2 = _723;
    out.out_var_SV_Target3 = _735;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_387, 1.0, 1.0, 1.0);
    return out;
}

