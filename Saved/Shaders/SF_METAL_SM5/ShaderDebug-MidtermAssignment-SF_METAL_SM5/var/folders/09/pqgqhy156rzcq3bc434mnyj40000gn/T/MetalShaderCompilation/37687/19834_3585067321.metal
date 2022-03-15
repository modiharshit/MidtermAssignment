

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

constant float4 _173 = {};
constant float3 _174 = {};
constant float _176 = {};
constant float4 _177 = {};

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

fragment MainPS_out Main_00004d7a_d5afc939(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], const device type_StructuredBuffer_v4float& View_SkyIrradianceEnvironmentMap [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_SkyBentNormalBrickTexture [[texture(8)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(11)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(12)]], texture2d<float> Material_Texture2D_0 [[texture(13)]], texture2d<float> Material_Texture2D_1 [[texture(14)]], texture2d<float> Material_Texture2D_2 [[texture(15)]], texture2d<float> Material_Texture2D_3 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    constant uint& View_SkyIrradianceEnvironmentMapBufferSize = spvBufferSizeConstants[1];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _176, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _253 = (_250.xy * float2(2.0)) - float2(1.0);
    float _260 = sqrt(fast::clamp(1.0 - dot(_253, _253), 0.0, 1.0)) + 1.0;
    float2 _261 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _261, bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float _272 = sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0));
    float3 _278 = float3(_253, _260);
    float3 _281 = float3(float4(_268, _272, 1.0).xy * (-1.0), _272);
    float3 _293 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_278 * dot(_278, _281)) - (_281 * _260)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _304 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _261, bias(View.View_MaterialTextureMipBias));
    float4 _308 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _313 = fast::clamp(_304.xyz, float3(0.0), float3(1.0));
    float _314 = fast::clamp(_308.x, 0.0, 1.0);
    float _319 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _320 = in.in_var_PRIMITIVE_ID * 36u;
    uint _321 = _320 + 20u;
    float _369;
    float _370;
    float _371;
    float3 _372;
    float3 _373;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _339 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _343 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float _359 = _349.w;
        _369 = (_319 * _359) + _349.z;
        _370 = (0.5 * _359) + _349.y;
        _371 = _349.x;
        _372 = (_313 * _343.w) + _343.xyz;
        _373 = normalize((_293 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _369 = _319;
        _370 = 0.5;
        _371 = 0.0;
        _372 = _313;
        _373 = _293;
    }
    float3 _383 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _394 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_383.x), int(_383.y), int(_383.z), 0).xyz), 0));
    float3 _409 = (((_394.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_383 / float3(_394.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _422;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].z > 0.0)
    {
        _422 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _409, level(0.0)).x;
    }
    else
    {
        _422 = 1.0;
    }
    float3 _436 = ((_372 - (_372 * _371)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _443 = (mix(float3(0.07999999821186065673828125 * _370), _372, float3(_371)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _446 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _451;
    if (_446)
    {
        _451 = _436 + (_443 * 0.449999988079071044921875);
    }
    else
    {
        _451 = _436;
    }
    float3 _453 = select(_443, float3(0.0), bool3(_446));
    float3 _455 = float3(dot(_453, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _462 = float3(_314);
    float4 _473 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _409, level(0.0));
    float _489 = _473.x;
    float4 _491 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _492 = _473.y;
    float4 _494 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _495 = _473.z;
    float4 _497 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _514 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _516 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = _177;
    _551.y = (-0.48860299587249755859375) * _373.y;
    float4 _554 = _551;
    _554.z = 0.48860299587249755859375 * _373.z;
    float4 _557 = _554;
    _557.w = (-0.48860299587249755859375) * _373.x;
    float3 _558 = _373 * _373;
    float4 _561 = _173;
    _561.x = (1.09254801273345947265625 * _373.x) * _373.y;
    float4 _564 = _561;
    _564.y = ((-1.09254801273345947265625) * _373.y) * _373.z;
    float4 _569 = _564;
    _569.z = 0.3153919875621795654296875 * ((3.0 * _558.z) - 1.0);
    float4 _572 = _569;
    _572.w = ((-1.09254801273345947265625) * _373.x) * _373.z;
    float4 _576 = _557;
    _576.x = 0.886227548122406005859375;
    float3 _578 = _576.yzw * 2.094395160675048828125;
    float4 _579 = float4(_576.x, _578.x, _578.y, _578.z);
    float4 _580 = _572 * 0.785398185253143310546875;
    float _581 = (_558.x - _558.y) * 0.4290426075458526611328125;
    float3 _587 = float3(0.0);
    _587.x = (dot(float4(_489, _491.xyz), _579) + dot(float4(_491.w, _514.xyz), _580)) + (_514.w * _581);
    float3 _593 = _587;
    _593.y = (dot(float4(_492, _494.xyz), _579) + dot(float4(_494.w, _516.xyz), _580)) + (_516.w * _581);
    float3 _599 = _593;
    _599.z = (dot(float4(_495, _497.xyz), _579) + dot(float4(_497.w, _518.xyz), _580)) + (_518.w * _581);
    float _628;
    float _629;
    float3 _630;
    if (View.View_SkyLightApplyPrecomputedBentNormalShadowingFlag != 0.0)
    {
        float3 _615 = (View_SkyBentNormalBrickTexture.sample(View_SharedBilinearClampedSampler, _409, level(0.0)).xyz * 2.0) - float3(1.0);
        float _616 = length(_615);
        float3 _619 = _615 / float3(fast::max(_616, 9.9999997473787516355514526367188e-05));
        float _620 = 1.0 - _616;
        float _622 = 1.0 - (_620 * _620);
        _628 = mix(fast::clamp(dot(_619, _373), 0.0, 1.0), 1.0, _622);
        _629 = _616;
        _630 = mix(_619, _373, float3(_622));
    }
    else
    {
        _628 = 1.0;
        _629 = 1.0;
        _630 = _373;
    }
    float4 _634 = float4(_630, 1.0);
    float3 _638 = _174;
    _638.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 0u)], _634);
    float3 _642 = _638;
    _642.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 1u)], _634);
    float3 _646 = _642;
    _646.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 2u)], _634);
    float4 _649 = _634.xyzz * _634.yzzx;
    float3 _653 = _174;
    _653.x = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 3u)], _649);
    float3 _657 = _653;
    _657.y = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 4u)], _649);
    float3 _661 = _657;
    _661.z = dot(View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 5u)], _649);
    float3 _676 = ((fast::max(float3(0.0), _599) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) + ((fast::max(float3(0.0), (_646 + _661) + (View_SkyIrradianceEnvironmentMap._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, 6u)].xyz * ((_630.x * _630.x) - (_630.y * _630.y)))) * View.View_SkyLightColor.xyz) * (_629 * _628));
    float3 _698 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _727;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _726;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 19u)].xyz + float3(1.0))))
        {
            _726 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _726 = _698;
        }
        _727 = _726;
    }
    else
    {
        _727 = _698;
    }
    float4 _734 = float4(((mix(float3(0.0), _451 + (_453 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_676 * _451) * fast::max(_462, ((((((_372 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_372 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_372 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314))) + _727) * 1.0, 0.0);
    float4 _741;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _740 = _734;
        _740.w = 0.0;
        _741 = _740;
    }
    else
    {
        _741 = _734;
    }
    float2 _745 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _753 = (_373 * 0.5) + float3(0.5);
    float4 _755 = float4(_753.x, _753.y, _753.z, float4(0.0).w);
    _755.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].y;
    float4 _756 = float4(0.0);
    _756.x = _371;
    float4 _757 = _756;
    _757.y = _370;
    float4 _758 = _757;
    _758.z = _369;
    float4 _759 = _758;
    _759.w = 0.50588238239288330078125;
    float4 _771 = float4(_372.x, _372.y, _372.z, float4(0.0).w);
    _771.w = ((log2(((dot(_676, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_462, ((((((_455 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_455 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_455 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_745.xyx * _745.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _741 * View.View_PreExposure;
    out.out_var_SV_Target1 = _755;
    out.out_var_SV_Target2 = _759;
    out.out_var_SV_Target3 = _771;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_422, 1.0, 1.0, 1.0);
    return out;
}

