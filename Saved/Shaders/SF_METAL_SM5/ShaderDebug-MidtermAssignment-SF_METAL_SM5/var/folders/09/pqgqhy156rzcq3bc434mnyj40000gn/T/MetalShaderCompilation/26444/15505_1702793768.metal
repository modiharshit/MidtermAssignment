

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

fragment MainPS_out Main_00003c91_657e9228(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _208 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _155, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _213 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _218 = (_213.xyz / float3(_213.w)) - View.View_PreViewTranslation;
    float3 _226 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float3 _239 = fast::clamp(Material.Material_VectorExpressions[3].xyz, float3(0.0), float3(1.0));
    float _244 = (fast::clamp(Material.Material_ScalarExpressions[0].y, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    uint _246 = _245 + 20u;
    float _294;
    float _295;
    float _296;
    float3 _297;
    float3 _298;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _264 = ((_208.xy / float2(_208.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _268 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _271 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float4 _274 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _264, level(0.0));
        float _284 = _274.w;
        _294 = (_244 * _284) + _274.z;
        _295 = (0.5 * _284) + _274.y;
        _296 = _274.x;
        _297 = (_239 * _268.w) + _268.xyz;
        _298 = normalize((_226 * _271.w) + ((_271.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _294 = _244;
        _295 = 0.5;
        _296 = 0.0;
        _297 = _239;
        _298 = _226;
    }
    float3 _308 = fast::clamp((_218 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _319 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_308.x), int(_308.y), int(_308.z), 0).xyz), 0));
    float3 _334 = (((_319.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_308 / float3(_319.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _347;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].z > 0.0)
    {
        _347 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _334, level(0.0)).x;
    }
    else
    {
        _347 = 1.0;
    }
    float3 _361 = ((_297 - (_297 * _296)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _368 = (mix(float3(0.07999999821186065673828125 * _295), _297, float3(_296)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _371 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _376;
    if (_371)
    {
        _376 = _361 + (_368 * 0.449999988079071044921875);
    }
    else
    {
        _376 = _361;
    }
    float3 _378 = select(_368, float3(0.0), bool3(_371));
    float3 _380 = float3(dot(_378, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _397 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _334, level(0.0));
    float _413 = _397.x;
    float4 _415 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _416 = _397.y;
    float4 _418 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _419 = _397.z;
    float4 _421 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _438 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _413) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _440 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _416) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _442 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _334, level(0.0)) * 2.0) - float4(1.0)) * _419) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _475 = _156;
    _475.y = (-0.48860299587249755859375) * _298.y;
    float4 _478 = _475;
    _478.z = 0.48860299587249755859375 * _298.z;
    float4 _481 = _478;
    _481.w = (-0.48860299587249755859375) * _298.x;
    float3 _482 = _298 * _298;
    float4 _485 = _153;
    _485.x = (1.09254801273345947265625 * _298.x) * _298.y;
    float4 _488 = _485;
    _488.y = ((-1.09254801273345947265625) * _298.y) * _298.z;
    float4 _493 = _488;
    _493.z = 0.3153919875621795654296875 * ((3.0 * _482.z) - 1.0);
    float4 _496 = _493;
    _496.w = ((-1.09254801273345947265625) * _298.x) * _298.z;
    float4 _500 = _481;
    _500.x = 0.886227548122406005859375;
    float3 _502 = _500.yzw * 2.094395160675048828125;
    float4 _503 = float4(_500.x, _502.x, _502.y, _502.z);
    float4 _504 = _496 * 0.785398185253143310546875;
    float _505 = (_482.x - _482.y) * 0.4290426075458526611328125;
    float3 _511 = float3(0.0);
    _511.x = (dot(float4(_413, _415.xyz), _503) + dot(float4(_415.w, _438.xyz), _504)) + (_438.w * _505);
    float3 _517 = _511;
    _517.y = (dot(float4(_416, _418.xyz), _503) + dot(float4(_418.w, _440.xyz), _504)) + (_440.w * _505);
    float3 _523 = _517;
    _523.z = (dot(float4(_419, _421.xyz), _503) + dot(float4(_421.w, _442.xyz), _504)) + (_442.w * _505);
    float3 _528 = (fast::max(float3(0.0), _523) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _550 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _579;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _578;
        if (any(abs(_218 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _578 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_218, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _578 = _550;
        }
        _579 = _578;
    }
    else
    {
        _579 = _550;
    }
    float4 _586 = float4(((mix(float3(0.0), _376 + (_378 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_528 * _376) * fast::max(float3(1.0), ((((((_297 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_297 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_297 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _579) * 1.0, 0.0);
    float4 _593;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _592 = _586;
        _592.w = 0.0;
        _593 = _592;
    }
    else
    {
        _593 = _586;
    }
    float2 _597 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _605 = (_298 * 0.5) + float3(0.5);
    float4 _607 = float4(_605.x, _605.y, _605.z, float4(0.0).w);
    _607.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _246)].y;
    float4 _608 = float4(0.0);
    _608.x = _296;
    float4 _609 = _608;
    _609.y = _295;
    float4 _610 = _609;
    _610.z = _294;
    float4 _611 = _610;
    _611.w = 0.50588238239288330078125;
    float4 _623 = float4(_297.x, _297.y, _297.z, float4(0.0).w);
    _623.w = ((log2(((dot(_528, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_380 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_380 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_380 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_597.xyx * _597.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _593 * View.View_PreExposure;
    out.out_var_SV_Target1 = _607;
    out.out_var_SV_Target2 = _611;
    out.out_var_SV_Target3 = _623;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_347, 1.0, 1.0, 1.0);
    return out;
}

