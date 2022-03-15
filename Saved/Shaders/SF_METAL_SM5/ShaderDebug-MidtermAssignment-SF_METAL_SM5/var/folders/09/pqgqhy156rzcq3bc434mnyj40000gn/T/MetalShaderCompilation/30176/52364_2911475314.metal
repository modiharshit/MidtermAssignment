

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
    int NiagaraSpriteVF_UVScaleDataOffset;
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m28_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    float4 NiagaraSpriteVF_DefaultPrevPos;
    float2 NiagaraSpriteVF_DefaultSize;
    float2 NiagaraSpriteVF_DefaultPrevSize;
    float2 NiagaraSpriteVF_DefaultUVScale;
    float3 NiagaraSpriteVF_DefaultVelocity;
    packed_float3 NiagaraSpriteVF_DefaultPrevVelocity;
    float NiagaraSpriteVF_DefaultRotation;
    float NiagaraSpriteVF_DefaultPrevRotation;
    char _m37_pad[32];
    float NiagaraSpriteVF_DefaultCamOffset;
    float NiagaraSpriteVF_DefaultPrevCamOffset;
    char _m39_pad[4];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    float4 NiagaraSpriteVF_DefaultPrevFacing;
    float4 NiagaraSpriteVF_DefaultAlignment;
    float4 NiagaraSpriteVF_DefaultPrevAlignment;
};

