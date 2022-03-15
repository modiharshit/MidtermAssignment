

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
    int NiagaraRibbonVF_VelocityDataOffset;
    int NiagaraRibbonVF_WidthDataOffset;
    int NiagaraRibbonVF_TwistDataOffset;
    char _m4_pad[4];
    int NiagaraRibbonVF_FacingDataOffset;
    char _m5_pad[28];
    int NiagaraRibbonVF_DistanceFromStartOffset;
    int NiagaraRibbonVF_U0OverrideDataOffset;
    int NiagaraRibbonVF_V0RangeOverrideDataOffset;
    char _m8_pad[16];
    float NiagaraRibbonVF_OneOverInterpCount;
    int NiagaraRibbonVF_ParticleIdShift;
    int NiagaraRibbonVF_ParticleIdMask;
    int NiagaraRibbonVF_InterpIdShift;
    int NiagaraRibbonVF_InterpIdMask;
    int NiagaraRibbonVF_SliceVertexIdMask;
    int NiagaraRibbonVF_ShouldFlipNormalToView;
    int NiagaraRibbonVF_U0DistributionMode;
    char _m16_pad[16];
    float4 NiagaraRibbonVF_PackedVData;
    uint NiagaraRibbonVF_bLocalSpace;
};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD3_0 [[user(locn2)]];
    float4 out_var_PARTICLE_VELOCITY [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00008418_beae34c3(constant type_View& View [[buffer(7)]], constant type_Primitive& Primitive [[buffer(8)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(9)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<uint> NiagaraRibbonVFLooseParameters_MultiRibbonIndices [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(4)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(5)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(6)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    uint _112 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _113 = _112 + 1u;
    uint _129;
    uint _130;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _129 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _112))).x);
        _130 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _113))).x);
    }
    else
    {
        _129 = _112;
        _130 = _113;
    }
    float _143 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    int _148 = int(NiagaraRibbonVFLooseParameters_MultiRibbonIndices.read(uint(_112)).x) * 7;
    float4 _165 = NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_148 + 2)));
    float _166 = _165.x;
    float3 _377;
    float3 _378;
    float _379;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _181;
        int _183;
        float3 _229;
        switch (0u)
        {
            default:
            {
                uint _179 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _181 = (_179 & 2147483648u) != 0u;
                _183 = int(_179 & 2147483647u);
                if (_181)
                {
                    _229 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _229 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float3 _277;
        switch (0u)
        {
            default:
            {
                if (_181)
                {
                    _277 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
                else
                {
                    _277 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
            }
        }
        bool _311;
        float4 _279 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_112));
        float4 _280 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_113));
        float3 _281 = _279.xyz;
        float3 _282 = _280.xyz;
        float _283 = _280.w;
        float _284 = _279.w;
        float _285 = _283 - _284;
        float _286 = _143 * _143;
        float _287 = _286 * _143;
        float _289 = 3.0 * _286;
        float3 _306 = (((_229 * (((2.0 * _287) - _289) + 1.0)) + (_281 * (_285 * ((_287 - (2.0 * _286)) + _143)))) + (_282 * (_285 * (_287 - _286)))) + (_277 * (((-2.0) * _287) + _289));
        float3 _341;
        switch (0u)
        {
            default:
            {
                _311 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_311)
                {
                    _341 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _306.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _306.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _306.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _341 = _306;
                    break;
                }
            }
        }
        float3 _343 = mix(_281, _282, float3(_143));
        float3 _374;
        switch (0u)
        {
            default:
            {
                if (_311)
                {
                    _374 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _343.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _343.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _343.zzz);
                    break;
                }
                else
                {
                    _374 = _343;
                    break;
                }
            }
        }
        _377 = normalize(_374);
        _378 = _341;
        _379 = mix(_284, _283, _143);
    }
    else
    {
        _377 = float3(0.0);
        _378 = float3(0.0);
        _379 = 0.0;
    }
    float4 _528;
    if (NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset != (-1))
    {
        bool _389;
        int _391;
        float3 _437;
        switch (0u)
        {
            default:
            {
                uint _387 = uint(NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset);
                _389 = (_387 & 2147483648u) != 0u;
                _391 = int(_387 & 2147483647u);
                if (_389)
                {
                    _437 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _437 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float3 _485;
        switch (0u)
        {
            default:
            {
                if (_389)
                {
                    _485 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_391 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
                else
                {
                    _485 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_391 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
            }
        }
        float3 _487 = mix(_437, _485, float3(_143));
        float3 _521;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _521 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _487.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _487.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _487.zzz);
                    break;
                }
                else
                {
                    _521 = _487;
                    break;
                }
            }
        }
        _528 = float4(normalize(_521), length(_521));
    }
    else
    {
        _528 = float4(0.0);
    }
    float _663;
    if (NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset != (-1))
    {
        bool _617;
        int _619;
        float _639;
        switch (0u)
        {
            default:
            {
                uint _615 = uint(NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset);
                _617 = (_615 & 2147483648u) != 0u;
                _619 = int(_615 & 2147483647u);
                if (_617)
                {
                    _639 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_619) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _639 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_619) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        float _661;
        switch (0u)
        {
            default:
            {
                if (_617)
                {
                    _661 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_619) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
                else
                {
                    _661 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_619) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
            }
        }
        _663 = mix(_639, _661, _143);
    }
    else
    {
        float _612;
        if (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 0)
        {
            _612 = (float(_112 - as_type<uint>(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_148 + 6))).x)) + _143) * _166;
        }
        else
        {
            float _607;
            if ((NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 1) || (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 2))
            {
                _607 = _379 * _166;
            }
            else
            {
                float _605;
                if ((NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset != (-1)) && (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 3))
                {
                    bool _558;
                    int _560;
                    float _580;
                    switch (0u)
                    {
                        default:
                        {
                            uint _556 = uint(NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset);
                            _558 = (_556 & 2147483648u) != 0u;
                            _560 = int(_556 & 2147483647u);
                            if (_558)
                            {
                                _580 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_560) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                                break;
                            }
                            else
                            {
                                _580 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_560) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                                break;
                            }
                        }
                    }
                    float _602;
                    switch (0u)
                    {
                        default:
                        {
                            if (_558)
                            {
                                _602 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_560) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                                break;
                            }
                            else
                            {
                                _602 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_560) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                                break;
                            }
                        }
                    }
                    _605 = mix(_580, _602, _143) * _166;
                }
                else
                {
                    _605 = 0.0;
                }
                _607 = _605;
            }
            _612 = _607;
        }
        _663 = _612;
    }
    float _775;
    if (NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset != (-1))
    {
        bool _683;
        int _685;
        float2 _719;
        switch (0u)
        {
            default:
            {
                uint _681 = uint(NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset);
                _683 = (_681 & 2147483648u) != 0u;
                _685 = int(_681 & 2147483647u);
                if (_683)
                {
                    _719 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_685) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_685 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _719 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_685) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_685 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float2 _755;
        switch (0u)
        {
            default:
            {
                if (_683)
                {
                    _755 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_685) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_685 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
                else
                {
                    _755 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_685) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_685 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
            }
        }
        float2 _757 = mix(_719, _755, float2(_143));
        uint _763 = (((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u;
        _775 = (1.0 - (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_763)).x * _757.x)) + (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_763)).x * _757.y);
    }
    else
    {
        _775 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(((((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u))).x;
    }
    float2 _778 = (float2(_663, _775) * float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_148))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.x)) + float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_148 + 1))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.y);
    float _834;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _788;
        int _790;
        float _810;
        switch (0u)
        {
            default:
            {
                uint _786 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _788 = (_786 & 2147483648u) != 0u;
                _790 = int(_786 & 2147483647u);
                if (_788)
                {
                    _810 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_790) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _810 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_790) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        float _832;
        switch (0u)
        {
            default:
            {
                if (_788)
                {
                    _832 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_790) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
                else
                {
                    _832 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_790) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
            }
        }
        _834 = mix(_810, _832, _143);
    }
    else
    {
        _834 = 1.0;
    }
    float3 _981;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _847;
        int _849;
        float3 _895;
        switch (0u)
        {
            default:
            {
                uint _845 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _847 = (_845 & 2147483648u) != 0u;
                _849 = int(_845 & 2147483647u);
                if (_847)
                {
                    _895 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
                else
                {
                    _895 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x);
                    break;
                }
            }
        }
        float3 _943;
        switch (0u)
        {
            default:
            {
                if (_847)
                {
                    _943 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_849 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
                else
                {
                    _943 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_849 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x);
                    break;
                }
            }
        }
        float3 _945 = mix(_895, _943, float3(_143));
        float3 _979;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _979 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _945.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _945.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _945.zzz);
                    break;
                }
                else
                {
                    _979 = _945;
                    break;
                }
            }
        }
        _981 = normalize(_979);
    }
    else
    {
        _981 = normalize(View.View_WorldCameraOrigin - _378);
    }
    float3 _983 = normalize(cross(_981, _377));
    bool _986 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _990;
    if (_986)
    {
        _990 = -_981;
    }
    else
    {
        _990 = _983;
    }
    float3 _992 = select(_981, _983, bool3(_986));
    float3 _1057;
    float3 _1058;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _1002;
        int _1004;
        float _1024;
        switch (0u)
        {
            default:
            {
                uint _1000 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _1002 = (_1000 & 2147483648u) != 0u;
                _1004 = int(_1000 & 2147483647u);
                if (_1002)
                {
                    _1024 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1004) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
                else
                {
                    _1024 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1004) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _129))).x;
                    break;
                }
            }
        }
        float _1046;
        switch (0u)
        {
            default:
            {
                if (_1002)
                {
                    _1046 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1004) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
                else
                {
                    _1046 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1004) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _130))).x;
                    break;
                }
            }
        }
        float _1047 = mix(_1024, _1046, _143);
        float _1048 = sin(_1047);
        float _1049 = cos(_1047);
        _1057 = (_990 * (-_1048)) + (_992 * _1049);
        _1058 = (_990 * _1049) + (_992 * _1048);
    }
    else
    {
        _1057 = _992;
        _1058 = _990;
    }
    float3 _1059 = cross(_377, _1058);
    uint _1067 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _1068 = (gl_VertexIndex - gl_BaseVertex) & _1067;
    uint _1069 = _1068 * 5u;
    float3 _1080 = normalize((select(_1057, _1059, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_1069 + 3u))).x) + (_1058 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_1069 + 2u))).x));
    float3 _1091 = _1080 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _378), _1080) < 0.0)) ? (-1) : 1);
    float3 _1092 = cross(_1091, _377);
    float4 _1093 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1069));
    float _1094 = _1093.x;
    uint _1095 = _1069 + 1u;
    float4 _1096 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1095));
    float _1097 = _1096.x;
    float2 _1098 = float2(_1094, _1097);
    float3 _1099 = _1098.xxx;
    float3 _1100 = _1058 * _1099;
    float3 _1101 = _1098.yyy;
    float3 _1102 = _1059 * _1101;
    float3 _1103 = _1100 + _1102;
    float3 _1104 = float3(_834);
    float3 _1105 = _1103 * _1104;
    float3 _1106 = _378 + _1105;
    float3 _1107 = _1106 + View.View_PreViewTranslation;
    float _1108 = _1107.x;
    float _1109 = _1107.y;
    float _1110 = _1107.z;
    float4 _1111 = float4(_1108, _1109, _1110, 1.0);
    float4 _1112 = float4(_1111.x, _1111.y, _1111.z, _1111.w);
    float4 _1113 = View.View_TranslatedWorldToClip * _1112;
    float4 _1116 = float4(_1092.x, _1092.y, _1092.z, float4(0.0).w);
    _1116.w = 0.0;
    spvUnsafeArray<float4, 1> _1121 = { float4(_778.x, _778.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = _1116;
    out.out_var_TEXCOORD11_centroid = float4(_1091, 1.0);
    out_var_TEXCOORD3 = _1121;
    out.out_var_PARTICLE_VELOCITY = _528;
    out.gl_Position = _1113;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

