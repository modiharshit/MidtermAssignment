

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
    char _m1_pad[352];
    float3 View_PreViewTranslation;
    char _m2_pad[1028];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m7_pad[8];
    float View_OutOfBoundsMask;
    char _m8_pad[48];
    float View_MaterialTextureMipBias;
    char _m9_pad[28];
    float View_UnlitViewmodeMask;
    char _m10_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m11_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m12_pad[376];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m13_pad[48];
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

constant float4 _170 = {};
constant float4 _172 = {};

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

fragment MainPS_out Main_00003dd6_fd74253b(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> Material_Texture2D_0 [[texture(9)]], texture2d<float> Material_Texture2D_1 [[texture(10)]], texture2d<float> Material_Texture2D_2 [[texture(11)]], texture2d<float> Material_Texture2D_3 [[texture(12)]], sampler View_MaterialTextureBilinearWrapedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _212 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _217 = (_212.xyz / float3(_212.w)) - View.View_PreViewTranslation;
    float4 _223 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _226 = (_223.xy * float2(2.0)) - float2(1.0);
    float _230 = sqrt(fast::clamp(1.0 - dot(_226, _226), 0.0, 1.0));
    float3 _238 = float3(float4(_226, _230, 1.0).xy * (-1.0), _230);
    float3 _242 = (float3(0.0, 0.0, 2.0) * dot(float3(0.0, 0.0, 2.0), _238)) - (_238 * 2.0);
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((_242 / float3(sqrt(dot(_242, _242)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _258 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _276 = Material_Texture2D_2.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 8.0));
    float3 _280 = float3(_258.x);
    float4 _285 = Material_Texture2D_3.sample(View_MaterialTextureBilinearWrapedSampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 50.0));
    float3 _289 = float3(_258.z);
    float3 _303 = fast::clamp(mix(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[3].xyz, float3(_258.y)), _276.xyz * float3(0.25), _280), _285.xyz * float3(0.2249999940395355224609375), _289), float3(0.0), float3(1.0));
    float _304 = fast::clamp(mix(mix(float3(0.0), float3(1.0), _280), float3(0.0), _289).x, 0.0, 1.0);
    float3 _319 = fast::clamp((_217 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _330 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_319.x), int(_319.y), int(_319.z), 0).xyz), 0));
    float3 _345 = (((_330.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_319 / float3(_330.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    uint _346 = in.in_var_PRIMITIVE_ID * 36u;
    uint _347 = _346 + 20u;
    float _361;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].z > 0.0)
    {
        _361 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _345, level(0.0)).x;
    }
    else
    {
        _361 = 1.0;
    }
    float3 _373 = ((_303 - (_303 * _304)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _380 = (mix(float3(0.039999999105930328369140625), _303, float3(_304)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _383 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _388;
    if (_383)
    {
        _388 = _373 + (_380 * 0.449999988079071044921875);
    }
    else
    {
        _388 = _373;
    }
    float3 _390 = select(_380, float3(0.0), bool3(_383));
    float3 _392 = float3(dot(_390, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _409 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _345, level(0.0));
    float _425 = _409.x;
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _428 = _409.y;
    float4 _430 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _431 = _409.z;
    float4 _433 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _431) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _450 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _452 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _428) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _454 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _345, level(0.0)) * 2.0) - float4(1.0)) * _431) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float _485 = _254.y;
    float4 _487 = _172;
    _487.y = (-0.48860299587249755859375) * _485;
    float _488 = _254.z;
    float4 _490 = _487;
    _490.z = 0.48860299587249755859375 * _488;
    float _491 = _254.x;
    float4 _493 = _490;
    _493.w = (-0.48860299587249755859375) * _491;
    float3 _494 = _254 * _254;
    float4 _497 = _170;
    _497.x = (1.09254801273345947265625 * _491) * _485;
    float4 _500 = _497;
    _500.y = ((-1.09254801273345947265625) * _485) * _488;
    float4 _505 = _500;
    _505.z = 0.3153919875621795654296875 * ((3.0 * _494.z) - 1.0);
    float4 _508 = _505;
    _508.w = ((-1.09254801273345947265625) * _491) * _488;
    float4 _512 = _493;
    _512.x = 0.886227548122406005859375;
    float3 _514 = _512.yzw * 2.094395160675048828125;
    float4 _515 = float4(_512.x, _514.x, _514.y, _514.z);
    float4 _516 = _508 * 0.785398185253143310546875;
    float _517 = (_494.x - _494.y) * 0.4290426075458526611328125;
    float3 _523 = float3(0.0);
    _523.x = (dot(float4(_425, _427.xyz), _515) + dot(float4(_427.w, _450.xyz), _516)) + (_450.w * _517);
    float3 _529 = _523;
    _529.y = (dot(float4(_428, _430.xyz), _515) + dot(float4(_430.w, _452.xyz), _516)) + (_452.w * _517);
    float3 _535 = _529;
    _535.z = (dot(float4(_431, _433.xyz), _515) + dot(float4(_433.w, _454.xyz), _516)) + (_454.w * _517);
    float3 _540 = (fast::max(float3(0.0), _535) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _562 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _591;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _590;
        if (any(abs(_217 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _346 + 19u)].xyz + float3(1.0))))
        {
            _590 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_217, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _590 = _562;
        }
        _591 = _590;
    }
    else
    {
        _591 = _562;
    }
    float4 _598 = float4(((mix(float3(0.0), _388 + (_390 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_540 * _388) * fast::max(float3(1.0), ((((((_303 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_303 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_303 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _591) * 1.0, 0.0);
    float4 _605;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _604 = _598;
        _604.w = 0.0;
        _605 = _604;
    }
    else
    {
        _605 = _598;
    }
    float2 _610 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _618 = (_254 * 0.5) + float3(0.5);
    float4 _620 = float4(_618.x, _618.y, _618.z, float4(0.0).w);
    _620.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].y;
    float4 _621 = float4(0.0);
    _621.x = _304;
    float4 _622 = _621;
    _622.y = 0.5;
    float4 _623 = _622;
    _623.z = (fast::clamp(mix(mix(float3(0.100000001490116119384765625), float3(mix(0.37999999523162841796875, 0.550000011920928955078125, _276.x)), _280), float3(mix(0.550000011920928955078125, 0.75, _285.x)), _289).x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float4 _624 = _623;
    _624.w = 0.50588238239288330078125;
    float4 _636 = float4(_303.x, _303.y, _303.z, float4(0.0).w);
    _636.w = ((log2(((dot(_540, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_610.xyx * _610.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _605 * View.View_PreExposure;
    out.out_var_SV_Target1 = _620;
    out.out_var_SV_Target2 = _624;
    out.out_var_SV_Target3 = _636;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_361, 1.0, 1.0, 1.0);
    return out;
}

