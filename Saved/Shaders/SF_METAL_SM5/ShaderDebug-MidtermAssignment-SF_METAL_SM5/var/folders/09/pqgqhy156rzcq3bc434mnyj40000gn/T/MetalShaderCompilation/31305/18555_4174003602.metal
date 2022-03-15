

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

constant float4 _180 = {};
constant float4 _182 = {};

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

fragment MainPS_out Main_0000487b_f8ca3d92(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float4 _269 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _296;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _296 = _239.w;
                break;
            }
            else
            {
                float _280 = _239.z;
                _296 = ((_280 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_280 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _312 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _269.x) + _296) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _324 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _329 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _334 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _338 = (_324.x + 0.5) * ((_329.x + 0.5) * (_334.x + 0.5));
    float4 _344 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _350 = fast::clamp(mix(float3(0.20000000298023223876953125), float3(1.0), float3(_338)) * _344.xyz, float3(0.0), float3(1.0));
    float _355 = (fast::clamp(mix(0.4000000059604644775390625, 0.800000011920928955078125, _338 * _344.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _356 = in.in_var_PRIMITIVE_ID * 36u;
    uint _357 = _356 + 20u;
    float _405;
    float _406;
    float _407;
    float3 _408;
    float3 _409;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _375 = ((_239.xy / float2(_239.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _379 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float4 _382 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float4 _385 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _375, level(0.0));
        float _395 = _385.w;
        _405 = (_355 * _395) + _385.z;
        _406 = (0.5 * _395) + _385.y;
        _407 = _385.x;
        _408 = (_350 * _379.w) + _379.xyz;
        _409 = normalize((_312 * _382.w) + ((_382.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _405 = _355;
        _406 = 0.5;
        _407 = 0.0;
        _408 = _350;
        _409 = _312;
    }
    float3 _419 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _430 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_419.x), int(_419.y), int(_419.z), 0).xyz), 0));
    float3 _445 = (((_430.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_419 / float3(_430.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _458;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].z > 0.0)
    {
        _458 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _445, level(0.0)).x;
    }
    else
    {
        _458 = 1.0;
    }
    float3 _472 = ((_408 - (_408 * _407)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _479 = (mix(float3(0.07999999821186065673828125 * _406), _408, float3(_407)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _482 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _487;
    if (_482)
    {
        _487 = _472 + (_479 * 0.449999988079071044921875);
    }
    else
    {
        _487 = _472;
    }
    float3 _489 = select(_479, float3(0.0), bool3(_482));
    float3 _491 = float3(dot(_489, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _508 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _445, level(0.0));
    float _524 = _508.x;
    float4 _526 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _527 = _508.y;
    float4 _529 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _530 = _508.z;
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _530) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _524) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _527) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _553 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _445, level(0.0)) * 2.0) - float4(1.0)) * _530) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _586 = _182;
    _586.y = (-0.48860299587249755859375) * _409.y;
    float4 _589 = _586;
    _589.z = 0.48860299587249755859375 * _409.z;
    float4 _592 = _589;
    _592.w = (-0.48860299587249755859375) * _409.x;
    float3 _593 = _409 * _409;
    float4 _596 = _180;
    _596.x = (1.09254801273345947265625 * _409.x) * _409.y;
    float4 _599 = _596;
    _599.y = ((-1.09254801273345947265625) * _409.y) * _409.z;
    float4 _604 = _599;
    _604.z = 0.3153919875621795654296875 * ((3.0 * _593.z) - 1.0);
    float4 _607 = _604;
    _607.w = ((-1.09254801273345947265625) * _409.x) * _409.z;
    float4 _611 = _592;
    _611.x = 0.886227548122406005859375;
    float3 _613 = _611.yzw * 2.094395160675048828125;
    float4 _614 = float4(_611.x, _613.x, _613.y, _613.z);
    float4 _615 = _607 * 0.785398185253143310546875;
    float _616 = (_593.x - _593.y) * 0.4290426075458526611328125;
    float3 _622 = float3(0.0);
    _622.x = (dot(float4(_524, _526.xyz), _614) + dot(float4(_526.w, _549.xyz), _615)) + (_549.w * _616);
    float3 _628 = _622;
    _628.y = (dot(float4(_527, _529.xyz), _614) + dot(float4(_529.w, _551.xyz), _615)) + (_551.w * _616);
    float3 _634 = _628;
    _634.z = (dot(float4(_530, _532.xyz), _614) + dot(float4(_532.w, _553.xyz), _615)) + (_553.w * _616);
    float3 _639 = (fast::max(float3(0.0), _634) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _661 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _690;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _689;
        if (any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _356 + 19u)].xyz + float3(1.0))))
        {
            _689 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _689 = _661;
        }
        _690 = _689;
    }
    else
    {
        _690 = _661;
    }
    float4 _697 = float4(((mix(float3(0.0), _487 + (_489 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_639 * _487) * fast::max(float3(1.0), ((((((_408 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_408 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_408 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _690) * 1.0, 0.0);
    float4 _704;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _703 = _697;
        _703.w = 0.0;
        _704 = _703;
    }
    else
    {
        _704 = _697;
    }
    float2 _708 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _716 = (_409 * 0.5) + float3(0.5);
    float4 _718 = float4(_716.x, _716.y, _716.z, float4(0.0).w);
    _718.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _357)].y;
    float4 _719 = float4(0.0);
    _719.x = _407;
    float4 _720 = _719;
    _720.y = _406;
    float4 _721 = _720;
    _721.z = _405;
    float4 _722 = _721;
    _722.w = 0.50588238239288330078125;
    float4 _734 = float4(_408.x, _408.y, _408.z, float4(0.0).w);
    _734.w = ((log2(((dot(_639, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_491 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_491 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_491 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_708.xyx * _708.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _704 * View.View_PreExposure;
    out.out_var_SV_Target1 = _718;
    out.out_var_SV_Target2 = _722;
    out.out_var_SV_Target3 = _734;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_458, 1.0, 1.0, 1.0);
    return out;
}

