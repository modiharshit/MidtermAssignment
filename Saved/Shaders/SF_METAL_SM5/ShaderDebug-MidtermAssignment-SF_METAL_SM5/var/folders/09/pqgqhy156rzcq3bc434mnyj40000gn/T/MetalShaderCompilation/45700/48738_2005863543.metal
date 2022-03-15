

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
    char _m9_pad[256];
    float3 View_PrevWorldCameraOrigin;
    char _m10_pad[16];
    float3 View_PrevPreViewTranslation;
    char _m11_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
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
    int NiagaraSpriteVF_PrevPositionDataOffset;
    int NiagaraSpriteVF_VelocityDataOffset;
    int NiagaraSpriteVF_PrevVelocityDataOffset;
    int NiagaraSpriteVF_RotationDataOffset;
    int NiagaraSpriteVF_PrevRotationDataOffset;
    int NiagaraSpriteVF_SizeDataOffset;
    int NiagaraSpriteVF_PrevSizeDataOffset;
    int NiagaraSpriteVF_SubimageDataOffset;
    char _m19_pad[24];
    int NiagaraSpriteVF_FacingDataOffset;
    int NiagaraSpriteVF_PrevFacingDataOffset;
    int NiagaraSpriteVF_AlignmentDataOffset;
    int NiagaraSpriteVF_PrevAlignmentDataOffset;
    int NiagaraSpriteVF_SubImageBlendMode;
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    int NiagaraSpriteVF_PrevCameraOffsetDataOffset;
    char _m26_pad[4];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m27_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    float4 NiagaraSpriteVF_DefaultPrevPos;
    float2 NiagaraSpriteVF_DefaultSize;
    float2 NiagaraSpriteVF_DefaultPrevSize;
    char _m31_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    packed_float3 NiagaraSpriteVF_DefaultPrevVelocity;
    float NiagaraSpriteVF_DefaultRotation;
    float NiagaraSpriteVF_DefaultPrevRotation;
    char _m35_pad[32];
    float NiagaraSpriteVF_DefaultCamOffset;
    float NiagaraSpriteVF_DefaultPrevCamOffset;
    char _m37_pad[4];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    float4 NiagaraSpriteVF_DefaultPrevFacing;
    float4 NiagaraSpriteVF_DefaultAlignment;
    float4 NiagaraSpriteVF_DefaultPrevAlignment;
};

constant float2 _85 = {};
constant float3x3 _86 = {};

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

