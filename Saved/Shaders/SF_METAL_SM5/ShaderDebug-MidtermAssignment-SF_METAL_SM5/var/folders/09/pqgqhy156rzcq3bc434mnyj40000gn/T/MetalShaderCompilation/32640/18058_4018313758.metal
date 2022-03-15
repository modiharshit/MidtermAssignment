

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

constant float4 _177 = {};
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

fragment MainPS_out Main_0000468a_ef829a1e(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float3 _269 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_253, sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _280 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _303 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _330;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _330 = _235.w;
                break;
            }
            else
            {
                float _314 = _235.z;
                _330 = ((_314 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_314 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _339 = fast::clamp(_280.xyz * (mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_284.z)) * mix(0.5, 1.0, _284.x)), float3(0.0), float3(1.0));
    float _344 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, mix(_280.w, 0.5, fast::min(fast::max(((mix(-2000.0, 2000.0, _303.x) + _330) - 1000.0) * 0.001000000047497451305389404296875, 0.0), 1.0))), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _345 = in.in_var_PRIMITIVE_ID * 36u;
    uint _346 = _345 + 20u;
    float _394;
    float _395;
    float _396;
    float3 _397;
    float3 _398;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _364 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _368 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _371 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float4 _374 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _364, level(0.0));
        float _384 = _374.w;
        _394 = (_344 * _384) + _374.z;
        _395 = (0.5 * _384) + _374.y;
        _396 = _374.x;
        _397 = (_339 * _368.w) + _368.xyz;
        _398 = normalize((_269 * _371.w) + ((_371.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _394 = _344;
        _395 = 0.5;
        _396 = 0.0;
        _397 = _339;
        _398 = _269;
    }
    float3 _408 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _419 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_408.x), int(_408.y), int(_408.z), 0).xyz), 0));
    float3 _434 = (((_419.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_408 / float3(_419.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _447;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].z > 0.0)
    {
        _447 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _434, level(0.0)).x;
    }
    else
    {
        _447 = 1.0;
    }
    float3 _461 = ((_397 - (_397 * _396)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _468 = (mix(float3(0.07999999821186065673828125 * _395), _397, float3(_396)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _471 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _476;
    if (_471)
    {
        _476 = _461 + (_468 * 0.449999988079071044921875);
    }
    else
    {
        _476 = _461;
    }
    float3 _478 = select(_468, float3(0.0), bool3(_471));
    float3 _480 = float3(dot(_478, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _497 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _434, level(0.0));
    float _513 = _497.x;
    float4 _515 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _516 = _497.y;
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _519 = _497.z;
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _538 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _542 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _575 = _179;
    _575.y = (-0.48860299587249755859375) * _398.y;
    float4 _578 = _575;
    _578.z = 0.48860299587249755859375 * _398.z;
    float4 _581 = _578;
    _581.w = (-0.48860299587249755859375) * _398.x;
    float3 _582 = _398 * _398;
    float4 _585 = _177;
    _585.x = (1.09254801273345947265625 * _398.x) * _398.y;
    float4 _588 = _585;
    _588.y = ((-1.09254801273345947265625) * _398.y) * _398.z;
    float4 _593 = _588;
    _593.z = 0.3153919875621795654296875 * ((3.0 * _582.z) - 1.0);
    float4 _596 = _593;
    _596.w = ((-1.09254801273345947265625) * _398.x) * _398.z;
    float4 _600 = _581;
    _600.x = 0.886227548122406005859375;
    float3 _602 = _600.yzw * 2.094395160675048828125;
    float4 _603 = float4(_600.x, _602.x, _602.y, _602.z);
    float4 _604 = _596 * 0.785398185253143310546875;
    float _605 = (_582.x - _582.y) * 0.4290426075458526611328125;
    float3 _611 = float3(0.0);
    _611.x = (dot(float4(_513, _515.xyz), _603) + dot(float4(_515.w, _538.xyz), _604)) + (_538.w * _605);
    float3 _617 = _611;
    _617.y = (dot(float4(_516, _518.xyz), _603) + dot(float4(_518.w, _540.xyz), _604)) + (_540.w * _605);
    float3 _623 = _617;
    _623.z = (dot(float4(_519, _521.xyz), _603) + dot(float4(_521.w, _542.xyz), _604)) + (_542.w * _605);
    float3 _628 = (fast::max(float3(0.0), _623) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _650 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _679;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _678;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 19u)].xyz + float3(1.0))))
        {
            _678 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _678 = _650;
        }
        _679 = _678;
    }
    else
    {
        _679 = _650;
    }
    float4 _686 = float4(((mix(float3(0.0), _476 + (_478 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_628 * _476) * fast::max(float3(1.0), ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _679) * 1.0, 0.0);
    float4 _693;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _692 = _686;
        _692.w = 0.0;
        _693 = _692;
    }
    else
    {
        _693 = _686;
    }
    float2 _697 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _705 = (_398 * 0.5) + float3(0.5);
    float4 _707 = float4(_705.x, _705.y, _705.z, float4(0.0).w);
    _707.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].y;
    float4 _708 = float4(0.0);
    _708.x = _396;
    float4 _709 = _708;
    _709.y = _395;
    float4 _710 = _709;
    _710.z = _394;
    float4 _711 = _710;
    _711.w = 0.50588238239288330078125;
    float4 _723 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _723.w = ((log2(((dot(_628, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_480 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_480 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_480 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_697.xyx * _697.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _693 * View.View_PreExposure;
    out.out_var_SV_Target1 = _707;
    out.out_var_SV_Target2 = _711;
    out.out_var_SV_Target3 = _723;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_447, 1.0, 1.0, 1.0);
    return out;
}

