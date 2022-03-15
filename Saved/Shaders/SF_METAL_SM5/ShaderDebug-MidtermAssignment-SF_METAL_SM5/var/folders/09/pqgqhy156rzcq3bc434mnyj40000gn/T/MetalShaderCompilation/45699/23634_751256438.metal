

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m5_pad[56];
    float NiagaraRibbonVF_OneOverInterpCount;
    int NiagaraRibbonVF_ParticleIdShift;
    int NiagaraRibbonVF_ParticleIdMask;
    int NiagaraRibbonVF_InterpIdShift;
    int NiagaraRibbonVF_InterpIdMask;
    int NiagaraRibbonVF_SliceVertexIdMask;
    int NiagaraRibbonVF_ShouldFlipNormalToView;
    char _m12_pad[36];
    uint NiagaraRibbonVF_bLocalSpace;
    float NiagaraRibbonVF_DeltaSeconds;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex MainVertexShader_out Main_00005c52_2cc74376(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(7)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(8)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    uint _101 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _102 = _101 + 1u;
    uint _118;
    uint _119;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _118 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _101))).x);
        _119 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _102))).x);
    }
    else
    {
        _118 = _101;
        _119 = _102;
    }
    float _132 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _337;
    float3 _338;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _142;
        int _144;
        float3 _190;
        switch (0u)
        {
            default:
            {
                uint _140 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _142 = (_140 & 2147483648u) != 0u;
                _144 = int(_140 & 2147483647u);
                if (_142)
                {
                    _190 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _190 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        float3 _238;
        switch (0u)
        {
            default:
            {
                if (_142)
                {
                    _238 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_144 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _238 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_144 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        bool _272;
        float4 _240 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_101));
        float4 _241 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_102));
        float3 _242 = _240.xyz;
        float3 _243 = _241.xyz;
        float _246 = _241.w - _240.w;
        float _247 = _132 * _132;
        float _248 = _247 * _132;
        float _250 = 3.0 * _247;
        float3 _267 = (((_190 * (((2.0 * _248) - _250) + 1.0)) + (_242 * (_246 * ((_248 - (2.0 * _247)) + _132)))) + (_243 * (_246 * (_248 - _247)))) + (_238 * (((-2.0) * _248) + _250));
        float3 _302;
        switch (0u)
        {
            default:
            {
                _272 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_272)
                {
                    _302 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _267.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _267.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _267.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _302 = _267;
                    break;
                }
            }
        }
        float3 _304 = mix(_242, _243, float3(_132));
        float3 _335;
        switch (0u)
        {
            default:
            {
                if (_272)
                {
                    _335 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _304.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _304.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _304.zzz);
                    break;
                }
                else
                {
                    _335 = _304;
                    break;
                }
            }
        }
        _337 = normalize(_335);
        _338 = _302;
    }
    else
    {
        _337 = float3(0.0);
        _338 = float3(0.0);
    }
    float4 _487;
    if (NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset != (-1))
    {
        bool _348;
        int _350;
        float3 _396;
        switch (0u)
        {
            default:
            {
                uint _346 = uint(NiagaraRibbonVF.NiagaraRibbonVF_VelocityDataOffset);
                _348 = (_346 & 2147483648u) != 0u;
                _350 = int(_346 & 2147483647u);
                if (_348)
                {
                    _396 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _396 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        float3 _444;
        switch (0u)
        {
            default:
            {
                if (_348)
                {
                    _444 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _444 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        float3 _446 = mix(_396, _444, float3(_132));
        float3 _480;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _480 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _446.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _446.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _446.zzz);
                    break;
                }
                else
                {
                    _480 = _446;
                    break;
                }
            }
        }
        _487 = float4(normalize(_480), length(_480));
    }
    else
    {
        _487 = float4(0.0);
    }
    float _543;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _497;
        int _499;
        float _519;
        switch (0u)
        {
            default:
            {
                uint _495 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _497 = (_495 & 2147483648u) != 0u;
                _499 = int(_495 & 2147483647u);
                if (_497)
                {
                    _519 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_499) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _519 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_499) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        float _541;
        switch (0u)
        {
            default:
            {
                if (_497)
                {
                    _541 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_499) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _541 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_499) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
            }
        }
        _543 = mix(_519, _541, _132);
    }
    else
    {
        _543 = 1.0;
    }
    float3 _690;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _556;
        int _558;
        float3 _604;
        switch (0u)
        {
            default:
            {
                uint _554 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _556 = (_554 & 2147483648u) != 0u;
                _558 = int(_554 & 2147483647u);
                if (_556)
                {
                    _604 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _604 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        float3 _652;
        switch (0u)
        {
            default:
            {
                if (_556)
                {
                    _652 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _652 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        float3 _654 = mix(_604, _652, float3(_132));
        float3 _688;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _688 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _654.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _654.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _654.zzz);
                    break;
                }
                else
                {
                    _688 = _654;
                    break;
                }
            }
        }
        _690 = normalize(_688);
    }
    else
    {
        _690 = normalize(View.View_WorldCameraOrigin - _338);
    }
    float3 _692 = normalize(cross(_690, _337));
    bool _695 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _699;
    if (_695)
    {
        _699 = -_690;
    }
    else
    {
        _699 = _692;
    }
    float3 _701 = select(_690, _692, bool3(_695));
    float3 _766;
    float3 _767;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _711;
        int _713;
        float _733;
        switch (0u)
        {
            default:
            {
                uint _709 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _711 = (_709 & 2147483648u) != 0u;
                _713 = int(_709 & 2147483647u);
                if (_711)
                {
                    _733 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_713) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _733 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_713) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        float _755;
        switch (0u)
        {
            default:
            {
                if (_711)
                {
                    _755 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_713) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _755 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_713) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
            }
        }
        float _756 = mix(_733, _755, _132);
        float _757 = sin(_756);
        float _758 = cos(_756);
        _766 = (_699 * (-_757)) + (_701 * _758);
        _767 = (_699 * _758) + (_701 * _757);
    }
    else
    {
        _766 = _701;
        _767 = _699;
    }
    float3 _768 = cross(_337, _767);
    uint _778 = ((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u;
    float3 _789 = normalize((select(_766, _768, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_778 + 3u))).x) + (_767 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_778 + 2u))).x));
    float3 _800 = _789 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _338), _789) < 0.0)) ? (-1) : 1);
    float3 _801 = cross(_800, _337);
    uint _804 = _778 + 1u;
    float2 _807 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_778)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_804)).x);
    float3 _813 = float3(_543);
    float4 _821 = float4(_801.x, _801.y, _801.z, float4(0.0).w);
    _821.w = 0.0;
    float2 _830 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_778)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_804)).x);
    float4 _857 = View.View_TranslatedWorldToClip * float4((_338 + (((_767 * _807.xxx) + (_768 * _807.yyy)) * _813)) + View.View_PreViewTranslation, 1.0);
    float4 _866 = _857;
    _866.z = _857.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _857.w) : 0.0);
    out.gl_Position = _866;
    out.out_var_TEXCOORD6 = _857;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(float4((_338 + (((_767 * _830.xxx) + (_768 * _830.yyy)) * _813)) + View.View_PreViewTranslation, 1.0).xyz - (_487.xyz * (_487.w * NiagaraRibbonVF.NiagaraRibbonVF_DeltaSeconds)), 1.0);
    out.out_var_TEXCOORD10_centroid = _821;
    out.out_var_TEXCOORD11_centroid = float4(_800, 1.0);
    return out;
}

