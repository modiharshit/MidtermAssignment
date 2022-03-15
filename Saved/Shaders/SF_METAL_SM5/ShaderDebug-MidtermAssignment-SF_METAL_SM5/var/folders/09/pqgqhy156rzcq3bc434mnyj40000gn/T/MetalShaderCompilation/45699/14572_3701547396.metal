

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
    char _m11_pad[24];
    float View_CullingSign;
    char _m12_pad[52];
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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _148 = {};
constant float _150 = {};
constant float4 _151 = {};

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
    float4 in_var_COLOR0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000038ec_dca12184(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _150, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    uint _217 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _233 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float3 _242 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _246 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _247 = _217 + 20u;
    float _293;
    float _294;
    float _295;
    float3 _296;
    float3 _297;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _265 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _269 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _272 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        float4 _275 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _265, level(0.0));
        _293 = (_246 * _275.w) + _275.z;
        _294 = _275.y;
        _295 = _275.x;
        _296 = (_242 * _269.w) + _269.xyz;
        _297 = normalize((_233 * _272.w) + ((_272.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _293 = _246;
        _294 = 0.0;
        _295 = 0.0;
        _296 = _242;
        _297 = _233;
    }
    bool _307 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _313;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 18u)].w > 0.0) && _307)
    {
        _313 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _313 = 1.0;
    }
    float _360;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].z > 0.0)
    {
        float3 _328 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _339 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_328.x), int(_328.y), int(_328.z), 0).xyz), 0));
        _360 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_339.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_328 / float3(_339.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _360 = _313;
    }
    float3 _374 = ((_296 - (_296 * _295)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _381 = (mix(float3(0.07999999821186065673828125 * _294), _296, float3(_295)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _384 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _389;
    if (_384)
    {
        _389 = _374 + (_381 * 0.449999988079071044921875);
    }
    else
    {
        _389 = _374;
    }
    float3 _391 = select(_381, float3(0.0), bool3(_384));
    float3 _393 = float3(dot(_391, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _479;
    if (_307)
    {
        float4 _429 = _151;
        _429.y = (-0.48860299587249755859375) * _297.y;
        float4 _432 = _429;
        _432.z = 0.48860299587249755859375 * _297.z;
        float4 _435 = _432;
        _435.w = (-0.48860299587249755859375) * _297.x;
        float3 _436 = _297 * _297;
        float4 _439 = _148;
        _439.x = (1.09254801273345947265625 * _297.x) * _297.y;
        float4 _442 = _439;
        _442.y = ((-1.09254801273345947265625) * _297.y) * _297.z;
        float4 _447 = _442;
        _447.z = 0.3153919875621795654296875 * ((3.0 * _436.z) - 1.0);
        float4 _450 = _447;
        _450.w = ((-1.09254801273345947265625) * _297.x) * _297.z;
        float4 _454 = _435;
        _454.x = 0.886227548122406005859375;
        float3 _456 = _454.yzw * 2.094395160675048828125;
        float4 _457 = float4(_454.x, _456.x, _456.y, _456.z);
        float4 _458 = _450 * 0.785398185253143310546875;
        float _459 = (_436.x - _436.y) * 0.4290426075458526611328125;
        float3 _465 = float3(0.0);
        _465.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _457) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _458)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _459);
        float3 _471 = _465;
        _471.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _457) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _458)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _459);
        float3 _477 = _471;
        _477.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _457) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _458)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _459);
        _479 = fast::max(float3(0.0), _477);
    }
    else
    {
        _479 = float3(0.0);
    }
    float3 _482 = _479 * View.View_IndirectLightingColorScale;
    float3 _504 = fast::max(mix(in.in_var_COLOR0.xyz, Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _533;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _532;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 19u)].xyz + float3(1.0))))
        {
            _532 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _532 = _504;
        }
        _533 = _532;
    }
    else
    {
        _533 = _504;
    }
    float4 _540 = float4(((mix(float3(0.0), _389 + (_391 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_482 * _389) * fast::max(float3(1.0), ((((((_296 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_296 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_296 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _533) * 1.0, 0.0);
    float4 _547;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _546 = _540;
        _546.w = 0.0;
        _547 = _546;
    }
    else
    {
        _547 = _540;
    }
    float2 _551 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _559 = (_297 * 0.5) + float3(0.5);
    float4 _561 = float4(_559.x, _559.y, _559.z, float4(0.0).w);
    _561.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _247)].y;
    float4 _562 = float4(0.0);
    _562.x = _295;
    float4 _563 = _562;
    _563.y = _294;
    float4 _564 = _563;
    _564.z = _293;
    float4 _565 = _564;
    _565.w = 0.50588238239288330078125;
    float4 _577 = float4(_296.x, _296.y, _296.z, float4(0.0).w);
    _577.w = ((log2(((dot(_482, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_393 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_393 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_393 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_551.xyx * _551.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _547 * View.View_PreExposure;
    out.out_var_SV_Target1 = _561;
    out.out_var_SV_Target2 = _565;
    out.out_var_SV_Target3 = _577;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_360, 1.0, 1.0, 1.0);
    return out;
}

