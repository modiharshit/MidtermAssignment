

#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[896];
    float3 View_ViewForward;
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m6_pad[32];
    float3 View_WorldCameraOrigin;
    char _m7_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_NiagaraSpriteVFLooseParameters
{
    uint NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame;
    uint NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride;
    uint NiagaraSpriteVFLooseParameters_ParticleAlignmentMode;
    uint NiagaraSpriteVFLooseParameters_ParticleFacingMode;
    uint NiagaraSpriteVFLooseParameters_SortedIndicesOffset;
};

struct type_NiagaraSpriteVF
{
    uint NiagaraSpriteVF_bLocalSpace;
    char _m1_pad[48];
    float4 NiagaraSpriteVF_SubImageSize;
    packed_float3 NiagaraSpriteVF_CameraFacingBlend;
    float NiagaraSpriteVF_RemoveHMDRoll;
    char _m4_pad[16];
    float NiagaraSpriteVF_RotationScale;
    float NiagaraSpriteVF_RotationBias;
    char _m6_pad[8];
    float2 NiagaraSpriteVF_DefaultPivotOffset;
    char _m7_pad[8];
    int NiagaraSpriteVF_PositionDataOffset;
    char _m8_pad[4];
    int NiagaraSpriteVF_VelocityDataOffset;
    char _m9_pad[4];
    int NiagaraSpriteVF_RotationDataOffset;
    char _m10_pad[4];
    int NiagaraSpriteVF_SizeDataOffset;
    char _m11_pad[4];
    int NiagaraSpriteVF_SubimageDataOffset;
    char _m12_pad[24];
    int NiagaraSpriteVF_FacingDataOffset;
    char _m13_pad[4];
    int NiagaraSpriteVF_AlignmentDataOffset;
    char _m14_pad[8];
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m15_pad[8];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m16_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m17_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m18_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m19_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m20_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m21_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m23_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _75 = {};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00006b81_8e977901(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _122;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _122 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _122 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _186;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _186 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _185;
            switch (0u)
            {
                default:
                {
                    uint _135 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _139 = int(_135 & 2147483647u);
                    if ((_135 & 2147483648u) != 0u)
                    {
                        _185 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_139 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _185 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_139 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _186 = _185;
            break;
        }
    }
    bool _193;
    float3 _213;
    switch (0u)
    {
        default:
        {
            _193 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_193)
            {
                _213 = (((Primitive.Primitive_LocalToWorld[0].xyz * _186.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _186.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _186.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _213 = _186;
            break;
        }
    }
    float _250;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _250 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _249;
            switch (0u)
            {
                default:
                {
                    uint _225 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _229 = int(_225 & 2147483647u);
                    if ((_225 & 2147483648u) != 0u)
                    {
                        _249 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_229) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                    else
                    {
                        _249 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_229) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                }
            }
            _250 = _249;
            break;
        }
    }
    float _251 = _250 * 0.0174532942473888397216796875;
    float2 _302;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _302 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _301;
            switch (0u)
            {
                default:
                {
                    uint _263 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _267 = int(_263 & 2147483647u);
                    if ((_263 & 2147483648u) != 0u)
                    {
                        _301 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_267) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_267 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _301 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_267) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_267 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _302 = _301;
            break;
        }
    }
    float3 _365;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _365 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _364;
            switch (0u)
            {
                default:
                {
                    uint _314 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _318 = int(_314 & 2147483647u);
                    if ((_314 & 2147483648u) != 0u)
                    {
                        _364 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_318) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_318 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_318 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _364 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_318) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_318 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_318 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _365 = _364;
            break;
        }
    }
    float3 _392;
    switch (0u)
    {
        default:
        {
            if (_193)
            {
                _392 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _365.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _365.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _365.zzz);
                break;
            }
            _392 = _365;
            break;
        }
    }
    float _429;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _429 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _428;
            switch (0u)
            {
                default:
                {
                    uint _404 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _408 = int(_404 & 2147483647u);
                    if ((_404 & 2147483648u) != 0u)
                    {
                        _428 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_408) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                    else
                    {
                        _428 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_408) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                }
            }
            _429 = _428;
            break;
        }
    }
    float3 _493;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _493 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _492;
            switch (0u)
            {
                default:
                {
                    uint _442 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _446 = int(_442 & 2147483647u);
                    if ((_442 & 2147483648u) != 0u)
                    {
                        _492 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_446) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_446 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_446 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _492 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_446) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_446 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_446 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _493 = _492;
            break;
        }
    }
    float3 _520;
    switch (0u)
    {
        default:
        {
            if (_193)
            {
                _520 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _493.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _493.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _493.zzz);
                break;
            }
            _520 = _493;
            break;
        }
    }
    float3 _588;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _588 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _587;
            switch (0u)
            {
                default:
                {
                    uint _537 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _541 = int(_537 & 2147483647u);
                    if ((_537 & 2147483648u) != 0u)
                    {
                        _587 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_541) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_541 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_541 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _587 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_541) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_541 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_541 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _588 = _587;
            break;
        }
    }
    float3 _615;
    switch (0u)
    {
        default:
        {
            if (_193)
            {
                _615 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _588.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _588.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _588.zzz);
                break;
            }
            _615 = _588;
            break;
        }
    }
    float2 _670;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _670 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _669;
            switch (0u)
            {
                default:
                {
                    uint _631 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _635 = int(_631 & 2147483647u);
                    if ((_631 & 2147483648u) != 0u)
                    {
                        _669 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_635) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_635 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                    else
                    {
                        _669 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_635) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_635 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x);
                        break;
                    }
                }
            }
            _670 = _669;
            break;
        }
    }
    float3 _671 = View.View_WorldCameraOrigin - _213;
    float _672 = length(_671);
    float _673 = fast::max(_672, 9.9999999747524270787835121154785e-07);
    float3 _674 = float3(_673);
    float3 _675 = _671 / _674;
    float _712;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _712 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _711;
            switch (0u)
            {
                default:
                {
                    uint _687 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _691 = int(_687 & 2147483647u);
                    if ((_687 & 2147483648u) != 0u)
                    {
                        _711 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_691) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                    else
                    {
                        _711 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_691) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _122))).x;
                        break;
                    }
                }
            }
            _712 = _711;
            break;
        }
    }
    float3 _713 = _675 * _712;
    float4 _716 = float4(_302, _251, _429);
    float _717 = length(_392);
    float3 _725 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _726 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _725);
    float3 _727 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _725);
    float3 _728 = -_727;
    float3 _729 = -View.View_ViewForward;
    bool _732 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _733 = bool3(_732);
    float3 _734 = select(_675, _520 / float3(fast::max(length(_520), 9.9999999747524270787835121154785e-07)), _733);
    float3 _740 = mix(select(float3(0.0, 0.0, 1.0), _392 / float3(_717), bool3(_717 > 9.9999999747524270787835121154785e-07)), _615 / float3(fast::max(length(_615), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _741 = cross(_734, _740);
    float3 _745 = _741 / float3(fast::max(length(_741), 9.9999999747524270787835121154785e-07));
    float3 _751 = cross(_729, _727);
    float3 _755 = _751 / float3(fast::max(length(_751), 9.9999999747524270787835121154785e-07));
    float3 _757 = cross(_734, _727);
    float3 _761 = _757 / float3(fast::max(length(_757), 9.9999999747524270787835121154785e-07));
    float3 _763 = cross(_675, float3(0.0, 0.0, 1.0));
    float3 _767 = _763 / float3(fast::max(length(_763), 9.9999999747524270787835121154785e-07));
    float3 _805;
    float3 _806;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _803;
        float3 _804;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _800 = float3(fast::clamp((dot(_671, _671) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _803 = mix(cross(_675, _763), _728, _800);
            _804 = mix(_763, _726, _800);
        }
        else
        {
            float3 _789;
            float3 _790;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _789 = _728;
                _790 = _726;
            }
            else
            {
                float3 _787;
                float3 _788;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _787 = cross(_729, _755);
                    _788 = _755;
                }
                else
                {
                    _787 = select(cross(_675, _767), cross(_734, _761), _733);
                    _788 = select(_767, _761, _733);
                }
                _789 = _787;
                _790 = _788;
            }
            _803 = _789;
            _804 = _790;
        }
        _805 = _803;
        _806 = _804;
    }
    else
    {
        _805 = mix(-_740, cross(_734, _745), float3(float(_732)));
        _806 = _745;
    }
    float _809 = _251 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _812 = _809 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _813 = sin(_812);
    float _814 = cos(_812);
    float3 _815 = _806 * _813;
    float3 _816 = _805 * _813;
    float3 _817 = _806 * _814;
    float3 _818 = _805 * _814;
    float3 _819 = _816 + _817;
    float3 _820 = _818 - _815;
    float2 _823 = float2(int2(sign(_302)));
    float2 _863;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _832 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _840 = _823.x;
        float _841 = _823.y;
        uint _848;
        if ((_840 * _841) < 0.0)
        {
            _848 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _832;
        }
        else
        {
            _848 = _832;
        }
        float4 _852 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_429, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _848)));
        float _854 = _852.x;
        float2 _857 = _75;
        _857.x = (_840 < 0.0) ? (1.0 - _854) : _854;
        float _859 = _852.y;
        float2 _862 = _857;
        _862.y = (_841 < 0.0) ? (1.0 - _859) : _859;
        _863 = _862;
    }
    else
    {
        _863 = in.in_var_ATTRIBUTE0;
    }
    float2 _864 = _716.xy;
    float2 _865 = abs(_864);
    float2x3 _866 = float2x3(_819, _820);
    float2 _867 = _863 - _670;
    float2 _868 = _865 * _867;
    float3 _869 = _866 * _868;
    float3 _870 = _713 + _869;
    float3 _871 = _213 + _870;
    float3 _872 = _871 + View.View_PreViewTranslation;
    float _873 = _872.x;
    float _874 = _872.y;
    float _875 = _872.z;
    float4 _876 = float4(_873, _874, _875, 1.0);
    float4 _877 = float4(_876.x, _876.y, _876.z, _876.w);
    float4 _878 = View.View_TranslatedWorldToClip * _877;
    out.gl_Position = _878;
    return out;
}

