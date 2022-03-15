

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

constant float4 _153 = {};
constant float _155 = {};
constant float4 _156 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003cac_65278456(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _239 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _244 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    uint _246 = _245 + 20u;
    float _295;
    float _296;
    float _297;
    float3 _298;
    float3 _299;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        float _290 = 0.5 * _284;
        _295 = (_244 * _284) + _274.z;
        _296 = _290 + _274.y;
        _297 = _290 + _274.x;
        _298 = (_239 * _268.w) + _268.xyz;
        _299 = normalize((_226 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _295 = _244;
        _296 = 0.5;
        _297 = 0.5;
        _298 = _239;
        _299 = _226;
    }
    float3 _309 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _320 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_309.x), int(_309.y), int(_309.z), 0).xyz), 0));
    float3 _335 = (((_320.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_309 / float3(_320.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _348;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].z > 0.0)
    {
        _348 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _335, level(0.0)).x;
    }
    else
    {
        _348 = 1.0;
    }
    float3 _362 = ((_298 - (_298 * _297)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _369 = (mix(float3(0.07999999821186065673828125 * _296), _298, float3(_297)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _372 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _377;
    if (_372)
    {
        _377 = _362 + (_369 * 0.449999988079071044921875);
    }
    else
    {
        _377 = _362;
    }
    float3 _379 = select(_369, float3(0.0), bool3(_372));
    float3 _381 = float3(dot(_379, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _398 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _335, level(0.0));
    float _414 = _398.x;
    float4 _416 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _417 = _398.y;
    float4 _419 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _420 = _398.z;
    float4 _422 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _439 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _414) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _441 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _417) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _443 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _335, level(0.0)) * 2.0) - float4(1.0)) * _420) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _476 = _156;
    _476.y = (-0.48860299587249755859375) * _299.y;
    float4 _479 = _476;
    _479.z = 0.48860299587249755859375 * _299.z;
    float4 _482 = _479;
    _482.w = (-0.48860299587249755859375) * _299.x;
    float3 _483 = _299 * _299;
    float4 _486 = _153;
    _486.x = (1.09254801273345947265625 * _299.x) * _299.y;
    float4 _489 = _486;
    _489.y = ((-1.09254801273345947265625) * _299.y) * _299.z;
    float4 _494 = _489;
    _494.z = 0.3153919875621795654296875 * ((3.0 * _483.z) - 1.0);
    float4 _497 = _494;
    _497.w = ((-1.09254801273345947265625) * _299.x) * _299.z;
    float4 _501 = _482;
    _501.x = 0.886227548122406005859375;
    float3 _503 = _501.yzw * 2.094395160675048828125;
    float4 _504 = float4(_501.x, _503.x, _503.y, _503.z);
    float4 _505 = _497 * 0.785398185253143310546875;
    float _506 = (_483.x - _483.y) * 0.4290426075458526611328125;
    float3 _512 = float3(0.0);
    _512.x = (dot(float4(_414, _416.xyz), _504) + dot(float4(_416.w, _439.xyz), _505)) + (_439.w * _506);
    float3 _518 = _512;
    _518.y = (dot(float4(_417, _419.xyz), _504) + dot(float4(_419.w, _441.xyz), _505)) + (_441.w * _506);
    float3 _524 = _518;
    _524.z = (dot(float4(_420, _422.xyz), _504) + dot(float4(_422.w, _443.xyz), _505)) + (_443.w * _506);
    float3 _529 = (fast::max(float3(0.0), _524) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _551 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _580;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _579;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _579 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _579 = _551;
        }
        _580 = _579;
    }
    else
    {
        _580 = _551;
    }
    float4 _587 = float4(((mix(float3(0.0), _377 + (_379 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_529 * _377) * fast::max(float3(1.0), ((((((_298 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_298 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_298 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _580) * 1.0, 0.0);
    float4 _594;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _593 = _587;
        _593.w = 0.0;
        _594 = _593;
    }
    else
    {
        _594 = _587;
    }
    float2 _598 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _606 = (_299 * 0.5) + float3(0.5);
    float4 _608 = float4(_606.x, _606.y, _606.z, float4(0.0).w);
    _608.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _609 = float4(0.0);
    _609.x = _297;
    float4 _610 = _609;
    _610.y = _296;
    float4 _611 = _610;
    _611.z = _295;
    float4 _612 = _611;
    _612.w = 0.50588238239288330078125;
    float4 _624 = float4(_298.x, _298.y, _298.z, float4(0.0).w);
    _624.w = ((log2(((dot(_529, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_381 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_381 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_381 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_598.xyx * _598.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _594 * View.View_PreExposure;
    out.out_var_SV_Target1 = _608;
    out.out_var_SV_Target2 = _612;
    out.out_var_SV_Target3 = _624;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_348, 1.0, 1.0, 1.0);
    return out;
}

