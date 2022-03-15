

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
    char _m11_pad[36];
    float View_GameTime;
    char _m12_pad[8];
    float View_MaterialTextureMipBias;
    char _m13_pad[28];
    float View_UnlitViewmodeMask;
    char _m14_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m15_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m16_pad[188];
    float View_ShowDecalsMask;
    char _m17_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m18_pad[48];
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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 1> Material_ScalarExpressions;
};

constant float4 _172 = {};
constant float _174 = {};
constant float4 _175 = {};

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

fragment MainPS_out Main_000043e6_8c2fd926(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _220 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _240 = _236.xyz / float3(_236.w);
    float3 _241 = _240 - View.View_PreViewTranslation;
    float4 _250 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float2 _256 = ((normalize(-_240) * _220).xy * ((0.0500000007450580596923828125 * _250.z) + (-0.02500000037252902984619140625))) + float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y);
    float4 _260 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float2 _263 = (_260.xy * float2(2.0)) - float2(1.0);
    float3 _279 = normalize(_220 * normalize((float4(_263, sqrt(fast::clamp(1.0 - dot(_263, _263), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _281 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _256, bias(View.View_MaterialTextureMipBias));
    float _294 = _281.y;
    float4 _306 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _314 = fast::clamp(float3(mix(0.25, 0.4000000059604644775390625, _306.x) * 0.25), float3(0.0), float3(1.0));
    float _319 = (fast::clamp(fast::min(fast::max(0.25 + _294, 0.0), 1.0), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _320 = in.in_var_PRIMITIVE_ID * 36u;
    uint _321 = _320 + 20u;
    float _369;
    float _370;
    float _371;
    float3 _372;
    float3 _373;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _339 = ((_231.xy / float2(_231.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _343 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float4 _349 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _339, level(0.0));
        float _359 = _349.w;
        _369 = (_319 * _359) + _349.z;
        _370 = (0.5 * _359) + _349.y;
        _371 = _349.x;
        _372 = (_314 * _343.w) + _343.xyz;
        _373 = normalize((_279 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _369 = _319;
        _370 = 0.5;
        _371 = 0.0;
        _372 = _314;
        _373 = _279;
    }
    float3 _383 = fast::clamp((_241 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _394 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_383.x), int(_383.y), int(_383.z), 0).xyz), 0));
    float3 _409 = (((_394.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_383 / float3(_394.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _422;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].z > 0.0)
    {
        _422 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _409, level(0.0)).x;
    }
    else
    {
        _422 = 1.0;
    }
    float3 _436 = ((_372 - (_372 * _371)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _443 = (mix(float3(0.07999999821186065673828125 * _370), _372, float3(_371)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _446 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _451;
    if (_446)
    {
        _451 = _436 + (_443 * 0.449999988079071044921875);
    }
    else
    {
        _451 = _436;
    }
    float3 _453 = select(_443, float3(0.0), bool3(_446));
    float3 _455 = float3(dot(_453, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _472 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _409, level(0.0));
    float _488 = _472.x;
    float4 _490 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _491 = _472.y;
    float4 _493 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _491) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _494 = _472.z;
    float4 _496 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _494) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _513 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _515 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _491) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _494) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _550 = _175;
    _550.y = (-0.48860299587249755859375) * _373.y;
    float4 _553 = _550;
    _553.z = 0.48860299587249755859375 * _373.z;
    float4 _556 = _553;
    _556.w = (-0.48860299587249755859375) * _373.x;
    float3 _557 = _373 * _373;
    float4 _560 = _172;
    _560.x = (1.09254801273345947265625 * _373.x) * _373.y;
    float4 _563 = _560;
    _563.y = ((-1.09254801273345947265625) * _373.y) * _373.z;
    float4 _568 = _563;
    _568.z = 0.3153919875621795654296875 * ((3.0 * _557.z) - 1.0);
    float4 _571 = _568;
    _571.w = ((-1.09254801273345947265625) * _373.x) * _373.z;
    float4 _575 = _556;
    _575.x = 0.886227548122406005859375;
    float3 _577 = _575.yzw * 2.094395160675048828125;
    float4 _578 = float4(_575.x, _577.x, _577.y, _577.z);
    float4 _579 = _571 * 0.785398185253143310546875;
    float _580 = (_557.x - _557.y) * 0.4290426075458526611328125;
    float3 _586 = float3(0.0);
    _586.x = (dot(float4(_488, _490.xyz), _578) + dot(float4(_490.w, _513.xyz), _579)) + (_513.w * _580);
    float3 _592 = _586;
    _592.y = (dot(float4(_491, _493.xyz), _578) + dot(float4(_493.w, _515.xyz), _579)) + (_515.w * _580);
    float3 _598 = _592;
    _598.z = (dot(float4(_494, _496.xyz), _578) + dot(float4(_496.w, _517.xyz), _579)) + (_517.w * _580);
    float3 _603 = (fast::max(float3(0.0), _598) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _625 = fast::max(mix(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(sin(View.View_GameTime * 1.57079637050628662109375))) * _294, Material.Material_VectorExpressions[5].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _654;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _653;
        if (any(abs(_241 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 19u)].xyz + float3(1.0))))
        {
            _653 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _653 = _625;
        }
        _654 = _653;
    }
    else
    {
        _654 = _625;
    }
    float4 _661 = float4(((mix(float3(0.0), _451 + (_453 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_603 * _451) * fast::max(float3(1.0), ((((((_372 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_372 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_372 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _654) * 1.0, 0.0);
    float4 _668;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _667 = _661;
        _667.w = 0.0;
        _668 = _667;
    }
    else
    {
        _668 = _661;
    }
    float2 _672 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _680 = (_373 * 0.5) + float3(0.5);
    float4 _682 = float4(_680.x, _680.y, _680.z, float4(0.0).w);
    _682.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].y;
    float4 _683 = float4(0.0);
    _683.x = _371;
    float4 _684 = _683;
    _684.y = _370;
    float4 _685 = _684;
    _685.z = _369;
    float4 _686 = _685;
    _686.w = 0.50588238239288330078125;
    float4 _698 = float4(_372.x, _372.y, _372.z, float4(0.0).w);
    _698.w = ((log2(((dot(_603, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_455 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_455 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_455 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_672.xyx * _672.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _668 * View.View_PreExposure;
    out.out_var_SV_Target1 = _682;
    out.out_var_SV_Target2 = _686;
    out.out_var_SV_Target3 = _698;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_422, 1.0, 1.0, 1.0);
    return out;
}

