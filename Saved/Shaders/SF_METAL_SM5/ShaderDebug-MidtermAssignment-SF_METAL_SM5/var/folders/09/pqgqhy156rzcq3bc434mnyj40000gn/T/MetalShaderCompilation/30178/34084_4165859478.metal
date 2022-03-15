

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
    char _m3_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m4_pad[640];
    int View_NumSceneColorMSAASamples;
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
    float NiagaraRibbonVF_DeltaSeconds;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

vertex MainVertexShader_out Main_00008524_f84df896(constant type_View& View [[buffer(7)]], constant type_Primitive& Primitive [[buffer(8)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(9)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<uint> NiagaraRibbonVFLooseParameters_MultiRibbonIndices [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(4)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(5)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(6)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    uint _117 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _118 = _117 + 1u;
    uint _134;
    uint _135;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _134 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _117))).x);
        _135 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _118))).x);
    }
    else
    {
        _134 = _117;
        _135 = _118;
    }
    float _148 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    int _153 = int(NiagaraRibbonVFLooseParameters_MultiRibbonIndices.read(uint(_117)).x) * 7;
    float4 _170 = NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_153 + 2)));
    float _171 = _170.x;
    float3 _382;
    float3 _383;
    float _384;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _186;
        int _188;
        float3 _234;
        switch (0u)
        {
            default:
            {
                uint _184 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _186 = (_184 & 2147483648u) != 0u;
                _188 = int(_184 & 2147483647u);
                if (_186)
                {
                    _234 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
                else
                {
                    _234 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
            }
        }
        float3 _282;
        switch (0u)
        {
            default:
            {
                if (_186)
                {
                    _282 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_188 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
                else
                {
                    _282 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_188 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
            }
        }
        bool _316;
        float4 _284 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_117));
        float4 _285 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_118));
        float3 _286 = _284.xyz;
        float3 _287 = _285.xyz;
        float _288 = _285.w;
        float _289 = _284.w;
        float _290 = _288 - _289;
        float _291 = _148 * _148;
        float _292 = _291 * _148;
        float _294 = 3.0 * _291;
        float3 _311 = (((_234 * (((2.0 * _292) - _294) + 1.0)) + (_286 * (_290 * ((_292 - (2.0 * _291)) + _148)))) + (_287 * (_290 * (_292 - _291)))) + (_282 * (((-2.0) * _292) + _294));
        float3 _346;
        switch (0u)
        {
            default:
            {
                _316 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_316)
                {
                    _346 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _311.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _311.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _311.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _346 = _311;
                    break;
                }
            }
        }
        float3 _348 = mix(_286, _287, float3(_148));
        float3 _379;
        switch (0u)
        {
            default:
            {
                if (_316)
                {
                    _379 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _348.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _348.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _348.zzz);
                    break;
                }
                else
                {
                    _379 = _348;
                    break;
                }
            }
        }
        _382 = normalize(_379);
        _383 = _346;
        _384 = mix(_289, _288, _148);
    }
    else
    {
        _382 = float3(0.0);
        _383 = float3(0.0);
        _384 = 0.0;
    }
    float4 _533;
    if (NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset != (-1))
    {
        bool _394;
        int _396;
        float3 _442;
        switch (0u)
        {
            default:
            {
                uint _392 = uint(NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset);
                _394 = (_392 & 2147483648u) != 0u;
                _396 = int(_392 & 2147483647u);
                if (_394)
                {
                    _442 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
                else
                {
                    _442 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
            }
        }
        float3 _490;
        switch (0u)
        {
            default:
            {
                if (_394)
                {
                    _490 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
                else
                {
                    _490 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
            }
        }
        float3 _492 = mix(_442, _490, float3(_148));
        float3 _526;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _526 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _492.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _492.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _492.zzz);
                    break;
                }
                else
                {
                    _526 = _492;
                    break;
                }
            }
        }
        _533 = float4(normalize(_526), length(_526));
    }
    else
    {
        _533 = float4(0.0);
    }
    float _668;
    if (NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset != (-1))
    {
        bool _622;
        int _624;
        float _644;
        switch (0u)
        {
            default:
            {
                uint _620 = uint(NiagaraRibbonVF.NiagaraRibbonVF_U0OverrideDataOffset);
                _622 = (_620 & 2147483648u) != 0u;
                _624 = int(_620 & 2147483647u);
                if (_622)
                {
                    _644 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_624) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
                else
                {
                    _644 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_624) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
            }
        }
        float _666;
        switch (0u)
        {
            default:
            {
                if (_622)
                {
                    _666 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_624) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
                else
                {
                    _666 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_624) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
            }
        }
        _668 = mix(_644, _666, _148);
    }
    else
    {
        float _617;
        if (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 0)
        {
            _617 = (float(_117 - as_type<uint>(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_153 + 6))).x)) + _148) * _171;
        }
        else
        {
            float _612;
            if ((NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 1) || (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 2))
            {
                _612 = _384 * _171;
            }
            else
            {
                float _610;
                if ((NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset != (-1)) && (NiagaraRibbonVF.NiagaraRibbonVF_U0DistributionMode == 3))
                {
                    bool _563;
                    int _565;
                    float _585;
                    switch (0u)
                    {
                        default:
                        {
                            uint _561 = uint(NiagaraRibbonVF.NiagaraRibbonVF_DistanceFromStartOffset);
                            _563 = (_561 & 2147483648u) != 0u;
                            _565 = int(_561 & 2147483647u);
                            if (_563)
                            {
                                _585 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                                break;
                            }
                            else
                            {
                                _585 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                                break;
                            }
                        }
                    }
                    float _607;
                    switch (0u)
                    {
                        default:
                        {
                            if (_563)
                            {
                                _607 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                                break;
                            }
                            else
                            {
                                _607 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                                break;
                            }
                        }
                    }
                    _610 = mix(_585, _607, _148) * _171;
                }
                else
                {
                    _610 = 0.0;
                }
                _612 = _610;
            }
            _617 = _612;
        }
        _668 = _617;
    }
    float _780;
    if (NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset != (-1))
    {
        bool _688;
        int _690;
        float2 _724;
        switch (0u)
        {
            default:
            {
                uint _686 = uint(NiagaraRibbonVF.NiagaraRibbonVF_V0RangeOverrideDataOffset);
                _688 = (_686 & 2147483648u) != 0u;
                _690 = int(_686 & 2147483647u);
                if (_688)
                {
                    _724 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_690) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_690 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
                else
                {
                    _724 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_690) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_690 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
            }
        }
        float2 _760;
        switch (0u)
        {
            default:
            {
                if (_688)
                {
                    _760 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_690) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_690 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
                else
                {
                    _760 = float2(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_690) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_690 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
            }
        }
        float2 _762 = mix(_724, _760, float2(_148));
        uint _768 = (((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u;
        _780 = (1.0 - (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_768)).x * _762.x)) + (NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_768)).x * _762.y);
    }
    else
    {
        _780 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(((((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u) + 4u))).x;
    }
    float2 _783 = (float2(_668, _780) * float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_153))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.x)) + float2(NiagaraRibbonVFLooseParameters_PackedPerRibbonDataByIndex.read(uint(uint(_153 + 1))).x, NiagaraRibbonVF.NiagaraRibbonVF_PackedVData.y);
    float _839;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _793;
        int _795;
        float _815;
        switch (0u)
        {
            default:
            {
                uint _791 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _793 = (_791 & 2147483648u) != 0u;
                _795 = int(_791 & 2147483647u);
                if (_793)
                {
                    _815 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_795) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
                else
                {
                    _815 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_795) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
            }
        }
        float _837;
        switch (0u)
        {
            default:
            {
                if (_793)
                {
                    _837 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_795) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
                else
                {
                    _837 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_795) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
            }
        }
        _839 = mix(_815, _837, _148);
    }
    else
    {
        _839 = 1.0;
    }
    float3 _986;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _852;
        int _854;
        float3 _900;
        switch (0u)
        {
            default:
            {
                uint _850 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _852 = (_850 & 2147483648u) != 0u;
                _854 = int(_850 & 2147483647u);
                if (_852)
                {
                    _900 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
                else
                {
                    _900 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                    break;
                }
            }
        }
        float3 _948;
        switch (0u)
        {
            default:
            {
                if (_852)
                {
                    _948 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_854 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
                else
                {
                    _948 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_854 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x);
                    break;
                }
            }
        }
        float3 _950 = mix(_900, _948, float3(_148));
        float3 _984;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _984 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _950.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _950.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _950.zzz);
                    break;
                }
                else
                {
                    _984 = _950;
                    break;
                }
            }
        }
        _986 = normalize(_984);
    }
    else
    {
        _986 = normalize(View.View_WorldCameraOrigin - _383);
    }
    float3 _988 = normalize(cross(_986, _382));
    bool _991 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _995;
    if (_991)
    {
        _995 = -_986;
    }
    else
    {
        _995 = _988;
    }
    float3 _997 = select(_986, _988, bool3(_991));
    float3 _1062;
    float3 _1063;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _1007;
        int _1009;
        float _1029;
        switch (0u)
        {
            default:
            {
                uint _1005 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _1007 = (_1005 & 2147483648u) != 0u;
                _1009 = int(_1005 & 2147483647u);
                if (_1007)
                {
                    _1029 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1009) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
                else
                {
                    _1029 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1009) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                    break;
                }
            }
        }
        float _1051;
        switch (0u)
        {
            default:
            {
                if (_1007)
                {
                    _1051 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1009) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
                else
                {
                    _1051 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1009) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _135))).x;
                    break;
                }
            }
        }
        float _1052 = mix(_1029, _1051, _148);
        float _1053 = sin(_1052);
        float _1054 = cos(_1052);
        _1062 = (_995 * (-_1053)) + (_997 * _1054);
        _1063 = (_995 * _1054) + (_997 * _1053);
    }
    else
    {
        _1062 = _997;
        _1063 = _995;
    }
    float3 _1064 = cross(_382, _1063);
    uint _1074 = ((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u;
    float3 _1085 = normalize((select(_1062, _1064, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_1074 + 3u))).x) + (_1063 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_1074 + 2u))).x));
    float3 _1096 = _1085 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _383), _1085) < 0.0)) ? (-1) : 1);
    float3 _1097 = cross(_1096, _382);
    uint _1100 = _1074 + 1u;
    float2 _1103 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1074)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1100)).x);
    float3 _1109 = float3(_839);
    float4 _1118 = float4(_1097.x, _1097.y, _1097.z, float4(0.0).w);
    _1118.w = 0.0;
    spvUnsafeArray<float4, 1> _1123 = { float4(_783.x, _783.y, float4(0.0).z, float4(0.0).w) };
    float2 _1128 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1074)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_1100)).x);
    float4 _1155 = View.View_TranslatedWorldToClip * float4((_383 + (((_1063 * _1103.xxx) + (_1064 * _1103.yyy)) * _1109)) + View.View_PreViewTranslation, 1.0);
    float4 _1164 = _1155;
    _1164.z = _1155.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1155.w) : 0.0);
    out.gl_Position = _1164;
    out.out_var_TEXCOORD6 = _1155;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(float4((_383 + (((_1063 * _1128.xxx) + (_1064 * _1128.yyy)) * _1109)) + View.View_PreViewTranslation, 1.0).xyz - (_533.xyz * (_533.w * NiagaraRibbonVF.NiagaraRibbonVF_DeltaSeconds)), 1.0);
    out.out_var_TEXCOORD10_centroid = _1118;
    out.out_var_TEXCOORD11_centroid = float4(_1096, 1.0);
    out_var_TEXCOORD3 = _1123;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

