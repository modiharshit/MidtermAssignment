

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
    char _m9_pad[16];
    float View_OutOfBoundsMask;
    char _m10_pad[80];
    float View_UnlitViewmodeMask;
    char _m11_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m12_pad[604];
    float View_ShowDecalsMask;
    char _m13_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m14_pad[48];
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

constant float4 _154 = {};
constant float _156 = {};
constant float4 _157 = {};

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
    uint in_var_PRIMITIVE_ID [[user(locn2)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000388d_bddb8363(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _207 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float3 _225 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    uint _233 = in.in_var_PRIMITIVE_ID * 36u;
    uint _234 = _233 + 20u;
    float _281;
    float _282;
    float _283;
    float3 _284;
    float3 _285;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _252 = ((_207.xy / float2(_207.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _256 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _259 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float4 _262 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _252, level(0.0));
        float _272 = _262.w;
        _281 = _272 + _262.z;
        _282 = (0.5 * _272) + _262.y;
        _283 = _262.x;
        _284 = (float3(0.180000007152557373046875) * _256.w) + _256.xyz;
        _285 = normalize((_225 * _259.w) + ((_259.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _281 = 1.0;
        _282 = 0.5;
        _283 = 0.0;
        _284 = float3(0.180000007152557373046875);
        _285 = _225;
    }
    float3 _295 = fast::clamp((_217 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _306 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_295.x), int(_295.y), int(_295.z), 0).xyz), 0));
    float3 _321 = (((_306.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_295 / float3(_306.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _334;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].z > 0.0)
    {
        _334 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _321, level(0.0)).x;
    }
    else
    {
        _334 = 1.0;
    }
    float3 _357 = (((_284 - (_284 * _283)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _282), _284, float3(_283)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _361 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _321, level(0.0));
    float _377 = _361.x;
    float4 _379 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _377) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _380 = _361.y;
    float4 _382 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _380) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _383 = _361.z;
    float4 _385 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _383) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _402 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _377) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _404 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _380) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _406 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _321, level(0.0)) * 2.0) - float4(1.0)) * _383) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _439 = _157;
    _439.y = (-0.48860299587249755859375) * _285.y;
    float4 _442 = _439;
    _442.z = 0.48860299587249755859375 * _285.z;
    float4 _445 = _442;
    _445.w = (-0.48860299587249755859375) * _285.x;
    float3 _446 = _285 * _285;
    float4 _449 = _154;
    _449.x = (1.09254801273345947265625 * _285.x) * _285.y;
    float4 _452 = _449;
    _452.y = ((-1.09254801273345947265625) * _285.y) * _285.z;
    float4 _457 = _452;
    _457.z = 0.3153919875621795654296875 * ((3.0 * _446.z) - 1.0);
    float4 _460 = _457;
    _460.w = ((-1.09254801273345947265625) * _285.x) * _285.z;
    float4 _464 = _445;
    _464.x = 0.886227548122406005859375;
    float3 _466 = _464.yzw * 2.094395160675048828125;
    float4 _467 = float4(_464.x, _466.x, _466.y, _466.z);
    float4 _468 = _460 * 0.785398185253143310546875;
    float _469 = (_446.x - _446.y) * 0.4290426075458526611328125;
    float3 _475 = float3(0.0);
    _475.x = (dot(float4(_377, _379.xyz), _467) + dot(float4(_379.w, _402.xyz), _468)) + (_402.w * _469);
    float3 _481 = _475;
    _481.y = (dot(float4(_380, _382.xyz), _467) + dot(float4(_382.w, _404.xyz), _468)) + (_404.w * _469);
    float3 _487 = _481;
    _487.z = (dot(float4(_383, _385.xyz), _467) + dot(float4(_385.w, _406.xyz), _468)) + (_406.w * _469);
    float3 _492 = (fast::max(float3(0.0), _487) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _512 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _541;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _540;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _233 + 19u)].xyz + float3(1.0))))
        {
            _540 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _540 = _512;
        }
        _541 = _540;
    }
    else
    {
        _541 = _512;
    }
    float4 _548 = float4(((mix(float3(0.0), _357, float3(View.View_UnlitViewmodeMask)) + ((_492 * _357) * fast::max(float3(1.0), ((((((_284 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_284 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_284 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _541) * 1.0, 0.0);
    float4 _555;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _554 = _548;
        _554.w = 0.0;
        _555 = _554;
    }
    else
    {
        _555 = _548;
    }
    float2 _559 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _567 = (_285 * 0.5) + float3(0.5);
    float4 _569 = float4(_567.x, _567.y, _567.z, float4(0.0).w);
    _569.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _234)].y;
    float4 _570 = float4(0.0);
    _570.x = _283;
    float4 _571 = _570;
    _571.y = _282;
    float4 _572 = _571;
    _572.z = _281;
    float4 _573 = _572;
    _573.w = 0.50588238239288330078125;
    float4 _584 = float4(_284.x, _284.y, _284.z, float4(0.0).w);
    _584.w = ((log2((dot(_492, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_559.xyx * _559.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _555 * View.View_PreExposure;
    out.out_var_SV_Target1 = _569;
    out.out_var_SV_Target2 = _573;
    out.out_var_SV_Target3 = _584;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_334, 1.0, 1.0, 1.0);
    return out;
}

