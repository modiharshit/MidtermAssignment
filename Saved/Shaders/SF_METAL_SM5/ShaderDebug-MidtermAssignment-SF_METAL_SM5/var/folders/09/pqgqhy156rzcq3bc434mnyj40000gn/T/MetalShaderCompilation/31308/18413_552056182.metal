

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

constant float4 _176 = {};
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

fragment MainPS_out Main_000047ed_20e7b576(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], texture2d<float> Material_Texture2D_4 [[texture(16)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], sampler Material_Texture2D_4Sampler [[sampler(6)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _224 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _178, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _240 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = _240.xyz / float3(_240.w);
    float3 _245 = _244 - View.View_PreViewTranslation;
    float2 _249 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float2 _261 = ((normalize(-_244) * _224).xy * ((0.00999999977648258209228515625 * _255.w) + (-0.004999999888241291046142578125))) + _249;
    float4 _265 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _261, bias(View.View_MaterialTextureMipBias));
    float2 _268 = (_265.xy * float2(2.0)) - float2(1.0);
    float4 _281 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.100000001490116119384765625), bias(2.0 + View.View_MaterialTextureMipBias));
    float2 _284 = (_281.xy * float2(2.0)) - float2(1.0);
    float3 _303 = normalize(_224 * normalize(((float4(_268, sqrt(fast::clamp(1.0 - dot(_268, _268), 0.0, 1.0)), 1.0).xyz + (float4(_284, sqrt(fast::clamp(1.0 - dot(_284, _284), 0.0, 1.0)), 1.0).xyz * float3(0.20000000298023223876953125, 0.20000000298023223876953125, 0.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _315 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _320 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _323 = (_315.x + 0.5) * (_320.x + 0.5);
    float4 _326 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _261, bias(View.View_MaterialTextureMipBias));
    float4 _332 = Material_Texture2D_4.sample(Material_Texture2D_4Sampler, _261, bias(View.View_MaterialTextureMipBias));
    float3 _338 = fast::clamp(_326.xyz * mix(0.5, 1.0, _323), float3(0.0), float3(1.0));
    float _339 = fast::clamp(_332.y, 0.0, 1.0);
    float _344 = (fast::clamp(mix(-0.300000011920928955078125, 0.800000011920928955078125, _332.x + (_323 * 0.20000000298023223876953125)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
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
        _397 = (_338 * _368.w) + _368.xyz;
        _398 = normalize((_303 * _371.w) + ((_371.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _394 = _344;
        _395 = 0.5;
        _396 = 0.0;
        _397 = _338;
        _398 = _303;
    }
    float3 _408 = fast::clamp((_245 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
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
    float3 _487 = float3(_339);
    float4 _498 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _434, level(0.0));
    float _514 = _498.x;
    float4 _516 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _517 = _498.y;
    float4 _519 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _520 = _498.z;
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _539 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _514) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _541 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _517) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _434, level(0.0)) * 2.0) - float4(1.0)) * _520) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _576 = _179;
    _576.y = (-0.48860299587249755859375) * _398.y;
    float4 _579 = _576;
    _579.z = 0.48860299587249755859375 * _398.z;
    float4 _582 = _579;
    _582.w = (-0.48860299587249755859375) * _398.x;
    float3 _583 = _398 * _398;
    float4 _586 = _176;
    _586.x = (1.09254801273345947265625 * _398.x) * _398.y;
    float4 _589 = _586;
    _589.y = ((-1.09254801273345947265625) * _398.y) * _398.z;
    float4 _594 = _589;
    _594.z = 0.3153919875621795654296875 * ((3.0 * _583.z) - 1.0);
    float4 _597 = _594;
    _597.w = ((-1.09254801273345947265625) * _398.x) * _398.z;
    float4 _601 = _582;
    _601.x = 0.886227548122406005859375;
    float3 _603 = _601.yzw * 2.094395160675048828125;
    float4 _604 = float4(_601.x, _603.x, _603.y, _603.z);
    float4 _605 = _597 * 0.785398185253143310546875;
    float _606 = (_583.x - _583.y) * 0.4290426075458526611328125;
    float3 _612 = float3(0.0);
    _612.x = (dot(float4(_514, _516.xyz), _604) + dot(float4(_516.w, _539.xyz), _605)) + (_539.w * _606);
    float3 _618 = _612;
    _618.y = (dot(float4(_517, _519.xyz), _604) + dot(float4(_519.w, _541.xyz), _605)) + (_541.w * _606);
    float3 _624 = _618;
    _624.z = (dot(float4(_520, _522.xyz), _604) + dot(float4(_522.w, _543.xyz), _605)) + (_543.w * _606);
    float3 _629 = (fast::max(float3(0.0), _624) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _651 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _680;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _679;
        if (any(abs(_245 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _345 + 19u)].xyz + float3(1.0))))
        {
            _679 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_245, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _679 = _651;
        }
        _680 = _679;
    }
    else
    {
        _680 = _651;
    }
    float4 _687 = float4(((mix(float3(0.0), _476 + (_478 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_629 * _476) * fast::max(_487, ((((((_397 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _339) + ((_397 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _339) + ((_397 * 2.755199909210205078125) + float3(0.69029998779296875))) * _339))) + _680) * 1.0, 0.0);
    float4 _694;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _693 = _687;
        _693.w = 0.0;
        _694 = _693;
    }
    else
    {
        _694 = _687;
    }
    float2 _698 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _706 = (_398 * 0.5) + float3(0.5);
    float4 _708 = float4(_706.x, _706.y, _706.z, float4(0.0).w);
    _708.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346)].y;
    float4 _709 = float4(0.0);
    _709.x = _396;
    float4 _710 = _709;
    _710.y = _395;
    float4 _711 = _710;
    _711.z = _394;
    float4 _712 = _711;
    _712.w = 0.50588238239288330078125;
    float4 _724 = float4(_397.x, _397.y, _397.z, float4(0.0).w);
    _724.w = ((log2(((dot(_629, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_487, ((((((_480 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _339) + ((_480 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _339) + ((_480 * 2.755199909210205078125) + float3(0.69029998779296875))) * _339).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_698.xyx * _698.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _694 * View.View_PreExposure;
    out.out_var_SV_Target1 = _708;
    out.out_var_SV_Target2 = _712;
    out.out_var_SV_Target3 = _724;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_447, 1.0, 1.0, 1.0);
    return out;
}

