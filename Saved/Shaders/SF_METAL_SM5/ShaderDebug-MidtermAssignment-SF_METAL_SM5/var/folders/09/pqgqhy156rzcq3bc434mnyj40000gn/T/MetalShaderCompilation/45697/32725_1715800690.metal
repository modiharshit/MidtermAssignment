

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
    char _m19_pad[4];
    int NiagaraSpriteVF_UVScaleDataOffset;
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m21_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m22_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m23_pad[8];
    float2 NiagaraSpriteVF_DefaultUVScale;
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m25_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m26_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m27_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m29_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _86 = {};
constant float3x3 _87 = {};
constant float2 _88 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
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

vertex Main_out Main_00007fd5_66450a72(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
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
    float2 _740;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _740 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _739;
            switch (0u)
            {
                default:
                {
                    uint _701 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _705 = int(_701 & 2147483647u);
                    if ((_701 & 2147483648u) != 0u)
                    {
                        _739 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_705) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_705 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                    else
                    {
                        _739 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_705) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_705 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x);
                        break;
                    }
                }
            }
            _740 = _739;
            break;
        }
    }
    float3 _741 = View.View_WorldCameraOrigin - _232;
    float _742 = length(_741);
    float _743 = fast::max(_742, 9.9999999747524270787835121154785e-07);
    float3 _744 = float3(_743);
    float3 _745 = _741 / _744;
    float _782;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _782 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _781;
            switch (0u)
            {
                default:
                {
                    uint _757 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _761 = int(_757 & 2147483647u);
                    if ((_757 & 2147483648u) != 0u)
                    {
                        _781 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_761) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                    else
                    {
                        _781 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_761) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _141))).x;
                        break;
                    }
                }
            }
            _782 = _781;
            break;
        }
    }
    float3 _783 = _745 * _782;
    float4 _786 = float4(_321, _270, _448);
    float _787 = length(_411);
    float3 _795 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _796 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _795);
    float3 _797 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _795);
    float3 _798 = -_797;
    float3 _799 = -View.View_ViewForward;
    bool _802 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _803 = bool3(_802);
    float3 _804 = select(_745, _539 / float3(fast::max(length(_539), 9.9999999747524270787835121154785e-07)), _803);
    float3 _810 = mix(select(float3(0.0, 0.0, 1.0), _411 / float3(_787), bool3(_787 > 9.9999999747524270787835121154785e-07)), _634 / float3(fast::max(length(_634), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _811 = cross(_804, _810);
    float3 _815 = _811 / float3(fast::max(length(_811), 9.9999999747524270787835121154785e-07));
    float3 _821 = cross(_799, _797);
    float3 _825 = _821 / float3(fast::max(length(_821), 9.9999999747524270787835121154785e-07));
    float3 _827 = cross(_804, _797);
    float3 _831 = _827 / float3(fast::max(length(_827), 9.9999999747524270787835121154785e-07));
    float3 _833 = cross(_745, float3(0.0, 0.0, 1.0));
    float3 _837 = _833 / float3(fast::max(length(_833), 9.9999999747524270787835121154785e-07));
    float3 _875;
    float3 _876;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _873;
        float3 _874;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _870 = float3(fast::clamp((dot(_741, _741) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _873 = mix(cross(_745, _833), _798, _870);
            _874 = mix(_833, _796, _870);
        }
        else
        {
            float3 _859;
            float3 _860;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _859 = _798;
                _860 = _796;
            }
            else
            {
                float3 _857;
                float3 _858;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _857 = cross(_799, _825);
                    _858 = _825;
                }
                else
                {
                    _857 = select(cross(_745, _837), cross(_804, _831), _803);
                    _858 = select(_837, _831, _803);
                }
                _859 = _857;
                _860 = _858;
            }
            _873 = _859;
            _874 = _860;
        }
        _875 = _873;
        _876 = _874;
    }
    else
    {
        _875 = mix(-_810, cross(_804, _815), float3(float(_802)));
        _876 = _815;
    }
    float _879 = _270 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _882 = _879 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _883 = sin(_882);
    float _884 = cos(_882);
    float3 _885 = _876 * _883;
    float3 _886 = _875 * _883;
    float3 _887 = _876 * _884;
    float3 _888 = _875 * _884;
    float3 _889 = _886 + _887;
    float3 _890 = _888 - _885;
    float2 _893 = float2(int2(sign(_321)));
    float2 _946;
    float2 _947;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _914 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _922 = _893.x;
        float _923 = _893.y;
        uint _930;
        if ((_922 * _923) < 0.0)
        {
            _930 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _914;
        }
        else
        {
            _930 = _914;
        }
        float4 _934 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_448, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _930)));
        float _937 = _934.x;
        float2 _940 = _86;
        _940.x = (_922 < 0.0) ? (1.0 - _937) : _937;
        float _942 = _934.y;
        float2 _945 = _940;
        _945.y = (_923 < 0.0) ? (1.0 - _942) : _942;
        _946 = _945;
        _947 = _934.xy;
    }
    else
    {
        float2 _905 = _88;
        _905.x = (_893.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _911 = _905;
        _911.y = (_893.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _946 = in.in_var_ATTRIBUTE0;
        _947 = _911;
    }
    float2 _951 = _786.xy;
    float2 _952 = abs(_951);
    float2x3 _953 = float2x3(_889, _890);
    float2 _954 = _946 - _689;
    float2 _955 = _952 * _954;
    float3 _956 = _953 * _955;
    float3 _957 = _783 + _956;
    float3 _958 = _232 + _957;
    float _959 = fract(_448);
    float _960 = _448 - _959;
    float2 _973 = (float2(mod(_960, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_960 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_947 - float2(0.5)) * _740))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _978 = _87;
    _978[0] = _889;
    float3x3 _979 = _978;
    _979[1] = _890;
    float3x3 _1013;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1012 = _979;
        _1012[2] = normalize(cross(_889, _890));
        _1013 = _1012;
    }
    else
    {
        float3x3 _1009;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1008 = _979;
            _1008[2] = normalize(_232 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1009 = _1008;
        }
        else
        {
            float3x3 _1002 = _979;
            _1002[2] = normalize(_232 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _232 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1009 = _1002;
        }
        _1013 = _1009;
    }
    float3 _1014 = _958 + View.View_PreViewTranslation;
    float _1015 = _1014.x;
    float _1016 = _1014.y;
    float _1017 = _1014.z;
    float4 _1018 = float4(_1015, _1016, _1017, 1.0);
    float4 _1019 = float4(_1018.x, _1018.y, _1018.z, _1018.w);
    float4 _1020 = View.View_TranslatedWorldToClip * _1019;
    float4 _1024 = float4(_1013[0].x, _1013[0].y, _1013[0].z, float4(0.0).w);
    _1024.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _959 : 0.0;
    spvUnsafeArray<float4, 1> _1034 = { float4(_973.x, _973.y, float4(0.0).z, float4(0.0).w) };
    out.gl_Position = _1020;
    out.out_var_TEXCOORD10 = _1024;
    out.out_var_TEXCOORD11 = float4(_1013[2], float(int(sign(determinant(_1013)))));
    out_var_TEXCOORD1 = _1034;
    out.out_var_TEXCOORD6 = _1019;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

