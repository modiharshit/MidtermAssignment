

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

constant float4 _163 = {};
constant float _165 = {};
constant float4 _166 = {};

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

fragment MainPS_out Main_0000411a_dfb7542d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _222 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _165, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _227 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _232 = (_227.xyz / float3(_227.w)) - View.View_PreViewTranslation;
    float4 _238 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _241 = (_238.xy * float2(2.0)) - float2(1.0);
    float3 _257 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_241, sqrt(fast::clamp(1.0 - dot(_241, _241), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _268 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float _272 = _268.x;
    float3 _281 = fast::clamp(Material.Material_VectorExpressions[3].xyz * _272, float3(0.0), float3(1.0));
    float _282 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _287 = (fast::clamp(mix(Material.Material_ScalarExpressions[0].z, Material.Material_ScalarExpressions[0].w, _272), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _288 = in.in_var_PRIMITIVE_ID * 36u;
    uint _289 = _288 + 20u;
    float _339;
    float _340;
    float _341;
    float3 _342;
    float3 _343;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _307 = ((_222.xy / float2(_222.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _311 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float4 _314 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float4 _317 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _307, level(0.0));
        float _327 = _317.w;
        _339 = (_287 * _327) + _317.z;
        _340 = (0.5 * _327) + _317.y;
        _341 = (_282 * _327) + _317.x;
        _342 = (_281 * _311.w) + _311.xyz;
        _343 = normalize((_257 * _314.w) + ((_314.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _339 = _287;
        _340 = 0.5;
        _341 = _282;
        _342 = _281;
        _343 = _257;
    }
    float3 _353 = fast::clamp((_232 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _364 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_353.x), int(_353.y), int(_353.z), 0).xyz), 0));
    float3 _379 = (((_364.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_353 / float3(_364.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _392;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].z > 0.0)
    {
        _392 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _379, level(0.0)).x;
    }
    else
    {
        _392 = 1.0;
    }
    float3 _406 = ((_342 - (_342 * _341)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _413 = (mix(float3(0.07999999821186065673828125 * _340), _342, float3(_341)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _416 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _421;
    if (_416)
    {
        _421 = _406 + (_413 * 0.449999988079071044921875);
    }
    else
    {
        _421 = _406;
    }
    float3 _423 = select(_413, float3(0.0), bool3(_416));
    float3 _425 = float3(dot(_423, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _442 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _379, level(0.0));
    float _458 = _442.x;
    float4 _460 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _458) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _461 = _442.y;
    float4 _463 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _461) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _464 = _442.z;
    float4 _466 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _464) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _483 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _458) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _485 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _461) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _487 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _379, level(0.0)) * 2.0) - float4(1.0)) * _464) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _520 = _166;
    _520.y = (-0.48860299587249755859375) * _343.y;
    float4 _523 = _520;
    _523.z = 0.48860299587249755859375 * _343.z;
    float4 _526 = _523;
    _526.w = (-0.48860299587249755859375) * _343.x;
    float3 _527 = _343 * _343;
    float4 _530 = _163;
    _530.x = (1.09254801273345947265625 * _343.x) * _343.y;
    float4 _533 = _530;
    _533.y = ((-1.09254801273345947265625) * _343.y) * _343.z;
    float4 _538 = _533;
    _538.z = 0.3153919875621795654296875 * ((3.0 * _527.z) - 1.0);
    float4 _541 = _538;
    _541.w = ((-1.09254801273345947265625) * _343.x) * _343.z;
    float4 _545 = _526;
    _545.x = 0.886227548122406005859375;
    float3 _547 = _545.yzw * 2.094395160675048828125;
    float4 _548 = float4(_545.x, _547.x, _547.y, _547.z);
    float4 _549 = _541 * 0.785398185253143310546875;
    float _550 = (_527.x - _527.y) * 0.4290426075458526611328125;
    float3 _556 = float3(0.0);
    _556.x = (dot(float4(_458, _460.xyz), _548) + dot(float4(_460.w, _483.xyz), _549)) + (_483.w * _550);
    float3 _562 = _556;
    _562.y = (dot(float4(_461, _463.xyz), _548) + dot(float4(_463.w, _485.xyz), _549)) + (_485.w * _550);
    float3 _568 = _562;
    _568.z = (dot(float4(_464, _466.xyz), _548) + dot(float4(_466.w, _487.xyz), _549)) + (_487.w * _550);
    float3 _573 = (fast::max(float3(0.0), _568) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _595 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _624;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _623;
        if (any(abs(_232 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _288 + 19u)].xyz + float3(1.0))))
        {
            _623 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_232, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _623 = _595;
        }
        _624 = _623;
    }
    else
    {
        _624 = _595;
    }
    float4 _631 = float4(((mix(float3(0.0), _421 + (_423 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_573 * _421) * fast::max(float3(1.0), ((((((_342 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_342 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_342 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _624) * 1.0, 0.0);
    float4 _638;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _637 = _631;
        _637.w = 0.0;
        _638 = _637;
    }
    else
    {
        _638 = _631;
    }
    float2 _642 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _650 = (_343 * 0.5) + float3(0.5);
    float4 _652 = float4(_650.x, _650.y, _650.z, float4(0.0).w);
    _652.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _289)].y;
    float4 _653 = float4(0.0);
    _653.x = _341;
    float4 _654 = _653;
    _654.y = _340;
    float4 _655 = _654;
    _655.z = _339;
    float4 _656 = _655;
    _656.w = 0.50588238239288330078125;
    float4 _668 = float4(_342.x, _342.y, _342.z, float4(0.0).w);
    _668.w = ((log2(((dot(_573, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_425 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_425 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_425 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_642.xyx * _642.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _638 * View.View_PreExposure;
    out.out_var_SV_Target1 = _652;
    out.out_var_SV_Target2 = _656;
    out.out_var_SV_Target3 = _668;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_392, 1.0, 1.0, 1.0);
    return out;
}

