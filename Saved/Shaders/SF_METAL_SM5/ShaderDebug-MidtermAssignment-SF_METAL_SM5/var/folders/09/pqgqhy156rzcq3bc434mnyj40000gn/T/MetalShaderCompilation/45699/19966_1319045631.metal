

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004dfe_4e9f09ff(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(8)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(9)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
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
    float _394;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _348;
        int _350;
        float _370;
        switch (0u)
        {
            default:
            {
                uint _346 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _348 = (_346 & 2147483648u) != 0u;
                _350 = int(_346 & 2147483647u);
                if (_348)
                {
                    _370 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _370 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        float _392;
        switch (0u)
        {
            default:
            {
                if (_348)
                {
                    _392 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _392 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_350) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
            }
        }
        _394 = mix(_370, _392, _132);
    }
    else
    {
        _394 = 1.0;
    }
    float3 _541;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _407;
        int _409;
        float3 _455;
        switch (0u)
        {
            default:
            {
                uint _405 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _407 = (_405 & 2147483648u) != 0u;
                _409 = int(_405 & 2147483647u);
                if (_407)
                {
                    _455 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _455 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        float3 _503;
        switch (0u)
        {
            default:
            {
                if (_407)
                {
                    _503 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_409 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _503 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_409 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        float3 _505 = mix(_455, _503, float3(_132));
        float3 _539;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _539 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _505.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _505.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _505.zzz);
                    break;
                }
                else
                {
                    _539 = _505;
                    break;
                }
            }
        }
        _541 = normalize(_539);
    }
    else
    {
        _541 = normalize(View.View_WorldCameraOrigin - _338);
    }
    float3 _543 = normalize(cross(_541, _337));
    bool _546 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _550;
    if (_546)
    {
        _550 = -_541;
    }
    else
    {
        _550 = _543;
    }
    float3 _552 = select(_541, _543, bool3(_546));
    float3 _617;
    float3 _618;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _562;
        int _564;
        float _584;
        switch (0u)
        {
            default:
            {
                uint _560 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _562 = (_560 & 2147483648u) != 0u;
                _564 = int(_560 & 2147483647u);
                if (_562)
                {
                    _584 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_564) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _584 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_564) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        float _606;
        switch (0u)
        {
            default:
            {
                if (_562)
                {
                    _606 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_564) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _606 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_564) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
            }
        }
        float _607 = mix(_584, _606, _132);
        float _608 = sin(_607);
        float _609 = cos(_607);
        _617 = (_550 * (-_608)) + (_552 * _609);
        _618 = (_550 * _609) + (_552 * _608);
    }
    else
    {
        _617 = _552;
        _618 = _550;
    }
    float3 _619 = cross(_337, _618);
    uint _629 = ((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u;
    float3 _640 = normalize((select(_617, _619, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_629 + 3u))).x) + (_618 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_629 + 2u))).x));
    float3 _651 = _640 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _338), _640) < 0.0)) ? (-1) : 1);
    float3 _652 = cross(_651, _337);
    float2 _658 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_629)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_629 + 1u))).x);
    float4 _671 = float4((_338 + (((_618 * _658.xxx) + (_619 * _658.yyy)) * float3(_394))) + View.View_PreViewTranslation, 1.0);
    float4 _677 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_671.x, _671.y, _671.z, _671.w);
    float4 _688;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_677.z < 0.0))
    {
        float4 _686 = _677;
        _686.z = 9.9999999747524270787835121154785e-07;
        float4 _687 = _686;
        _687.w = 1.0;
        _688 = _687;
    }
    else
    {
        _688 = _677;
    }
    float _694 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _651));
    float4 _714 = float4(_652.x, _652.y, _652.z, float4(0.0).w);
    _714.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _714;
    out.out_var_TEXCOORD11_centroid = float4(_651, 1.0);
    out.out_var_TEXCOORD6 = _688.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_694) > 0.0) ? (sqrt(fast::clamp(1.0 - (_694 * _694), 0.0, 1.0)) / _694) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _671.xyz;
    out.gl_Position = _688;
    return out;
}

