

#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    char _m0_pad[960];
    float3 View_ViewForward;
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m5_pad[32];
    float3 View_WorldCameraOrigin;
    char _m6_pad[32];
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
    char _m17_pad[8];
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m18_pad[8];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m19_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m20_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m21_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m22_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m23_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m24_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m26_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _84 = {};
constant float3x3 _85 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
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

vertex Main_out Main_00007288_1cb34dc5(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(7)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(8)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _132;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _132 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _132 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _196;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _196 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _195;
            switch (0u)
            {
                default:
                {
                    uint _145 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _149 = int(_145 & 2147483647u);
                    if ((_145 & 2147483648u) != 0u)
                    {
                        _195 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_149 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _195 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_149 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _196 = _195;
            break;
        }
    }
    bool _203;
    float3 _223;
    switch (0u)
    {
        default:
        {
            _203 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_203)
            {
                _223 = (((Primitive.Primitive_LocalToWorld[0].xyz * _196.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _196.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _196.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _223 = _196;
            break;
        }
    }
    float _260;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _260 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _259;
            switch (0u)
            {
                default:
                {
                    uint _235 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _239 = int(_235 & 2147483647u);
                    if ((_235 & 2147483648u) != 0u)
                    {
                        _259 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_239) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                    else
                    {
                        _259 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_239) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                }
            }
            _260 = _259;
            break;
        }
    }
    float _261 = _260 * 0.0174532942473888397216796875;
    float2 _312;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _312 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _311;
            switch (0u)
            {
                default:
                {
                    uint _273 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _277 = int(_273 & 2147483647u);
                    if ((_273 & 2147483648u) != 0u)
                    {
                        _311 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_277) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_277 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _311 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_277) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_277 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _312 = _311;
            break;
        }
    }
    float3 _375;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _375 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _374;
            switch (0u)
            {
                default:
                {
                    uint _324 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _328 = int(_324 & 2147483647u);
                    if ((_324 & 2147483648u) != 0u)
                    {
                        _374 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_328) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_328 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_328 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _374 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_328) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_328 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_328 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _375 = _374;
            break;
        }
    }
    float3 _402;
    switch (0u)
    {
        default:
        {
            if (_203)
            {
                _402 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _375.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _375.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _375.zzz);
                break;
            }
            _402 = _375;
            break;
        }
    }
    float _439;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _439 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _438;
            switch (0u)
            {
                default:
                {
                    uint _414 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _418 = int(_414 & 2147483647u);
                    if ((_414 & 2147483648u) != 0u)
                    {
                        _438 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_418) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                    else
                    {
                        _438 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_418) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                }
            }
            _439 = _438;
            break;
        }
    }
    float3 _503;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _503 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _502;
            switch (0u)
            {
                default:
                {
                    uint _452 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _456 = int(_452 & 2147483647u);
                    if ((_452 & 2147483648u) != 0u)
                    {
                        _502 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_456) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_456 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_456 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _502 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_456) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_456 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_456 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _503 = _502;
            break;
        }
    }
    float3 _530;
    switch (0u)
    {
        default:
        {
            if (_203)
            {
                _530 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _503.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _503.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _503.zzz);
                break;
            }
            _530 = _503;
            break;
        }
    }
    float3 _598;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _598 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _597;
            switch (0u)
            {
                default:
                {
                    uint _547 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _551 = int(_547 & 2147483647u);
                    if ((_547 & 2147483648u) != 0u)
                    {
                        _597 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_551) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_551 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_551 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _597 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_551) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_551 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_551 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _598 = _597;
            break;
        }
    }
    float3 _625;
    switch (0u)
    {
        default:
        {
            if (_203)
            {
                _625 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _598.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _598.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _598.zzz);
                break;
            }
            _625 = _598;
            break;
        }
    }
    float2 _680;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _680 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _679;
            switch (0u)
            {
                default:
                {
                    uint _641 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _645 = int(_641 & 2147483647u);
                    if ((_641 & 2147483648u) != 0u)
                    {
                        _679 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_645) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_645 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                    else
                    {
                        _679 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_645) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_645 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x);
                        break;
                    }
                }
            }
            _680 = _679;
            break;
        }
    }
    float3 _681 = View.View_WorldCameraOrigin - _223;
    float3 _685 = _681 / float3(fast::max(length(_681), 9.9999999747524270787835121154785e-07));
    float _722;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _722 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _721;
            switch (0u)
            {
                default:
                {
                    uint _697 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _701 = int(_697 & 2147483647u);
                    if ((_697 & 2147483648u) != 0u)
                    {
                        _721 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_701) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                    else
                    {
                        _721 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_701) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _132))).x;
                        break;
                    }
                }
            }
            _722 = _721;
            break;
        }
    }
    float _727 = length(_402);
    float3 _735 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _736 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _735);
    float3 _737 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _735);
    float3 _738 = -_737;
    float3 _739 = -View.View_ViewForward;
    bool _742 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _743 = bool3(_742);
    float3 _744 = select(_685, _530 / float3(fast::max(length(_530), 9.9999999747524270787835121154785e-07)), _743);
    float3 _750 = mix(select(float3(0.0, 0.0, 1.0), _402 / float3(_727), bool3(_727 > 9.9999999747524270787835121154785e-07)), _625 / float3(fast::max(length(_625), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _751 = cross(_744, _750);
    float3 _755 = _751 / float3(fast::max(length(_751), 9.9999999747524270787835121154785e-07));
    float3 _761 = cross(_739, _737);
    float3 _765 = _761 / float3(fast::max(length(_761), 9.9999999747524270787835121154785e-07));
    float3 _767 = cross(_744, _737);
    float3 _771 = _767 / float3(fast::max(length(_767), 9.9999999747524270787835121154785e-07));
    float3 _773 = cross(_685, float3(0.0, 0.0, 1.0));
    float3 _777 = _773 / float3(fast::max(length(_773), 9.9999999747524270787835121154785e-07));
    float3 _815;
    float3 _816;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _813;
        float3 _814;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _810 = float3(fast::clamp((dot(_681, _681) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _813 = mix(cross(_685, _773), _738, _810);
            _814 = mix(_773, _736, _810);
        }
        else
        {
            float3 _799;
            float3 _800;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _799 = _738;
                _800 = _736;
            }
            else
            {
                float3 _797;
                float3 _798;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _797 = cross(_739, _765);
                    _798 = _765;
                }
                else
                {
                    _797 = select(cross(_685, _777), cross(_744, _771), _743);
                    _798 = select(_777, _771, _743);
                }
                _799 = _797;
                _800 = _798;
            }
            _813 = _799;
            _814 = _800;
        }
        _815 = _813;
        _816 = _814;
    }
    else
    {
        _815 = mix(-_750, cross(_744, _755), float3(float(_742)));
        _816 = _755;
    }
    float _822 = (_261 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _823 = sin(_822);
    float _824 = cos(_822);
    float3 _829 = (_815 * _823) + (_816 * _824);
    float3 _830 = (_815 * _824) - (_816 * _823);
    float2 _833 = float2(int2(sign(_312)));
    float2 _873;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _842 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _850 = _833.x;
        float _851 = _833.y;
        uint _858;
        if ((_850 * _851) < 0.0)
        {
            _858 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _842;
        }
        else
        {
            _858 = _842;
        }
        float4 _862 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_439, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _858)));
        float _864 = _862.x;
        float2 _867 = _84;
        _867.x = (_850 < 0.0) ? (1.0 - _864) : _864;
        float _869 = _862.y;
        float2 _872 = _867;
        _872.y = (_851 < 0.0) ? (1.0 - _869) : _869;
        _873 = _872;
    }
    else
    {
        _873 = in.in_var_ATTRIBUTE0;
    }
    float4 _886 = float4((_223 + ((_685 * _722) + (float2x3(_829, _830) * (abs(float4(_312, _261, _439).xy) * (_873 - _680))))) + View.View_PreViewTranslation, 1.0);
    float3x3 _920;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _919 = _85;
        _919[2] = normalize(cross(_829, _830));
        _920 = _919;
    }
    else
    {
        float3x3 _916;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _915 = _85;
            _915[2] = normalize(_223 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _916 = _915;
        }
        else
        {
            float3x3 _909 = _85;
            _909[2] = normalize(_223 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _223 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _916 = _909;
        }
        _920 = _916;
    }
    float4 _927 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_886.x, _886.y, _886.z, _886.w);
    float4 _938;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_927.z < 0.0))
    {
        float4 _936 = _927;
        _936.z = 9.9999999747524270787835121154785e-07;
        float4 _937 = _936;
        _937.w = 1.0;
        _938 = _937;
    }
    else
    {
        _938 = _927;
    }
    float _944 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _920[2]));
    float4 _969 = _938;
    _969.z = ((_938.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_944) > 0.0) ? (sqrt(fast::clamp(1.0 - (_944 * _944), 0.0, 1.0)) / _944) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _938.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _969;
    return out;
}

