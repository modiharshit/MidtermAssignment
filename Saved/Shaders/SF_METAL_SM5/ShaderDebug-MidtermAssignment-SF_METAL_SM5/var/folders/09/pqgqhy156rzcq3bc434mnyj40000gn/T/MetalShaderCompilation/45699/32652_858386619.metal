

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

constant float2 _85 = {};
constant float3x3 _86 = {};
constant float2 _87 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
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

vertex Main_out Main_00007f8c_3329f0bb(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _140;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _140 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _140 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _204;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _204 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _203;
            switch (0u)
            {
                default:
                {
                    uint _153 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _157 = int(_153 & 2147483647u);
                    if ((_153 & 2147483648u) != 0u)
                    {
                        _203 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_157) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_157 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_157 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _203 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_157) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_157 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_157 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _204 = _203;
            break;
        }
    }
    bool _211;
    float3 _231;
    switch (0u)
    {
        default:
        {
            _211 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_211)
            {
                _231 = (((Primitive.Primitive_LocalToWorld[0].xyz * _204.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _204.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _204.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _231 = _204;
            break;
        }
    }
    float _268;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _268 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _267;
            switch (0u)
            {
                default:
                {
                    uint _243 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _247 = int(_243 & 2147483647u);
                    if ((_243 & 2147483648u) != 0u)
                    {
                        _267 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_247) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                    else
                    {
                        _267 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_247) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                }
            }
            _268 = _267;
            break;
        }
    }
    float _269 = _268 * 0.0174532942473888397216796875;
    float2 _320;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _320 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _319;
            switch (0u)
            {
                default:
                {
                    uint _281 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _285 = int(_281 & 2147483647u);
                    if ((_281 & 2147483648u) != 0u)
                    {
                        _319 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_285) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_285 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _319 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_285) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_285 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _320 = _319;
            break;
        }
    }
    float3 _383;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _383 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _382;
            switch (0u)
            {
                default:
                {
                    uint _332 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _336 = int(_332 & 2147483647u);
                    if ((_332 & 2147483648u) != 0u)
                    {
                        _382 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_336) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_336 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_336 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _382 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_336) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_336 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_336 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _383 = _382;
            break;
        }
    }
    float3 _410;
    switch (0u)
    {
        default:
        {
            if (_211)
            {
                _410 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _383.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _383.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _383.zzz);
                break;
            }
            _410 = _383;
            break;
        }
    }
    float _447;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _447 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _446;
            switch (0u)
            {
                default:
                {
                    uint _422 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _426 = int(_422 & 2147483647u);
                    if ((_422 & 2147483648u) != 0u)
                    {
                        _446 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_426) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                    else
                    {
                        _446 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_426) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                }
            }
            _447 = _446;
            break;
        }
    }
    float3 _511;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _511 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _510;
            switch (0u)
            {
                default:
                {
                    uint _460 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _464 = int(_460 & 2147483647u);
                    if ((_460 & 2147483648u) != 0u)
                    {
                        _510 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_464) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_464 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_464 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _510 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_464) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_464 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_464 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _511 = _510;
            break;
        }
    }
    float3 _538;
    switch (0u)
    {
        default:
        {
            if (_211)
            {
                _538 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _511.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _511.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _511.zzz);
                break;
            }
            _538 = _511;
            break;
        }
    }
    float3 _606;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _606 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _605;
            switch (0u)
            {
                default:
                {
                    uint _555 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _559 = int(_555 & 2147483647u);
                    if ((_555 & 2147483648u) != 0u)
                    {
                        _605 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_559) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_559 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_559 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _605 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_559) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_559 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_559 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _606 = _605;
            break;
        }
    }
    float3 _633;
    switch (0u)
    {
        default:
        {
            if (_211)
            {
                _633 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _606.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _606.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _606.zzz);
                break;
            }
            _633 = _606;
            break;
        }
    }
    float2 _688;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _688 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _687;
            switch (0u)
            {
                default:
                {
                    uint _649 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _653 = int(_649 & 2147483647u);
                    if ((_649 & 2147483648u) != 0u)
                    {
                        _687 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_653) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_653 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _687 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_653) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_653 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _688 = _687;
            break;
        }
    }
    float2 _739;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _739 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _738;
            switch (0u)
            {
                default:
                {
                    uint _700 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _704 = int(_700 & 2147483647u);
                    if ((_700 & 2147483648u) != 0u)
                    {
                        _738 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_704) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_704 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                    else
                    {
                        _738 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_704) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_704 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x);
                        break;
                    }
                }
            }
            _739 = _738;
            break;
        }
    }
    float3 _740 = View.View_WorldCameraOrigin - _231;
    float _741 = length(_740);
    float _742 = fast::max(_741, 9.9999999747524270787835121154785e-07);
    float3 _743 = float3(_742);
    float3 _744 = _740 / _743;
    float _781;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _781 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _780;
            switch (0u)
            {
                default:
                {
                    uint _756 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _760 = int(_756 & 2147483647u);
                    if ((_756 & 2147483648u) != 0u)
                    {
                        _780 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_760) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                    else
                    {
                        _780 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_760) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _140))).x;
                        break;
                    }
                }
            }
            _781 = _780;
            break;
        }
    }
    float3 _782 = _744 * _781;
    float4 _785 = float4(_320, _269, _447);
    float _786 = length(_410);
    float3 _794 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _795 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _794);
    float3 _796 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _794);
    float3 _797 = -_796;
    float3 _798 = -View.View_ViewForward;
    bool _801 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _802 = bool3(_801);
    float3 _803 = select(_744, _538 / float3(fast::max(length(_538), 9.9999999747524270787835121154785e-07)), _802);
    float3 _809 = mix(select(float3(0.0, 0.0, 1.0), _410 / float3(_786), bool3(_786 > 9.9999999747524270787835121154785e-07)), _633 / float3(fast::max(length(_633), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _810 = cross(_803, _809);
    float3 _814 = _810 / float3(fast::max(length(_810), 9.9999999747524270787835121154785e-07));
    float3 _820 = cross(_798, _796);
    float3 _824 = _820 / float3(fast::max(length(_820), 9.9999999747524270787835121154785e-07));
    float3 _826 = cross(_803, _796);
    float3 _830 = _826 / float3(fast::max(length(_826), 9.9999999747524270787835121154785e-07));
    float3 _832 = cross(_744, float3(0.0, 0.0, 1.0));
    float3 _836 = _832 / float3(fast::max(length(_832), 9.9999999747524270787835121154785e-07));
    float3 _874;
    float3 _875;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _872;
        float3 _873;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _869 = float3(fast::clamp((dot(_740, _740) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _872 = mix(cross(_744, _832), _797, _869);
            _873 = mix(_832, _795, _869);
        }
        else
        {
            float3 _858;
            float3 _859;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _858 = _797;
                _859 = _795;
            }
            else
            {
                float3 _856;
                float3 _857;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _856 = cross(_798, _824);
                    _857 = _824;
                }
                else
                {
                    _856 = select(cross(_744, _836), cross(_803, _830), _802);
                    _857 = select(_836, _830, _802);
                }
                _858 = _856;
                _859 = _857;
            }
            _872 = _858;
            _873 = _859;
        }
        _874 = _872;
        _875 = _873;
    }
    else
    {
        _874 = mix(-_809, cross(_803, _814), float3(float(_801)));
        _875 = _814;
    }
    float _878 = _269 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _881 = _878 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _882 = sin(_881);
    float _883 = cos(_881);
    float3 _884 = _875 * _882;
    float3 _885 = _874 * _882;
    float3 _886 = _875 * _883;
    float3 _887 = _874 * _883;
    float3 _888 = _885 + _886;
    float3 _889 = _887 - _884;
    float2 _892 = float2(int2(sign(_320)));
    float2 _945;
    float2 _946;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _913 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _921 = _892.x;
        float _922 = _892.y;
        uint _929;
        if ((_921 * _922) < 0.0)
        {
            _929 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _913;
        }
        else
        {
            _929 = _913;
        }
        float4 _933 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_447, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _929)));
        float _936 = _933.x;
        float2 _939 = _85;
        _939.x = (_921 < 0.0) ? (1.0 - _936) : _936;
        float _941 = _933.y;
        float2 _944 = _939;
        _944.y = (_922 < 0.0) ? (1.0 - _941) : _941;
        _945 = _944;
        _946 = _933.xy;
    }
    else
    {
        float2 _904 = _87;
        _904.x = (_892.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _910 = _904;
        _910.y = (_892.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _945 = in.in_var_ATTRIBUTE0;
        _946 = _910;
    }
    float2 _950 = _785.xy;
    float2 _951 = abs(_950);
    float2x3 _952 = float2x3(_888, _889);
    float2 _953 = _945 - _688;
    float2 _954 = _951 * _953;
    float3 _955 = _952 * _954;
    float3 _956 = _782 + _955;
    float3 _957 = _231 + _956;
    float _958 = fract(_447);
    float _959 = _447 - _958;
    float2 _972 = (float2(mod(_959, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_959 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_946 - float2(0.5)) * _739))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _977 = _86;
    _977[0] = _888;
    float3x3 _978 = _977;
    _978[1] = _889;
    float3x3 _1012;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1011 = _978;
        _1011[2] = normalize(cross(_888, _889));
        _1012 = _1011;
    }
    else
    {
        float3x3 _1008;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1007 = _978;
            _1007[2] = normalize(_231 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1008 = _1007;
        }
        else
        {
            float3x3 _1001 = _978;
            _1001[2] = normalize(_231 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _231 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1008 = _1001;
        }
        _1012 = _1008;
    }
    float3 _1013 = _957 + View.View_PreViewTranslation;
    float _1014 = _1013.x;
    float _1015 = _1013.y;
    float _1016 = _1013.z;
    float4 _1017 = float4(_1014, _1015, _1016, 1.0);
    float4 _1018 = float4(_1017.x, _1017.y, _1017.z, _1017.w);
    float4 _1019 = View.View_TranslatedWorldToClip * _1018;
    float4 _1023 = float4(_1012[0].x, _1012[0].y, _1012[0].z, float4(0.0).w);
    _1023.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _958 : 0.0;
    spvUnsafeArray<float4, 1> _1033 = { float4(_972.x, _972.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1023;
    out.out_var_TEXCOORD11 = float4(_1012[2], float(int(sign(determinant(_1012)))));
    out_var_TEXCOORD1 = _1033;
    out.gl_Position = _1019;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

