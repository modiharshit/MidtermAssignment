

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

constant float3x3 _167 = {};
constant float4 _168 = {};
constant float2 _170 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_COLOR0 [[user(locn2)]];
    float4 out_var_TEXCOORD0_0 [[user(locn3)]];
    uint out_var_PRIMITIVE_ID [[user(locn4)]];
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

vertex Main_out Main_00007151_df1ac578(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(6)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(3)]], constant type_View& View [[buffer(4)]], constant type_LocalVF& LocalVF [[buffer(5)]], texture_buffer<float> LocalVF_VertexFetch_TexCoordBuffer [[texture(0)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(1)]], texture_buffer<float> LocalVF_VertexFetch_ColorComponentsBuffer [[texture(2)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(3)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(4)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(5)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(6)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[3];
    uint _221 = uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex);
    uint _229 = 2u * _221;
    float4 _234 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_229 + 1u)));
    float _235 = _234.w;
    float3 _236 = _234.xyz;
    float3 _238 = cross(_236, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_229)).xyz) * _235;
    float3x3 _241 = _167;
    _241[0] = cross(_238, _236) * _235;
    float3x3 _242 = _241;
    _242[1] = _238;
    float3x3 _243 = _242;
    _243[2] = _236;
    uint _244 = in.in_var_ATTRIBUTE13 * 36u;
    uint _247 = _244 + 1u;
    uint _250 = _244 + 2u;
    uint _253 = _244 + 3u;
    uint _259 = _244 + 4u;
    float3x3 _264 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _244)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _247)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _250)].xyz);
    _264[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _244)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _259)].x;
    float3x3 _267 = _264;
    _267[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _247)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _259)].y;
    float3x3 _270 = _267;
    _270[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _250)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _259)].z;
    float3x3 _271 = _270 * _243;
    float3 _281 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _244)].xyz * in.in_var_ATTRIBUTE0.xxx;
    float3 _284 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _247)].xyz * in.in_var_ATTRIBUTE0.yyy;
    float3 _285 = _281 + _284;
    float3 _288 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _250)].xyz * in.in_var_ATTRIBUTE0.zzz;
    float3 _289 = _285 + _288;
    float3 _291 = View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _253)].xyz + View.View_PreViewTranslation;
    float3 _292 = _289 + _291;
    float _293 = _292.x;
    float _294 = _292.y;
    float _295 = _292.z;
    float4 _296 = float4(_293, _294, _295, 1.0);
    uint _299 = uint(LocalVF.LocalVF_VertexFetch_Parameters.y);
    float4 _305 = LocalVF_VertexFetch_TexCoordBuffer.read(uint(((_299 * _221) + min(0u, (_299 - 1u)))));
    float4 _306 = float4(_296.x, _296.y, _296.z, _296.w);
    float4 _307 = View.View_TranslatedWorldToClip * _306;
    spvUnsafeArray<float4, 1> _319 = { float4(_305.x, _305.y, float4(0.0).z, float4(0.0).w) };
    float3 _320 = _296.xyz;
    float3 _321 = _320 - View.View_TranslatedWorldCameraOrigin;
    float _325 = 9.9999997473787516355514526367188e-06 * View.View_AtmosphericFogDistanceScale;
    float3 _333 = View.View_TranslatedWorldCameraOrigin;
    _333.z = (View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset) * View.View_AtmosphericFogAltitudeScale;
    float3 _334 = _333 * _325;
    float3 _337 = _334;
    _337.z = _334.z + 6360.009765625;
    float _338 = length(_337);
    float3 _339 = normalize(_321);
    float _340 = dot(_337, _339);
    float _341 = _340 / _338;
    float _343 = (-_338) * _341;
    float _347 = (_338 * _338) * ((_341 * _341) - 1.0);
    float _352 = length(_321) * _325;
    float _356 = fast::max(0.0, _352 - View.View_AtmosphericFogStartDistance);
    float _359 = fast::min((_356 * 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _360 = _352 < (100.0 * View.View_AtmosphericFogDistanceScale);
    float _370;
    float _371;
    if (_360)
    {
        _370 = _359 * View.View_AtmosphericFogPower;
        _371 = fast::max(_352 + View.View_AtmosphericFogDistanceOffset, 1.0);
    }
    else
    {
        _370 = 1.0;
        _371 = _343 - sqrt(_347 + 40449600.0);
    }
    float _377 = _343 - sqrt(_347 + 41344900.0);
    bool _378 = _377 > 0.0;
    float _386;
    float _387;
    float3 _388;
    if (_378)
    {
        _386 = (_340 + _377) * 0.00015552098921034485101699829101562;
        _387 = _371 - _377;
        _388 = _337 + (_339 * _377);
    }
    else
    {
        _386 = _341;
        _387 = _371;
        _388 = _337;
    }
    float _389 = _378 ? 6430.0 : _338;
    bool _390 = _389 < 6360.0146484375;
    float _399;
    float _400;
    float3 _401;
    if (_390)
    {
        float _393 = 6360.0146484375 - _389;
        float3 _395 = _388 - (_339 * _393);
        _399 = dot(_395, _339) * 0.0001572323380969464778900146484375;
        _400 = _387 - _393;
        _401 = _395;
    }
    else
    {
        _399 = _386;
        _400 = _387;
        _401 = _388;
    }
    float _402 = _390 ? 6360.0146484375 : _389;
    float3 _902;
    float3 _903;
    if ((_402 <= 6430.0) && (_356 > 0.0))
    {
        float3 _409 = _401 + (_339 * _400);
        float _410 = length(_409);
        float _411 = dot(_339, View.View_AtmosphereLightDirection[0].xyz);
        float _413 = dot(_401, View.View_AtmosphereLightDirection[0].xyz) / _402;
        float _414 = 6360.0 / _402;
        float _417 = sqrt(1.0 - (_414 * _414));
        float _426;
        if (_360)
        {
            _426 = fast::max(_399, 0.1550000011920928955078125 - _417);
        }
        else
        {
            _426 = fast::max(_399, 0.004999999888241291046142578125 - _417);
        }
        float3 _447;
        float _448;
        float _449;
        if (_360)
        {
            float _429 = _339.z;
            float _433 = fast::clamp(exp(-_429) - 0.5, 0.0, 1.0);
            float3 _445;
            float _446;
            if (_433 < 1.0)
            {
                float3 _438 = _339;
                _438.z = fast::max(_429, 0.1500000059604644775390625);
                float3 _439 = normalize(_438);
                float3 _441 = _401 + (_439 * _400);
                _445 = _439;
                _446 = dot(_441, _439) / length(_441);
            }
            else
            {
                _445 = _339;
                _446 = _426;
            }
            _447 = _445;
            _448 = _433;
            _449 = _446;
        }
        else
        {
            _447 = _339;
            _448 = 0.0;
            _449 = _426;
        }
        float _451 = 1.0 + (_411 * _411);
        float _462 = _402 * _402;
        float _464 = sqrt(_462 - 40449600.0);
        float _465 = _402 * _449;
        float _468 = ((_465 * _465) - _462) + 40449600.0;
        float4 _473 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_465 < 0.0) && (_468 > 0.0)));
        float _476 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _477 = 0.5 / _476;
        float _480 = 1.0 - (1.0 / _476);
        float _482 = _477 + ((_464 * 0.00105685577727854251861572265625) * _480);
        float _494 = _473.w + ((((_465 * _473.x) + sqrt(_468 + _473.y)) / (_464 + _473.z)) * 0.4921875);
        float _503 = (_411 + 1.0) * 3.5;
        float _504 = floor(_503);
        float _505 = _503 - _504;
        float _506 = _504 + (0.015625 + (((atan(fast::max(_413, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
        float _507 = _506 * 0.125;
        float _511 = 1.0 - _505;
        float _514 = (_506 + 1.0) * 0.125;
        float4 _520 = fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_507, _494, _482), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_514, _494, _482), level(0.0)) * _505), float4(0.0));
        float3 _886;
        float4 _887;
        if (_400 > 0.0)
        {
            float2 _531 = float2(_449, _449 + (_400 / _402));
            float2 _532 = _531 * sqrt((0.5 / View.View_AtmosphericFogHeightScaleRayleigh) * _402);
            float2 _535 = float2(int2(sign(_532)));
            float2 _536 = _532 * _532;
            float _552 = 2.0 * _402;
            float _554 = (_400 / _552) + _449;
            float _562 = 6360.0 - _402;
            float2 _572 = _531 * sqrt(0.4166666567325592041015625 * _402);
            float2 _575 = float2(int2(sign(_572)));
            float2 _576 = _572 * _572;
            float3 _605 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * ((sqrt((6.283100128173828125 * View.View_AtmosphericFogHeightScaleRayleigh) * _402) * exp(_562 / View.View_AtmosphericFogHeightScaleRayleigh)) * (((_535.y > _535.x) ? exp(_536.x) : 0.0) + dot((_535 / ((abs(_532) * 2.3192999362945556640625) + sqrt((_536 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp(((-_400) / View.View_AtmosphericFogHeightScaleRayleigh) * _554)), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * ((sqrt(7.5397205352783203125 * _402) * exp(_562 * 0.833333313465118408203125)) * (((_575.y > _575.x) ? exp(_576.x) : 0.0) + dot((_575 / ((abs(_572) * 2.3192999362945556640625) + sqrt((_576 * 1.519999980926513671875) + float2(4.0)))) * float2(1.0, exp((_400 * (-0.833333313465118408203125)) * _554)), float2(1.0, -1.0))))));
            float _613;
            if (_360)
            {
                _613 = fast::max(_410, _402);
            }
            else
            {
                _613 = _410;
            }
            float4 _885;
            if (_613 > 6360.009765625)
            {
                float4 _884;
                if (_448 < 1.0)
                {
                    float4 _624 = _605.xyzx;
                    float _625 = _613 * _613;
                    float _627 = sqrt(_625 - 40449600.0);
                    float _628 = _613 * (dot(_409, _447) / _410);
                    float _631 = ((_628 * _628) - _625) + 40449600.0;
                    float4 _636 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_628 < 0.0) && (_631 > 0.0)));
                    float _639 = _477 + ((_627 * 0.00105685577727854251861572265625) * _480);
                    float _651 = _636.w + ((((_628 * _636.x) + sqrt(_631 + _636.y)) / (_627 + _636.z)) * 0.4921875);
                    float _659 = _504 + (0.015625 + (((atan(fast::max(dot(_409, View.View_AtmosphereLightDirection[0].xyz) / _410, -0.19750000536441802978515625) * 5.349621295928955078125) * 0.90909087657928466796875) + 0.7400000095367431640625) * 0.484375));
                    float _660 = _659 * 0.125;
                    float _666 = (_659 + 1.0) * 0.125;
                    float4 _674 = fast::max(_520 - (_624 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_660, _651, _639), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _651, _639), level(0.0)) * _505))), float4(0.0));
                    float4 _883;
                    if (!_360)
                    {
                        float _718 = _449 - (-_417);
                        float4 _882;
                        if (abs(_718) < 0.004999999888241291046142578125)
                        {
                            float _725 = (-0.004999999888241291046142578125) - _417;
                            float _727 = _462 + (_400 * _400);
                            float _728 = _552 * _400;
                            float _731 = sqrt(_727 + (_728 * _725));
                            float _732 = _402 * _725;
                            float _735 = 0.004999999888241291046142578125 - _417;
                            float _739 = ((_732 * _732) - _462) + 40449600.0;
                            float4 _744 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_732 < 0.0) && (_739 > 0.0)));
                            float _756 = _744.w + ((((_732 * _744.x) + sqrt(_739 + _744.y)) / (_464 + _744.z)) * 0.4921875);
                            float _766 = _731 * _731;
                            float _768 = sqrt(_766 - 40449600.0);
                            float _769 = _731 * fast::max(_735, (_732 + _400) / _731);
                            float _772 = ((_769 * _769) - _766) + 40449600.0;
                            float4 _777 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_769 < 0.0) && (_772 > 0.0)));
                            float _780 = _477 + ((_768 * 0.00105685577727854251861572265625) * _480);
                            float _792 = _777.w + ((((_769 * _777.x) + sqrt(_772 + _777.y)) / (_768 + _777.z)) * 0.4921875);
                            float _807 = sqrt(_727 + (_728 * _735));
                            float _808 = _402 * _735;
                            float _814 = ((_808 * _808) - _462) + 40449600.0;
                            float4 _819 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_808 < 0.0) && (_814 > 0.0)));
                            float _831 = _819.w + ((((_808 * _819.x) + sqrt(_814 + _819.y)) / (_464 + _819.z)) * 0.4921875);
                            float _841 = _807 * _807;
                            float _843 = sqrt(_841 - 40449600.0);
                            float _844 = _807 * fast::max(_735, (_808 + _400) / _807);
                            float _847 = ((_844 * _844) - _841) + 40449600.0;
                            float4 _852 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_844 < 0.0) && (_847 > 0.0)));
                            float _855 = _477 + ((_843 * 0.00105685577727854251861572265625) * _480);
                            float _867 = _852.w + ((((_844 * _852.x) + sqrt(_847 + _852.y)) / (_843 + _852.z)) * 0.4921875);
                            _882 = mix(fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_507, _756, _482), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_514, _756, _482), level(0.0)) * _505)) - (_624 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_660, _792, _780), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _792, _780), level(0.0)) * _505))), float4(0.0)), fast::max(((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_507, _831, _482), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_514, _831, _482), level(0.0)) * _505)) - (_624 * ((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_660, _867, _855), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_666, _867, _855), level(0.0)) * _505))), float4(0.0)), float4((_718 + 0.004999999888241291046142578125) * 100.0));
                        }
                        else
                        {
                            _882 = _674;
                        }
                        _883 = _882;
                    }
                    else
                    {
                        float4 _717;
                        if (_448 > 0.0)
                        {
                            float _683 = _402 * _426;
                            float _686 = ((_683 * _683) - _462) + 40449600.0;
                            float4 _691 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_683 < 0.0) && (_686 > 0.0)));
                            float _703 = _691.w + ((((_683 * _691.x) + sqrt(_686 + _691.y)) / (_464 + _691.z)) * 0.4921875);
                            _717 = mix(_674, (float4(1.0) - _624) * fast::max((View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_507, _703, _482), level(0.0)) * _511) + (View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_514, _703, _482), level(0.0)) * _505), float4(0.0)), float4(_448));
                        }
                        else
                        {
                            _717 = _674;
                        }
                        _883 = _717;
                    }
                    _884 = _883;
                }
                else
                {
                    _884 = (float4(1.0) - _605.xyzx) * _520;
                }
                _885 = _884;
            }
            else
            {
                _885 = _520;
            }
            _886 = _605;
            _887 = _885;
        }
        else
        {
            _886 = float3(1.0);
            _887 = _520;
        }
        _902 = _886;
        _903 = fast::max((_887.xyz * (0.0596831031143665313720703125 * _451)) + ((((_887.xyz * (_887.w * smoothstep(0.0, 0.0199999995529651641845703125, _413))) / float3(fast::max(_887.x, 9.9999997473787516355514526367188e-05))) * float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * (((0.042971827089786529541015625 * pow(abs(1.6400001049041748046875 - (1.60000002384185791015625 * _411)), -1.5)) * _451) * 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _902 = float3(1.0);
        _903 = float3(0.0);
    }
    float3 _968;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _967;
        if (_371 > 0.0)
        {
            float3 _914 = _337 + (_339 * _371);
            float _915 = length(_914);
            float3 _917 = _914 / float3(_915);
            float _918 = dot(_917, View.View_AtmosphereLightDirection[0].xyz);
            float _920 = (_915 - 6360.0) * 0.014285714365541934967041015625;
            float3 _933 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_918 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt(_920)), level(0.0)).xyz, float3(0.0), bool3(_360));
            float3 _945 = ((_933 * fast::max(_918, 0.0)) + View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2((_918 + 0.20000000298023223876953125) * 0.833333313465118408203125, _920), level(0.0)).xyz) * float3(0.0031830989755690097808837890625);
            float3 _965;
            if ((!_360) && true)
            {
                float3 _951 = normalize(View.View_AtmosphereLightDirection[0].xyz - _339);
                _965 = _945 + (_933 * fast::max((0.0199999995529651641845703125 + (0.980000019073486328125 * pow(1.0 - dot(-_339, _951), 5.0))) * pow(fast::max(dot(_951, _917), 0.0), 150.0), 0.0));
            }
            else
            {
                _965 = _945;
            }
            _967 = _902 * _965;
        }
        else
        {
            _967 = float3(0.0);
        }
        _968 = _967;
    }
    else
    {
        _968 = float3(0.0);
    }
    float3 _1005;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _1004;
        switch (0u)
        {
            default:
            {
                if (_371 > 0.0)
                {
                    _1004 = float3(0.0);
                    break;
                }
                else
                {
                    _1004 = (select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(atan((_341 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_338 - 6360.0) * 0.014285714365541934967041015625)), level(0.0)).xyz, bool3(_338 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_339, View.View_AtmosphereLightDirection[0].xyz))) * View.View_AtmosphereLightDiscLuminance[0].xyz;
                    break;
                }
            }
        }
        _1005 = _1004;
    }
    else
    {
        _1005 = float3(0.0);
    }
    float _1025 = mix(fast::clamp((_902.x * View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _359);
    float4 _1029 = float4((View.View_AtmosphereLightColor[0].xyz * (View.View_AtmosphericFogSunPower * _370)) * ((_1005 + _968) + _903), _1025);
    float4 _1106;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1043 = (_320 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1049 = sqrt((fast::max(0.0, length(_1043) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv) * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv);
        float _1050 = _1049 * View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
        float _1057;
        if (_1050 < 0.707106769084930419921875)
        {
            _1057 = fast::clamp((_1050 * _1050) * 2.0, 0.0, 1.0);
        }
        else
        {
            _1057 = 1.0;
        }
        float2 _1085;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1060 = normalize(_1043);
            float _1061 = _1060.z;
            float _1064 = sqrt(1.0 - (_1061 * _1061));
            float2 _1067 = _170;
            _1067.y = (_1061 * 0.5) + 0.5;
            float _1072 = acos(_1060.x / _1064);
            float2 _1077 = _1067;
            _1077.x = (((_1060.y / _1064) < 0.0) ? (6.283185482025146484375 - _1072) : _1072) * 0.15915493667125701904296875;
            _1085 = (_1077 + (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5)) * (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / (View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy + float2(1.0)));
        }
        else
        {
            _1085 = ((_307.xy / _307.ww) * float2(0.5, -0.5)) + float2(0.5);
        }
        float4 _1090 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1085, _1049), level(0.0));
        float3 _1102 = _1029.xyz + (((_1090.xyz * _1057).xyz * View.View_OneOverPreExposure).xyz * _1025);
        float4 _1105 = float4(_1102.x, _1102.y, _1102.z, _168.w);
        _1105.w = _1025 * (1.0 - (_1057 * (1.0 - _1090.w)));
        _1106 = _1105;
    }
    else
    {
        _1106 = _1029;
    }
    out.out_var_TEXCOORD10_centroid = float4(_271[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_271[2], _235 * View_PrimitiveSceneData._m0[spvStorageBufferCoords(3, spvBufferSizeConstants, float4, _259)].w);
    out.out_var_COLOR0 = LocalVF_VertexFetch_ColorComponentsBuffer.read(uint((_221 & uint(LocalVF.LocalVF_VertexFetch_Parameters.x)))).zyxw;
    out_var_TEXCOORD0 = _319;
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _1106;
    out.gl_Position = _307;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

