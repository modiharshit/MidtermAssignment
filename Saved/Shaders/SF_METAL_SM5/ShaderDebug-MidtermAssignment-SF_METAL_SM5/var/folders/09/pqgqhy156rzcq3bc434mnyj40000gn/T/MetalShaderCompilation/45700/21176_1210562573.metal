

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
    spvUnsafeArray<float4, 6> Material_VectorExpressions;
    spvUnsafeArray<float4, 4> Material_ScalarExpressions;
};

constant float _181 = {};
constant float4x4 _182 = {};
constant float4 _183 = {};
constant float _185 = {};
constant float4 _186 = {};
constant float3 _187 = {};

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
    float4 in_var_TEXCOORD0_0 [[user(locn3)]];
    uint in_var_PRIMITIVE_ID [[user(locn4)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

fragment MainPS_out Main_000052b8_4827b80d(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_PrimitiveDither& PrimitiveDither [[buffer(2)]], constant type_Material& Material [[buffer(3)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_3 [[texture(14)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_3Sampler [[sampler(4)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float3x3 _238 = float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz);
    float4 _250 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), _185, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _255 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _260 = (_255.xyz / float3(_255.w)) - View.View_PreViewTranslation;
    uint _261 = in.in_var_PRIMITIVE_ID * 36u;
    float4x4 _264 = _182;
    _264[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261)];
    float4x4 _268 = _264;
    _268[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 1u)];
    float4x4 _272 = _268;
    _272[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 2u)];
    float4x4 _276 = _272;
    _276[3] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 3u)];
    float3 _279 = (_276 * float4(0.0, 0.0, 0.0, 1.0)).xyz - View.View_WorldCameraOrigin;
    float4 _291 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float3 _294 = (float3(-0.5) + _291.xyz) * 2.0;
    float3 _310 = ((((_279 / float3(sqrt(dot(_279, _279)))) * _238) * (-1.0)) * _294.z) + (float3(_294.xy, 0.0) * ((float3x3(View.View_ViewToTranslatedWorld[0].xyz, View.View_ViewToTranslatedWorld[1].xyz, View.View_ViewToTranslatedWorld[2].xyz) * float3(1.0, 1.0, 0.0)) * _238));
    float3 _322 = normalize(_238 * normalize(((_310 / float3(sqrt(dot(_310, _310)))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _333 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    float4 _340 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), bias(View.View_MaterialTextureMipBias));
    if (PrimitiveDither.PrimitiveDither_LODFactor != 0.0)
    {
        if (abs(PrimitiveDither.PrimitiveDither_LODFactor) > 0.001000000047497451305389404296875)
        {
            float _360 = fract(cos(dot(floor(gl_FragCoord.xy), float2(347.834503173828125, 3343.28369140625))) * 1000.0);
            if ((float((PrimitiveDither.PrimitiveDither_LODFactor < 0.0) ? ((PrimitiveDither.PrimitiveDither_LODFactor + 1.0) > _360) : (PrimitiveDither.PrimitiveDither_LODFactor < _360)) - 0.001000000047497451305389404296875) < 0.0)
            {
                discard_fragment();
            }
        }
    }
    if (((_333.w * in_var_TEXCOORD0[0].z) - 0.100000001490116119384765625) < 0.0)
    {
        discard_fragment();
    }
    float3 _375 = fast::clamp(_333.xyz, float3(0.0), float3(1.0));
    float _380 = (fast::clamp(_291.w, 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    float3 _390 = (fast::clamp(float4(_340.xyz, _181).xyz, float3(0.0), float3(1.0)).xyz * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    uint _391 = _261 + 20u;
    float3 _440;
    float _441;
    float _442;
    float _443;
    float3 _444;
    float3 _445;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _391)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _409 = ((_250.xy / float2(_250.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _413 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _409, level(0.0));
        float4 _416 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _409, level(0.0));
        float4 _419 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _409, level(0.0));
        float _421 = _413.w;
        float _429 = _419.w;
        _440 = _390 * _421;
        _441 = (_380 * _429) + _419.z;
        _442 = (0.5 * _429) + _419.y;
        _443 = _419.x;
        _444 = (_375 * _421) + _413.xyz;
        _445 = normalize((_322 * _416.w) + ((_416.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _440 = _390;
        _441 = _380;
        _442 = 0.5;
        _443 = 0.0;
        _444 = _375;
        _445 = _322;
    }
    float3 _455 = fast::clamp((_260 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _466 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_455.x), int(_455.y), int(_455.z), 0).xyz), 0));
    float3 _481 = (((_466.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_455 / float3(_466.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _494;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _391)].z > 0.0)
    {
        _494 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _481, level(0.0)).x;
    }
    else
    {
        _494 = 1.0;
    }
    float3 _497 = sqrt(fast::clamp(_440, float3(0.0), float3(1.0)));
    float4 _499 = float4(_497.x, _497.y, _497.z, float4(0.0).w);
    _499.w = 1.0;
    float3 _504 = dfdx(in.in_var_TEXCOORD15.xyz);
    float3 _505 = dfdy(in.in_var_TEXCOORD15.xyz);
    float3 _523 = ((_444 - (_444 * _443)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _530 = (mix(float3(0.07999999821186065673828125 * _442), _444, float3(_443)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _533 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _538;
    if (_533)
    {
        _538 = _523 + (_530 * 0.449999988079071044921875);
    }
    else
    {
        _538 = _523;
    }
    float3 _540 = select(_530, float3(0.0), bool3(_533));
    float3 _542 = float3(dot(_540, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _559 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _481, level(0.0));
    float _575 = _559.x;
    float4 _577 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _575) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _578 = _559.y;
    float4 _580 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _578) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _581 = _559.z;
    float4 _583 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _581) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _600 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _575) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _602 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _578) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _604 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _481, level(0.0)) * 2.0) - float4(1.0)) * _581) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _608 = float4(_575, _577.xyz);
    float4 _613 = float4(_577.w, _600.xyz);
    float _614 = _600.w;
    float4 _618 = float4(_578, _580.xyz);
    float4 _623 = float4(_580.w, _602.xyz);
    float _624 = _602.w;
    float4 _628 = float4(_581, _583.xyz);
    float4 _633 = float4(_583.w, _604.xyz);
    float _634 = _604.w;
    float4 _637 = _186;
    _637.y = (-0.48860299587249755859375) * _445.y;
    float4 _640 = _637;
    _640.z = 0.48860299587249755859375 * _445.z;
    float4 _643 = _640;
    _643.w = (-0.48860299587249755859375) * _445.x;
    float3 _644 = _445 * _445;
    float4 _647 = _183;
    _647.x = (1.09254801273345947265625 * _445.x) * _445.y;
    float4 _650 = _647;
    _650.y = ((-1.09254801273345947265625) * _445.y) * _445.z;
    float4 _655 = _650;
    _655.z = 0.3153919875621795654296875 * ((3.0 * _644.z) - 1.0);
    float4 _658 = _655;
    _658.w = ((-1.09254801273345947265625) * _445.x) * _445.z;
    float4 _662 = _643;
    _662.x = 0.886227548122406005859375;
    float3 _664 = _662.yzw * 2.094395160675048828125;
    float4 _665 = float4(_662.x, _664.x, _664.y, _664.z);
    float4 _666 = _658 * 0.785398185253143310546875;
    float _667 = (_644.x - _644.y) * 0.4290426075458526611328125;
    float3 _673 = float3(0.0);
    _673.x = (dot(_608, _665) + dot(_613, _666)) + (_614 * _667);
    float3 _679 = _673;
    _679.y = (dot(_618, _665) + dot(_623, _666)) + (_624 * _667);
    float3 _685 = _679;
    _685.z = (dot(_628, _665) + dot(_633, _666)) + (_634 * _667);
    float3 _688 = -_445;
    float _689 = _688.y;
    float4 _691 = _186;
    _691.y = (-0.48860299587249755859375) * _689;
    float _692 = _688.z;
    float4 _694 = _691;
    _694.z = 0.48860299587249755859375 * _692;
    float _695 = _688.x;
    float4 _697 = _694;
    _697.w = (-0.48860299587249755859375) * _695;
    float3 _698 = _688 * _688;
    float4 _701 = _183;
    _701.x = (1.09254801273345947265625 * _695) * _689;
    float4 _704 = _701;
    _704.y = ((-1.09254801273345947265625) * _689) * _692;
    float4 _709 = _704;
    _709.z = 0.3153919875621795654296875 * ((3.0 * _698.z) - 1.0);
    float4 _712 = _709;
    _712.w = ((-1.09254801273345947265625) * _695) * _692;
    float4 _716 = _697;
    _716.x = 0.886227548122406005859375;
    float3 _718 = _716.yzw * 2.094395160675048828125;
    float4 _719 = float4(_716.x, _718.x, _718.y, _718.z);
    float4 _720 = _712 * 0.785398185253143310546875;
    float _721 = (_698.x - _698.y) * 0.4290426075458526611328125;
    float3 _727 = _187;
    _727.x = (dot(_608, _719) + dot(_613, _720)) + (_614 * _721);
    float3 _733 = _727;
    _733.y = (dot(_618, _719) + dot(_623, _720)) + (_624 * _721);
    float3 _739 = _733;
    _739.z = (dot(_628, _719) + dot(_633, _720)) + (_634 * _721);
    float3 _744 = (fast::max(float3(0.0), _685) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _769 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _798;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _797;
        if (any(abs(_260 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _261 + 19u)].xyz + float3(1.0))))
        {
            _797 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_260, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _797 = _769;
        }
        _798 = _797;
    }
    else
    {
        _798 = _769;
    }
    float4 _805 = float4(((mix(float3(0.0), _538 + (_540 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + (((_744 * _538) + (((fast::max(float3(0.0), _739) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale) * _440)) * fast::max(float3(1.0), ((((((_444 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_444 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_444 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _798) * 1.0, 0.0);
    float4 _812;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _811 = _805;
        _811.w = 0.0;
        _812 = _811;
    }
    else
    {
        _812 = _805;
    }
    float2 _816 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _824 = (_445 * 0.5) + float3(0.5);
    float4 _826 = float4(_824.x, _824.y, _824.z, float4(0.0).w);
    _826.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _391)].y;
    float4 _827 = float4(0.0);
    _827.x = _443;
    float4 _828 = _827;
    _828.y = _442;
    float4 _829 = _828;
    _829.z = fast::max(_441, fast::clamp((pow(fast::max(dot(_504, _504), dot(_505, _505)), View.View_NormalCurvatureToRoughnessScaleBias[2]) * View.View_NormalCurvatureToRoughnessScaleBias[0]) + View.View_NormalCurvatureToRoughnessScaleBias[1], 0.0, 1.0));
    float4 _830 = _829;
    _830.w = 0.525490224361419677734375;
    float4 _842 = float4(_444.x, _444.y, _444.z, float4(0.0).w);
    _842.w = ((log2(((dot(_744, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_542 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_542 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_542 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_816.xyx * _816.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _812 * View.View_PreExposure;
    out.out_var_SV_Target1 = _826;
    out.out_var_SV_Target2 = _830;
    out.out_var_SV_Target3 = _842;
    out.out_var_SV_Target4 = _499;
    out.out_var_SV_Target5 = float4(_494, 1.0, 1.0, 1.0);
    return out;
}

