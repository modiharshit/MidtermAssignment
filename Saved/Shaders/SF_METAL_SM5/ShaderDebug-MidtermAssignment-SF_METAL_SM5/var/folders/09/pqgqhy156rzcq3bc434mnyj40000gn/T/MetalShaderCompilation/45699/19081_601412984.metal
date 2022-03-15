

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
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004a89_23d8d578(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(7)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(8)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _94 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _95 = _94 + 1u;
    uint _111;
    uint _112;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _111 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _94))).x);
        _112 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _95))).x);
    }
    else
    {
        _111 = _94;
        _112 = _95;
    }
    float _125 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _330;
    float3 _331;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _135;
        int _137;
        float3 _183;
        switch (0u)
        {
            default:
            {
                uint _133 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _135 = (_133 & 2147483648u) != 0u;
                _137 = int(_133 & 2147483647u);
                if (_135)
                {
                    _183 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
                else
                {
                    _183 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
            }
        }
        float3 _231;
        switch (0u)
        {
            default:
            {
                if (_135)
                {
                    _231 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_137 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
                else
                {
                    _231 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_137 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
            }
        }
        bool _265;
        float4 _233 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_94));
        float4 _234 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_95));
        float3 _235 = _233.xyz;
        float3 _236 = _234.xyz;
        float _239 = _234.w - _233.w;
        float _240 = _125 * _125;
        float _241 = _240 * _125;
        float _243 = 3.0 * _240;
        float3 _260 = (((_183 * (((2.0 * _241) - _243) + 1.0)) + (_235 * (_239 * ((_241 - (2.0 * _240)) + _125)))) + (_236 * (_239 * (_241 - _240)))) + (_231 * (((-2.0) * _241) + _243));
        float3 _295;
        switch (0u)
        {
            default:
            {
                _265 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_265)
                {
                    _295 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _260.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _260.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _260.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _295 = _260;
                    break;
                }
            }
        }
        float3 _297 = mix(_235, _236, float3(_125));
        float3 _328;
        switch (0u)
        {
            default:
            {
                if (_265)
                {
                    _328 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _297.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _297.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _297.zzz);
                    break;
                }
                else
                {
                    _328 = _297;
                    break;
                }
            }
        }
        _330 = normalize(_328);
        _331 = _295;
    }
    else
    {
        _330 = float3(0.0);
        _331 = float3(0.0);
    }
    float _387;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _341;
        int _343;
        float _363;
        switch (0u)
        {
            default:
            {
                uint _339 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _341 = (_339 & 2147483648u) != 0u;
                _343 = int(_339 & 2147483647u);
                if (_341)
                {
                    _363 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_343) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
                else
                {
                    _363 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_343) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
            }
        }
        float _385;
        switch (0u)
        {
            default:
            {
                if (_341)
                {
                    _385 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_343) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
                else
                {
                    _385 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_343) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
            }
        }
        _387 = mix(_363, _385, _125);
    }
    else
    {
        _387 = 1.0;
    }
    float3 _534;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _400;
        int _402;
        float3 _448;
        switch (0u)
        {
            default:
            {
                uint _398 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _400 = (_398 & 2147483648u) != 0u;
                _402 = int(_398 & 2147483647u);
                if (_400)
                {
                    _448 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
                else
                {
                    _448 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x);
                    break;
                }
            }
        }
        float3 _496;
        switch (0u)
        {
            default:
            {
                if (_400)
                {
                    _496 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_402 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
                else
                {
                    _496 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_402 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x);
                    break;
                }
            }
        }
        float3 _498 = mix(_448, _496, float3(_125));
        float3 _532;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _532 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _498.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _498.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _498.zzz);
                    break;
                }
                else
                {
                    _532 = _498;
                    break;
                }
            }
        }
        _534 = normalize(_532);
    }
    else
    {
        _534 = normalize(View.View_WorldCameraOrigin - _331);
    }
    float3 _536 = normalize(cross(_534, _330));
    bool _539 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _543;
    if (_539)
    {
        _543 = -_534;
    }
    else
    {
        _543 = _536;
    }
    float3 _545 = select(_534, _536, bool3(_539));
    float3 _610;
    float3 _611;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _555;
        int _557;
        float _577;
        switch (0u)
        {
            default:
            {
                uint _553 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _555 = (_553 & 2147483648u) != 0u;
                _557 = int(_553 & 2147483647u);
                if (_555)
                {
                    _577 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_557) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
                else
                {
                    _577 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_557) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _111))).x;
                    break;
                }
            }
        }
        float _599;
        switch (0u)
        {
            default:
            {
                if (_555)
                {
                    _599 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_557) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
                else
                {
                    _599 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_557) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _112))).x;
                    break;
                }
            }
        }
        float _600 = mix(_577, _599, _125);
        float _601 = sin(_600);
        float _602 = cos(_600);
        _610 = (_543 * (-_601)) + (_545 * _602);
        _611 = (_543 * _602) + (_545 * _601);
    }
    else
    {
        _610 = _545;
        _611 = _543;
    }
    float3 _612 = cross(_330, _611);
    uint _620 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _621 = (gl_VertexIndex - gl_BaseVertex) & _620;
    uint _622 = _621 * 5u;
    float3 _633 = normalize((select(_610, _612, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_622 + 3u))).x) + (_611 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_622 + 2u))).x));
    float3 _644 = _633 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _331), _633) < 0.0)) ? (-1) : 1);
    float3 _645 = cross(_644, _330);
    float4 _646 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_622));
    float _647 = _646.x;
    uint _648 = _622 + 1u;
    float4 _649 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_648));
    float _650 = _649.x;
    float2 _651 = float2(_647, _650);
    float3 _652 = _651.xxx;
    float3 _653 = _611 * _652;
    float3 _654 = _651.yyy;
    float3 _655 = _612 * _654;
    float3 _656 = _653 + _655;
    float3 _657 = float3(_387);
    float3 _658 = _656 * _657;
    float3 _659 = _331 + _658;
    float3 _660 = _659 + View.View_PreViewTranslation;
    float _661 = _660.x;
    float _662 = _660.y;
    float _663 = _660.z;
    float4 _664 = float4(_661, _662, _663, 1.0);
    float4 _665 = float4(_664.x, _664.y, _664.z, _664.w);
    float4 _666 = View.View_TranslatedWorldToClip * _665;
    float4 _668 = float4(_645.x, _645.y, _645.z, float4(0.0).w);
    _668.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _668;
    out.out_var_TEXCOORD11_centroid = float4(_644, 1.0);
    out.gl_Position = _666;
    return out;
}

