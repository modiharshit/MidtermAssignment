

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

constant float4 _171 = {};
constant float _173 = {};
constant float4 _174 = {};

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

fragment MainPS_out Main_0000465f_5f2adc44(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _219 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _230 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _173, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _235 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = _235.xyz / float3(_235.w);
    float3 _240 = _239 - View.View_PreViewTranslation;
    float2 _244 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _244, bias(View.View_MaterialTextureMipBias));
    float2 _256 = ((normalize(-_239) * _219).xy * ((0.00999999977648258209228515625 * _250.w) + (-0.008000000379979610443115234375))) + _244;
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float3 _279 = normalize(_219 * normalize((float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _291 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _301 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _305 = (_291.x + 0.5) * ((_296.x + 0.5) * (_301.x + 0.5));
    float4 _308 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float4 _314 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float3 _319 = fast::clamp(_308.xyz * mix(0.5, 1.0, _305), float3(0.0), float3(1.0));
    float _320 = fast::clamp(_314.y, 0.0, 1.0);
    float _325 = (fast::clamp(mix(0.300000011920928955078125, 0.800000011920928955078125, _305 * _314.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _326 = in.in_var_PRIMITIVE_ID * 36u;
    uint _327 = _326 + 20u;
    float _375;
    float _376;
    float _377;
    float3 _378;
    float3 _379;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _345 = ((_230.xy / float2(_230.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _349 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float4 _352 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float4 _355 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _345, level(0.0));
        float _365 = _355.w;
        _375 = (_325 * _365) + _355.z;
        _376 = (0.5 * _365) + _355.y;
        _377 = _355.x;
        _378 = (_319 * _349.w) + _349.xyz;
        _379 = normalize((_279 * _352.w) + ((_352.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _375 = _325;
        _376 = 0.5;
        _377 = 0.0;
        _378 = _319;
        _379 = _279;
    }
    float3 _389 = fast::clamp((_240 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _400 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_389.x), int(_389.y), int(_389.z), 0).xyz), 0));
    float3 _415 = (((_400.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_389 / float3(_400.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _428;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327)].z > 0.0)
    {
        _428 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _415, level(0.0)).x;
    }
    else
    {
        _428 = 1.0;
    }
    float3 _442 = ((_378 - (_378 * _377)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _449 = (mix(float3(0.07999999821186065673828125 * _376), _378, float3(_377)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _452 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _457;
    if (_452)
    {
        _457 = _442 + (_449 * 0.449999988079071044921875);
    }
    else
    {
        _457 = _442;
    }
    float3 _459 = select(_449, float3(0.0), bool3(_452));
    float3 _461 = float3(dot(_459, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _468 = float3(_320);
    float4 _479 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _415, level(0.0));
    float _495 = _479.x;
    float4 _497 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _498 = _479.y;
    float4 _500 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _501 = _479.z;
    float4 _503 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _498) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _415, level(0.0)) * 2.0) - float4(1.0)) * _501) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _557 = _174;
    _557.y = (-0.48860299587249755859375) * _379.y;
    float4 _560 = _557;
    _560.z = 0.48860299587249755859375 * _379.z;
    float4 _563 = _560;
    _563.w = (-0.48860299587249755859375) * _379.x;
    float3 _564 = _379 * _379;
    float4 _567 = _171;
    _567.x = (1.09254801273345947265625 * _379.x) * _379.y;
    float4 _570 = _567;
    _570.y = ((-1.09254801273345947265625) * _379.y) * _379.z;
    float4 _575 = _570;
    _575.z = 0.3153919875621795654296875 * ((3.0 * _564.z) - 1.0);
    float4 _578 = _575;
    _578.w = ((-1.09254801273345947265625) * _379.x) * _379.z;
    float4 _582 = _563;
    _582.x = 0.886227548122406005859375;
    float3 _584 = _582.yzw * 2.094395160675048828125;
    float4 _585 = float4(_582.x, _584.x, _584.y, _584.z);
    float4 _586 = _578 * 0.785398185253143310546875;
    float _587 = (_564.x - _564.y) * 0.4290426075458526611328125;
    float3 _593 = float3(0.0);
    _593.x = (dot(float4(_495, _497.xyz), _585) + dot(float4(_497.w, _520.xyz), _586)) + (_520.w * _587);
    float3 _599 = _593;
    _599.y = (dot(float4(_498, _500.xyz), _585) + dot(float4(_500.w, _522.xyz), _586)) + (_522.w * _587);
    float3 _605 = _599;
    _605.z = (dot(float4(_501, _503.xyz), _585) + dot(float4(_503.w, _524.xyz), _586)) + (_524.w * _587);
    float3 _610 = (fast::max(float3(0.0), _605) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _632 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _661;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _660;
        if (any(abs(_240 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _326 + 19u)].xyz + float3(1.0))))
        {
            _660 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_240, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _660 = _632;
        }
        _661 = _660;
    }
    else
    {
        _661 = _632;
    }
    float4 _668 = float4(((mix(float3(0.0), _457 + (_459 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_610 * _457) * fast::max(_468, ((((((_378 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _320) + ((_378 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _320) + ((_378 * 2.755199909210205078125) + float3(0.69029998779296875))) * _320))) + _661) * 1.0, 0.0);
    float4 _675;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _674 = _668;
        _674.w = 0.0;
        _675 = _674;
    }
    else
    {
        _675 = _668;
    }
    float2 _679 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _687 = (_379 * 0.5) + float3(0.5);
    float4 _689 = float4(_687.x, _687.y, _687.z, float4(0.0).w);
    _689.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _327)].y;
    float4 _690 = float4(0.0);
    _690.x = _377;
    float4 _691 = _690;
    _691.y = _376;
    float4 _692 = _691;
    _692.z = _375;
    float4 _693 = _692;
    _693.w = 0.50588238239288330078125;
    float4 _705 = float4(_378.x, _378.y, _378.z, float4(0.0).w);
    _705.w = ((log2(((dot(_610, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_468, ((((((_461 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _320) + ((_461 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _320) + ((_461 * 2.755199909210205078125) + float3(0.69029998779296875))) * _320).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_679.xyx * _679.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _675 * View.View_PreExposure;
    out.out_var_SV_Target1 = _689;
    out.out_var_SV_Target2 = _693;
    out.out_var_SV_Target3 = _705;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_428, 1.0, 1.0, 1.0);
    return out;
}

