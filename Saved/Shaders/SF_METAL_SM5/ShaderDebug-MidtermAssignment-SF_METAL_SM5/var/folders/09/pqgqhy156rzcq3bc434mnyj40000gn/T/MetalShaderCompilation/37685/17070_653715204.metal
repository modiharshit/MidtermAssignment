

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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _167 = {};
constant float _169 = {};
constant float4 _170 = {};

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

fragment MainPS_out Main_000042ae_26f6e704(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _225 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _169, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _230 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = (_230.xyz / float3(_230.w)) - View.View_PreViewTranslation;
    float4 _241 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _244 = (_241.xy * float2(2.0)) - float2(1.0);
    float3 _260 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_244, sqrt(fast::clamp(1.0 - dot(_244, _244), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _271 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _278 = _271.y;
    float _284 = _271.z;
    float _287 = _271.x;
    float3 _305 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_278)), Material.Material_VectorExpressions[7].xyz, float3(_284)) * _287, float3(0.0), float3(1.0));
    float _306 = fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _278), Material.Material_ScalarExpressions[0].w, _284), 0.0, 1.0);
    float _307 = fast::clamp(_287, 0.0, 1.0);
    float _312 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[1].x, Material.Material_ScalarExpressions[1].y, _278), Material.Material_ScalarExpressions[1].z, _284), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _313 = in.in_var_PRIMITIVE_ID * 36u;
    uint _314 = _313 + 20u;
    float _364;
    float _365;
    float _366;
    float3 _367;
    float3 _368;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _332 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _336 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _339 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float4 _342 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _332, level(0.0));
        float _352 = _342.w;
        _364 = (_312 * _352) + _342.z;
        _365 = (0.5 * _352) + _342.y;
        _366 = (_306 * _352) + _342.x;
        _367 = (_305 * _336.w) + _336.xyz;
        _368 = normalize((_260 * _339.w) + ((_339.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _364 = _312;
        _365 = 0.5;
        _366 = _306;
        _367 = _305;
        _368 = _260;
    }
    float3 _378 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _389 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_378.x), int(_378.y), int(_378.z), 0).xyz), 0));
    float3 _404 = (((_389.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_378 / float3(_389.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _417;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].z > 0.0)
    {
        _417 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _404, level(0.0)).x;
    }
    else
    {
        _417 = 1.0;
    }
    float3 _431 = ((_367 - (_367 * _366)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _438 = (mix(float3(0.07999999821186065673828125 * _365), _367, float3(_366)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _441 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _446;
    if (_441)
    {
        _446 = _431 + (_438 * 0.449999988079071044921875);
    }
    else
    {
        _446 = _431;
    }
    float3 _448 = select(_438, float3(0.0), bool3(_441));
    float3 _450 = float3(dot(_448, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _457 = float3(_307);
    float4 _468 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _404, level(0.0));
    float _484 = _468.x;
    float4 _486 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _484) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _487 = _468.y;
    float4 _489 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _487) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _490 = _468.z;
    float4 _492 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _490) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _484) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _511 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _487) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _513 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _404, level(0.0)) * 2.0) - float4(1.0)) * _490) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _546 = _170;
    _546.y = (-0.48860299587249755859375) * _368.y;
    float4 _549 = _546;
    _549.z = 0.48860299587249755859375 * _368.z;
    float4 _552 = _549;
    _552.w = (-0.48860299587249755859375) * _368.x;
    float3 _553 = _368 * _368;
    float4 _556 = _167;
    _556.x = (1.09254801273345947265625 * _368.x) * _368.y;
    float4 _559 = _556;
    _559.y = ((-1.09254801273345947265625) * _368.y) * _368.z;
    float4 _564 = _559;
    _564.z = 0.3153919875621795654296875 * ((3.0 * _553.z) - 1.0);
    float4 _567 = _564;
    _567.w = ((-1.09254801273345947265625) * _368.x) * _368.z;
    float4 _571 = _552;
    _571.x = 0.886227548122406005859375;
    float3 _573 = _571.yzw * 2.094395160675048828125;
    float4 _574 = float4(_571.x, _573.x, _573.y, _573.z);
    float4 _575 = _567 * 0.785398185253143310546875;
    float _576 = (_553.x - _553.y) * 0.4290426075458526611328125;
    float3 _582 = float3(0.0);
    _582.x = (dot(float4(_484, _486.xyz), _574) + dot(float4(_486.w, _509.xyz), _575)) + (_509.w * _576);
    float3 _588 = _582;
    _588.y = (dot(float4(_487, _489.xyz), _574) + dot(float4(_489.w, _511.xyz), _575)) + (_511.w * _576);
    float3 _594 = _588;
    _594.z = (dot(float4(_490, _492.xyz), _574) + dot(float4(_492.w, _513.xyz), _575)) + (_513.w * _576);
    float3 _599 = (fast::max(float3(0.0), _594) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _621 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _650;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _649;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _313 + 19u)].xyz + float3(1.0))))
        {
            _649 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _649 = _621;
        }
        _650 = _649;
    }
    else
    {
        _650 = _621;
    }
    float4 _657 = float4(((mix(float3(0.0), _446 + (_448 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_599 * _446) * fast::max(_457, ((((((_367 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _307) + ((_367 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _307) + ((_367 * 2.755199909210205078125) + float3(0.69029998779296875))) * _307))) + _650) * 1.0, 0.0);
    float4 _664;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _663 = _657;
        _663.w = 0.0;
        _664 = _663;
    }
    else
    {
        _664 = _657;
    }
    float2 _668 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _676 = (_368 * 0.5) + float3(0.5);
    float4 _678 = float4(_676.x, _676.y, _676.z, float4(0.0).w);
    _678.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _314)].y;
    float4 _679 = float4(0.0);
    _679.x = _366;
    float4 _680 = _679;
    _680.y = _365;
    float4 _681 = _680;
    _681.z = _364;
    float4 _682 = _681;
    _682.w = 0.50588238239288330078125;
    float4 _694 = float4(_367.x, _367.y, _367.z, float4(0.0).w);
    _694.w = ((log2(((dot(_599, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_457, ((((((_450 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _307) + ((_450 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _307) + ((_450 * 2.755199909210205078125) + float3(0.69029998779296875))) * _307).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_668.xyx * _668.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _664 * View.View_PreExposure;
    out.out_var_SV_Target1 = _678;
    out.out_var_SV_Target2 = _682;
    out.out_var_SV_Target3 = _694;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_417, 1.0, 1.0, 1.0);
    return out;
}

