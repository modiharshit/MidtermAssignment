

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

constant float4 _164 = {};
constant float _166 = {};
constant float4 _167 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_00003f79_c7f1186f(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _227 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _166, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _232 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _237 = (_232.xyz / float3(_232.w)) - View.View_PreViewTranslation;
    uint _238 = in.in_var_PRIMITIVE_ID * 36u;
    float3 _254 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float3(0.0, 0.0, 1.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    if ((mix(-90.0, 90.0, Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y)).x) - 0.33329999446868896484375) < 0.0)
    {
        discard_fragment();
    }
    float3 _273 = fast::clamp(in.in_var_COLOR0.xyz, float3(0.0), float3(1.0));
    float _277 = (0.5 * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _278 = _238 + 20u;
    float _326;
    float _327;
    float _328;
    float3 _329;
    float3 _330;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _296 = ((_227.xy / float2(_227.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _300 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float4 _303 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float4 _306 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _296, level(0.0));
        float _316 = _306.w;
        _326 = (_277 * _316) + _306.z;
        _327 = (0.5 * _316) + _306.y;
        _328 = _306.x;
        _329 = (_273 * _300.w) + _300.xyz;
        _330 = normalize((_254 * _303.w) + ((_303.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _326 = _277;
        _327 = 0.5;
        _328 = 0.0;
        _329 = _273;
        _330 = _254;
    }
    float3 _340 = fast::clamp((_237 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _351 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_340.x), int(_340.y), int(_340.z), 0).xyz), 0));
    float3 _366 = (((_351.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_340 / float3(_351.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _379;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278)].z > 0.0)
    {
        _379 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _366, level(0.0)).x;
    }
    else
    {
        _379 = 1.0;
    }
    float3 _393 = ((_329 - (_329 * _328)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _400 = (mix(float3(0.07999999821186065673828125 * _327), _329, float3(_328)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _403 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _408;
    if (_403)
    {
        _408 = _393 + (_400 * 0.449999988079071044921875);
    }
    else
    {
        _408 = _393;
    }
    float3 _410 = select(_400, float3(0.0), bool3(_403));
    float3 _412 = float3(dot(_410, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _429 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _366, level(0.0));
    float _445 = _429.x;
    float4 _447 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _445) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _448 = _429.y;
    float4 _450 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _448) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _451 = _429.z;
    float4 _453 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _451) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _470 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _445) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _472 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _448) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _474 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _366, level(0.0)) * 2.0) - float4(1.0)) * _451) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _507 = _167;
    _507.y = (-0.48860299587249755859375) * _330.y;
    float4 _510 = _507;
    _510.z = 0.48860299587249755859375 * _330.z;
    float4 _513 = _510;
    _513.w = (-0.48860299587249755859375) * _330.x;
    float3 _514 = _330 * _330;
    float4 _517 = _164;
    _517.x = (1.09254801273345947265625 * _330.x) * _330.y;
    float4 _520 = _517;
    _520.y = ((-1.09254801273345947265625) * _330.y) * _330.z;
    float4 _525 = _520;
    _525.z = 0.3153919875621795654296875 * ((3.0 * _514.z) - 1.0);
    float4 _528 = _525;
    _528.w = ((-1.09254801273345947265625) * _330.x) * _330.z;
    float4 _532 = _513;
    _532.x = 0.886227548122406005859375;
    float3 _534 = _532.yzw * 2.094395160675048828125;
    float4 _535 = float4(_532.x, _534.x, _534.y, _534.z);
    float4 _536 = _528 * 0.785398185253143310546875;
    float _537 = (_514.x - _514.y) * 0.4290426075458526611328125;
    float3 _543 = float3(0.0);
    _543.x = (dot(float4(_445, _447.xyz), _535) + dot(float4(_447.w, _470.xyz), _536)) + (_470.w * _537);
    float3 _549 = _543;
    _549.y = (dot(float4(_448, _450.xyz), _535) + dot(float4(_450.w, _472.xyz), _536)) + (_472.w * _537);
    float3 _555 = _549;
    _555.z = (dot(float4(_451, _453.xyz), _535) + dot(float4(_453.w, _474.xyz), _536)) + (_474.w * _537);
    float3 _560 = (fast::max(float3(0.0), _555) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _582 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _611;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _610;
        if (any(abs(_237 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _238 + 19u)].xyz + float3(1.0))))
        {
            _610 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_237, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _610 = _582;
        }
        _611 = _610;
    }
    else
    {
        _611 = _582;
    }
    float4 _618 = float4(((mix(float3(0.0), _408 + (_410 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_560 * _408) * fast::max(float3(1.0), ((((((_329 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_329 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_329 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _611) * 1.0, 0.0);
    float4 _625;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _624 = _618;
        _624.w = 0.0;
        _625 = _624;
    }
    else
    {
        _625 = _618;
    }
    float2 _629 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _637 = (_330 * 0.5) + float3(0.5);
    float4 _639 = float4(_637.x, _637.y, _637.z, float4(0.0).w);
    _639.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _278)].y;
    float4 _640 = float4(0.0);
    _640.x = _328;
    float4 _641 = _640;
    _641.y = _327;
    float4 _642 = _641;
    _642.z = _326;
    float4 _643 = _642;
    _643.w = 0.50588238239288330078125;
    float4 _655 = float4(_329.x, _329.y, _329.z, float4(0.0).w);
    _655.w = ((log2(((dot(_560, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_412 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_412 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_412 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_629.xyx * _629.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _625 * View.View_PreExposure;
    out.out_var_SV_Target1 = _639;
    out.out_var_SV_Target2 = _643;
    out.out_var_SV_Target3 = _655;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_379, 1.0, 1.0, 1.0);
    return out;
}

