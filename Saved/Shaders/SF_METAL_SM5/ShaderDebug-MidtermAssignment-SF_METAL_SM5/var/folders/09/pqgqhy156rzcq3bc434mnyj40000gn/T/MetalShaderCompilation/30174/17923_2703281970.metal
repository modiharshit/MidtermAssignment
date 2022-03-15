

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

constant float4 _176 = {};
constant float4 _178 = {};

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
    float4 in_var_COLOR1 [[user(locn2)]];
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
};

fragment MainPS_out Main_00004603_a120cf32(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float4 _237 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _241 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _246 = (_241.xyz / float3(_241.w)) - View.View_PreViewTranslation;
    float4 _254 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(10.0)), bias(View.View_MaterialTextureMipBias));
    float2 _257 = (_254.xy * float2(2.0)) - float2(1.0);
    float3 _274 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize(((float4(_257, sqrt(fast::clamp(1.0 - dot(_257, _257), 0.0, 1.0)), 1.0).xyz * float3(0.300000011920928955078125, 0.300000011920928955078125, 1.0)) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _286 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 20.0), bias(View.View_MaterialTextureMipBias));
    float _288 = mix(0.4000000059604644775390625, 1.0, _286.x);
    float4 _292 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(5.0)), bias(View.View_MaterialTextureMipBias));
    float _317;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _317 = _237.w;
                break;
            }
            else
            {
                float _301 = _237.z;
                _317 = ((_301 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_301 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float _321 = fast::min(fast::max((_317 - 24.0) * 0.000666666659526526927947998046875, 0.0), 1.0);
    float _322 = _292.y;
    float4 _326 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * float2(0.5)), bias(View.View_MaterialTextureMipBias));
    float _328 = _326.y;
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _350 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _350) : (in.in_var_COLOR1.w < _350)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    float3 _361 = fast::clamp(float3(mix(_288, 1.0 - _288, mix(_322, 1.0, _321)) * (mix(0.2949999868869781494140625, 0.660000026226043701171875, mix(_328 + mix(_322, 0.0, _321), 0.5, 0.5)) * 0.5)), float3(0.0), float3(1.0));
    float _366 = (fast::clamp(fast::min(fast::max(mix(0.0, 0.5, _328) + mix(mix(0.699999988079071044921875, 1.0, _322), 1.0, _321), 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float _413;
    float _414;
    float _415;
    float3 _416;
    float3 _417;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _383 = ((_237.xy / float2(_237.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _387 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _390 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float4 _393 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _383, level(0.0));
        float _403 = _393.w;
        _413 = (_366 * _403) + _393.z;
        _414 = (0.5 * _403) + _393.y;
        _415 = _393.x;
        _416 = (_361 * _387.w) + _387.xyz;
        _417 = normalize((_274 * _390.w) + ((_390.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _366;
        _414 = 0.5;
        _415 = 0.0;
        _416 = _361;
        _417 = _274;
    }
    float3 _427 = fast::clamp((_246 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _438 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_427.x), int(_427.y), int(_427.z), 0).xyz), 0));
    float3 _453 = (((_438.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_427 / float3(_438.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _466;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _466 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _453, level(0.0)).x;
    }
    else
    {
        _466 = 1.0;
    }
    float3 _480 = ((_416 - (_416 * _415)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _487 = (mix(float3(0.07999999821186065673828125 * _414), _416, float3(_415)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _490 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _495;
    if (_490)
    {
        _495 = _480 + (_487 * 0.449999988079071044921875);
    }
    else
    {
        _495 = _480;
    }
    float3 _497 = select(_487, float3(0.0), bool3(_490));
    float3 _499 = float3(dot(_497, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _516 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _453, level(0.0));
    float _532 = _516.x;
    float4 _534 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _532) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _535 = _516.y;
    float4 _537 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _538 = _516.z;
    float4 _540 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _557 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _532) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _559 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _535) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _561 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _453, level(0.0)) * 2.0) - float4(1.0)) * _538) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _594 = _178;
    _594.y = (-0.48860299587249755859375) * _417.y;
    float4 _597 = _594;
    _597.z = 0.48860299587249755859375 * _417.z;
    float4 _600 = _597;
    _600.w = (-0.48860299587249755859375) * _417.x;
    float3 _601 = _417 * _417;
    float4 _604 = _176;
    _604.x = (1.09254801273345947265625 * _417.x) * _417.y;
    float4 _607 = _604;
    _607.y = ((-1.09254801273345947265625) * _417.y) * _417.z;
    float4 _612 = _607;
    _612.z = 0.3153919875621795654296875 * ((3.0 * _601.z) - 1.0);
    float4 _615 = _612;
    _615.w = ((-1.09254801273345947265625) * _417.x) * _417.z;
    float4 _619 = _600;
    _619.x = 0.886227548122406005859375;
    float3 _621 = _619.yzw * 2.094395160675048828125;
    float4 _622 = float4(_619.x, _621.x, _621.y, _621.z);
    float4 _623 = _615 * 0.785398185253143310546875;
    float _624 = (_601.x - _601.y) * 0.4290426075458526611328125;
    float3 _630 = float3(0.0);
    _630.x = (dot(float4(_532, _534.xyz), _622) + dot(float4(_534.w, _557.xyz), _623)) + (_557.w * _624);
    float3 _636 = _630;
    _636.y = (dot(float4(_535, _537.xyz), _622) + dot(float4(_537.w, _559.xyz), _623)) + (_559.w * _624);
    float3 _642 = _636;
    _642.z = (dot(float4(_538, _540.xyz), _622) + dot(float4(_540.w, _561.xyz), _623)) + (_561.w * _624);
    float3 _647 = (fast::max(float3(0.0), _642) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _669 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _695;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _694;
        if (any(abs(_246 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _694 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_246, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _694 = _669;
        }
        _695 = _694;
    }
    else
    {
        _695 = _669;
    }
    float4 _702 = float4(((mix(float3(0.0), _495 + (_497 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_647 * _495) * fast::max(float3(1.0), ((((((_416 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_416 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_416 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _695) * 1.0, 0.0);
    float4 _709;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _708 = _702;
        _708.w = 0.0;
        _709 = _708;
    }
    else
    {
        _709 = _702;
    }
    float2 _713 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _721 = (_417 * 0.5) + float3(0.5);
    float4 _723 = float4(_721.x, _721.y, _721.z, float4(0.0).w);
    _723.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _724 = float4(0.0);
    _724.x = _415;
    float4 _725 = _724;
    _725.y = _414;
    float4 _726 = _725;
    _726.z = _413;
    float4 _727 = _726;
    _727.w = 0.50588238239288330078125;
    float4 _739 = float4(_416.x, _416.y, _416.z, float4(0.0).w);
    _739.w = ((log2(((dot(_647, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_499 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_499 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_499 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_713.xyx * _713.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _709 * View.View_PreExposure;
    out.out_var_SV_Target1 = _723;
    out.out_var_SV_Target2 = _727;
    out.out_var_SV_Target3 = _739;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_466, 1.0, 1.0, 1.0);
    return out;
}

