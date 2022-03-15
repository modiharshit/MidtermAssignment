

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
    char _m11_pad[48];
    float View_MaterialTextureMipBias;
    char _m12_pad[28];
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

fragment MainPS_out Main_000045ce_984e80d1(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _231 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _236 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _241 = (_236.xyz / float3(_236.w)) - View.View_PreViewTranslation;
    float2 _242 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.5;
    float4 _248 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float2 _251 = (_248.xy * float2(2.0)) - float2(1.0);
    float3 _267 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_251, sqrt(fast::clamp(1.0 - dot(_251, _251), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _279 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.21340000629425048828125), bias(View.View_MaterialTextureMipBias));
    float4 _284 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.053410001099109649658203125), bias(View.View_MaterialTextureMipBias));
    float4 _289 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.00200000009499490261077880859375), bias(View.View_MaterialTextureMipBias));
    float _293 = (_279.x + 0.5) * ((_284.x + 0.5) * (_289.x + 0.5));
    float4 _298 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float4 _304 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _242, bias(View.View_MaterialTextureMipBias));
    float _305 = _304.w;
    float3 _312 = fast::clamp(_298.xyz * mix(0.800000011920928955078125, 1.2000000476837158203125, _293), float3(0.0), float3(1.0));
    float _313 = fast::clamp(fast::min(fast::max(_305, 0.0), 1.0) * 2.0, 0.0, 1.0);
    float _314 = fast::clamp(_305, 0.0, 1.0);
    float _319 = (fast::clamp(mix(0.20000000298023223876953125, mix(0.60000002384185791015625, 1.0, _293), _304.x), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
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
        _370 = (_313 * _359) + _349.y;
        _371 = _349.x;
        _372 = (_312 * _343.w) + _343.xyz;
        _373 = normalize((_267 * _346.w) + ((_346.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _369 = _319;
        _370 = _313;
        _371 = 0.0;
        _372 = _312;
        _373 = _267;
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
    float3 _462 = float3(_314);
    float4 _473 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _409, level(0.0));
    float _489 = _473.x;
    float4 _491 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _492 = _473.y;
    float4 _494 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _495 = _473.z;
    float4 _497 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _514 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _489) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _516 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _492) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _518 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _409, level(0.0)) * 2.0) - float4(1.0)) * _495) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _551 = _175;
    _551.y = (-0.48860299587249755859375) * _373.y;
    float4 _554 = _551;
    _554.z = 0.48860299587249755859375 * _373.z;
    float4 _557 = _554;
    _557.w = (-0.48860299587249755859375) * _373.x;
    float3 _558 = _373 * _373;
    float4 _561 = _172;
    _561.x = (1.09254801273345947265625 * _373.x) * _373.y;
    float4 _564 = _561;
    _564.y = ((-1.09254801273345947265625) * _373.y) * _373.z;
    float4 _569 = _564;
    _569.z = 0.3153919875621795654296875 * ((3.0 * _558.z) - 1.0);
    float4 _572 = _569;
    _572.w = ((-1.09254801273345947265625) * _373.x) * _373.z;
    float4 _576 = _557;
    _576.x = 0.886227548122406005859375;
    float3 _578 = _576.yzw * 2.094395160675048828125;
    float4 _579 = float4(_576.x, _578.x, _578.y, _578.z);
    float4 _580 = _572 * 0.785398185253143310546875;
    float _581 = (_558.x - _558.y) * 0.4290426075458526611328125;
    float3 _587 = float3(0.0);
    _587.x = (dot(float4(_489, _491.xyz), _579) + dot(float4(_491.w, _514.xyz), _580)) + (_514.w * _581);
    float3 _593 = _587;
    _593.y = (dot(float4(_492, _494.xyz), _579) + dot(float4(_494.w, _516.xyz), _580)) + (_516.w * _581);
    float3 _599 = _593;
    _599.z = (dot(float4(_495, _497.xyz), _579) + dot(float4(_497.w, _518.xyz), _580)) + (_518.w * _581);
    float3 _604 = (fast::max(float3(0.0), _599) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _626 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _655;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _654;
        if (any(abs(_241 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _320 + 19u)].xyz + float3(1.0))))
        {
            _654 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_241, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _654 = _626;
        }
        _655 = _654;
    }
    else
    {
        _655 = _626;
    }
    float4 _662 = float4(((mix(float3(0.0), _451 + (_453 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_604 * _451) * fast::max(_462, ((((((_372 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_372 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_372 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314))) + _655) * 1.0, 0.0);
    float4 _669;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _668 = _662;
        _668.w = 0.0;
        _669 = _668;
    }
    else
    {
        _669 = _662;
    }
    float2 _673 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _681 = (_373 * 0.5) + float3(0.5);
    float4 _683 = float4(_681.x, _681.y, _681.z, float4(0.0).w);
    _683.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _321)].y;
    float4 _684 = float4(0.0);
    _684.x = _371;
    float4 _685 = _684;
    _685.y = _370;
    float4 _686 = _685;
    _686.z = _369;
    float4 _687 = _686;
    _687.w = 0.50588238239288330078125;
    float4 _699 = float4(_372.x, _372.y, _372.z, float4(0.0).w);
    _699.w = ((log2(((dot(_604, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_462, ((((((_455 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _314) + ((_455 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _314) + ((_455 * 2.755199909210205078125) + float3(0.69029998779296875))) * _314).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_673.xyx * _673.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _669 * View.View_PreExposure;
    out.out_var_SV_Target1 = _683;
    out.out_var_SV_Target2 = _687;
    out.out_var_SV_Target3 = _699;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_422, 1.0, 1.0, 1.0);
    return out;
}

