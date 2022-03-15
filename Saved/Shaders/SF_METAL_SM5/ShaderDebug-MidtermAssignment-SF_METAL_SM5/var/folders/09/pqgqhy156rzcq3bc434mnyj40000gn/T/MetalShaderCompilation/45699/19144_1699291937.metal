

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

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004ac8_65492321(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(7)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(8)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _93 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _94 = _93 + 1u;
    uint _110;
    uint _111;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _110 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _93))).x);
        _111 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _94))).x);
    }
    else
    {
        _110 = _93;
        _111 = _94;
    }
    float _124 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _329;
    float3 _330;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _134;
        int _136;
        float3 _182;
        switch (0u)
        {
            default:
            {
                uint _132 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _134 = (_132 & 2147483648u) != 0u;
                _136 = int(_132 & 2147483647u);
                if (_134)
                {
                    _182 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x);
                    break;
                }
                else
                {
                    _182 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x);
                    break;
                }
            }
        }
        float3 _230;
        switch (0u)
        {
            default:
            {
                if (_134)
                {
                    _230 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_136 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
                else
                {
                    _230 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_136 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
            }
        }
        bool _264;
        float4 _232 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_93));
        float4 _233 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_94));
        float3 _234 = _232.xyz;
        float3 _235 = _233.xyz;
        float _238 = _233.w - _232.w;
        float _239 = _124 * _124;
        float _240 = _239 * _124;
        float _242 = 3.0 * _239;
        float3 _259 = (((_182 * (((2.0 * _240) - _242) + 1.0)) + (_234 * (_238 * ((_240 - (2.0 * _239)) + _124)))) + (_235 * (_238 * (_240 - _239)))) + (_230 * (((-2.0) * _240) + _242));
        float3 _294;
        switch (0u)
        {
            default:
            {
                _264 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_264)
                {
                    _294 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _259.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _259.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _259.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _294 = _259;
                    break;
                }
            }
        }
        float3 _296 = mix(_234, _235, float3(_124));
        float3 _327;
        switch (0u)
        {
            default:
            {
                if (_264)
                {
                    _327 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _296.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _296.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _296.zzz);
                    break;
                }
                else
                {
                    _327 = _296;
                    break;
                }
            }
        }
        _329 = normalize(_327);
        _330 = _294;
    }
    else
    {
        _329 = float3(0.0);
        _330 = float3(0.0);
    }
    float _386;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _340;
        int _342;
        float _362;
        switch (0u)
        {
            default:
            {
                uint _338 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _340 = (_338 & 2147483648u) != 0u;
                _342 = int(_338 & 2147483647u);
                if (_340)
                {
                    _362 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_342) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x;
                    break;
                }
                else
                {
                    _362 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_342) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x;
                    break;
                }
            }
        }
        float _384;
        switch (0u)
        {
            default:
            {
                if (_340)
                {
                    _384 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_342) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
                else
                {
                    _384 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_342) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
            }
        }
        _386 = mix(_362, _384, _124);
    }
    else
    {
        _386 = 1.0;
    }
    float3 _533;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _399;
        int _401;
        float3 _447;
        switch (0u)
        {
            default:
            {
                uint _397 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _399 = (_397 & 2147483648u) != 0u;
                _401 = int(_397 & 2147483647u);
                if (_399)
                {
                    _447 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x);
                    break;
                }
                else
                {
                    _447 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x);
                    break;
                }
            }
        }
        float3 _495;
        switch (0u)
        {
            default:
            {
                if (_399)
                {
                    _495 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_401 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
                else
                {
                    _495 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_401 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
            }
        }
        float3 _497 = mix(_447, _495, float3(_124));
        float3 _531;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _531 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _497.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _497.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _497.zzz);
                    break;
                }
                else
                {
                    _531 = _497;
                    break;
                }
            }
        }
        _533 = normalize(_531);
    }
    else
    {
        _533 = normalize(View.View_WorldCameraOrigin - _330);
    }
    float3 _535 = normalize(cross(_533, _329));
    bool _538 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _542;
    if (_538)
    {
        _542 = -_533;
    }
    else
    {
        _542 = _535;
    }
    float3 _544 = select(_533, _535, bool3(_538));
    float3 _609;
    float3 _610;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _554;
        int _556;
        float _576;
        switch (0u)
        {
            default:
            {
                uint _552 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _554 = (_552 & 2147483648u) != 0u;
                _556 = int(_552 & 2147483647u);
                if (_554)
                {
                    _576 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_556) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x;
                    break;
                }
                else
                {
                    _576 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_556) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _110))).x;
                    break;
                }
            }
        }
        float _598;
        switch (0u)
        {
            default:
            {
                if (_554)
                {
                    _598 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_556) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
                else
                {
                    _598 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_556) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
            }
        }
        float _599 = mix(_576, _598, _124);
        float _600 = sin(_599);
        float _601 = cos(_599);
        _609 = (_542 * (-_600)) + (_544 * _601);
        _610 = (_542 * _601) + (_544 * _600);
    }
    else
    {
        _609 = _544;
        _610 = _542;
    }
    float3 _611 = cross(_329, _610);
    uint _619 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _620 = (gl_VertexIndex - gl_BaseVertex) & _619;
    uint _621 = _620 * 5u;
    float3 _632 = normalize((select(_609, _611, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_621 + 3u))).x) + (_610 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_621 + 2u))).x));
    float3 _643 = _632 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _330), _632) < 0.0)) ? (-1) : 1);
    float3 _644 = cross(_643, _329);
    float4 _645 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_621));
    float _646 = _645.x;
    uint _647 = _621 + 1u;
    float4 _648 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_647));
    float _649 = _648.x;
    float2 _650 = float2(_646, _649);
    float3 _651 = _650.xxx;
    float3 _652 = _610 * _651;
    float3 _653 = _650.yyy;
    float3 _654 = _611 * _653;
    float3 _655 = _652 + _654;
    float3 _656 = float3(_386);
    float3 _657 = _655 * _656;
    float3 _658 = _330 + _657;
    float3 _659 = _658 + View.View_PreViewTranslation;
    float _660 = _659.x;
    float _661 = _659.y;
    float _662 = _659.z;
    float4 _663 = float4(_660, _661, _662, 1.0);
    float4 _664 = float4(_663.x, _663.y, _663.z, _663.w);
    float4 _667 = View.View_TranslatedWorldToClip * _664;
    float4 _669 = float4(_644.x, _644.y, _644.z, float4(0.0).w);
    _669.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _669;
    out.out_var_TEXCOORD11_centroid = float4(_643, 1.0);
    out.out_var_TEXCOORD6 = _664;
    out.gl_Position = _667;
    return out;
}

