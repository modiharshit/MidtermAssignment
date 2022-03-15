

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

constant float3x3 _168 = {};
constant float4 _169 = {};
constant float2 _171 = {};

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

vertex Main_out Main_0000723e_26e97eda(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(2)]], const device type_StructuredBuffer_v4float& View_LightmapSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(2)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(3)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(4)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(5)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[2];
    constant uint& View_LightmapSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _220 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _221 = 2u * _220;
    float4 _226 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_221 + 1u)));
    float _227 = _226.w;
    float3 _228 = _226.xyz;
    float3 _230 = cross(_228, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_221)).xyz) * _227;
    float3x3 _233 = _168;
    _233[0] = cross(_230, _228) * _227;
    float3x3 _234 = _233;
    _234[1] = _230;
    float3x3 _235 = _234;
    _235[2] = _228;
    uint _236 = in.in_var_ATTRIBUTE13 * 36u;
    uint _239 = _236 + 1u;
    uint _242 = _236 + 2u;
    uint _245 = _236 + 3u;
    uint _251 = _236 + 4u;
    float3x3 _256 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz);
    _256[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _251)].x;
    float3x3 _259 = _256;
    _259[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _251)].y;
    float3x3 _262 = _259;
    _262[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _251)].z;
    float3x3 _263 = _262 * _235;
    float3 _273 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _276 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _239)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _277 = _273 + _276;
    float3 _280 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _242)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _281 = _277 + _280;
    float3 _283 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _245)].xyz + View.View_PreViewTranslation;
    float3 _284 = _281 + _283;
    float _285 = _284.x;
    float _286 = _284.y;
    float _287 = _284.z;
    float4 _288 = float4(_285, _286, _287, 1.0);
    float4 _289 = float4(_288.x, _288.y, _288.z, _288.w);
    float4 _290 = View.View_TranslatedWorldToClip * _289;
    uint _309 = as_type<uint>(View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _236 + 24u)].w) + LocalVF.LocalVF_LODLightmapDataIndex;
    uint _311 = (_309 * 15u) + 2u;
    float2 _317 = (LocalVF_VertexFetch_TexCoordBuffer.read(uint(((uint(LocalVF.LocalVF_VertexFetch_Parameters.y) * _220) + uint(LocalVF.LocalVF_VertexFetch_Parameters.z)))).xy * View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _311)].xy) + View_LightmapSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _311)].zw;
    float3 _329 = _288.xyz;
    float3 _330 = _329 - View.View_TranslatedWorldCameraOrigin;
    float _334 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _342 = View.View_TranslatedWorldCameraOrigin;
    _342.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _343 = _342 * _334;
    float3 _346 = _343;
    _346.z = _343.z + 6360.009765625;
    float _347 = length(_346);
    float3 _348 = normalize(_330);
    float _349 = dot(_346, _348);
    float _350 = _349 / _347;
    float _352 = (-_347) * _350;
    float _356 = (_347 * _347) * ((_350 * _350) - 1.0);
    float _361 = length(_330) * _334;
    float _365 = fast::max(0.0, _361 - View.View_AtmosphericFogStartDistance);
    float _368 = fast::min((_365 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _369 = _361 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _379;
    float _380;
    if (_369)
    {
        _379 = _368 * View.View_AtmosphericFogPower;
        _380 = fast::max(_361 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _379 = 1.0;
        _380 = _352 - sqrt(_356 + 40449600.0);
    }
    float _386 = _352 - sqrt(_356 + 41344900.0);
    bool _387 = _386 > 0.0;
    float _395;
    float _396;
    float3 _397;
    if (_387)
    {
        _395 = (_349 + _386) * 0.00015552098921034485101699829101562;
        _396 = _380 - _386;
        _397 = _346 + (_348 * _386);
    }
    else
    {
        _395 = _350;
        _396 = _380;
        _397 = _346;
    }
    float _398 = _387 ? 6430.0 : _347;
    bool _399 = _398 < 6360.0146484375;
    float _408;
    float _409;
    float3 _410;
    if (_399)
    {
        float _402 = 6360.0146484375 - _398;
        float3 _404 = _397 - (_348 * _402);
        _408 = dot(_404, _348) * 0.0001572323380969464778900146484375;
        _409 = _396 - _402;
        _410 = _404;
    }
    else
    {
        _408 = _395;
        _409 = _396;
        _410 = _397;
    }
    float _411 = _399 ? 6360.0146484375 : _398;
    float3 _911;
    float3 _912;
    if ((_411 <= 6430.0) && (_365 > 0.0))
    {
        float3 _418 = _410 + (_348 * _409);
        float _419 = length(_418);
        float _420 = dot(_348, View.View_AtmosphereLightDirection[0].xyz);
        float _422 = dot(_410, View.View_AtmosphereLightDirection[0].xyz) / _411;
        float _423 = 6360.0 / _411;
        float _426 = sqrt(1.0 - (_423 * _423));
        float _435;
        if (_369)
        {
            _435 = fast::max(_408, 0.1550000011920928955078125 - _426);
        }
        else
        {
            _435 = fast::max(_408, 0.004999999888241291046142578125 - _426);
        }
        float3 _456;
        float _457;
        float _458;
        if (_369)
        {
            float _438 = _348.z;
            float _442 = fast::clamp(exp(-_438) - 0.5, 0.0, 1.0);
            float3 _454;
            float _455;
            if (_442 < 1.0)
            {
                float3 _447 = _348;
                _447.z = fast::max(_438, 0.1500000059604644775390625);
                float3 _448 = normalize(_447);
                float3 _450 = _410 + (_448 * _409);
                _454 = _448;
                _455 = dot(_450, _448) / length(_450);
            }
            else
            {
                _454 = _348;
                _455 = _435;
            }
            _456 = _454;
            _457 = _442;
            _458 = _455;
        }
        else
        {
            _456 = _348;
            _457 = 0.0;
            _458 = _435;
        }
        float _460 = 1.0 + (_420 * _420);
        float _471 = _411 * _411;
        float _473 = sqrt(_471 - 40449600.0);
        float _474 = _411 * _458;
        float _477 = ((_474 * _474) - _471) + 40449600.0;
        float4 _482 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_474 < 0.0) && (_477 > 0.0)));
        float _485 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _486 = 0.5 / _485;
        float _489 = 1.0 - (1.0 / _485);
        float _491 = _486 + ((_473 * 0.00105685577727854251861572265625) * _489);
        float _503 = _482.w + ((((_474 * _482.x) + sqrt(_477 + _482.y)) / (_473 + _482.z)) * 0.4921875);
        float _512 = (_420 + 1.0) * 3.5;
        float _513 = floor(_512);
        float _514 = _512 - _513;
        float _515 = _513 + (0.015625 + (((atan(fast::max(_422, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _516 = _515 * 0.125;
        float _520 = 1.0 - _514;
        float _523 = (_515 + 1.0) * 0.125;
        float4 _529 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_516, _503, _491), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_523, _503, _491), level(0.0)) * _514), float4(0.0));
        float3 _895;
        float4 _896;
        if (_409 > 0.0)
        {
            float2 _540 = float2(_458, _458 + (_409 / _411));
            float2 _541 = _540 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _411);
            float2 _544 = float2(int2(sign(_541)));
            float2 _545 = _541 * _541;
            float _561 = 2.0 * _411;
            float _563 = (_409 / _561) + _458;
            float _571 = 6360.0 - _411;
            float2 _581 = _540 * sqrt(0.4166666567325592041015625 * _411);
            float2 _584 = float2(int2(sign(_581)));
            float2 _585 = _581 * _581;
            float3 _614 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _411) * exp(_571 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_544.y > _544.x) ? exp(_545.x) : 0.0) + dot((_544 / ((abs(_541) * 2.3192999362945556640625) + sqrt((_545 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_409) / View.View_AtmosphericFogHeightScaleRayleigh) * _563)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _411) * exp(_571 * 0.833333313465118408203125)) * (((_584.y > _584.x) ? exp(_585.x) : 0.0) + dot((_584 / ((abs(_581) * 2.3192999362945556640625) + sqrt((_585 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_409 * (-0.833333313465118408203125)) * _563)), float2(1.0, -1.0))))));
            float _622;
            if (_369)
            {
                _622 = fast::max(_419, _411);
            }
            else
            {
                _622 = _419;
            }
            float4 _894;
            if (_622 > 6360.009765625)
            {
                float4 _893;
                if (_457 < 1.0)
                {
                    float4 _633 = _614.xyzx;
                    float _634 = _622 * _622;
                    float _636 = sqrt(_634 - 40449600.0);
                    float _637 = _622 * (dot(_418, _456) / _419);
                    float _640 = ((_637 * _637) - _634) + 40449600.0;
                    float4 _645 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_637 < 0.0) && (_640 > 0.0)));
                    float _648 = _486 + ((_636 * 0.00105685577727854251861572265625) * _489);
                    float _660 = _645.w + ((((_637 * _645.x) + sqrt(_640 + _645.y)) / (_636 + _645.z)) * 0.4921875);
                    float _668 = _513 + (0.015625 + (((atan(fast::max(dot(_418, View.View_AtmosphereLightDirection[0].xyz) / _419, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _669 = _668 * 0.125;
                    float _675 = (_668 + 1.0) * 0.125;
                    float4 _683 = fast::max(_529 - (_633 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_669, _660, _648), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _660, _648), level(0.0)) * _514))), float4(0.0));
                    float4 _892;
                    if (!_369)
                    {
                        float _727 = _458 - (-_426);
                        float4 _891;
                        if (abs(_727) < 0.004999999888241291046142578125)
                        {
                            float _734 = (-0.004999999888241291046142578125) - _426;
                            float _736 = _471 + (_409 * _409);
                            float _737 = _561 * _409;
                            float _740 = sqrt(_736 + (_737 * _734));
                            float _741 = _411 * _734;
                            float _744 = 0.004999999888241291046142578125 - _426;
                            float _748 = ((_741 * _741) - _471) + 40449600.0;
                            float4 _753 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_741 < 0.0) && (_748 > 0.0)));
                            float _765 = _753.w + ((((_741 * _753.x) + sqrt(_748 + _753.y)) / (_473 + _753.z)) * 0.4921875);
                            float _775 = _740 * _740;
                            float _777 = sqrt(_775 - 40449600.0);
                            float _778 = _740 * fast::max(_744, (_741 + _409) / _740);
                            float _781 = ((_778 * _778) - _775) + 40449600.0;
                            float4 _786 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_778 < 0.0) && (_781 > 0.0)));
                            float _789 = _486 + ((_777 * 0.00105685577727854251861572265625) * _489);
                            float _801 = _786.w + ((((_778 * _786.x) + sqrt(_781 + _786.y)) / (_777 + _786.z)) * 0.4921875);
                            float _816 = sqrt(_736 + (_737 * _744));
                            float _817 = _411 * _744;
                            float _823 = ((_817 * _817) - _471) + 40449600.0;
                            float4 _828 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_817 < 0.0) && (_823 > 0.0)));
                            float _840 = _828.w + ((((_817 * _828.x) + sqrt(_823 + _828.y)) / (_473 + _828.z)) * 0.4921875);
                            float _850 = _816 * _816;
                            float _852 = sqrt(_850 - 40449600.0);
                            float _853 = _816 * fast::max(_744, (_817 + _409) / _816);
                            float _856 = ((_853 * _853) - _850) + 40449600.0;
                            float4 _861 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_853 < 0.0) && (_856 > 0.0)));
                            float _864 = _486 + ((_852 * 0.00105685577727854251861572265625) * _489);
                            float _876 = _861.w + ((((_853 * _861.x) + sqrt(_856 + _861.y)) / (_852 + _861.z)) * 0.4921875);
                            _891 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_516, _765, _491), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_523, _765, _491), level(0.0)) * _514)) - (_633 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_669, _801, _789), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _801, _789), level(0.0)) * _514))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_516, _840, _491), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_523, _840, _491), level(0.0)) * _514)) - (_633 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_669, _876, _864), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_675, _876, _864), level(0.0)) * _514))), float4(0.0)), float4((_727 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _891 = _683;
                        }
                        _892 = _891;
                    }
                    else
                    {
                        float4 _726;
                        if (_457 > 0.0)
                        {
                            float _692 = _411 * _435;
                            float _695 = ((_692 * _692) - _471) + 40449600.0;
                            float4 _700 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_692 < 0.0) && (_695 > 0.0)));
                            float _712 = _700.w + ((((_692 * _700.x) + sqrt(_695 + _700.y)) / (_473 + _700.z)) * 0.4921875);
                            _726 = mix(_683, (float4(1.0) - _633) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_516, _712, _491), level(0.0)) * _520) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_523, _712, _491), level(0.0)) * _514), float4(0.0)), float4(_457));
                        }
                        else
                        {
                            _726 = _683;
                        }
                        _892 = _726;
                    }
                    _893 = _892;
                }
                else
                {
                    _893 = (float4(1.0) - _614.xyzx) * _529;
                }
                _894 = _893;
            }
            else
            {
                _894 = _529;
            }
            _895 = _614;
            _896 = _894;
        }
        else
        {
            _895 = float3(1.0);
            _896 = _529;
        }
        _911 = _895;
        _912 = fast::max((_896.xyz * (0.0596831031143665313720703125 * _460)) + ((((_896.xyz * (_896.w * smoothstep(0.0, 0.0199999995529651641845703125, _422))) / float3(fast::max(_896.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _420)), -1.5)) * _460) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _911 = float3(1.0);
        _912 = float3(0.0);
    }
    float3 _977;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _976;
        if (_380 > 0.0)
        {
            float3 _923 = _346 + (_348 * _380);
            float _924 = length(_923);
            float3 _926 = _923 / float3(_924);
            float _927 = dot(_926, View.View_AtmosphereLightDirection[0].xyz);
            float _929 = (_924 - 6360.0) * 0.014285714365541934967041015625;
            float3 _942 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_927 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_929)), level(0.0)).xyz, float3(0.0), bool3(_369));
            float3 _954 = ((_942 * fast::max(_927, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_927 + 0.20000000298023223876953125) * 0.833333313465118408203125, _929), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _974;
            if ((!_369) && true)
            {
                float3 _960 = normalize(View.View_AtmosphereLightDirection[0].xyz - _348);
                _974 = _954 + (_942 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_348, _960), 5.0))) * pow(fast::max(dot(_960, _926), 0.0), 150.0), 0.0));
            }
            else
            {
                _974 = _954;
            }
            _976 = _911 * _974;
        }
        else
        {
            _976 = float3(0.0);
        }
        _977 = _976;
    }
    else
    {
        _977 = float3(0.0);
    }
    float3 _1014;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1013;
        switch (0u)
        {
            default:
            {
                if (_380 > 0.0)
                {
                    _1013 = float3(0.0);
                    break;
                }
                else
                {
                    _1013 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_350 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_347 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_347 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_348, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1014 = _1013;
    }
    else
    {
        _1014 = float3(0.0);
    }
    float _1034 = mix(fast::clamp((_911.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _368);
    float4 _1038 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _379)) * ((_1014 + _977) + _912), _1034);
    float4 _1115;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1052 = (_329 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1058 = sqrt((fast::max(0.0, length(_1052) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1059 = _1058 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1066;
        if (_1059 < 0.707106769084930419921875)
        {
            _1066 = fast::clamp((_1059 * _1059) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1066 = 1.0;
        }
        float2 _1094;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1069 = normalize(_1052);
            float _1070 = _1069.z;
            float _1073 = sqrt(1.0 - (_1070 * _1070));
            float2 _1076 = _171;
            _1076.y = (_1070 * 0.5) + 0.5;
            float _1081 = acos(_1069.x / _1073);
            float2 _1086 = _1076;
            _1086.x = (((_1069.y / _1073) < 0.0) ? (6.283185482025146484375 - _1081) : _1081) * 0.15915493667125701904296875;
            _1094 = (_1086 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1094 = ((_290.xy / _290.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1099 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1094, _1058), level(0.0));
        float3 _1111 = _1038.xyz + (((_1099.xyz * _1066).xyz * View.View_OneOverPreExposure).xyz * _1034);
        float4 _1114 = float4(_1111.x, _1111.y, _1111.z, _169.w);
        _1114.w = _1034 * (1.0 - (_1066 * (1.0 - _1099.w)));
        _1115 = _1114;
    }
    else
    {
        _1115 = _1038;
    }
    out.out_var_TEXCOORD10_centroid = float4(_263[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_263[2], _227 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(2, spvBufferSizeConstants, float4, _251)].w);
    out.out_var_TEXCOORD4 = float4(_317.x, _317.y, float2(0.0).x, float2(0.0).y);
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_LIGHTMAP_ID = _309;
    out.out_var_TEXCOORD7 = _1115;
    out.gl_Position = _290;
    return out;
}

