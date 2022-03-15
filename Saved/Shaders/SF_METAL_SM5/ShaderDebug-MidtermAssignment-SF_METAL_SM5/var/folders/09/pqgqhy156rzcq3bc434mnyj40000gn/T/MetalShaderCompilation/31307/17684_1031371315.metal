

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
    char _m11_pad[16];
    float View_OutOfBoundsMask;
    char _m12_pad[48];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[604];
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
    spvUnsafeArray<float4, 8> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _181 = {};
constant float4 _183 = {};

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

fragment MainPS_out Main_00004514_3d797a33(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _235 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    float2 _245 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _251 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float2 _254 = (_251.xy * float2(2.0)) - float2(1.0);
    float2 _262 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125;
    float4 _266 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float _293;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _293 = _235.w;
                break;
            }
            else
            {
                float _277 = _235.z;
                _293 = ((_277 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_277 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _300 = float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _266.x) + _293) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0));
    float3 _309 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(float4(_254, sqrt(fast::clamp(1.0 - dot(_254, _254), 0.0, 1.0)), 1.0).xyz, float3(0.0, 0.0, 1.0), _300) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _320 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _245, bias(View.View_MaterialTextureMipBias));
    float4 _336 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, ((float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.75) * 0.00999999977648258209228515625), bias(View.View_MaterialTextureMipBias));
    float3 _342 = mix(Material.Material_VectorExpressions[3].xyz * _320.y, _320.xyz * Material.Material_VectorExpressions[5].xyz, float3(fast::min(fast::max(mix(-0.25, 2.0, _336.x), 0.0), 1.0)));
    float4 _344 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _262, bias(View.View_MaterialTextureMipBias));
    float4 _352 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float3 _357 = fast::clamp(mix(_342, mix(_342, mix(_344.xyz, Material.Material_VectorExpressions[7].xyz, float3(0.300000011920928955078125)), float3(_352.x)), _300), float3(0.0), float3(1.0));
    uint _358 = in.in_var_PRIMITIVE_ID * 36u;
    uint _359 = _358 + 20u;
    float _406;
    float _407;
    float _408;
    float3 _409;
    float3 _410;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _377 = ((_235.xy / float2(_235.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _381 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _384 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float4 _387 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _377, level(0.0));
        float _397 = _387.w;
        _406 = _397 + _387.z;
        _407 = (0.5 * _397) + _387.y;
        _408 = _387.x;
        _409 = (_357 * _381.w) + _381.xyz;
        _410 = normalize((_309 * _384.w) + ((_384.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _406 = 1.0;
        _407 = 0.5;
        _408 = 0.0;
        _409 = _357;
        _410 = _309;
    }
    float3 _420 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _431 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_420.x), int(_420.y), int(_420.z), 0).xyz), 0));
    float3 _446 = (((_431.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_420 / float3(_431.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _459;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].z > 0.0)
    {
        _459 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _446, level(0.0)).x;
    }
    else
    {
        _459 = 1.0;
    }
    float3 _482 = (((_409 - (_409 * _408)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz) + (((mix(float3(0.07999999821186065673828125 * _407), _409, float3(_408)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz) * 0.449999988079071044921875);
    float4 _486 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _446, level(0.0));
    float _502 = _486.x;
    float4 _504 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _502) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _505 = _486.y;
    float4 _507 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _505) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _508 = _486.z;
    float4 _510 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _527 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _502) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _529 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _505) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _531 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _446, level(0.0)) * 2.0) - float4(1.0)) * _508) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _564 = _183;
    _564.y = (-0.48860299587249755859375) * _410.y;
    float4 _567 = _564;
    _567.z = 0.48860299587249755859375 * _410.z;
    float4 _570 = _567;
    _570.w = (-0.48860299587249755859375) * _410.x;
    float3 _571 = _410 * _410;
    float4 _574 = _181;
    _574.x = (1.09254801273345947265625 * _410.x) * _410.y;
    float4 _577 = _574;
    _577.y = ((-1.09254801273345947265625) * _410.y) * _410.z;
    float4 _582 = _577;
    _582.z = 0.3153919875621795654296875 * ((3.0 * _571.z) - 1.0);
    float4 _585 = _582;
    _585.w = ((-1.09254801273345947265625) * _410.x) * _410.z;
    float4 _589 = _570;
    _589.x = 0.886227548122406005859375;
    float3 _591 = _589.yzw * 2.094395160675048828125;
    float4 _592 = float4(_589.x, _591.x, _591.y, _591.z);
    float4 _593 = _585 * 0.785398185253143310546875;
    float _594 = (_571.x - _571.y) * 0.4290426075458526611328125;
    float3 _600 = float3(0.0);
    _600.x = (dot(float4(_502, _504.xyz), _592) + dot(float4(_504.w, _527.xyz), _593)) + (_527.w * _594);
    float3 _606 = _600;
    _606.y = (dot(float4(_505, _507.xyz), _592) + dot(float4(_507.w, _529.xyz), _593)) + (_529.w * _594);
    float3 _612 = _606;
    _612.z = (dot(float4(_508, _510.xyz), _592) + dot(float4(_510.w, _531.xyz), _593)) + (_531.w * _594);
    float3 _617 = (fast::max(float3(0.0), _612) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _637 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _666;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _665;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _358 + 19u)].xyz + float3(1.0))))
        {
            _665 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _665 = _637;
        }
        _666 = _665;
    }
    else
    {
        _666 = _637;
    }
    float4 _673 = float4(((mix(float3(0.0), _482, float3(View.View_UnlitViewmodeMask)) + ((_617 * _482) * fast::max(float3(1.0), ((((((_409 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_409 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_409 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _666) * 1.0, 0.0);
    float4 _680;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _679 = _673;
        _679.w = 0.0;
        _680 = _679;
    }
    else
    {
        _680 = _673;
    }
    float2 _684 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _692 = (_410 * 0.5) + float3(0.5);
    float4 _694 = float4(_692.x, _692.y, _692.z, float4(0.0).w);
    _694.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _359)].y;
    float4 _695 = float4(0.0);
    _695.x = _408;
    float4 _696 = _695;
    _696.y = _407;
    float4 _697 = _696;
    _697.z = _406;
    float4 _698 = _697;
    _698.w = 0.50588238239288330078125;
    float4 _709 = float4(_409.x, _409.y, _409.z, float4(0.0).w);
    _709.w = ((log2((dot(_617, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_684.xyx * _684.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _680 * View.View_PreExposure;
    out.out_var_SV_Target1 = _694;
    out.out_var_SV_Target2 = _698;
    out.out_var_SV_Target3 = _709;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_459, 1.0, 1.0, 1.0);
    return out;
}

