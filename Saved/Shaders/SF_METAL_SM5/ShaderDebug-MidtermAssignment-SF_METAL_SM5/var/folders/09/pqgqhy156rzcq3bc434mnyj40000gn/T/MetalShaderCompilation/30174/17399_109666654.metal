

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

struct type_Primitive
{
    char _m0_pad[80];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m1_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 2> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _172 = {};
constant float4 _174 = {};

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
    float4 in_var_TEXCOORD10 [[user(locn0)]];
    float4 in_var_TEXCOORD11 [[user(locn1)]];
    float4 in_var_TEXCOORD3_0 [[user(locn2)]];
};

fragment MainPS_out Main_000043f7_0689615e(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD3 = {};
    in_var_TEXCOORD3[0] = in.in_var_TEXCOORD3_0;
    float4 _232 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    float4 _249 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _252 = (_249.xy * float2(2.0)) - float2(1.0);
    float3 _269 = normalize(float3x3(in.in_var_TEXCOORD10.xyz, cross(in.in_var_TEXCOORD11.xyz, in.in_var_TEXCOORD10.xyz) * in.in_var_TEXCOORD11.w, in.in_var_TEXCOORD11.xyz) * normalize(((float4(_252, sqrt(fast::clamp(1.0 - dot(_252, _252), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _283 = mix(0.4000000059604644775390625, 1.0, _281.x);
    float4 _287 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _312;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _312 = _232.w;
                break;
            }
            else
            {
                float _296 = _232.z;
                _312 = ((_296 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_296 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _316 = fast::min(fast::max((_312 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _317 = _287.y;
    float4 _321 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD3[0].x, in_var_TEXCOORD3[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _323 = _321.y;
    float3 _336 = fast::clamp(float3(mix(_283, 1.0 - _283, mix(_317, 1.0, _316)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_323 + mix(_317, 0.0, _316), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _341 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _323) + mix(mix(0.699999988079071044921875, 1.0, _317), 1.0, _316), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _388;
    float _389;
    float _390;
    float3 _391;
    float3 _392;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _358 = ((_232.xy / float2(_232.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _362 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _365 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float4 _368 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _358, level(0.0));
        float _378 = _368.w;
        _388 = (_341 * _378) + _368.z;
        _389 = (0.5 * _378) + _368.y;
        _390 = _368.x;
        _391 = (_336 * _362.w) + _362.xyz;
        _392 = normalize((_269 * _365.w) + ((_365.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _388 = _341;
        _389 = 0.5;
        _390 = 0.0;
        _391 = _336;
        _392 = _269;
    }
    float3 _402 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _413 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_402.x), int(_402.y), int(_402.z), 0).xyz), 0));
    float3 _428 = (((_413.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_402 / float3(_413.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _441;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _441 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _428, level(0.0)).x;
    }
    else
    {
        _441 = 1.0;
    }
    float3 _455 = ((_391 - (_391 * _390)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _462 = (mix(float3(0.07999999821186065673828125 * _389), _391, float3(_390)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _465 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _470;
    if (_465)
    {
        _470 = _455 + (_462 * 0.449999988079071044921875);
    }
    else
    {
        _470 = _455;
    }
    float3 _472 = select(_462, float3(0.0), bool3(_465));
    float3 _474 = float3(dot(_472, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _491 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _428, level(0.0));
    float _507 = _491.x;
    float4 _509 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _510 = _491.y;
    float4 _512 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _510) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _513 = _491.z;
    float4 _515 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _532 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _507) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _534 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _510) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _536 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _428, level(0.0)) * 2.0) - float4(1.0)) * _513) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _569 = _174;
    _569.y = (-0.48860299587249755859375) * _392.y;
    float4 _572 = _569;
    _572.z = 0.48860299587249755859375 * _392.z;
    float4 _575 = _572;
    _575.w = (-0.48860299587249755859375) * _392.x;
    float3 _576 = _392 * _392;
    float4 _579 = _172;
    _579.x = (1.09254801273345947265625 * _392.x) * _392.y;
    float4 _582 = _579;
    _582.y = ((-1.09254801273345947265625) * _392.y) * _392.z;
    float4 _587 = _582;
    _587.z = 0.3153919875621795654296875 * ((3.0 * _576.z) - 1.0);
    float4 _590 = _587;
    _590.w = ((-1.09254801273345947265625) * _392.x) * _392.z;
    float4 _594 = _575;
    _594.x = 0.886227548122406005859375;
    float3 _596 = _594.yzw * 2.094395160675048828125;
    float4 _597 = float4(_594.x, _596.x, _596.y, _596.z);
    float4 _598 = _590 * 0.785398185253143310546875;
    float _599 = (_576.x - _576.y) * 0.4290426075458526611328125;
    float3 _605 = float3(0.0);
    _605.x = (dot(float4(_507, _509.xyz), _597) + dot(float4(_509.w, _532.xyz), _598)) + (_532.w * _599);
    float3 _611 = _605;
    _611.y = (dot(float4(_510, _512.xyz), _597) + dot(float4(_512.w, _534.xyz), _598)) + (_534.w * _599);
    float3 _617 = _611;
    _617.z = (dot(float4(_513, _515.xyz), _597) + dot(float4(_515.w, _536.xyz), _598)) + (_536.w * _599);
    float3 _622 = (fast::max(float3(0.0), _617) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _644 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _670;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _669;
        if (any(abs(_241 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _669 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _669 = _644;
        }
        _670 = _669;
    }
    else
    {
        _670 = _644;
    }
    float4 _677 = float4(((mix(float3(0.0), _470 + (_472 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_622 * _470) * fast::max(float3(1.0), ((((((_391 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_391 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_391 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _670) * 1.0, 0.0);
    float4 _684;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _683 = _677;
        _683.w = 0.0;
        _684 = _683;
    }
    else
    {
        _684 = _677;
    }
    float2 _688 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _696 = (_392 * 0.5) + float3(0.5);
    float4 _698 = float4(_696.x, _696.y, _696.z, float4(0.0).w);
    _698.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _699 = float4(0.0);
    _699.x = _390;
    float4 _700 = _699;
    _700.y = _389;
    float4 _701 = _700;
    _701.z = _388;
    float4 _702 = _701;
    _702.w = 0.50588238239288330078125;
    float4 _714 = float4(_391.x, _391.y, _391.z, float4(0.0).w);
    _714.w = ((log2(((dot(_622, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_474 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_474 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_474 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_688.xyx * _688.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _684 * View.View_PreExposure;
    out.out_var_SV_Target1 = _698;
    out.out_var_SV_Target2 = _702;
    out.out_var_SV_Target3 = _714;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_441, 1.0, 1.0, 1.0);
    return out;
}

