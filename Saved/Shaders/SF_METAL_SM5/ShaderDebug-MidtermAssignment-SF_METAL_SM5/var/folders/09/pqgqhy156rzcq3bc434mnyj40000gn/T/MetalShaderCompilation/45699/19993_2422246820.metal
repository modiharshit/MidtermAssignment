

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
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004e19_90608da4(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(8)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(9)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _100 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _101 = _100 + 1u;
    uint _117;
    uint _118;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _117 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _100))).x);
        _118 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _101))).x);
    }
    else
    {
        _117 = _100;
        _118 = _101;
    }
    float _131 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _336;
    float3 _337;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _141;
        int _143;
        float3 _189;
        switch (0u)
        {
            default:
            {
                uint _139 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _141 = (_139 & 2147483648u) != 0u;
                _143 = int(_139 & 2147483647u);
                if (_141)
                {
                    _189 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x);
                    break;
                }
                else
                {
                    _189 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x);
                    break;
                }
            }
        }
        float3 _237;
        switch (0u)
        {
            default:
            {
                if (_141)
                {
                    _237 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_143 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _237 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_143 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        bool _271;
        float4 _239 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_100));
        float4 _240 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_101));
        float3 _241 = _239.xyz;
        float3 _242 = _240.xyz;
        float _245 = _240.w - _239.w;
        float _246 = _131 * _131;
        float _247 = _246 * _131;
        float _249 = 3.0 * _246;
        float3 _266 = (((_189 * (((2.0 * _247) - _249) + 1.0)) + (_241 * (_245 * ((_247 - (2.0 * _246)) + _131)))) + (_242 * (_245 * (_247 - _246)))) + (_237 * (((-2.0) * _247) + _249));
        float3 _301;
        switch (0u)
        {
            default:
            {
                _271 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_271)
                {
                    _301 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _266.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _266.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _266.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _301 = _266;
                    break;
                }
            }
        }
        float3 _303 = mix(_241, _242, float3(_131));
        float3 _334;
        switch (0u)
        {
            default:
            {
                if (_271)
                {
                    _334 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _303.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _303.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _303.zzz);
                    break;
                }
                else
                {
                    _334 = _303;
                    break;
                }
            }
        }
        _336 = normalize(_334);
        _337 = _301;
    }
    else
    {
        _336 = float3(0.0);
        _337 = float3(0.0);
    }
    float _393;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _347;
        int _349;
        float _369;
        switch (0u)
        {
            default:
            {
                uint _345 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _347 = (_345 & 2147483648u) != 0u;
                _349 = int(_345 & 2147483647u);
                if (_347)
                {
                    _369 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_349) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x;
                    break;
                }
                else
                {
                    _369 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_349) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x;
                    break;
                }
            }
        }
        float _391;
        switch (0u)
        {
            default:
            {
                if (_347)
                {
                    _391 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_349) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _391 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_349) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        _393 = mix(_369, _391, _131);
    }
    else
    {
        _393 = 1.0;
    }
    float3 _540;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _406;
        int _408;
        float3 _454;
        switch (0u)
        {
            default:
            {
                uint _404 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _406 = (_404 & 2147483648u) != 0u;
                _408 = int(_404 & 2147483647u);
                if (_406)
                {
                    _454 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x);
                    break;
                }
                else
                {
                    _454 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x);
                    break;
                }
            }
        }
        float3 _502;
        switch (0u)
        {
            default:
            {
                if (_406)
                {
                    _502 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
                else
                {
                    _502 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x);
                    break;
                }
            }
        }
        float3 _504 = mix(_454, _502, float3(_131));
        float3 _538;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _538 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _504.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _504.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _504.zzz);
                    break;
                }
                else
                {
                    _538 = _504;
                    break;
                }
            }
        }
        _540 = normalize(_538);
    }
    else
    {
        _540 = normalize(View.View_WorldCameraOrigin - _337);
    }
    float3 _542 = normalize(cross(_540, _336));
    bool _545 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _549;
    if (_545)
    {
        _549 = -_540;
    }
    else
    {
        _549 = _542;
    }
    float3 _551 = select(_540, _542, bool3(_545));
    float3 _616;
    float3 _617;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _561;
        int _563;
        float _583;
        switch (0u)
        {
            default:
            {
                uint _559 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _561 = (_559 & 2147483648u) != 0u;
                _563 = int(_559 & 2147483647u);
                if (_561)
                {
                    _583 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_563) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x;
                    break;
                }
                else
                {
                    _583 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_563) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _117))).x;
                    break;
                }
            }
        }
        float _605;
        switch (0u)
        {
            default:
            {
                if (_561)
                {
                    _605 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_563) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
                else
                {
                    _605 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_563) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _118))).x;
                    break;
                }
            }
        }
        float _606 = mix(_583, _605, _131);
        float _607 = sin(_606);
        float _608 = cos(_606);
        _616 = (_549 * (-_607)) + (_551 * _608);
        _617 = (_549 * _608) + (_551 * _607);
    }
    else
    {
        _616 = _551;
        _617 = _549;
    }
    float3 _618 = cross(_336, _617);
    uint _628 = ((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u;
    float3 _639 = normalize((select(_616, _618, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_628 + 3u))).x) + (_617 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_628 + 2u))).x));
    float3 _650 = _639 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _337), _639) < 0.0)) ? (-1) : 1);
    float3 _651 = cross(_650, _336);
    float2 _657 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_628)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_628 + 1u))).x);
    float4 _670 = float4((_337 + (((_617 * _657.xxx) + (_618 * _657.yyy)) * float3(_393))) + View.View_PreViewTranslation, 1.0);
    float4 _676 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_670.x, _670.y, _670.z, _670.w);
    float4 _687;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_676.z < 0.0))
    {
        float4 _685 = _676;
        _685.z = 9.9999999747524270787835121154785e-07;
        float4 _686 = _685;
        _686.w = 1.0;
        _687 = _686;
    }
    else
    {
        _687 = _676;
    }
    float _693 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _650));
    float4 _718 = _687;
    _718.z = ((_687.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_693) > 0.0) ? (sqrt(fast::clamp(1.0 - (_693 * _693), 0.0, 1.0)) / _693) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _687.w;
    float4 _720 = float4(_651.x, _651.y, _651.z, float4(0.0).w);
    _720.w = 0.0;
    out.out_var_TEXCOORD10_centroid = _720;
    out.out_var_TEXCOORD11_centroid = float4(_650, 1.0);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _670.xyz;
    out.gl_Position = _718;
    return out;
}