constant float2 _92 = {};
constant float3x3 _93 = {};
constant float2 _94 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10 [[user(locn2)]];
    float4 out_var_TEXCOORD11 [[user(locn3)]];
    float4 out_var_TEXCOORD1_0 [[user(locn4)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
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

vertex MainVertexShader_out Main_0000cc8c_ad899672(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _166;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _166 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _166 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _230;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _230 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _229;
            switch (0u)
            {
                default:
                {
                    uint _179 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _183 = int(_179 & 2147483647u);
                    if ((_179 & 2147483648u) != 0u)
                    {
                        _229 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_183 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _229 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_183 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _230 = _229;
            break;
        }
    }
    bool _237;
    float3 _257;
    switch (0u)
    {
        default:
        {
            _237 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_237)
            {
                _257 = (((Primitive.Primitive_LocalToWorld[0].xyz * _230.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _230.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _230.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _257 = _230;
            break;
        }
    }
    float _294;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _294 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _293;
            switch (0u)
            {
                default:
                {
                    uint _269 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _273 = int(_269 & 2147483647u);
                    if ((_269 & 2147483648u) != 0u)
                    {
                        _293 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_273) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                    else
                    {
                        _293 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_273) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                }
            }
            _294 = _293;
            break;
        }
    }
    float _295 = _294 * 0.0174532942473888397216796875;
    float2 _346;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _346 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _345;
            switch (0u)
            {
                default:
                {
                    uint _307 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _311 = int(_307 & 2147483647u);
                    if ((_307 & 2147483648u) != 0u)
                    {
                        _345 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_311) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_311 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _345 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_311) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_311 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _346 = _345;
            break;
        }
    }
    float3 _409;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _409 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _408;
            switch (0u)
            {
                default:
                {
                    uint _358 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _362 = int(_358 & 2147483647u);
                    if ((_358 & 2147483648u) != 0u)
                    {
                        _408 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_362) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_362 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_362 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _408 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_362) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_362 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_362 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _409 = _408;
            break;
        }
    }
    float3 _436;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _436 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _409.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _409.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _409.zzz);
                break;
            }
            _436 = _409;
            break;
        }
    }
    float _473;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _473 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _472;
            switch (0u)
            {
                default:
                {
                    uint _448 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _452 = int(_448 & 2147483647u);
                    if ((_448 & 2147483648u) != 0u)
                    {
                        _472 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_452) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                    else
                    {
                        _472 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_452) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                }
            }
            _473 = _472;
            break;
        }
    }
    float3 _537;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _537 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _536;
            switch (0u)
            {
                default:
                {
                    uint _486 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _490 = int(_486 & 2147483647u);
                    if ((_486 & 2147483648u) != 0u)
                    {
                        _536 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_490) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_490 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_490 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _536 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_490) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_490 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_490 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _537 = _536;
            break;
        }
    }
    float3 _564;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _564 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _537.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _537.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _537.zzz);
                break;
            }
            _564 = _537;
            break;
        }
    }
    float3 _632;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _632 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _631;
            switch (0u)
            {
                default:
                {
                    uint _581 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _585 = int(_581 & 2147483647u);
                    if ((_581 & 2147483648u) != 0u)
                    {
                        _631 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_585) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_585 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_585 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _631 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_585) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_585 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_585 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _632 = _631;
            break;
        }
    }
    float3 _659;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _659 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _632.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _632.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _632.zzz);
                break;
            }
            _659 = _632;
            break;
        }
    }
    float2 _714;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _714 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _713;
            switch (0u)
            {
                default:
                {
                    uint _675 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _679 = int(_675 & 2147483647u);
                    if ((_675 & 2147483648u) != 0u)
                    {
                        _713 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_679) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_679 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _713 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_679) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_679 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _714 = _713;
            break;
        }
    }
    float2 _765;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _765 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _764;
            switch (0u)
            {
                default:
                {
                    uint _726 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _730 = int(_726 & 2147483647u);
                    if ((_726 & 2147483648u) != 0u)
                    {
                        _764 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_730) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_730 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _764 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_730) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_730 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _765 = _764;
            break;
        }
    }
    float3 _766 = View.View_WorldCameraOrigin - _257;
    float3 _770 = _766 / float3(fast::max(length(_766), 9.9999999747524270787835121154785e-07));
    float _807;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _807 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _806;
            switch (0u)
            {
                default:
                {
                    uint _782 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _786 = int(_782 & 2147483647u);
                    if ((_782 & 2147483648u) != 0u)
                    {
                        _806 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_786) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                    else
                    {
                        _806 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_786) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                }
            }
            _807 = _806;
            break;
        }
    }
    float _812 = length(_436);
    float3 _820 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _821 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _820);
    float3 _822 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _820);
    float3 _823 = -_822;
    float3 _824 = -View.View_ViewForward;
    bool _827 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _828 = bool3(_827);
    float3 _829 = select(_770, _564 / float3(fast::max(length(_564), 9.9999999747524270787835121154785e-07)), _828);
    float3 _834 = float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u));
    float3 _835 = mix(select(float3(0.0, 0.0, 1.0), _436 / float3(_812), bool3(_812 > 9.9999999747524270787835121154785e-07)), _659 / float3(fast::max(length(_659), 9.9999999747524270787835121154785e-07)), _834);
    float3 _836 = cross(_829, _835);
    float3 _840 = _836 / float3(fast::max(length(_836), 9.9999999747524270787835121154785e-07));
    float3 _844 = float3(float(_827));
    float3 _846 = cross(_824, _822);
    float3 _850 = _846 / float3(fast::max(length(_846), 9.9999999747524270787835121154785e-07));
    float3 _851 = cross(_824, _850);
    float3 _852 = cross(_829, _822);
    float3 _856 = _852 / float3(fast::max(length(_852), 9.9999999747524270787835121154785e-07));
    float3 _858 = cross(_770, float3(0.0, 0.0, 1.0));
    float3 _862 = _858 / float3(fast::max(length(_858), 9.9999999747524270787835121154785e-07));
    bool _864 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u;
    float3 _900;
    float3 _901;
    if (_864)
    {
        float3 _898;
        float3 _899;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _895 = float3(fast::clamp((dot(_766, _766) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _898 = mix(cross(_770, _858), _823, _895);
            _899 = mix(_858, _821, _895);
        }
        else
        {
            float3 _884;
            float3 _885;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _884 = _823;
                _885 = _821;
            }
            else
            {
                float3 _882;
                float3 _883;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _882 = _851;
                    _883 = _850;
                }
                else
                {
                    _882 = select(cross(_770, _862), cross(_829, _856), _828);
                    _883 = select(_862, _856, _828);
                }
                _884 = _882;
                _885 = _883;
            }
            _898 = _884;
            _899 = _885;
        }
        _900 = _898;
        _901 = _899;
    }
    else
    {
        _900 = mix(-_835, cross(_829, _840), _844);
        _901 = _840;
    }
    float _907 = (_295 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _908 = sin(_907);
    float _909 = cos(_907);
    float3 _914 = (_900 * _908) + (_901 * _909);
    float3 _915 = (_900 * _909) - (_901 * _908);
    float2 _918 = float2(int2(sign(_346)));
    bool _921 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u;
    float2 _971;
    float2 _972;
    if (_921)
    {
        uint _939 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _947 = _918.x;
        float _948 = _918.y;
        uint _955;
        if ((_947 * _948) < 0.0)
        {
            _955 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _939;
        }
        else
        {
            _955 = _939;
        }
        float4 _959 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_473, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _955)));
        float _962 = _959.x;
        float2 _965 = _92;
        _965.x = (_947 < 0.0) ? (1.0 - _962) : _962;
        float _967 = _959.y;
        float2 _970 = _965;
        _970.y = (_948 < 0.0) ? (1.0 - _967) : _967;
        _971 = _970;
        _972 = _959.xy;
    }
    else
    {
        float2 _930 = _94;
        _930.x = (_918.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _936 = _930;
        _936.y = (_918.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _971 = in.in_var_ATTRIBUTE0;
        _972 = _936;
    }
    float3 _1047;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset == (-1))
            {
                _1047 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevPos.xyz;
                break;
            }
            float3 _1046;
            switch (0u)
            {
                default:
                {
                    uint _996 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset);
                    int _1000 = int(_996 & 2147483647u);
                    if ((_996 & 2147483648u) != 0u)
                    {
                        _1046 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1000) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1000 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1000 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _1046 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1000) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1000 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1000 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _1047 = _1046;
            break;
        }
    }
    float3 _1071;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _1071 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _1047.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _1047.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _1047.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                break;
            }
            _1071 = _1047;
            break;
        }
    }
    float _1108;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset == (-1))
            {
                _1108 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevRotation;
                break;
            }
            float _1107;
            switch (0u)
            {
                default:
                {
                    uint _1083 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset);
                    int _1087 = int(_1083 & 2147483647u);
                    if ((_1083 & 2147483648u) != 0u)
                    {
                        _1107 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1087) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                    else
                    {
                        _1107 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1087) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                }
            }
            _1108 = _1107;
            break;
        }
    }
    float2 _1160;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset == (-1))
            {
                _1160 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevSize;
                break;
            }
            float2 _1159;
            switch (0u)
            {
                default:
                {
                    uint _1121 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset);
                    int _1125 = int(_1121 & 2147483647u);
                    if ((_1121 & 2147483648u) != 0u)
                    {
                        _1159 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1125) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1125 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _1159 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1125) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1125 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _1160 = _1159;
            break;
        }
    }
    float3 _1223;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset == (-1))
            {
                _1223 = float3(NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevVelocity);
                break;
            }
            float3 _1222;
            switch (0u)
            {
                default:
                {
                    uint _1172 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset);
                    int _1176 = int(_1172 & 2147483647u);
                    if ((_1172 & 2147483648u) != 0u)
                    {
                        _1222 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1176) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1176 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1176 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _1222 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1176) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1176 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1176 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _1223 = _1222;
            break;
        }
    }
    float3 _1250;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _1250 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1223.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1223.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1223.zzz);
                break;
            }
            _1250 = _1223;
            break;
        }
    }
    float3 _1314;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset == (-1))
            {
                _1314 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevFacing.xyz;
                break;
            }
            float3 _1313;
            switch (0u)
            {
                default:
                {
                    uint _1263 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset);
                    int _1267 = int(_1263 & 2147483647u);
                    if ((_1263 & 2147483648u) != 0u)
                    {
                        _1313 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1267) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1267 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1267 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _1313 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1267) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1267 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1267 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _1314 = _1313;
            break;
        }
    }
    float3 _1341;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _1341 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1314.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1314.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1314.zzz);
                break;
            }
            _1341 = _1314;
            break;
        }
    }
    float3 _1409;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset == (-1))
            {
                _1409 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevAlignment.xyz;
                break;
            }
            float3 _1408;
            switch (0u)
            {
                default:
                {
                    uint _1358 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset);
                    int _1362 = int(_1358 & 2147483647u);
                    if ((_1358 & 2147483648u) != 0u)
                    {
                        _1408 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1362) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1362 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1362 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                    else
                    {
                        _1408 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1362) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1362 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1362 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x);
                        break;
                    }
                }
            }
            _1409 = _1408;
            break;
        }
    }
    float3 _1436;
    switch (0u)
    {
        default:
        {
            if (_237)
            {
                _1436 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1409.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1409.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1409.zzz);
                break;
            }
            _1436 = _1409;
            break;
        }
    }
    float3 _1441 = View.View_PrevWorldCameraOrigin - _1071;
    float _1482;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset == (-1))
            {
                _1482 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevCamOffset;
                break;
            }
            float _1481;
            switch (0u)
            {
                default:
                {
                    uint _1457 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset);
                    int _1461 = int(_1457 & 2147483647u);
                    if ((_1457 & 2147483648u) != 0u)
                    {
                        _1481 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1461) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                    else
                    {
                        _1481 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1461) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _166))).x;
                        break;
                    }
                }
            }
            _1482 = _1481;
            break;
        }
    }
    float _1484 = length(_1250);
    float3 _1490 = View.View_WorldCameraOrigin - _1071;
    float3 _1494 = _1490 / float3(fast::max(length(_1490), 9.9999999747524270787835121154785e-07));
    float3 _1495 = select(_1494, _1341 / float3(fast::max(length(_1341), 9.9999999747524270787835121154785e-07)), _828);
    float3 _1496 = mix(select(float3(0.0, 0.0, 1.0), _1250 / float3(_1484), bool3(_1484 > 9.9999999747524270787835121154785e-07)), _1436 / float3(fast::max(length(_1436), 9.9999999747524270787835121154785e-07)), _834);
    float3 _1497 = cross(_1495, _1496);
    float3 _1501 = _1497 / float3(fast::max(length(_1497), 9.9999999747524270787835121154785e-07));
    float3 _1505 = cross(_1495, _822);
    float3 _1509 = _1505 / float3(fast::max(length(_1505), 9.9999999747524270787835121154785e-07));
    float3 _1511 = cross(_1494, float3(0.0, 0.0, 1.0));
    float3 _1515 = _1511 / float3(fast::max(length(_1511), 9.9999999747524270787835121154785e-07));
    float3 _1552;
    float3 _1553;
    if (_864)
    {
        float3 _1550;
        float3 _1551;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _1547 = float3(fast::clamp((dot(_1490, _1490) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _1550 = mix(cross(_1494, _1511), _823, _1547);
            _1551 = mix(_1511, _821, _1547);
        }
        else
        {
            float3 _1536;
            float3 _1537;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _1536 = _823;
                _1537 = _821;
            }
            else
            {
                float3 _1534;
                float3 _1535;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _1534 = _851;
                    _1535 = _850;
                }
                else
                {
                    _1534 = select(cross(_1494, _1515), cross(_1495, _1509), _828);
                    _1535 = select(_1515, _1509, _828);
                }
                _1536 = _1534;
                _1537 = _1535;
            }
            _1550 = _1536;
            _1551 = _1537;
        }
        _1552 = _1550;
        _1553 = _1551;
    }
    else
    {
        _1552 = mix(-_1496, cross(_1495, _1501), _844);
        _1553 = _1501;
    }
    float _1555 = ((_1108 * 0.0174532942473888397216796875) * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _1556 = sin(_1555);
    float _1557 = cos(_1555);
    float2 _1566 = float2(int2(sign(_1160)));
    float2 _1603;
    if (_921)
    {
        uint _1572 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _1580 = _1566.x;
        float _1581 = _1566.y;
        uint _1588;
        if ((_1580 * _1581) < 0.0)
        {
            _1588 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _1572;
        }
        else
        {
            _1588 = _1572;
        }
        float4 _1592 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_473, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _1588)));
        float _1594 = _1592.x;
        float2 _1597 = _92;
        _1597.x = (_1580 < 0.0) ? (1.0 - _1594) : _1594;
        float _1599 = _1592.y;
        float2 _1602 = _1597;
        _1602.y = (_1581 < 0.0) ? (1.0 - _1599) : _1599;
        _1603 = _1602;
    }
    else
    {
        _1603 = in.in_var_ATTRIBUTE0;
    }
    float _1611 = fract(_473);
    float _1612 = _473 - _1611;
    float2 _1625 = (float2(mod(_1612, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_1612 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_972 - float2(0.5)) * _765))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _1630 = _93;
    _1630[0] = _914;
    float3x3 _1631 = _1630;
    _1631[1] = _915;
    float3x3 _1665;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1664 = _1631;
        _1664[2] = normalize(cross(_914, _915));
        _1665 = _1664;
    }
    else
    {
        float3x3 _1661;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1660 = _1631;
            _1660[2] = normalize(_257 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1661 = _1660;
        }
        else
        {
            float3x3 _1654 = _1631;
            _1654[2] = normalize(_257 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _257 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1661 = _1654;
        }
        _1665 = _1661;
    }
    float4 _1673 = float4(_1665[0].x, _1665[0].y, _1665[0].z, float4(0.0).w);
    _1673.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _1611 : 0.0;
    spvUnsafeArray<float4, 1> _1683 = { float4(_1625.x, _1625.y, float4(0.0).z, float4(0.0).w) };
    float4 _1691 = View.View_TranslatedWorldToClip * float4((_257 + ((_770 * _807) + (float2x3(_914, _915) * (abs(float4(_346, _295, _473).xy) * (_971 - _714))))) + View.View_PreViewTranslation, 1.0);
    float4 _1700 = _1691;
    _1700.z = _1691.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1691.w) : 0.0);
    out.gl_Position = _1700;
    out.out_var_TEXCOORD6 = _1691;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_1071 + (((_1441 / float3(fast::max(length(_1441), 9.9999999747524270787835121154785e-07))) * _1482) + (float2x3((_1552 * _1556) + (_1553 * _1557), (_1552 * _1557) - (_1553 * _1556)) * (abs(_1160) * (_1603 - _714))))) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _1673;
    out.out_var_TEXCOORD11 = float4(_1665[2], float(int(sign(determinant(_1665)))));
    out_var_TEXCOORD1 = _1683;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

