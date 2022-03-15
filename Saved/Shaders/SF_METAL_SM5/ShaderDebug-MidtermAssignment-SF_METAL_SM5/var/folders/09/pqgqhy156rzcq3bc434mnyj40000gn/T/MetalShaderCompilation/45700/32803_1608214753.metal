

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
    char _m9_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m10_pad[336];
    int View_NumSceneColorMSAASamples;
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
    float NiagaraSpriteVF_DeltaSeconds;
    float2 NiagaraSpriteVF_DefaultPivotOffset;
    char _m11_pad[8];
    int NiagaraSpriteVF_PositionDataOffset;
    char _m12_pad[4];
    int NiagaraSpriteVF_VelocityDataOffset;
    char _m13_pad[4];
    int NiagaraSpriteVF_RotationDataOffset;
    char _m14_pad[4];
    int NiagaraSpriteVF_SizeDataOffset;
    char _m15_pad[4];
    int NiagaraSpriteVF_SubimageDataOffset;
    char _m16_pad[24];
    int NiagaraSpriteVF_FacingDataOffset;
    char _m17_pad[4];
    int NiagaraSpriteVF_AlignmentDataOffset;
    char _m18_pad[4];
    int NiagaraSpriteVF_SubImageBlendMode;
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m20_pad[4];
    int NiagaraSpriteVF_UVScaleDataOffset;
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m22_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m23_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m24_pad[8];
    float2 NiagaraSpriteVF_DefaultUVScale;
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m26_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m27_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m28_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m30_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

constant float2 _88 = {};
constant float3x3 _89 = {};
constant float2 _90 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10 [[user(locn2)]];
    float4 out_var_TEXCOORD11 [[user(locn3)]];
    float4 out_var_TEXCOORD1_0 [[user(locn4)]];
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

