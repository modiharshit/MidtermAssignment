

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
    char _m15_pad[188];
    float View_ShowDecalsMask;
    char _m16_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m17_pad[48];
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
constant float _171 = {};
constant float4 _172 = {};

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

fragment MainPS_out Main_000044ba_d7eeb82a(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _228 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _171, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _233 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _238 = (_233.xyz / float3(_233.w)) - View.View_PreViewTranslation;
    float4 _244 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _247 = (_244.xy * float2(2.0)) - float2(1.0);
    float _254 = sqrt(fast::clamp(1.0 - dot(_247, _247), 0.0, 1.0)) + 1.0;
    float4 _257 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 2.0), bias(View.View_MaterialTextureMipBias));
    float2 _260 = (_257.xy * float2(2.0)) - float2(1.0);
    float3 _269 = float4(_260, sqrt(fast::clamp(1.0 - dot(_260, _260), 0.0, 1.0)), 1.0).xyz * float3(-1.0, -1.0, 1.0);
    float3 _272 = float3(_247, _254);
    float3 _276 = float3(_269.xy * (-1.0), _269.z);
    float3 _288 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((_272 * dot(_272, _276)) - (_276 * _254)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _300 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _305 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.02999999932944774627685546875), bias(View.View_MaterialTextureMipBias));
    float4 _314 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _318 = fast::clamp(mix(float3(0.5), float3(1.0), float3((_300.x + 0.5) * (_305.x + 0.5))) * _314.xyz, float3(0.0), float3(1.0));
    float _319 = fast::clamp(_314.w, 0.0, 1.0);
    float _323 = (0.980000019073486328125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _324 = in.in_var_PRIMITIVE_ID * 36u;
    uint _325 = _324 + 20u;
    float _373;
    float _374;
    float _375;
    float3 _376;
    float3 _377;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _343 = ((_228.xy / float2(_228.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _347 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _350 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float4 _353 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _343, level(0.0));
        float _363 = _353.w;
        _373 = (_323 * _363) + _353.z;
        _374 = (_319 * _363) + _353.y;
        _375 = _353.x;
        _376 = (_318 * _347.w) + _347.xyz;
        _377 = normalize((_288 * _350.w) + ((_350.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _373 = _323;
        _374 = _319;
        _375 = 0.0;
        _376 = _318;
        _377 = _288;
    }
    float3 _387 = fast::clamp((_238 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _398 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_387.x), int(_387.y), int(_387.z), 0).xyz), 0));
    float3 _413 = (((_398.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_387 / float3(_398.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _426;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].z > 0.0)
    {
        _426 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _413, level(0.0)).x;
    }
    else
    {
        _426 = 1.0;
    }
    float3 _440 = ((_376 - (_376 * _375)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _447 = (mix(float3(0.07999999821186065673828125 * _374), _376, float3(_375)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _450 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _455;
    if (_450)
    {
        _455 = _440 + (_447 * 0.449999988079071044921875);
    }
    else
    {
        _455 = _440;
    }
    float3 _457 = select(_447, float3(0.0), bool3(_450));
    float3 _459 = float3(dot(_457, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _476 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _413, level(0.0));
    float _492 = _476.x;
    float4 _494 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _495 = _476.y;
    float4 _497 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _498 = _476.z;
    float4 _500 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _519 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _413, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _554 = _172;
    _554.y = (-0.48860299587249755859375) * _377.y;
    float4 _557 = _554;
    _557.z = 0.48860299587249755859375 * _377.z;
    float4 _560 = _557;
    _560.w = (-0.48860299587249755859375) * _377.x;
    float3 _561 = _377 * _377;
    float4 _564 = _169;
    _564.x = (1.09254801273345947265625 * _377.x) * _377.y;
    float4 _567 = _564;
    _567.y = ((-1.09254801273345947265625) * _377.y) * _377.z;
    float4 _572 = _567;
    _572.z = 0.3153919875621795654296875 * ((3.0 * _561.z) - 1.0);
    float4 _575 = _572;
    _575.w = ((-1.09254801273345947265625) * _377.x) * _377.z;
    float4 _579 = _560;
    _579.x = 0.886227548122406005859375;
    float3 _581 = _579.yzw * 2.094395160675048828125;
    float4 _582 = float4(_579.x, _581.x, _581.y, _581.z);
    float4 _583 = _575 * 0.785398185253143310546875;
    float _584 = (_561.x - _561.y) * 0.4290426075458526611328125;
    float3 _590 = float3(0.0);
    _590.x = (dot(float4(_492, _494.xyz), _582) + dot(float4(_494.w, _517.xyz), _583)) + (_517.w * _584);
    float3 _596 = _590;
    _596.y = (dot(float4(_495, _497.xyz), _582) + dot(float4(_497.w, _519.xyz), _583)) + (_519.w * _584);
    float3 _602 = _596;
    _602.z = (dot(float4(_498, _500.xyz), _582) + dot(float4(_500.w, _521.xyz), _583)) + (_521.w * _584);
    float3 _607 = (fast::max(float3(0.0), _602) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _629 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _658;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _657;
        if (any(abs(_238 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324 + 19u)].xyz + float3(1.0))))
        {
            _657 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_238, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _657 = _629;
        }
        _658 = _657;
    }
    else
    {
        _658 = _629;
    }
    float4 _665 = float4(((mix(float3(0.0), _455 + (_457 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_607 * _455) * fast::max(float3(1.0), ((((((_376 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_376 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_376 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _658) * 1.0, 0.0);
    float4 _672;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _671 = _665;
        _671.w = 0.0;
        _672 = _671;
    }
    else
    {
        _672 = _665;
    }
    float2 _676 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _684 = (_377 * 0.5) + float3(0.5);
    float4 _686 = float4(_684.x, _684.y, _684.z, float4(0.0).w);
    _686.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _325)].y;
    float4 _687 = float4(0.0);
    _687.x = _375;
    float4 _688 = _687;
    _688.y = _374;
    float4 _689 = _688;
    _689.z = _373;
    float4 _690 = _689;
    _690.w = 0.50588238239288330078125;
    float4 _702 = float4(_376.x, _376.y, _376.z, float4(0.0).w);
    _702.w = ((log2(((dot(_607, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_459 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_459 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_459 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_676.xyx * _676.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _672 * View.View_PreExposure;
    out.out_var_SV_Target1 = _686;
    out.out_var_SV_Target2 = _690;
    out.out_var_SV_Target3 = _702;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_426, 1.0, 1.0, 1.0);
    return out;
}

