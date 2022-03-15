

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

constant float2 _91 = {};
constant float3x3 _92 = {};
constant float2 _93 = {};

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

vertex MainVertexShader_out Main_00008094_b1b8b6ef(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _151;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _151 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _151 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _215;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _215 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _214;
            switch (0u)
            {
                default:
                {
                    uint _164 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _168 = int(_164 & 2147483647u);
                    if ((_164 & 2147483648u) != 0u)
                    {
                        _214 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_168) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_168 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_168 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _214 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_168) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_168 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_168 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _215 = _214;
            break;
        }
    }
    bool _222;
    float3 _242;
    switch (0u)
    {
        default:
        {
            _222 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_222)
            {
                _242 = (((Primitive.Primitive_LocalToWorld[0].xyz * _215.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _215.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _215.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _242 = _215;
            break;
        }
    }
    float _279;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _279 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _278;
            switch (0u)
            {
                default:
                {
                    uint _254 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _258 = int(_254 & 2147483647u);
                    if ((_254 & 2147483648u) != 0u)
                    {
                        _278 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_258) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                    else
                    {
                        _278 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_258) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                }
            }
            _279 = _278;
            break;
        }
    }
    float _280 = _279 * 0.0174532942473888397216796875;
    float2 _331;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _331 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _330;
            switch (0u)
            {
                default:
                {
                    uint _292 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _296 = int(_292 & 2147483647u);
                    if ((_292 & 2147483648u) != 0u)
                    {
                        _330 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_296) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_296 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _330 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_296) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_296 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _331 = _330;
            break;
        }
    }
    float3 _394;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _394 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _393;
            switch (0u)
            {
                default:
                {
                    uint _343 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _347 = int(_343 & 2147483647u);
                    if ((_343 & 2147483648u) != 0u)
                    {
                        _393 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_347) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_347 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_347 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _393 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_347) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_347 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_347 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _394 = _393;
            break;
        }
    }
    float3 _421;
    switch (0u)
    {
        default:
        {
            if (_222)
            {
                _421 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _394.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _394.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _394.zzz);
                break;
            }
            _421 = _394;
            break;
        }
    }
    float _458;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _458 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _457;
            switch (0u)
            {
                default:
                {
                    uint _433 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _437 = int(_433 & 2147483647u);
                    if ((_433 & 2147483648u) != 0u)
                    {
                        _457 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_437) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                    else
                    {
                        _457 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_437) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                }
            }
            _458 = _457;
            break;
        }
    }
    float3 _522;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _522 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _521;
            switch (0u)
            {
                default:
                {
                    uint _471 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _475 = int(_471 & 2147483647u);
                    if ((_471 & 2147483648u) != 0u)
                    {
                        _521 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_475) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_475 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_475 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _521 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_475) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_475 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_475 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _522 = _521;
            break;
        }
    }
    float3 _549;
    switch (0u)
    {
        default:
        {
            if (_222)
            {
                _549 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _522.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _522.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _522.zzz);
                break;
            }
            _549 = _522;
            break;
        }
    }
    float3 _617;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _617 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _616;
            switch (0u)
            {
                default:
                {
                    uint _566 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _570 = int(_566 & 2147483647u);
                    if ((_566 & 2147483648u) != 0u)
                    {
                        _616 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_570) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_570 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_570 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _616 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_570) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_570 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_570 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _617 = _616;
            break;
        }
    }
    float3 _644;
    switch (0u)
    {
        default:
        {
            if (_222)
            {
                _644 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _617.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _617.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _617.zzz);
                break;
            }
            _644 = _617;
            break;
        }
    }
    float2 _699;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _699 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _698;
            switch (0u)
            {
                default:
                {
                    uint _660 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _664 = int(_660 & 2147483647u);
                    if ((_660 & 2147483648u) != 0u)
                    {
                        _698 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_664) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_664 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _698 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_664) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_664 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _699 = _698;
            break;
        }
    }
    float2 _750;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _750 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _749;
            switch (0u)
            {
                default:
                {
                    uint _711 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _715 = int(_711 & 2147483647u);
                    if ((_711 & 2147483648u) != 0u)
                    {
                        _749 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_715) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_715 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                    else
                    {
                        _749 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_715) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_715 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x);
                        break;
                    }
                }
            }
            _750 = _749;
            break;
        }
    }
    float3 _751 = View.View_WorldCameraOrigin - _242;
    float3 _755 = _751 / float3(fast::max(length(_751), 9.9999999747524270787835121154785e-07));
    float _792;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _792 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _791;
            switch (0u)
            {
                default:
                {
                    uint _767 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _771 = int(_767 & 2147483647u);
                    if ((_767 & 2147483648u) != 0u)
                    {
                        _791 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_771) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                    else
                    {
                        _791 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_771) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _151))).x;
                        break;
                    }
                }
            }
            _792 = _791;
            break;
        }
    }
    float _797 = length(_421);
    float3 _805 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _806 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _805);
    float3 _807 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _805);
    float3 _808 = -_807;
    float3 _809 = -View.View_ViewForward;
    bool _812 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _813 = bool3(_812);
    float3 _814 = select(_755, _549 / float3(fast::max(length(_549), 9.9999999747524270787835121154785e-07)), _813);
    float3 _820 = mix(select(float3(0.0, 0.0, 1.0), _421 / float3(_797), bool3(_797 > 9.9999999747524270787835121154785e-07)), _644 / float3(fast::max(length(_644), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _821 = cross(_814, _820);
    float3 _825 = _821 / float3(fast::max(length(_821), 9.9999999747524270787835121154785e-07));
    float3 _831 = cross(_809, _807);
    float3 _835 = _831 / float3(fast::max(length(_831), 9.9999999747524270787835121154785e-07));
    float3 _837 = cross(_814, _807);
    float3 _841 = _837 / float3(fast::max(length(_837), 9.9999999747524270787835121154785e-07));
    float3 _843 = cross(_755, float3(0.0, 0.0, 1.0));
    float3 _847 = _843 / float3(fast::max(length(_843), 9.9999999747524270787835121154785e-07));
    float3 _885;
    float3 _886;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _883;
        float3 _884;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _880 = float3(fast::clamp((dot(_751, _751) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _883 = mix(cross(_755, _843), _808, _880);
            _884 = mix(_843, _806, _880);
        }
        else
        {
            float3 _869;
            float3 _870;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _869 = _808;
                _870 = _806;
            }
            else
            {
                float3 _867;
                float3 _868;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _867 = cross(_809, _835);
                    _868 = _835;
                }
                else
                {
                    _867 = select(cross(_755, _847), cross(_814, _841), _813);
                    _868 = select(_847, _841, _813);
                }
                _869 = _867;
                _870 = _868;
            }
            _883 = _869;
            _884 = _870;
        }
        _885 = _883;
        _886 = _884;
    }
    else
    {
        _885 = mix(-_820, cross(_814, _825), float3(float(_812)));
        _886 = _825;
    }
    float _892 = (_280 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _893 = sin(_892);
    float _894 = cos(_892);
    float3 _899 = (_885 * _893) + (_886 * _894);
    float3 _900 = (_885 * _894) - (_886 * _893);
    float2 _903 = float2(int2(sign(_331)));
    float2 _956;
    float2 _957;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _924 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _932 = _903.x;
        float _933 = _903.y;
        uint _940;
        if ((_932 * _933) < 0.0)
        {
            _940 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _924;
        }
        else
        {
            _940 = _924;
        }
        float4 _944 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_458, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _940)));
        float _947 = _944.x;
        float2 _950 = _91;
        _950.x = (_932 < 0.0) ? (1.0 - _947) : _947;
        float _952 = _944.y;
        float2 _955 = _950;
        _955.y = (_933 < 0.0) ? (1.0 - _952) : _952;
        _956 = _955;
        _957 = _944.xy;
    }
    else
    {
        float2 _915 = _93;
        _915.x = (_903.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _921 = _915;
        _921.y = (_903.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _956 = in.in_var_ATTRIBUTE0;
        _957 = _921;
    }
    float3 _968 = _242 + ((_755 * _792) + (float2x3(_899, _900) * (abs(float4(_331, _280, _458).xy) * (_956 - _699))));
    float _973 = fract(_458);
    float _974 = _458 - _973;
    float2 _987 = (float2(mod(_974, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_974 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_957 - float2(0.5)) * _750))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _992 = _92;
    _992[0] = _899;
    float3x3 _993 = _992;
    _993[1] = _900;
    float3x3 _1027;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1026 = _993;
        _1026[2] = normalize(cross(_899, _900));
        _1027 = _1026;
    }
    else
    {
        float3x3 _1023;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1022 = _993;
            _1022[2] = normalize(_242 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1023 = _1022;
        }
        else
        {
            float3x3 _1016 = _993;
            _1016[2] = normalize(_242 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _242 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1023 = _1016;
        }
        _1027 = _1023;
    }
    float4 _1035 = float4(_1027[0].x, _1027[0].y, _1027[0].z, float4(0.0).w);
    _1035.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _973 : 0.0;
    spvUnsafeArray<float4, 1> _1045 = { float4(_987.x, _987.y, float4(0.0).z, float4(0.0).w) };
    float4 _1053 = View.View_TranslatedWorldToClip * float4(_968 + View.View_PreViewTranslation, 1.0);
    float4 _1062 = _1053;
    _1062.z = _1053.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1053.w) : 0.0);
    out.gl_Position = _1062;
    out.out_var_TEXCOORD6 = _1053;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_968 - (_421 * NiagaraSpriteVF.NiagaraSpriteVF_DeltaSeconds)) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _1035;
    out.out_var_TEXCOORD11 = float4(_1027[2], float(int(sign(determinant(_1027)))));
    out_var_TEXCOORD1 = _1045;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

