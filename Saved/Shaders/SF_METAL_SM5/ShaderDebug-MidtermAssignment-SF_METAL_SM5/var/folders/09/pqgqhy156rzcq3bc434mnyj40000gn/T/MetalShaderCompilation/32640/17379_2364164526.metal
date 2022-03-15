

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
    spvUnsafeArray<float4, 4> Material_VectorExpressions;
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

fragment MainPS_out Main_000043e3_8cea49ae(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _215 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _226 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _169, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _231 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _235 = _231.xyz / float3(_231.w);
    float3 _236 = _235 - View.View_PreViewTranslation;
    float4 _245 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _251 = ((normalize(-_235) * _215).xy * ((0.0500000007450580596923828125 * _245.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _255 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float _265 = sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)) + 1.0;
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0), bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float4 _280 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _251, bias(View.View_MaterialTextureMipBias));
    float _282 = _280.y;
    float3 _284 = mix(float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(_282));
    float3 _287 = float3(_258, _265);
    float3 _291 = float3(_284.xy * (-1.0), _284.z);
    float3 _303 = normalize(_215 * normalize((((_287 * dot(_287, _291)) - (_291 * _265)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _317 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _280.x, float3(0.0), float3(1.0));
    float _318 = fast::clamp(mix(1.0, 0.0, _282), 0.0, 1.0);
    float _322 = (0.300000011920928955078125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _323 = in.in_var_PRIMITIVE_ID * 36u;
    uint _324 = _323 + 20u;
    float _374;
    float _375;
    float _376;
    float3 _377;
    float3 _378;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _342 = ((_226.xy / float2(_226.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _346 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float4 _352 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _342, level(0.0));
        float _362 = _352.w;
        _374 = (_322 * _362) + _352.z;
        _375 = (0.5 * _362) + _352.y;
        _376 = (_318 * _362) + _352.x;
        _377 = (_317 * _346.w) + _346.xyz;
        _378 = normalize((_303 * _349.w) + ((_349.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _374 = _322;
        _375 = 0.5;
        _376 = _318;
        _377 = _317;
        _378 = _303;
    }
    float3 _388 = fast::clamp((_236 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _399 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_388.x), int(_388.y), int(_388.z), 0).xyz), 0));
    float3 _414 = (((_399.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_388 / float3(_399.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _427;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].z > 0.0)
    {
        _427 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _414, level(0.0)).x;
    }
    else
    {
        _427 = 1.0;
    }
    float3 _441 = ((_377 - (_377 * _376)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _448 = (mix(float3(0.07999999821186065673828125 * _375), _377, float3(_376)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _451 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _456;
    if (_451)
    {
        _456 = _441 + (_448 * 0.449999988079071044921875);
    }
    else
    {
        _456 = _441;
    }
    float3 _458 = select(_448, float3(0.0), bool3(_451));
    float3 _460 = float3(dot(_458, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _477 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _414, level(0.0));
    float _493 = _477.x;
    float4 _495 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _493) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _496 = _477.y;
    float4 _498 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _496) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _499 = _477.z;
    float4 _501 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _499) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _493) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _520 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _496) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _522 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _414, level(0.0)) * 2.0) - float4(1.0)) * _499) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _555 = _170;
    _555.y = (-0.48860299587249755859375) * _378.y;
    float4 _558 = _555;
    _558.z = 0.48860299587249755859375 * _378.z;
    float4 _561 = _558;
    _561.w = (-0.48860299587249755859375) * _378.x;
    float3 _562 = _378 * _378;
    float4 _565 = _167;
    _565.x = (1.09254801273345947265625 * _378.x) * _378.y;
    float4 _568 = _565;
    _568.y = ((-1.09254801273345947265625) * _378.y) * _378.z;
    float4 _573 = _568;
    _573.z = 0.3153919875621795654296875 * ((3.0 * _562.z) - 1.0);
    float4 _576 = _573;
    _576.w = ((-1.09254801273345947265625) * _378.x) * _378.z;
    float4 _580 = _561;
    _580.x = 0.886227548122406005859375;
    float3 _582 = _580.yzw * 2.094395160675048828125;
    float4 _583 = float4(_580.x, _582.x, _582.y, _582.z);
    float4 _584 = _576 * 0.785398185253143310546875;
    float _585 = (_562.x - _562.y) * 0.4290426075458526611328125;
    float3 _591 = float3(0.0);
    _591.x = (dot(float4(_493, _495.xyz), _583) + dot(float4(_495.w, _518.xyz), _584)) + (_518.w * _585);
    float3 _597 = _591;
    _597.y = (dot(float4(_496, _498.xyz), _583) + dot(float4(_498.w, _520.xyz), _584)) + (_520.w * _585);
    float3 _603 = _597;
    _603.z = (dot(float4(_499, _501.xyz), _583) + dot(float4(_501.w, _522.xyz), _584)) + (_522.w * _585);
    float3 _608 = (fast::max(float3(0.0), _603) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _630 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _659;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _658;
        if (any(abs(_236 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _323 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _323 + 19u)].xyz + float3(1.0))))
        {
            _658 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_236, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _658 = _630;
        }
        _659 = _658;
    }
    else
    {
        _659 = _630;
    }
    float4 _666 = float4(((mix(float3(0.0), _456 + (_458 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_608 * _456) * fast::max(float3(1.0), ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _659) * 1.0, 0.0);
    float4 _673;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _672 = _666;
        _672.w = 0.0;
        _673 = _672;
    }
    else
    {
        _673 = _666;
    }
    float2 _677 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _685 = (_378 * 0.5) + float3(0.5);
    float4 _687 = float4(_685.x, _685.y, _685.z, float4(0.0).w);
    _687.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _324)].y;
    float4 _688 = float4(0.0);
    _688.x = _376;
    float4 _689 = _688;
    _689.y = _375;
    float4 _690 = _689;
    _690.z = _374;
    float4 _691 = _690;
    _691.w = 0.50588238239288330078125;
    float4 _703 = float4(_377.x, _377.y, _377.z, float4(0.0).w);
    _703.w = ((log2(((dot(_608, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_460 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_460 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_460 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_677.xyx * _677.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _673 * View.View_PreExposure;
    out.out_var_SV_Target1 = _687;
    out.out_var_SV_Target2 = _691;
    out.out_var_SV_Target3 = _703;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_427, 1.0, 1.0, 1.0);
    return out;
}

