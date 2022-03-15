

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

constant float2 _89 = {};
constant float3x3 _90 = {};
constant float2 _91 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float4 out_var_PARTICLE_VELOCITY [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
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

vertex Main_out Main_00008bcd_b380380b(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _144;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _144 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _144 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _208;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _208 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _207;
            switch (0u)
            {
                default:
                {
                    uint _157 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _161 = int(_157 & 2147483647u);
                    if ((_157 & 2147483648u) != 0u)
                    {
                        _207 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_161) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_161 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_161 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _207 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_161) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_161 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_161 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _208 = _207;
            break;
        }
    }
    bool _215;
    float3 _235;
    switch (0u)
    {
        default:
        {
            _215 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_215)
            {
                _235 = (((Primitive.Primitive_LocalToWorld[0].xyz * _208.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _208.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _208.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _235 = _208;
            break;
        }
    }
    float _272;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _272 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _271;
            switch (0u)
            {
                default:
                {
                    uint _247 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _251 = int(_247 & 2147483647u);
                    if ((_247 & 2147483648u) != 0u)
                    {
                        _271 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_251) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                    else
                    {
                        _271 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_251) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                }
            }
            _272 = _271;
            break;
        }
    }
    float _273 = _272 * 0.0174532942473888397216796875;
    float2 _324;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _324 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _323;
            switch (0u)
            {
                default:
                {
                    uint _285 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _289 = int(_285 & 2147483647u);
                    if ((_285 & 2147483648u) != 0u)
                    {
                        _323 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_289) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_289 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _323 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_289) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_289 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _324 = _323;
            break;
        }
    }
    float3 _387;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _387 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _386;
            switch (0u)
            {
                default:
                {
                    uint _336 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _340 = int(_336 & 2147483647u);
                    if ((_336 & 2147483648u) != 0u)
                    {
                        _386 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_340) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_340 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_340 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _386 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_340) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_340 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_340 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _387 = _386;
            break;
        }
    }
    float3 _414;
    switch (0u)
    {
        default:
        {
            if (_215)
            {
                _414 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _387.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _387.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _387.zzz);
                break;
            }
            _414 = _387;
            break;
        }
    }
    float _451;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _451 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _450;
            switch (0u)
            {
                default:
                {
                    uint _426 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _430 = int(_426 & 2147483647u);
                    if ((_426 & 2147483648u) != 0u)
                    {
                        _450 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_430) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                    else
                    {
                        _450 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_430) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                }
            }
            _451 = _450;
            break;
        }
    }
    float3 _515;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _515 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _514;
            switch (0u)
            {
                default:
                {
                    uint _464 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _468 = int(_464 & 2147483647u);
                    if ((_464 & 2147483648u) != 0u)
                    {
                        _514 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_468) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_468 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_468 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _514 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_468) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_468 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_468 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _515 = _514;
            break;
        }
    }
    float3 _542;
    switch (0u)
    {
        default:
        {
            if (_215)
            {
                _542 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _515.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _515.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _515.zzz);
                break;
            }
            _542 = _515;
            break;
        }
    }
    bool _554;
    float3 _610;
    switch (0u)
    {
        default:
        {
            _554 = NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1);
            if (_554)
            {
                _610 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _609;
            switch (0u)
            {
                default:
                {
                    uint _559 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _563 = int(_559 & 2147483647u);
                    if ((_559 & 2147483648u) != 0u)
                    {
                        _609 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_563) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_563 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_563 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _609 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_563) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_563 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_563 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _610 = _609;
            break;
        }
    }
    float3 _637;
    switch (0u)
    {
        default:
        {
            if (_215)
            {
                _637 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _610.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _610.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _610.zzz);
                break;
            }
            _637 = _610;
            break;
        }
    }
    float2 _692;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _692 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _691;
            switch (0u)
            {
                default:
                {
                    uint _653 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _657 = int(_653 & 2147483647u);
                    if ((_653 & 2147483648u) != 0u)
                    {
                        _691 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_657) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_657 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _691 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_657) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_657 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _692 = _691;
            break;
        }
    }
    float2 _743;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _743 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _742;
            switch (0u)
            {
                default:
                {
                    uint _704 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _708 = int(_704 & 2147483647u);
                    if ((_704 & 2147483648u) != 0u)
                    {
                        _742 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_708) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_708 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _742 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_708) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_708 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _743 = _742;
            break;
        }
    }
    float3 _744 = View.View_WorldCameraOrigin - _235;
    float _745 = length(_744);
    float _746 = fast::max(_745, 9.9999999747524270787835121154785e-07);
    float3 _747 = float3(_746);
    float3 _748 = _744 / _747;
    float _785;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _785 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _784;
            switch (0u)
            {
                default:
                {
                    uint _760 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _764 = int(_760 & 2147483647u);
                    if ((_760 & 2147483648u) != 0u)
                    {
                        _784 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_764) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                    else
                    {
                        _784 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_764) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x;
                        break;
                    }
                }
            }
            _785 = _784;
            break;
        }
    }
    float3 _786 = _748 * _785;
    float4 _789 = float4(_324, _273, _451);
    float3 _847;
    switch (0u)
    {
        default:
        {
            if (_554)
            {
                _847 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _846;
            switch (0u)
            {
                default:
                {
                    uint _796 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _800 = int(_796 & 2147483647u);
                    if ((_796 & 2147483648u) != 0u)
                    {
                        _846 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_800) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_800 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_800 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                    else
                    {
                        _846 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_800) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_800 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_800 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _144))).x);
                        break;
                    }
                }
            }
            _847 = _846;
            break;
        }
    }
    float3 _874;
    switch (0u)
    {
        default:
        {
            if (_215)
            {
                _874 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _847.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _847.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _847.zzz);
                break;
            }
            _874 = _847;
            break;
        }
    }
    float _879 = length(_414);
    float3 _887 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _888 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _887);
    float3 _889 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _887);
    float3 _890 = -_889;
    float3 _891 = -View.View_ViewForward;
    bool _894 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _895 = bool3(_894);
    float3 _896 = select(_748, _542 / float3(fast::max(length(_542), 9.9999999747524270787835121154785e-07)), _895);
    bool _899 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u;
    float3 _902 = mix(select(float3(0.0, 0.0, 1.0), _414 / float3(_879), bool3(_879 > 9.9999999747524270787835121154785e-07)), _637 / float3(fast::max(length(_637), 9.9999999747524270787835121154785e-07)), float3(float(_899)));
    float3 _903 = cross(_896, _902);
    float3 _907 = _903 / float3(fast::max(length(_903), 9.9999999747524270787835121154785e-07));
    float3 _913 = cross(_891, _889);
    float3 _917 = _913 / float3(fast::max(length(_913), 9.9999999747524270787835121154785e-07));
    float3 _919 = cross(_896, _889);
    float3 _923 = _919 / float3(fast::max(length(_919), 9.9999999747524270787835121154785e-07));
    float3 _925 = cross(_748, float3(0.0, 0.0, 1.0));
    float3 _929 = _925 / float3(fast::max(length(_925), 9.9999999747524270787835121154785e-07));
    float3 _967;
    float3 _968;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _965;
        float3 _966;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _962 = float3(fast::clamp((dot(_744, _744) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _965 = mix(cross(_748, _925), _890, _962);
            _966 = mix(_925, _888, _962);
        }
        else
        {
            float3 _951;
            float3 _952;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _951 = _890;
                _952 = _888;
            }
            else
            {
                float3 _949;
                float3 _950;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _949 = cross(_891, _917);
                    _950 = _917;
                }
                else
                {
                    _949 = select(cross(_748, _929), cross(_896, _923), _895);
                    _950 = select(_929, _923, _895);
                }
                _951 = _949;
                _952 = _950;
            }
            _965 = _951;
            _966 = _952;
        }
        _967 = _965;
        _968 = _966;
    }
    else
    {
        _967 = mix(-_902, cross(_896, _907), float3(float(_894)));
        _968 = _907;
    }
    float _971 = _273 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _974 = _971 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _975 = sin(_974);
    float _976 = cos(_974);
    float3 _977 = _968 * _975;
    float3 _978 = _967 * _975;
    float3 _979 = _968 * _976;
    float3 _980 = _967 * _976;
    float3 _981 = _978 + _979;
    float3 _982 = _980 - _977;
    float2 _985 = float2(int2(sign(_324)));
    float2 _1038;
    float2 _1039;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _1006 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _1014 = _985.x;
        float _1015 = _985.y;
        uint _1022;
        if ((_1014 * _1015) < 0.0)
        {
            _1022 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _1006;
        }
        else
        {
            _1022 = _1006;
        }
        float4 _1026 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_451, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _1022)));
        float _1029 = _1026.x;
        float2 _1032 = _89;
        _1032.x = (_1014 < 0.0) ? (1.0 - _1029) : _1029;
        float _1034 = _1026.y;
        float2 _1037 = _1032;
        _1037.y = (_1015 < 0.0) ? (1.0 - _1034) : _1034;
        _1038 = _1037;
        _1039 = _1026.xy;
    }
    else
    {
        float2 _997 = _91;
        _997.x = (_985.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _1003 = _997;
        _1003.y = (_985.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _1038 = in.in_var_ATTRIBUTE0;
        _1039 = _1003;
    }
    float2 _1043 = _789.xy;
    float2 _1044 = abs(_1043);
    float2x3 _1045 = float2x3(_981, _982);
    float2 _1046 = _1038 - _692;
    float2 _1047 = _1044 * _1046;
    float3 _1048 = _1045 * _1047;
    float3 _1049 = _786 + _1048;
    float3 _1050 = _235 + _1049;
    float _1051 = fract(_451);
    float _1052 = _451 - _1051;
    float2 _1065 = (float2(mod(_1052, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_1052 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_1039 - float2(0.5)) * _743))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3 _1071 = select(_414, _874 / float3(fast::max(length(_874), 9.9999999747524270787835121154785e-07)), bool3(_899));
    float3 _1072 = normalize(_1071);
    float4 _1075 = float4(_1072.x, _1072.y, _1072.z, float4(0.0).w);
    _1075.w = length(_1071);
    float3x3 _1076 = _90;
    _1076[0] = _981;
    float3x3 _1077 = _1076;
    _1077[1] = _982;
    float3x3 _1111;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1110 = _1077;
        _1110[2] = normalize(cross(_981, _982));
        _1111 = _1110;
    }
    else
    {
        float3x3 _1107;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1106 = _1077;
            _1106[2] = normalize(_235 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1107 = _1106;
        }
        else
        {
            float3x3 _1100 = _1077;
            _1100[2] = normalize(_235 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _235 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1107 = _1100;
        }
        _1111 = _1107;
    }
    float3 _1112 = _1050 + View.View_PreViewTranslation;
    float _1113 = _1112.x;
    float _1114 = _1112.y;
    float _1115 = _1112.z;
    float4 _1116 = float4(_1113, _1114, _1115, 1.0);
    float4 _1117 = float4(_1116.x, _1116.y, _1116.z, _1116.w);
    float4 _1118 = View.View_TranslatedWorldToClip * _1117;
    float4 _1122 = float4(_1111[0].x, _1111[0].y, _1111[0].z, float4(0.0).w);
    _1122.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _1051 : 0.0;
    spvUnsafeArray<float4, 1> _1132 = { float4(_1065.x, _1065.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1122;
    out.out_var_TEXCOORD11 = float4(_1111[2], float(int(sign(determinant(_1111)))));
    out_var_TEXCOORD1 = _1132;
    out.out_var_PARTICLE_VELOCITY = _1075;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.gl_Position = _1118;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

