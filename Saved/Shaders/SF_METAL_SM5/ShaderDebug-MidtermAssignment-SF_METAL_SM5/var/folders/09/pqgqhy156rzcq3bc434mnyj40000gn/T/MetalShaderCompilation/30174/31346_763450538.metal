

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>


template<typename T>
static inline __attribute__((always_inline))
T ue4_cross(T x, T y)
{
    metal::float3 fx = metal::float3(x);
    metal::float3 fy = metal::float3(y);
    return T(metal::fma(fx[1], fy[2], -metal::fma(fy[1], fx[2], 0.0)), metal::fma(fx[2], fy[0], -metal::fma(fy[2], fx[0], 0.0)), metal::fma(fx[0], fy[1], -metal::fma(fy[0], fx[1], 0.0)));
}
#define cross ue4_cross

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
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    float3 View_TranslatedWorldCameraOrigin;
    char _m3_pad[16];
    float3 View_PreViewTranslation;
    char _m4_pad[1032];
    float View_OneOverPreExposure;
    char _m5_pad[352];
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
    char _m17_pad[32];
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscLuminance;
    spvUnsafeArray<float4, 2> View_AtmosphereLightDiscCosHalfApexAngle;
    char _m19_pad[144];
    float4 View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize;
    float View_SkyAtmosphereAerialPerspectiveStartDepthKm;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution;
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv;
    char _m23_pad[4];
    float View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv;
    float View_SkyAtmosphereApplyCameraAerialPerspectiveVolume;
    uint View_AtmosphericFogRenderMask;
    uint View_AtmosphericFogInscatterAltitudeSampleNum;
    char _m27_pad[16];
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

constant float3x3 _161 = {};
constant float4 _162 = {};
constant float2 _164 = {};

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

template<typename T>
T spvFMul(T l, T r)
{
    return fma(l, r, T(0));
}

