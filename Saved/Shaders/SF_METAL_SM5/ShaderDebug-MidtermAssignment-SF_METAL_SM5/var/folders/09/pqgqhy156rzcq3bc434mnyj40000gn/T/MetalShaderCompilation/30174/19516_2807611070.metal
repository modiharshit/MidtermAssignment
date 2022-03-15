

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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004c3c_a758bebe(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(8)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(9)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _96 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _97 = _96 + 1u;
    uint _113;
    uint _114;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _113 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _96))).x);
        _114 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _97))).x);
    }
    else
    {
        _113 = _96;
        _114 = _97;
    }
    float _127 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _332;
    float3 _333;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _137;
        int _139;
        float3 _185;
        switch (0u)
        {
            default:
            {
                uint _135 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _137 = (_135 & 2147483648u) != 0u;
                _139 = int(_135 & 2147483647u);
                if (_137)
                {
                    _185 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
                else
                {
                    _185 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
            }
        }
        float3 _233;
        switch (0u)
        {
            default:
            {
                if (_137)
                {
                    _233 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x);
                    break;
                }
                else
                {
                    _233 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x);
                    break;
                }
            }
        }
        bool _267;
        float4 _235 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_96));
        float4 _236 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_97));
        float3 _237 = _235.xyz;
        float3 _238 = _236.xyz;
        float _241 = _236.w - _235.w;
        float _242 = _127 * _127;
        float _243 = _242 * _127;
        float _245 = 3.0 * _242;
        float3 _262 = (((_185 * (((2.0 * _243) - _245) + 1.0)) + (_237 * (_241 * ((_243 - (2.0 * _242)) + _127)))) + (_238 * (_241 * (_243 - _242)))) + (_233 * (((-2.0) * _243) + _245));
        float3 _297;
        switch (0u)
        {
            default:
            {
                _267 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_267)
                {
                    _297 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _262.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _262.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _262.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _297 = _262;
                    break;
                }
            }
        }
        float3 _299 = mix(_237, _238, float3(_127));
        float3 _330;
        switch (0u)
        {
            default:
            {
                if (_267)
                {
                    _330 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _299.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _299.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _299.zzz);
                    break;
                }
                else
                {
                    _330 = _299;
                    break;
                }
            }
        }
        _332 = normalize(_330);
        _333 = _297;
    }
    else
    {
        _332 = float3(0.0);
        _333 = float3(0.0);
    }
    float _389;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _343;
        int _345;
        float _365;
        switch (0u)
        {
            default:
            {
                uint _341 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _343 = (_341 & 2147483648u) != 0u;
                _345 = int(_341 & 2147483647u);
                if (_343)
                {
                    _365 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_345) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
                else
                {
                    _365 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_345) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
            }
        }
        float _387;
        switch (0u)
        {
            default:
            {
                if (_343)
                {
                    _387 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_345) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x;
                    break;
                }
                else
                {
                    _387 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_345) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x;
                    break;
                }
            }
        }
        _389 = mix(_365, _387, _127);
    }
    else
    {
        _389 = 1.0;
    }
    float3 _536;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _402;
        int _404;
        float3 _450;
        switch (0u)
        {
            default:
            {
                uint _400 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _402 = (_400 & 2147483648u) != 0u;
                _404 = int(_400 & 2147483647u);
                if (_402)
                {
                    _450 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
                else
                {
                    _450 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x);
                    break;
                }
            }
        }
        float3 _498;
        switch (0u)
        {
            default:
            {
                if (_402)
                {
                    _498 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_404 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x);
                    break;
                }
                else
                {
                    _498 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_404 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x);
                    break;
                }
            }
        }
        float3 _500 = mix(_450, _498, float3(_127));
        float3 _534;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _534 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _500.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _500.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _500.zzz);
                    break;
                }
                else
                {
                    _534 = _500;
                    break;
                }
            }
        }
        _536 = normalize(_534);
    }
    else
    {
        _536 = normalize(View.View_WorldCameraOrigin - _333);
    }
    float3 _538 = normalize(cross(_536, _332));
    bool _541 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _545;
    if (_541)
    {
        _545 = -_536;
    }
    else
    {
        _545 = _538;
    }
    float3 _547 = select(_536, _538, bool3(_541));
    float3 _612;
    float3 _613;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _557;
        int _559;
        float _579;
        switch (0u)
        {
            default:
            {
                uint _555 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _557 = (_555 & 2147483648u) != 0u;
                _559 = int(_555 & 2147483647u);
                if (_557)
                {
                    _579 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_559) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
                else
                {
                    _579 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_559) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _113))).x;
                    break;
                }
            }
        }
        float _601;
        switch (0u)
        {
            default:
            {
                if (_557)
                {
                    _601 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_559) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x;
                    break;
                }
                else
                {
                    _601 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_559) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _114))).x;
                    break;
                }
            }
        }
        float _602 = mix(_579, _601, _127);
        float _603 = sin(_602);
        float _604 = cos(_602);
        _612 = (_545 * (-_603)) + (_547 * _604);
        _613 = (_545 * _604) + (_547 * _603);
    }
    else
    {
        _612 = _547;
        _613 = _545;
    }
    float3 _614 = cross(_332, _613);
    uint _624 = ((gl_VertexIndex - gl_BaseVertex) & uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask)) * 5u;
    float3 _635 = normalize((select(_612, _614, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_624 + 3u))).x) + (_613 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_624 + 2u))).x));
    float2 _652 = float2(NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_624)).x, NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_624 + 1u))).x);
    float4 _665 = float4((_333 + (((_613 * _652.xxx) + (_614 * _652.yyy)) * float3(_389))) + View.View_PreViewTranslation, 1.0);
    float4 _671 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_665.x, _665.y, _665.z, _665.w);
    float4 _682;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_671.z < 0.0))
    {
        float4 _680 = _671;
        _680.z = 9.9999999747524270787835121154785e-07;
        float4 _681 = _680;
        _681.w = 1.0;
        _682 = _681;
    }
    else
    {
        _682 = _671;
    }
    float _688 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _635 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _333), _635) < 0.0)) ? (-1) : 1)));
    out.out_var_TEXCOORD6 = _682.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_688) > 0.0) ? (sqrt(fast::clamp(1.0 - (_688 * _688), 0.0, 1.0)) / _688) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _682;
    return out;
}

