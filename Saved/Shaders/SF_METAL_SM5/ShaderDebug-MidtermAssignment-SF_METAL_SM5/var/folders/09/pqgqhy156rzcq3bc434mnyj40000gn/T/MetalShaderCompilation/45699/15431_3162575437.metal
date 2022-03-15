

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

constant float4 _153 = {};
constant float _155 = {};
constant float4 _156 = {};

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

fragment MainPS_out Main_00003c47_bc81124d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _237 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _241 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _242 = in.in_var_PRIMITIVE_ID * 36u;
    uint _243 = _242 + 20u;
    float _291;
    float _292;
    float _293;
    float3 _294;
    float3 _295;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _261 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _265 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _268 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _261, level(0.0));
        float _281 = _271.w;
        _291 = (_241 * _281) + _271.z;
        _292 = (0.5 * _281) + _271.y;
        _293 = _271.x;
        _294 = (_237 * _265.w) + _265.xyz;
        _295 = normalize((_226 * _268.w) + ((_268.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _291 = _241;
        _292 = 0.5;
        _293 = 0.0;
        _294 = _237;
        _295 = _226;
    }
    float3 _305 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _316 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_305.x), int(_305.y), int(_305.z), 0).xyz), 0));
    float3 _331 = (((_316.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_305 / float3(_316.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _344;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].z > 0.0)
    {
        _344 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _331, level(0.0)).x;
    }
    else
    {
        _344 = 1.0;
    }
    float3 _358 = ((_294 - (_294 * _293)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _365 = (mix(float3(0.07999999821186065673828125 * _292), _294, float3(_293)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _368 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _373;
    if (_368)
    {
        _373 = _358 + (_365 * 0.449999988079071044921875);
    }
    else
    {
        _373 = _358;
    }
    float3 _375 = select(_365, float3(0.0), bool3(_368));
    float3 _377 = float3(dot(_375, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _394 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _331, level(0.0));
    float _410 = _394.x;
    float4 _412 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _410) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _413 = _394.y;
    float4 _415 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _416 = _394.z;
    float4 _418 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _435 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _410) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _437 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _439 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _331, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _472 = _156;
    _472.y = (-0.48860299587249755859375) * _295.y;
    float4 _475 = _472;
    _475.z = 0.48860299587249755859375 * _295.z;
    float4 _478 = _475;
    _478.w = (-0.48860299587249755859375) * _295.x;
    float3 _479 = _295 * _295;
    float4 _482 = _153;
    _482.x = (1.09254801273345947265625 * _295.x) * _295.y;
    float4 _485 = _482;
    _485.y = ((-1.09254801273345947265625) * _295.y) * _295.z;
    float4 _490 = _485;
    _490.z = 0.3153919875621795654296875 * ((3.0 * _479.z) - 1.0);
    float4 _493 = _490;
    _493.w = ((-1.09254801273345947265625) * _295.x) * _295.z;
    float4 _497 = _478;
    _497.x = 0.886227548122406005859375;
    float3 _499 = _497.yzw * 2.094395160675048828125;
    float4 _500 = float4(_497.x, _499.x, _499.y, _499.z);
    float4 _501 = _493 * 0.785398185253143310546875;
    float _502 = (_479.x - _479.y) * 0.4290426075458526611328125;
    float3 _508 = float3(0.0);
    _508.x = (dot(float4(_410, _412.xyz), _500) + dot(float4(_412.w, _435.xyz), _501)) + (_435.w * _502);
    float3 _514 = _508;
    _514.y = (dot(float4(_413, _415.xyz), _500) + dot(float4(_415.w, _437.xyz), _501)) + (_437.w * _502);
    float3 _520 = _514;
    _520.z = (dot(float4(_416, _418.xyz), _500) + dot(float4(_418.w, _439.xyz), _501)) + (_439.w * _502);
    float3 _525 = (fast::max(float3(0.0), _520) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _547 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _576;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _575;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _242 + 19u)].xyz + float3(1.0))))
        {
            _575 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _575 = _547;
        }
        _576 = _575;
    }
    else
    {
        _576 = _547;
    }
    float4 _583 = float4(((mix(float3(0.0), _373 + (_375 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_525 * _373) * fast::max(float3(1.0), ((((((_294 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_294 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_294 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _576) * 1.0, 0.0);
    float4 _590;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _589 = _583;
        _589.w = 0.0;
        _590 = _589;
    }
    else
    {
        _590 = _583;
    }
    float2 _594 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _602 = (_295 * 0.5) + float3(0.5);
    float4 _604 = float4(_602.x, _602.y, _602.z, float4(0.0).w);
    _604.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _243)].y;
    float4 _605 = float4(0.0);
    _605.x = _293;
    float4 _606 = _605;
    _606.y = _292;
    float4 _607 = _606;
    _607.z = _291;
    float4 _608 = _607;
    _608.w = 0.50588238239288330078125;
    float4 _620 = float4(_294.x, _294.y, _294.z, float4(0.0).w);
    _620.w = ((log2(((dot(_525, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_377 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_377 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_377 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_594.xyx * _594.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _590 * View.View_PreExposure;
    out.out_var_SV_Target1 = _604;
    out.out_var_SV_Target2 = _608;
    out.out_var_SV_Target3 = _620;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_344, 1.0, 1.0, 1.0);
    return out;
}

