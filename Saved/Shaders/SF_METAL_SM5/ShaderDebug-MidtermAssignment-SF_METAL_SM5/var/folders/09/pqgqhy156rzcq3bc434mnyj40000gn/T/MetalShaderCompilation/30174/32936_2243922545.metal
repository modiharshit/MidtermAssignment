

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

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex MainVertexShader_out Main_000080a8_85bf8a71(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
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
    float3 _610;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
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
    float _790 = length(_414);
    float3 _798 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _799 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _798);
    float3 _800 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _798);
    float3 _801 = -_800;
    float3 _802 = -View.View_ViewForward;
    bool _805 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _806 = bool3(_805);
    float3 _807 = select(_748, _542 / float3(fast::max(length(_542), 9.9999999747524270787835121154785e-07)), _806);
    float3 _813 = mix(select(float3(0.0, 0.0, 1.0), _414 / float3(_790), bool3(_790 > 9.9999999747524270787835121154785e-07)), _637 / float3(fast::max(length(_637), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _814 = cross(_807, _813);
    float3 _818 = _814 / float3(fast::max(length(_814), 9.9999999747524270787835121154785e-07));
    float3 _824 = cross(_802, _800);
    float3 _828 = _824 / float3(fast::max(length(_824), 9.9999999747524270787835121154785e-07));
    float3 _830 = cross(_807, _800);
    float3 _834 = _830 / float3(fast::max(length(_830), 9.9999999747524270787835121154785e-07));
    float3 _836 = cross(_748, float3(0.0, 0.0, 1.0));
    float3 _840 = _836 / float3(fast::max(length(_836), 9.9999999747524270787835121154785e-07));
    float3 _878;
    float3 _879;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _876;
        float3 _877;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _873 = float3(fast::clamp((dot(_744, _744) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _876 = mix(cross(_748, _836), _801, _873);
            _877 = mix(_836, _799, _873);
        }
        else
        {
            float3 _862;
            float3 _863;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _862 = _801;
                _863 = _799;
            }
            else
            {
                float3 _860;
                float3 _861;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _860 = cross(_802, _828);
                    _861 = _828;
                }
                else
                {
                    _860 = select(cross(_748, _840), cross(_807, _834), _806);
                    _861 = select(_840, _834, _806);
                }
                _862 = _860;
                _863 = _861;
            }
            _876 = _862;
            _877 = _863;
        }
        _878 = _876;
        _879 = _877;
    }
    else
    {
        _878 = mix(-_813, cross(_807, _818), float3(float(_805)));
        _879 = _818;
    }
    float _882 = _273 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _885 = _882 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _886 = sin(_885);
    float _887 = cos(_885);
    float3 _888 = _879 * _886;
    float3 _889 = _878 * _886;
    float3 _890 = _879 * _887;
    float3 _891 = _878 * _887;
    float3 _892 = _889 + _890;
    float3 _893 = _891 - _888;
    float2 _896 = float2(int2(sign(_324)));
    float2 _949;
    float2 _950;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _917 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _925 = _896.x;
        float _926 = _896.y;
        uint _933;
        if ((_925 * _926) < 0.0)
        {
            _933 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _917;
        }
        else
        {
            _933 = _917;
        }
        float4 _937 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_451, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _933)));
        float _940 = _937.x;
        float2 _943 = _89;
        _943.x = (_925 < 0.0) ? (1.0 - _940) : _940;
        float _945 = _937.y;
        float2 _948 = _943;
        _948.y = (_926 < 0.0) ? (1.0 - _945) : _945;
        _949 = _948;
        _950 = _937.xy;
    }
    else
    {
        float2 _908 = _91;
        _908.x = (_896.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _914 = _908;
        _914.y = (_896.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _949 = in.in_var_ATTRIBUTE0;
        _950 = _914;
    }
    float2 _954 = _789.xy;
    float2 _955 = abs(_954);
    float2x3 _956 = float2x3(_892, _893);
    float2 _957 = _949 - _692;
    float2 _958 = _955 * _957;
    float3 _959 = _956 * _958;
    float3 _960 = _786 + _959;
    float3 _961 = _235 + _960;
    float _962 = fract(_451);
    float _963 = _451 - _962;
    float2 _976 = (float2(mod(_963, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_963 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_950 - float2(0.5)) * _743))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _981 = _90;
    _981[0] = _892;
    float3x3 _982 = _981;
    _982[1] = _893;
    float3x3 _1016;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1015 = _982;
        _1015[2] = normalize(cross(_892, _893));
        _1016 = _1015;
    }
    else
    {
        float3x3 _1012;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1011 = _982;
            _1011[2] = normalize(_235 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1012 = _1011;
        }
        else
        {
            float3x3 _1005 = _982;
            _1005[2] = normalize(_235 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _235 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1012 = _1005;
        }
        _1016 = _1012;
    }
    float3 _1017 = _961 + View.View_PreViewTranslation;
    float _1018 = _1017.x;
    float _1019 = _1017.y;
    float _1020 = _1017.z;
    float4 _1021 = float4(_1018, _1019, _1020, 1.0);
    float4 _1022 = float4(_1021.x, _1021.y, _1021.z, _1021.w);
    float4 _1023 = View.View_TranslatedWorldToClip * _1022;
    float4 _1027 = float4(_1016[0].x, _1016[0].y, _1016[0].z, float4(0.0).w);
    _1027.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _962 : 0.0;
    spvUnsafeArray<float4, 1> _1037 = { float4(_976.x, _976.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1027;
    out.out_var_TEXCOORD11 = float4(_1016[2], float(int(sign(determinant(_1016)))));
    out_var_TEXCOORD1 = _1037;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.out_var_TEXCOORD6 = _1022;
    out.gl_Position = _1023;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

