

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
    char _m0_pad[256];
    float4x4 View_ViewToTranslatedWorld;
    char _m1_pad[384];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[288];
    float4 View_ScreenPositionScaleBias;
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
    char _m5_pad[928];
    float4 View_ViewRectMin;
    float4 View_ViewSizeAndInvSize;
    char _m7_pad[68];
    float View_PreExposure;
    float4 View_DiffuseOverrideParameter;
    float4 View_SpecularOverrideParameter;
    float4 View_NormalOverrideParameter;
    float2 View_RoughnessOverrideParameter;
    char _m12_pad[8];
    float View_OutOfBoundsMask;
    char _m13_pad[48];
    float View_MaterialTextureMipBias;
    char _m14_pad[28];
    float View_UnlitViewmodeMask;
    char _m15_pad[600];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m17_pad[188];
    float View_ShowDecalsMask;
    char _m18_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m19_pad[48];
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

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _142 = {};
constant float4x4 _143 = {};
constant float _144 = {};

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
    float4 in_var_TEXCOORD15 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000385b_109ac775(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _194 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _206 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _144, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _211 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _216 = (_211.xyz / float3(_211.w)) - View.View_PreViewTranslation;
    uint _217 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _220 = _143;
    _220[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217)];
    float4x4 _224 = _220;
    _224[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 1u)];
    float4x4 _228 = _224;
    _228[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 2u)];
    float4x4 _232 = _228;
    _232[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 3u)];
    float3 _235 = (_232 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _247 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _250 = (float3(-0.5) + _247.xyz) * 2.0;
    float3 _266 = ((((_235 / float3(sqrt(dot(_235, _235)))) * _194) * (-1.0)) * _250.z) + (float3(_250.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _194));
    float3 _278 = normalize(_194 * normalize(((_266 / float3(sqrt(dot(_266, _266)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _296 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _316 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _316) : (PrimitiveDither.PrimitiveDither_LODFactor < _316)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_289.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _331 = fast::clamp(_289.xyz, float3(0.0), float3(1.0));
    float _336 = (fast::clamp(_247.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _346 = (fast::clamp(float4(_296.xyz, _142).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _347 = _217 + 20u;
    float3 _396;
    float _397;
    float _398;
    float _399;
    float3 _400;
    float3 _401;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _365 = ((_206.xy / float2(_206.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _369 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _372 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float4 _375 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _365, level(0.0));
        float _377 = _369.w;
        float _385 = _375.w;
        _396 = _346 * _377;
        _397 = (_336 * _385) + _375.z;
        _398 = (0.5 * _385) + _375.y;
        _399 = _375.x;
        _400 = (_331 * _377) + _369.xyz;
        _401 = normalize((_278 * _372.w) + ((_372.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _396 = _346;
        _397 = _336;
        _398 = 0.5;
        _399 = 0.0;
        _400 = _331;
        _401 = _278;
    }
    float _450;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].z > 0.0)
    {
        float3 _418 = fast::clamp((_216 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _429 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_418.x), int(_418.y), int(_418.z), 0).xyz), 0));
        _450 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_429.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_418 / float3(_429.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _450 = 1.0;
    }
    float3 _453 = sqrt(fast::clamp(_396, float3(0.0), float3(1.0)));
    float4 _455 = float4(_453.x, _453.y, _453.z, float4(0.0).w);
    _455.w = 1.0;
    float3 _460 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _461 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _479 = ((_400 - (_400 * _399)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _486 = (mix(float3(0.07999999821186065673828125 * _398), _400, float3(_399)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _489 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _494;
    if (_489)
    {
        _494 = _479 + (_486 * 0.449999988079071044921875);
    }
    else
    {
        _494 = _479;
    }
    float3 _503 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _532;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _531;
        if (any(abs(_216 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _217 + 19u)].xyz + float3(1.0))))
        {
            _531 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_216, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _531 = _503;
        }
        _532 = _531;
    }
    else
    {
        _532 = _503;
    }
    float4 _538 = float4((mix(float3(0.0), _494 + (select(_486, float3(0.0), bool3(_489)) * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + _532) * 1.0, 0.0);
    float4 _545;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _544 = _538;
        _544.w = 0.0;
        _545 = _544;
    }
    else
    {
        _545 = _538;
    }
    float2 _549 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _557 = (_401 * 0.5) + float3(0.5);
    float4 _559 = float4(_557.x, _557.y, _557.z, float4(0.0).w);
    _559.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _347)].y;
    float4 _560 = float4(0.0);
    _560.x = _399;
    float4 _561 = _560;
    _561.y = _398;
    float4 _562 = _561;
    _562.z = fast::max(_397, fast::clamp((pow(fast::max(dot(_460, _460), dot(_461, _461)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _563 = _562;
    _563.w = 0.525490224361419677734375;
    float4 _566 = float4(_400.x, _400.y, _400.z, float4(0.0).w);
    _566.w = (fract(dot(_549.xyx * _549.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125;
    out.out_var_SV_Target0 = _545 * View.View_PreExposure;
    out.out_var_SV_Target1 = _559;
    out.out_var_SV_Target2 = _563;
    out.out_var_SV_Target3 = _566;
    out.out_var_SV_Target4 = _455;
    out.out_var_SV_Target5 = float4(_450, 1.0, 1.0, 1.0);
    return out;
}

