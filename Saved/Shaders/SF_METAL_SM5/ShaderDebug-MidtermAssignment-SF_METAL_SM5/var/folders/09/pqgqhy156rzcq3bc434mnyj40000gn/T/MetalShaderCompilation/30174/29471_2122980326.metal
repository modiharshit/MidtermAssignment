

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
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_0000731f_7e8a1be6(constant type_View& View [[buffer(7)]], constant type_Primitive& Primitive [[buffer(8)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(9)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<uint> NiagaraRibbonVFLooseParameters_MultiRibbonIndices [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(4)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(5)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(6)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    uint _110 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _111 = _110 + 1u;
    uint _127;
    uint _128;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _127 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _110))).x);
        _128 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _111))).x);
    }
    else
    {
        _127 = _110;
        _128 = _111;
    }
    float _141 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    int _146 = int(NiagaraRibbonVFLooseParameters_MultiRibbonIndices.read(uint(_110)).x) * 7;
    float4 _163 = NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_146 + 2)));
    float _164 = _163.x;
    float3 _375;
    float3 _376;
    float _377;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _179;
        int _181;
        float3 _227;
        switch (0u)
        {
            default:
            {
                uint _177 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _179 = (_177 & 2147483648u) != 0u;
                _181 = int(_177 & 2147483647u);
                if (_179)
                {
                    _227 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _227 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        float3 _275;
        switch (0u)
        {
            default:
            {
                if (_179)
                {
                    _275 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_181 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _275 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_181 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        bool _309;
        float4 _277 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_110));
        float4 _278 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_111));
        float3 _279 = _277.xyz;
        float3 _280 = _278.xyz;
        float _281 = _278.w;
        float _282 = _277.w;
        float _283 = _281 - _282;
        float _284 = _141 * _141;
        float _285 = _284 * _141;
        float _287 = 3.0 * _284;
        float3 _304 = (((_227 * (((2.0 * _285) - _287) + 1.0)) + (_279 * (_283 * ((_285 - (2.0 * _284)) + _141)))) + (_280 * (_283 * (_285 - _284)))) + (_275 * (((-2.0) * _285) + _287));
        float3 _339;
        switch (0u)
        {
            default:
            {
                _309 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_309)
                {
                    _339 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _304.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _304.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _304.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _339 = _304;
                    break;
                }
            }
        }
        float3 _341 = mix(_279, _280, float3(_141));
        float3 _372;
        switch (0u)
        {
            default:
            {
                if (_309)
                {
                    _372 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _341.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _341.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _341.zzz);
                    break;
                }
                else
                {
                    _372 = _341;
                    break;
                }
            }
        }
        _375 = normalize(_372);
        _376 = _339;
        _377 = mix(_282, _281, _141);
    }
    else
    {
        _375 = float3(0.0);
        _376 = float3(0.0);
        _377 = 0.0;
    }
    float _512;
    if (NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset != (-1))
    {
        bool _466;
        int _468;
        float _488;
        switch (0u)
        {
            default:
            {
                uint _464 = uint(NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset);
                _466 = (_464 & 2147483648u) != 0u;
                _468 = int(_464 & 2147483647u);
                if (_466)
                {
                    _488 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_468) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _488 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_468) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        float _510;
        switch (0u)
        {
            default:
            {
                if (_466)
                {
                    _510 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_468) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _510 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_468) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        _512 = mix(_488, _510, _141);
    }
    else
    {
        float _461;
        if (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 0)
        {
            _461 = (float(_110 - as_type<uint>(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_146 + 6))).x)) + _141) * _164;
        }
        else
        {
            float _456;
            if ((NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 1) || (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 2))
            {
                _456 = _377 * _164;
            }
            else
            {
                float _454;
                if ((NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset != (-1)) && (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 3))
                {
                    bool _407;
                    int _409;
                    float _429;
                    switch (0u)
                    {
                        default:
                        {
                            uint _405 = uint(NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset);
                            _407 = (_405 & 2147483648u) != 0u;
                            _409 = int(_405 & 2147483647u);
                            if (_407)
                            {
                                _429 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                                break;
                            }
                            else
                            {
                                _429 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                                break;
                            }
                        }
                    }
                    float _451;
                    switch (0u)
                    {
                        default:
                        {
                            if (_407)
                            {
                                _451 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                                break;
                            }
                            else
                            {
                                _451 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                                break;
                            }
                        }
                    }
                    _454 = mix(_429, _451, _141) * _164;
                }
                else
                {
                    _454 = 0.0;
                }
                _456 = _454;
            }
            _461 = _456;
        }
        _512 = _461;
    }
    float _624;
    if (NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset != (-1))
    {
        bool _532;
        int _534;
        float2 _568;
        switch (0u)
        {
            default:
            {
                uint _530 = uint(NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset);
                _532 = (_530 & 2147483648u) != 0u;
                _534 = int(_530 & 2147483647u);
                if (_532)
                {
                    _568 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_534) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_534 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _568 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_534) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_534 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        float2 _604;
        switch (0u)
        {
            default:
            {
                if (_532)
                {
                    _604 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_534) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_534 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _604 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_534) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_534 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        float2 _606 = mix(_568, _604, float2(_141));
        uint _612 = (((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u;
        _624 = (1.0 - (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_612)).x * _606.x)) + (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_612)).x * _606.y);
    }
    else
    {
        _624 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(((((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u))).x;
    }
    float2 _627 = (float2(_512, _624) * float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_146))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.x)) + float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_146 + 1))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.y);
    float _683;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _637;
        int _639;
        float _659;
        switch (0u)
        {
            default:
            {
                uint _635 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _637 = (_635 & 2147483648u) != 0u;
                _639 = int(_635 & 2147483647u);
                if (_637)
                {
                    _659 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_639) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _659 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_639) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        float _681;
        switch (0u)
        {
            default:
            {
                if (_637)
                {
                    _681 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_639) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _681 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_639) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        _683 = mix(_659, _681, _141);
    }
    else
    {
        _683 = 1.0;
    }
    float3 _830;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _696;
        int _698;
        float3 _744;
        switch (0u)
        {
            default:
            {
                uint _694 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _696 = (_694 & 2147483648u) != 0u;
                _698 = int(_694 & 2147483647u);
                if (_696)
                {
                    _744 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
                else
                {
                    _744 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x);
                    break;
                }
            }
        }
        float3 _792;
        switch (0u)
        {
            default:
            {
                if (_696)
                {
                    _792 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_698 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
                else
                {
                    _792 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_698 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x);
                    break;
                }
            }
        }
        float3 _794 = mix(_744, _792, float3(_141));
        float3 _828;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _828 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _794.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _794.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _794.zzz);
                    break;
                }
                else
                {
                    _828 = _794;
                    break;
                }
            }
        }
        _830 = normalize(_828);
    }
    else
    {
        _830 = normalize(View.View_WorldCameraOrigin - _376);
    }
    float3 _832 = normalize(cross(_830, _375));
    bool _835 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _839;
    if (_835)
    {
        _839 = -_830;
    }
    else
    {
        _839 = _832;
    }
    float3 _841 = select(_830, _832, bool3(_835));
    float3 _906;
    float3 _907;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _851;
        int _853;
        float _873;
        switch (0u)
        {
            default:
            {
                uint _849 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _851 = (_849 & 2147483648u) != 0u;
                _853 = int(_849 & 2147483647u);
                if (_851)
                {
                    _873 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_853) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
                else
                {
                    _873 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_853) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _127))).x;
                    break;
                }
            }
        }
        float _895;
        switch (0u)
        {
            default:
            {
                if (_851)
                {
                    _895 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_853) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
                else
                {
                    _895 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_853) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _128))).x;
                    break;
                }
            }
        }
        float _896 = mix(_873, _895, _141);
        float _897 = sin(_896);
        float _898 = cos(_896);
        _906 = (_839 * (-_897)) + (_841 * _898);
        _907 = (_839 * _898) + (_841 * _897);
    }
    else
    {
        _906 = _841;
        _907 = _839;
    }
    float3 _908 = cross(_375, _907);
    uint _916 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _917 = (gl_VertexIndex - gl_BaseVertex) & _916;
    uint _918 = _917 * 5u;
    float3 _929 = normalize((select(_906, _908, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_918 + 3u))).x) + (_907 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_918 + 2u))).x));
    float3 _940 = _929 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _376), _929) < 0.0)) ? (-1) : 1);
    float3 _941 = cross(_940, _375);
    float4 _942 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_918));
    float _943 = _942.x;
    uint _944 = _918 + 1u;
    float4 _945 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_944));
    float _946 = _945.x;
    float2 _947 = float2(_943, _946);
    float3 _948 = _947.xxx;
    float3 _949 = _907 * _948;
    float3 _950 = _947.yyy;
    float3 _951 = _908 * _950;
    float3 _952 = _949 + _951;
    float3 _953 = float3(_683);
    float3 _954 = _952 * _953;
    float3 _955 = _376 + _954;
    float3 _956 = _955 + View.View_PreViewTranslation;
    float _957 = _956.x;
    float _958 = _956.y;
    float _959 = _956.z;
    float4 _960 = float4(_957, _958, _959, 1.0);
    float4 _961 = float4(_960.x, _960.y, _960.z, _960.w);
    float4 _962 = View.View_TranslatedWorldToClip * _961;
    float4 _965 = float4(_941.x, _941.y, _941.z, float4(0.0).w);
    _965.w = 0.0;
    spvUnsafeArray<float4, 1> _970 = { float4(_627.x, _627.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = _965;
    out.out_var_TEXCOORD11_centroid = float4(_940, 1.0);
    out_var_TEXCOORD3 = _970;
    out.gl_Position = _962;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

