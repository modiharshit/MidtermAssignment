

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

constant float2 _89 = {};
constant float3x3 _90 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
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

vertex Main_out Main_00007848_b7a03881(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(7)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(8)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _138;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _138 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _138 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _202;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _202 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _201;
            switch (0u)
            {
                default:
                {
                    uint _151 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _155 = int(_151 & 2147483647u);
                    if ((_151 & 2147483648u) != 0u)
                    {
                        _201 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_155) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_155 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_155 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _201 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_155) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_155 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_155 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _202 = _201;
            break;
        }
    }
    bool _209;
    float3 _229;
    switch (0u)
    {
        default:
        {
            _209 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_209)
            {
                _229 = (((Primitive.Primitive_LocalToWorld[0].xyz * _202.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _202.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _202.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _229 = _202;
            break;
        }
    }
    float _266;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _266 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _265;
            switch (0u)
            {
                default:
                {
                    uint _241 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _245 = int(_241 & 2147483647u);
                    if ((_241 & 2147483648u) != 0u)
                    {
                        _265 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_245) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                    else
                    {
                        _265 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_245) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                }
            }
            _266 = _265;
            break;
        }
    }
    float _267 = _266 * 0.0174532942473888397216796875;
    float2 _318;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _318 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _317;
            switch (0u)
            {
                default:
                {
                    uint _279 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _283 = int(_279 & 2147483647u);
                    if ((_279 & 2147483648u) != 0u)
                    {
                        _317 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_283) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_283 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _317 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_283) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_283 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _318 = _317;
            break;
        }
    }
    float3 _381;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _381 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _380;
            switch (0u)
            {
                default:
                {
                    uint _330 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _334 = int(_330 & 2147483647u);
                    if ((_330 & 2147483648u) != 0u)
                    {
                        _380 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_334) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_334 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_334 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _380 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_334) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_334 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_334 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _381 = _380;
            break;
        }
    }
    float3 _408;
    switch (0u)
    {
        default:
        {
            if (_209)
            {
                _408 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _381.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _381.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _381.zzz);
                break;
            }
            _408 = _381;
            break;
        }
    }
    float _445;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _445 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _444;
            switch (0u)
            {
                default:
                {
                    uint _420 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _424 = int(_420 & 2147483647u);
                    if ((_420 & 2147483648u) != 0u)
                    {
                        _444 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_424) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                    else
                    {
                        _444 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_424) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                }
            }
            _445 = _444;
            break;
        }
    }
    float3 _509;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _509 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _508;
            switch (0u)
            {
                default:
                {
                    uint _458 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _462 = int(_458 & 2147483647u);
                    if ((_458 & 2147483648u) != 0u)
                    {
                        _508 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_462) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_462 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_462 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _508 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_462) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_462 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_462 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _509 = _508;
            break;
        }
    }
    float3 _536;
    switch (0u)
    {
        default:
        {
            if (_209)
            {
                _536 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _509.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _509.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _509.zzz);
                break;
            }
            _536 = _509;
            break;
        }
    }
    float3 _604;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _604 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _603;
            switch (0u)
            {
                default:
                {
                    uint _553 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _557 = int(_553 & 2147483647u);
                    if ((_553 & 2147483648u) != 0u)
                    {
                        _603 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_557) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_557 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_557 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _603 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_557) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_557 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_557 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _604 = _603;
            break;
        }
    }
    float3 _631;
    switch (0u)
    {
        default:
        {
            if (_209)
            {
                _631 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _604.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _604.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _604.zzz);
                break;
            }
            _631 = _604;
            break;
        }
    }
    float2 _686;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _686 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _685;
            switch (0u)
            {
                default:
                {
                    uint _647 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _651 = int(_647 & 2147483647u);
                    if ((_647 & 2147483648u) != 0u)
                    {
                        _685 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_651) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_651 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                    else
                    {
                        _685 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_651) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_651 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x);
                        break;
                    }
                }
            }
            _686 = _685;
            break;
        }
    }
    float3 _687 = View.View_WorldCameraOrigin - _229;
    float3 _691 = _687 / float3(fast::max(length(_687), 9.9999999747524270787835121154785e-07));
    float _728;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _728 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _727;
            switch (0u)
            {
                default:
                {
                    uint _703 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _707 = int(_703 & 2147483647u);
                    if ((_703 & 2147483648u) != 0u)
                    {
                        _727 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_707) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                    else
                    {
                        _727 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_707) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _138))).x;
                        break;
                    }
                }
            }
            _728 = _727;
            break;
        }
    }
    float _733 = length(_408);
    float3 _741 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _742 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _741);
    float3 _743 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _741);
    float3 _744 = -_743;
    float3 _745 = -View.View_ViewForward;
    bool _748 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _749 = bool3(_748);
    float3 _750 = select(_691, _536 / float3(fast::max(length(_536), 9.9999999747524270787835121154785e-07)), _749);
    float3 _756 = mix(select(float3(0.0, 0.0, 1.0), _408 / float3(_733), bool3(_733 > 9.9999999747524270787835121154785e-07)), _631 / float3(fast::max(length(_631), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _757 = cross(_750, _756);
    float3 _761 = _757 / float3(fast::max(length(_757), 9.9999999747524270787835121154785e-07));
    float3 _767 = cross(_745, _743);
    float3 _771 = _767 / float3(fast::max(length(_767), 9.9999999747524270787835121154785e-07));
    float3 _773 = cross(_750, _743);
    float3 _777 = _773 / float3(fast::max(length(_773), 9.9999999747524270787835121154785e-07));
    float3 _779 = cross(_691, float3(0.0, 0.0, 1.0));
    float3 _783 = _779 / float3(fast::max(length(_779), 9.9999999747524270787835121154785e-07));
    float3 _821;
    float3 _822;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _819;
        float3 _820;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _816 = float3(fast::clamp((dot(_687, _687) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _819 = mix(cross(_691, _779), _744, _816);
            _820 = mix(_779, _742, _816);
        }
        else
        {
            float3 _805;
            float3 _806;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _805 = _744;
                _806 = _742;
            }
            else
            {
                float3 _803;
                float3 _804;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _803 = cross(_745, _771);
                    _804 = _771;
                }
                else
                {
                    _803 = select(cross(_691, _783), cross(_750, _777), _749);
                    _804 = select(_783, _777, _749);
                }
                _805 = _803;
                _806 = _804;
            }
            _819 = _805;
            _820 = _806;
        }
        _821 = _819;
        _822 = _820;
    }
    else
    {
        _821 = mix(-_756, cross(_750, _761), float3(float(_748)));
        _822 = _761;
    }
    float _828 = (_267 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _829 = sin(_828);
    float _830 = cos(_828);
    float3 _835 = (_821 * _829) + (_822 * _830);
    float3 _836 = (_821 * _830) - (_822 * _829);
    float2 _839 = float2(int2(sign(_318)));
    float2 _879;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _848 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _856 = _839.x;
        float _857 = _839.y;
        uint _864;
        if ((_856 * _857) < 0.0)
        {
            _864 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _848;
        }
        else
        {
            _864 = _848;
        }
        float4 _868 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_445, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _864)));
        float _870 = _868.x;
        float2 _873 = _89;
        _873.x = (_856 < 0.0) ? (1.0 - _870) : _870;
        float _875 = _868.y;
        float2 _878 = _873;
        _878.y = (_857 < 0.0) ? (1.0 - _875) : _875;
        _879 = _878;
    }
    else
    {
        _879 = in.in_var_ATTRIBUTE0;
    }
    float3x3 _893 = _90;
    _893[0] = _835;
    float3x3 _894 = _893;
    _894[1] = _836;
    bool _897 = NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5;
    float3x3 _928;
    if (_897)
    {
        float3x3 _927 = _894;
        _927[2] = normalize(cross(_835, _836));
        _928 = _927;
    }
    else
    {
        float3x3 _924;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _923 = _894;
            _923[2] = normalize(_229 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _924 = _923;
        }
        else
        {
            float3x3 _917 = _894;
            _917[2] = normalize(_229 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _229 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _924 = _917;
        }
        _928 = _924;
    }
    float4 _933 = float4((_229 + ((_691 * _728) + (float2x3(_835, _836) * (abs(float4(_318, _267, _445).xy) * (_879 - _686))))) + View.View_PreViewTranslation, 1.0);
    float3x3 _964;
    if (_897)
    {
        float3x3 _963 = _894;
        _963[2] = normalize(cross(_835, _836));
        _964 = _963;
    }
    else
    {
        float3x3 _960;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _959 = _894;
            _959[2] = normalize(_229 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _960 = _959;
        }
        else
        {
            float3x3 _953 = _894;
            _953[2] = normalize(_229 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _229 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _960 = _953;
        }
        _964 = _960;
    }
    float4 _971 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_933.x, _933.y, _933.z, _933.w);
    float4 _982;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_971.z < 0.0))
    {
        float4 _980 = _971;
        _980.z = 9.9999999747524270787835121154785e-07;
        float4 _981 = _980;
        _981.w = 1.0;
        _982 = _981;
    }
    else
    {
        _982 = _971;
    }
    float _988 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _964[2]));
    float4 _1013 = _982;
    _1013.z = ((_982.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_988) > 0.0) ? (sqrt(fast::clamp(1.0 - (_988 * _988), 0.0, 1.0)) / _988) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _982.w;
    float4 _1016 = float4(_928[0].x, _928[0].y, _928[0].z, float4(0.0).w);
    _1016.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? fract(_445) : 0.0;
    out.out_var_TEXCOORD10 = _1016;
    out.out_var_TEXCOORD11 = float4(_928[2], float(int(sign(determinant(_928)))));
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _933.xyz;
    out.gl_Position = _1013;
    return out;
}

