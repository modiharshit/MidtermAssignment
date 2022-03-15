

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

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD3_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_0000734d_f9f486a9(constant type_View& View [[buffer(7)]], constant type_Primitive& Primitive [[buffer(8)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(9)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<uint> NiagaraRibbonVFLooseParameters_MultiRibbonIndices [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(4)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(5)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(6)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    uint _109 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _110 = _109 + 1u;
    uint _126;
    uint _127;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _126 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _109))).x);
        _127 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _110))).x);
    }
    else
    {
        _126 = _109;
        _127 = _110;
    }
    float _140 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    int _145 = int(NiagaraRibbonVFLooseParameters_MultiRibbonIndices.read(uint(_109)).x) * 7;
    float4 _162 = NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_145 + 2)));
    float _163 = _162.x;
    float3 _374;
    float3 _375;
    float _376;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _178;
        int _180;
        float3 _226;
        switch (0u)
        {
            default:
            {
                uint _176 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _178 = (_176 & 2147483648u) != 0u;
                _180 = int(_176 & 2147483647u);
                if (_178)
                {
                    _226 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
                else
                {
                    _226 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
            }
        }
        float3 _274;
        switch (0u)
        {
            default:
            {
                if (_178)
                {
                    _274 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _274 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        bool _308;
        float4 _276 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_109));
        float4 _277 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_110));
        float3 _278 = _276.xyz;
        float3 _279 = _277.xyz;
        float _280 = _277.w;
        float _281 = _276.w;
        float _282 = _280 - _281;
        float _283 = _140 * _140;
        float _284 = _283 * _140;
        float _286 = 3.0 * _283;
        float3 _303 = (((_226 * (((2.0 * _284) - _286) + 1.0)) + (_278 * (_282 * ((_284 - (2.0 * _283)) + _140)))) + (_279 * (_282 * (_284 - _283)))) + (_274 * (((-2.0) * _284) + _286));
        float3 _338;
        switch (0u)
        {
            default:
            {
                _308 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_308)
                {
                    _338 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _303.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _303.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _303.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _338 = _303;
                    break;
                }
            }
        }
        float3 _340 = mix(_278, _279, float3(_140));
        float3 _371;
        switch (0u)
        {
            default:
            {
                if (_308)
                {
                    _371 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _340.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _340.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _340.zzz);
                    break;
                }
                else
                {
                    _371 = _340;
                    break;
                }
            }
        }
        _374 = normalize(_371);
        _375 = _338;
        _376 = mix(_281, _280, _140);
    }
    else
    {
        _374 = float3(0.0);
        _375 = float3(0.0);
        _376 = 0.0;
    }
    float _511;
    if (NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset != (-1))
    {
        bool _465;
        int _467;
        float _487;
        switch (0u)
        {
            default:
            {
                uint _463 = uint(NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset);
                _465 = (_463 & 2147483648u) != 0u;
                _467 = int(_463 & 2147483647u);
                if (_465)
                {
                    _487 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_467) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
                else
                {
                    _487 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_467) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
            }
        }
        float _509;
        switch (0u)
        {
            default:
            {
                if (_465)
                {
                    _509 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_467) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _509 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_467) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        _511 = mix(_487, _509, _140);
    }
    else
    {
        float _460;
        if (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 0)
        {
            _460 = (float(_109 - as_type<uint>(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_145 + 6))).x)) + _140) * _163;
        }
        else
        {
            float _455;
            if ((NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 1) || (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 2))
            {
                _455 = _376 * _163;
            }
            else
            {
                float _453;
                if ((NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset != (-1)) && (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 3))
                {
                    bool _406;
                    int _408;
                    float _428;
                    switch (0u)
                    {
                        default:
                        {
                            uint _404 = uint(NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset);
                            _406 = (_404 & 2147483648u) != 0u;
                            _408 = int(_404 & 2147483647u);
                            if (_406)
                            {
                                _428 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                                break;
                            }
                            else
                            {
                                _428 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                                break;
                            }
                        }
                    }
                    float _450;
                    switch (0u)
                    {
                        default:
                        {
                            if (_406)
                            {
                                _450 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                                break;
                            }
                            else
                            {
                                _450 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                                break;
                            }
                        }
                    }
                    _453 = mix(_428, _450, _140) * _163;
                }
                else
                {
                    _453 = 0.0;
                }
                _455 = _453;
            }
            _460 = _455;
        }
        _511 = _460;
    }
    float _623;
    if (NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset != (-1))
    {
        bool _531;
        int _533;
        float2 _567;
        switch (0u)
        {
            default:
            {
                uint _529 = uint(NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset);
                _531 = (_529 & 2147483648u) != 0u;
                _533 = int(_529 & 2147483647u);
                if (_531)
                {
                    _567 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_533) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_533 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
                else
                {
                    _567 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_533) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_533 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
            }
        }
        float2 _603;
        switch (0u)
        {
            default:
            {
                if (_531)
                {
                    _603 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_533) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_533 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _603 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_533) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_533 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        float2 _605 = mix(_567, _603, float2(_140));
        uint _611 = (((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u;
        _623 = (1.0 - (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_611)).x * _605.x)) + (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_611)).x * _605.y);
    }
    else
    {
        _623 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(((((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u))).x;
    }
    float2 _626 = (float2(_511, _623) * float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_145))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.x)) + float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_145 + 1))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.y);
    float _682;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _636;
        int _638;
        float _658;
        switch (0u)
        {
            default:
            {
                uint _634 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _636 = (_634 & 2147483648u) != 0u;
                _638 = int(_634 & 2147483647u);
                if (_636)
                {
                    _658 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_638) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
                else
                {
                    _658 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_638) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
            }
        }
        float _680;
        switch (0u)
        {
            default:
            {
                if (_636)
                {
                    _680 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_638) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _680 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_638) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        _682 = mix(_658, _680, _140);
    }
    else
    {
        _682 = 1.0;
    }
    float3 _829;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _695;
        int _697;
        float3 _743;
        switch (0u)
        {
            default:
            {
                uint _693 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _695 = (_693 & 2147483648u) != 0u;
                _697 = int(_693 & 2147483647u);
                if (_695)
                {
                    _743 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
                else
                {
                    _743 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x);
                    break;
                }
            }
        }
        float3 _791;
        switch (0u)
        {
            default:
            {
                if (_695)
                {
                    _791 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_697 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _791 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_697 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        float3 _793 = mix(_743, _791, float3(_140));
        float3 _827;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _827 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _793.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _793.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _793.zzz);
                    break;
                }
                else
                {
                    _827 = _793;
                    break;
                }
            }
        }
        _829 = normalize(_827);
    }
    else
    {
        _829 = normalize(View.View_WorldCameraOrigin - _375);
    }
    float3 _831 = normalize(cross(_829, _374));
    bool _834 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _838;
    if (_834)
    {
        _838 = -_829;
    }
    else
    {
        _838 = _831;
    }
    float3 _840 = select(_829, _831, bool3(_834));
    float3 _905;
    float3 _906;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _850;
        int _852;
        float _872;
        switch (0u)
        {
            default:
            {
                uint _848 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _850 = (_848 & 2147483648u) != 0u;
                _852 = int(_848 & 2147483647u);
                if (_850)
                {
                    _872 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_852) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
                else
                {
                    _872 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_852) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _126))).x;
                    break;
                }
            }
        }
        float _894;
        switch (0u)
        {
            default:
            {
                if (_850)
                {
                    _894 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_852) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _894 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_852) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        float _895 = mix(_872, _894, _140);
        float _896 = sin(_895);
        float _897 = cos(_895);
        _905 = (_838 * (-_896)) + (_840 * _897);
        _906 = (_838 * _897) + (_840 * _896);
    }
    else
    {
        _905 = _840;
        _906 = _838;
    }
    float3 _907 = cross(_374, _906);
    uint _915 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _916 = (gl_VertexIndex - gl_BaseVertex) & _915;
    uint _917 = _916 * 5u;
    float3 _928 = normalize((select(_905, _907, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_917 + 3u))).x) + (_906 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_917 + 2u))).x));
    float3 _939 = _928 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _375), _928) < 0.0)) ? (-1) : 1);
    float3 _940 = cross(_939, _374);
    float4 _941 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_917));
    float _942 = _941.x;
    uint _943 = _917 + 1u;
    float4 _944 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_943));
    float _945 = _944.x;
    float2 _946 = float2(_942, _945);
    float3 _947 = _946.xxx;
    float3 _948 = _906 * _947;
    float3 _949 = _946.yyy;
    float3 _950 = _907 * _949;
    float3 _951 = _948 + _950;
    float3 _952 = float3(_682);
    float3 _953 = _951 * _952;
    float3 _954 = _375 + _953;
    float3 _955 = _954 + View.View_PreViewTranslation;
    float _956 = _955.x;
    float _957 = _955.y;
    float _958 = _955.z;
    float4 _959 = float4(_956, _957, _958, 1.0);
    float4 _960 = float4(_959.x, _959.y, _959.z, _959.w);
    float4 _963 = View.View_TranslatedWorldToClip * _960;
    float4 _966 = float4(_940.x, _940.y, _940.z, float4(0.0).w);
    _966.w = 0.0;
    spvUnsafeArray<float4, 1> _971 = { float4(_626.x, _626.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = _966;
    out.out_var_TEXCOORD11_centroid = float4(_939, 1.0);
    out_var_TEXCOORD3 = _971;
    out.out_var_TEXCOORD6 = _960;
    out.gl_Position = _963;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

