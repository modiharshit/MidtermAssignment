

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _166 = {};
constant float _168 = {};
constant float4 _169 = {};

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

fragment MainPS_out Main_00004185_ce80c1e8(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _224 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _168, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _229 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _234 = (_229.xyz / float3(_229.w)) - View.View_PreViewTranslation;
    float4 _240 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _243 = (_240.xy * float2(2.0)) - float2(1.0);
    float3 _259 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_243, sqrt(fast::clamp(1.0 - dot(_243, _243), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _270 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _277 = _270.y;
    float3 _287 = fast::clamp(mix(Material.Material_VectorExpressions[4].xyz, Material.Material_VectorExpressions[5].xyz, float3(_277)), float3(0.0), float3(1.0));
    float _288 = fast::clamp(mix(0.0, 1.0, _277), 0.0, 1.0);
    float _289 = fast::clamp(_270.x, 0.0, 1.0);
    float _294 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].y, Material.Material_ScalarExpressions[0].z, _277), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _295 = in.in_var_PRIMITIVE_ID * 36u;
    uint _296 = _295 + 20u;
    float _346;
    float _347;
    float _348;
    float3 _349;
    float3 _350;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _314 = ((_224.xy / float2(_224.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _318 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _321 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float4 _324 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _314, level(0.0));
        float _334 = _324.w;
        _346 = (_294 * _334) + _324.z;
        _347 = (0.5 * _334) + _324.y;
        _348 = (_288 * _334) + _324.x;
        _349 = (_287 * _318.w) + _318.xyz;
        _350 = normalize((_259 * _321.w) + ((_321.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _346 = _294;
        _347 = 0.5;
        _348 = _288;
        _349 = _287;
        _350 = _259;
    }
    float3 _360 = fast::clamp((_234 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _371 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_360.x), int(_360.y), int(_360.z), 0).xyz), 0));
    float3 _386 = (((_371.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_360 / float3(_371.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _399;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].z > 0.0)
    {
        _399 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _386, level(0.0)).x;
    }
    else
    {
        _399 = 1.0;
    }
    float3 _413 = ((_349 - (_349 * _348)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _420 = (mix(float3(0.07999999821186065673828125 * _347), _349, float3(_348)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _423 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _428;
    if (_423)
    {
        _428 = _413 + (_420 * 0.449999988079071044921875);
    }
    else
    {
        _428 = _413;
    }
    float3 _430 = select(_420, float3(0.0), bool3(_423));
    float3 _432 = float3(dot(_430, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _439 = float3(_289);
    float4 _450 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _386, level(0.0));
    float _466 = _450.x;
    float4 _468 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _466) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _469 = _450.y;
    float4 _471 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _472 = _450.z;
    float4 _474 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _491 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _466) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _493 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _469) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _495 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _386, level(0.0)) * 2.0) - float4(1.0)) * _472) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _528 = _169;
    _528.y = (-0.48860299587249755859375) * _350.y;
    float4 _531 = _528;
    _531.z = 0.48860299587249755859375 * _350.z;
    float4 _534 = _531;
    _534.w = (-0.48860299587249755859375) * _350.x;
    float3 _535 = _350 * _350;
    float4 _538 = _166;
    _538.x = (1.09254801273345947265625 * _350.x) * _350.y;
    float4 _541 = _538;
    _541.y = ((-1.09254801273345947265625) * _350.y) * _350.z;
    float4 _546 = _541;
    _546.z = 0.3153919875621795654296875 * ((3.0 * _535.z) - 1.0);
    float4 _549 = _546;
    _549.w = ((-1.09254801273345947265625) * _350.x) * _350.z;
    float4 _553 = _534;
    _553.x = 0.886227548122406005859375;
    float3 _555 = _553.yzw * 2.094395160675048828125;
    float4 _556 = float4(_553.x, _555.x, _555.y, _555.z);
    float4 _557 = _549 * 0.785398185253143310546875;
    float _558 = (_535.x - _535.y) * 0.4290426075458526611328125;
    float3 _564 = float3(0.0);
    _564.x = (dot(float4(_466, _468.xyz), _556) + dot(float4(_468.w, _491.xyz), _557)) + (_491.w * _558);
    float3 _570 = _564;
    _570.y = (dot(float4(_469, _471.xyz), _556) + dot(float4(_471.w, _493.xyz), _557)) + (_493.w * _558);
    float3 _576 = _570;
    _576.z = (dot(float4(_472, _474.xyz), _556) + dot(float4(_474.w, _495.xyz), _557)) + (_495.w * _558);
    float3 _581 = (fast::max(float3(0.0), _576) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _603 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _632;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _631;
        if (any(abs(_234 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _295 + 19u)].xyz + float3(1.0))))
        {
            _631 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_234, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _631 = _603;
        }
        _632 = _631;
    }
    else
    {
        _632 = _603;
    }
    float4 _639 = float4(((mix(float3(0.0), _428 + (_430 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_581 * _428) * fast::max(_439, ((((((_349 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _289) + ((_349 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _289) + ((_349 * 2.755199909210205078125) + float3(0.69029998779296875))) * _289))) + _632) * 1.0, 0.0);
    float4 _646;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _645 = _639;
        _645.w = 0.0;
        _646 = _645;
    }
    else
    {
        _646 = _639;
    }
    float2 _650 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _658 = (_350 * 0.5) + float3(0.5);
    float4 _660 = float4(_658.x, _658.y, _658.z, float4(0.0).w);
    _660.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _296)].y;
    float4 _661 = float4(0.0);
    _661.x = _348;
    float4 _662 = _661;
    _662.y = _347;
    float4 _663 = _662;
    _663.z = _346;
    float4 _664 = _663;
    _664.w = 0.50588238239288330078125;
    float4 _676 = float4(_349.x, _349.y, _349.z, float4(0.0).w);
    _676.w = ((log2(((dot(_581, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_439, ((((((_432 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _289) + ((_432 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _289) + ((_432 * 2.755199909210205078125) + float3(0.69029998779296875))) * _289).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_650.xyx * _650.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _646 * View.View_PreExposure;
    out.out_var_SV_Target1 = _660;
    out.out_var_SV_Target2 = _664;
    out.out_var_SV_Target3 = _676;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_399, 1.0, 1.0, 1.0);
    return out;
}

