

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

constant float2 _88 = {};
constant float3x3 _89 = {};
constant float2 _90 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
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

vertex Main_out Main_0000800d_7bf70da4(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _143;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _143 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _143 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _207;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _207 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _206;
            switch (0u)
            {
                default:
                {
                    uint _156 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _160 = int(_156 & 2147483647u);
                    if ((_156 & 2147483648u) != 0u)
                    {
                        _206 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_160) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_160 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_160 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _206 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_160) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_160 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_160 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _207 = _206;
            break;
        }
    }
    bool _214;
    float3 _234;
    switch (0u)
    {
        default:
        {
            _214 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_214)
            {
                _234 = (((Primitive.Primitive_LocalToWorld[0].xyz * _207.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _207.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _207.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _234 = _207;
            break;
        }
    }
    float _271;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _271 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _270;
            switch (0u)
            {
                default:
                {
                    uint _246 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _250 = int(_246 & 2147483647u);
                    if ((_246 & 2147483648u) != 0u)
                    {
                        _270 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_250) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                    else
                    {
                        _270 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_250) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                }
            }
            _271 = _270;
            break;
        }
    }
    float _272 = _271 * 0.0174532942473888397216796875;
    float2 _323;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _323 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _322;
            switch (0u)
            {
                default:
                {
                    uint _284 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _288 = int(_284 & 2147483647u);
                    if ((_284 & 2147483648u) != 0u)
                    {
                        _322 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_288) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_288 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _322 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_288) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_288 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _323 = _322;
            break;
        }
    }
    float3 _386;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _386 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _385;
            switch (0u)
            {
                default:
                {
                    uint _335 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _339 = int(_335 & 2147483647u);
                    if ((_335 & 2147483648u) != 0u)
                    {
                        _385 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_339) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_339 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_339 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _385 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_339) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_339 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_339 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _386 = _385;
            break;
        }
    }
    float3 _413;
    switch (0u)
    {
        default:
        {
            if (_214)
            {
                _413 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _386.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _386.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _386.zzz);
                break;
            }
            _413 = _386;
            break;
        }
    }
    float _450;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _450 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _449;
            switch (0u)
            {
                default:
                {
                    uint _425 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _429 = int(_425 & 2147483647u);
                    if ((_425 & 2147483648u) != 0u)
                    {
                        _449 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_429) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                    else
                    {
                        _449 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_429) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                }
            }
            _450 = _449;
            break;
        }
    }
    float3 _514;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _514 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _513;
            switch (0u)
            {
                default:
                {
                    uint _463 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _467 = int(_463 & 2147483647u);
                    if ((_463 & 2147483648u) != 0u)
                    {
                        _513 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_467) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_467 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_467 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _513 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_467) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_467 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_467 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _514 = _513;
            break;
        }
    }
    float3 _541;
    switch (0u)
    {
        default:
        {
            if (_214)
            {
                _541 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _514.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _514.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _514.zzz);
                break;
            }
            _541 = _514;
            break;
        }
    }
    float3 _609;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _609 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _608;
            switch (0u)
            {
                default:
                {
                    uint _558 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _562 = int(_558 & 2147483647u);
                    if ((_558 & 2147483648u) != 0u)
                    {
                        _608 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_562) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_562 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_562 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _608 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_562) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_562 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_562 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _609 = _608;
            break;
        }
    }
    float3 _636;
    switch (0u)
    {
        default:
        {
            if (_214)
            {
                _636 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _609.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _609.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _609.zzz);
                break;
            }
            _636 = _609;
            break;
        }
    }
    float2 _691;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _691 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _690;
            switch (0u)
            {
                default:
                {
                    uint _652 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _656 = int(_652 & 2147483647u);
                    if ((_652 & 2147483648u) != 0u)
                    {
                        _690 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_656) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_656 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _690 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_656) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_656 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _691 = _690;
            break;
        }
    }
    float2 _742;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _742 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _741;
            switch (0u)
            {
                default:
                {
                    uint _703 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _707 = int(_703 & 2147483647u);
                    if ((_703 & 2147483648u) != 0u)
                    {
                        _741 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_707) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_707 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                    else
                    {
                        _741 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_707) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_707 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x);
                        break;
                    }
                }
            }
            _742 = _741;
            break;
        }
    }
    float3 _743 = View.View_WorldCameraOrigin - _234;
    float _744 = length(_743);
    float _745 = fast::max(_744, 9.9999999747524270787835121154785e-07);
    float3 _746 = float3(_745);
    float3 _747 = _743 / _746;
    float _784;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _784 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _783;
            switch (0u)
            {
                default:
                {
                    uint _759 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _763 = int(_759 & 2147483647u);
                    if ((_759 & 2147483648u) != 0u)
                    {
                        _783 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_763) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                    else
                    {
                        _783 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_763) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _143))).x;
                        break;
                    }
                }
            }
            _784 = _783;
            break;
        }
    }
    float3 _785 = _747 * _784;
    float4 _788 = float4(_323, _272, _450);
    float _789 = length(_413);
    float3 _797 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _798 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _797);
    float3 _799 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _797);
    float3 _800 = -_799;
    float3 _801 = -View.View_ViewForward;
    bool _804 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _805 = bool3(_804);
    float3 _806 = select(_747, _541 / float3(fast::max(length(_541), 9.9999999747524270787835121154785e-07)), _805);
    float3 _812 = mix(select(float3(0.0, 0.0, 1.0), _413 / float3(_789), bool3(_789 > 9.9999999747524270787835121154785e-07)), _636 / float3(fast::max(length(_636), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _813 = cross(_806, _812);
    float3 _817 = _813 / float3(fast::max(length(_813), 9.9999999747524270787835121154785e-07));
    float3 _823 = cross(_801, _799);
    float3 _827 = _823 / float3(fast::max(length(_823), 9.9999999747524270787835121154785e-07));
    float3 _829 = cross(_806, _799);
    float3 _833 = _829 / float3(fast::max(length(_829), 9.9999999747524270787835121154785e-07));
    float3 _835 = cross(_747, float3(0.0, 0.0, 1.0));
    float3 _839 = _835 / float3(fast::max(length(_835), 9.9999999747524270787835121154785e-07));
    float3 _877;
    float3 _878;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _875;
        float3 _876;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _872 = float3(fast::clamp((dot(_743, _743) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _875 = mix(cross(_747, _835), _800, _872);
            _876 = mix(_835, _798, _872);
        }
        else
        {
            float3 _861;
            float3 _862;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _861 = _800;
                _862 = _798;
            }
            else
            {
                float3 _859;
                float3 _860;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _859 = cross(_801, _827);
                    _860 = _827;
                }
                else
                {
                    _859 = select(cross(_747, _839), cross(_806, _833), _805);
                    _860 = select(_839, _833, _805);
                }
                _861 = _859;
                _862 = _860;
            }
            _875 = _861;
            _876 = _862;
        }
        _877 = _875;
        _878 = _876;
    }
    else
    {
        _877 = mix(-_812, cross(_806, _817), float3(float(_804)));
        _878 = _817;
    }
    float _881 = _272 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _884 = _881 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _885 = sin(_884);
    float _886 = cos(_884);
    float3 _887 = _878 * _885;
    float3 _888 = _877 * _885;
    float3 _889 = _878 * _886;
    float3 _890 = _877 * _886;
    float3 _891 = _888 + _889;
    float3 _892 = _890 - _887;
    float2 _895 = float2(int2(sign(_323)));
    float2 _948;
    float2 _949;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _916 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _924 = _895.x;
        float _925 = _895.y;
        uint _932;
        if ((_924 * _925) < 0.0)
        {
            _932 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _916;
        }
        else
        {
            _932 = _916;
        }
        float4 _936 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_450, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _932)));
        float _939 = _936.x;
        float2 _942 = _88;
        _942.x = (_924 < 0.0) ? (1.0 - _939) : _939;
        float _944 = _936.y;
        float2 _947 = _942;
        _947.y = (_925 < 0.0) ? (1.0 - _944) : _944;
        _948 = _947;
        _949 = _936.xy;
    }
    else
    {
        float2 _907 = _90;
        _907.x = (_895.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _913 = _907;
        _913.y = (_895.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _948 = in.in_var_ATTRIBUTE0;
        _949 = _913;
    }
    float2 _953 = _788.xy;
    float2 _954 = abs(_953);
    float2x3 _955 = float2x3(_891, _892);
    float2 _956 = _948 - _691;
    float2 _957 = _954 * _956;
    float3 _958 = _955 * _957;
    float3 _959 = _785 + _958;
    float3 _960 = _234 + _959;
    float _961 = fract(_450);
    float _962 = _450 - _961;
    float2 _975 = (float2(mod(_962, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_962 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_949 - float2(0.5)) * _742))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _980 = _89;
    _980[0] = _891;
    float3x3 _981 = _980;
    _981[1] = _892;
    float3x3 _1015;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1014 = _981;
        _1014[2] = normalize(cross(_891, _892));
        _1015 = _1014;
    }
    else
    {
        float3x3 _1011;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1010 = _981;
            _1010[2] = normalize(_234 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1011 = _1010;
        }
        else
        {
            float3x3 _1004 = _981;
            _1004[2] = normalize(_234 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _234 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1011 = _1004;
        }
        _1015 = _1011;
    }
    float3 _1016 = _960 + View.View_PreViewTranslation;
    float _1017 = _1016.x;
    float _1018 = _1016.y;
    float _1019 = _1016.z;
    float4 _1020 = float4(_1017, _1018, _1019, 1.0);
    float4 _1021 = float4(_1020.x, _1020.y, _1020.z, _1020.w);
    float4 _1022 = View.View_TranslatedWorldToClip * _1021;
    float4 _1026 = float4(_1015[0].x, _1015[0].y, _1015[0].z, float4(0.0).w);
    _1026.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _961 : 0.0;
    spvUnsafeArray<float4, 1> _1036 = { float4(_975.x, _975.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1026;
    out.out_var_TEXCOORD11 = float4(_1015[2], float(int(sign(determinant(_1015)))));
    out_var_TEXCOORD1 = _1036;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.gl_Position = _1022;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

