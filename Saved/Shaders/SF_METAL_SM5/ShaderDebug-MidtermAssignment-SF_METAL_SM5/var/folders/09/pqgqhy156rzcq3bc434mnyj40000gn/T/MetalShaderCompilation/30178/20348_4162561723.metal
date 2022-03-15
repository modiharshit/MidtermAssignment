

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
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

vertex Main_out Main_00004f7c_f81ba6bb(constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(7)]], constant type_NiagaraRibbonVFLooseParameters& NiagaraRibbonVFLooseParameters [[buffer(8)]], constant type_NiagaraRibbonVF& NiagaraRibbonVF [[buffer(9)]], constant type_Globals& _Globals [[buffer(10)]], texture_buffer<int> NiagaraRibbonVFLooseParameters_SortedIndices [[texture(0)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_TangentsAndDistances [[texture(1)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat [[texture(2)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf [[texture(3)]], texture_buffer<float> NiagaraRibbonVFLooseParameters_SliceVertexData [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    uint _102 = ((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_ParticleIdMask);
    uint _103 = _102 + 1u;
    uint _119;
    uint _120;
    if (NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _119 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _102))).x);
        _120 = uint(NiagaraRibbonVFLooseParameters_SortedIndices.read(uint((NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_SortedIndicesOffset + _103))).x);
    }
    else
    {
        _119 = _102;
        _120 = _103;
    }
    float _133 = float(((gl_VertexIndex - gl_BaseVertex) >> (uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdShift) & 31u)) & uint(NiagaraRibbonVF.NiagaraRibbonVF_InterpIdMask)) * NiagaraRibbonVF.NiagaraRibbonVF_OneOverInterpCount;
    float3 _338;
    float3 _339;
    if (NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset != (-1))
    {
        bool _143;
        int _145;
        float3 _191;
        switch (0u)
        {
            default:
            {
                uint _141 = uint(NiagaraRibbonVF.NiagaraRibbonVF_PositionDataOffset);
                _143 = (_141 & 2147483648u) != 0u;
                _145 = int(_141 & 2147483647u);
                if (_143)
                {
                    _191 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _191 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        float3 _239;
        switch (0u)
        {
            default:
            {
                if (_143)
                {
                    _239 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_145 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x);
                    break;
                }
                else
                {
                    _239 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_145 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x);
                    break;
                }
            }
        }
        bool _273;
        float4 _241 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_102));
        float4 _242 = NiagaraRibbonVFLooseParameters_TangentsAndDistances.read(uint(_103));
        float3 _243 = _241.xyz;
        float3 _244 = _242.xyz;
        float _247 = _242.w - _241.w;
        float _248 = _133 * _133;
        float _249 = _248 * _133;
        float _251 = 3.0 * _248;
        float3 _268 = (((_191 * (((2.0 * _249) - _251) + 1.0)) + (_243 * (_247 * ((_249 - (2.0 * _248)) + _133)))) + (_244 * (_247 * (_249 - _248)))) + (_239 * (((-2.0) * _249) + _251));
        float3 _303;
        switch (0u)
        {
            default:
            {
                _273 = NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u;
                if (_273)
                {
                    _303 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _268.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _268.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _268.zzz)) + Primitive.Primitive_LocalToWorld[3u].xyz, 1.0).xyz;
                    break;
                }
                else
                {
                    _303 = _268;
                    break;
                }
            }
        }
        float3 _305 = mix(_243, _244, float3(_133));
        float3 _336;
        switch (0u)
        {
            default:
            {
                if (_273)
                {
                    _336 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _305.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _305.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _305.zzz);
                    break;
                }
                else
                {
                    _336 = _305;
                    break;
                }
            }
        }
        _338 = normalize(_336);
        _339 = _303;
    }
    else
    {
        _338 = float3(0.0);
        _339 = float3(0.0);
    }
    float _395;
    if (NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset != (-1))
    {
        bool _349;
        int _351;
        float _371;
        switch (0u)
        {
            default:
            {
                uint _347 = uint(NiagaraRibbonVF.NiagaraRibbonVF_WidthDataOffset);
                _349 = (_347 & 2147483648u) != 0u;
                _351 = int(_347 & 2147483647u);
                if (_349)
                {
                    _371 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_351) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _371 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_351) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
            }
        }
        float _393;
        switch (0u)
        {
            default:
            {
                if (_349)
                {
                    _393 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_351) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x;
                    break;
                }
                else
                {
                    _393 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_351) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x;
                    break;
                }
            }
        }
        _395 = mix(_371, _393, _133);
    }
    else
    {
        _395 = 1.0;
    }
    float3 _542;
    if (NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset != (-1))
    {
        bool _408;
        int _410;
        float3 _456;
        switch (0u)
        {
            default:
            {
                uint _406 = uint(NiagaraRibbonVF.NiagaraRibbonVF_FacingDataOffset);
                _408 = (_406 & 2147483648u) != 0u;
                _410 = int(_406 & 2147483647u);
                if (_408)
                {
                    _456 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
                else
                {
                    _456 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x);
                    break;
                }
            }
        }
        float3 _504;
        switch (0u)
        {
            default:
            {
                if (_408)
                {
                    _504 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_410 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x);
                    break;
                }
                else
                {
                    _504 = float3(NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410 + 1) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x, NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_410 + 2) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x);
                    break;
                }
            }
        }
        float3 _506 = mix(_456, _504, float3(_133));
        float3 _540;
        switch (0u)
        {
            default:
            {
                if (NiagaraRibbonVF.NiagaraRibbonVF_bLocalSpace != 0u)
                {
                    _540 = (((Primitive.Primitive_LocalToWorld[0u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _506.xxx) + ((Primitive.Primitive_LocalToWorld[1u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _506.yyy)) + ((Primitive.Primitive_LocalToWorld[2u].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _506.zzz);
                    break;
                }
                else
                {
                    _540 = _506;
                    break;
                }
            }
        }
        _542 = normalize(_540);
    }
    else
    {
        _542 = normalize(View.View_WorldCameraOrigin - _339);
    }
    float3 _544 = normalize(cross(_542, _338));
    bool _547 = NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_FacingMode == 2u;
    float3 _551;
    if (_547)
    {
        _551 = -_542;
    }
    else
    {
        _551 = _544;
    }
    float3 _553 = select(_542, _544, bool3(_547));
    float3 _618;
    float3 _619;
    if (NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset != (-1))
    {
        bool _563;
        int _565;
        float _585;
        switch (0u)
        {
            default:
            {
                uint _561 = uint(NiagaraRibbonVF.NiagaraRibbonVF_TwistDataOffset);
                _563 = (_561 & 2147483648u) != 0u;
                _565 = int(_561 & 2147483647u);
                if (_563)
                {
                    _585 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
                    break;
                }
                else
                {
                    _585 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _119))).x;
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
                    _607 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x;
                    break;
                }
                else
                {
                    _607 = NiagaraRibbonVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565) * NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_NiagaraFloatDataStride) + _120))).x;
                    break;
                }
            }
        }
        float _608 = mix(_585, _607, _133);
        float _609 = sin(_608);
        float _610 = cos(_608);
        _618 = (_551 * (-_609)) + (_553 * _610);
        _619 = (_551 * _610) + (_553 * _609);
    }
    else
    {
        _618 = _553;
        _619 = _551;
    }
    float3 _620 = cross(_338, _619);
    uint _628 = uint(NiagaraRibbonVF.NiagaraRibbonVF_SliceVertexIdMask);
    uint _629 = (gl_VertexIndex - gl_BaseVertex) & _628;
    uint _630 = _629 * 5u;
    float3 _641 = normalize((select(_618, _620, bool3(NiagaraRibbonVFLooseParameters.NiagaraRibbonVFLooseParameters_Shape >= 1u)) * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_630 + 3u))).x) + (_619 * NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint((_630 + 2u))).x));
    float4 _653 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_630));
    float _654 = _653.x;
    uint _655 = _630 + 1u;
    float4 _656 = NiagaraRibbonVFLooseParameters_SliceVertexData.read(uint(_655));
    float _657 = _656.x;
    float2 _658 = float2(_654, _657);
    float3 _659 = _658.xxx;
    float3 _660 = _619 * _659;
    float3 _661 = _658.yyy;
    float3 _662 = _620 * _661;
    float3 _663 = _660 + _662;
    float3 _664 = float3(_395);
    float3 _665 = _663 * _664;
    float3 _666 = _339 + _665;
    float3 _667 = _666 + View.View_PreViewTranslation;
    float _668 = _667.x;
    float _669 = _667.y;
    float _670 = _667.z;
    float4 _671 = float4(_668, _669, _670, 1.0);
    float4 _672 = float4(_671.x, _671.y, _671.z, _671.w);
    float4 _677 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _672;
    out.out_var_TEXCOORD6 = _672;
    out.out_var_TEXCOORD8 = _641 * float(((NiagaraRibbonVF.NiagaraRibbonVF_ShouldFlipNormalToView > 0) && (dot(normalize(View.View_WorldCameraOrigin - _339), _641) < 0.0)) ? (-1) : 1);
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _677;
    return out;
}

