

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

constant float4 _168 = {};
constant float _170 = {};
constant float4 _171 = {};

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

fragment MainPS_out Main_000043e4_3b42b9b2(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _170, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _274 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _288 = (_274.x + 0.5) * ((_279.x + 0.5) * (_284.x + 0.5));
    float4 _294 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _300 = fast::clamp(mix(float3(0.800000011920928955078125), float3(1.0), float3(_288)) * _294.xyz, float3(0.0), float3(1.0));
    float _305 = (fast::clamp(mix(0.800000011920928955078125, 0.5, _288 * _294.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _306 = in.in_var_PRIMITIVE_ID * 36u;
    uint _307 = _306 + 20u;
    float _355;
    float _356;
    float _357;
    float3 _358;
    float3 _359;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _325 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _329 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _332 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float4 _335 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _325, level(0.0));
        float _345 = _335.w;
        _355 = (_305 * _345) + _335.z;
        _356 = (0.5 * _345) + _335.y;
        _357 = _335.x;
        _358 = (_300 * _329.w) + _329.xyz;
        _359 = normalize((_262 * _332.w) + ((_332.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _355 = _305;
        _356 = 0.5;
        _357 = 0.0;
        _358 = _300;
        _359 = _262;
    }
    float3 _369 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _380 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_369.x), int(_369.y), int(_369.z), 0).xyz), 0));
    float3 _395 = (((_380.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_369 / float3(_380.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _408;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].z > 0.0)
    {
        _408 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _395, level(0.0)).x;
    }
    else
    {
        _408 = 1.0;
    }
    float3 _422 = ((_358 - (_358 * _357)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _429 = (mix(float3(0.07999999821186065673828125 * _356), _358, float3(_357)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _432 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _437;
    if (_432)
    {
        _437 = _422 + (_429 * 0.449999988079071044921875);
    }
    else
    {
        _437 = _422;
    }
    float3 _439 = select(_429, float3(0.0), bool3(_432));
    float3 _441 = float3(dot(_439, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _458 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _395, level(0.0));
    float _474 = _458.x;
    float4 _476 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _474) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _477 = _458.y;
    float4 _479 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _477) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _480 = _458.z;
    float4 _482 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _480) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _499 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _474) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _501 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _477) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _503 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _395, level(0.0)) * 2.0) - float4(1.0)) * _480) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _536 = _171;
    _536.y = (-0.48860299587249755859375) * _359.y;
    float4 _539 = _536;
    _539.z = 0.48860299587249755859375 * _359.z;
    float4 _542 = _539;
    _542.w = (-0.48860299587249755859375) * _359.x;
    float3 _543 = _359 * _359;
    float4 _546 = _168;
    _546.x = (1.09254801273345947265625 * _359.x) * _359.y;
    float4 _549 = _546;
    _549.y = ((-1.09254801273345947265625) * _359.y) * _359.z;
    float4 _554 = _549;
    _554.z = 0.3153919875621795654296875 * ((3.0 * _543.z) - 1.0);
    float4 _557 = _554;
    _557.w = ((-1.09254801273345947265625) * _359.x) * _359.z;
    float4 _561 = _542;
    _561.x = 0.886227548122406005859375;
    float3 _563 = _561.yzw * 2.094395160675048828125;
    float4 _564 = float4(_561.x, _563.x, _563.y, _563.z);
    float4 _565 = _557 * 0.785398185253143310546875;
    float _566 = (_543.x - _543.y) * 0.4290426075458526611328125;
    float3 _572 = float3(0.0);
    _572.x = (dot(float4(_474, _476.xyz), _564) + dot(float4(_476.w, _499.xyz), _565)) + (_499.w * _566);
    float3 _578 = _572;
    _578.y = (dot(float4(_477, _479.xyz), _564) + dot(float4(_479.w, _501.xyz), _565)) + (_501.w * _566);
    float3 _584 = _578;
    _584.z = (dot(float4(_480, _482.xyz), _564) + dot(float4(_482.w, _503.xyz), _565)) + (_503.w * _566);
    float3 _589 = (fast::max(float3(0.0), _584) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _611 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _640;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _639;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306 + 19u)].xyz + float3(1.0))))
        {
            _639 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _639 = _611;
        }
        _640 = _639;
    }
    else
    {
        _640 = _611;
    }
    float4 _647 = float4(((mix(float3(0.0), _437 + (_439 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_589 * _437) * fast::max(float3(1.0), ((((((_358 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_358 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_358 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _640) * 1.0, 0.0);
    float4 _654;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _653 = _647;
        _653.w = 0.0;
        _654 = _653;
    }
    else
    {
        _654 = _647;
    }
    float2 _658 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _666 = (_359 * 0.5) + float3(0.5);
    float4 _668 = float4(_666.x, _666.y, _666.z, float4(0.0).w);
    _668.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _307)].y;
    float4 _669 = float4(0.0);
    _669.x = _357;
    float4 _670 = _669;
    _670.y = _356;
    float4 _671 = _670;
    _671.z = _355;
    float4 _672 = _671;
    _672.w = 0.50588238239288330078125;
    float4 _684 = float4(_358.x, _358.y, _358.z, float4(0.0).w);
    _684.w = ((log2(((dot(_589, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_441 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_441 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_441 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_658.xyx * _658.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _654 * View.View_PreExposure;
    out.out_var_SV_Target1 = _668;
    out.out_var_SV_Target2 = _672;
    out.out_var_SV_Target3 = _684;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_408, 1.0, 1.0, 1.0);
    return out;
}

