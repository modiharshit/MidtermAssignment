

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
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _179 = {};
constant float4 _181 = {};

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

fragment MainPS_out Main_00004a2b_83c3a817(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _238 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _242 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = _242.xyz / float3(_242.w);
    float3 _247 = _246 - View.View_PreViewTranslation;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _297;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _297 = _238.w;
                break;
            }
            else
            {
                float _281 = _238.z;
                _297 = ((_281 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_281 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _313 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _270.x) + _297) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _325 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _330 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _335 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _339 = (_325.x + 0.5) * ((_330.x + 0.5) * (_335.x + 0.5));
    float4 _343 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _345 = _343.xyz * _339;
    float _347 = _345.x;
    float _351 = _345.y;
    float _355 = _345.z;
    float _364 = fast::max(abs(1.0 - fast::max(0.0, dot(in.in_var_TEXCOORD11_centroid.xyz, normalize(-_246)))), 9.9999997473787516355514526367188e-05);
    float3 _373 = fast::clamp(mix(_345 * 0.5, float3((_347 <= 0.0) ? 0.0 : pow(_347, 0.4000000059604644775390625), (_351 <= 0.0) ? 0.0 : pow(_351, 0.4000000059604644775390625), (_355 <= 0.0) ? 0.0 : pow(_355, 0.4000000059604644775390625)), float3((_364 <= 0.0) ? 0.0 : pow(_364, 3.0))), float3(0.0), float3(1.0));
    float _378 = (fast::clamp(mix(0.89999997615814208984375, 0.5, _339 * _343.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _379 = in.in_var_PRIMITIVE_ID * 36u;
    uint _380 = _379 + 20u;
    float _428;
    float _429;
    float _430;
    float3 _431;
    float3 _432;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _380)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _398 = ((_238.xy / float2(_238.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _402 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _398, level(0.0));
        float4 _405 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _398, level(0.0));
        float4 _408 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _398, level(0.0));
        float _418 = _408.w;
        _428 = (_378 * _418) + _408.z;
        _429 = (0.5 * _418) + _408.y;
        _430 = _408.x;
        _431 = (_373 * _402.w) + _402.xyz;
        _432 = normalize((_313 * _405.w) + ((_405.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _428 = _378;
        _429 = 0.5;
        _430 = 0.0;
        _431 = _373;
        _432 = _313;
    }
    float3 _442 = fast::clamp((_247 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _453 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_442.x), int(_442.y), int(_442.z), 0).xyz), 0));
    float3 _468 = (((_453.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_442 / float3(_453.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _481;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _380)].z > 0.0)
    {
        _481 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _468, level(0.0)).x;
    }
    else
    {
        _481 = 1.0;
    }
    float3 _495 = ((_431 - (_431 * _430)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _502 = (mix(float3(0.07999999821186065673828125 * _429), _431, float3(_430)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _505 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _510;
    if (_505)
    {
        _510 = _495 + (_502 * 0.449999988079071044921875);
    }
    else
    {
        _510 = _495;
    }
    float3 _512 = select(_502, float3(0.0), bool3(_505));
    float3 _514 = float3(dot(_512, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _531 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _468, level(0.0));
    float _547 = _531.x;
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _547) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _550 = _531.y;
    float4 _552 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _550) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _553 = _531.z;
    float4 _555 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _553) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _572 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _547) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _574 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _550) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _576 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _468, level(0.0)) * 2.0) - float4(1.0)) * _553) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _609 = _181;
    _609.y = (-0.48860299587249755859375) * _432.y;
    float4 _612 = _609;
    _612.z = 0.48860299587249755859375 * _432.z;
    float4 _615 = _612;
    _615.w = (-0.48860299587249755859375) * _432.x;
    float3 _616 = _432 * _432;
    float4 _619 = _179;
    _619.x = (1.09254801273345947265625 * _432.x) * _432.y;
    float4 _622 = _619;
    _622.y = ((-1.09254801273345947265625) * _432.y) * _432.z;
    float4 _627 = _622;
    _627.z = 0.3153919875621795654296875 * ((3.0 * _616.z) - 1.0);
    float4 _630 = _627;
    _630.w = ((-1.09254801273345947265625) * _432.x) * _432.z;
    float4 _634 = _615;
    _634.x = 0.886227548122406005859375;
    float3 _636 = _634.yzw * 2.094395160675048828125;
    float4 _637 = float4(_634.x, _636.x, _636.y, _636.z);
    float4 _638 = _630 * 0.785398185253143310546875;
    float _639 = (_616.x - _616.y) * 0.4290426075458526611328125;
    float3 _645 = float3(0.0);
    _645.x = (dot(float4(_547, _549.xyz), _637) + dot(float4(_549.w, _572.xyz), _638)) + (_572.w * _639);
    float3 _651 = _645;
    _651.y = (dot(float4(_550, _552.xyz), _637) + dot(float4(_552.w, _574.xyz), _638)) + (_574.w * _639);
    float3 _657 = _651;
    _657.z = (dot(float4(_553, _555.xyz), _637) + dot(float4(_555.w, _576.xyz), _638)) + (_576.w * _639);
    float3 _662 = (fast::max(float3(0.0), _657) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _684 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _713;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _712;
        if (any(abs(_247 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _379 + 19u)].xyz + float3(1.0))))
        {
            _712 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_247, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _712 = _684;
        }
        _713 = _712;
    }
    else
    {
        _713 = _684;
    }
    float4 _720 = float4(((mix(float3(0.0), _510 + (_512 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_662 * _510) * fast::max(float3(1.0), ((((((_431 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_431 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_431 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _713) * 1.0, 0.0);
    float4 _727;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _726 = _720;
        _726.w = 0.0;
        _727 = _726;
    }
    else
    {
        _727 = _720;
    }
    float2 _731 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _739 = (_432 * 0.5) + float3(0.5);
    float4 _741 = float4(_739.x, _739.y, _739.z, float4(0.0).w);
    _741.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _380)].y;
    float4 _742 = float4(0.0);
    _742.x = _430;
    float4 _743 = _742;
    _743.y = _429;
    float4 _744 = _743;
    _744.z = _428;
    float4 _745 = _744;
    _745.w = 0.50588238239288330078125;
    float4 _757 = float4(_431.x, _431.y, _431.z, float4(0.0).w);
    _757.w = ((log2(((dot(_662, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_514 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_514 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_514 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_731.xyx * _731.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _727 * View.View_PreExposure;
    out.out_var_SV_Target1 = _741;
    out.out_var_SV_Target2 = _745;
    out.out_var_SV_Target3 = _757;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_481, 1.0, 1.0, 1.0);
    return out;
}

