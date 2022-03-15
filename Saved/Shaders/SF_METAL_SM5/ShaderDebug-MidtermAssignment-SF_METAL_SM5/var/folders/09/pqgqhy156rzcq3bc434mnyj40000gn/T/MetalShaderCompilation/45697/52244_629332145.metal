

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

constant float2 _89 = {};
constant float3x3 _90 = {};
constant float2 _91 = {};

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

vertex MainVertexShader_out Main_0000cc14_2582d8b1(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _163;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _163 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _163 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _227;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _227 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _226;
            switch (0u)
            {
                default:
                {
                    uint _176 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _180 = int(_176 & 2147483647u);
                    if ((_176 & 2147483648u) != 0u)
                    {
                        _226 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_180 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _226 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_180 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _227 = _226;
            break;
        }
    }
    bool _234;
    float3 _254;
    switch (0u)
    {
        default:
        {
            _234 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_234)
            {
                _254 = (((Primitive.Primitive_LocalToWorld[0].xyz * _227.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _227.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _227.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _254 = _227;
            break;
        }
    }
    float _291;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _291 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _290;
            switch (0u)
            {
                default:
                {
                    uint _266 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _270 = int(_266 & 2147483647u);
                    if ((_266 & 2147483648u) != 0u)
                    {
                        _290 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_270) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                    else
                    {
                        _290 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_270) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                }
            }
            _291 = _290;
            break;
        }
    }
    float _292 = _291 * 0.0174532942473888397216796875;
    float2 _343;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _343 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _342;
            switch (0u)
            {
                default:
                {
                    uint _304 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _308 = int(_304 & 2147483647u);
                    if ((_304 & 2147483648u) != 0u)
                    {
                        _342 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_308) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_308 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _342 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_308) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_308 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _343 = _342;
            break;
        }
    }
    float3 _406;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _406 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _405;
            switch (0u)
            {
                default:
                {
                    uint _355 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _359 = int(_355 & 2147483647u);
                    if ((_355 & 2147483648u) != 0u)
                    {
                        _405 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_359) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_359 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_359 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _405 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_359) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_359 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_359 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _406 = _405;
            break;
        }
    }
    float3 _433;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _433 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _406.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _406.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _406.zzz);
                break;
            }
            _433 = _406;
            break;
        }
    }
    float _470;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _470 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _469;
            switch (0u)
            {
                default:
                {
                    uint _445 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _449 = int(_445 & 2147483647u);
                    if ((_445 & 2147483648u) != 0u)
                    {
                        _469 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_449) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                    else
                    {
                        _469 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_449) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                }
            }
            _470 = _469;
            break;
        }
    }
    float3 _534;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _534 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _533;
            switch (0u)
            {
                default:
                {
                    uint _483 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _487 = int(_483 & 2147483647u);
                    if ((_483 & 2147483648u) != 0u)
                    {
                        _533 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_487) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_487 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_487 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _533 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_487) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_487 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_487 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _534 = _533;
            break;
        }
    }
    float3 _561;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _561 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _534.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _534.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _534.zzz);
                break;
            }
            _561 = _534;
            break;
        }
    }
    float3 _629;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _629 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _628;
            switch (0u)
            {
                default:
                {
                    uint _578 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _582 = int(_578 & 2147483647u);
                    if ((_578 & 2147483648u) != 0u)
                    {
                        _628 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_582) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_582 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_582 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _628 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_582) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_582 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_582 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _629 = _628;
            break;
        }
    }
    float3 _656;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _656 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _629.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _629.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _629.zzz);
                break;
            }
            _656 = _629;
            break;
        }
    }
    float2 _711;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _711 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _710;
            switch (0u)
            {
                default:
                {
                    uint _672 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _676 = int(_672 & 2147483647u);
                    if ((_672 & 2147483648u) != 0u)
                    {
                        _710 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_676) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_676 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _710 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_676) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_676 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _711 = _710;
            break;
        }
    }
    float2 _762;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _762 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _761;
            switch (0u)
            {
                default:
                {
                    uint _723 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _727 = int(_723 & 2147483647u);
                    if ((_723 & 2147483648u) != 0u)
                    {
                        _761 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_727) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_727 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _761 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_727) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_727 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _762 = _761;
            break;
        }
    }
    float3 _763 = View.View_WorldCameraOrigin - _254;
    float3 _767 = _763 / float3(fast::max(length(_763), 9.9999999747524270787835121154785e-07));
    float _804;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _804 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _803;
            switch (0u)
            {
                default:
                {
                    uint _779 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _783 = int(_779 & 2147483647u);
                    if ((_779 & 2147483648u) != 0u)
                    {
                        _803 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_783) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                    else
                    {
                        _803 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_783) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                }
            }
            _804 = _803;
            break;
        }
    }
    float _809 = length(_433);
    float3 _817 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _818 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _817);
    float3 _819 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _817);
    float3 _820 = -_819;
    float3 _821 = -View.View_ViewForward;
    bool _824 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _825 = bool3(_824);
    float3 _826 = select(_767, _561 / float3(fast::max(length(_561), 9.9999999747524270787835121154785e-07)), _825);
    float3 _831 = float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u));
    float3 _832 = mix(select(float3(0.0, 0.0, 1.0), _433 / float3(_809), bool3(_809 > 9.9999999747524270787835121154785e-07)), _656 / float3(fast::max(length(_656), 9.9999999747524270787835121154785e-07)), _831);
    float3 _833 = cross(_826, _832);
    float3 _837 = _833 / float3(fast::max(length(_833), 9.9999999747524270787835121154785e-07));
    float3 _841 = float3(float(_824));
    float3 _843 = cross(_821, _819);
    float3 _847 = _843 / float3(fast::max(length(_843), 9.9999999747524270787835121154785e-07));
    float3 _848 = cross(_821, _847);
    float3 _849 = cross(_826, _819);
    float3 _853 = _849 / float3(fast::max(length(_849), 9.9999999747524270787835121154785e-07));
    float3 _855 = cross(_767, float3(0.0, 0.0, 1.0));
    float3 _859 = _855 / float3(fast::max(length(_855), 9.9999999747524270787835121154785e-07));
    bool _861 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u;
    float3 _897;
    float3 _898;
    if (_861)
    {
        float3 _895;
        float3 _896;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _892 = float3(fast::clamp((dot(_763, _763) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _895 = mix(cross(_767, _855), _820, _892);
            _896 = mix(_855, _818, _892);
        }
        else
        {
            float3 _881;
            float3 _882;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _881 = _820;
                _882 = _818;
            }
            else
            {
                float3 _879;
                float3 _880;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _879 = _848;
                    _880 = _847;
                }
                else
                {
                    _879 = select(cross(_767, _859), cross(_826, _853), _825);
                    _880 = select(_859, _853, _825);
                }
                _881 = _879;
                _882 = _880;
            }
            _895 = _881;
            _896 = _882;
        }
        _897 = _895;
        _898 = _896;
    }
    else
    {
        _897 = mix(-_832, cross(_826, _837), _841);
        _898 = _837;
    }
    float _904 = (_292 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _905 = sin(_904);
    float _906 = cos(_904);
    float3 _911 = (_897 * _905) + (_898 * _906);
    float3 _912 = (_897 * _906) - (_898 * _905);
    float2 _915 = float2(int2(sign(_343)));
    bool _918 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u;
    float2 _968;
    float2 _969;
    if (_918)
    {
        uint _936 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _944 = _915.x;
        float _945 = _915.y;
        uint _952;
        if ((_944 * _945) < 0.0)
        {
            _952 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _936;
        }
        else
        {
            _952 = _936;
        }
        float4 _956 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_470, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _952)));
        float _959 = _956.x;
        float2 _962 = _89;
        _962.x = (_944 < 0.0) ? (1.0 - _959) : _959;
        float _964 = _956.y;
        float2 _967 = _962;
        _967.y = (_945 < 0.0) ? (1.0 - _964) : _964;
        _968 = _967;
        _969 = _956.xy;
    }
    else
    {
        float2 _927 = _91;
        _927.x = (_915.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _933 = _927;
        _933.y = (_915.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _968 = in.in_var_ATTRIBUTE0;
        _969 = _933;
    }
    float3 _1044;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset == (-1))
            {
                _1044 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevPos.xyz;
                break;
            }
            float3 _1043;
            switch (0u)
            {
                default:
                {
                    uint _993 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevPositionDataOffset);
                    int _997 = int(_993 & 2147483647u);
                    if ((_993 & 2147483648u) != 0u)
                    {
                        _1043 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_997) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_997 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_997 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _1043 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_997) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_997 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_997 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _1044 = _1043;
            break;
        }
    }
    float3 _1068;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _1068 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _1044.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _1044.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _1044.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                break;
            }
            _1068 = _1044;
            break;
        }
    }
    float _1105;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset == (-1))
            {
                _1105 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevRotation;
                break;
            }
            float _1104;
            switch (0u)
            {
                default:
                {
                    uint _1080 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevRotationDataOffset);
                    int _1084 = int(_1080 & 2147483647u);
                    if ((_1080 & 2147483648u) != 0u)
                    {
                        _1104 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1084) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                    else
                    {
                        _1104 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1084) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                }
            }
            _1105 = _1104;
            break;
        }
    }
    float2 _1157;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset == (-1))
            {
                _1157 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevSize;
                break;
            }
            float2 _1156;
            switch (0u)
            {
                default:
                {
                    uint _1118 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevSizeDataOffset);
                    int _1122 = int(_1118 & 2147483647u);
                    if ((_1118 & 2147483648u) != 0u)
                    {
                        _1156 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1122) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1122 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _1156 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1122) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1122 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _1157 = _1156;
            break;
        }
    }
    float3 _1220;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset == (-1))
            {
                _1220 = float3(NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevVelocity);
                break;
            }
            float3 _1219;
            switch (0u)
            {
                default:
                {
                    uint _1169 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevVelocityDataOffset);
                    int _1173 = int(_1169 & 2147483647u);
                    if ((_1169 & 2147483648u) != 0u)
                    {
                        _1219 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1173) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1173 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1173 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _1219 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1173) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1173 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1173 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _1220 = _1219;
            break;
        }
    }
    float3 _1247;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _1247 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1220.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1220.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1220.zzz);
                break;
            }
            _1247 = _1220;
            break;
        }
    }
    float3 _1311;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset == (-1))
            {
                _1311 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevFacing.xyz;
                break;
            }
            float3 _1310;
            switch (0u)
            {
                default:
                {
                    uint _1260 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevFacingDataOffset);
                    int _1264 = int(_1260 & 2147483647u);
                    if ((_1260 & 2147483648u) != 0u)
                    {
                        _1310 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1264) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1264 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1264 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _1310 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1264) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1264 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1264 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _1311 = _1310;
            break;
        }
    }
    float3 _1338;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _1338 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1311.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1311.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1311.zzz);
                break;
            }
            _1338 = _1311;
            break;
        }
    }
    float3 _1406;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset == (-1))
            {
                _1406 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevAlignment.xyz;
                break;
            }
            float3 _1405;
            switch (0u)
            {
                default:
                {
                    uint _1355 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevAlignmentDataOffset);
                    int _1359 = int(_1355 & 2147483647u);
                    if ((_1355 & 2147483648u) != 0u)
                    {
                        _1405 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1359) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1359 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1359 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                    else
                    {
                        _1405 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1359) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1359 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1359 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x);
                        break;
                    }
                }
            }
            _1406 = _1405;
            break;
        }
    }
    float3 _1433;
    switch (0u)
    {
        default:
        {
            if (_234)
            {
                _1433 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _1406.xxx) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _1406.yyy)) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _1406.zzz);
                break;
            }
            _1433 = _1406;
            break;
        }
    }
    float3 _1438 = View.View_PrevWorldCameraOrigin - _1068;
    float _1479;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset == (-1))
            {
                _1479 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPrevCamOffset;
                break;
            }
            float _1478;
            switch (0u)
            {
                default:
                {
                    uint _1454 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PrevCameraOffsetDataOffset);
                    int _1458 = int(_1454 & 2147483647u);
                    if ((_1454 & 2147483648u) != 0u)
                    {
                        _1478 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_1458) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                    else
                    {
                        _1478 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_1458) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _163))).x;
                        break;
                    }
                }
            }
            _1479 = _1478;
            break;
        }
    }
    float _1481 = length(_1247);
    float3 _1487 = View.View_WorldCameraOrigin - _1068;
    float3 _1491 = _1487 / float3(fast::max(length(_1487), 9.9999999747524270787835121154785e-07));
    float3 _1492 = select(_1491, _1338 / float3(fast::max(length(_1338), 9.9999999747524270787835121154785e-07)), _825);
    float3 _1493 = mix(select(float3(0.0, 0.0, 1.0), _1247 / float3(_1481), bool3(_1481 > 9.9999999747524270787835121154785e-07)), _1433 / float3(fast::max(length(_1433), 9.9999999747524270787835121154785e-07)), _831);
    float3 _1494 = cross(_1492, _1493);
    float3 _1498 = _1494 / float3(fast::max(length(_1494), 9.9999999747524270787835121154785e-07));
    float3 _1502 = cross(_1492, _819);
    float3 _1506 = _1502 / float3(fast::max(length(_1502), 9.9999999747524270787835121154785e-07));
    float3 _1508 = cross(_1491, float3(0.0, 0.0, 1.0));
    float3 _1512 = _1508 / float3(fast::max(length(_1508), 9.9999999747524270787835121154785e-07));
    float3 _1549;
    float3 _1550;
    if (_861)
    {
        float3 _1547;
        float3 _1548;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _1544 = float3(fast::clamp((dot(_1487, _1487) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _1547 = mix(cross(_1491, _1508), _820, _1544);
            _1548 = mix(_1508, _818, _1544);
        }
        else
        {
            float3 _1533;
            float3 _1534;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _1533 = _820;
                _1534 = _818;
            }
            else
            {
                float3 _1531;
                float3 _1532;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _1531 = _848;
                    _1532 = _847;
                }
                else
                {
                    _1531 = select(cross(_1491, _1512), cross(_1492, _1506), _825);
                    _1532 = select(_1512, _1506, _825);
                }
                _1533 = _1531;
                _1534 = _1532;
            }
            _1547 = _1533;
            _1548 = _1534;
        }
        _1549 = _1547;
        _1550 = _1548;
    }
    else
    {
        _1549 = mix(-_1493, cross(_1492, _1498), _841);
        _1550 = _1498;
    }
    float _1552 = ((_1105 * 0.0174532942473888397216796875) * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _1553 = sin(_1552);
    float _1554 = cos(_1552);
    float2 _1563 = float2(int2(sign(_1157)));
    float2 _1600;
    if (_918)
    {
        uint _1569 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _1577 = _1563.x;
        float _1578 = _1563.y;
        uint _1585;
        if ((_1577 * _1578) < 0.0)
        {
            _1585 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _1569;
        }
        else
        {
            _1585 = _1569;
        }
        float4 _1589 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_470, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _1585)));
        float _1591 = _1589.x;
        float2 _1594 = _89;
        _1594.x = (_1577 < 0.0) ? (1.0 - _1591) : _1591;
        float _1596 = _1589.y;
        float2 _1599 = _1594;
        _1599.y = (_1578 < 0.0) ? (1.0 - _1596) : _1596;
        _1600 = _1599;
    }
    else
    {
        _1600 = in.in_var_ATTRIBUTE0;
    }
    float _1608 = fract(_470);
    float _1609 = _470 - _1608;
    float2 _1622 = (float2(mod(_1609, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_1609 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_969 - float2(0.5)) * _762))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _1627 = _90;
    _1627[0] = _911;
    float3x3 _1628 = _1627;
    _1628[1] = _912;
    float3x3 _1662;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1661 = _1628;
        _1661[2] = normalize(cross(_911, _912));
        _1662 = _1661;
    }
    else
    {
        float3x3 _1658;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1657 = _1628;
            _1657[2] = normalize(_254 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1658 = _1657;
        }
        else
        {
            float3x3 _1651 = _1628;
            _1651[2] = normalize(_254 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _254 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1658 = _1651;
        }
        _1662 = _1658;
    }
    float4 _1670 = float4(_1662[0].x, _1662[0].y, _1662[0].z, float4(0.0).w);
    _1670.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _1608 : 0.0;
    spvUnsafeArray<float4, 1> _1680 = { float4(_1622.x, _1622.y, float4(0.0).z, float4(0.0).w) };
    float4 _1688 = View.View_TranslatedWorldToClip * float4((_254 + ((_767 * _804) + (float2x3(_911, _912) * (abs(float4(_343, _292, _470).xy) * (_968 - _711))))) + View.View_PreViewTranslation, 1.0);
    float4 _1697 = _1688;
    _1697.z = _1688.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1688.w) : 0.0);
    out.gl_Position = _1697;
    out.out_var_TEXCOORD6 = _1688;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_1068 + (((_1438 / float3(fast::max(length(_1438), 9.9999999747524270787835121154785e-07))) * _1479) + (float2x3((_1549 * _1553) + (_1550 * _1554), (_1549 * _1554) - (_1550 * _1553)) * (abs(_1157) * (_1600 - _711))))) + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10 = _1670;
    out.out_var_TEXCOORD11 = float4(_1662[2], float(int(sign(determinant(_1662)))));
    out_var_TEXCOORD1 = _1680;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