vertex MainVertexShader_out Main_0000be62_778f0c77(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _156;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _156 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _156 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _220;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _220 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _219;
            switch (0u)
            {
                default:
                {
                    uint _169 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _173 = int(_169 & 2147483647u);
                    if ((_169 & 2147483648u) != 0u)
                    {
                        _219 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_173) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_173 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_173 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _219 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_173) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_173 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_173 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _220 = _219;
            break;
        }
    }
    bool _227;
    float3 _247;
    switch (0u)
    {
        default:
        {
            _227 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_227)
            {
                _247 = (((Primitive.Primitive_LocalToWorld[0].xyz * _220.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _220.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _220.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _247 = _220;
            break;
        }
    }
    float _284;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _284 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _283;
            switch (0u)
            {
                default:
                {
                    uint _259 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _263 = int(_259 & 2147483647u);
                    if ((_259 & 2147483648u) != 0u)
                    {
                        _283 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_263) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                    else
                    {
                        _283 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_263) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                }
            }
            _284 = _283;
            break;
        }
    }
    float _285 = _284 * 0.0174532942473888397216796875;
    float2 _336;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _336 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _335;
            switch (0u)
            {
                default:
                {
                    uint _297 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _301 = int(_297 & 2147483647u);
                    if ((_297 & 2147483648u) != 0u)
                    {
                        _335 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_301) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_301 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _335 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_301) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_301 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _336 = _335;
            break;
        }
    }
    float3 _399;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _399 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _398;
            switch (0u)
            {
                default:
                {
                    uint _348 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _352 = int(_348 & 2147483647u);
                    if ((_348 & 2147483648u) != 0u)
                    {
                        _398 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_352) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_352 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_352 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _398 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_352) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_352 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_352 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _399 = _398;
            break;
        }
    }
    float3 _426;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _426 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _399.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _399.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _399.zzz);
                break;
            }
            _426 = _399;
            break;
        }
    }
    float _463;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _463 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _462;
            switch (0u)
            {
                default:
                {
                    uint _438 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _442 = int(_438 & 2147483647u);
                    if ((_438 & 2147483648u) != 0u)
                    {
                        _462 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_442) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                    else
                    {
                        _462 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_442) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                }
            }
            _463 = _462;
            break;
        }
    }
    float3 _527;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _527 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _526;
            switch (0u)
            {
                default:
                {
                    uint _476 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _480 = int(_476 & 2147483647u);
                    if ((_476 & 2147483648u) != 0u)
                    {
                        _526 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_480) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_480 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_480 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _526 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_480) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_480 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_480 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _527 = _526;
            break;
        }
    }
    float3 _554;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _554 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _527.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _527.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _527.zzz);
                break;
            }
            _554 = _527;
            break;
        }
    }
    float3 _622;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _622 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _621;
            switch (0u)
            {
                default:
                {
                    uint _571 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _575 = int(_571 & 2147483647u);
                    if ((_571 & 2147483648u) != 0u)
                    {
                        _621 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_575) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_575 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_575 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _621 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_575) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_575 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_575 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _622 = _621;
            break;
        }
    }
    float3 _649;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _649 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _622.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _622.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _622.zzz);
                break;
            }
            _649 = _622;
            break;
        }
    }
    float2 _704;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _704 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _703;
            switch (0u)
            {
                default:
                {
                    uint _665 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _669 = int(_665 & 2147483647u);
                    if ((_665 & 2147483648u) != 0u)
                    {
                        _703 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_669) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_669 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _703 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_669) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_669 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _704 = _703;
            break;
        }
    }
    float3 _705 = View.View_WorldCameraOrigin - _247;
    float3 _709 = _705 / float3(fast::max(length(_705), 9.9999999747524270787835121154785e-07));
    float _746;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _746 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _745;
            switch (0u)
            {
                default:
                {
                    uint _721 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _725 = int(_721 & 2147483647u);
                    if ((_721 & 2147483648u) != 0u)
                    {
                        _745 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_725) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                    else
                    {
                        _745 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_725) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                }
            }
            _746 = _745;
            break;
        }
    }
    float _751 = length(_426);
    float3 _759 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _760 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _759);
    float3 _761 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _759);
    float3 _762 = -_761;
    float3 _763 = -View.View_ViewForward;
    bool _766 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _767 = bool3(_766);
    float3 _768 = select(_709, _554 / float3(fast::max(length(_554), 9.9999999747524270787835121154785e-07)), _767);
    float3 _773 = float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u));
    float3 _774 = mix(select(float3(0.0, 0.0, 1.0), _426 / float3(_751), bool3(_751 > 9.9999999747524270787835121154785e-07)), _649 / float3(fast::max(length(_649), 9.9999999747524270787835121154785e-07)), _773);
    float3 _775 = cross(_768, _774);
    float3 _779 = _775 / float3(fast::max(length(_775), 9.9999999747524270787835121154785e-07));
    float3 _783 = float3(float(_766));
    float3 _785 = cross(_763, _761);
    float3 _789 = _785 / float3(fast::max(length(_785), 9.9999999747524270787835121154785e-07));
    float3 _790 = cross(_763, _789);
    float3 _791 = cross(_768, _761);
    float3 _795 = _791 / float3(fast::max(length(_791), 9.9999999747524270787835121154785e-07));
    float3 _797 = cross(_709, float3(0.0, 0.0, 1.0));
    float3 _801 = _797 / float3(fast::max(length(_797), 9.9999999747524270787835121154785e-07));
    bool _803 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u;
    float3 _839;
    float3 _840;
    if (_803)
    {
        float3 _837;
        float3 _838;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _834 = float3(fast::clamp((dot(_705, _705) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _837 = mix(cross(_709, _797), _762, _834);
            _838 = mix(_797, _760, _834);
        }
        else
        {
            float3 _823;
            float3 _824;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _823 = _762;
                _824 = _760;
            }
            else
            {
                float3 _821;
                float3 _822;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _821 = _790;
                    _822 = _789;
                }
                else
                {
                    _821 = select(cross(_709, _801), cross(_768, _795), _767);
                    _822 = select(_801, _795, _767);
                }
                _823 = _821;
                _824 = _822;
            }
            _837 = _823;
            _838 = _824;
        }
        _839 = _837;
        _840 = _838;
    }
    else
    {
        _839 = mix(-_774, cross(_768, _779), _783);
        _840 = _779;
    }
    float _846 = (_285 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _847 = sin(_846);
    float _848 = cos(_846);
    float3 _853 = (_839 * _847) + (_840 * _848);
    float3 _854 = (_839 * _848) - (_840 * _847);
    float2 _857 = float2(int2(sign(_336)));
    bool _860 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u;
    float2 _897;
    if (_860)
    {
        uint _866 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _874 = _857.x;
        float _875 = _857.y;
        uint _882;
        if ((_874 * _875) < 0.0)
        {
            _882 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _866;
        }
        else
        {
            _882 = _866;
        }
        float4 _886 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_463, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _882)));
        float _888 = _886.x;
        float2 _891 = _85;
        _891.x = (_874 < 0.0) ? (1.0 - _888) : _888;
        float _893 = _886.y;
        float2 _896 = _891;
        _896.y = (_875 < 0.0) ? (1.0 - _893) : _893;
        _897 = _896;
    }
    else
    {
        _897 = in.in_var_ATTRIBUTE0;
    }
    float3 _969;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset == (-1))
            {
                _969 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevPos.xyz;
                break;
            }
            float3 _968;
            switch (0u)
            {
                default:
                {
                    uint _918 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset);
                    int _922 = int(_918 & 2147483647u);
                    if ((_918 & 2147483648u) != 0u)
                    {
                        _968 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_922) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_922 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_922 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _968 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_922) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_922 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_922 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _969 = _968;
            break;
        }
    }
    float3 _993;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _993 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _969.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _969.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _969.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                break;
            }
            _993 = _969;
            break;
        }
    }
    float _1030;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset == (-1))
            {
                _1030 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevRotation;
                break;
            }
            float _1029;
            switch (0u)
            {
                default:
                {
                    uint _1005 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset);
                    int _1009 = int(_1005 & 2147483647u);
                    if ((_1005 & 2147483648u) != 0u)
                    {
                        _1029 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1009) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                    else
                    {
                        _1029 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1009) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                }
            }
            _1030 = _1029;
            break;
        }
    }
    float2 _1082;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset == (-1))
            {
                _1082 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevSize;
                break;
            }
            float2 _1081;
            switch (0u)
            {
                default:
                {
                    uint _1043 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset);
                    int _1047 = int(_1043 & 2147483647u);
                    if ((_1043 & 2147483648u) != 0u)
                    {
                        _1081 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1047) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1047 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _1081 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1047) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1047 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _1082 = _1081;
            break;
        }
    }
    float3 _1145;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset == (-1))
            {
                _1145 = float3(NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevVelocity);
                break;
            }
            float3 _1144;
            switch (0u)
            {
                default:
                {
                    uint _1094 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset);
                    int _1098 = int(_1094 & 2147483647u);
                    if ((_1094 & 2147483648u) != 0u)
                    {
                        _1144 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1098) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1098 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1098 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _1144 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1098) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1098 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1098 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _1145 = _1144;
            break;
        }
    }
    float3 _1172;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _1172 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1145.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1145.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1145.zzz);
                break;
            }
            _1172 = _1145;
            break;
        }
    }
    float3 _1236;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset == (-1))
            {
                _1236 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevFacing.xyz;
                break;
            }
            float3 _1235;
            switch (0u)
            {
                default:
                {
                    uint _1185 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset);
                    int _1189 = int(_1185 & 2147483647u);
                    if ((_1185 & 2147483648u) != 0u)
                    {
                        _1235 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1189) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1189 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1189 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _1235 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1189) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1189 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1189 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _1236 = _1235;
            break;
        }
    }
    float3 _1263;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _1263 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1236.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1236.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1236.zzz);
                break;
            }
            _1263 = _1236;
            break;
        }
    }
    float3 _1331;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset == (-1))
            {
                _1331 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevAlignment.xyz;
                break;
            }
            float3 _1330;
            switch (0u)
            {
                default:
                {
                    uint _1280 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset);
                    int _1284 = int(_1280 & 2147483647u);
                    if ((_1280 & 2147483648u) != 0u)
                    {
                        _1330 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1284) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1284 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1284 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                    else
                    {
                        _1330 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1284) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1284 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1284 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x);
                        break;
                    }
                }
            }
            _1331 = _1330;
            break;
        }
    }
    float3 _1358;
    switch (0u)
    {
        default:
        {
            if (_227)
            {
                _1358 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1331.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1331.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1331.zzz);
                break;
            }
            _1358 = _1331;
            break;
        }
    }
    float3 _1363 = View.View_PrevWorldCameraOrigin - _993;
    float _1404;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset == (-1))
            {
                _1404 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevCamOffset;
                break;
            }
            float _1403;
            switch (0u)
            {
                default:
                {
                    uint _1379 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset);
                    int _1383 = int(_1379 & 2147483647u);
                    if ((_1379 & 2147483648u) != 0u)
                    {
                        _1403 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1383) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                    else
                    {
                        _1403 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1383) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _156))).x;
                        break;
                    }
                }
            }
            _1404 = _1403;
            break;
        }
    }
    float _1406 = length(_1172);
    float3 _1412 = View.View_WorldCameraOrigin - _993;
    float3 _1416 = _1412 / float3(fast::max(length(_1412), 9.9999999747524270787835121154785e-07));
    float3 _1417 = select(_1416, _1263 / float3(fast::max(length(_1263), 9.9999999747524270787835121154785e-07)), _767);
    float3 _1418 = mix(select(float3(0.0, 0.0, 1.0), _1172 / float3(_1406), bool3(_1406 > 9.9999999747524270787835121154785e-07)), _1358 / float3(fast::max(length(_1358), 9.9999999747524270787835121154785e-07)), _773);
    float3 _1419 = cross(_1417, _1418);
    float3 _1423 = _1419 / float3(fast::max(length(_1419), 9.9999999747524270787835121154785e-07));
    float3 _1427 = cross(_1417, _761);
    float3 _1431 = _1427 / float3(fast::max(length(_1427), 9.9999999747524270787835121154785e-07));
    float3 _1433 = cross(_1416, float3(0.0, 0.0, 1.0));
    float3 _1437 = _1433 / float3(fast::max(length(_1433), 9.9999999747524270787835121154785e-07));
    float3 _1474;
    float3 _1475;
    if (_803)
    {
        float3 _1472;
        float3 _1473;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _1469 = float3(fast::clamp((dot(_1412, _1412) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _1472 = mix(cross(_1416, _1433), _762, _1469);
            _1473 = mix(_1433, _760, _1469);
        }
        else
        {
            float3 _1458;
            float3 _1459;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _1458 = _762;
                _1459 = _760;
            }
            else
            {
                float3 _1456;
                float3 _1457;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _1456 = _790;
                    _1457 = _789;
                }
                else
                {
                    _1456 = select(cross(_1416, _1437), cross(_1417, _1431), _767);
                    _1457 = select(_1437, _1431, _767);
                }
                _1458 = _1456;
                _1459 = _1457;
            }
            _1472 = _1458;
            _1473 = _1459;
        }
        _1474 = _1472;
        _1475 = _1473;
    }
    else
    {
        _1474 = mix(-_1418, cross(_1417, _1423), _783);
        _1475 = _1423;
    }
    float _1477 = ((_1030 * 0.0174532942473888397216796875) * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _1478 = sin(_1477);
    float _1479 = cos(_1477);
    float2 _1488 = float2(int2(sign(_1082)));
    float2 _1525;
    if (_860)
    {
        uint _1494 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _1502 = _1488.x;
        float _1503 = _1488.y;
        uint _1510;
        if ((_1502 * _1503) < 0.0)
        {
            _1510 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _1494;
        }
        else
        {
            _1510 = _1494;
        }
        float4 _1514 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_463, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _1510)));
        float _1516 = _1514.x;
        float2 _1519 = _85;
        _1519.x = (_1502 < 0.0) ? (1.0 - _1516) : _1516;
        float _1521 = _1514.y;
        float2 _1524 = _1519;
        _1524.y = (_1503 < 0.0) ? (1.0 - _1521) : _1521;
        _1525 = _1524;
    }
    else
    {
        _1525 = in.in_var_ATTRIBUTE0;
    }
    float3x3 _1538 = _86;
    _1538[0] = _853;
    float3x3 _1539 = _1538;
    _1539[1] = _854;
    float3x3 _1573;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1572 = _1539;
        _1572[2] = normalize(cross(_853, _854));
        _1573 = _1572;
    }
    else
    {
        float3x3 _1569;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1568 = _1539;
            _1568[2] = normalize(_247 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1569 = _1568;
        }
        else
        {
            float3x3 _1562 = _1539;
            _1562[2] = normalize(_247 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _247 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1569 = _1562;
        }
        _1573 = _1569;
    }
    float4 _1580 = float4(_1573[0].x, _1573[0].y, _1573[0].z, float4(0.0).w);
    _1580.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? fract(_463) : 0.0;
    float4 _1597 = View.View_TranslatedWorldToClip * float4((_247 + ((_709 * _746) + (float2x3(_853, _854) * (abs(float4(_336, _285, _463).xy) * (_897 - _704))))) + View.View_PreViewTranslation, 1.0);
    float4 _1606 = _1597;
    _1606.z = _1597.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1597.w) : 0.0);
    out.gl_Position = _1606;
    out.out_var_TEXCOORD6 = _1597;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_993 + (((_1363 / float3(fast::max(length(_1363), 9.9999999747524270787835121154785e-07))) * _1404) + (float2x3((_1474 * _1478) + (_1475 * _1479), (_1474 * _1479) - (_1475 * _1478)) * (abs(_1082) * (_1525 - _704))))) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _1580;
    out.out_var_TEXCOORD11 = float4(_1573[2], float(int(sign(determinant(_1573)))));
    return out;
}

