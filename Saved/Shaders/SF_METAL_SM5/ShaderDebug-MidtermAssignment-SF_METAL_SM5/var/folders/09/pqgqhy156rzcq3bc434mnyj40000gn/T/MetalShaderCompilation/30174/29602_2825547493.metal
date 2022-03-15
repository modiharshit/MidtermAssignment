

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
    char _m1_pad[1008];
    float3 View_WorldCameraOrigin;
    char _m2_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_NiagaraRibbonVFLooseParameters
{
    uint NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride;
    uint NiagaraRibbonVFLooseParameters_SortedIndicesOffset;
    uint NiagaraRibbonVFLooseParameters_FacingMode;
    uint NiagaraRibbonVFLooseParameters_Shape;
};

struct type_NiagaraRibbonVF
{
    char _m0_pad[48];
    int NiagaraRibbonVF_PositionDataOffset;
    char _m1_pad[4];
    int NiagaraRibbonVF_WidthDataOffset;
    int NiagaraRibbonVF_TwistDataOffset;
    char _m3_pad[4];
    int NiagaraRibbonVF_FacingDataOffset;
    char _m4_pad[28];
    int NiagaraRibbonVF_DistanceFromStartOffset;
    int NiagaraRibbonVF_U0OverrideDataOffset;
    int NiagaraRibbonVF_V0RangeOverrideDataOffset;
    char _m7_pad[16];
    float NiagaraRibbonVF_OneOverInterpCount;
    int NiagaraRibbonVF_ParticleIdShift;
    int NiagaraRibbonVF_ParticleIdMask;
    int NiagaraRibbonVF_InterpIdShift;
    int NiagaraRibbonVF_InterpIdMask;
    int NiagaraRibbonVF_SliceVertexIdMask;
    int NiagaraRibbonVF_ShouldFlipNormalToView;
    int NiagaraRibbonVF_U0DistributionMode;
    char _m15_pad[16];
    float4 NiagaraRibbonVF_PackedVData;
    uint NiagaraRibbonVF_bLocalSpace;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD3_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex MainVertexShader_out Main_000073a2_a86a6ee5(constant type_View& View [[buffer(7)]], constant type_Primitive& Primitive [[buffer(8)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(9)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<uint> NiagaraRibbonVFLooseParameters_MultiRibbonIndices [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(4)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(5)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(6)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    uint _111 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _112 = _111 + 1u;
    uint _128;
    uint _129;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _128 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _111))).x);
        _129 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _112))).x);
    }
    else
    {
        _128 = _111;
        _129 = _112;
    }
    float _142 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    int _147 = int(NiagaraRibbonVFLooseParameters_MultiRibbonIndices.read(uint(_111)).x) * 7;
    float4 _164 = NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_147 + 2)));
    float _165 = _164.x;
    float3 _376;
    float3 _377;
    float _378;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _180;
        int _182;
        float3 _228;
        switch (0u)
        {
            default:
            {
                uint _178 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _180 = (_178 & 2147483648u) != 0u;
                _182 = int(_178 & 2147483647u);
                if (_180)
                {
                    _228 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _228 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        float3 _276;
        switch (0u)
        {
            default:
            {
                if (_180)
                {
                    _276 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_182 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _276 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_182 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        bool _310;
        float4 _278 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_111));
        float4 _279 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_112));
        float3 _280 = _278.xyz;
        float3 _281 = _279.xyz;
        float _282 = _279.w;
        float _283 = _278.w;
        float _284 = _282 - _283;
        float _285 = _142 * _142;
        float _286 = _285 * _142;
        float _288 = 3.0 * _285;
        float3 _305 = (((_228 * (((2.0 * _286) - _288) + 1.0)) + (_280 * (_284 * ((_286 - (2.0 * _285)) + _142)))) + (_281 * (_284 * (_286 - _285)))) + (_276 * (((-2.0) * _286) + _288));
        float3 _340;
        switch (0u)
        {
            default:
            {
                _310 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_310)
                {
                    _340 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _305.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _305.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _305.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _340 = _305;
                    break;
                }
            }
        }
        float3 _342 = mix(_280, _281, float3(_142));
        float3 _373;
        switch (0u)
        {
            default:
            {
                if (_310)
                {
                    _373 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _342.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _342.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _342.zzz);
                    break;
                }
                else
                {
                    _373 = _342;
                    break;
                }
            }
        }
        _376 = normalize(_373);
        _377 = _340;
        _378 = mix(_283, _282, _142);
    }
    else
    {
        _376 = float3(0.0);
        _377 = float3(0.0);
        _378 = 0.0;
    }
    float _513;
    if (NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset != (-1))
    {
        bool _467;
        int _469;
        float _489;
        switch (0u)
        {
            default:
            {
                uint _465 = uint(NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset);
                _467 = (_465 & 2147483648u) != 0u;
                _469 = int(_465 & 2147483647u);
                if (_467)
                {
                    _489 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_469) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _489 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_469) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        float _511;
        switch (0u)
        {
            default:
            {
                if (_467)
                {
                    _511 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_469) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _511 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_469) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        _513 = mix(_489, _511, _142);
    }
    else
    {
        float _462;
        if (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 0)
        {
            _462 = (float(_111 - as_type<uint>(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_147 + 6))).x)) + _142) * _165;
        }
        else
        {
            float _457;
            if ((NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 1) || (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 2))
            {
                _457 = _378 * _165;
            }
            else
            {
                float _455;
                if ((NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset != (-1)) && (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 3))
                {
                    bool _408;
                    int _410;
                    float _430;
                    switch (0u)
                    {
                        default:
                        {
                            uint _406 = uint(NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset);
                            _408 = (_406 & 2147483648u) != 0u;
                            _410 = int(_406 & 2147483647u);
                            if (_408)
                            {
                                _430 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                                break;
                            }
                            else
                            {
                                _430 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                                break;
                            }
                        }
                    }
                    float _452;
                    switch (0u)
                    {
                        default:
                        {
                            if (_408)
                            {
                                _452 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                                break;
                            }
                            else
                            {
                                _452 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                                break;
                            }
                        }
                    }
                    _455 = mix(_430, _452, _142) * _165;
                }
                else
                {
                    _455 = 0.0;
                }
                _457 = _455;
            }
            _462 = _457;
        }
        _513 = _462;
    }
    float _625;
    if (NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset != (-1))
    {
        bool _533;
        int _535;
        float2 _569;
        switch (0u)
        {
            default:
            {
                uint _531 = uint(NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset);
                _533 = (_531 & 2147483648u) != 0u;
                _535 = int(_531 & 2147483647u);
                if (_533)
                {
                    _569 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_535) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_535 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _569 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_535) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_535 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        float2 _605;
        switch (0u)
        {
            default:
            {
                if (_533)
                {
                    _605 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_535) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_535 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _605 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_535) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_535 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float2 _607 = mix(_569, _605, float2(_142));
        uint _613 = (((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u;
        _625 = (1.0 - (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_613)).x * _607.x)) + (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_613)).x * _607.y);
    }
    else
    {
        _625 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(((((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u))).x;
    }
    float2 _628 = (float2(_513, _625) * float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_147))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.x)) + float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_147 + 1))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.y);
    float _684;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _638;
        int _640;
        float _660;
        switch (0u)
        {
            default:
            {
                uint _636 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _638 = (_636 & 2147483648u) != 0u;
                _640 = int(_636 & 2147483647u);
                if (_638)
                {
                    _660 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_640) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _660 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_640) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        float _682;
        switch (0u)
        {
            default:
            {
                if (_638)
                {
                    _682 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_640) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _682 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_640) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        _684 = mix(_660, _682, _142);
    }
    else
    {
        _684 = 1.0;
    }
    float3 _831;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _697;
        int _699;
        float3 _745;
        switch (0u)
        {
            default:
            {
                uint _695 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _697 = (_695 & 2147483648u) != 0u;
                _699 = int(_695 & 2147483647u);
                if (_697)
                {
                    _745 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _745 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        float3 _793;
        switch (0u)
        {
            default:
            {
                if (_697)
                {
                    _793 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_699 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _793 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_699 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float3 _795 = mix(_745, _793, float3(_142));
        float3 _829;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _829 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _795.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _795.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _795.zzz);
                    break;
                }
                else
                {
                    _829 = _795;
                    break;
                }
            }
        }
        _831 = normalize(_829);
    }
    else
    {
        _831 = normalize(View.View_WorldCameraOrigin - _377);
    }
    float3 _833 = normalize(cross(_831, _376));
    bool _836 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _840;
    if (_836)
    {
        _840 = -_831;
    }
    else
    {
        _840 = _833;
    }
    float3 _842 = select(_831, _833, bool3(_836));
    float3 _907;
    float3 _908;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _852;
        int _854;
        float _874;
        switch (0u)
        {
            default:
            {
                uint _850 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _852 = (_850 & 2147483648u) != 0u;
                _854 = int(_850 & 2147483647u);
                if (_852)
                {
                    _874 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _874 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        float _896;
        switch (0u)
        {
            default:
            {
                if (_852)
                {
                    _896 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _896 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        float _897 = mix(_874, _896, _142);
        float _898 = sin(_897);
        float _899 = cos(_897);
        _907 = (_840 * (-_898)) + (_842 * _899);
        _908 = (_840 * _899) + (_842 * _898);
    }
    else
    {
        _907 = _842;
        _908 = _840;
    }
    float3 _909 = cross(_376, _908);
    uint _917 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _918 = (gl_VertexIndex - gl_BaseVertex) & _917;
    uint _919 = _918 * 5u;
    float3 _930 = normalize((select(_907, _909, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_919 + 3u))).x) + (_908 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_919 + 2u))).x));
    float3 _941 = _930 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _377), _930) < 0.0)) ? (-1) : 1);
    float3 _942 = cross(_941, _376);
    float4 _943 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_919));
    float _944 = _943.x;
    uint _945 = _919 + 1u;
    float4 _946 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_945));
    float _947 = _946.x;
    float2 _948 = float2(_944, _947);
    float3 _949 = _948.xxx;
    float3 _950 = _908 * _949;
    float3 _951 = _948.yyy;
    float3 _952 = _909 * _951;
    float3 _953 = _950 + _952;
    float3 _954 = float3(_684);
    float3 _955 = _953 * _954;
    float3 _956 = _377 + _955;
    float3 _957 = _956 + View.View_PreViewTranslation;
    float _958 = _957.x;
    float _959 = _957.y;
    float _960 = _957.z;
    float4 _961 = float4(_958, _959, _960, 1.0);
    float4 _962 = float4(_961.x, _961.y, _961.z, _961.w);
    float4 _963 = View.View_TranslatedWorldToClip * _962;
    float4 _966 = float4(_942.x, _942.y, _942.z, float4(0.0).w);
    _966.w = 0.0;
    spvUnsafeArray<float4, 1> _971 = { float4(_628.x, _628.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = _966;
    out.out_var_TEXCOORD11_centroid = float4(_941, 1.0);
    out_var_TEXCOORD3 = _971;
    out.out_var_TEXCOORD6 = _962;
    out.gl_Position = _963;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

