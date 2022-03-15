

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
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1024];
    float3 View_TranslatedWorldCameraOrigin;
    char _m2_pad[16];
    float3 View_PreViewTranslation;
    char _m3_pad[1032];
    float View_OneOverPreExposure;
    char _m4_pad[352];
    float View_AtmosphericFogSunPower;
    float View_AtmosphericFogPower;
    float View_AtmosphericFogDensityScale;
    float View_AtmosphericFogDensityOffset;
    float View_AtmosphericFogGroundOffset;
    float View_AtmosphericFogDistanceScale;
    float View_AtmosphericFogAltitudeScale;
    float View_AtmosphericFogHeightScaleRayleigh;
    float View_AtmosphericFogStartDistance;
    float View_AtmosphericFogDistanceOffset;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDirection;
    spvUnsafeArray<float4, 2> View_AtmosphereLightColor;
    char _m16_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m18_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m22_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m26_pad[16];
    float View_RealTimeReflectionCapture;
};

struct type_StructuredBuffer_v4float
{
    spvUnsafeArray<float4, 1> _m0;
};

struct type_LocalVF
{
    int4 LocalVF_VertexFetch_Parameters;
};

constant float3x3 _165 = {};
constant float4 _166 = {};
constant float2 _168 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00006fd0_0688eadd(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    uint _219 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _220 = 2u * _219;
    float4 _225 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_220 + 1u)));
    float _226 = _225.w;
    float3 _227 = _225.xyz;
    float3 _229 = cross(_227, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_220)).xyz) * _226;
    float3x3 _232 = _165;
    _232[0] = cross(_229, _227) * _226;
    float3x3 _233 = _232;
    _233[1] = _229;
    float3x3 _234 = _233;
    _234[2] = _227;
    uint _235 = in.in_var_ATTRIBUTE13 * 36u;
    uint _238 = _235 + 1u;
    uint _241 = _235 + 2u;
    uint _244 = _235 + 3u;
    uint _250 = _235 + 4u;
    float3x3 _255 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz);
    _255[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].x;
    float3x3 _258 = _255;
    _258[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].y;
    float3x3 _261 = _258;
    _261[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].z;
    float3x3 _262 = _261 * _234;
    float3 _272 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _275 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _276 = _272 + _275;
    float3 _279 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _280 = _276 + _279;
    float3 _282 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz + View.View_PreViewTranslation;
    float3 _283 = _280 + _282;
    float _284 = _283.x;
    float _285 = _283.y;
    float _286 = _283.z;
    float4 _287 = float4(_284, _285, _286, 1.0);
    float4 _288 = float4(_287.x, _287.y, _287.z, _287.w);
    float4 _289 = View.View_TranslatedWorldToClip * _288;
    float4 _295 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _219)));
    spvUnsafeArray<float4, 1> _307 = { float4(_295.x, _295.y, float4(0.0).z, float4(0.0).w) };
    float3 _308 = _287.xyz;
    float3 _309 = _308 - View.View_TranslatedWorldCameraOrigin;
    float _313 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _321 = View.View_TranslatedWorldCameraOrigin;
    _321.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _322 = _321 * _313;
    float3 _325 = _322;
    _325.z = _322.z + 6360.009765625;
    float _326 = length(_325);
    float3 _327 = normalize(_309);
    float _328 = dot(_325, _327);
    float _329 = _328 / _326;
    float _331 = (-_326) * _329;
    float _335 = (_326 * _326) * ((_329 * _329) - 1.0);
    float _340 = length(_309) * _313;
    float _344 = fast::max(0.0, _340 - View.View_AtmosphericFogStartDistance);
    float _347 = fast::min((_344 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _348 = _340 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _358;
    float _359;
    if (_348)
    {
        _358 = _347 * View.View_AtmosphericFogPower;
        _359 = fast::max(_340 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _358 = 1.0;
        _359 = _331 - sqrt(_335 + 40449600.0);
    }
    float _365 = _331 - sqrt(_335 + 41344900.0);
    bool _366 = _365 > 0.0;
    float _374;
    float _375;
    float3 _376;
    if (_366)
    {
        _374 = (_328 + _365) * 0.00015552098921034485101699829101562;
        _375 = _359 - _365;
        _376 = _325 + (_327 * _365);
    }
    else
    {
        _374 = _329;
        _375 = _359;
        _376 = _325;
    }
    float _377 = _366 ? 6430.0 : _326;
    bool _378 = _377 < 6360.0146484375;
    float _387;
    float _388;
    float3 _389;
    if (_378)
    {
        float _381 = 6360.0146484375 - _377;
        float3 _383 = _376 - (_327 * _381);
        _387 = dot(_383, _327) * 0.0001572323380969464778900146484375;
        _388 = _375 - _381;
        _389 = _383;
    }
    else
    {
        _387 = _374;
        _388 = _375;
        _389 = _376;
    }
    float _390 = _378 ? 6360.0146484375 : _377;
    float3 _890;
    float3 _891;
    if ((_390 <= 6430.0) && (_344 > 0.0))
    {
        float3 _397 = _389 + (_327 * _388);
        float _398 = length(_397);
        float _399 = dot(_327, View.View_AtmosphereLightDirection[0].xyz);
        float _401 = dot(_389, View.View_AtmosphereLightDirection[0].xyz) / _390;
        float _402 = 6360.0 / _390;
        float _405 = sqrt(1.0 - (_402 * _402));
        float _414;
        if (_348)
        {
            _414 = fast::max(_387, 0.1550000011920928955078125 - _405);
        }
        else
        {
            _414 = fast::max(_387, 0.004999999888241291046142578125 - _405);
        }
        float3 _435;
        float _436;
        float _437;
        if (_348)
        {
            float _417 = _327.z;
            float _421 = fast::clamp(exp(-_417) - 0.5, 0.0, 1.0);
            float3 _433;
            float _434;
            if (_421 < 1.0)
            {
                float3 _426 = _327;
                _426.z = fast::max(_417, 0.1500000059604644775390625);
                float3 _427 = normalize(_426);
                float3 _429 = _389 + (_427 * _388);
                _433 = _427;
                _434 = dot(_429, _427) / length(_429);
            }
            else
            {
                _433 = _327;
                _434 = _414;
            }
            _435 = _433;
            _436 = _421;
            _437 = _434;
        }
        else
        {
            _435 = _327;
            _436 = 0.0;
            _437 = _414;
        }
        float _439 = 1.0 + (_399 * _399);
        float _450 = _390 * _390;
        float _452 = sqrt(_450 - 40449600.0);
        float _453 = _390 * _437;
        float _456 = ((_453 * _453) - _450) + 40449600.0;
        float4 _461 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_453 < 0.0) && (_456 > 0.0)));
        float _464 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _465 = 0.5 / _464;
        float _468 = 1.0 - (1.0 / _464);
        float _470 = _465 + ((_452 * 0.00105685577727854251861572265625) * _468);
        float _482 = _461.w + ((((_453 * _461.x) + sqrt(_456 + _461.y)) / (_452 + _461.z)) * 0.4921875);
        float _491 = (_399 + 1.0) * 3.5;
        float _492 = floor(_491);
        float _493 = _491 - _492;
        float _494 = _492 + (0.015625 + (((atan(fast::max(_401, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _495 = _494 * 0.125;
        float _499 = 1.0 - _493;
        float _502 = (_494 + 1.0) * 0.125;
        float4 _508 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _482, _470), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_502, _482, _470), level(0.0)) * _493), float4(0.0));
        float3 _874;
        float4 _875;
        if (_388 > 0.0)
        {
            float2 _519 = float2(_437, _437 + (_388 / _390));
            float2 _520 = _519 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _390);
            float2 _523 = float2(int2(sign(_520)));
            float2 _524 = _520 * _520;
            float _540 = 2.0 * _390;
            float _542 = (_388 / _540) + _437;
            float _550 = 6360.0 - _390;
            float2 _560 = _519 * sqrt(0.4166666567325592041015625 * _390);
            float2 _563 = float2(int2(sign(_560)));
            float2 _564 = _560 * _560;
            float3 _593 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _390) * exp(_550 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_523.y > _523.x) ? exp(_524.x) : 0.0) + dot((_523 / ((abs(_520) * 2.3192999362945556640625) + sqrt((_524 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_388) / View.View_AtmosphericFogHeightScaleRayleigh) * _542)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _390) * exp(_550 * 0.833333313465118408203125)) * (((_563.y > _563.x) ? exp(_564.x) : 0.0) + dot((_563 / ((abs(_560) * 2.3192999362945556640625) + sqrt((_564 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_388 * (-0.833333313465118408203125)) * _542)), float2(1.0, -1.0))))));
            float _601;
            if (_348)
            {
                _601 = fast::max(_398, _390);
            }
            else
            {
                _601 = _398;
            }
            float4 _873;
            if (_601 > 6360.009765625)
            {
                float4 _872;
                if (_436 < 1.0)
                {
                    float4 _612 = _593.xyzx;
                    float _613 = _601 * _601;
                    float _615 = sqrt(_613 - 40449600.0);
                    float _616 = _601 * (dot(_397, _435) / _398);
                    float _619 = ((_616 * _616) - _613) + 40449600.0;
                    float4 _624 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_616 < 0.0) && (_619 > 0.0)));
                    float _627 = _465 + ((_615 * 0.00105685577727854251861572265625) * _468);
                    float _639 = _624.w + ((((_616 * _624.x) + sqrt(_619 + _624.y)) / (_615 + _624.z)) * 0.4921875);
                    float _647 = _492 + (0.015625 + (((atan(fast::max(dot(_397, View.View_AtmosphereLightDirection[0].xyz) / _398, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _648 = _647 * 0.125;
                    float _654 = (_647 + 1.0) * 0.125;
                    float4 _662 = fast::max(_508 - (_612 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_648, _639, _627), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_654, _639, _627), level(0.0)) * _493))), float4(0.0));
                    float4 _871;
                    if (!_348)
                    {
                        float _706 = _437 - (-_405);
                        float4 _870;
                        if (abs(_706) < 0.004999999888241291046142578125)
                        {
                            float _713 = (-0.004999999888241291046142578125) - _405;
                            float _715 = _450 + (_388 * _388);
                            float _716 = _540 * _388;
                            float _719 = sqrt(_715 + (_716 * _713));
                            float _720 = _390 * _713;
                            float _723 = 0.004999999888241291046142578125 - _405;
                            float _727 = ((_720 * _720) - _450) + 40449600.0;
                            float4 _732 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_720 < 0.0) && (_727 > 0.0)));
                            float _744 = _732.w + ((((_720 * _732.x) + sqrt(_727 + _732.y)) / (_452 + _732.z)) * 0.4921875);
                            float _754 = _719 * _719;
                            float _756 = sqrt(_754 - 40449600.0);
                            float _757 = _719 * fast::max(_723, (_720 + _388) / _719);
                            float _760 = ((_757 * _757) - _754) + 40449600.0;
                            float4 _765 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_757 < 0.0) && (_760 > 0.0)));
                            float _768 = _465 + ((_756 * 0.00105685577727854251861572265625) * _468);
                            float _780 = _765.w + ((((_757 * _765.x) + sqrt(_760 + _765.y)) / (_756 + _765.z)) * 0.4921875);
                            float _795 = sqrt(_715 + (_716 * _723));
                            float _796 = _390 * _723;
                            float _802 = ((_796 * _796) - _450) + 40449600.0;
                            float4 _807 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_796 < 0.0) && (_802 > 0.0)));
                            float _819 = _807.w + ((((_796 * _807.x) + sqrt(_802 + _807.y)) / (_452 + _807.z)) * 0.4921875);
                            float _829 = _795 * _795;
                            float _831 = sqrt(_829 - 40449600.0);
                            float _832 = _795 * fast::max(_723, (_796 + _388) / _795);
                            float _835 = ((_832 * _832) - _829) + 40449600.0;
                            float4 _840 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_832 < 0.0) && (_835 > 0.0)));
                            float _843 = _465 + ((_831 * 0.00105685577727854251861572265625) * _468);
                            float _855 = _840.w + ((((_832 * _840.x) + sqrt(_835 + _840.y)) / (_831 + _840.z)) * 0.4921875);
                            _870 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _744, _470), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_502, _744, _470), level(0.0)) * _493)) - (_612 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_648, _780, _768), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_654, _780, _768), level(0.0)) * _493))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _819, _470), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_502, _819, _470), level(0.0)) * _493)) - (_612 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_648, _855, _843), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_654, _855, _843), level(0.0)) * _493))), float4(0.0)), float4((_706 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _870 = _662;
                        }
                        _871 = _870;
                    }
                    else
                    {
                        float4 _705;
                        if (_436 > 0.0)
                        {
                            float _671 = _390 * _414;
                            float _674 = ((_671 * _671) - _450) + 40449600.0;
                            float4 _679 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_671 < 0.0) && (_674 > 0.0)));
                            float _691 = _679.w + ((((_671 * _679.x) + sqrt(_674 + _679.y)) / (_452 + _679.z)) * 0.4921875);
                            _705 = mix(_662, (float4(1.0) - _612) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _691, _470), level(0.0)) * _499) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_502, _691, _470), level(0.0)) * _493), float4(0.0)), float4(_436));
                        }
                        else
                        {
                            _705 = _662;
                        }
                        _871 = _705;
                    }
                    _872 = _871;
                }
                else
                {
                    _872 = (float4(1.0) - _593.xyzx) * _508;
                }
                _873 = _872;
            }
            else
            {
                _873 = _508;
            }
            _874 = _593;
            _875 = _873;
        }
        else
        {
            _874 = float3(1.0);
            _875 = _508;
        }
        _890 = _874;
        _891 = fast::max((_875.xyz * (0.0596831031143665313720703125 * _439)) + ((((_875.xyz * (_875.w * smoothstep(0.0, 0.0199999995529651641845703125, _401))) / float3(fast::max(_875.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _399)), -1.5)) * _439) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _890 = float3(1.0);
        _891 = float3(0.0);
    }
    float3 _956;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _955;
        if (_359 > 0.0)
        {
            float3 _902 = _325 + (_327 * _359);
            float _903 = length(_902);
            float3 _905 = _902 / float3(_903);
            float _906 = dot(_905, View.View_AtmosphereLightDirection[0].xyz);
            float _908 = (_903 - 6360.0) * 0.014285714365541934967041015625;
            float3 _921 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_906 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_908)), level(0.0)).xyz, float3(0.0), bool3(_348));
            float3 _933 = ((_921 * fast::max(_906, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_906 + 0.20000000298023223876953125) * 0.833333313465118408203125, _908), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _953;
            if ((!_348) && true)
            {
                float3 _939 = normalize(View.View_AtmosphereLightDirection[0].xyz - _327);
                _953 = _933 + (_921 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_327, _939), 5.0))) * pow(fast::max(dot(_939, _905), 0.0), 150.0), 0.0));
            }
            else
            {
                _953 = _933;
            }
            _955 = _890 * _953;
        }
        else
        {
            _955 = float3(0.0);
        }
        _956 = _955;
    }
    else
    {
        _956 = float3(0.0);
    }
    float3 _993;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _992;
        switch (0u)
        {
            default:
            {
                if (_359 > 0.0)
                {
                    _992 = float3(0.0);
                    break;
                }
                else
                {
                    _992 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_329 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_326 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_326 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_327, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _993 = _992;
    }
    else
    {
        _993 = float3(0.0);
    }
    float _1013 = mix(fast::clamp((_890.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _347);
    float4 _1017 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _358)) * ((_993 + _956) + _891), _1013);
    float4 _1094;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1031 = (_308 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1037 = sqrt((fast::max(0.0, length(_1031) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1038 = _1037 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1045;
        if (_1038 < 0.707106769084930419921875)
        {
            _1045 = fast::clamp((_1038 * _1038) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1045 = 1.0;
        }
        float2 _1073;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1048 = normalize(_1031);
            float _1049 = _1048.z;
            float _1052 = sqrt(1.0 - (_1049 * _1049));
            float2 _1055 = _168;
            _1055.y = (_1049 * 0.5) + 0.5;
            float _1060 = acos(_1048.x / _1052);
            float2 _1065 = _1055;
            _1065.x = (((_1048.y / _1052) < 0.0) ? (6.283185482025146484375 - _1060) : _1060) * 0.15915493667125701904296875;
            _1073 = (_1065 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1073 = ((_289.xy / _289.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1078 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1073, _1037), level(0.0));
        float3 _1090 = _1017.xyz + (((_1078.xyz * _1045).xyz * View.View_OneOverPreExposure).xyz * _1013);
        float4 _1093 = float4(_1090.x, _1090.y, _1090.z, _166.w);
        _1093.w = _1013 * (1.0 - (_1045 * (1.0 - _1078.w)));
        _1094 = _1093;
    }
    else
    {
        _1094 = _1017;
    }
    out.out_var_TEXCOORD10_centroid = float4(_262[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_262[2], _226 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].w);
    out_var_TEXCOORD0 = _307;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _1094;
    out.gl_Position = _289;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

