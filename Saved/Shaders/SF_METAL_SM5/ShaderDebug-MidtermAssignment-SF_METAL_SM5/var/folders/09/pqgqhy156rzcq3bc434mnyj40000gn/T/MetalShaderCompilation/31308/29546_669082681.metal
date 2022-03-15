

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
    char _m1_pad[4];
    uint LocalVF_LODLightmapDataIndex;
};

constant float3x3 _167 = {};
constant float4 _168 = {};
constant float2 _170 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD4 [[user(locn2)]];
    uint out_var_PRIMITIVE_ID [[user(locn3)]];
    uint out_var_LIGHTMAP_ID [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_0000736a_27e16439(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _219 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _220 = 2u * _219;
    float4 _225 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_220 + 1u)));
    float _226 = _225.w;
    float3 _227 = _225.xyz;
    float3 _229 = cross(_227, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_220)).xyz) * _226;
    float3x3 _232 = _167;
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
    float2 _300 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _219) + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _308 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _235 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _309 = _308 * 15u;
    uint _310 = _309 + 2u;
    float2 _316 = (_300 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _310)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _310)].zw;
    uint _317 = _309 + 3u;
    float2 _323 = (_300 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _317)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _317)].zw;
    float3 _335 = _287.xyz;
    float3 _336 = _335 - View.View_TranslatedWorldCameraOrigin;
    float _340 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _348 = View.View_TranslatedWorldCameraOrigin;
    _348.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _349 = _348 * _340;
    float3 _352 = _349;
    _352.z = _349.z + 6360.009765625;
    float _353 = length(_352);
    float3 _354 = normalize(_336);
    float _355 = dot(_352, _354);
    float _356 = _355 / _353;
    float _358 = (-_353) * _356;
    float _362 = (_353 * _353) * ((_356 * _356) - 1.0);
    float _367 = length(_336) * _340;
    float _371 = fast::max(0.0, _367 - View.View_AtmosphericFogStartDistance);
    float _374 = fast::min((_371 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _375 = _367 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _385;
    float _386;
    if (_375)
    {
        _385 = _374 * View.View_AtmosphericFogPower;
        _386 = fast::max(_367 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _385 = 1.0;
        _386 = _358 - sqrt(_362 + 40449600.0);
    }
    float _392 = _358 - sqrt(_362 + 41344900.0);
    bool _393 = _392 > 0.0;
    float _401;
    float _402;
    float3 _403;
    if (_393)
    {
        _401 = (_355 + _392) * 0.00015552098921034485101699829101562;
        _402 = _386 - _392;
        _403 = _352 + (_354 * _392);
    }
    else
    {
        _401 = _356;
        _402 = _386;
        _403 = _352;
    }
    float _404 = _393 ? 6430.0 : _353;
    bool _405 = _404 < 6360.0146484375;
    float _414;
    float _415;
    float3 _416;
    if (_405)
    {
        float _408 = 6360.0146484375 - _404;
        float3 _410 = _403 - (_354 * _408);
        _414 = dot(_410, _354) * 0.0001572323380969464778900146484375;
        _415 = _402 - _408;
        _416 = _410;
    }
    else
    {
        _414 = _401;
        _415 = _402;
        _416 = _403;
    }
    float _417 = _405 ? 6360.0146484375 : _404;
    float3 _917;
    float3 _918;
    if ((_417 <= 6430.0) && (_371 > 0.0))
    {
        float3 _424 = _416 + (_354 * _415);
        float _425 = length(_424);
        float _426 = dot(_354, View.View_AtmosphereLightDirection[0].xyz);
        float _428 = dot(_416, View.View_AtmosphereLightDirection[0].xyz) / _417;
        float _429 = 6360.0 / _417;
        float _432 = sqrt(1.0 - (_429 * _429));
        float _441;
        if (_375)
        {
            _441 = fast::max(_414, 0.1550000011920928955078125 - _432);
        }
        else
        {
            _441 = fast::max(_414, 0.004999999888241291046142578125 - _432);
        }
        float3 _462;
        float _463;
        float _464;
        if (_375)
        {
            float _444 = _354.z;
            float _448 = fast::clamp(exp(-_444) - 0.5, 0.0, 1.0);
            float3 _460;
            float _461;
            if (_448 < 1.0)
            {
                float3 _453 = _354;
                _453.z = fast::max(_444, 0.1500000059604644775390625);
                float3 _454 = normalize(_453);
                float3 _456 = _416 + (_454 * _415);
                _460 = _454;
                _461 = dot(_456, _454) / length(_456);
            }
            else
            {
                _460 = _354;
                _461 = _441;
            }
            _462 = _460;
            _463 = _448;
            _464 = _461;
        }
        else
        {
            _462 = _354;
            _463 = 0.0;
            _464 = _441;
        }
        float _466 = 1.0 + (_426 * _426);
        float _477 = _417 * _417;
        float _479 = sqrt(_477 - 40449600.0);
        float _480 = _417 * _464;
        float _483 = ((_480 * _480) - _477) + 40449600.0;
        float4 _488 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_480 < 0.0) && (_483 > 0.0)));
        float _491 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _492 = 0.5 / _491;
        float _495 = 1.0 - (1.0 / _491);
        float _497 = _492 + ((_479 * 0.00105685577727854251861572265625) * _495);
        float _509 = _488.w + ((((_480 * _488.x) + sqrt(_483 + _488.y)) / (_479 + _488.z)) * 0.4921875);
        float _518 = (_426 + 1.0) * 3.5;
        float _519 = floor(_518);
        float _520 = _518 - _519;
        float _521 = _519 + (0.015625 + (((atan(fast::max(_428, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _522 = _521 * 0.125;
        float _526 = 1.0 - _520;
        float _529 = (_521 + 1.0) * 0.125;
        float4 _535 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_522, _509, _497), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_529, _509, _497), level(0.0)) * _520), float4(0.0));
        float3 _901;
        float4 _902;
        if (_415 > 0.0)
        {
            float2 _546 = float2(_464, _464 + (_415 / _417));
            float2 _547 = _546 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _417);
            float2 _550 = float2(int2(sign(_547)));
            float2 _551 = _547 * _547;
            float _567 = 2.0 * _417;
            float _569 = (_415 / _567) + _464;
            float _577 = 6360.0 - _417;
            float2 _587 = _546 * sqrt(0.4166666567325592041015625 * _417);
            float2 _590 = float2(int2(sign(_587)));
            float2 _591 = _587 * _587;
            float3 _620 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _417) * exp(_577 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_550.y > _550.x) ? exp(_551.x) : 0.0) + dot((_550 / ((abs(_547) * 2.3192999362945556640625) + sqrt((_551 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_415) / View.View_AtmosphericFogHeightScaleRayleigh) * _569)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _417) * exp(_577 * 0.833333313465118408203125)) * (((_590.y > _590.x) ? exp(_591.x) : 0.0) + dot((_590 / ((abs(_587) * 2.3192999362945556640625) + sqrt((_591 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_415 * (-0.833333313465118408203125)) * _569)), float2(1.0, -1.0))))));
            float _628;
            if (_375)
            {
                _628 = fast::max(_425, _417);
            }
            else
            {
                _628 = _425;
            }
            float4 _900;
            if (_628 > 6360.009765625)
            {
                float4 _899;
                if (_463 < 1.0)
                {
                    float4 _639 = _620.xyzx;
                    float _640 = _628 * _628;
                    float _642 = sqrt(_640 - 40449600.0);
                    float _643 = _628 * (dot(_424, _462) / _425);
                    float _646 = ((_643 * _643) - _640) + 40449600.0;
                    float4 _651 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_643 < 0.0) && (_646 > 0.0)));
                    float _654 = _492 + ((_642 * 0.00105685577727854251861572265625) * _495);
                    float _666 = _651.w + ((((_643 * _651.x) + sqrt(_646 + _651.y)) / (_642 + _651.z)) * 0.4921875);
                    float _674 = _519 + (0.015625 + (((atan(fast::max(dot(_424, View.View_AtmosphereLightDirection[0].xyz) / _425, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _675 = _674 * 0.125;
                    float _681 = (_674 + 1.0) * 0.125;
                    float4 _689 = fast::max(_535 - (_639 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _666, _654), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_681, _666, _654), level(0.0)) * _520))), float4(0.0));
                    float4 _898;
                    if (!_375)
                    {
                        float _733 = _464 - (-_432);
                        float4 _897;
                        if (abs(_733) < 0.004999999888241291046142578125)
                        {
                            float _740 = (-0.004999999888241291046142578125) - _432;
                            float _742 = _477 + (_415 * _415);
                            float _743 = _567 * _415;
                            float _746 = sqrt(_742 + (_743 * _740));
                            float _747 = _417 * _740;
                            float _750 = 0.004999999888241291046142578125 - _432;
                            float _754 = ((_747 * _747) - _477) + 40449600.0;
                            float4 _759 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_747 < 0.0) && (_754 > 0.0)));
                            float _771 = _759.w + ((((_747 * _759.x) + sqrt(_754 + _759.y)) / (_479 + _759.z)) * 0.4921875);
                            float _781 = _746 * _746;
                            float _783 = sqrt(_781 - 40449600.0);
                            float _784 = _746 * fast::max(_750, (_747 + _415) / _746);
                            float _787 = ((_784 * _784) - _781) + 40449600.0;
                            float4 _792 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_784 < 0.0) && (_787 > 0.0)));
                            float _795 = _492 + ((_783 * 0.00105685577727854251861572265625) * _495);
                            float _807 = _792.w + ((((_784 * _792.x) + sqrt(_787 + _792.y)) / (_783 + _792.z)) * 0.4921875);
                            float _822 = sqrt(_742 + (_743 * _750));
                            float _823 = _417 * _750;
                            float _829 = ((_823 * _823) - _477) + 40449600.0;
                            float4 _834 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_823 < 0.0) && (_829 > 0.0)));
                            float _846 = _834.w + ((((_823 * _834.x) + sqrt(_829 + _834.y)) / (_479 + _834.z)) * 0.4921875);
                            float _856 = _822 * _822;
                            float _858 = sqrt(_856 - 40449600.0);
                            float _859 = _822 * fast::max(_750, (_823 + _415) / _822);
                            float _862 = ((_859 * _859) - _856) + 40449600.0;
                            float4 _867 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_859 < 0.0) && (_862 > 0.0)));
                            float _870 = _492 + ((_858 * 0.00105685577727854251861572265625) * _495);
                            float _882 = _867.w + ((((_859 * _867.x) + sqrt(_862 + _867.y)) / (_858 + _867.z)) * 0.4921875);
                            _897 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_522, _771, _497), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_529, _771, _497), level(0.0)) * _520)) - (_639 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _807, _795), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_681, _807, _795), level(0.0)) * _520))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_522, _846, _497), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_529, _846, _497), level(0.0)) * _520)) - (_639 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _882, _870), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_681, _882, _870), level(0.0)) * _520))), float4(0.0)), float4((_733 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _897 = _689;
                        }
                        _898 = _897;
                    }
                    else
                    {
                        float4 _732;
                        if (_463 > 0.0)
                        {
                            float _698 = _417 * _441;
                            float _701 = ((_698 * _698) - _477) + 40449600.0;
                            float4 _706 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_698 < 0.0) && (_701 > 0.0)));
                            float _718 = _706.w + ((((_698 * _706.x) + sqrt(_701 + _706.y)) / (_479 + _706.z)) * 0.4921875);
                            _732 = mix(_689, (float4(1.0) - _639) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_522, _718, _497), level(0.0)) * _526) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_529, _718, _497), level(0.0)) * _520), float4(0.0)), float4(_463));
                        }
                        else
                        {
                            _732 = _689;
                        }
                        _898 = _732;
                    }
                    _899 = _898;
                }
                else
                {
                    _899 = (float4(1.0) - _620.xyzx) * _535;
                }
                _900 = _899;
            }
            else
            {
                _900 = _535;
            }
            _901 = _620;
            _902 = _900;
        }
        else
        {
            _901 = float3(1.0);
            _902 = _535;
        }
        _917 = _901;
        _918 = fast::max((_902.xyz * (0.0596831031143665313720703125 * _466)) + ((((_902.xyz * (_902.w * smoothstep(0.0, 0.0199999995529651641845703125, _428))) / float3(fast::max(_902.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _426)), -1.5)) * _466) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _917 = float3(1.0);
        _918 = float3(0.0);
    }
    float3 _983;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _982;
        if (_386 > 0.0)
        {
            float3 _929 = _352 + (_354 * _386);
            float _930 = length(_929);
            float3 _932 = _929 / float3(_930);
            float _933 = dot(_932, View.View_AtmosphereLightDirection[0].xyz);
            float _935 = (_930 - 6360.0) * 0.014285714365541934967041015625;
            float3 _948 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_933 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_935)), level(0.0)).xyz, float3(0.0), bool3(_375));
            float3 _960 = ((_948 * fast::max(_933, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_933 + 0.20000000298023223876953125) * 0.833333313465118408203125, _935), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _980;
            if ((!_375) && true)
            {
                float3 _966 = normalize(View.View_AtmosphereLightDirection[0].xyz - _354);
                _980 = _960 + (_948 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_354, _966), 5.0))) * pow(fast::max(dot(_966, _932), 0.0), 150.0), 0.0));
            }
            else
            {
                _980 = _960;
            }
            _982 = _917 * _980;
        }
        else
        {
            _982 = float3(0.0);
        }
        _983 = _982;
    }
    else
    {
        _983 = float3(0.0);
    }
    float3 _1020;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1019;
        switch (0u)
        {
            default:
            {
                if (_386 > 0.0)
                {
                    _1019 = float3(0.0);
                    break;
                }
                else
                {
                    _1019 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_356 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_353 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_353 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_354, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1020 = _1019;
    }
    else
    {
        _1020 = float3(0.0);
    }
    float _1040 = mix(fast::clamp((_917.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _374);
    float4 _1044 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _385)) * ((_1020 + _983) + _918), _1040);
    float4 _1121;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1058 = (_335 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1064 = sqrt((fast::max(0.0, length(_1058) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1065 = _1064 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1072;
        if (_1065 < 0.707106769084930419921875)
        {
            _1072 = fast::clamp((_1065 * _1065) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1072 = 1.0;
        }
        float2 _1100;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1075 = normalize(_1058);
            float _1076 = _1075.z;
            float _1079 = sqrt(1.0 - (_1076 * _1076));
            float2 _1082 = _170;
            _1082.y = (_1076 * 0.5) + 0.5;
            float _1087 = acos(_1075.x / _1079);
            float2 _1092 = _1082;
            _1092.x = (((_1075.y / _1079) < 0.0) ? (6.283185482025146484375 - _1087) : _1087) * 0.15915493667125701904296875;
            _1100 = (_1092 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1100 = ((_289.xy / _289.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1105 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1100, _1064), level(0.0));
        float3 _1117 = _1044.xyz + (((_1105.xyz * _1072).xyz * View.View_OneOverPreExposure).xyz * _1040);
        float4 _1120 = float4(_1117.x, _1117.y, _1117.z, _168.w);
        _1120.w = _1040 * (1.0 - (_1072 * (1.0 - _1105.w)));
        _1121 = _1120;
    }
    else
    {
        _1121 = _1044;
    }
    out.out_var_TEXCOORD10_centroid = float4(_262[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_262[2], _226 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].w);
    out.out_var_TEXCOORD4 = float4(_316.x, _316.y, _323.x, _323.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _308;
    out.out_var_TEXCOORD7 = _1121;
    out.gl_Position = _289;
    return out;
}

