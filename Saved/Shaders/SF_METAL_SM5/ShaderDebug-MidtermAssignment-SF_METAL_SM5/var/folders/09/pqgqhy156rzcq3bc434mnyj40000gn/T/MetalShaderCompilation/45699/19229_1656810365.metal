

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
    char _m4_pad[56];
    float NiagaraRibbonVF_OneOverInterpCount;
    int NiagaraRibbonVF_ParticleIdShift;
    int NiagaraRibbonVF_ParticleIdMask;
    int NiagaraRibbonVF_InterpIdShift;
    int NiagaraRibbonVF_InterpIdMask;
    int NiagaraRibbonVF_SliceVertexIdMask;
    int NiagaraRibbonVF_ShouldFlipNormalToView;
    char _m11_pad[36];
    uint NiagaraRibbonVF_bLocalSpace;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

vertex MainVertexShader_out Main_00004b1d_62c0eb7d(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(7)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(8)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    uint _95 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _96 = _95 + 1u;
    uint _112;
    uint _113;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _112 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _95))).x);
        _113 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _96))).x);
    }
    else
    {
        _112 = _95;
        _113 = _96;
    }
    float _126 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _331;
    float3 _332;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _136;
        int _138;
        float3 _184;
        switch (0u)
        {
            default:
            {
                uint _134 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _136 = (_134 & 2147483648u) != 0u;
                _138 = int(_134 & 2147483647u);
                if (_136)
                {
                    _184 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
                else
                {
                    _184 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
            }
        }
        float3 _232;
        switch (0u)
        {
            default:
            {
                if (_136)
                {
                    _232 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_138 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
                else
                {
                    _232 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_138 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
            }
        }
        bool _266;
        float4 _234 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_95));
        float4 _235 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_96));
        float3 _236 = _234.xyz;
        float3 _237 = _235.xyz;
        float _240 = _235.w - _234.w;
        float _241 = _126 * _126;
        float _242 = _241 * _126;
        float _244 = 3.0 * _241;
        float3 _261 = (((_184 * (((2.0 * _242) - _244) + 1.0)) + (_236 * (_240 * ((_242 - (2.0 * _241)) + _126)))) + (_237 * (_240 * (_242 - _241)))) + (_232 * (((-2.0) * _242) + _244));
        float3 _296;
        switch (0u)
        {
            default:
            {
                _266 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_266)
                {
                    _296 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _261.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _261.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _261.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _296 = _261;
                    break;
                }
            }
        }
        float3 _298 = mix(_236, _237, float3(_126));
        float3 _329;
        switch (0u)
        {
            default:
            {
                if (_266)
                {
                    _329 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _298.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _298.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _298.zzz);
                    break;
                }
                else
                {
                    _329 = _298;
                    break;
                }
            }
        }
        _331 = normalize(_329);
        _332 = _296;
    }
    else
    {
        _331 = float3(0.0);
        _332 = float3(0.0);
    }
    float _388;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _342;
        int _344;
        float _364;
        switch (0u)
        {
            default:
            {
                uint _340 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _342 = (_340 & 2147483648u) != 0u;
                _344 = int(_340 & 2147483647u);
                if (_342)
                {
                    _364 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_344) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
                else
                {
                    _364 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_344) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
            }
        }
        float _386;
        switch (0u)
        {
            default:
            {
                if (_342)
                {
                    _386 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_344) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
                else
                {
                    _386 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_344) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
            }
        }
        _388 = mix(_364, _386, _126);
    }
    else
    {
        _388 = 1.0;
    }
    float3 _535;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _401;
        int _403;
        float3 _449;
        switch (0u)
        {
            default:
            {
                uint _399 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _401 = (_399 & 2147483648u) != 0u;
                _403 = int(_399 & 2147483647u);
                if (_401)
                {
                    _449 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
                else
                {
                    _449 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
            }
        }
        float3 _497;
        switch (0u)
        {
            default:
            {
                if (_401)
                {
                    _497 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_403 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
                else
                {
                    _497 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_403 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
            }
        }
        float3 _499 = mix(_449, _497, float3(_126));
        float3 _533;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _533 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _499.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _499.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _499.zzz);
                    break;
                }
                else
                {
                    _533 = _499;
                    break;
                }
            }
        }
        _535 = normalize(_533);
    }
    else
    {
        _535 = normalize(View.View_WorldCameraOrigin - _332);
    }
    float3 _537 = normalize(cross(_535, _331));
    bool _540 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _544;
    if (_540)
    {
        _544 = -_535;
    }
    else
    {
        _544 = _537;
    }
    float3 _546 = select(_535, _537, bool3(_540));
    float3 _611;
    float3 _612;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _556;
        int _558;
        float _578;
        switch (0u)
        {
            default:
            {
                uint _554 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _556 = (_554 & 2147483648u) != 0u;
                _558 = int(_554 & 2147483647u);
                if (_556)
                {
                    _578 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
                else
                {
                    _578 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
            }
        }
        float _600;
        switch (0u)
        {
            default:
            {
                if (_556)
                {
                    _600 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
                else
                {
                    _600 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
            }
        }
        float _601 = mix(_578, _600, _126);
        float _602 = sin(_601);
        float _603 = cos(_601);
        _611 = (_544 * (-_602)) + (_546 * _603);
        _612 = (_544 * _603) + (_546 * _602);
    }
    else
    {
        _611 = _546;
        _612 = _544;
    }
    float3 _613 = cross(_331, _612);
    uint _621 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _622 = (gl_VertexIndex - gl_BaseVertex) & _621;
    uint _623 = _622 * 5u;
    float3 _634 = normalize((select(_611, _613, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_623 + 3u))).x) + (_612 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_623 + 2u))).x));
    float3 _645 = _634 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _332), _634) < 0.0)) ? (-1) : 1);
    float3 _646 = cross(_645, _331);
    float4 _647 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_623));
    float _648 = _647.x;
    uint _649 = _623 + 1u;
    float4 _650 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_649));
    float _651 = _650.x;
    float2 _652 = float2(_648, _651);
    float3 _653 = _652.xxx;
    float3 _654 = _612 * _653;
    float3 _655 = _652.yyy;
    float3 _656 = _613 * _655;
    float3 _657 = _654 + _656;
    float3 _658 = float3(_388);
    float3 _659 = _657 * _658;
    float3 _660 = _332 + _659;
    float3 _661 = _660 + View.View_PreViewTranslation;
    float _662 = _661.x;
    float _663 = _661.y;
    float _664 = _661.z;
    float4 _665 = float4(_662, _663, _664, 1.0);
    float4 _666 = float4(_665.x, _665.y, _665.z, _665.w);
    float4 _667 = View.View_TranslatedWorldToClip * _666;
    float4 _669 = float4(_646.x, _646.y, _646.z, float4(0.0).w);
    _669.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _669;
    out.out_var_TEXCOORD11_centroid = float4(_645, 1.0);
    out.out_var_TEXCOORD6 = _666;
    out.gl_Position = _667;
    return out;
}

