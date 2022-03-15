

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

vertex Main_out Main_00006ff3_8e08b662(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(5)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], constant type_View& View [[buffer(3)]], constant type_LocalVF& LocalVF [[buffer(4)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
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
    uint _290 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _296 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_290 * _219) + min(0u, (_290 - 1u)))));
    float4 _297 = float4(_287.x, _287.y, _287.z, _287.w);
    float4 _298 = View.View_TranslatedWorldToClip * _297;
    spvUnsafeArray<float4, 1> _310 = { float4(_296.x, _296.y, float4(0.0).z, float4(0.0).w) };
    float3 _311 = _287.xyz;
    float3 _312 = _311 - View.View_TranslatedWorldCameraOrigin;
    float _316 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _324 = View.View_TranslatedWorldCameraOrigin;
    _324.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _325 = _324 * _316;
    float3 _328 = _325;
    _328.z = _325.z + 6360.009765625;
    float _329 = length(_328);
    float3 _330 = normalize(_312);
    float _331 = dot(_328, _330);
    float _332 = _331 / _329;
    float _334 = (-_329) * _332;
    float _338 = (_329 * _329) * ((_332 * _332) - 1.0);
    float _343 = length(_312) * _316;
    float _347 = fast::max(0.0, _343 - View.View_AtmosphericFogStartDistance);
    float _350 = fast::min((_347 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _351 = _343 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _361;
    float _362;
    if (_351)
    {
        _361 = _350 * View.View_AtmosphericFogPower;
        _362 = fast::max(_343 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _361 = 1.0;
        _362 = _334 - sqrt(_338 + 40449600.0);
    }
    float _368 = _334 - sqrt(_338 + 41344900.0);
    bool _369 = _368 > 0.0;
    float _377;
    float _378;
    float3 _379;
    if (_369)
    {
        _377 = (_331 + _368) * 0.00015552098921034485101699829101562;
        _378 = _362 - _368;
        _379 = _328 + (_330 * _368);
    }
    else
    {
        _377 = _332;
        _378 = _362;
        _379 = _328;
    }
    float _380 = _369 ? 6430.0 : _329;
    bool _381 = _380 < 6360.0146484375;
    float _390;
    float _391;
    float3 _392;
    if (_381)
    {
        float _384 = 6360.0146484375 - _380;
        float3 _386 = _379 - (_330 * _384);
        _390 = dot(_386, _330) * 0.0001572323380969464778900146484375;
        _391 = _378 - _384;
        _392 = _386;
    }
    else
    {
        _390 = _377;
        _391 = _378;
        _392 = _379;
    }
    float _393 = _381 ? 6360.0146484375 : _380;
    float3 _893;
    float3 _894;
    if ((_393 <= 6430.0) && (_347 > 0.0))
    {
        float3 _400 = _392 + (_330 * _391);
        float _401 = length(_400);
        float _402 = dot(_330, View.View_AtmosphereLightDirection[0].xyz);
        float _404 = dot(_392, View.View_AtmosphereLightDirection[0].xyz) / _393;
        float _405 = 6360.0 / _393;
        float _408 = sqrt(1.0 - (_405 * _405));
        float _417;
        if (_351)
        {
            _417 = fast::max(_390, 0.1550000011920928955078125 - _408);
        }
        else
        {
            _417 = fast::max(_390, 0.004999999888241291046142578125 - _408);
        }
        float3 _438;
        float _439;
        float _440;
        if (_351)
        {
            float _420 = _330.z;
            float _424 = fast::clamp(exp(-_420) - 0.5, 0.0, 1.0);
            float3 _436;
            float _437;
            if (_424 < 1.0)
            {
                float3 _429 = _330;
                _429.z = fast::max(_420, 0.1500000059604644775390625);
                float3 _430 = normalize(_429);
                float3 _432 = _392 + (_430 * _391);
                _436 = _430;
                _437 = dot(_432, _430) / length(_432);
            }
            else
            {
                _436 = _330;
                _437 = _417;
            }
            _438 = _436;
            _439 = _424;
            _440 = _437;
        }
        else
        {
            _438 = _330;
            _439 = 0.0;
            _440 = _417;
        }
        float _442 = 1.0 + (_402 * _402);
        float _453 = _393 * _393;
        float _455 = sqrt(_453 - 40449600.0);
        float _456 = _393 * _440;
        float _459 = ((_456 * _456) - _453) + 40449600.0;
        float4 _464 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_456 < 0.0) && (_459 > 0.0)));
        float _467 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _468 = 0.5 / _467;
        float _471 = 1.0 - (1.0 / _467);
        float _473 = _468 + ((_455 * 0.00105685577727854251861572265625) * _471);
        float _485 = _464.w + ((((_456 * _464.x) + sqrt(_459 + _464.y)) / (_455 + _464.z)) * 0.4921875);
        float _494 = (_402 + 1.0) * 3.5;
        float _495 = floor(_494);
        float _496 = _494 - _495;
        float _497 = _495 + (0.015625 + (((atan(fast::max(_404, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _498 = _497 * 0.125;
        float _502 = 1.0 - _496;
        float _505 = (_497 + 1.0) * 0.125;
        float4 _511 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_498, _485, _473), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_505, _485, _473), level(0.0)) * _496), float4(0.0));
        float3 _877;
        float4 _878;
        if (_391 > 0.0)
        {
            float2 _522 = float2(_440, _440 + (_391 / _393));
            float2 _523 = _522 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _393);
            float2 _526 = float2(int2(sign(_523)));
            float2 _527 = _523 * _523;
            float _543 = 2.0 * _393;
            float _545 = (_391 / _543) + _440;
            float _553 = 6360.0 - _393;
            float2 _563 = _522 * sqrt(0.4166666567325592041015625 * _393);
            float2 _566 = float2(int2(sign(_563)));
            float2 _567 = _563 * _563;
            float3 _596 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _393) * exp(_553 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_526.y > _526.x) ? exp(_527.x) : 0.0) + dot((_526 / ((abs(_523) * 2.3192999362945556640625) + sqrt((_527 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_391) / View.View_AtmosphericFogHeightScaleRayleigh) * _545)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _393) * exp(_553 * 0.833333313465118408203125)) * (((_566.y > _566.x) ? exp(_567.x) : 0.0) + dot((_566 / ((abs(_563) * 2.3192999362945556640625) + sqrt((_567 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_391 * (-0.833333313465118408203125)) * _545)), float2(1.0, -1.0))))));
            float _604;
            if (_351)
            {
                _604 = fast::max(_401, _393);
            }
            else
            {
                _604 = _401;
            }
            float4 _876;
            if (_604 > 6360.009765625)
            {
                float4 _875;
                if (_439 < 1.0)
                {
                    float4 _615 = _596.xyzx;
                    float _616 = _604 * _604;
                    float _618 = sqrt(_616 - 40449600.0);
                    float _619 = _604 * (dot(_400, _438) / _401);
                    float _622 = ((_619 * _619) - _616) + 40449600.0;
                    float4 _627 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_619 < 0.0) && (_622 > 0.0)));
                    float _630 = _468 + ((_618 * 0.00105685577727854251861572265625) * _471);
                    float _642 = _627.w + ((((_619 * _627.x) + sqrt(_622 + _627.y)) / (_618 + _627.z)) * 0.4921875);
                    float _650 = _495 + (0.015625 + (((atan(fast::max(dot(_400, View.View_AtmosphereLightDirection[0].xyz) / _401, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _651 = _650 * 0.125;
                    float _657 = (_650 + 1.0) * 0.125;
                    float4 _665 = fast::max(_511 - (_615 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_651, _642, _630), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_657, _642, _630), level(0.0)) * _496))), float4(0.0));
                    float4 _874;
                    if (!_351)
                    {
                        float _709 = _440 - (-_408);
                        float4 _873;
                        if (abs(_709) < 0.004999999888241291046142578125)
                        {
                            float _716 = (-0.004999999888241291046142578125) - _408;
                            float _718 = _453 + (_391 * _391);
                            float _719 = _543 * _391;
                            float _722 = sqrt(_718 + (_719 * _716));
                            float _723 = _393 * _716;
                            float _726 = 0.004999999888241291046142578125 - _408;
                            float _730 = ((_723 * _723) - _453) + 40449600.0;
                            float4 _735 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_723 < 0.0) && (_730 > 0.0)));
                            float _747 = _735.w + ((((_723 * _735.x) + sqrt(_730 + _735.y)) / (_455 + _735.z)) * 0.4921875);
                            float _757 = _722 * _722;
                            float _759 = sqrt(_757 - 40449600.0);
                            float _760 = _722 * fast::max(_726, (_723 + _391) / _722);
                            float _763 = ((_760 * _760) - _757) + 40449600.0;
                            float4 _768 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_760 < 0.0) && (_763 > 0.0)));
                            float _771 = _468 + ((_759 * 0.00105685577727854251861572265625) * _471);
                            float _783 = _768.w + ((((_760 * _768.x) + sqrt(_763 + _768.y)) / (_759 + _768.z)) * 0.4921875);
                            float _798 = sqrt(_718 + (_719 * _726));
                            float _799 = _393 * _726;
                            float _805 = ((_799 * _799) - _453) + 40449600.0;
                            float4 _810 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_799 < 0.0) && (_805 > 0.0)));
                            float _822 = _810.w + ((((_799 * _810.x) + sqrt(_805 + _810.y)) / (_455 + _810.z)) * 0.4921875);
                            float _832 = _798 * _798;
                            float _834 = sqrt(_832 - 40449600.0);
                            float _835 = _798 * fast::max(_726, (_799 + _391) / _798);
                            float _838 = ((_835 * _835) - _832) + 40449600.0;
                            float4 _843 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_835 < 0.0) && (_838 > 0.0)));
                            float _846 = _468 + ((_834 * 0.00105685577727854251861572265625) * _471);
                            float _858 = _843.w + ((((_835 * _843.x) + sqrt(_838 + _843.y)) / (_834 + _843.z)) * 0.4921875);
                            _873 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_498, _747, _473), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_505, _747, _473), level(0.0)) * _496)) - (_615 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_651, _783, _771), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_657, _783, _771), level(0.0)) * _496))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_498, _822, _473), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_505, _822, _473), level(0.0)) * _496)) - (_615 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_651, _858, _846), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_657, _858, _846), level(0.0)) * _496))), float4(0.0)), float4((_709 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _873 = _665;
                        }
                        _874 = _873;
                    }
                    else
                    {
                        float4 _708;
                        if (_439 > 0.0)
                        {
                            float _674 = _393 * _417;
                            float _677 = ((_674 * _674) - _453) + 40449600.0;
                            float4 _682 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_674 < 0.0) && (_677 > 0.0)));
                            float _694 = _682.w + ((((_674 * _682.x) + sqrt(_677 + _682.y)) / (_455 + _682.z)) * 0.4921875);
                            _708 = mix(_665, (float4(1.0) - _615) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_498, _694, _473), level(0.0)) * _502) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_505, _694, _473), level(0.0)) * _496), float4(0.0)), float4(_439));
                        }
                        else
                        {
                            _708 = _665;
                        }
                        _874 = _708;
                    }
                    _875 = _874;
                }
                else
                {
                    _875 = (float4(1.0) - _596.xyzx) * _511;
                }
                _876 = _875;
            }
            else
            {
                _876 = _511;
            }
            _877 = _596;
            _878 = _876;
        }
        else
        {
            _877 = float3(1.0);
            _878 = _511;
        }
        _893 = _877;
        _894 = fast::max((_878.xyz * (0.0596831031143665313720703125 * _442)) + ((((_878.xyz * (_878.w * smoothstep(0.0, 0.0199999995529651641845703125, _404))) / float3(fast::max(_878.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _402)), -1.5)) * _442) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _893 = float3(1.0);
        _894 = float3(0.0);
    }
    float3 _959;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _958;
        if (_362 > 0.0)
        {
            float3 _905 = _328 + (_330 * _362);
            float _906 = length(_905);
            float3 _908 = _905 / float3(_906);
            float _909 = dot(_908, View.View_AtmosphereLightDirection[0].xyz);
            float _911 = (_906 - 6360.0) * 0.014285714365541934967041015625;
            float3 _924 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_909 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_911)), level(0.0)).xyz, float3(0.0), bool3(_351));
            float3 _936 = ((_924 * fast::max(_909, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_909 + 0.20000000298023223876953125) * 0.833333313465118408203125, _911), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _956;
            if ((!_351) && true)
            {
                float3 _942 = normalize(View.View_AtmosphereLightDirection[0].xyz - _330);
                _956 = _936 + (_924 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_330, _942), 5.0))) * pow(fast::max(dot(_942, _908), 0.0), 150.0), 0.0));
            }
            else
            {
                _956 = _936;
            }
            _958 = _893 * _956;
        }
        else
        {
            _958 = float3(0.0);
        }
        _959 = _958;
    }
    else
    {
        _959 = float3(0.0);
    }
    float3 _996;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _995;
        switch (0u)
        {
            default:
            {
                if (_362 > 0.0)
                {
                    _995 = float3(0.0);
                    break;
                }
                else
                {
                    _995 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_332 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_329 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_329 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_330, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _996 = _995;
    }
    else
    {
        _996 = float3(0.0);
    }
    float _1016 = mix(fast::clamp((_893.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _350);
    float4 _1020 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _361)) * ((_996 + _959) + _894), _1016);
    float4 _1097;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1034 = (_311 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1040 = sqrt((fast::max(0.0, length(_1034) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1041 = _1040 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1048;
        if (_1041 < 0.707106769084930419921875)
        {
            _1048 = fast::clamp((_1041 * _1041) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1048 = 1.0;
        }
        float2 _1076;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1051 = normalize(_1034);
            float _1052 = _1051.z;
            float _1055 = sqrt(1.0 - (_1052 * _1052));
            float2 _1058 = _168;
            _1058.y = (_1052 * 0.5) + 0.5;
            float _1063 = acos(_1051.x / _1055);
            float2 _1068 = _1058;
            _1068.x = (((_1051.y / _1055) < 0.0) ? (6.283185482025146484375 - _1063) : _1063) * 0.15915493667125701904296875;
            _1076 = (_1068 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1076 = ((_298.xy / _298.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1081 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1076, _1040), level(0.0));
        float3 _1093 = _1020.xyz + (((_1081.xyz * _1048).xyz * View.View_OneOverPreExposure).xyz * _1016);
        float4 _1096 = float4(_1093.x, _1093.y, _1093.z, _166.w);
        _1096.w = _1016 * (1.0 - (_1048 * (1.0 - _1081.w)));
        _1097 = _1096;
    }
    else
    {
        _1097 = _1020;
    }
    out.out_var_TEXCOORD10_centroid = float4(_262[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_262[2], _226 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _250)].w);
    out_var_TEXCOORD0 = _310;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _1097;
    out.gl_Position = _298;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

