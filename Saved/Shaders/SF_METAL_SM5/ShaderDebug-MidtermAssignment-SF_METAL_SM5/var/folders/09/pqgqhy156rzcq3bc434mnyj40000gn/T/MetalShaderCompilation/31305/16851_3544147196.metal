

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
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
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

fragment MainPS_out Main_000041d3_d33f64fc(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
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
    float _278 = _271.z;
    float _284 = _271.y;
    float3 _298 = fast::clamp(mix(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_278)), Material.Material_VectorExpressions[7].xyz, float3(_284)) * _271.x, float3(0.0), float3(1.0));
    float _299 = fast::clamp(mix(0.0, 1.0, _284), 0.0, 1.0);
    float _304 = (fast::clamp(mix(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _278), Material.Material_ScalarExpressions[0].w, _284), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _305 = in.in_var_PRIMITIVE_ID * 36u;
    uint _306 = _305 + 20u;
    float _356;
    float _357;
    float _358;
    float3 _359;
    float3 _360;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _324 = ((_225.xy / float2(_225.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _328 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _331 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float4 _334 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _324, level(0.0));
        float _344 = _334.w;
        _356 = (_304 * _344) + _334.z;
        _357 = (0.5 * _344) + _334.y;
        _358 = (_299 * _344) + _334.x;
        _359 = (_298 * _328.w) + _328.xyz;
        _360 = normalize((_260 * _331.w) + ((_331.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _356 = _304;
        _357 = 0.5;
        _358 = _299;
        _359 = _298;
        _360 = _260;
    }
    float3 _370 = fast::clamp((_235 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _381 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_370.x), int(_370.y), int(_370.z), 0).xyz), 0));
    float3 _396 = (((_381.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_370 / float3(_381.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _409;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].z > 0.0)
    {
        _409 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _396, level(0.0)).x;
    }
    else
    {
        _409 = 1.0;
    }
    float3 _423 = ((_359 - (_359 * _358)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _430 = (mix(float3(0.07999999821186065673828125 * _357), _359, float3(_358)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _433 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _438;
    if (_433)
    {
        _438 = _423 + (_430 * 0.449999988079071044921875);
    }
    else
    {
        _438 = _423;
    }
    float3 _440 = select(_430, float3(0.0), bool3(_433));
    float3 _442 = float3(dot(_440, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _459 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _396, level(0.0));
    float _475 = _459.x;
    float4 _477 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _475) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _478 = _459.y;
    float4 _480 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _478) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _481 = _459.z;
    float4 _483 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _481) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _500 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _475) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _502 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _478) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _504 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _396, level(0.0)) * 2.0) - float4(1.0)) * _481) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _537 = _170;
    _537.y = (-0.48860299587249755859375) * _360.y;
    float4 _540 = _537;
    _540.z = 0.48860299587249755859375 * _360.z;
    float4 _543 = _540;
    _543.w = (-0.48860299587249755859375) * _360.x;
    float3 _544 = _360 * _360;
    float4 _547 = _167;
    _547.x = (1.09254801273345947265625 * _360.x) * _360.y;
    float4 _550 = _547;
    _550.y = ((-1.09254801273345947265625) * _360.y) * _360.z;
    float4 _555 = _550;
    _555.z = 0.3153919875621795654296875 * ((3.0 * _544.z) - 1.0);
    float4 _558 = _555;
    _558.w = ((-1.09254801273345947265625) * _360.x) * _360.z;
    float4 _562 = _543;
    _562.x = 0.886227548122406005859375;
    float3 _564 = _562.yzw * 2.094395160675048828125;
    float4 _565 = float4(_562.x, _564.x, _564.y, _564.z);
    float4 _566 = _558 * 0.785398185253143310546875;
    float _567 = (_544.x - _544.y) * 0.4290426075458526611328125;
    float3 _573 = float3(0.0);
    _573.x = (dot(float4(_475, _477.xyz), _565) + dot(float4(_477.w, _500.xyz), _566)) + (_500.w * _567);
    float3 _579 = _573;
    _579.y = (dot(float4(_478, _480.xyz), _565) + dot(float4(_480.w, _502.xyz), _566)) + (_502.w * _567);
    float3 _585 = _579;
    _585.z = (dot(float4(_481, _483.xyz), _565) + dot(float4(_483.w, _504.xyz), _566)) + (_504.w * _567);
    float3 _590 = (fast::max(float3(0.0), _585) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _612 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _641;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _640;
        if (any(abs(_235 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _305 + 19u)].xyz + float3(1.0))))
        {
            _640 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_235, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _640 = _612;
        }
        _641 = _640;
    }
    else
    {
        _641 = _612;
    }
    float4 _648 = float4(((mix(float3(0.0), _438 + (_440 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_590 * _438) * fast::max(float3(1.0), ((((((_359 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_359 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_359 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _641) * 1.0, 0.0);
    float4 _655;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _654 = _648;
        _654.w = 0.0;
        _655 = _654;
    }
    else
    {
        _655 = _648;
    }
    float2 _659 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _667 = (_360 * 0.5) + float3(0.5);
    float4 _669 = float4(_667.x, _667.y, _667.z, float4(0.0).w);
    _669.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _306)].y;
    float4 _670 = float4(0.0);
    _670.x = _358;
    float4 _671 = _670;
    _671.y = _357;
    float4 _672 = _671;
    _672.z = _356;
    float4 _673 = _672;
    _673.w = 0.50588238239288330078125;
    float4 _685 = float4(_359.x, _359.y, _359.z, float4(0.0).w);
    _685.w = ((log2(((dot(_590, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_442 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_442 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_442 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_659.xyx * _659.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _655 * View.View_PreExposure;
    out.out_var_SV_Target1 = _669;
    out.out_var_SV_Target2 = _673;
    out.out_var_SV_Target3 = _685;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_409, 1.0, 1.0, 1.0);
    return out;
}

