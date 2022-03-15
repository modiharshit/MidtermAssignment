

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
    char _m4_pad[56];
    float NiagaraRibbonVF_OneOverInterpCount;
    int NiagaraRibbonVF_ParticleIdShift;
    int NiagaraRibbonVF_ParticleIdMask;
    int NiagaraRibbonVF_InterpIdShift;
    int NiagaraRibbonVF_InterpIdMask;
    int NiagaraRibbonVF_SliceVertexIdMask;
    char _m10_pad[40];
    uint NiagaraRibbonVF_bLocalSpace;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_0000465d_c285c497(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(7)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(8)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _88 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _89 = _88 + 1u;
    uint _105;
    uint _106;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _105 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _88))).x);
        _106 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _89))).x);
    }
    else
    {
        _105 = _88;
        _106 = _89;
    }
    float _119 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _324;
    float3 _325;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _129;
        int _131;
        float3 _177;
        switch (0u)
        {
            default:
            {
                uint _127 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _129 = (_127 & 2147483648u) != 0u;
                _131 = int(_127 & 2147483647u);
                if (_129)
                {
                    _177 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x);
                    break;
                }
                else
                {
                    _177 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x);
                    break;
                }
            }
        }
        float3 _225;
        switch (0u)
        {
            default:
            {
                if (_129)
                {
                    _225 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_131 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x);
                    break;
                }
                else
                {
                    _225 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_131 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x);
                    break;
                }
            }
        }
        bool _259;
        float4 _227 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_88));
        float4 _228 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_89));
        float3 _229 = _227.xyz;
        float3 _230 = _228.xyz;
        float _233 = _228.w - _227.w;
        float _234 = _119 * _119;
        float _235 = _234 * _119;
        float _237 = 3.0 * _234;
        float3 _254 = (((_177 * (((2.0 * _235) - _237) + 1.0)) + (_229 * (_233 * ((_235 - (2.0 * _234)) + _119)))) + (_230 * (_233 * (_235 - _234)))) + (_225 * (((-2.0) * _235) + _237));
        float3 _289;
        switch (0u)
        {
            default:
            {
                _259 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_259)
                {
                    _289 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _254.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _254.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _254.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _289 = _254;
                    break;
                }
            }
        }
        float3 _291 = mix(_229, _230, float3(_119));
        float3 _322;
        switch (0u)
        {
            default:
            {
                if (_259)
                {
                    _322 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _291.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _291.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _291.zzz);
                    break;
                }
                else
                {
                    _322 = _291;
                    break;
                }
            }
        }
        _324 = normalize(_322);
        _325 = _289;
    }
    else
    {
        _324 = float3(0.0);
        _325 = float3(0.0);
    }
    float _381;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _335;
        int _337;
        float _357;
        switch (0u)
        {
            default:
            {
                uint _333 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _335 = (_333 & 2147483648u) != 0u;
                _337 = int(_333 & 2147483647u);
                if (_335)
                {
                    _357 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_337) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x;
                    break;
                }
                else
                {
                    _357 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_337) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x;
                    break;
                }
            }
        }
        float _379;
        switch (0u)
        {
            default:
            {
                if (_335)
                {
                    _379 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_337) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x;
                    break;
                }
                else
                {
                    _379 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_337) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x;
                    break;
                }
            }
        }
        _381 = mix(_357, _379, _119);
    }
    else
    {
        _381 = 1.0;
    }
    float3 _528;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _394;
        int _396;
        float3 _442;
        switch (0u)
        {
            default:
            {
                uint _392 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _394 = (_392 & 2147483648u) != 0u;
                _396 = int(_392 & 2147483647u);
                if (_394)
                {
                    _442 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x);
                    break;
                }
                else
                {
                    _442 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x);
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
                    _490 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x);
                    break;
                }
                else
                {
                    _490 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_396 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x);
                    break;
                }
            }
        }
        float3 _492 = mix(_442, _490, float3(_119));
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
        _528 = normalize(_526);
    }
    else
    {
        _528 = normalize(View.View_WorldCameraOrigin - _325);
    }
    float3 _530 = normalize(cross(_528, _324));
    bool _533 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _537;
    if (_533)
    {
        _537 = -_528;
    }
    else
    {
        _537 = _530;
    }
    float3 _600;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _549;
        int _551;
        float _571;
        switch (0u)
        {
            default:
            {
                uint _547 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _549 = (_547 & 2147483648u) != 0u;
                _551 = int(_547 & 2147483647u);
                if (_549)
                {
                    _571 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_551) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x;
                    break;
                }
                else
                {
                    _571 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_551) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _105))).x;
                    break;
                }
            }
        }
        float _593;
        switch (0u)
        {
            default:
            {
                if (_549)
                {
                    _593 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_551) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x;
                    break;
                }
                else
                {
                    _593 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_551) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _106))).x;
                    break;
                }
            }
        }
        float _594 = mix(_571, _593, _119);
        _600 = (_537 * cos(_594)) + (select(_528, _530, bool3(_533)) * sin(_594));
    }
    else
    {
        _600 = _537;
    }
    float3 _601 = cross(_324, _600);
    uint _604 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _605 = (gl_VertexIndex - gl_BaseVertex) & _604;
    uint _606 = _605 * 5u;
    float4 _608 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_606));
    float _609 = _608.x;
    uint _610 = _606 + 1u;
    float4 _611 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_610));
    float _612 = _611.x;
    float2 _613 = float2(_609, _612);
    float3 _614 = _613.xxx;
    float3 _615 = _600 * _614;
    float3 _616 = _613.yyy;
    float3 _617 = _601 * _616;
    float3 _618 = _615 + _617;
    float3 _619 = float3(_381);
    float3 _620 = _618 * _619;
    float3 _621 = _325 + _620;
    float3 _622 = _621 + View.View_PreViewTranslation;
    float _623 = _622.x;
    float _624 = _622.y;
    float _625 = _622.z;
    float4 _626 = float4(_623, _624, _625, 1.0);
    float4 _627 = float4(_626.x, _626.y, _626.z, _626.w);
    float4 _628 = View.View_TranslatedWorldToClip * _627;
    out.gl_Position = _628;
    return out;
}

