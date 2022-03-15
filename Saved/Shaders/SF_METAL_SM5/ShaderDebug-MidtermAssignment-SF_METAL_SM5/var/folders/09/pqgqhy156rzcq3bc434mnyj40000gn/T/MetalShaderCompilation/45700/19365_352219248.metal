

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
    char _m12_pad[20];
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
    float View_IndirectLightingCacheShowFlag;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_PrimitiveDither
{
    float PrimitiveDither_LODFactor;
};

struct type_IndirectLightingCache
{
    char _m0_pad[80];
    float IndirectLightingCache_DirectionalLightShadowing;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients0;
    spvUnsafeArray<float4, 3> IndirectLightingCache_IndirectLightingSHCoefficients1;
    float4 IndirectLightingCache_IndirectLightingSHCoefficients2;
};

struct type_Material
{
    spvUnsafeArray<float4, 7> Material_VectorExpressions;
    spvUnsafeArray<float4, 6> Material_ScalarExpressions;
};

constant float _171 = {};
constant float4 _172 = {};
constant float _174 = {};
constant float4 _175 = {};
constant float3 _176 = {};

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

fragment MainPS_out Main_00004ba5_14fe7070(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_IndirectLightingCache& IndirectLightingCache [[buffer(3)]], constant type_Material& Material [[buffer(4)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(1)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(2)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(3)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(4)]], texture2d<float> Material_Texture2D_0 [[texture(5)]], texture2d<float> Material_Texture2D_1 [[texture(6)]], texture2d<float> Material_Texture2D_3 [[texture(7)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]], bool gl_FrontFacing [[front_facing]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _234 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _174, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _239 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _244 = (_239.xyz / float3(_239.w)) - View.View_PreViewTranslation;
    uint _245 = in.in_var_PRIMITIVE_ID * 36u;
    float4 _259 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _270 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((((float3(-0.5) + _259.xyz) * 2.0) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * ((View.View_CullingSign * View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 4u)].w) * float(gl_FrontFacing ? 1 : (-1)));
    float4 _281 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _308 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _308) : (PrimitiveDither.PrimitiveDither_LODFactor < _308)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((in.in_var_COLOR0.w * _281.w) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _323 = fast::clamp(_281.xyz, float3(0.0), float3(1.0));
    float _328 = (fast::clamp(_259.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _338 = (fast::clamp(float4(_288.xyz, _171).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _339 = _245 + 20u;
    float3 _388;
    float _389;
    float _390;
    float _391;
    float3 _392;
    float3 _393;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _357 = ((_234.xy / float2(_234.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _361 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _364 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float4 _367 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _357, level(0.0));
        float _369 = _361.w;
        float _377 = _367.w;
        _388 = _338 * _369;
        _389 = (_328 * _377) + _367.z;
        _390 = (0.5 * _377) + _367.y;
        _391 = _367.x;
        _392 = (_323 * _369) + _361.xyz;
        _393 = normalize((_270 * _364.w) + ((_364.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _388 = _338;
        _389 = _328;
        _390 = 0.5;
        _391 = 0.0;
        _392 = _323;
        _393 = _270;
    }
    bool _403 = View.View_IndirectLightingCacheShowFlag > 0.0;
    float _409;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 18u)].w > 0.0) && _403)
    {
        _409 = IndirectLightingCache.IndirectLightingCache_DirectionalLightShadowing;
    }
    else
    {
        _409 = 1.0;
    }
    float _456;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].z > 0.0)
    {
        float3 _424 = fast::clamp((_244 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
        float4 _435 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_424.x), int(_424.y), int(_424.z), 0).xyz), 0));
        _456 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, ((((_435.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_424 / float3(_435.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize), level(0.0)).x;
    }
    else
    {
        _456 = _409;
    }
    float3 _459 = sqrt(fast::clamp(_388, float3(0.0), float3(1.0)));
    float4 _461 = float4(_459.x, _459.y, _459.z, float4(0.0).w);
    _461.w = 1.0;
    float3 _469 = ((_392 - (_392 * _391)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _476 = (mix(float3(0.07999999821186065673828125 * _390), _392, float3(_391)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _479 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _484;
    if (_479)
    {
        _484 = _469 + (_476 * 0.449999988079071044921875);
    }
    else
    {
        _484 = _469;
    }
    float3 _486 = select(_476, float3(0.0), bool3(_479));
    float3 _488 = float3(dot(_486, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float3 _627;
    float3 _628;
    if (_403)
    {
        float4 _524 = _175;
        _524.y = (-0.48860299587249755859375) * _393.y;
        float4 _527 = _524;
        _527.z = 0.48860299587249755859375 * _393.z;
        float4 _530 = _527;
        _530.w = (-0.48860299587249755859375) * _393.x;
        float3 _531 = _393 * _393;
        float4 _534 = _172;
        _534.x = (1.09254801273345947265625 * _393.x) * _393.y;
        float4 _537 = _534;
        _537.y = ((-1.09254801273345947265625) * _393.y) * _393.z;
        float4 _542 = _537;
        _542.z = 0.3153919875621795654296875 * ((3.0 * _531.z) - 1.0);
        float4 _545 = _542;
        _545.w = ((-1.09254801273345947265625) * _393.x) * _393.z;
        float4 _549 = _530;
        _549.x = 0.886227548122406005859375;
        float3 _551 = _549.yzw * 2.094395160675048828125;
        float4 _552 = float4(_549.x, _551.x, _551.y, _551.z);
        float4 _553 = _545 * 0.785398185253143310546875;
        float _554 = (_531.x - _531.y) * 0.4290426075458526611328125;
        float3 _560 = float3(0.0);
        _560.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _552) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _553)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _554);
        float3 _566 = _560;
        _566.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _552) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _553)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _554);
        float3 _572 = _566;
        _572.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _552) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _553)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _554);
        float3 _574 = -_393;
        float _575 = _574.y;
        float4 _577 = _175;
        _577.y = (-0.48860299587249755859375) * _575;
        float _578 = _574.z;
        float4 _580 = _577;
        _580.z = 0.48860299587249755859375 * _578;
        float _581 = _574.x;
        float4 _583 = _580;
        _583.w = (-0.48860299587249755859375) * _581;
        float3 _584 = _574 * _574;
        float4 _587 = _172;
        _587.x = (1.09254801273345947265625 * _581) * _575;
        float4 _590 = _587;
        _590.y = ((-1.09254801273345947265625) * _575) * _578;
        float4 _595 = _590;
        _595.z = 0.3153919875621795654296875 * ((3.0 * _584.z) - 1.0);
        float4 _598 = _595;
        _598.w = ((-1.09254801273345947265625) * _581) * _578;
        float4 _602 = _583;
        _602.x = 0.886227548122406005859375;
        float3 _604 = _602.yzw * 2.094395160675048828125;
        float4 _605 = float4(_602.x, _604.x, _604.y, _604.z);
        float4 _606 = _598 * 0.785398185253143310546875;
        float _607 = (_584.x - _584.y) * 0.4290426075458526611328125;
        float3 _613 = _176;
        _613.x = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[0], _605) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[0], _606)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.x * _607);
        float3 _619 = _613;
        _619.y = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[1], _605) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[1], _606)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.y * _607);
        float3 _625 = _619;
        _625.z = (dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients0[2], _605) + dot(IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients1[2], _606)) + (IndirectLightingCache.IndirectLightingCache_IndirectLightingSHCoefficients2.z * _607);
        _627 = fast::max(float3(0.0), _625);
        _628 = fast::max(float3(0.0), _572);
    }
    else
    {
        _627 = float3(0.0);
        _628 = float3(0.0);
    }
    float3 _631 = _628 * View.View_IndirectLightingColorScale;
    float3 _656 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _685;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _684;
        if (any(abs(_244 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _245 + 19u)].xyz + float3(1.0))))
        {
            _684 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_244, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _684 = _656;
        }
        _685 = _684;
    }
    else
    {
        _685 = _656;
    }
    float4 _692 = float4(((mix(float3(0.0), _484 + (_486 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_631 * _484) + ((_627 * View.View_IndirectLightingColorScale) * _388)) * fast::max(float3(1.0), ((((((_392 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_392 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_392 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _685) * 1.0, 0.0);
    float4 _699;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _698 = _692;
        _698.w = 0.0;
        _699 = _698;
    }
    else
    {
        _699 = _692;
    }
    float2 _703 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _711 = (_393 * 0.5) + float3(0.5);
    float4 _713 = float4(_711.x, _711.y, _711.z, float4(0.0).w);
    _713.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _339)].y;
    float4 _714 = float4(0.0);
    _714.x = _391;
    float4 _715 = _714;
    _715.y = _390;
    float4 _716 = _715;
    _716.z = _389;
    float4 _717 = _716;
    _717.w = 0.525490224361419677734375;
    float4 _729 = float4(_392.x, _392.y, _392.z, float4(0.0).w);
    _729.w = ((log2(((dot(_631, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_488 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_488 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_488 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_703.xyx * _703.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _699 * View.View_PreExposure;
    out.out_var_SV_Target1 = _713;
    out.out_var_SV_Target2 = _717;
    out.out_var_SV_Target3 = _729;
    out.out_var_SV_Target4 = _461;
    out.out_var_SV_Target5 = float4(_456, 1.0, 1.0, 1.0);
    return out;
}

