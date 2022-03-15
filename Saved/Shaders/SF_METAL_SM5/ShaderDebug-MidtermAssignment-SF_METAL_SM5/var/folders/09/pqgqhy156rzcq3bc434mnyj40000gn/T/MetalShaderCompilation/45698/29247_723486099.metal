

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
    char _m8_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m9_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m10_pad[336];
    int View_NumSceneColorMSAASamples;
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
    char _m1_pad[16];
    float4 NiagaraSpriteVF_NormalsSphereCenter;
    float4 NiagaraSpriteVF_NormalsCylinderUnitDirection;
    float4 NiagaraSpriteVF_SubImageSize;
    packed_float3 NiagaraSpriteVF_CameraFacingBlend;
    float NiagaraSpriteVF_RemoveHMDRoll;
    char _m6_pad[16];
    float NiagaraSpriteVF_RotationScale;
    float NiagaraSpriteVF_RotationBias;
    float NiagaraSpriteVF_NormalsType;
    float NiagaraSpriteVF_DeltaSeconds;
    float2 NiagaraSpriteVF_DefaultPivotOffset;
    char _m11_pad[8];
    int NiagaraSpriteVF_PositionDataOffset;
    char _m12_pad[4];
    int NiagaraSpriteVF_VelocityDataOffset;
    char _m13_pad[4];
    int NiagaraSpriteVF_RotationDataOffset;
    char _m14_pad[4];
    int NiagaraSpriteVF_SizeDataOffset;
    char _m15_pad[4];
    int NiagaraSpriteVF_SubimageDataOffset;
    char _m16_pad[24];
    int NiagaraSpriteVF_FacingDataOffset;
    char _m17_pad[4];
    int NiagaraSpriteVF_AlignmentDataOffset;
    char _m18_pad[4];
    int NiagaraSpriteVF_SubImageBlendMode;
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m20_pad[8];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m21_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m22_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m23_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m24_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m25_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m26_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m28_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _84 = {};
constant float3x3 _85 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10 [[user(locn2)]];
    float4 out_var_TEXCOORD11 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVertexShader_out Main_0000723f_2b1f8593(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _141;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _141 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _141 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _205;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _205 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _204;
            switch (0u)
            {
                default:
                {
                    uint _154 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _158 = int(_154 & 2147483647u);
                    if ((_154 & 2147483648u) != 0u)
                    {
                        _204 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_158) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_158 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_158 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _204 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_158) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_158 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_158 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _205 = _204;
            break;
        }
    }
    bool _212;
    float3 _232;
    switch (0u)
    {
        default:
        {
            _212 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_212)
            {
                _232 = (((Primitive.Primitive_LocalToWorld[0].xyz * _205.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _205.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _205.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _232 = _205;
            break;
        }
    }
    float _269;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _269 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _268;
            switch (0u)
            {
                default:
                {
                    uint _244 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _248 = int(_244 & 2147483647u);
                    if ((_244 & 2147483648u) != 0u)
                    {
                        _268 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_248) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                    else
                    {
                        _268 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_248) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                }
            }
            _269 = _268;
            break;
        }
    }
    float _270 = _269 * 0.0174532942473888397216796875;
    float2 _321;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _321 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _320;
            switch (0u)
            {
                default:
                {
                    uint _282 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _286 = int(_282 & 2147483647u);
                    if ((_282 & 2147483648u) != 0u)
                    {
                        _320 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_286) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_286 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _320 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_286) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_286 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _321 = _320;
            break;
        }
    }
    float3 _384;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _384 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _383;
            switch (0u)
            {
                default:
                {
                    uint _333 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _337 = int(_333 & 2147483647u);
                    if ((_333 & 2147483648u) != 0u)
                    {
                        _383 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_337) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_337 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_337 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _383 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_337) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_337 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_337 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _384 = _383;
            break;
        }
    }
    float3 _411;
    switch (0u)
    {
        default:
        {
            if (_212)
            {
                _411 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _384.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _384.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _384.zzz);
                break;
            }
            _411 = _384;
            break;
        }
    }
    float _448;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _448 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _447;
            switch (0u)
            {
                default:
                {
                    uint _423 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _427 = int(_423 & 2147483647u);
                    if ((_423 & 2147483648u) != 0u)
                    {
                        _447 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_427) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                    else
                    {
                        _447 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_427) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                }
            }
            _448 = _447;
            break;
        }
    }
    float3 _512;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _512 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _511;
            switch (0u)
            {
                default:
                {
                    uint _461 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _465 = int(_461 & 2147483647u);
                    if ((_461 & 2147483648u) != 0u)
                    {
                        _511 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_465) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_465 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_465 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _511 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_465) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_465 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_465 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _512 = _511;
            break;
        }
    }
    float3 _539;
    switch (0u)
    {
        default:
        {
            if (_212)
            {
                _539 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _512.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _512.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _512.zzz);
                break;
            }
            _539 = _512;
            break;
        }
    }
    float3 _607;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _607 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _606;
            switch (0u)
            {
                default:
                {
                    uint _556 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _560 = int(_556 & 2147483647u);
                    if ((_556 & 2147483648u) != 0u)
                    {
                        _606 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_560) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_560 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_560 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _606 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_560) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_560 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_560 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _607 = _606;
            break;
        }
    }
    float3 _634;
    switch (0u)
    {
        default:
        {
            if (_212)
            {
                _634 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _607.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _607.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _607.zzz);
                break;
            }
            _634 = _607;
            break;
        }
    }
    float2 _689;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _689 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _688;
            switch (0u)
            {
                default:
                {
                    uint _650 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _654 = int(_650 & 2147483647u);
                    if ((_650 & 2147483648u) != 0u)
                    {
                        _688 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_654) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_654 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _688 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_654) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_654 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _689 = _688;
            break;
        }
    }
    float3 _690 = View.View_WorldCameraOrigin - _232;
    float3 _694 = _690 / float3(fast::max(length(_690), 9.9999999747524270787835121154785e-07));
    float _731;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _731 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _730;
            switch (0u)
            {
                default:
                {
                    uint _706 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _710 = int(_706 & 2147483647u);
                    if ((_706 & 2147483648u) != 0u)
                    {
                        _730 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_710) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                    else
                    {
                        _730 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_710) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                }
            }
            _731 = _730;
            break;
        }
    }
    float _736 = length(_411);
    float3 _744 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _745 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _744);
    float3 _746 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _744);
    float3 _747 = -_746;
    float3 _748 = -View.View_ViewForward;
    bool _751 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _752 = bool3(_751);
    float3 _753 = select(_694, _539 / float3(fast::max(length(_539), 9.9999999747524270787835121154785e-07)), _752);
    float3 _759 = mix(select(float3(0.0, 0.0, 1.0), _411 / float3(_736), bool3(_736 > 9.9999999747524270787835121154785e-07)), _634 / float3(fast::max(length(_634), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _760 = cross(_753, _759);
    float3 _764 = _760 / float3(fast::max(length(_760), 9.9999999747524270787835121154785e-07));
    float3 _770 = cross(_748, _746);
    float3 _774 = _770 / float3(fast::max(length(_770), 9.9999999747524270787835121154785e-07));
    float3 _776 = cross(_753, _746);
    float3 _780 = _776 / float3(fast::max(length(_776), 9.9999999747524270787835121154785e-07));
    float3 _782 = cross(_694, float3(0.0, 0.0, 1.0));
    float3 _786 = _782 / float3(fast::max(length(_782), 9.9999999747524270787835121154785e-07));
    float3 _824;
    float3 _825;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _822;
        float3 _823;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _819 = float3(fast::clamp((dot(_690, _690) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _822 = mix(cross(_694, _782), _747, _819);
            _823 = mix(_782, _745, _819);
        }
        else
        {
            float3 _808;
            float3 _809;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _808 = _747;
                _809 = _745;
            }
            else
            {
                float3 _806;
                float3 _807;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _806 = cross(_748, _774);
                    _807 = _774;
                }
                else
                {
                    _806 = select(cross(_694, _786), cross(_753, _780), _752);
                    _807 = select(_786, _780, _752);
                }
                _808 = _806;
                _809 = _807;
            }
            _822 = _808;
            _823 = _809;
        }
        _824 = _822;
        _825 = _823;
    }
    else
    {
        _824 = mix(-_759, cross(_753, _764), float3(float(_751)));
        _825 = _764;
    }
    float _831 = (_270 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _832 = sin(_831);
    float _833 = cos(_831);
    float3 _838 = (_824 * _832) + (_825 * _833);
    float3 _839 = (_824 * _833) - (_825 * _832);
    float2 _842 = float2(int2(sign(_321)));
    float2 _882;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _851 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _859 = _842.x;
        float _860 = _842.y;
        uint _867;
        if ((_859 * _860) < 0.0)
        {
            _867 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _851;
        }
        else
        {
            _867 = _851;
        }
        float4 _871 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_448, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _867)));
        float _873 = _871.x;
        float2 _876 = _84;
        _876.x = (_859 < 0.0) ? (1.0 - _873) : _873;
        float _878 = _871.y;
        float2 _881 = _876;
        _881.y = (_860 < 0.0) ? (1.0 - _878) : _878;
        _882 = _881;
    }
    else
    {
        _882 = in.in_var_ATTRIBUTE0;
    }
    float3 _890 = _232 + ((_694 * _731) + (float2x3(_838, _839) * (abs(float4(_321, _270, _448).xy) * (_882 - _689))));
    float3x3 _900 = _85;
    _900[0] = _838;
    float3x3 _901 = _900;
    _901[1] = _839;
    float3x3 _935;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _934 = _901;
        _934[2] = normalize(cross(_838, _839));
        _935 = _934;
    }
    else
    {
        float3x3 _931;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _930 = _901;
            _930[2] = normalize(_232 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _931 = _930;
        }
        else
        {
            float3x3 _924 = _901;
            _924[2] = normalize(_232 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _232 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _931 = _924;
        }
        _935 = _931;
    }
    float4 _942 = float4(_935[0].x, _935[0].y, _935[0].z, float4(0.0).w);
    _942.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? fract(_448) : 0.0;
    float4 _959 = View.View_TranslatedWorldToClip * float4(_890 + View.View_PreViewTranslation, 1.0);
    float4 _968 = _959;
    _968.z = _959.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _959.w) : 0.0);
    out.gl_Position = _968;
    out.out_var_TEXCOORD6 = _959;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_890 - (_411 * NiagaraSpriteVF.NiagaraSpriteVF_DeltaSeconds)) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _942;
    out.out_var_TEXCOORD11 = float4(_935[2], float(int(sign(determinant(_935)))));
    return out;
}

