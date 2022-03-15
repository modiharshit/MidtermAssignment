

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
    float2 NiagaraSpriteVF_DefaultPivotOffset;
    char _m10_pad[8];
    int NiagaraSpriteVF_PositionDataOffset;
    char _m11_pad[4];
    int NiagaraSpriteVF_VelocityDataOffset;
    char _m12_pad[4];
    int NiagaraSpriteVF_RotationDataOffset;
    char _m13_pad[4];
    int NiagaraSpriteVF_SizeDataOffset;
    char _m14_pad[4];
    int NiagaraSpriteVF_SubimageDataOffset;
    char _m15_pad[24];
    int NiagaraSpriteVF_FacingDataOffset;
    char _m16_pad[4];
    int NiagaraSpriteVF_AlignmentDataOffset;
    char _m17_pad[4];
    int NiagaraSpriteVF_SubImageBlendMode;
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m19_pad[8];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m20_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m21_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m22_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m23_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m24_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m25_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m27_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _81 = {};
constant float3x3 _82 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
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

vertex Main_out Main_0000719d_421eb800(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _133;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _133 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _133 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _197;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _197 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _196;
            switch (0u)
            {
                default:
                {
                    uint _146 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _150 = int(_146 & 2147483647u);
                    if ((_146 & 2147483648u) != 0u)
                    {
                        _196 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_150) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_150 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_150 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _196 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_150) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_150 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_150 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _197 = _196;
            break;
        }
    }
    bool _204;
    float3 _224;
    switch (0u)
    {
        default:
        {
            _204 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_204)
            {
                _224 = (((Primitive.Primitive_LocalToWorld[0].xyz * _197.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _197.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _197.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _224 = _197;
            break;
        }
    }
    float _261;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _261 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _260;
            switch (0u)
            {
                default:
                {
                    uint _236 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _240 = int(_236 & 2147483647u);
                    if ((_236 & 2147483648u) != 0u)
                    {
                        _260 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_240) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                    else
                    {
                        _260 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_240) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                }
            }
            _261 = _260;
            break;
        }
    }
    float _262 = _261 * 0.0174532942473888397216796875;
    float2 _313;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _313 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _312;
            switch (0u)
            {
                default:
                {
                    uint _274 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _278 = int(_274 & 2147483647u);
                    if ((_274 & 2147483648u) != 0u)
                    {
                        _312 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_278) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_278 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _312 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_278) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_278 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _313 = _312;
            break;
        }
    }
    float3 _376;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _376 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _375;
            switch (0u)
            {
                default:
                {
                    uint _325 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _329 = int(_325 & 2147483647u);
                    if ((_325 & 2147483648u) != 0u)
                    {
                        _375 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_329) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_329 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_329 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _375 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_329) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_329 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_329 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _376 = _375;
            break;
        }
    }
    float3 _403;
    switch (0u)
    {
        default:
        {
            if (_204)
            {
                _403 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _376.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _376.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _376.zzz);
                break;
            }
            _403 = _376;
            break;
        }
    }
    float _440;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _440 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _439;
            switch (0u)
            {
                default:
                {
                    uint _415 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _419 = int(_415 & 2147483647u);
                    if ((_415 & 2147483648u) != 0u)
                    {
                        _439 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_419) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                    else
                    {
                        _439 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_419) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                }
            }
            _440 = _439;
            break;
        }
    }
    float3 _504;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _504 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _503;
            switch (0u)
            {
                default:
                {
                    uint _453 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _457 = int(_453 & 2147483647u);
                    if ((_453 & 2147483648u) != 0u)
                    {
                        _503 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_457) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_457 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_457 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _503 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_457) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_457 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_457 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _504 = _503;
            break;
        }
    }
    float3 _531;
    switch (0u)
    {
        default:
        {
            if (_204)
            {
                _531 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _504.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _504.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _504.zzz);
                break;
            }
            _531 = _504;
            break;
        }
    }
    float3 _599;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _599 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _598;
            switch (0u)
            {
                default:
                {
                    uint _548 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _552 = int(_548 & 2147483647u);
                    if ((_548 & 2147483648u) != 0u)
                    {
                        _598 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_552) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_552 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_552 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _598 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_552) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_552 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_552 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _599 = _598;
            break;
        }
    }
    float3 _626;
    switch (0u)
    {
        default:
        {
            if (_204)
            {
                _626 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _599.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _599.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _599.zzz);
                break;
            }
            _626 = _599;
            break;
        }
    }
    float2 _681;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _681 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _680;
            switch (0u)
            {
                default:
                {
                    uint _642 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _646 = int(_642 & 2147483647u);
                    if ((_642 & 2147483648u) != 0u)
                    {
                        _680 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_646) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_646 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                    else
                    {
                        _680 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_646) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_646 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x);
                        break;
                    }
                }
            }
            _681 = _680;
            break;
        }
    }
    float3 _682 = View.View_WorldCameraOrigin - _224;
    float _683 = length(_682);
    float _684 = fast::max(_683, 9.9999999747524270787835121154785e-07);
    float3 _685 = float3(_684);
    float3 _686 = _682 / _685;
    float _723;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _723 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _722;
            switch (0u)
            {
                default:
                {
                    uint _698 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _702 = int(_698 & 2147483647u);
                    if ((_698 & 2147483648u) != 0u)
                    {
                        _722 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_702) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                    else
                    {
                        _722 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_702) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _133))).x;
                        break;
                    }
                }
            }
            _723 = _722;
            break;
        }
    }
    float3 _724 = _686 * _723;
    float4 _727 = float4(_313, _262, _440);
    float _728 = length(_403);
    float3 _736 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _737 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _736);
    float3 _738 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _736);
    float3 _739 = -_738;
    float3 _740 = -View.View_ViewForward;
    bool _743 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _744 = bool3(_743);
    float3 _745 = select(_686, _531 / float3(fast::max(length(_531), 9.9999999747524270787835121154785e-07)), _744);
    float3 _751 = mix(select(float3(0.0, 0.0, 1.0), _403 / float3(_728), bool3(_728 > 9.9999999747524270787835121154785e-07)), _626 / float3(fast::max(length(_626), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _752 = cross(_745, _751);
    float3 _756 = _752 / float3(fast::max(length(_752), 9.9999999747524270787835121154785e-07));
    float3 _762 = cross(_740, _738);
    float3 _766 = _762 / float3(fast::max(length(_762), 9.9999999747524270787835121154785e-07));
    float3 _768 = cross(_745, _738);
    float3 _772 = _768 / float3(fast::max(length(_768), 9.9999999747524270787835121154785e-07));
    float3 _774 = cross(_686, float3(0.0, 0.0, 1.0));
    float3 _778 = _774 / float3(fast::max(length(_774), 9.9999999747524270787835121154785e-07));
    float3 _816;
    float3 _817;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _814;
        float3 _815;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _811 = float3(fast::clamp((dot(_682, _682) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _814 = mix(cross(_686, _774), _739, _811);
            _815 = mix(_774, _737, _811);
        }
        else
        {
            float3 _800;
            float3 _801;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _800 = _739;
                _801 = _737;
            }
            else
            {
                float3 _798;
                float3 _799;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _798 = cross(_740, _766);
                    _799 = _766;
                }
                else
                {
                    _798 = select(cross(_686, _778), cross(_745, _772), _744);
                    _799 = select(_778, _772, _744);
                }
                _800 = _798;
                _801 = _799;
            }
            _814 = _800;
            _815 = _801;
        }
        _816 = _814;
        _817 = _815;
    }
    else
    {
        _816 = mix(-_751, cross(_745, _756), float3(float(_743)));
        _817 = _756;
    }
    float _820 = _262 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _823 = _820 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _824 = sin(_823);
    float _825 = cos(_823);
    float3 _826 = _817 * _824;
    float3 _827 = _816 * _824;
    float3 _828 = _817 * _825;
    float3 _829 = _816 * _825;
    float3 _830 = _827 + _828;
    float3 _831 = _829 - _826;
    float2 _834 = float2(int2(sign(_313)));
    float2 _874;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _843 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _851 = _834.x;
        float _852 = _834.y;
        uint _859;
        if ((_851 * _852) < 0.0)
        {
            _859 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _843;
        }
        else
        {
            _859 = _843;
        }
        float4 _863 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_440, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _859)));
        float _865 = _863.x;
        float2 _868 = _81;
        _868.x = (_851 < 0.0) ? (1.0 - _865) : _865;
        float _870 = _863.y;
        float2 _873 = _868;
        _873.y = (_852 < 0.0) ? (1.0 - _870) : _870;
        _874 = _873;
    }
    else
    {
        _874 = in.in_var_ATTRIBUTE0;
    }
    float2 _875 = _727.xy;
    float2 _876 = abs(_875);
    float2x3 _877 = float2x3(_830, _831);
    float2 _878 = _874 - _681;
    float2 _879 = _876 * _878;
    float3 _880 = _877 * _879;
    float3 _881 = _724 + _880;
    float3 _882 = _224 + _881;
    float3x3 _888 = _82;
    _888[0] = _830;
    float3x3 _889 = _888;
    _889[1] = _831;
    float3x3 _923;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _922 = _889;
        _922[2] = normalize(cross(_830, _831));
        _923 = _922;
    }
    else
    {
        float3x3 _919;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _918 = _889;
            _918[2] = normalize(_224 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _919 = _918;
        }
        else
        {
            float3x3 _912 = _889;
            _912[2] = normalize(_224 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _224 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _919 = _912;
        }
        _923 = _919;
    }
    float3 _924 = _882 + View.View_PreViewTranslation;
    float _925 = _924.x;
    float _926 = _924.y;
    float _927 = _924.z;
    float4 _928 = float4(_925, _926, _927, 1.0);
    float4 _929 = float4(_928.x, _928.y, _928.z, _928.w);
    float4 _930 = View.View_TranslatedWorldToClip * _929;
    float4 _933 = float4(_923[0].x, _923[0].y, _923[0].z, float4(0.0).w);
    _933.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? fract(_440) : 0.0;
    out.out_var_TEXCOORD10 = _933;
    out.out_var_TEXCOORD11 = float4(_923[2], float(int(sign(determinant(_923)))));
    out.gl_Position = _930;
    return out;
}

