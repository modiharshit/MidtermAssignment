

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

constant float3x3 _171 = {};
constant float4 _172 = {};
constant float2 _174 = {};

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

vertex Main_out Main_000073f4_17a03467(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _223 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _224 = 2u * _223;
    float4 _229 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_224 + 1u)));
    float _230 = _229.w;
    float3 _231 = _229.xyz;
    float3 _233 = cross(_231, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_224)).xyz) * _230;
    float3x3 _236 = _171;
    _236[0] = cross(_233, _231) * _230;
    float3x3 _237 = _236;
    _237[1] = _233;
    float3x3 _238 = _237;
    _238[2] = _231;
    uint _239 = in.in_var_ATTRIBUTE13 * 36u;
    uint _242 = _239 + 1u;
    uint _245 = _239 + 2u;
    uint _248 = _239 + 3u;
    uint _254 = _239 + 4u;
    float3x3 _259 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _245)].xyz);
    _259[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _254)].x;
    float3x3 _262 = _259;
    _262[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _254)].y;
    float3x3 _265 = _262;
    _265[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _245)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _254)].z;
    float3x3 _266 = _265 * _238;
    float3 _276 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _279 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _280 = _276 + _279;
    float3 _283 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _245)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _284 = _280 + _283;
    float3 _286 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _248)].xyz + View.View_PreViewTranslation;
    float3 _287 = _284 + _286;
    float _288 = _287.x;
    float _289 = _287.y;
    float _290 = _287.z;
    float4 _291 = float4(_288, _289, _290, 1.0);
    uint _294 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    uint _297 = _294 * _223;
    float4 _300 = LocalVF_VertexFetch_TexCoordBuffer.read(uint((_297 + min(0u, (_294 - 1u)))));
    float4 _301 = float4(_291.x, _291.y, _291.z, _291.w);
    float4 _302 = View.View_TranslatedWorldToClip * _301;
    uint _317 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _319 = (_317 * 15u) + 2u;
    float2 _325 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint((_297 + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _319)].zw;
    spvUnsafeArray<float4, 1> _337 = { float4(_300.x, _300.y, float4(0.0).z, float4(0.0).w) };
    float3 _338 = _291.xyz;
    float3 _339 = _338 - View.View_TranslatedWorldCameraOrigin;
    float _343 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _351 = View.View_TranslatedWorldCameraOrigin;
    _351.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _352 = _351 * _343;
    float3 _355 = _352;
    _355.z = _352.z + 6360.009765625;
    float _356 = length(_355);
    float3 _357 = normalize(_339);
    float _358 = dot(_355, _357);
    float _359 = _358 / _356;
    float _361 = (-_356) * _359;
    float _365 = (_356 * _356) * ((_359 * _359) - 1.0);
    float _370 = length(_339) * _343;
    float _374 = fast::max(0.0, _370 - View.View_AtmosphericFogStartDistance);
    float _377 = fast::min((_374 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _378 = _370 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _388;
    float _389;
    if (_378)
    {
        _388 = _377 * View.View_AtmosphericFogPower;
        _389 = fast::max(_370 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _388 = 1.0;
        _389 = _361 - sqrt(_365 + 40449600.0);
    }
    float _395 = _361 - sqrt(_365 + 41344900.0);
    bool _396 = _395 > 0.0;
    float _404;
    float _405;
    float3 _406;
    if (_396)
    {
        _404 = (_358 + _395) * 0.00015552098921034485101699829101562;
        _405 = _389 - _395;
        _406 = _355 + (_357 * _395);
    }
    else
    {
        _404 = _359;
        _405 = _389;
        _406 = _355;
    }
    float _407 = _396 ? 6430.0 : _356;
    bool _408 = _407 < 6360.0146484375;
    float _417;
    float _418;
    float3 _419;
    if (_408)
    {
        float _411 = 6360.0146484375 - _407;
        float3 _413 = _406 - (_357 * _411);
        _417 = dot(_413, _357) * 0.0001572323380969464778900146484375;
        _418 = _405 - _411;
        _419 = _413;
    }
    else
    {
        _417 = _404;
        _418 = _405;
        _419 = _406;
    }
    float _420 = _408 ? 6360.0146484375 : _407;
    float3 _920;
    float3 _921;
    if ((_420 <= 6430.0) && (_374 > 0.0))
    {
        float3 _427 = _419 + (_357 * _418);
        float _428 = length(_427);
        float _429 = dot(_357, View.View_AtmosphereLightDirection[0].xyz);
        float _431 = dot(_419, View.View_AtmosphereLightDirection[0].xyz) / _420;
        float _432 = 6360.0 / _420;
        float _435 = sqrt(1.0 - (_432 * _432));
        float _444;
        if (_378)
        {
            _444 = fast::max(_417, 0.1550000011920928955078125 - _435);
        }
        else
        {
            _444 = fast::max(_417, 0.004999999888241291046142578125 - _435);
        }
        float3 _465;
        float _466;
        float _467;
        if (_378)
        {
            float _447 = _357.z;
            float _451 = fast::clamp(exp(-_447) - 0.5, 0.0, 1.0);
            float3 _463;
            float _464;
            if (_451 < 1.0)
            {
                float3 _456 = _357;
                _456.z = fast::max(_447, 0.1500000059604644775390625);
                float3 _457 = normalize(_456);
                float3 _459 = _419 + (_457 * _418);
                _463 = _457;
                _464 = dot(_459, _457) / length(_459);
            }
            else
            {
                _463 = _357;
                _464 = _444;
            }
            _465 = _463;
            _466 = _451;
            _467 = _464;
        }
        else
        {
            _465 = _357;
            _466 = 0.0;
            _467 = _444;
        }
        float _469 = 1.0 + (_429 * _429);
        float _480 = _420 * _420;
        float _482 = sqrt(_480 - 40449600.0);
        float _483 = _420 * _467;
        float _486 = ((_483 * _483) - _480) + 40449600.0;
        float4 _491 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_483 < 0.0) && (_486 > 0.0)));
        float _494 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _495 = 0.5 / _494;
        float _498 = 1.0 - (1.0 / _494);
        float _500 = _495 + ((_482 * 0.00105685577727854251861572265625) * _498);
        float _512 = _491.w + ((((_483 * _491.x) + sqrt(_486 + _491.y)) / (_482 + _491.z)) * 0.4921875);
        float _521 = (_429 + 1.0) * 3.5;
        float _522 = floor(_521);
        float _523 = _521 - _522;
        float _524 = _522 + (0.015625 + (((atan(fast::max(_431, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _525 = _524 * 0.125;
        float _529 = 1.0 - _523;
        float _532 = (_524 + 1.0) * 0.125;
        float4 _538 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_525, _512, _500), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_532, _512, _500), level(0.0)) * _523), float4(0.0));
        float3 _904;
        float4 _905;
        if (_418 > 0.0)
        {
            float2 _549 = float2(_467, _467 + (_418 / _420));
            float2 _550 = _549 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _420);
            float2 _553 = float2(int2(sign(_550)));
            float2 _554 = _550 * _550;
            float _570 = 2.0 * _420;
            float _572 = (_418 / _570) + _467;
            float _580 = 6360.0 - _420;
            float2 _590 = _549 * sqrt(0.4166666567325592041015625 * _420);
            float2 _593 = float2(int2(sign(_590)));
            float2 _594 = _590 * _590;
            float3 _623 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _420) * exp(_580 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_553.y > _553.x) ? exp(_554.x) : 0.0) + dot((_553 / ((abs(_550) * 2.3192999362945556640625) + sqrt((_554 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_418) / View.View_AtmosphericFogHeightScaleRayleigh) * _572)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _420) * exp(_580 * 0.833333313465118408203125)) * (((_593.y > _593.x) ? exp(_594.x) : 0.0) + dot((_593 / ((abs(_590) * 2.3192999362945556640625) + sqrt((_594 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_418 * (-0.833333313465118408203125)) * _572)), float2(1.0, -1.0))))));
            float _631;
            if (_378)
            {
                _631 = fast::max(_428, _420);
            }
            else
            {
                _631 = _428;
            }
            float4 _903;
            if (_631 > 6360.009765625)
            {
                float4 _902;
                if (_466 < 1.0)
                {
                    float4 _642 = _623.xyzx;
                    float _643 = _631 * _631;
                    float _645 = sqrt(_643 - 40449600.0);
                    float _646 = _631 * (dot(_427, _465) / _428);
                    float _649 = ((_646 * _646) - _643) + 40449600.0;
                    float4 _654 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_646 < 0.0) && (_649 > 0.0)));
                    float _657 = _495 + ((_645 * 0.00105685577727854251861572265625) * _498);
                    float _669 = _654.w + ((((_646 * _654.x) + sqrt(_649 + _654.y)) / (_645 + _654.z)) * 0.4921875);
                    float _677 = _522 + (0.015625 + (((atan(fast::max(dot(_427, View.View_AtmosphereLightDirection[0].xyz) / _428, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _678 = _677 * 0.125;
                    float _684 = (_677 + 1.0) * 0.125;
                    float4 _692 = fast::max(_538 - (_642 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_678, _669, _657), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _669, _657), level(0.0)) * _523))), float4(0.0));
                    float4 _901;
                    if (!_378)
                    {
                        float _736 = _467 - (-_435);
                        float4 _900;
                        if (abs(_736) < 0.004999999888241291046142578125)
                        {
                            float _743 = (-0.004999999888241291046142578125) - _435;
                            float _745 = _480 + (_418 * _418);
                            float _746 = _570 * _418;
                            float _749 = sqrt(_745 + (_746 * _743));
                            float _750 = _420 * _743;
                            float _753 = 0.004999999888241291046142578125 - _435;
                            float _757 = ((_750 * _750) - _480) + 40449600.0;
                            float4 _762 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_750 < 0.0) && (_757 > 0.0)));
                            float _774 = _762.w + ((((_750 * _762.x) + sqrt(_757 + _762.y)) / (_482 + _762.z)) * 0.4921875);
                            float _784 = _749 * _749;
                            float _786 = sqrt(_784 - 40449600.0);
                            float _787 = _749 * fast::max(_753, (_750 + _418) / _749);
                            float _790 = ((_787 * _787) - _784) + 40449600.0;
                            float4 _795 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_787 < 0.0) && (_790 > 0.0)));
                            float _798 = _495 + ((_786 * 0.00105685577727854251861572265625) * _498);
                            float _810 = _795.w + ((((_787 * _795.x) + sqrt(_790 + _795.y)) / (_786 + _795.z)) * 0.4921875);
                            float _825 = sqrt(_745 + (_746 * _753));
                            float _826 = _420 * _753;
                            float _832 = ((_826 * _826) - _480) + 40449600.0;
                            float4 _837 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_826 < 0.0) && (_832 > 0.0)));
                            float _849 = _837.w + ((((_826 * _837.x) + sqrt(_832 + _837.y)) / (_482 + _837.z)) * 0.4921875);
                            float _859 = _825 * _825;
                            float _861 = sqrt(_859 - 40449600.0);
                            float _862 = _825 * fast::max(_753, (_826 + _418) / _825);
                            float _865 = ((_862 * _862) - _859) + 40449600.0;
                            float4 _870 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_862 < 0.0) && (_865 > 0.0)));
                            float _873 = _495 + ((_861 * 0.00105685577727854251861572265625) * _498);
                            float _885 = _870.w + ((((_862 * _870.x) + sqrt(_865 + _870.y)) / (_861 + _870.z)) * 0.4921875);
                            _900 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_525, _774, _500), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_532, _774, _500), level(0.0)) * _523)) - (_642 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_678, _810, _798), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _810, _798), level(0.0)) * _523))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_525, _849, _500), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_532, _849, _500), level(0.0)) * _523)) - (_642 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_678, _885, _873), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_684, _885, _873), level(0.0)) * _523))), float4(0.0)), float4((_736 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _900 = _692;
                        }
                        _901 = _900;
                    }
                    else
                    {
                        float4 _735;
                        if (_466 > 0.0)
                        {
                            float _701 = _420 * _444;
                            float _704 = ((_701 * _701) - _480) + 40449600.0;
                            float4 _709 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_701 < 0.0) && (_704 > 0.0)));
                            float _721 = _709.w + ((((_701 * _709.x) + sqrt(_704 + _709.y)) / (_482 + _709.z)) * 0.4921875);
                            _735 = mix(_692, (float4(1.0) - _642) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_525, _721, _500), level(0.0)) * _529) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_532, _721, _500), level(0.0)) * _523), float4(0.0)), float4(_466));
                        }
                        else
                        {
                            _735 = _692;
                        }
                        _901 = _735;
                    }
                    _902 = _901;
                }
                else
                {
                    _902 = (float4(1.0) - _623.xyzx) * _538;
                }
                _903 = _902;
            }
            else
            {
                _903 = _538;
            }
            _904 = _623;
            _905 = _903;
        }
        else
        {
            _904 = float3(1.0);
            _905 = _538;
        }
        _920 = _904;
        _921 = fast::max((_905.xyz * (0.0596831031143665313720703125 * _469)) + ((((_905.xyz * (_905.w * smoothstep(0.0, 0.0199999995529651641845703125, _431))) / float3(fast::max(_905.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _429)), -1.5)) * _469) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _920 = float3(1.0);
        _921 = float3(0.0);
    }
    float3 _986;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _985;
        if (_389 > 0.0)
        {
            float3 _932 = _355 + (_357 * _389);
            float _933 = length(_932);
            float3 _935 = _932 / float3(_933);
            float _936 = dot(_935, View.View_AtmosphereLightDirection[0].xyz);
            float _938 = (_933 - 6360.0) * 0.014285714365541934967041015625;
            float3 _951 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_936 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_938)), level(0.0)).xyz, float3(0.0), bool3(_378));
            float3 _963 = ((_951 * fast::max(_936, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_936 + 0.20000000298023223876953125) * 0.833333313465118408203125, _938), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _983;
            if ((!_378) && true)
            {
                float3 _969 = normalize(View.View_AtmosphereLightDirection[0].xyz - _357);
                _983 = _963 + (_951 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_357, _969), 5.0))) * pow(fast::max(dot(_969, _935), 0.0), 150.0), 0.0));
            }
            else
            {
                _983 = _963;
            }
            _985 = _920 * _983;
        }
        else
        {
            _985 = float3(0.0);
        }
        _986 = _985;
    }
    else
    {
        _986 = float3(0.0);
    }
    float3 _1023;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1022;
        switch (0u)
        {
            default:
            {
                if (_389 > 0.0)
                {
                    _1022 = float3(0.0);
                    break;
                }
                else
                {
                    _1022 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_359 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_356 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_356 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_357, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1023 = _1022;
    }
    else
    {
        _1023 = float3(0.0);
    }
    float _1043 = mix(fast::clamp((_920.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _377);
    float4 _1047 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _388)) * ((_1023 + _986) + _921), _1043);
    float4 _1124;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1061 = (_338 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1067 = sqrt((fast::max(0.0, length(_1061) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1068 = _1067 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1075;
        if (_1068 < 0.707106769084930419921875)
        {
            _1075 = fast::clamp((_1068 * _1068) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1075 = 1.0;
        }
        float2 _1103;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1078 = normalize(_1061);
            float _1079 = _1078.z;
            float _1082 = sqrt(1.0 - (_1079 * _1079));
            float2 _1085 = _174;
            _1085.y = (_1079 * 0.5) + 0.5;
            float _1090 = acos(_1078.x / _1082);
            float2 _1095 = _1085;
            _1095.x = (((_1078.y / _1082) < 0.0) ? (6.283185482025146484375 - _1090) : _1090) * 0.15915493667125701904296875;
            _1103 = (_1095 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1103 = ((_302.xy / _302.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1108 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1103, _1067), level(0.0));
        float3 _1120 = _1047.xyz + (((_1108.xyz * _1075).xyz * View.View_OneOverPreExposure).xyz * _1043);
        float4 _1123 = float4(_1120.x, _1120.y, _1120.z, _172.w);
        _1123.w = _1043 * (1.0 - (_1075 * (1.0 - _1108.w)));
        _1124 = _1123;
    }
    else
    {
        _1124 = _1047;
    }
    out.out_var_TEXCOORD10_centroid = float4(_266[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_266[2], _230 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _254)].w);
    out_var_TEXCOORD0 = _337;
    out.out_var_TEXCOORD4 = float4(_325.x, _325.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _317;
    out.out_var_TEXCOORD7 = _1124;
    out.gl_Position = _302;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

