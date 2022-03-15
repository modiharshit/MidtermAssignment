

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

fragment MainPS_out Main_00003c1b_a833cc0c(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _209 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _156, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _214 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _219 = (_214.xyz / float3(_214.w)) - View.View_PreViewTranslation;
    float3 _227 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float _238 = (0.20000000298023223876953125 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _239 = in.in_var_PRIMITIVE_ID * 36u;
    uint _240 = _239 + 20u;
    float _288;
    float _289;
    float _290;
    float3 _291;
    float3 _292;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _258 = ((_209.xy / float2(_209.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _262 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _265 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _258, level(0.0));
        float _278 = _268.w;
        _288 = (_238 * _278) + _268.z;
        _289 = (0.5 * _278) + _268.y;
        _290 = _268.x;
        _291 = (float3(0.5) * _262.w) + _262.xyz;
        _292 = normalize((_227 * _265.w) + ((_265.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _288 = _238;
        _289 = 0.5;
        _290 = 0.0;
        _291 = float3(0.5);
        _292 = _227;
    }
    float3 _302 = fast::clamp((_219 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _313 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_302.x), int(_302.y), int(_302.z), 0).xyz), 0));
    float3 _328 = (((_313.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_302 / float3(_313.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _341;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].z > 0.0)
    {
        _341 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _328, level(0.0)).x;
    }
    else
    {
        _341 = 1.0;
    }
    float3 _355 = ((_291 - (_291 * _290)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _362 = (mix(float3(0.07999999821186065673828125 * _289), _291, float3(_290)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _365 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _370;
    if (_365)
    {
        _370 = _355 + (_362 * 0.449999988079071044921875);
    }
    else
    {
        _370 = _355;
    }
    float3 _372 = select(_362, float3(0.0), bool3(_365));
    float3 _374 = float3(dot(_372, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _391 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _328, level(0.0));
    float _407 = _391.x;
    float4 _409 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _407) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _410 = _391.y;
    float4 _412 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _410) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _413 = _391.z;
    float4 _415 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _432 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _407) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _434 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _410) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _436 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _328, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _469 = _157;
    _469.y = (-0.48860299587249755859375) * _292.y;
    float4 _472 = _469;
    _472.z = 0.48860299587249755859375 * _292.z;
    float4 _475 = _472;
    _475.w = (-0.48860299587249755859375) * _292.x;
    float3 _476 = _292 * _292;
    float4 _479 = _154;
    _479.x = (1.09254801273345947265625 * _292.x) * _292.y;
    float4 _482 = _479;
    _482.y = ((-1.09254801273345947265625) * _292.y) * _292.z;
    float4 _487 = _482;
    _487.z = 0.3153919875621795654296875 * ((3.0 * _476.z) - 1.0);
    float4 _490 = _487;
    _490.w = ((-1.09254801273345947265625) * _292.x) * _292.z;
    float4 _494 = _475;
    _494.x = 0.886227548122406005859375;
    float3 _496 = _494.yzw * 2.094395160675048828125;
    float4 _497 = float4(_494.x, _496.x, _496.y, _496.z);
    float4 _498 = _490 * 0.785398185253143310546875;
    float _499 = (_476.x - _476.y) * 0.4290426075458526611328125;
    float3 _505 = float3(0.0);
    _505.x = (dot(float4(_407, _409.xyz), _497) + dot(float4(_409.w, _432.xyz), _498)) + (_432.w * _499);
    float3 _511 = _505;
    _511.y = (dot(float4(_410, _412.xyz), _497) + dot(float4(_412.w, _434.xyz), _498)) + (_434.w * _499);
    float3 _517 = _511;
    _517.z = (dot(float4(_413, _415.xyz), _497) + dot(float4(_415.w, _436.xyz), _498)) + (_436.w * _499);
    float3 _522 = (fast::max(float3(0.0), _517) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _544 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _573;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _572;
        if (any(abs(_219 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _239 + 19u)].xyz + float3(1.0))))
        {
            _572 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_219, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _572 = _544;
        }
        _573 = _572;
    }
    else
    {
        _573 = _544;
    }
    float4 _580 = float4(((mix(float3(0.0), _370 + (_372 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_522 * _370) * fast::max(float3(1.0), ((((((_291 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_291 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_291 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _573) * 1.0, 0.0);
    float4 _587;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _586 = _580;
        _586.w = 0.0;
        _587 = _586;
    }
    else
    {
        _587 = _580;
    }
    float2 _591 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _599 = (_292 * 0.5) + float3(0.5);
    float4 _601 = float4(_599.x, _599.y, _599.z, float4(0.0).w);
    _601.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _240)].y;
    float4 _602 = float4(0.0);
    _602.x = _290;
    float4 _603 = _602;
    _603.y = _289;
    float4 _604 = _603;
    _604.z = _288;
    float4 _605 = _604;
    _605.w = 0.50588238239288330078125;
    float4 _617 = float4(_291.x, _291.y, _291.z, float4(0.0).w);
    _617.w = ((log2(((dot(_522, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_374 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_374 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_374 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_591.xyx * _591.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _587 * View.View_PreExposure;
    out.out_var_SV_Target1 = _601;
    out.out_var_SV_Target2 = _605;
    out.out_var_SV_Target3 = _617;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_341, 1.0, 1.0, 1.0);
    return out;
}

