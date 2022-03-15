

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
    char _m15_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m16_pad[400];
    packed_float3 View_NormalCurvatureToRoughnessScaleBias;
    float View_RenderingReflectionCaptureMask;
    char _m18_pad[188];
    float View_ShowDecalsMask;
    char _m19_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m20_pad[48];
    float3 View_VolumetricLightmapWorldToUVScale;
    float3 View_VolumetricLightmapWorldToUVAdd;
    packed_float3 View_VolumetricLightmapIndirectionTextureSize;
    float View_VolumetricLightmapBrickSize;
    float3 View_VolumetricLightmapBrickTexelSize;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    char _m1_pad[16];
    float4 Primitive_ObjectWorldPositionAndRadius;
    char _m2_pad[208];
    float3 Primitive_ObjectBounds;
    float Primitive_DecalReceiverMask;
    float Primitive_PerObjectGBufferData;
    float Primitive_UseVolumetricLightmapShadowFromStationaryLights;
};

struct type_Material
{
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _172 = {};
constant float4 _173 = {};
constant float _175 = {};
constant float4 _176 = {};
constant float3 _177 = {};

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
    float4 in_var_COLOR1 [[user(locn3)]];
    float4 in_var_TEXCOORD0_0 [[user(locn4)]];
};

fragment MainPS_out Main_00004d76_f2c1c01b(MainPS_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_3 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    float3x3 _231 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _243 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _175, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _248 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _253 = (_248.xyz / float3(_248.w)) - View.View_PreViewTranslation;
    float3 _258 = (Primitive.Primitive_LocalToWorld * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _270 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _273 = (float3(-0.5) + _270.xyz) * 2.0;
    float3 _289 = ((((_258 / float3(sqrt(dot(_258, _258)))) * _231) * (-1.0)) * _273.z) + (float3(_273.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _231));
    float3 _301 = normalize(_231 * normalize(((_289 / float3(sqrt(dot(_289, _289)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _312 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _319 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (abs(in.in_var_COLOR1.w) > 0.001000000047497451305389404296875)
    {
        float _335 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
        if ((float((in.in_var_COLOR1.w < 0.0) ? ((in.in_var_COLOR1.w + 1.0) > _335) : (in.in_var_COLOR1.w < _335)) - 0.001000000047497451305389404296875) < 0.0)
        {
            discard_fragment();
        }
    }
    if (((_312.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _350 = fast::clamp(_312.xyz, float3(0.0), float3(1.0));
    float _355 = (fast::clamp(_270.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _365 = (fast::clamp(float4(_319.xyz, _172).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _413;
    float _414;
    float _415;
    float _416;
    float3 _417;
    float3 _418;
    if ((Primitive.Primitive_DecalReceiverMask > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _382 = ((_243.xy / float2(_243.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _386 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _389 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float4 _392 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _382, level(0.0));
        float _394 = _386.w;
        float _402 = _392.w;
        _413 = _365 * _394;
        _414 = (_355 * _402) + _392.z;
        _415 = (0.5 * _402) + _392.y;
        _416 = _392.x;
        _417 = (_350 * _394) + _386.xyz;
        _418 = normalize((_301 * _389.w) + ((_389.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _413 = _365;
        _414 = _355;
        _415 = 0.5;
        _416 = 0.0;
        _417 = _350;
        _418 = _301;
    }
    float3 _428 = fast::clamp((_253 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _439 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_428.x), int(_428.y), int(_428.z), 0).xyz), 0));
    float3 _454 = (((_439.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_428 / float3(_439.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _467;
    if (Primitive.Primitive_UseVolumetricLightmapShadowFromStationaryLights > 0.0)
    {
        _467 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _454, level(0.0)).x;
    }
    else
    {
        _467 = 1.0;
    }
    float3 _470 = sqrt(fast::clamp(_413, float3(0.0), float3(1.0)));
    float4 _472 = float4(_470.x, _470.y, _470.z, float4(0.0).w);
    _472.w = 1.0;
    float3 _477 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _478 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _496 = ((_417 - (_417 * _416)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _503 = (mix(float3(0.07999999821186065673828125 * _415), _417, float3(_416)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _506 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _511;
    if (_506)
    {
        _511 = _496 + (_503 * 0.449999988079071044921875);
    }
    else
    {
        _511 = _496;
    }
    float3 _513 = select(_503, float3(0.0), bool3(_506));
    float3 _515 = float3(dot(_513, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _532 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _454, level(0.0));
    float _548 = _532.x;
    float4 _550 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _548) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _551 = _532.y;
    float4 _553 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _551) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _554 = _532.z;
    float4 _556 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _554) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _573 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _548) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _575 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _551) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _577 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _454, level(0.0)) * 2.0) - float4(1.0)) * _554) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _581 = float4(_548, _550.xyz);
    float4 _586 = float4(_550.w, _573.xyz);
    float _587 = _573.w;
    float4 _591 = float4(_551, _553.xyz);
    float4 _596 = float4(_553.w, _575.xyz);
    float _597 = _575.w;
    float4 _601 = float4(_554, _556.xyz);
    float4 _606 = float4(_556.w, _577.xyz);
    float _607 = _577.w;
    float4 _610 = _176;
    _610.y = (-0.48860299587249755859375) * _418.y;
    float4 _613 = _610;
    _613.z = 0.48860299587249755859375 * _418.z;
    float4 _616 = _613;
    _616.w = (-0.48860299587249755859375) * _418.x;
    float3 _617 = _418 * _418;
    float4 _620 = _173;
    _620.x = (1.09254801273345947265625 * _418.x) * _418.y;
    float4 _623 = _620;
    _623.y = ((-1.09254801273345947265625) * _418.y) * _418.z;
    float4 _628 = _623;
    _628.z = 0.3153919875621795654296875 * ((3.0 * _617.z) - 1.0);
    float4 _631 = _628;
    _631.w = ((-1.09254801273345947265625) * _418.x) * _418.z;
    float4 _635 = _616;
    _635.x = 0.886227548122406005859375;
    float3 _637 = _635.yzw * 2.094395160675048828125;
    float4 _638 = float4(_635.x, _637.x, _637.y, _637.z);
    float4 _639 = _631 * 0.785398185253143310546875;
    float _640 = (_617.x - _617.y) * 0.4290426075458526611328125;
    float3 _646 = float3(0.0);
    _646.x = (dot(_581, _638) + dot(_586, _639)) + (_587 * _640);
    float3 _652 = _646;
    _652.y = (dot(_591, _638) + dot(_596, _639)) + (_597 * _640);
    float3 _658 = _652;
    _658.z = (dot(_601, _638) + dot(_606, _639)) + (_607 * _640);
    float3 _661 = -_418;
    float _662 = _661.y;
    float4 _664 = _176;
    _664.y = (-0.48860299587249755859375) * _662;
    float _665 = _661.z;
    float4 _667 = _664;
    _667.z = 0.48860299587249755859375 * _665;
    float _668 = _661.x;
    float4 _670 = _667;
    _670.w = (-0.48860299587249755859375) * _668;
    float3 _671 = _661 * _661;
    float4 _674 = _173;
    _674.x = (1.09254801273345947265625 * _668) * _662;
    float4 _677 = _674;
    _677.y = ((-1.09254801273345947265625) * _662) * _665;
    float4 _682 = _677;
    _682.z = 0.3153919875621795654296875 * ((3.0 * _671.z) - 1.0);
    float4 _685 = _682;
    _685.w = ((-1.09254801273345947265625) * _668) * _665;
    float4 _689 = _670;
    _689.x = 0.886227548122406005859375;
    float3 _691 = _689.yzw * 2.094395160675048828125;
    float4 _692 = float4(_689.x, _691.x, _691.y, _691.z);
    float4 _693 = _685 * 0.785398185253143310546875;
    float _694 = (_671.x - _671.y) * 0.4290426075458526611328125;
    float3 _700 = _177;
    _700.x = (dot(_581, _692) + dot(_586, _693)) + (_587 * _694);
    float3 _706 = _700;
    _706.y = (dot(_591, _692) + dot(_596, _693)) + (_597 * _694);
    float3 _712 = _706;
    _712.z = (dot(_601, _692) + dot(_606, _693)) + (_607 * _694);
    float3 _717 = (fast::max(float3(0.0), _658) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _742 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _768;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _767;
        if (any(abs(_253 - Primitive.Primitive_ObjectWorldPositionAndRadius.xyz) > (Primitive.Primitive_ObjectBounds + float3(1.0))))
        {
            _767 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_253, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _767 = _742;
        }
        _768 = _767;
    }
    else
    {
        _768 = _742;
    }
    float4 _775 = float4(((mix(float3(0.0), _511 + (_513 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_717 * _511) + (((fast::max(float3(0.0), _712) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _413)) * fast::max(float3(1.0), ((((((_417 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_417 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_417 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _768) * 1.0, 0.0);
    float4 _782;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _781 = _775;
        _781.w = 0.0;
        _782 = _781;
    }
    else
    {
        _782 = _775;
    }
    float2 _786 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _794 = (_418 * 0.5) + float3(0.5);
    float4 _796 = float4(_794.x, _794.y, _794.z, float4(0.0).w);
    _796.w = Primitive.Primitive_PerObjectGBufferData;
    float4 _797 = float4(0.0);
    _797.x = _416;
    float4 _798 = _797;
    _798.y = _415;
    float4 _799 = _798;
    _799.z = fast::max(_414, fast::clamp((pow(fast::max(dot(_477, _477), dot(_478, _478)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _800 = _799;
    _800.w = 0.525490224361419677734375;
    float4 _812 = float4(_417.x, _417.y, _417.z, float4(0.0).w);
    _812.w = ((log2(((dot(_717, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_515 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_515 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_515 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_786.xyx * _786.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _782 * View.View_PreExposure;
    out.out_var_SV_Target1 = _796;
    out.out_var_SV_Target2 = _800;
    out.out_var_SV_Target3 = _812;
    out.out_var_SV_Target4 = _472;
    out.out_var_SV_Target5 = float4(_467, 1.0, 1.0, 1.0);
    return out;
}

