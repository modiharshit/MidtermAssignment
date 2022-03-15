

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
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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

constant float _178 = {};
constant float4 _179 = {};
constant float _181 = {};
constant float4 _182 = {};
constant float3 _183 = {};

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

fragment MainPS_out Main_00004da8_51b897fb(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_3 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _181, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = (_248.xyz / float3(_248.w)) - View.View_PreViewTranslation;
    uint _254 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _279 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _268.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _290 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _297 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _317 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _317) : (PrimitiveDither.PrimitiveDither_LODFactor < _317)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _290.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _332 = fast::clamp(_290.xyz, float3(0.0), float3(1.0));
    float _337 = (fast::clamp(_268.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _347 = (fast::clamp(float4(_297.xyz, _178).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _348 = _254 + 20u;
    float3 _397;
    float _398;
    float _399;
    float _400;
    float3 _401;
    float3 _402;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _366 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _370 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _373 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float4 _376 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _366, level(0.0));
        float _378 = _370.w;
        float _386 = _376.w;
        _397 = _347 * _378;
        _398 = (_337 * _386) + _376.z;
        _399 = (0.5 * _386) + _376.y;
        _400 = _376.x;
        _401 = (_332 * _378) + _370.xyz;
        _402 = normalize((_279 * _373.w) + ((_373.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _397 = _347;
        _398 = _337;
        _399 = 0.5;
        _400 = 0.0;
        _401 = _332;
        _402 = _279;
    }
    float3 _412 = fast::clamp((_253 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _423 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_412.x), int(_412.y), int(_412.z), 0).xyz), 0));
    float3 _438 = (((_423.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_412 / float3(_423.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _451;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].z > 0.0)
    {
        _451 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _438, level(0.0)).x;
    }
    else
    {
        _451 = 1.0;
    }
    float3 _454 = sqrt(fast::clamp(_397, float3(0.0), float3(1.0)));
    float4 _456 = float4(_454.x, _454.y, _454.z, float4(0.0).w);
    _456.w = 1.0;
    float3 _464 = ((_401 - (_401 * _400)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _471 = (mix(float3(0.07999999821186065673828125 * _399), _401, float3(_400)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _474 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _479;
    if (_474)
    {
        _479 = _464 + (_471 * 0.449999988079071044921875);
    }
    else
    {
        _479 = _464;
    }
    float3 _481 = select(_471, float3(0.0), bool3(_474));
    float3 _483 = float3(dot(_481, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _500 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _438, level(0.0));
    float _516 = _500.x;
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _519 = _500.y;
    float4 _521 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _522 = _500.z;
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _516) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _519) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _545 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _438, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _549 = float4(_516, _518.xyz);
    float4 _554 = float4(_518.w, _541.xyz);
    float _555 = _541.w;
    float4 _559 = float4(_519, _521.xyz);
    float4 _564 = float4(_521.w, _543.xyz);
    float _565 = _543.w;
    float4 _569 = float4(_522, _524.xyz);
    float4 _574 = float4(_524.w, _545.xyz);
    float _575 = _545.w;
    float4 _578 = _182;
    _578.y = (-0.48860299587249755859375) * _402.y;
    float4 _581 = _578;
    _581.z = 0.48860299587249755859375 * _402.z;
    float4 _584 = _581;
    _584.w = (-0.48860299587249755859375) * _402.x;
    float3 _585 = _402 * _402;
    float4 _588 = _179;
    _588.x = (1.09254801273345947265625 * _402.x) * _402.y;
    float4 _591 = _588;
    _591.y = ((-1.09254801273345947265625) * _402.y) * _402.z;
    float4 _596 = _591;
    _596.z = 0.3153919875621795654296875 * ((3.0 * _585.z) - 1.0);
    float4 _599 = _596;
    _599.w = ((-1.09254801273345947265625) * _402.x) * _402.z;
    float4 _603 = _584;
    _603.x = 0.886227548122406005859375;
    float3 _605 = _603.yzw * 2.094395160675048828125;
    float4 _606 = float4(_603.x, _605.x, _605.y, _605.z);
    float4 _607 = _599 * 0.785398185253143310546875;
    float _608 = (_585.x - _585.y) * 0.4290426075458526611328125;
    float3 _614 = float3(0.0);
    _614.x = (dot(_549, _606) + dot(_554, _607)) + (_555 * _608);
    float3 _620 = _614;
    _620.y = (dot(_559, _606) + dot(_564, _607)) + (_565 * _608);
    float3 _626 = _620;
    _626.z = (dot(_569, _606) + dot(_574, _607)) + (_575 * _608);
    float3 _629 = -_402;
    float _630 = _629.y;
    float4 _632 = _182;
    _632.y = (-0.48860299587249755859375) * _630;
    float _633 = _629.z;
    float4 _635 = _632;
    _635.z = 0.48860299587249755859375 * _633;
    float _636 = _629.x;
    float4 _638 = _635;
    _638.w = (-0.48860299587249755859375) * _636;
    float3 _639 = _629 * _629;
    float4 _642 = _179;
    _642.x = (1.09254801273345947265625 * _636) * _630;
    float4 _645 = _642;
    _645.y = ((-1.09254801273345947265625) * _630) * _633;
    float4 _650 = _645;
    _650.z = 0.3153919875621795654296875 * ((3.0 * _639.z) - 1.0);
    float4 _653 = _650;
    _653.w = ((-1.09254801273345947265625) * _636) * _633;
    float4 _657 = _638;
    _657.x = 0.886227548122406005859375;
    float3 _659 = _657.yzw * 2.094395160675048828125;
    float4 _660 = float4(_657.x, _659.x, _659.y, _659.z);
    float4 _661 = _653 * 0.785398185253143310546875;
    float _662 = (_639.x - _639.y) * 0.4290426075458526611328125;
    float3 _668 = _183;
    _668.x = (dot(_549, _660) + dot(_554, _661)) + (_555 * _662);
    float3 _674 = _668;
    _674.y = (dot(_559, _660) + dot(_564, _661)) + (_565 * _662);
    float3 _680 = _674;
    _680.z = (dot(_569, _660) + dot(_574, _661)) + (_575 * _662);
    float3 _685 = (fast::max(float3(0.0), _626) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _710 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _739;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _738;
        if (any(abs(_253 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _254 + 19u)].xyz + float3(1.0))))
        {
            _738 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _738 = _710;
        }
        _739 = _738;
    }
    else
    {
        _739 = _710;
    }
    float4 _746 = float4(((mix(float3(0.0), _479 + (_481 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_685 * _479) + (((fast::max(float3(0.0), _680) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _397)) * fast::max(float3(1.0), ((((((_401 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_401 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_401 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _739) * 1.0, 0.0);
    float4 _753;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _752 = _746;
        _752.w = 0.0;
        _753 = _752;
    }
    else
    {
        _753 = _746;
    }
    float2 _757 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _765 = (_402 * 0.5) + float3(0.5);
    float4 _767 = float4(_765.x, _765.y, _765.z, float4(0.0).w);
    _767.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _348)].y;
    float4 _768 = float4(0.0);
    _768.x = _400;
    float4 _769 = _768;
    _769.y = _399;
    float4 _770 = _769;
    _770.z = _398;
    float4 _771 = _770;
    _771.w = 0.525490224361419677734375;
    float4 _783 = float4(_401.x, _401.y, _401.z, float4(0.0).w);
    _783.w = ((log2(((dot(_685, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_483 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_483 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_483 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_757.xyx * _757.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _753 * View.View_PreExposure;
    out.out_var_SV_Target1 = _767;
    out.out_var_SV_Target2 = _771;
    out.out_var_SV_Target3 = _783;
    out.out_var_SV_Target4 = _456;
    out.out_var_SV_Target5 = float4(_451, 1.0, 1.0, 1.0);
    return out;
}

