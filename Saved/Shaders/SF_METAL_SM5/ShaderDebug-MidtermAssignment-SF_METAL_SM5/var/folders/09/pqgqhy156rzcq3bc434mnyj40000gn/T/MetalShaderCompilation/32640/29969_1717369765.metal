

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

constant float3x3 _170 = {};
constant float4 _171 = {};
constant float2 _173 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD4 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
    uint out_var_LIGHTMAP_ID [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00007511_665cfba5(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _222 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _223 = 2u * _222;
    float4 _228 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_223 + 1u)));
    float _229 = _228.w;
    float3 _230 = _228.xyz;
    float3 _232 = cross(_230, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_223)).xyz) * _229;
    float3x3 _235 = _170;
    _235[0] = cross(_232, _230) * _229;
    float3x3 _236 = _235;
    _236[1] = _232;
    float3x3 _237 = _236;
    _237[2] = _230;
    uint _238 = in.in_var_ATTRIBUTE13 * 36u;
    uint _241 = _238 + 1u;
    uint _244 = _238 + 2u;
    uint _247 = _238 + 3u;
    uint _253 = _238 + 4u;
    float3x3 _258 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz);
    _258[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _253)].x;
    float3x3 _261 = _258;
    _261[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _253)].y;
    float3x3 _264 = _261;
    _264[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _253)].z;
    float3x3 _265 = _264 * _237;
    float3 _275 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _278 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _241)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _279 = _275 + _278;
    float3 _282 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _244)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _283 = _279 + _282;
    float3 _285 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _247)].xyz + View.View_PreViewTranslation;
    float3 _286 = _283 + _285;
    float _287 = _286.x;
    float _288 = _286.y;
    float _289 = _286.z;
    float4 _290 = float4(_287, _288, _289, 1.0);
    uint _293 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _296 = _293 * _222;
    float4 _299 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_296 + min(0u, (_293 - 1u)))));
    float4 _300 = float4(_290.x, _290.y, _290.z, _290.w);
    float4 _301 = View.View_TranslatedWorldToClip * _300;
    float2 _308 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_296 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy;
    uint _316 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _238 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _317 = _316 * 15u;
    uint _318 = _317 + 2u;
    float2 _324 = (_308 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _318)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _318)].zw;
    uint _325 = _317 + 3u;
    float2 _331 = (_308 * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _325)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _325)].zw;
    spvUnsafeArray<float4, 1> _343 = { float4(_299.x, _299.y, float4(0.0).z, float4(0.0).w) };
    float3 _344 = _290.xyz;
    float3 _345 = _344 - View.View_TranslatedWorldCameraOrigin;
    float _349 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _357 = View.View_TranslatedWorldCameraOrigin;
    _357.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _358 = _357 * _349;
    float3 _361 = _358;
    _361.z = _358.z + 6360.009765625;
    float _362 = length(_361);
    float3 _363 = normalize(_345);
    float _364 = dot(_361, _363);
    float _365 = _364 / _362;
    float _367 = (-_362) * _365;
    float _371 = (_362 * _362) * ((_365 * _365) - 1.0);
    float _376 = length(_345) * _349;
    float _380 = fast::max(0.0, _376 - View.View_AtmosphericFogStartDistance);
    float _383 = fast::min((_380 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _384 = _376 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _394;
    float _395;
    if (_384)
    {
        _394 = _383 * View.View_AtmosphericFogPower;
        _395 = fast::max(_376 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _394 = 1.0;
        _395 = _367 - sqrt(_371 + 40449600.0);
    }
    float _401 = _367 - sqrt(_371 + 41344900.0);
    bool _402 = _401 > 0.0;
    float _410;
    float _411;
    float3 _412;
    if (_402)
    {
        _410 = (_364 + _401) * 0.00015552098921034485101699829101562;
        _411 = _395 - _401;
        _412 = _361 + (_363 * _401);
    }
    else
    {
        _410 = _365;
        _411 = _395;
        _412 = _361;
    }
    float _413 = _402 ? 6430.0 : _362;
    bool _414 = _413 < 6360.0146484375;
    float _423;
    float _424;
    float3 _425;
    if (_414)
    {
        float _417 = 6360.0146484375 - _413;
        float3 _419 = _412 - (_363 * _417);
        _423 = dot(_419, _363) * 0.0001572323380969464778900146484375;
        _424 = _411 - _417;
        _425 = _419;
    }
    else
    {
        _423 = _410;
        _424 = _411;
        _425 = _412;
    }
    float _426 = _414 ? 6360.0146484375 : _413;
    float3 _926;
    float3 _927;
    if ((_426 <= 6430.0) && (_380 > 0.0))
    {
        float3 _433 = _425 + (_363 * _424);
        float _434 = length(_433);
        float _435 = dot(_363, View.View_AtmosphereLightDirection[0].xyz);
        float _437 = dot(_425, View.View_AtmosphereLightDirection[0].xyz) / _426;
        float _438 = 6360.0 / _426;
        float _441 = sqrt(1.0 - (_438 * _438));
        float _450;
        if (_384)
        {
            _450 = fast::max(_423, 0.1550000011920928955078125 - _441);
        }
        else
        {
            _450 = fast::max(_423, 0.004999999888241291046142578125 - _441);
        }
        float3 _471;
        float _472;
        float _473;
        if (_384)
        {
            float _453 = _363.z;
            float _457 = fast::clamp(exp(-_453) - 0.5, 0.0, 1.0);
            float3 _469;
            float _470;
            if (_457 < 1.0)
            {
                float3 _462 = _363;
                _462.z = fast::max(_453, 0.1500000059604644775390625);
                float3 _463 = normalize(_462);
                float3 _465 = _425 + (_463 * _424);
                _469 = _463;
                _470 = dot(_465, _463) / length(_465);
            }
            else
            {
                _469 = _363;
                _470 = _450;
            }
            _471 = _469;
            _472 = _457;
            _473 = _470;
        }
        else
        {
            _471 = _363;
            _472 = 0.0;
            _473 = _450;
        }
        float _475 = 1.0 + (_435 * _435);
        float _486 = _426 * _426;
        float _488 = sqrt(_486 - 40449600.0);
        float _489 = _426 * _473;
        float _492 = ((_489 * _489) - _486) + 40449600.0;
        float4 _497 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_489 < 0.0) && (_492 > 0.0)));
        float _500 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _501 = 0.5 / _500;
        float _504 = 1.0 - (1.0 / _500);
        float _506 = _501 + ((_488 * 0.00105685577727854251861572265625) * _504);
        float _518 = _497.w + ((((_489 * _497.x) + sqrt(_492 + _497.y)) / (_488 + _497.z)) * 0.4921875);
        float _527 = (_435 + 1.0) * 3.5;
        float _528 = floor(_527);
        float _529 = _527 - _528;
        float _530 = _528 + (0.015625 + (((atan(fast::max(_437, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _531 = _530 * 0.125;
        float _535 = 1.0 - _529;
        float _538 = (_530 + 1.0) * 0.125;
        float4 _544 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_531, _518, _506), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_538, _518, _506), level(0.0)) * _529), float4(0.0));
        float3 _910;
        float4 _911;
        if (_424 > 0.0)
        {
            float2 _555 = float2(_473, _473 + (_424 / _426));
            float2 _556 = _555 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _426);
            float2 _559 = float2(int2(sign(_556)));
            float2 _560 = _556 * _556;
            float _576 = 2.0 * _426;
            float _578 = (_424 / _576) + _473;
            float _586 = 6360.0 - _426;
            float2 _596 = _555 * sqrt(0.4166666567325592041015625 * _426);
            float2 _599 = float2(int2(sign(_596)));
            float2 _600 = _596 * _596;
            float3 _629 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _426) * exp(_586 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_559.y > _559.x) ? exp(_560.x) : 0.0) + dot((_559 / ((abs(_556) * 2.3192999362945556640625) + sqrt((_560 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_424) / View.View_AtmosphericFogHeightScaleRayleigh) * _578)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _426) * exp(_586 * 0.833333313465118408203125)) * (((_599.y > _599.x) ? exp(_600.x) : 0.0) + dot((_599 / ((abs(_596) * 2.3192999362945556640625) + sqrt((_600 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_424 * (-0.833333313465118408203125)) * _578)), float2(1.0, -1.0))))));
            float _637;
            if (_384)
            {
                _637 = fast::max(_434, _426);
            }
            else
            {
                _637 = _434;
            }
            float4 _909;
            if (_637 > 6360.009765625)
            {
                float4 _908;
                if (_472 < 1.0)
                {
                    float4 _648 = _629.xyzx;
                    float _649 = _637 * _637;
                    float _651 = sqrt(_649 - 40449600.0);
                    float _652 = _637 * (dot(_433, _471) / _434);
                    float _655 = ((_652 * _652) - _649) + 40449600.0;
                    float4 _660 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_652 < 0.0) && (_655 > 0.0)));
                    float _663 = _501 + ((_651 * 0.00105685577727854251861572265625) * _504);
                    float _675 = _660.w + ((((_652 * _660.x) + sqrt(_655 + _660.y)) / (_651 + _660.z)) * 0.4921875);
                    float _683 = _528 + (0.015625 + (((atan(fast::max(dot(_433, View.View_AtmosphereLightDirection[0].xyz) / _434, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _684 = _683 * 0.125;
                    float _690 = (_683 + 1.0) * 0.125;
                    float4 _698 = fast::max(_544 - (_648 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _675, _663), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_690, _675, _663), level(0.0)) * _529))), float4(0.0));
                    float4 _907;
                    if (!_384)
                    {
                        float _742 = _473 - (-_441);
                        float4 _906;
                        if (abs(_742) < 0.004999999888241291046142578125)
                        {
                            float _749 = (-0.004999999888241291046142578125) - _441;
                            float _751 = _486 + (_424 * _424);
                            float _752 = _576 * _424;
                            float _755 = sqrt(_751 + (_752 * _749));
                            float _756 = _426 * _749;
                            float _759 = 0.004999999888241291046142578125 - _441;
                            float _763 = ((_756 * _756) - _486) + 40449600.0;
                            float4 _768 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_756 < 0.0) && (_763 > 0.0)));
                            float _780 = _768.w + ((((_756 * _768.x) + sqrt(_763 + _768.y)) / (_488 + _768.z)) * 0.4921875);
                            float _790 = _755 * _755;
                            float _792 = sqrt(_790 - 40449600.0);
                            float _793 = _755 * fast::max(_759, (_756 + _424) / _755);
                            float _796 = ((_793 * _793) - _790) + 40449600.0;
                            float4 _801 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_793 < 0.0) && (_796 > 0.0)));
                            float _804 = _501 + ((_792 * 0.00105685577727854251861572265625) * _504);
                            float _816 = _801.w + ((((_793 * _801.x) + sqrt(_796 + _801.y)) / (_792 + _801.z)) * 0.4921875);
                            float _831 = sqrt(_751 + (_752 * _759));
                            float _832 = _426 * _759;
                            float _838 = ((_832 * _832) - _486) + 40449600.0;
                            float4 _843 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_832 < 0.0) && (_838 > 0.0)));
                            float _855 = _843.w + ((((_832 * _843.x) + sqrt(_838 + _843.y)) / (_488 + _843.z)) * 0.4921875);
                            float _865 = _831 * _831;
                            float _867 = sqrt(_865 - 40449600.0);
                            float _868 = _831 * fast::max(_759, (_832 + _424) / _831);
                            float _871 = ((_868 * _868) - _865) + 40449600.0;
                            float4 _876 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_868 < 0.0) && (_871 > 0.0)));
                            float _879 = _501 + ((_867 * 0.00105685577727854251861572265625) * _504);
                            float _891 = _876.w + ((((_868 * _876.x) + sqrt(_871 + _876.y)) / (_867 + _876.z)) * 0.4921875);
                            _906 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_531, _780, _506), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_538, _780, _506), level(0.0)) * _529)) - (_648 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _816, _804), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_690, _816, _804), level(0.0)) * _529))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_531, _855, _506), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_538, _855, _506), level(0.0)) * _529)) - (_648 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _891, _879), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_690, _891, _879), level(0.0)) * _529))), float4(0.0)), float4((_742 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _906 = _698;
                        }
                        _907 = _906;
                    }
                    else
                    {
                        float4 _741;
                        if (_472 > 0.0)
                        {
                            float _707 = _426 * _450;
                            float _710 = ((_707 * _707) - _486) + 40449600.0;
                            float4 _715 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_707 < 0.0) && (_710 > 0.0)));
                            float _727 = _715.w + ((((_707 * _715.x) + sqrt(_710 + _715.y)) / (_488 + _715.z)) * 0.4921875);
                            _741 = mix(_698, (float4(1.0) - _648) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_531, _727, _506), level(0.0)) * _535) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_538, _727, _506), level(0.0)) * _529), float4(0.0)), float4(_472));
                        }
                        else
                        {
                            _741 = _698;
                        }
                        _907 = _741;
                    }
                    _908 = _907;
                }
                else
                {
                    _908 = (float4(1.0) - _629.xyzx) * _544;
                }
                _909 = _908;
            }
            else
            {
                _909 = _544;
            }
            _910 = _629;
            _911 = _909;
        }
        else
        {
            _910 = float3(1.0);
            _911 = _544;
        }
        _926 = _910;
        _927 = fast::max((_911.xyz * (0.0596831031143665313720703125 * _475)) + ((((_911.xyz * (_911.w * smoothstep(0.0, 0.0199999995529651641845703125, _437))) / float3(fast::max(_911.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _435)), -1.5)) * _475) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _926 = float3(1.0);
        _927 = float3(0.0);
    }
    float3 _992;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _991;
        if (_395 > 0.0)
        {
            float3 _938 = _361 + (_363 * _395);
            float _939 = length(_938);
            float3 _941 = _938 / float3(_939);
            float _942 = dot(_941, View.View_AtmosphereLightDirection[0].xyz);
            float _944 = (_939 - 6360.0) * 0.014285714365541934967041015625;
            float3 _957 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_942 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_944)), level(0.0)).xyz, float3(0.0), bool3(_384));
            float3 _969 = ((_957 * fast::max(_942, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_942 + 0.20000000298023223876953125) * 0.833333313465118408203125, _944), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _989;
            if ((!_384) && true)
            {
                float3 _975 = normalize(View.View_AtmosphereLightDirection[0].xyz - _363);
                _989 = _969 + (_957 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_363, _975), 5.0))) * pow(fast::max(dot(_975, _941), 0.0), 150.0), 0.0));
            }
            else
            {
                _989 = _969;
            }
            _991 = _926 * _989;
        }
        else
        {
            _991 = float3(0.0);
        }
        _992 = _991;
    }
    else
    {
        _992 = float3(0.0);
    }
    float3 _1029;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1028;
        switch (0u)
        {
            default:
            {
                if (_395 > 0.0)
                {
                    _1028 = float3(0.0);
                    break;
                }
                else
                {
                    _1028 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_365 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_362 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_362 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_363, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1029 = _1028;
    }
    else
    {
        _1029 = float3(0.0);
    }
    float _1049 = mix(fast::clamp((_926.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _383);
    float4 _1053 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _394)) * ((_1029 + _992) + _927), _1049);
    float4 _1130;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1067 = (_344 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1073 = sqrt((fast::max(0.0, length(_1067) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1074 = _1073 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1081;
        if (_1074 < 0.707106769084930419921875)
        {
            _1081 = fast::clamp((_1074 * _1074) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1081 = 1.0;
        }
        float2 _1109;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1084 = normalize(_1067);
            float _1085 = _1084.z;
            float _1088 = sqrt(1.0 - (_1085 * _1085));
            float2 _1091 = _173;
            _1091.y = (_1085 * 0.5) + 0.5;
            float _1096 = acos(_1084.x / _1088);
            float2 _1101 = _1091;
            _1101.x = (((_1084.y / _1088) < 0.0) ? (6.283185482025146484375 - _1096) : _1096) * 0.15915493667125701904296875;
            _1109 = (_1101 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1109 = ((_301.xy / _301.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1114 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1109, _1073), level(0.0));
        float3 _1126 = _1053.xyz + (((_1114.xyz * _1081).xyz * View.View_OneOverPreExposure).xyz * _1049);
        float4 _1129 = float4(_1126.x, _1126.y, _1126.z, _171.w);
        _1129.w = _1049 * (1.0 - (_1081 * (1.0 - _1114.w)));
        _1130 = _1129;
    }
    else
    {
        _1130 = _1053;
    }
    out.out_var_TEXCOORD10_centroid = float4(_265[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_265[2], _229 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _253)].w);
    out_var_TEXCOORD0 = _343;
    out.out_var_TEXCOORD4 = float4(_324.x, _324.y, _331.x, _331.y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _316;
    out.out_var_TEXCOORD7 = _1130;
    out.gl_Position = _301;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

