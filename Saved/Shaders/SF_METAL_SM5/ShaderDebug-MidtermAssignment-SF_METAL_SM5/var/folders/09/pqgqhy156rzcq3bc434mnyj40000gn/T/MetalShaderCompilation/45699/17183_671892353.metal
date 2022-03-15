

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
    char _m11_pad[80];
    float View_UnlitViewmodeMask;
    char _m12_pad[176];
    float3 View_IndirectLightingColorScale;
    char _m13_pad[412];
    float View_RenderingReflectionCaptureMask;
    char _m14_pad[188];
    float View_ShowDecalsMask;
    char _m15_pad[184];
    float View_bCheckerboardSubsurfaceProfileRendering;
    char _m16_pad[48];
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
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 2> Material_ScalarExpressions;
};

constant float4 _171 = {};
constant float _173 = {};
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
    float4 in_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 in_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 in_var_TEXCOORD0_0 [[user(locn2)]];
    uint in_var_PRIMITIVE_ID [[user(locn3)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_0000431f_280c4381(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], sampler View_MaterialTextureBilinearClampedSampler [[sampler(0)]], sampler View_SharedBilinearClampedSampler [[sampler(1)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(2)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _229 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _173, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _234 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _239 = (_234.xyz / float3(_234.w)) - View.View_PreViewTranslation;
    float4 _243 = Material_Texture2D_0.sample(View_MaterialTextureBilinearClampedSampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y));
    float2 _246 = (_243.xy * float2(2.0)) - float2(1.0);
    float3 _262 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((float4(_246, sqrt(fast::clamp(1.0 - dot(_246, _246), 0.0, 1.0)), 1.0).xyz * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _297 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _297) : (PrimitiveDither.PrimitiveDither_LODFactor < _297)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    float3 _308 = fast::clamp(Material.Material_VectorExpressions[6].xyz, float3(0.0), float3(1.0));
    float _309 = fast::clamp(Material.Material_ScalarExpressions[0].z, 0.0, 1.0);
    float _310 = fast::clamp(Material.Material_ScalarExpressions[0].w, 0.0, 1.0);
    float _311 = fast::clamp(Material.Material_ScalarExpressions[1].y, 0.0, 1.0);
    float _316 = (fast::clamp(Material.Material_ScalarExpressions[1].x, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _317 = in.in_var_PRIMITIVE_ID * 36u;
    uint _318 = _317 + 20u;
    float _368;
    float _369;
    float _370;
    float3 _371;
    float3 _372;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _336 = ((_229.xy / float2(_229.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _340 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _343 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float4 _346 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _336, level(0.0));
        float _356 = _346.w;
        _368 = (_316 * _356) + _346.z;
        _369 = (_310 * _356) + _346.y;
        _370 = (_309 * _356) + _346.x;
        _371 = (_308 * _340.w) + _340.xyz;
        _372 = normalize((_262 * _343.w) + ((_343.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _368 = _316;
        _369 = _310;
        _370 = _309;
        _371 = _308;
        _372 = _262;
    }
    float3 _382 = fast::clamp((_239 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _393 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_382.x), int(_382.y), int(_382.z), 0).xyz), 0));
    float3 _408 = (((_393.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_382 / float3(_393.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _421;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].z > 0.0)
    {
        _421 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _408, level(0.0)).x;
    }
    else
    {
        _421 = 1.0;
    }
    float3 _435 = ((_371 - (_371 * _370)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _442 = (mix(float3(0.07999999821186065673828125 * _369), _371, float3(_370)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _445 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _450;
    if (_445)
    {
        _450 = _435 + (_442 * 0.449999988079071044921875);
    }
    else
    {
        _450 = _435;
    }
    float3 _452 = select(_442, float3(0.0), bool3(_445));
    float3 _454 = float3(dot(_452, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _461 = float3(_311);
    float4 _472 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _408, level(0.0));
    float _488 = _472.x;
    float4 _490 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _491 = _472.y;
    float4 _493 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _491) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _494 = _472.z;
    float4 _496 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _494) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _513 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _488) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _515 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _491) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _517 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _408, level(0.0)) * 2.0) - float4(1.0)) * _494) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _550 = _174;
    _550.y = (-0.48860299587249755859375) * _372.y;
    float4 _553 = _550;
    _553.z = 0.48860299587249755859375 * _372.z;
    float4 _556 = _553;
    _556.w = (-0.48860299587249755859375) * _372.x;
    float3 _557 = _372 * _372;
    float4 _560 = _171;
    _560.x = (1.09254801273345947265625 * _372.x) * _372.y;
    float4 _563 = _560;
    _563.y = ((-1.09254801273345947265625) * _372.y) * _372.z;
    float4 _568 = _563;
    _568.z = 0.3153919875621795654296875 * ((3.0 * _557.z) - 1.0);
    float4 _571 = _568;
    _571.w = ((-1.09254801273345947265625) * _372.x) * _372.z;
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
    float3 _625 = fast::max(mix(Material.Material_VectorExpressions[3].xyz, Material.Material_VectorExpressions[4].xyz, float3(Material.Material_ScalarExpressions[0].y)), float3(0.0));
    float3 _654;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _653;
        if (any(abs(_239 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _317 + 19u)].xyz + float3(1.0))))
        {
            _653 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_239, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
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
    float4 _661 = float4(((mix(float3(0.0), _450 + (_452 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_603 * _450) * fast::max(_461, ((((((_371 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_371 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_371 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311))) + _654) * 1.0, 0.0);
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
    float3 _680 = (_372 * 0.5) + float3(0.5);
    float4 _682 = float4(_680.x, _680.y, _680.z, float4(0.0).w);
    _682.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _318)].y;
    float4 _683 = float4(0.0);
    _683.x = _370;
    float4 _684 = _683;
    _684.y = _369;
    float4 _685 = _684;
    _685.z = _368;
    float4 _686 = _685;
    _686.w = 0.50588238239288330078125;
    float4 _698 = float4(_371.x, _371.y, _371.z, float4(0.0).w);
    _698.w = ((log2(((dot(_603, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(_461, ((((((_454 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * _311) + ((_454 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * _311) + ((_454 * 2.755199909210205078125) + float3(0.69029998779296875))) * _311).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_672.xyx * _672.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _668 * View.View_PreExposure;
    out.out_var_SV_Target1 = _682;
    out.out_var_SV_Target2 = _686;
    out.out_var_SV_Target3 = _698;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_421, 1.0, 1.0, 1.0);
    return out;
}

