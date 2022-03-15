

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
    char _m0_pad[1072];
    float3 View_WorldCameraOrigin;
    char _m1_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00005135_65249765(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(8)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _106 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _107 = _106 + 1u;
    uint _123;
    uint _124;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _123 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _106))).x);
        _124 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _107))).x);
    }
    else
    {
        _123 = _106;
        _124 = _107;
    }
    float _137 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _342;
    float3 _343;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _147;
        int _149;
        float3 _195;
        switch (0u)
        {
            default:
            {
                uint _145 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _147 = (_145 & 2147483648u) != 0u;
                _149 = int(_145 & 2147483647u);
                if (_147)
                {
                    _195 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x);
                    break;
                }
                else
                {
                    _195 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x);
                    break;
                }
            }
        }
        float3 _243;
        switch (0u)
        {
            default:
            {
                if (_147)
                {
                    _243 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x);
                    break;
                }
                else
                {
                    _243 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x);
                    break;
                }
            }
        }
        bool _277;
        float4 _245 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_106));
        float4 _246 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_107));
        float3 _247 = _245.xyz;
        float3 _248 = _246.xyz;
        float _251 = _246.w - _245.w;
        float _252 = _137 * _137;
        float _253 = _252 * _137;
        float _255 = 3.0 * _252;
        float3 _272 = (((_195 * (((2.0 * _253) - _255) + 1.0)) + (_247 * (_251 * ((_253 - (2.0 * _252)) + _137)))) + (_248 * (_251 * (_253 - _252)))) + (_243 * (((-2.0) * _253) + _255));
        float3 _307;
        switch (0u)
        {
            default:
            {
                _277 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_277)
                {
                    _307 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _272.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _272.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _272.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _307 = _272;
                    break;
                }
            }
        }
        float3 _309 = mix(_247, _248, float3(_137));
        float3 _340;
        switch (0u)
        {
            default:
            {
                if (_277)
                {
                    _340 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _309.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _309.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _309.zzz);
                    break;
                }
                else
                {
                    _340 = _309;
                    break;
                }
            }
        }
        _342 = normalize(_340);
        _343 = _307;
    }
    else
    {
        _342 = float3(0.0);
        _343 = float3(0.0);
    }
    float _399;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _353;
        int _355;
        float _375;
        switch (0u)
        {
            default:
            {
                uint _351 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _353 = (_351 & 2147483648u) != 0u;
                _355 = int(_351 & 2147483647u);
                if (_353)
                {
                    _375 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_355) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x;
                    break;
                }
                else
                {
                    _375 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_355) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x;
                    break;
                }
            }
        }
        float _397;
        switch (0u)
        {
            default:
            {
                if (_353)
                {
                    _397 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_355) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x;
                    break;
                }
                else
                {
                    _397 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_355) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x;
                    break;
                }
            }
        }
        _399 = mix(_375, _397, _137);
    }
    else
    {
        _399 = 1.0;
    }
    float3 _546;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _412;
        int _414;
        float3 _460;
        switch (0u)
        {
            default:
            {
                uint _410 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _412 = (_410 & 2147483648u) != 0u;
                _414 = int(_410 & 2147483647u);
                if (_412)
                {
                    _460 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x);
                    break;
                }
                else
                {
                    _460 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x);
                    break;
                }
            }
        }
        float3 _508;
        switch (0u)
        {
            default:
            {
                if (_412)
                {
                    _508 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_414 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x);
                    break;
                }
                else
                {
                    _508 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_414 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x);
                    break;
                }
            }
        }
        float3 _510 = mix(_460, _508, float3(_137));
        float3 _544;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _544 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _510.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _510.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _510.zzz);
                    break;
                }
                else
                {
                    _544 = _510;
                    break;
                }
            }
        }
        _546 = normalize(_544);
    }
    else
    {
        _546 = normalize(View.View_WorldCameraOrigin - _343);
    }
    float3 _548 = normalize(cross(_546, _342));
    bool _551 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _555;
    if (_551)
    {
        _555 = -_546;
    }
    else
    {
        _555 = _548;
    }
    float3 _557 = select(_546, _548, bool3(_551));
    float3 _622;
    float3 _623;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _567;
        int _569;
        float _589;
        switch (0u)
        {
            default:
            {
                uint _565 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _567 = (_565 & 2147483648u) != 0u;
                _569 = int(_565 & 2147483647u);
                if (_567)
                {
                    _589 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_569) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x;
                    break;
                }
                else
                {
                    _589 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_569) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _123))).x;
                    break;
                }
            }
        }
        float _611;
        switch (0u)
        {
            default:
            {
                if (_567)
                {
                    _611 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_569) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x;
                    break;
                }
                else
                {
                    _611 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_569) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _124))).x;
                    break;
                }
            }
        }
        float _612 = mix(_589, _611, _137);
        float _613 = sin(_612);
        float _614 = cos(_612);
        _622 = (_555 * (-_613)) + (_557 * _614);
        _623 = (_555 * _614) + (_557 * _613);
    }
    else
    {
        _622 = _557;
        _623 = _555;
    }
    float3 _624 = cross(_342, _623);
    uint _632 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _633 = (gl_VertexIndex - gl_BaseVertex) & _632;
    uint _634 = _633 * 5u;
    float3 _645 = normalize((select(_622, _624, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_634 + 3u))).x) + (_623 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_634 + 2u))).x));
    float3 _656 = _645 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _343), _645) < 0.0)) ? (-1) : 1);
    float3 _657 = cross(_656, _342);
    float4 _658 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_634));
    float _659 = _658.x;
    uint _660 = _634 + 1u;
    float4 _661 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_660));
    float _662 = _661.x;
    float2 _663 = float2(_659, _662);
    float3 _664 = _663.xxx;
    float3 _665 = _623 * _664;
    float3 _666 = _663.yyy;
    float3 _667 = _624 * _666;
    float3 _668 = _665 + _667;
    float3 _669 = float3(_399);
    float3 _670 = _668 * _669;
    float3 _671 = _343 + _670;
    float3 _672 = _671 + View.View_PreViewTranslation;
    float _673 = _672.x;
    float _674 = _672.y;
    float _675 = _672.z;
    float4 _676 = float4(_673, _674, _675, 1.0);
    float4 _677 = float4(_676.x, _676.y, _676.z, _676.w);
    float4 _679 = float4(_657.x, _657.y, _657.z, float4(0.0).w);
    _679.w = 0.0;
    float4 _689 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _677;
    out.out_var_TEXCOORD10_centroid = _679;
    out.out_var_TEXCOORD11_centroid = float4(_656, 1.0);
    out.out_var_TEXCOORD7 = _676.xyz;
    out.out_var_TEXCOORD6 = _689;
    out.out_var_TEXCOORD8 = _656;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _689;
    return out;
}