template<typename T, int Cols, int Rows>
vec<T, Cols> spvFMulVectorMatrix(vec<T, Rows> v, matrix<T, Cols, Rows> m)
{
    vec<T, Cols> res = vec<T, Cols>(0);
    for (uint i = Rows; i > 0; --i)
    {
        vec<T, Cols> tmp(0);
        for (uint j = 0; j < Cols; ++j)
        {
            tmp[j] = m[j][i - 1];
        }
        res = fma(tmp, vec<T, Cols>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int Cols, int Rows>
vec<T, Rows> spvFMulMatrixVector(matrix<T, Cols, Rows> m, vec<T, Cols> v)
{
    vec<T, Rows> res = vec<T, Rows>(0);
    for (uint i = Cols; i > 0; --i)
    {
        res = fma(m[i - 1], vec<T, Rows>(v[i - 1]), res);
    }
    return res;
}

template<typename T, int LCols, int LRows, int RCols, int RRows>
matrix<T, RCols, LRows> spvFMulMatrixMatrix(matrix<T, LCols, LRows> l, matrix<T, RCols, RRows> r)
{
    matrix<T, RCols, LRows> res;
    for (uint i = 0; i < RCols; i++)
    {
        vec<T, RCols> tmp(0);
        for (uint j = 0; j < LCols; j++)
        {
            tmp = fma(vec<T, RCols>(r[i][j]), l[j], tmp);
        }
        res[i] = tmp;
    }
    return res;
}

template<typename T>
T spvFAdd(T l, T r)
{
    return fma(T(1), l, r);
}

vertex Main_out Main_00007a72_2d8154aa(Main_in in [[stage_in]], constant uint* spvBufferSizeConstants [[buffer(4)]], const device type_StructuredBuffer_v4float& View_PrimitiveSceneData [[buffer(1)]], constant type_View& View [[buffer(2)]], constant type_LocalVF& LocalVF [[buffer(3)]], texture_buffer<float> LocalVF_VertexFetch_PackedTangentsBuffer [[texture(0)]], texture2d<float> View_AtmosphereTransmittanceTexture [[texture(1)]], texture2d<float> View_AtmosphereIrradianceTexture [[texture(2)]], texture3d<float> View_AtmosphereInscatterTexture [[texture(3)]], texture3d<float> View_CameraAerialPerspectiveVolume [[texture(4)]], sampler View_AtmosphereTransmittanceTextureSampler [[sampler(0)]], sampler View_AtmosphereIrradianceTextureSampler [[sampler(1)]], sampler View_AtmosphereInscatterTextureSampler [[sampler(2)]], sampler View_CameraAerialPerspectiveVolumeSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    constant uint& View_PrimitiveSceneDataBufferSize = spvBufferSizeConstants[1];
    uint _219 = 2u * (uint(LocalVF.LocalVF_VertexFetch_Parameters.w) + (gl_VertexIndex - gl_BaseVertex));
    float4 _224 = LocalVF_VertexFetch_PackedTangentsBuffer.read(uint((_219 + 1u)));
    float _225 = _224.w;
    float3 _226 = _224.xyz;
    float3 _228 = cross(_226, LocalVF_VertexFetch_PackedTangentsBuffer.read(uint(_219)).xyz) * _225;
    float3x3 _231 = _161;
    _231[0] = cross(_228, _226) * _225;
    float3x3 _232 = _231;
    _232[1] = _228;
    float3x3 _233 = _232;
    _233[2] = _226;
    uint _234 = in.in_var_ATTRIBUTE13 * 36u;
    uint _237 = _234 + 1u;
    uint _240 = _234 + 2u;
    uint _243 = _234 + 3u;
    uint _249 = _234 + 4u;
    float3x3 _254 = float3x3(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _234)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _237)].xyz, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _240)].xyz);
    _254[0] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _234)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _249)].x;
    float3x3 _257 = _254;
    _257[1] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _237)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _249)].y;
    float3x3 _260 = _257;
    _260[2] = View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _240)].xyz * View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _249)].z;
    float3x3 _261 = spvFMulMatrixMatrix(_260, _233);
    float3 _273 = spvFMul(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _237)].xyz, in.in_var_ATTRIBUTE0.yyy);
    float3 _274 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _234)].xyz, in.in_var_ATTRIBUTE0.xxx, _273);
    float3 _277 = fma(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _240)].xyz, in.in_var_ATTRIBUTE0.zzz, _274);
    float3 _279 = spvFAdd(View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _243)].xyz, View.View_PreViewTranslation);
    float3 _280 = spvFAdd(_277, _279);
    float _281 = _280.x;
    float _282 = _280.y;
    float _283 = _280.z;
    float4 _284 = float4(_281, _282, _283, 1.0);
    float3 _285 = _284.xyz;
    float3 _286 = _285 - View.View_PreViewTranslation;
    float3 _287 = View.View_WorldCameraOrigin - _286;
    float _288 = dot(_287, _287);
    float _289 = sqrt(_288);
    float3 _290 = float3(_289);
    float3 _291 = _287 / _290;
    float _292 = _289 - 20.0;
    float _293 = fast::min(999999988484154753734934528.0, _292);
    float3 _294 = _291 * _293;
    float3 _295 = spvFAdd(_285, _294);
    float4 _296 = float4(_295.x, _295.y, _295.z, _284.w);
    float4 _297 = spvFMulMatrixVector(View.View_TranslatedWorldToClip, _296);
    float3 _308 = _295.xyz;
    float3 _309 = _308 - View.View_TranslatedWorldCameraOrigin;
    float _310 = length(_309);
    float _313 = spvFMul(9.9999997473787516355514526367188e-06, View.View_AtmosphericFogDistanceScale);
    float3 _321 = View.View_TranslatedWorldCameraOrigin;
    _321.z = spvFMul(View.View_TranslatedWorldCameraOrigin.z - View.View_AtmosphericFogGroundOffset, View.View_AtmosphericFogAltitudeScale);
    float3 _322 = _321 * _313;
    float3 _325 = _322;
    _325.z = spvFAdd(_322.z, 6360.009765625);
    float _326 = length(_325);
    float3 _327 = normalize(_309);
    float _328 = dot(_325, _327);
    float _329 = _328 / _326;
    float _331 = spvFMul(-_326, _329);
    float _332 = spvFMul(_326, _326);
    float _334 = spvFMul(_329, _329) - 1.0;
    float _339 = spvFMul(_310, _313);
    float _343 = fast::max(0.0, _339 - View.View_AtmosphericFogStartDistance);
    float _346 = fast::min(spvFMul(_343, 0.100000001490116119384765625) / View.View_AtmosphericFogStartDistance, 1.0);
    bool _347 = _339 < spvFMul(100.0, View.View_AtmosphericFogDistanceScale);
    float _357;
    float _358;
    if (_347)
    {
        _357 = spvFMul(_346, View.View_AtmosphericFogPower);
        _358 = fast::max(fma(_310, _313, View.View_AtmosphericFogDistanceOffset), 1.0);
    }
    else
    {
        _357 = 1.0;
        _358 = _331 - sqrt(fma(_332, _334, 40449600.0));
    }
    float _364 = _331 - sqrt(fma(_332, _334, 41344900.0));
    bool _365 = _364 > 0.0;
    float _373;
    float _374;
    float3 _375;
    if (_365)
    {
        _373 = spvFMul(spvFAdd(_328, _364), 0.00015552098921034485101699829101562);
        _374 = _358 - _364;
        _375 = spvFAdd(_325, _327 * _364);
    }
    else
    {
        _373 = _329;
        _374 = _358;
        _375 = _325;
    }
    float _376 = _365 ? 6430.0 : _326;
    bool _377 = _376 < 6360.0146484375;
    float _386;
    float _387;
    float3 _388;
    if (_377)
    {
        float _380 = 6360.0146484375 - _376;
        float3 _382 = _375 - (_327 * _380);
        _386 = spvFMul(dot(_382, _327), 0.0001572323380969464778900146484375);
        _387 = _374 - _380;
        _388 = _382;
    }
    else
    {
        _386 = _373;
        _387 = _374;
        _388 = _375;
    }
    float _389 = _377 ? 6360.0146484375 : _376;
    float3 _864;
    float3 _865;
    if ((_389 <= 6430.0) && (_343 > 0.0))
    {
        float3 _396 = spvFAdd(_388, _327 * _387);
        float _397 = length(_396);
        float _398 = dot(_327, View.View_AtmosphereLightDirection[0].xyz);
        float _400 = dot(_388, View.View_AtmosphereLightDirection[0].xyz) / _389;
        float _401 = 6360.0 / _389;
        float _404 = sqrt(1.0 - spvFMul(_401, _401));
        float _413;
        if (_347)
        {
            _413 = fast::max(_386, 0.1550000011920928955078125 - _404);
        }
        else
        {
            _413 = fast::max(_386, 0.004999999888241291046142578125 - _404);
        }
        float3 _434;
        float _435;
        float _436;
        if (_347)
        {
            float _416 = _327.z;
            float _420 = fast::clamp(exp(-_416) - 0.5, 0.0, 1.0);
            float3 _432;
            float _433;
            if (_420 < 1.0)
            {
                float3 _425 = _327;
                _425.z = fast::max(_416, 0.1500000059604644775390625);
                float3 _426 = normalize(_425);
                float3 _428 = spvFAdd(_388, _426 * _387);
                _432 = _426;
                _433 = dot(_428, _426) / length(_428);
            }
            else
            {
                _432 = _327;
                _433 = _413;
            }
            _434 = _432;
            _435 = _420;
            _436 = _433;
        }
        else
        {
            _434 = _327;
            _435 = 0.0;
            _436 = _413;
        }
        float _437 = fma(_398, _398, 1.0);
        float _448 = spvFMul(_389, _389);
        float _450 = sqrt(_448 - 40449600.0);
        float _451 = spvFMul(_389, _436);
        float _454 = spvFAdd(spvFMul(_451, _451) - _448, 40449600.0);
        float4 _459 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_451 < 0.0) && (_454 > 0.0)));
        float _462 = float(View.View_AtmosphericFogInscatterAltitudeSampleNum);
        float _463 = 0.5 / _462;
        float _466 = 1.0 - (1.0 / _462);
        float _467 = fma(spvFMul(_450, 0.00105685577727854251861572265625), _466, _463);
        float _477 = fma(fma(_451, _459.x, sqrt(spvFAdd(_454, _459.y))) / spvFAdd(_450, _459.z), 0.4921875, _459.w);
        float _484 = spvFMul(spvFAdd(_398, 1.0), 3.5);
        float _485 = floor(_484);
        float _486 = _484 - _485;
        float _487 = spvFAdd(_485, fma(fma(atan(spvFMul(fast::max(_400, -0.19750000536441802978515625), 5.349621295928955078125)), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625));
        float _488 = spvFMul(_487, 0.125);
        float _492 = 1.0 - _486;
        float _495 = spvFMul(spvFAdd(_487, 1.0), 0.125);
        float4 _501 = fast::max(spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _477, _467), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _477, _467), level(0.0)) * _486), float4(0.0));
        float3 _848;
        float4 _849;
        if (_387 > 0.0)
        {
            float2 _512 = float2(_436, spvFAdd(_436, _387 / _389));
            float2 _513 = _512 * sqrt(spvFMul(0.5 / View.View_AtmosphericFogHeightScaleRayleigh, _389));
            float2 _516 = float2(int2(sign(_513)));
            float2 _517 = spvFMul(_513, _513);
            float _533 = spvFMul(2.0, _389);
            float _535 = spvFAdd(_387 / _533, _436);
            float _543 = 6360.0 - _389;
            float2 _553 = _512 * sqrt(spvFMul(0.4166666567325592041015625, _389));
            float2 _556 = float2(int2(sign(_553)));
            float2 _557 = spvFMul(_553, _553);
            float3 _586 = exp((float3(-0.0057999999262392520904541015625, -0.013500000350177288055419921875, -0.033100001513957977294921875) * spvFMul(spvFMul(sqrt(spvFMul(spvFMul(6.283100128173828125, View.View_AtmosphericFogHeightScaleRayleigh), _389)), exp(_543 / View.View_AtmosphericFogHeightScaleRayleigh)), spvFAdd((_516.y > _516.x) ? exp(_517.x) : 0.0, dot(spvFMul(_516 / spvFAdd(abs(_513) * 2.3192999362945556640625, sqrt(spvFAdd(_517 * 1.519999980926513671875, float2(4.0)))), float2(1.0, exp(spvFMul((-_387) / View.View_AtmosphericFogHeightScaleRayleigh, _535)))), float2(1.0, -1.0))))) - (float3(0.00444444455206394195556640625) * spvFMul(spvFMul(sqrt(spvFMul(7.5397205352783203125, _389)), exp(spvFMul(_543, 0.833333313465118408203125))), spvFAdd((_556.y > _556.x) ? exp(_557.x) : 0.0, dot(spvFMul(_556 / spvFAdd(abs(_553) * 2.3192999362945556640625, sqrt(spvFAdd(_557 * 1.519999980926513671875, float2(4.0)))), float2(1.0, exp(spvFMul(spvFMul(_387, -0.833333313465118408203125), _535)))), float2(1.0, -1.0))))));
            float _594;
            if (_347)
            {
                _594 = fast::max(_397, _389);
            }
            else
            {
                _594 = _397;
            }
            float4 _847;
            if (_594 > 6360.009765625)
            {
                float4 _846;
                if (_435 < 1.0)
                {
                    float4 _605 = _586.xyzx;
                    float _606 = spvFMul(_594, _594);
                    float _608 = sqrt(_606 - 40449600.0);
                    float _609 = spvFMul(_594, dot(_396, _434) / _397);
                    float _612 = spvFAdd(spvFMul(_609, _609) - _606, 40449600.0);
                    float4 _617 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_609 < 0.0) && (_612 > 0.0)));
                    float _619 = fma(spvFMul(_608, 0.00105685577727854251861572265625), _466, _463);
                    float _629 = fma(fma(_609, _617.x, sqrt(spvFAdd(_612, _617.y))) / spvFAdd(_608, _617.z), 0.4921875, _617.w);
                    float _635 = spvFAdd(_485, fma(fma(atan(spvFMul(fast::max(dot(_396, View.View_AtmosphereLightDirection[0].xyz) / _397, -0.19750000536441802978515625), 5.349621295928955078125)), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625));
                    float _636 = spvFMul(_635, 0.125);
                    float _642 = spvFMul(spvFAdd(_635, 1.0), 0.125);
                    float4 _650 = fast::max(_501 - spvFMul(_605, spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_636, _629, _619), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_642, _629, _619), level(0.0)) * _486)), float4(0.0));
                    float4 _845;
                    if (!_347)
                    {
                        float _692 = _436 - (-_404);
                        float4 _844;
                        if (abs(_692) < 0.004999999888241291046142578125)
                        {
                            float _699 = (-0.004999999888241291046142578125) - _404;
                            float _701 = fma(_389, _389, spvFMul(_387, _387));
                            float _702 = spvFMul(_533, _387);
                            float _704 = sqrt(fma(_702, _699, _701));
                            float _707 = 0.004999999888241291046142578125 - _404;
                            float _709 = spvFMul(_389, _699);
                            float _712 = spvFAdd(spvFMul(_709, _709) - _448, 40449600.0);
                            float4 _717 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_709 < 0.0) && (_712 > 0.0)));
                            float _727 = fma(fma(_709, _717.x, sqrt(spvFAdd(_712, _717.y))) / spvFAdd(_450, _717.z), 0.4921875, _717.w);
                            float _737 = spvFMul(_704, _704);
                            float _739 = sqrt(_737 - 40449600.0);
                            float _740 = spvFMul(_704, fast::max(_707, fma(_389, _699, _387) / _704));
                            float _743 = spvFAdd(spvFMul(_740, _740) - _737, 40449600.0);
                            float4 _748 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_740 < 0.0) && (_743 > 0.0)));
                            float _750 = fma(spvFMul(_739, 0.00105685577727854251861572265625), _466, _463);
                            float _760 = fma(fma(_740, _748.x, sqrt(spvFAdd(_743, _748.y))) / spvFAdd(_739, _748.z), 0.4921875, _748.w);
                            float _774 = sqrt(fma(_702, _707, _701));
                            float _778 = spvFMul(_389, _707);
                            float _781 = spvFAdd(spvFMul(_778, _778) - _448, 40449600.0);
                            float4 _786 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_778 < 0.0) && (_781 > 0.0)));
                            float _796 = fma(fma(_778, _786.x, sqrt(spvFAdd(_781, _786.y))) / spvFAdd(_450, _786.z), 0.4921875, _786.w);
                            float _806 = spvFMul(_774, _774);
                            float _808 = sqrt(_806 - 40449600.0);
                            float _809 = spvFMul(_774, fast::max(_707, fma(_389, _707, _387) / _774));
                            float _812 = spvFAdd(spvFMul(_809, _809) - _806, 40449600.0);
                            float4 _817 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_809 < 0.0) && (_812 > 0.0)));
                            float _819 = fma(spvFMul(_808, 0.00105685577727854251861572265625), _466, _463);
                            float _829 = fma(fma(_809, _817.x, sqrt(spvFAdd(_812, _817.y))) / spvFAdd(_808, _817.z), 0.4921875, _817.w);
                            _844 = mix(fast::max(spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _727, _467), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _727, _467), level(0.0)) * _486) - spvFMul(_605, spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_636, _760, _750), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_642, _760, _750), level(0.0)) * _486)), float4(0.0)), fast::max(spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _796, _467), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _796, _467), level(0.0)) * _486) - spvFMul(_605, spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_636, _829, _819), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_642, _829, _819), level(0.0)) * _486)), float4(0.0)), float4(spvFMul(spvFAdd(_692, 0.004999999888241291046142578125), 100.0)));
                        }
                        else
                        {
                            _844 = _650;
                        }
                        _845 = _844;
                    }
                    else
                    {
                        float4 _691;
                        if (_435 > 0.0)
                        {
                            float _659 = spvFMul(_389, _413);
                            float _662 = spvFAdd(spvFMul(_659, _659) - _448, 40449600.0);
                            float4 _667 = select(float4(-1.0, 895300.0, 946.20294189453125, 0.50390625), float4(1.0, 0.0, 0.0, 0.49609375), bool4((_659 < 0.0) && (_662 > 0.0)));
                            float _677 = fma(fma(_659, _667.x, sqrt(spvFAdd(_662, _667.y))) / spvFAdd(_450, _667.z), 0.4921875, _667.w);
                            _691 = mix(_650, spvFMul(float4(1.0) - _605, fast::max(spvFAdd(View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_488, _677, _467), level(0.0)) * _492, View_AtmosphereInscatterTexture.sample(View_AtmosphereInscatterTextureSampler, float3(_495, _677, _467), level(0.0)) * _486), float4(0.0))), float4(_435));
                        }
                        else
                        {
                            _691 = _650;
                        }
                        _845 = _691;
                    }
                    _846 = _845;
                }
                else
                {
                    _846 = spvFMul(float4(1.0) - _586.xyzx, _501);
                }
                _847 = _846;
            }
            else
            {
                _847 = _501;
            }
            _848 = _586;
            _849 = _847;
        }
        else
        {
            _848 = float3(1.0);
            _849 = _501;
        }
        _864 = _848;
        _865 = fast::max(spvFAdd(_849.xyz * spvFMul(0.0596831031143665313720703125, _437), spvFMul((_849.xyz * spvFMul(_849.w, smoothstep(0.0, 0.0199999995529651641845703125, _400))) / float3(fast::max(_849.x, 9.9999997473787516355514526367188e-05)), float3(1.0, 0.429629623889923095703125, 0.17522656917572021484375)) * spvFMul(spvFMul(spvFMul(0.042971827089786529541015625, pow(abs(1.6400001049041748046875 - spvFMul(1.60000002384185791015625, _398)), -1.5)), _437), 0.37878787517547607421875)), float3(0.0));
    }
    else
    {
        _864 = float3(1.0);
        _865 = float3(0.0);
    }
    float3 _929;
    if ((View.View_AtmosphericFogRenderMask & 2u) == 0u)
    {
        float3 _928;
        if (_358 > 0.0)
        {
            float3 _876 = spvFAdd(_325, _327 * _358);
            float _877 = length(_876);
            float3 _879 = _876 / float3(_877);
            float _880 = dot(_879, View.View_AtmosphereLightDirection[0].xyz);
            float _882 = spvFMul(_877 - 6360.0, 0.014285714365541934967041015625);
            float3 _895 = select(View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(spvFMul(atan(spvFMul(spvFAdd(_880, 0.1500000059604644775390625), 12.26210498809814453125)), 0.666666686534881591796875), sqrt(_882)), level(0.0)).xyz, float3(0.0), bool3(_347));
            float3 _906 = spvFAdd(_895 * fast::max(_880, 0.0), View_AtmosphereIrradianceTexture.sample(View_AtmosphereIrradianceTextureSampler, float2(spvFMul(spvFAdd(_880, 0.20000000298023223876953125), 0.833333313465118408203125), _882), level(0.0)).xyz);
            float3 _926;
            if ((!_347) && true)
            {
                float3 _913 = normalize(View.View_AtmosphereLightDirection[0].xyz - _327);
                _926 = fma(_906, float3(0.0031830989755690097808837890625), _895 * fast::max(spvFMul(fma(0.980000019073486328125, pow(1.0 - dot(-_327, _913), 5.0), 0.0199999995529651641845703125), pow(fast::max(dot(_913, _879), 0.0), 150.0)), 0.0));
            }
            else
            {
                _926 = spvFMul(_906, float3(0.0031830989755690097808837890625));
            }
            _928 = spvFMul(_864, _926);
        }
        else
        {
            _928 = float3(0.0);
        }
        _929 = _928;
    }
    else
    {
        _929 = float3(0.0);
    }
    float3 _966;
    if ((View.View_AtmosphericFogRenderMask & 1u) == 0u)
    {
        float3 _965;
        switch (0u)
        {
            default:
            {
                if (_358 > 0.0)
                {
                    _965 = float3(0.0);
                    break;
                }
                else
                {
                    _965 = spvFMul(select(float3(1.0), View_AtmosphereTransmittanceTexture.sample(View_AtmosphereTransmittanceTextureSampler, float2(spvFMul(atan(spvFMul(spvFAdd(_329, 0.1500000059604644775390625), 12.26210498809814453125)), 0.666666686534881591796875), sqrt(spvFMul(_326 - 6360.0, 0.014285714365541934967041015625))), level(0.0)).xyz, bool3(_326 <= 6430.0)) * step(View.View_AtmosphereLightDiscCosHalfApexAngle[0].x, dot(_327, View.View_AtmosphereLightDirection[0].xyz)), View.View_AtmosphereLightDiscLuminance[0].xyz);
                    break;
                }
            }
        }
        _966 = _965;
    }
    else
    {
        _966 = float3(0.0);
    }
    float _986 = mix(fast::clamp(spvFMul(_864.x, View.View_AtmosphericFogDensityScale) - View.View_AtmosphericFogDensityOffset, 0.0, 1.0), 1.0, 1.0 - _346);
    float4 _990 = float4(spvFMul(View.View_AtmosphereLightColor[0].xyz * spvFMul(View.View_AtmosphericFogSunPower, _357), spvFAdd(spvFAdd(_966, _929), _865)), _986);
    float4 _1065;
    if (View.View_SkyAtmosphereApplyCameraAerialPerspectiveVolume > 0.0)
    {
        float3 _1003 = (_308 * 9.9999997473787516355514526367188e-06) - (View.View_TranslatedWorldCameraOrigin * 9.9999997473787516355514526367188e-06);
        float _1009 = sqrt(spvFMul(spvFMul(fast::max(0.0, length(_1003) - View.View_SkyAtmosphereAerialPerspectiveStartDepthKm), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthSliceLengthKmInv), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolutionInv));
        float _1010 = spvFMul(_1009, View.View_SkyAtmosphereCameraAerialPerspectiveVolumeDepthResolution);
        float _1017;
        if (_1010 < 0.707106769084930419921875)
        {
            _1017 = fast::clamp(spvFMul(spvFMul(_1010, _1010), 2.0), 0.0, 1.0);
        }
        else
        {
            _1017 = 1.0;
        }
        float2 _1044;
        if (View.View_RealTimeReflectionCapture != 0.0)
        {
            float3 _1020 = normalize(_1003);
            float _1021 = _1020.z;
            float _1024 = sqrt(1.0 - spvFMul(_1021, _1021));
            float2 _1026 = _164;
            _1026.y = fma(_1021, 0.5, 0.5);
            float _1031 = acos(_1020.x / _1024);
            float2 _1036 = _1026;
            _1036.x = spvFMul(((_1020.y / _1024) < 0.0) ? (6.283185482025146484375 - _1031) : _1031, 0.15915493667125701904296875);
            _1044 = spvFMul(spvFAdd(_1036, View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.zw * 0.5), View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy / spvFAdd(View.View_SkyAtmosphereCameraAerialPerspectiveVolumeSizeAndInvSize.xy, float2(1.0)));
        }
        else
        {
            _1044 = fma(_297.xy / _297.ww, float2(0.5, -0.5), float2(0.5));
        }
        float4 _1049 = View_CameraAerialPerspectiveVolume.sample(View_CameraAerialPerspectiveVolumeSampler, float3(_1044, _1009), level(0.0));
        float3 _1061 = spvFAdd(_990.xyz, ((_1049.xyz * _1017).xyz * View.View_OneOverPreExposure).xyz * _986);
        float4 _1064 = float4(_1061.x, _1061.y, _1061.z, _162.w);
        _1064.w = spvFMul(_986, 1.0 - spvFMul(_1017, 1.0 - _1049.w));
        _1065 = _1064;
    }
    else
    {
        _1065 = _990;
    }
    out.out_var_TEXCOORD10_centroid = float4(_261[0], 0.0);
    out.out_var_TEXCOORD11_centroid = float4(_261[2], spvFMul(_225, View_PrimitiveSceneData._m0[spvStorageBufferCoords(1, spvBufferSizeConstants, float4, _249)].w));
    out.out_var_PRIMITIVE_ID = in.in_var_ATTRIBUTE13;
    out.out_var_TEXCOORD7 = _1065;
    out.gl_Position = _297;
    return out;
}

