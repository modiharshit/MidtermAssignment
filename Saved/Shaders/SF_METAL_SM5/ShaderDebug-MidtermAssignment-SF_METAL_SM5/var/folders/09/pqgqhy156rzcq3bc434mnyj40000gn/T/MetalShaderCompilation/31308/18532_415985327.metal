

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
    char _m0_pad[448];
    float4x4 View_ViewToClip;
    char _m1_pad[192];
    float4x4 View_SVPositionToTranslatedWorld;
    char _m2_pad[272];
    float4 View_InvDeviceZToWorldZTransform;
    float4 View_ScreenPositionScaleBias;
    char _m4_pad[48];
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
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[412];
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

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _178 = {};
constant float4 _180 = {};

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

fragment MainPS_out Main_00004864_18cb6eaf(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _252 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _255 = (_252.xy * float2(2.0)) - float2(1.0);
    float4 _267 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _294;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _294 = _237.w;
                break;
            }
            else
            {
                float _278 = _237.z;
                _294 = ((_278 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_278 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _310 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_255, sqrt(fast::clamp(1.0 - dot(_255, _255), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _267.x) + _294) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _322 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _327 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _332 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _336 = (_322.x + 0.5) * ((_327.x + 0.5) * (_332.x + 0.5));
    float4 _342 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _348 = fast::clamp(mix(float3(0.300000011920928955078125), float3(1.0), float3(_336)) * _342.xyz, float3(0.0), float3(1.0));
    float _353 = (fast::clamp(mix(0.5, 0.20000000298023223876953125, _336 * _342.w), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _354 = in.in_var_PRIMITIVE_ID * 36u;
    uint _355 = _354 + 20u;
    float _403;
    float _404;
    float _405;
    float3 _406;
    float3 _407;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _373 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _377 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _380 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float4 _383 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _373, level(0.0));
        float _393 = _383.w;
        _403 = (_353 * _393) + _383.z;
        _404 = (0.5 * _393) + _383.y;
        _405 = _383.x;
        _406 = (_348 * _377.w) + _377.xyz;
        _407 = normalize((_310 * _380.w) + ((_380.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _403 = _353;
        _404 = 0.5;
        _405 = 0.0;
        _406 = _348;
        _407 = _310;
    }
    float3 _417 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _428 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_417.x), int(_417.y), int(_417.z), 0).xyz), 0));
    float3 _443 = (((_428.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_417 / float3(_428.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _456;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355)].z > 0.0)
    {
        _456 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _443, level(0.0)).x;
    }
    else
    {
        _456 = 1.0;
    }
    float3 _470 = ((_406 - (_406 * _405)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _477 = (mix(float3(0.07999999821186065673828125 * _404), _406, float3(_405)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _480 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _485;
    if (_480)
    {
        _485 = _470 + (_477 * 0.449999988079071044921875);
    }
    else
    {
        _485 = _470;
    }
    float3 _487 = select(_477, float3(0.0), bool3(_480));
    float3 _489 = float3(dot(_487, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _506 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _443, level(0.0));
    float _522 = _506.x;
    float4 _524 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _525 = _506.y;
    float4 _527 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _528 = _506.z;
    float4 _530 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _547 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _522) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _525) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _443, level(0.0)) * 2.0) - float4(1.0)) * _528) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _584 = _180;
    _584.y = (-0.48860299587249755859375) * _407.y;
    float4 _587 = _584;
    _587.z = 0.48860299587249755859375 * _407.z;
    float4 _590 = _587;
    _590.w = (-0.48860299587249755859375) * _407.x;
    float3 _591 = _407 * _407;
    float4 _594 = _178;
    _594.x = (1.09254801273345947265625 * _407.x) * _407.y;
    float4 _597 = _594;
    _597.y = ((-1.09254801273345947265625) * _407.y) * _407.z;
    float4 _602 = _597;
    _602.z = 0.3153919875621795654296875 * ((3.0 * _591.z) - 1.0);
    float4 _605 = _602;
    _605.w = ((-1.09254801273345947265625) * _407.x) * _407.z;
    float4 _609 = _590;
    _609.x = 0.886227548122406005859375;
    float3 _611 = _609.yzw * 2.094395160675048828125;
    float4 _612 = float4(_609.x, _611.x, _611.y, _611.z);
    float4 _613 = _605 * 0.785398185253143310546875;
    float _614 = (_591.x - _591.y) * 0.4290426075458526611328125;
    float3 _620 = float3(0.0);
    _620.x = (dot(float4(_522, _524.xyz), _612) + dot(float4(_524.w, _547.xyz), _613)) + (_547.w * _614);
    float3 _626 = _620;
    _626.y = (dot(float4(_525, _527.xyz), _612) + dot(float4(_527.w, _549.xyz), _613)) + (_549.w * _614);
    float3 _632 = _626;
    _632.z = (dot(float4(_528, _530.xyz), _612) + dot(float4(_530.w, _551.xyz), _613)) + (_551.w * _614);
    float3 _637 = (fast::max(float3(0.0), _632) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _659 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _688;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _687;
        if (any(abs(_246 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _354 + 19u)].xyz + float3(1.0))))
        {
            _687 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _687 = _659;
        }
        _688 = _687;
    }
    else
    {
        _688 = _659;
    }
    float4 _695 = float4(((mix(float3(0.0), _485 + (_487 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_637 * _485) * fast::max(float3(1.0), ((((((_406 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_406 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_406 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _688) * 1.0, 0.0);
    float4 _702;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _701 = _695;
        _701.w = 0.0;
        _702 = _701;
    }
    else
    {
        _702 = _695;
    }
    float2 _706 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _714 = (_407 * 0.5) + float3(0.5);
    float4 _716 = float4(_714.x, _714.y, _714.z, float4(0.0).w);
    _716.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _355)].y;
    float4 _717 = float4(0.0);
    _717.x = _405;
    float4 _718 = _717;
    _718.y = _404;
    float4 _719 = _718;
    _719.z = _403;
    float4 _720 = _719;
    _720.w = 0.50588238239288330078125;
    float4 _732 = float4(_406.x, _406.y, _406.z, float4(0.0).w);
    _732.w = ((log2(((dot(_637, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_489 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_489 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_489 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_706.xyx * _706.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _702 * View.View_PreExposure;
    out.out_var_SV_Target1 = _716;
    out.out_var_SV_Target2 = _720;
    out.out_var_SV_Target3 = _732;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_456, 1.0, 1.0, 1.0);
    return out;
}