vertex MainVertexShader_out Main_00008023_5fdb68e1(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _148;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _148 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _148 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _212;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _212 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _211;
            switch (0u)
            {
                default:
                {
                    uint _161 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _165 = int(_161 & 2147483647u);
                    if ((_161 & 2147483648u) != 0u)
                    {
                        _211 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_165) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_165 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_165 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _211 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_165) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_165 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_165 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _212 = _211;
            break;
        }
    }
    bool _219;
    float3 _239;
    switch (0u)
    {
        default:
        {
            _219 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_219)
            {
                _239 = (((Primitive.Primitive_LocalToWorld[0].xyz * _212.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _212.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _212.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _239 = _212;
            break;
        }
    }
    float _276;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _276 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _275;
            switch (0u)
            {
                default:
                {
                    uint _251 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _255 = int(_251 & 2147483647u);
                    if ((_251 & 2147483648u) != 0u)
                    {
                        _275 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_255) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                    else
                    {
                        _275 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_255) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                }
            }
            _276 = _275;
            break;
        }
    }
    float _277 = _276 * 0.0174532942473888397216796875;
    float2 _328;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _328 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _327;
            switch (0u)
            {
                default:
                {
                    uint _289 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _293 = int(_289 & 2147483647u);
                    if ((_289 & 2147483648u) != 0u)
                    {
                        _327 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_293) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_293 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _327 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_293) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_293 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _328 = _327;
            break;
        }
    }
    float3 _391;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _391 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _390;
            switch (0u)
            {
                default:
                {
                    uint _340 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _344 = int(_340 & 2147483647u);
                    if ((_340 & 2147483648u) != 0u)
                    {
                        _390 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_344) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_344 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_344 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _390 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_344) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_344 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_344 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _391 = _390;
            break;
        }
    }
    float3 _418;
    switch (0u)
    {
        default:
        {
            if (_219)
            {
                _418 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _391.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _391.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _391.zzz);
                break;
            }
            _418 = _391;
            break;
        }
    }
    float _455;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _455 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _454;
            switch (0u)
            {
                default:
                {
                    uint _430 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _434 = int(_430 & 2147483647u);
                    if ((_430 & 2147483648u) != 0u)
                    {
                        _454 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_434) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                    else
                    {
                        _454 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_434) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                }
            }
            _455 = _454;
            break;
        }
    }
    float3 _519;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _519 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _518;
            switch (0u)
            {
                default:
                {
                    uint _468 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _472 = int(_468 & 2147483647u);
                    if ((_468 & 2147483648u) != 0u)
                    {
                        _518 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_472) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_472 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_472 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _518 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_472) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_472 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_472 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _519 = _518;
            break;
        }
    }
    float3 _546;
    switch (0u)
    {
        default:
        {
            if (_219)
            {
                _546 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _519.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _519.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _519.zzz);
                break;
            }
            _546 = _519;
            break;
        }
    }
    float3 _614;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _614 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _613;
            switch (0u)
            {
                default:
                {
                    uint _563 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _567 = int(_563 & 2147483647u);
                    if ((_563 & 2147483648u) != 0u)
                    {
                        _613 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_567) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_567 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_567 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _613 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_567) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_567 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_567 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _614 = _613;
            break;
        }
    }
    float3 _641;
    switch (0u)
    {
        default:
        {
            if (_219)
            {
                _641 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _614.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _614.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _614.zzz);
                break;
            }
            _641 = _614;
            break;
        }
    }
    float2 _696;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _696 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _695;
            switch (0u)
            {
                default:
                {
                    uint _657 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _661 = int(_657 & 2147483647u);
                    if ((_657 & 2147483648u) != 0u)
                    {
                        _695 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_661) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_661 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _695 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_661) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_661 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _696 = _695;
            break;
        }
    }
    float2 _747;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _747 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _746;
            switch (0u)
            {
                default:
                {
                    uint _708 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _712 = int(_708 & 2147483647u);
                    if ((_708 & 2147483648u) != 0u)
                    {
                        _746 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_712) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_712 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                    else
                    {
                        _746 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_712) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_712 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x);
                        break;
                    }
                }
            }
            _747 = _746;
            break;
        }
    }
    float3 _748 = View.View_WorldCameraOrigin - _239;
    float3 _752 = _748 / float3(fast::max(length(_748), 9.9999999747524270787835121154785e-07));
    float _789;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _789 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _788;
            switch (0u)
            {
                default:
                {
                    uint _764 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _768 = int(_764 & 2147483647u);
                    if ((_764 & 2147483648u) != 0u)
                    {
                        _788 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_768) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                    else
                    {
                        _788 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_768) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _148))).x;
                        break;
                    }
                }
            }
            _789 = _788;
            break;
        }
    }
    float _794 = length(_418);
    float3 _802 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _803 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _802);
    float3 _804 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _802);
    float3 _805 = -_804;
    float3 _806 = -View.View_ViewForward;
    bool _809 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _810 = bool3(_809);
    float3 _811 = select(_752, _546 / float3(fast::max(length(_546), 9.9999999747524270787835121154785e-07)), _810);
    float3 _817 = mix(select(float3(0.0, 0.0, 1.0), _418 / float3(_794), bool3(_794 > 9.9999999747524270787835121154785e-07)), _641 / float3(fast::max(length(_641), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _818 = cross(_811, _817);
    float3 _822 = _818 / float3(fast::max(length(_818), 9.9999999747524270787835121154785e-07));
    float3 _828 = cross(_806, _804);
    float3 _832 = _828 / float3(fast::max(length(_828), 9.9999999747524270787835121154785e-07));
    float3 _834 = cross(_811, _804);
    float3 _838 = _834 / float3(fast::max(length(_834), 9.9999999747524270787835121154785e-07));
    float3 _840 = cross(_752, float3(0.0, 0.0, 1.0));
    float3 _844 = _840 / float3(fast::max(length(_840), 9.9999999747524270787835121154785e-07));
    float3 _882;
    float3 _883;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _880;
        float3 _881;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _877 = float3(fast::clamp((dot(_748, _748) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _880 = mix(cross(_752, _840), _805, _877);
            _881 = mix(_840, _803, _877);
        }
        else
        {
            float3 _866;
            float3 _867;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _866 = _805;
                _867 = _803;
            }
            else
            {
                float3 _864;
                float3 _865;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _864 = cross(_806, _832);
                    _865 = _832;
                }
                else
                {
                    _864 = select(cross(_752, _844), cross(_811, _838), _810);
                    _865 = select(_844, _838, _810);
                }
                _866 = _864;
                _867 = _865;
            }
            _880 = _866;
            _881 = _867;
        }
        _882 = _880;
        _883 = _881;
    }
    else
    {
        _882 = mix(-_817, cross(_811, _822), float3(float(_809)));
        _883 = _822;
    }
    float _889 = (_277 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _890 = sin(_889);
    float _891 = cos(_889);
    float3 _896 = (_882 * _890) + (_883 * _891);
    float3 _897 = (_882 * _891) - (_883 * _890);
    float2 _900 = float2(int2(sign(_328)));
    float2 _953;
    float2 _954;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _921 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _929 = _900.x;
        float _930 = _900.y;
        uint _937;
        if ((_929 * _930) < 0.0)
        {
            _937 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _921;
        }
        else
        {
            _937 = _921;
        }
        float4 _941 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_455, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _937)));
        float _944 = _941.x;
        float2 _947 = _88;
        _947.x = (_929 < 0.0) ? (1.0 - _944) : _944;
        float _949 = _941.y;
        float2 _952 = _947;
        _952.y = (_930 < 0.0) ? (1.0 - _949) : _949;
        _953 = _952;
        _954 = _941.xy;
    }
    else
    {
        float2 _912 = _90;
        _912.x = (_900.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _918 = _912;
        _918.y = (_900.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _953 = in.in_var_ATTRIBUTE0;
        _954 = _918;
    }
    float3 _965 = _239 + ((_752 * _789) + (float2x3(_896, _897) * (abs(float4(_328, _277, _455).xy) * (_953 - _696))));
    float _970 = fract(_455);
    float _971 = _455 - _970;
    float2 _984 = (float2(mod(_971, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_971 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_954 - float2(0.5)) * _747))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _989 = _89;
    _989[0] = _896;
    float3x3 _990 = _989;
    _990[1] = _897;
    float3x3 _1024;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1023 = _990;
        _1023[2] = normalize(cross(_896, _897));
        _1024 = _1023;
    }
    else
    {
        float3x3 _1020;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1019 = _990;
            _1019[2] = normalize(_239 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1020 = _1019;
        }
        else
        {
            float3x3 _1013 = _990;
            _1013[2] = normalize(_239 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _239 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1020 = _1013;
        }
        _1024 = _1020;
    }
    float4 _1032 = float4(_1024[0].x, _1024[0].y, _1024[0].z, float4(0.0).w);
    _1032.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _970 : 0.0;
    spvUnsafeArray<float4, 1> _1042 = { float4(_984.x, _984.y, float4(0.0).z, float4(0.0).w) };
    float4 _1050 = View.View_TranslatedWorldToClip * float4(_965 + View.View_PreViewTranslation, 1.0);
    float4 _1059 = _1050;
    _1059.z = _1050.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1050.w) : 0.0);
    out.gl_Position = _1059;
    out.out_var_TEXCOORD6 = _1050;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_965 - (_418 * NiagaraSpriteVF.NiagaraSpriteVF_DeltaSeconds)) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _1032;
    out.out_var_TEXCOORD11 = float4(_1024[2], float(int(sign(determinant(_1024)))));
    out_var_TEXCOORD1 = _1042;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

