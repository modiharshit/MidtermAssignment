

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

constant float4 _180 = {};
constant float4 _182 = {};

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

fragment MainPS_out Main_000049eb_50272f49(MainPS_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(3)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(0)]], constant type_View& View [[buffer(1)]], constant type_Material& Material [[buffer(2)]], texture3d<uint> View_VolumetricLightmapIndirectionTexture [[texture(0)]], texture3d<float> View_VolumetricLightmapBrickAmbientVector [[texture(1)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients0 [[texture(2)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients1 [[texture(3)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients2 [[texture(4)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients3 [[texture(5)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients4 [[texture(6)]], texture3d<float> View_VolumetricLightmapBrickSHCoefficients5 [[texture(7)]], texture3d<float> View_DirectionalLightShadowingBrickTexture [[texture(8)]], texture2d<float> OpaqueBasePass_DBufferATexture [[texture(9)]], texture2d<float> OpaqueBasePass_DBufferBTexture [[texture(10)]], texture2d<float> OpaqueBasePass_DBufferCTexture [[texture(11)]], texture2d<float> Material_Texture2D_0 [[texture(12)]], texture2d<float> Material_Texture2D_1 [[texture(13)]], texture2d<float> Material_Texture2D_2 [[texture(14)]], texture2d<float> Material_Texture2D_3 [[texture(15)]], sampler View_SharedBilinearClampedSampler [[sampler(0)]], sampler OpaqueBasePass_DBufferATextureSampler [[sampler(1)]], sampler Material_Texture2D_0Sampler [[sampler(2)]], sampler Material_Texture2D_1Sampler [[sampler(3)]], sampler Material_Texture2D_2Sampler [[sampler(4)]], sampler Material_Texture2D_3Sampler [[sampler(5)]], float4 gl_FragCoord [[position]])
{
    MainPS_out out = {};
    spvUnsafeArray<float4, 1> in_var_TEXCOORD0 = {};
    in_var_TEXCOORD0[0] = in.in_var_TEXCOORD0_0;
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[0];
    float4 _239 = float4((((gl_FragCoord.xy - View.View_ViewRectMin.xy) * View.View_ViewSizeAndInvSize.zw) - float2(0.5)) * float2(2.0, -2.0), gl_FragCoord.z, 1.0) * (1.0 / gl_FragCoord.w);
    float4 _243 = View.View_SVPositionToTranslatedWorld * float4(gl_FragCoord.xyz, 1.0);
    float3 _248 = (_243.xyz / float3(_243.w)) - View.View_PreViewTranslation;
    float2 _249 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.300000011920928955078125;
    float4 _255 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float2 _258 = (_255.xy * float2(2.0)) - float2(1.0);
    float2 _266 = float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.20000000298023223876953125;
    float4 _268 = Material_Texture2D_0.sample(Material_Texture2D_0Sampler, _266, bias(View.View_MaterialTextureMipBias));
    float2 _271 = (_268.xy * float2(2.0)) - float2(1.0);
    float4 _283 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.008000000379979610443115234375), bias(View.View_MaterialTextureMipBias));
    float4 _288 = Material_Texture2D_1.sample(Material_Texture2D_1Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.004999999888241291046142578125), bias(View.View_MaterialTextureMipBias));
    float _290 = (_283.x + 0.5) * _288.x;
    float _292 = fast::min(fast::max(_290, 0.0), 1.0);
    float3 _295 = float3(_292);
    float4 _301 = Material_Texture2D_2.sample(Material_Texture2D_2Sampler, (float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y) * 0.0500000007450580596923828125), bias(View.View_MaterialTextureMipBias));
    float _328;
    switch (0u)
    {
        default:
        {
            if (View.View_ViewToClip[3u].w < 1.0)
            {
                _328 = _239.w;
                break;
            }
            else
            {
                float _312 = _239.z;
                _328 = ((_312 * View.View_InvDeviceZToWorldZTransform.x) + View.View_InvDeviceZToWorldZTransform.y) + (1.0 / ((_312 * View.View_InvDeviceZToWorldZTransform.z) - View.View_InvDeviceZToWorldZTransform.w));
                break;
            }
        }
    }
    float3 _343 = normalize(float3x3(in.in_var_TEXCOORD10_centroid.xyz, cross(in.in_var_TEXCOORD11_centroid.xyz, in.in_var_TEXCOORD10_centroid.xyz) * in.in_var_TEXCOORD11_centroid.w, in.in_var_TEXCOORD11_centroid.xyz) * normalize((mix(mix(float4(_258, sqrt(fast::clamp(1.0 - dot(_258, _258), 0.0, 1.0)), 1.0).xyz, float4(_271, sqrt(fast::clamp(1.0 - dot(_271, _271), 0.0, 1.0)), 1.0).xyz, _295), float3(0.0, 0.0, 1.0), float3(fast::min(fast::max(((mix(-2000.0, 2000.0, _301.x) + _328) - 1000.0) * 0.0005000000237487256526947021484375, 0.0), 1.0))) * View.View_NormalOverrideParameter.w) + View.View_NormalOverrideParameter.xyz)) * 1.0;
    float4 _355 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _249, bias(View.View_MaterialTextureMipBias));
    float4 _357 = Material_Texture2D_3.sample(Material_Texture2D_3Sampler, _266, bias(View.View_MaterialTextureMipBias));
    float3 _367 = fast::clamp(mix(_355.xyz, _357.xyz, _295) * mix(0.60000002384185791015625, 1.0, _290), float3(0.0), float3(1.0));
    float _372 = (fast::clamp(mix(0.949999988079071044921875, 0.699999988079071044921875, _290 * mix(_355.w, _357.w, _292)), 0.0, 1.0) * View.View_RoughnessOverrideParameter.y) + View.View_RoughnessOverrideParameter.x;
    uint _373 = in.in_var_PRIMITIVE_ID * 36u;
    uint _374 = _373 + 20u;
    float _422;
    float _423;
    float _424;
    float3 _425;
    float3 _426;
    if ((View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374)].x > 0.0) && (View.View_ShowDecalsMask > 0.0))
    {
        float2 _392 = ((_239.xy / float2(_239.w)) * View.View_ScreenPositionScaleBias.xy) + View.View_ScreenPositionScaleBias.wz;
        float4 _396 = OpaqueBasePass_DBufferATexture.sample(OpaqueBasePass_DBufferATextureSampler, _392, level(0.0));
        float4 _399 = OpaqueBasePass_DBufferBTexture.sample(OpaqueBasePass_DBufferATextureSampler, _392, level(0.0));
        float4 _402 = OpaqueBasePass_DBufferCTexture.sample(OpaqueBasePass_DBufferATextureSampler, _392, level(0.0));
        float _412 = _402.w;
        _422 = (_372 * _412) + _402.z;
        _423 = (0.5 * _412) + _402.y;
        _424 = _402.x;
        _425 = (_367 * _396.w) + _396.xyz;
        _426 = normalize((_343 * _399.w) + ((_399.xyz * 2.0) - float3(1.00392162799835205078125)));
    }
    else
    {
        _422 = _372;
        _423 = 0.5;
        _424 = 0.0;
        _425 = _367;
        _426 = _343;
    }
    float3 _436 = fast::clamp((_248 * View.View_VolumetricLightmapWorldToUVScale) + View.View_VolumetricLightmapWorldToUVAdd, float3(0.0), float3(0.9900000095367431640625)) * float3(View.View_VolumetricLightmapIndirectionTextureSize);
    float4 _447 = float4(View_VolumetricLightmapIndirectionTexture.read(uint3(int4(int(_436.x), int(_436.y), int(_436.z), 0).xyz), 0));
    float3 _462 = (((_447.xyz * (View.View_VolumetricLightmapBrickSize + 1.0)) + (fract(_436 / float3(_447.w)) * View.View_VolumetricLightmapBrickSize)) + float3(0.5)) * View.View_VolumetricLightmapBrickTexelSize;
    float _475;
    if (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374)].z > 0.0)
    {
        _475 = View_DirectionalLightShadowingBrickTexture.sample(View_SharedBilinearClampedSampler, _462, level(0.0)).x;
    }
    else
    {
        _475 = 1.0;
    }
    float3 _489 = ((_425 - (_425 * _424)) * View.View_DiffuseOverrideParameter.w) + View.View_DiffuseOverrideParameter.xyz;
    float3 _496 = (mix(float3(0.07999999821186065673828125 * _423), _425, float3(_424)) * View.View_SpecularOverrideParameter.w) + View.View_SpecularOverrideParameter.xyz;
    bool _499 = View.View_RenderingReflectionCaptureMask != 0.0;
    float3 _504;
    if (_499)
    {
        _504 = _489 + (_496 * 0.449999988079071044921875);
    }
    else
    {
        _504 = _489;
    }
    float3 _506 = select(_496, float3(0.0), bool3(_499));
    float3 _508 = float3(dot(_506, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)));
    float4 _525 = View_VolumetricLightmapBrickAmbientVector.sample(View_SharedBilinearClampedSampler, _462, level(0.0));
    float _541 = _525.x;
    float4 _543 = (((View_VolumetricLightmapBrickSHCoefficients0.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _544 = _525.y;
    float4 _546 = (((View_VolumetricLightmapBrickSHCoefficients2.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _544) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float _547 = _525.z;
    float4 _549 = (((View_VolumetricLightmapBrickSHCoefficients4.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _547) * float4(1.732051372528076171875, 1.732051372528076171875, 1.732051372528076171875, 3.87297916412353515625);
    float4 _566 = (((View_VolumetricLightmapBrickSHCoefficients1.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _541) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _568 = (((View_VolumetricLightmapBrickSHCoefficients3.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _544) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _570 = (((View_VolumetricLightmapBrickSHCoefficients5.sample(View_SharedBilinearClampedSampler, _462, level(0.0)) * 2.0) - float4(1.0)) * _547) * float4(3.87297916412353515625, 4.472138881683349609375, 3.87297916412353515625, 3.87297916412353515625);
    float4 _603 = _182;
    _603.y = (-0.48860299587249755859375) * _426.y;
    float4 _606 = _603;
    _606.z = 0.48860299587249755859375 * _426.z;
    float4 _609 = _606;
    _609.w = (-0.48860299587249755859375) * _426.x;
    float3 _610 = _426 * _426;
    float4 _613 = _180;
    _613.x = (1.09254801273345947265625 * _426.x) * _426.y;
    float4 _616 = _613;
    _616.y = ((-1.09254801273345947265625) * _426.y) * _426.z;
    float4 _621 = _616;
    _621.z = 0.3153919875621795654296875 * ((3.0 * _610.z) - 1.0);
    float4 _624 = _621;
    _624.w = ((-1.09254801273345947265625) * _426.x) * _426.z;
    float4 _628 = _609;
    _628.x = 0.886227548122406005859375;
    float3 _630 = _628.yzw * 2.094395160675048828125;
    float4 _631 = float4(_628.x, _630.x, _630.y, _630.z);
    float4 _632 = _624 * 0.785398185253143310546875;
    float _633 = (_610.x - _610.y) * 0.4290426075458526611328125;
    float3 _639 = float3(0.0);
    _639.x = (dot(float4(_541, _543.xyz), _631) + dot(float4(_543.w, _566.xyz), _632)) + (_566.w * _633);
    float3 _645 = _639;
    _645.y = (dot(float4(_544, _546.xyz), _631) + dot(float4(_546.w, _568.xyz), _632)) + (_568.w * _633);
    float3 _651 = _645;
    _651.z = (dot(float4(_547, _549.xyz), _631) + dot(float4(_549.w, _570.xyz), _632)) + (_570.w * _633);
    float3 _656 = (fast::max(float3(0.0), _651) * float3(0.3183098733425140380859375)) * View.View_IndirectLightingColorScale;
    float3 _678 = fast::max(mix(float3(0.0), Material.Material_VectorExpressions[1].xyz, float3(Material.Material_ScalarExpressions[0].x)), float3(0.0));
    float3 _707;
    if (View.View_OutOfBoundsMask > 0.0)
    {
        float3 _706;
        if (any(abs(_248 - View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _373 + 5u)].xyz) > (View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _373 + 19u)].xyz + float3(1.0))))
        {
            _706 = mix(float3(1.0, 1.0, 0.0), float3(0.0, 1.0, 1.0), select(float3(0.0), float3(1.0), float3(fract(dot(_248, float3(0.57700002193450927734375)) * 0.00200000009499490261077880859375)) > float3(0.5)));
        }
        else
        {
            _706 = _678;
        }
        _707 = _706;
    }
    else
    {
        _707 = _678;
    }
    float4 _714 = float4(((mix(float3(0.0), _504 + (_506 * 0.449999988079071044921875), float3(View.View_UnlitViewmodeMask)) + ((_656 * _504) * fast::max(float3(1.0), ((((((_425 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_425 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_425 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0))) + _707) * 1.0, 0.0);
    float4 _721;
    if (View.View_bCheckerboardSubsurfaceProfileRendering == 0.0)
    {
        float4 _720 = _714;
        _720.w = 0.0;
        _721 = _720;
    }
    else
    {
        _721 = _714;
    }
    float2 _725 = (fract(gl_FragCoord.xy * float2(0.0078125)) * 128.0) + float2(-64.3406219482421875, -72.4656219482421875);
    float3 _733 = (_426 * 0.5) + float3(0.5);
    float4 _735 = float4(_733.x, _733.y, _733.z, float4(0.0).w);
    _735.w = View_PrimitiveSceneData._m0[spvStorageBufferCoords(0, spvBufferSizeConstants, float4, _374)].y;
    float4 _736 = float4(0.0);
    _736.x = _424;
    float4 _737 = _736;
    _737.y = _423;
    float4 _738 = _737;
    _738.z = _422;
    float4 _739 = _738;
    _739.w = 0.50588238239288330078125;
    float4 _751 = float4(_425.x, _425.y, _425.z, float4(0.0).w);
    _751.w = ((log2(((dot(_656, float3(0.300000011920928955078125, 0.589999973773956298828125, 0.10999999940395355224609375)) * fast::max(float3(1.0), ((((((_508 * 2.040400028228759765625) - float3(0.3323999941349029541015625)) * 1.0) + ((_508 * (-4.79510021209716796875)) + float3(0.6417000293731689453125))) * 1.0) + ((_508 * 2.755199909210205078125) + float3(0.69029998779296875))) * 1.0).y) * View.View_PreExposure) + 0.00390625) * 0.0625) + 0.5) + ((fract(dot(_725.xyx * _725.xyy, float3(20.390625, 60.703125, 2.4281208515167236328125))) - 0.5) * 0.0039215688593685626983642578125);
    out.out_var_SV_Target0 = _721 * View.View_PreExposure;
    out.out_var_SV_Target1 = _735;
    out.out_var_SV_Target2 = _739;
    out.out_var_SV_Target3 = _751;
    out.out_var_SV_Target4 = float4(0.0);
    out.out_var_SV_Target5 = float4(_475, 1.0, 1.0, 1.0);
    return out;
}

