

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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

fragment MainPS_out Main_00003cee_b4e6c35f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float3 _227 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _242 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _243 = fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0);
    float _248 = (fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _249 = in.in_var_PRIMITIVE_ID * 36u;
    uint _250 = _249 + 20u;
    float _300;
    float _301;
    float _302;
    float3 _303;
    float3 _304;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _268 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _272 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float4 _278 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _268, level(0.0));
        float _288 = _278.w;
        _300 = (_248 * _288) + _278.z;
        _301 = (0.5 * _288) + _278.y;
        _302 = (_243 * _288) + _278.x;
        _303 = (_242 * _272.w) + _272.xyz;
        _304 = normalize((_227 * _275.w) + ((_275.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _300 = _248;
        _301 = 0.5;
        _302 = _243;
        _303 = _242;
        _304 = _227;
    }
    float3 _314 = fast::clamp((_219 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _325 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_314.x), int(_314.y), int(_314.z), 0).xyz), 0));
    float3 _340 = (((_325.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_314 / float3(_325.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _353;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].z > 0.0)
    {
        _353 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _340, level(0.0)).x;
    }
    else
    {
        _353 = 1.0;
    }
    float3 _367 = ((_303 - (_303 * _302)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _374 = (mix(float3(0.07999999821186065673828125 * _301), _303, float3(_302)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _377 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _382;
    if (_377)
    {
        _382 = _367 + (_374 * 0.449999988079071044921875);
    }
    else
    {
        _382 = _367;
    }
    float3 _384 = select(_374, float3(0.0), bool3(_377));
    float3 _386 = float3(dot(_384, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _403 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _340, level(0.0));
    float _419 = _403.x;
    float4 _421 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _422 = _403.y;
    float4 _424 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _425 = _403.z;
    float4 _427 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _444 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _446 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _422) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _448 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _340, level(0.0)) * 2.0) - float4(1.0)) * _425) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _481 = _157;
    _481.y = (-0.48860299587249755859375) * _304.y;
    float4 _484 = _481;
    _484.z = 0.48860299587249755859375 * _304.z;
    float4 _487 = _484;
    _487.w = (-0.48860299587249755859375) * _304.x;
    float3 _488 = _304 * _304;
    float4 _491 = _154;
    _491.x = (1.09254801273345947265625 * _304.x) * _304.y;
    float4 _494 = _491;
    _494.y = ((-1.09254801273345947265625) * _304.y) * _304.z;
    float4 _499 = _494;
    _499.z = 0.3153919875621795654296875 * ((3.0 * _488.z) - 1.0);
    float4 _502 = _499;
    _502.w = ((-1.09254801273345947265625) * _304.x) * _304.z;
    float4 _506 = _487;
    _506.x = 0.886227548122406005859375;
    float3 _508 = _506.yzw * 2.094395160675048828125;
    float4 _509 = float4(_506.x, _508.x, _508.y, _508.z);
    float4 _510 = _502 * 0.785398185253143310546875;
    float _511 = (_488.x - _488.y) * 0.4290426075458526611328125;
    float3 _517 = float3(0.0);
    _517.x = (dot(float4(_419, _421.xyz), _509) + dot(float4(_421.w, _444.xyz), _510)) + (_444.w * _511);
    float3 _523 = _517;
    _523.y = (dot(float4(_422, _424.xyz), _509) + dot(float4(_424.w, _446.xyz), _510)) + (_446.w * _511);
    float3 _529 = _523;
    _529.z = (dot(float4(_425, _427.xyz), _509) + dot(float4(_427.w, _448.xyz), _510)) + (_448.w * _511);
    float3 _534 = (fast::max(float3(0.0), _529) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _556 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _585;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _584;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _249 + 19u)].xyz + float3(1.0))))
        {
            _584 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _584 = _556;
        }
        _585 = _584;
    }
    else
    {
        _585 = _556;
    }
    float4 _592 = float4(((mix(float3(0.0), _382 + (_384 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_534 * _382) * fast::max(float3(1.0), ((((((_303 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_303 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_303 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _585) * 1.0, 0.0);
    float4 _599;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _598 = _592;
        _598.w = 0.0;
        _599 = _598;
    }
    else
    {
        _599 = _592;
    }
    float2 _603 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _611 = (_304 * 0.5) + float3(0.5);
    float4 _613 = float4(_611.x, _611.y, _611.z, float4(0.0).w);
    _613.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _250)].y;
    float4 _614 = float4(0.0);
    _614.x = _302;
    float4 _615 = _614;
    _615.y = _301;
    float4 _616 = _615;
    _616.z = _300;
    float4 _617 = _616;
    _617.w = 0.50588238239288330078125;
    float4 _629 = float4(_303.x, _303.y, _303.z, float4(0.0).w);
    _629.w = ((log2(((dot(_534, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_386 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_386 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_386 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_603.xyx * _603.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _599 * View.View_PreExposure;
    out.out_var_SV_Target1 = _613;
    out.out_var_SV_Target2 = _617;
    out.out_var_SV_Target3 = _629;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_353, 1.0, 1.0, 1.0);
    return out;
}

