

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

constant float3x3 _159 = {};
constant float4 _160 = {};
constant float2 _162 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    uint out_var_PRIMITIVE_ID [[user(locn2)]];
    float4 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE13 [[attribute(13)]];
};

// Returns buffer coords clamped to storage buffer size
#define spvStorageBufferCoords(idx, sizes, type, coord) metal::min((coord), (sizes[(idx)*2] / sizeof(type)) - 1)

vertex Main_out Main_00006da7_a258cfa3(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _214 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _219 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_214 + 1u)));
    float _220 = _219.w;
    float3 _221 = _219.xyz;
    float3 _223 = cross(_221, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_214)).xyz) * _220;
    float3x3 _226 = _159;
    _226[0] = cross(_223, _221) * _220;
    float3x3 _227 = _226;
    _227[1] = _223;
    float3x3 _228 = _227;
    _228[2] = _221;
    uint _229 = in.in_var_ATTRIBUTE13 * 36u;
    uint _232 = _229 + 1u;
    uint _235 = _229 + 2u;
    uint _238 = _229 + 3u;
    uint _244 = _229 + 4u;
    float3x3 _249 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _229)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _232)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _235)].xyz);
    _249[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _229)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _244)].x;
    float3x3 _252 = _249;
    _252[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _232)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _244)].y;
    float3x3 _255 = _252;
    _255[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _235)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _244)].z;
    float3x3 _256 = _255 * _228;
    float3 _266 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _229)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _269 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _232)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _270 = _266 + _269;
    float3 _273 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _235)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _274 = _270 + _273;
    float3 _276 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _238)].xyz + View.View_PreViewTranslation;
    float3 _277 = _274 + _276;
    float _278 = _277.x;
    float _279 = _277.y;
    float _280 = _277.z;
    float4 _281 = float4(_278, _279, _280, 1.0);
    float4 _282 = float4(_281.x, _281.y, _281.z, _281.w);
    float4 _283 = View.View_TranslatedWorldToClip * _282;
    float3 _294 = _281.xyz;
    float3 _295 = _294 - View.View_TranslatedWorldCameraOrigin;
    float _299 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _307 = View.View_TranslatedWorldCameraOrigin;
    _307.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _308 = _307 * _299;
    float3 _311 = _308;
    _311.z = _308.z + 6360.009765625;
    float _312 = length(_311);
    float3 _313 = normalize(_295);
    float _314 = dot(_311, _313);
    float _315 = _314 / _312;
    float _317 = (-_312) * _315;
    float _321 = (_312 * _312) * ((_315 * _315) - 1.0);
    float _326 = length(_295) * _299;
    float _330 = fast::max(0.0, _326 - View.View_AtmosphericFogStartDistance);
    float _333 = fast::min((_330 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _334 = _326 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _344;
    float _345;
    if (_334)
    {
        _344 = _333 * View.View_AtmosphericFogPower;
        _345 = fast::max(_326 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _344 = 1.0;
        _345 = _317 - sqrt(_321 + 40449600.0);
    }
    float _351 = _317 - sqrt(_321 + 41344900.0);
    bool _352 = _351 > 0.0;
    float _360;
    float _361;
    float3 _362;
    if (_352)
    {
        _360 = (_314 + _351) * 0.00015552098921034485101699829101562;
        _361 = _345 - _351;
        _362 = _311 + (_313 * _351);
    }
    else
    {
        _360 = _315;
        _361 = _345;
        _362 = _311;
    }
    float _363 = _352 ? 6430.0 : _312;
    bool _364 = _363 < 6360.0146484375;
    float _373;
    float _374;
    float3 _375;
    if (_364)
    {
        float _367 = 6360.0146484375 - _363;
        float3 _369 = _362 - (_313 * _367);
        _373 = dot(_369, _313) * 0.0001572323380969464778900146484375;
        _374 = _361 - _367;
        _375 = _369;
    }
    else
    {
        _373 = _360;
        _374 = _361;
        _375 = _362;
    }
    float _376 = _364 ? 6360.0146484375 : _363;
    float3 _876;
    float3 _877;
    if ((_376 <= 6430.0) && (_330 > 0.0))
    {
        float3 _383 = _375 + (_313 * _374);
        float _384 = length(_383);
        float _385 = dot(_313, View.View_AtmosphereLightDirection[0].xyz);
        float _387 = dot(_375, View.View_AtmosphereLightDirection[0].xyz) / _376;
        float _388 = 6360.0 / _376;
        float _391 = sqrt(1.0 - (_388 * _388));
        float _400;
        if (_334)
        {
            _400 = fast::max(_373, 0.1550000011920928955078125 - _391);
        }
        else
        {
            _400 = fast::max(_373, 0.004999999888241291046142578125 - _391);
        }
        float3 _421;
        float _422;
        float _423;
        if (_334)
        {
            float _403 = _313.z;
            float _407 = fast::clamp(exp(-_403) - 0.5, 0.0, 1.0);
            float3 _419;
            float _420;
            if (_407 < 1.0)
            {
                float3 _412 = _313;
                _412.z = fast::max(_403, 0.1500000059604644775390625);
                float3 _413 = normalize(_412);
                float3 _415 = _375 + (_413 * _374);
                _419 = _413;
                _420 = dot(_415, _413) / length(_415);
            }
            else
            {
                _419 = _313;
                _420 = _400;
            }
            _421 = _419;
            _422 = _407;
            _423 = _420;
        }
        else
        {
            _421 = _313;
            _422 = 0.0;
            _423 = _400;
        }
        float _425 = 1.0 + (_385 * _385);
        float _436 = _376 * _376;
        float _438 = sqrt(_436 - 40449600.0);
        float _439 = _376 * _423;
        float _442 = ((_439 * _439) - _436) + 40449600.0;
        float4 _447 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_439 < 0.0) && (_442 > 0.0)));
        float _450 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _451 = 0.5 / _450;
        float _454 = 1.0 - (1.0 / _450);
        float _456 = _451 + ((_438 * 0.00105685577727854251861572265625) * _454);
        float _468 = _447.w + ((((_439 * _447.x) + sqrt(_442 + _447.y)) / (_438 + _447.z)) * 0.4921875);
        float _477 = (_385 + 1.0) * 3.5;
        float _478 = floor(_477);
        float _479 = _477 - _478;
        float _480 = _478 + (0.015625 + (((atan(fast::max(_387, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _481 = _480 * 0.125;
        float _485 = 1.0 - _479;
        float _488 = (_480 + 1.0) * 0.125;
        float4 _494 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_481, _468, _456), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _468, _456), level(0.0)) * _479), float4(0.0));
        float3 _860;
        float4 _861;
        if (_374 > 0.0)
        {
            float2 _505 = float2(_423, _423 + (_374 / _376));
            float2 _506 = _505 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _376);
            float2 _509 = float2(int2(sign(_506)));
            float2 _510 = _506 * _506;
            float _526 = 2.0 * _376;
            float _528 = (_374 / _526) + _423;
            float _536 = 6360.0 - _376;
            float2 _546 = _505 * sqrt(0.4166666567325592041015625 * _376);
            float2 _549 = float2(int2(sign(_546)));
            float2 _550 = _546 * _546;
            float3 _579 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _376) * exp(_536 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_509.y > _509.x) ? exp(_510.x) : 0.0) + dot((_509 / ((abs(_506) * 2.3192999362945556640625) + sqrt((_510 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_374) / View.View_AtmosphericFogHeightScaleRayleigh) * _528)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _376) * exp(_536 * 0.833333313465118408203125)) * (((_549.y > _549.x) ? exp(_550.x) : 0.0) + dot((_549 / ((abs(_546) * 2.3192999362945556640625) + sqrt((_550 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_374 * (-0.833333313465118408203125)) * _528)), float2(1.0, -1.0))))));
            float _587;
            if (_334)
            {
                _587 = fast::max(_384, _376);
            }
            else
            {
                _587 = _384;
            }
            float4 _859;
            if (_587 > 6360.009765625)
            {
                float4 _858;
                if (_422 < 1.0)
                {
                    float4 _598 = _579.xyzx;
                    float _599 = _587 * _587;
                    float _601 = sqrt(_599 - 40449600.0);
                    float _602 = _587 * (dot(_383, _421) / _384);
                    float _605 = ((_602 * _602) - _599) + 40449600.0;
                    float4 _610 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_602 < 0.0) && (_605 > 0.0)));
                    float _613 = _451 + ((_601 * 0.00105685577727854251861572265625) * _454);
                    float _625 = _610.w + ((((_602 * _610.x) + sqrt(_605 + _610.y)) / (_601 + _610.z)) * 0.4921875);
                    float _633 = _478 + (0.015625 + (((atan(fast::max(dot(_383, View.View_AtmosphereLightDirection[0].xyz) / _384, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _634 = _633 * 0.125;
                    float _640 = (_633 + 1.0) * 0.125;
                    float4 _648 = fast::max(_494 - (_598 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_634, _625, _613), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_640, _625, _613), level(0.0)) * _479))), float4(0.0));
                    float4 _857;
                    if (!_334)
                    {
                        float _692 = _423 - (-_391);
                        float4 _856;
                        if (abs(_692) < 0.004999999888241291046142578125)
                        {
                            float _699 = (-0.004999999888241291046142578125) - _391;
                            float _701 = _436 + (_374 * _374);
                            float _702 = _526 * _374;
                            float _705 = sqrt(_701 + (_702 * _699));
                            float _706 = _376 * _699;
                            float _709 = 0.004999999888241291046142578125 - _391;
                            float _713 = ((_706 * _706) - _436) + 40449600.0;
                            float4 _718 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_706 < 0.0) && (_713 > 0.0)));
                            float _730 = _718.w + ((((_706 * _718.x) + sqrt(_713 + _718.y)) / (_438 + _718.z)) * 0.4921875);
                            float _740 = _705 * _705;
                            float _742 = sqrt(_740 - 40449600.0);
                            float _743 = _705 * fast::max(_709, (_706 + _374) / _705);
                            float _746 = ((_743 * _743) - _740) + 40449600.0;
                            float4 _751 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_743 < 0.0) && (_746 > 0.0)));
                            float _754 = _451 + ((_742 * 0.00105685577727854251861572265625) * _454);
                            float _766 = _751.w + ((((_743 * _751.x) + sqrt(_746 + _751.y)) / (_742 + _751.z)) * 0.4921875);
                            float _781 = sqrt(_701 + (_702 * _709));
                            float _782 = _376 * _709;
                            float _788 = ((_782 * _782) - _436) + 40449600.0;
                            float4 _793 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_782 < 0.0) && (_788 > 0.0)));
                            float _805 = _793.w + ((((_782 * _793.x) + sqrt(_788 + _793.y)) / (_438 + _793.z)) * 0.4921875);
                            float _815 = _781 * _781;
                            float _817 = sqrt(_815 - 40449600.0);
                            float _818 = _781 * fast::max(_709, (_782 + _374) / _781);
                            float _821 = ((_818 * _818) - _815) + 40449600.0;
                            float4 _826 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_818 < 0.0) && (_821 > 0.0)));
                            float _829 = _451 + ((_817 * 0.00105685577727854251861572265625) * _454);
                            float _841 = _826.w + ((((_818 * _826.x) + sqrt(_821 + _826.y)) / (_817 + _826.z)) * 0.4921875);
                            _856 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_481, _730, _456), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _730, _456), level(0.0)) * _479)) - (_598 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_634, _766, _754), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_640, _766, _754), level(0.0)) * _479))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_481, _805, _456), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _805, _456), level(0.0)) * _479)) - (_598 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_634, _841, _829), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_640, _841, _829), level(0.0)) * _479))), float4(0.0)), float4((_692 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _856 = _648;
                        }
                        _857 = _856;
                    }
                    else
                    {
                        float4 _691;
                        if (_422 > 0.0)
                        {
                            float _657 = _376 * _400;
                            float _660 = ((_657 * _657) - _436) + 40449600.0;
                            float4 _665 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_657 < 0.0) && (_660 > 0.0)));
                            float _677 = _665.w + ((((_657 * _665.x) + sqrt(_660 + _665.y)) / (_438 + _665.z)) * 0.4921875);
                            _691 = mix(_648, (float4(1.0) - _598) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_481, _677, _456), level(0.0)) * _485) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _677, _456), level(0.0)) * _479), float4(0.0)), float4(_422));
                        }
                        else
                        {
                            _691 = _648;
                        }
                        _857 = _691;
                    }
                    _858 = _857;
                }
                else
                {
                    _858 = (float4(1.0) - _579.xyzx) * _494;
                }
                _859 = _858;
            }
            else
            {
                _859 = _494;
            }
            _860 = _579;
            _861 = _859;
        }
        else
        {
            _860 = float3(1.0);
            _861 = _494;
        }
        _876 = _860;
        _877 = fast::max((_861.xyz * (0.0596831031143665313720703125 * _425)) + ((((_861.xyz * (_861.w * smoothstep(0.0, 0.0199999995529651641845703125, _387))) / float3(fast::max(_861.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _385)), -1.5)) * _425) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _876 = float3(1.0);
        _877 = float3(0.0);
    }
    float3 _942;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _941;
        if (_345 > 0.0)
        {
            float3 _888 = _311 + (_313 * _345);
            float _889 = length(_888);
            float3 _891 = _888 / float3(_889);
            float _892 = dot(_891, View.View_AtmosphereLightDirection[0].xyz);
            float _894 = (_889 - 6360.0) * 0.014285714365541934967041015625;
            float3 _907 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_892 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_894)), level(0.0)).xyz, float3(0.0), bool3(_334));
            float3 _919 = ((_907 * fast::max(_892, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_892 + 0.20000000298023223876953125) * 0.833333313465118408203125, _894), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _939;
            if ((!_334) && true)
            {
                float3 _925 = normalize(View.View_AtmosphereLightDirection[0].xyz - _313);
                _939 = _919 + (_907 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_313, _925), 5.0))) * pow(fast::max(dot(_925, _891), 0.0), 150.0), 0.0));
            }
            else
            {
                _939 = _919;
            }
            _941 = _876 * _939;
        }
        else
        {
            _941 = float3(0.0);
        }
        _942 = _941;
    }
    else
    {
        _942 = float3(0.0);
    }
    float3 _979;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _978;
        switch (0u)
        {
            default:
            {
                if (_345 > 0.0)
                {
                    _978 = float3(0.0);
                    break;
                }
                else
                {
                    _978 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_315 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_312 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_312 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_313, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _979 = _978;
    }
    else
    {
        _979 = float3(0.0);
    }
    float _999 = mix(fast::clamp((_876.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _333);
    float4 _1003 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _344)) * ((_979 + _942) + _877), _999);
    float4 _1080;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1017 = (_294 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1023 = sqrt((fast::max(0.0, length(_1017) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1024 = _1023 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1031;
        if (_1024 < 0.707106769084930419921875)
        {
            _1031 = fast::clamp((_1024 * _1024) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1031 = 1.0;
        }
        float2 _1059;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1034 = normalize(_1017);
            float _1035 = _1034.z;
            float _1038 = sqrt(1.0 - (_1035 * _1035));
            float2 _1041 = _162;
            _1041.y = (_1035 * 0.5) + 0.5;
            float _1046 = acos(_1034.x / _1038);
            float2 _1051 = _1041;
            _1051.x = (((_1034.y / _1038) < 0.0) ? (6.283185482025146484375 - _1046) : _1046) * 0.15915493667125701904296875;
            _1059 = (_1051 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1059 = ((_283.xy / _283.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1064 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1059, _1023), level(0.0));
        float3 _1076 = _1003.xyz + (((_1064.xyz * _1031).xyz * View.View_OneOverPreExposure).xyz * _999);
        float4 _1079 = float4(_1076.x, _1076.y, _1076.z, _160.w);
        _1079.w = _999 * (1.0 - (_1031 * (1.0 - _1064.w)));
        _1080 = _1079;
    }
    else
    {
        _1080 = _1003;
    }
    out.out_var_TEXCOORD10_centroid = float4(_256[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_256[2], _220 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _244)].w);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _1080;
    out.gl_Position = _283;
    return out;
}

