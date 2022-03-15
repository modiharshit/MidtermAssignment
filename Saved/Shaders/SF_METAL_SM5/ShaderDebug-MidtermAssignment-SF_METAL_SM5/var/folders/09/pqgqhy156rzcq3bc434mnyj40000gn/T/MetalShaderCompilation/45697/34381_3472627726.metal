

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
    char _m0_pad[960];
    float3 View_ViewForward;
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m5_pad[32];
    float3 View_WorldCameraOrigin;
    char _m6_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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

constant float2 _93 = {};
constant float3x3 _94 = {};
constant float2 _95 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_0000864d_cefc180e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(7)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(8)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _145;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _145 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _145 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _209;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _209 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _208;
            switch (0u)
            {
                default:
                {
                    uint _158 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _162 = int(_158 & 2147483647u);
                    if ((_158 & 2147483648u) != 0u)
                    {
                        _208 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_162) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_162 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_162 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _208 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_162) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_162 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_162 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _209 = _208;
            break;
        }
    }
    bool _216;
    float3 _236;
    switch (0u)
    {
        default:
        {
            _216 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_216)
            {
                _236 = (((Primitive.Primitive_LocalToWorld[0].xyz * _209.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _209.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _209.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _236 = _209;
            break;
        }
    }
    float _273;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _273 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _272;
            switch (0u)
            {
                default:
                {
                    uint _248 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _252 = int(_248 & 2147483647u);
                    if ((_248 & 2147483648u) != 0u)
                    {
                        _272 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_252) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                    else
                    {
                        _272 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_252) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                }
            }
            _273 = _272;
            break;
        }
    }
    float _274 = _273 * 0.0174532942473888397216796875;
    float2 _325;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _325 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _324;
            switch (0u)
            {
                default:
                {
                    uint _286 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _290 = int(_286 & 2147483647u);
                    if ((_286 & 2147483648u) != 0u)
                    {
                        _324 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_290) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_290 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _324 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_290) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_290 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _325 = _324;
            break;
        }
    }
    float3 _388;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _388 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _387;
            switch (0u)
            {
                default:
                {
                    uint _337 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _341 = int(_337 & 2147483647u);
                    if ((_337 & 2147483648u) != 0u)
                    {
                        _387 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_341) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_341 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_341 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _387 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_341) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_341 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_341 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _388 = _387;
            break;
        }
    }
    float3 _415;
    switch (0u)
    {
        default:
        {
            if (_216)
            {
                _415 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _388.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _388.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _388.zzz);
                break;
            }
            _415 = _388;
            break;
        }
    }
    float _452;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _452 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _451;
            switch (0u)
            {
                default:
                {
                    uint _427 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _431 = int(_427 & 2147483647u);
                    if ((_427 & 2147483648u) != 0u)
                    {
                        _451 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_431) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                    else
                    {
                        _451 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_431) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                }
            }
            _452 = _451;
            break;
        }
    }
    float3 _516;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _516 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _515;
            switch (0u)
            {
                default:
                {
                    uint _465 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _469 = int(_465 & 2147483647u);
                    if ((_465 & 2147483648u) != 0u)
                    {
                        _515 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_469) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_469 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_469 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _515 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_469) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_469 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_469 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _516 = _515;
            break;
        }
    }
    float3 _543;
    switch (0u)
    {
        default:
        {
            if (_216)
            {
                _543 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _516.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _516.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _516.zzz);
                break;
            }
            _543 = _516;
            break;
        }
    }
    float3 _611;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _611 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _610;
            switch (0u)
            {
                default:
                {
                    uint _560 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _564 = int(_560 & 2147483647u);
                    if ((_560 & 2147483648u) != 0u)
                    {
                        _610 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_564) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_564 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_564 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _610 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_564) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_564 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_564 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _611 = _610;
            break;
        }
    }
    float3 _638;
    switch (0u)
    {
        default:
        {
            if (_216)
            {
                _638 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _611.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _611.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _611.zzz);
                break;
            }
            _638 = _611;
            break;
        }
    }
    float2 _693;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _693 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _692;
            switch (0u)
            {
                default:
                {
                    uint _654 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _658 = int(_654 & 2147483647u);
                    if ((_654 & 2147483648u) != 0u)
                    {
                        _692 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_658) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_658 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _692 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_658) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_658 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _693 = _692;
            break;
        }
    }
    float2 _744;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _744 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _743;
            switch (0u)
            {
                default:
                {
                    uint _705 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _709 = int(_705 & 2147483647u);
                    if ((_705 & 2147483648u) != 0u)
                    {
                        _743 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_709) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_709 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                    else
                    {
                        _743 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_709) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_709 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x);
                        break;
                    }
                }
            }
            _744 = _743;
            break;
        }
    }
    float3 _745 = View.View_WorldCameraOrigin - _236;
    float3 _749 = _745 / float3(fast::max(length(_745), 9.9999999747524270787835121154785e-07));
    float _786;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _786 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _785;
            switch (0u)
            {
                default:
                {
                    uint _761 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _765 = int(_761 & 2147483647u);
                    if ((_761 & 2147483648u) != 0u)
                    {
                        _785 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_765) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                    else
                    {
                        _785 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_765) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _145))).x;
                        break;
                    }
                }
            }
            _786 = _785;
            break;
        }
    }
    float _791 = length(_415);
    float3 _799 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _800 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _799);
    float3 _801 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _799);
    float3 _802 = -_801;
    float3 _803 = -View.View_ViewForward;
    bool _806 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _807 = bool3(_806);
    float3 _808 = select(_749, _543 / float3(fast::max(length(_543), 9.9999999747524270787835121154785e-07)), _807);
    float3 _814 = mix(select(float3(0.0, 0.0, 1.0), _415 / float3(_791), bool3(_791 > 9.9999999747524270787835121154785e-07)), _638 / float3(fast::max(length(_638), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _815 = cross(_808, _814);
    float3 _819 = _815 / float3(fast::max(length(_815), 9.9999999747524270787835121154785e-07));
    float3 _825 = cross(_803, _801);
    float3 _829 = _825 / float3(fast::max(length(_825), 9.9999999747524270787835121154785e-07));
    float3 _831 = cross(_808, _801);
    float3 _835 = _831 / float3(fast::max(length(_831), 9.9999999747524270787835121154785e-07));
    float3 _837 = cross(_749, float3(0.0, 0.0, 1.0));
    float3 _841 = _837 / float3(fast::max(length(_837), 9.9999999747524270787835121154785e-07));
    float3 _879;
    float3 _880;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _877;
        float3 _878;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _874 = float3(fast::clamp((dot(_745, _745) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _877 = mix(cross(_749, _837), _802, _874);
            _878 = mix(_837, _800, _874);
        }
        else
        {
            float3 _863;
            float3 _864;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _863 = _802;
                _864 = _800;
            }
            else
            {
                float3 _861;
                float3 _862;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _861 = cross(_803, _829);
                    _862 = _829;
                }
                else
                {
                    _861 = select(cross(_749, _841), cross(_808, _835), _807);
                    _862 = select(_841, _835, _807);
                }
                _863 = _861;
                _864 = _862;
            }
            _877 = _863;
            _878 = _864;
        }
        _879 = _877;
        _880 = _878;
    }
    else
    {
        _879 = mix(-_814, cross(_808, _819), float3(float(_806)));
        _880 = _819;
    }
    float _886 = (_274 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _887 = sin(_886);
    float _888 = cos(_886);
    float3 _893 = (_879 * _887) + (_880 * _888);
    float3 _894 = (_879 * _888) - (_880 * _887);
    float2 _897 = float2(int2(sign(_325)));
    float2 _950;
    float2 _951;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _918 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _926 = _897.x;
        float _927 = _897.y;
        uint _934;
        if ((_926 * _927) < 0.0)
        {
            _934 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _918;
        }
        else
        {
            _934 = _918;
        }
        float4 _938 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_452, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _934)));
        float _941 = _938.x;
        float2 _944 = _93;
        _944.x = (_926 < 0.0) ? (1.0 - _941) : _941;
        float _946 = _938.y;
        float2 _949 = _944;
        _949.y = (_927 < 0.0) ? (1.0 - _946) : _946;
        _950 = _949;
        _951 = _938.xy;
    }
    else
    {
        float2 _909 = _95;
        _909.x = (_897.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _915 = _909;
        _915.y = (_897.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _950 = in.in_var_ATTRIBUTE0;
        _951 = _915;
    }
    float _963 = fract(_452);
    float _964 = _452 - _963;
    float2 _977 = (float2(mod(_964, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_964 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_951 - float2(0.5)) * _744))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _982 = _94;
    _982[0] = _893;
    float3x3 _983 = _982;
    _983[1] = _894;
    bool _986 = NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5;
    float3x3 _1017;
    if (_986)
    {
        float3x3 _1016 = _983;
        _1016[2] = normalize(cross(_893, _894));
        _1017 = _1016;
    }
    else
    {
        float3x3 _1013;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1012 = _983;
            _1012[2] = normalize(_236 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1013 = _1012;
        }
        else
        {
            float3x3 _1006 = _983;
            _1006[2] = normalize(_236 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _236 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1013 = _1006;
        }
        _1017 = _1013;
    }
    float4 _1022 = float4((_236 + ((_749 * _786) + (float2x3(_893, _894) * (abs(float4(_325, _274, _452).xy) * (_950 - _693))))) + View.View_PreViewTranslation, 1.0);
    float3x3 _1053;
    if (_986)
    {
        float3x3 _1052 = _983;
        _1052[2] = normalize(cross(_893, _894));
        _1053 = _1052;
    }
    else
    {
        float3x3 _1049;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1048 = _983;
            _1048[2] = normalize(_236 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1049 = _1048;
        }
        else
        {
            float3x3 _1042 = _983;
            _1042[2] = normalize(_236 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _236 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1049 = _1042;
        }
        _1053 = _1049;
    }
    float4 _1060 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_1022.x, _1022.y, _1022.z, _1022.w);
    float4 _1071;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_1060.z < 0.0))
    {
        float4 _1069 = _1060;
        _1069.z = 9.9999999747524270787835121154785e-07;
        float4 _1070 = _1069;
        _1070.w = 1.0;
        _1071 = _1070;
    }
    else
    {
        _1071 = _1060;
    }
    float _1077 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _1053[2]));
    float4 _1102 = _1071;
    _1102.z = ((_1071.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_1077) > 0.0) ? (sqrt(fast::clamp(1.0 - (_1077 * _1077), 0.0, 1.0)) / _1077) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _1071.w;
    float4 _1106 = float4(_1017[0].x, _1017[0].y, _1017[0].z, float4(0.0).w);
    _1106.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _963 : 0.0;
    spvUnsafeArray<float4, 1> _1116 = { float4(_977.x, _977.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1106;
    out.out_var_TEXCOORD11 = float4(_1017[2], float(int(sign(determinant(_1017)))));
    out_var_TEXCOORD1 = _1116;
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _1022.xyz;
    out.gl_Position = _1102;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

