

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

constant float2 _82 = {};
constant float3x3 _83 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
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

vertex Main_out Main_000071e3_5f5d9bf3(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _134;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _134 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _134 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _198;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _198 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _197;
            switch (0u)
            {
                default:
                {
                    uint _147 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _151 = int(_147 & 2147483647u);
                    if ((_147 & 2147483648u) != 0u)
                    {
                        _197 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_151) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_151 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_151 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _197 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_151) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_151 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_151 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _198 = _197;
            break;
        }
    }
    bool _205;
    float3 _225;
    switch (0u)
    {
        default:
        {
            _205 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_205)
            {
                _225 = (((Primitive.Primitive_LocalToWorld[0].xyz * _198.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _198.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _198.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _225 = _198;
            break;
        }
    }
    float _262;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _262 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _261;
            switch (0u)
            {
                default:
                {
                    uint _237 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _241 = int(_237 & 2147483647u);
                    if ((_237 & 2147483648u) != 0u)
                    {
                        _261 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_241) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                    else
                    {
                        _261 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_241) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                }
            }
            _262 = _261;
            break;
        }
    }
    float _263 = _262 * 0.0174532942473888397216796875;
    float2 _314;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _314 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _313;
            switch (0u)
            {
                default:
                {
                    uint _275 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _279 = int(_275 & 2147483647u);
                    if ((_275 & 2147483648u) != 0u)
                    {
                        _313 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_279) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_279 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _313 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_279) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_279 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _314 = _313;
            break;
        }
    }
    float3 _377;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _377 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _376;
            switch (0u)
            {
                default:
                {
                    uint _326 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _330 = int(_326 & 2147483647u);
                    if ((_326 & 2147483648u) != 0u)
                    {
                        _376 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_330) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_330 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_330 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _376 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_330) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_330 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_330 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _377 = _376;
            break;
        }
    }
    float3 _404;
    switch (0u)
    {
        default:
        {
            if (_205)
            {
                _404 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _377.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _377.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _377.zzz);
                break;
            }
            _404 = _377;
            break;
        }
    }
    float _441;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _441 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _440;
            switch (0u)
            {
                default:
                {
                    uint _416 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _420 = int(_416 & 2147483647u);
                    if ((_416 & 2147483648u) != 0u)
                    {
                        _440 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_420) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                    else
                    {
                        _440 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_420) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                }
            }
            _441 = _440;
            break;
        }
    }
    float3 _505;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _505 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _504;
            switch (0u)
            {
                default:
                {
                    uint _454 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _458 = int(_454 & 2147483647u);
                    if ((_454 & 2147483648u) != 0u)
                    {
                        _504 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_458) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_458 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_458 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _504 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_458) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_458 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_458 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _505 = _504;
            break;
        }
    }
    float3 _532;
    switch (0u)
    {
        default:
        {
            if (_205)
            {
                _532 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _505.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _505.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _505.zzz);
                break;
            }
            _532 = _505;
            break;
        }
    }
    float3 _600;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _600 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _599;
            switch (0u)
            {
                default:
                {
                    uint _549 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _553 = int(_549 & 2147483647u);
                    if ((_549 & 2147483648u) != 0u)
                    {
                        _599 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_553) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_553 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_553 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _599 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_553) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_553 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_553 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _600 = _599;
            break;
        }
    }
    float3 _627;
    switch (0u)
    {
        default:
        {
            if (_205)
            {
                _627 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _600.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _600.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _600.zzz);
                break;
            }
            _627 = _600;
            break;
        }
    }
    float2 _682;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _682 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _681;
            switch (0u)
            {
                default:
                {
                    uint _643 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _647 = int(_643 & 2147483647u);
                    if ((_643 & 2147483648u) != 0u)
                    {
                        _681 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_647) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_647 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _681 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_647) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_647 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _682 = _681;
            break;
        }
    }
    float3 _683 = View.View_WorldCameraOrigin - _225;
    float _684 = length(_683);
    float _685 = fast::max(_684, 9.9999999747524270787835121154785e-07);
    float3 _686 = float3(_685);
    float3 _687 = _683 / _686;
    float _724;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _724 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _723;
            switch (0u)
            {
                default:
                {
                    uint _699 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _703 = int(_699 & 2147483647u);
                    if ((_699 & 2147483648u) != 0u)
                    {
                        _723 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_703) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                    else
                    {
                        _723 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_703) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _134))).x;
                        break;
                    }
                }
            }
            _724 = _723;
            break;
        }
    }
    float3 _725 = _687 * _724;
    float4 _728 = float4(_314, _263, _441);
    float _729 = length(_404);
    float3 _737 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _738 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _737);
    float3 _739 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _737);
    float3 _740 = -_739;
    float3 _741 = -View.View_ViewForward;
    bool _744 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _745 = bool3(_744);
    float3 _746 = select(_687, _532 / float3(fast::max(length(_532), 9.9999999747524270787835121154785e-07)), _745);
    float3 _752 = mix(select(float3(0.0, 0.0, 1.0), _404 / float3(_729), bool3(_729 > 9.9999999747524270787835121154785e-07)), _627 / float3(fast::max(length(_627), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _753 = cross(_746, _752);
    float3 _757 = _753 / float3(fast::max(length(_753), 9.9999999747524270787835121154785e-07));
    float3 _763 = cross(_741, _739);
    float3 _767 = _763 / float3(fast::max(length(_763), 9.9999999747524270787835121154785e-07));
    float3 _769 = cross(_746, _739);
    float3 _773 = _769 / float3(fast::max(length(_769), 9.9999999747524270787835121154785e-07));
    float3 _775 = cross(_687, float3(0.0, 0.0, 1.0));
    float3 _779 = _775 / float3(fast::max(length(_775), 9.9999999747524270787835121154785e-07));
    float3 _817;
    float3 _818;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _815;
        float3 _816;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _812 = float3(fast::clamp((dot(_683, _683) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _815 = mix(cross(_687, _775), _740, _812);
            _816 = mix(_775, _738, _812);
        }
        else
        {
            float3 _801;
            float3 _802;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _801 = _740;
                _802 = _738;
            }
            else
            {
                float3 _799;
                float3 _800;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _799 = cross(_741, _767);
                    _800 = _767;
                }
                else
                {
                    _799 = select(cross(_687, _779), cross(_746, _773), _745);
                    _800 = select(_779, _773, _745);
                }
                _801 = _799;
                _802 = _800;
            }
            _815 = _801;
            _816 = _802;
        }
        _817 = _815;
        _818 = _816;
    }
    else
    {
        _817 = mix(-_752, cross(_746, _757), float3(float(_744)));
        _818 = _757;
    }
    float _821 = _263 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _824 = _821 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _825 = sin(_824);
    float _826 = cos(_824);
    float3 _827 = _818 * _825;
    float3 _828 = _817 * _825;
    float3 _829 = _818 * _826;
    float3 _830 = _817 * _826;
    float3 _831 = _828 + _829;
    float3 _832 = _830 - _827;
    float2 _835 = float2(int2(sign(_314)));
    float2 _875;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _844 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _852 = _835.x;
        float _853 = _835.y;
        uint _860;
        if ((_852 * _853) < 0.0)
        {
            _860 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _844;
        }
        else
        {
            _860 = _844;
        }
        float4 _864 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_441, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _860)));
        float _866 = _864.x;
        float2 _869 = _82;
        _869.x = (_852 < 0.0) ? (1.0 - _866) : _866;
        float _871 = _864.y;
        float2 _874 = _869;
        _874.y = (_853 < 0.0) ? (1.0 - _871) : _871;
        _875 = _874;
    }
    else
    {
        _875 = in.in_var_ATTRIBUTE0;
    }
    float2 _876 = _728.xy;
    float2 _877 = abs(_876);
    float2x3 _878 = float2x3(_831, _832);
    float2 _879 = _875 - _682;
    float2 _880 = _877 * _879;
    float3 _881 = _878 * _880;
    float3 _882 = _725 + _881;
    float3 _883 = _225 + _882;
    float3x3 _889 = _83;
    _889[0] = _831;
    float3x3 _890 = _889;
    _890[1] = _832;
    float3x3 _924;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _923 = _890;
        _923[2] = normalize(cross(_831, _832));
        _924 = _923;
    }
    else
    {
        float3x3 _920;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _919 = _890;
            _919[2] = normalize(_225 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _920 = _919;
        }
        else
        {
            float3x3 _913 = _890;
            _913[2] = normalize(_225 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _225 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _920 = _913;
        }
        _924 = _920;
    }
    float3 _925 = _883 + View.View_PreViewTranslation;
    float _926 = _925.x;
    float _927 = _925.y;
    float _928 = _925.z;
    float4 _929 = float4(_926, _927, _928, 1.0);
    float4 _930 = float4(_929.x, _929.y, _929.z, _929.w);
    float4 _931 = View.View_TranslatedWorldToClip * _930;
    float4 _934 = float4(_924[0].x, _924[0].y, _924[0].z, float4(0.0).w);
    _934.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? fract(_441) : 0.0;
    out.gl_Position = _931;
    out.out_var_TEXCOORD10 = _934;
    out.out_var_TEXCOORD11 = float4(_924[2], float(int(sign(determinant(_924)))));
    out.out_var_TEXCOORD6 = _930;
    return out;
}

