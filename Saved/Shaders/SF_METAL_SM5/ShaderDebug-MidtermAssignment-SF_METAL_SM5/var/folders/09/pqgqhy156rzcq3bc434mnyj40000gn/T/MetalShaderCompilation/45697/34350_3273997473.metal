

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

constant float2 _94 = {};
constant float3x3 _95 = {};
constant float2 _96 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float out_var_TEXCOORD8 [[user(locn4)]];
    float3 out_var_TEXCOORD7 [[user(locn5)]];
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

vertex Main_out Main_0000862e_c3253ca1(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(7)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(8)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _146;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _146 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _146 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _210;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _210 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _209;
            switch (0u)
            {
                default:
                {
                    uint _159 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _163 = int(_159 & 2147483647u);
                    if ((_159 & 2147483648u) != 0u)
                    {
                        _209 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_163) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_163 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_163 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _209 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_163) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_163 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_163 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _210 = _209;
            break;
        }
    }
    bool _217;
    float3 _237;
    switch (0u)
    {
        default:
        {
            _217 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_217)
            {
                _237 = (((Primitive.Primitive_LocalToWorld[0].xyz * _210.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _210.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _210.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _237 = _210;
            break;
        }
    }
    float _274;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _274 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _273;
            switch (0u)
            {
                default:
                {
                    uint _249 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _253 = int(_249 & 2147483647u);
                    if ((_249 & 2147483648u) != 0u)
                    {
                        _273 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_253) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                    else
                    {
                        _273 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_253) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                }
            }
            _274 = _273;
            break;
        }
    }
    float _275 = _274 * 0.0174532942473888397216796875;
    float2 _326;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _326 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _325;
            switch (0u)
            {
                default:
                {
                    uint _287 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _291 = int(_287 & 2147483647u);
                    if ((_287 & 2147483648u) != 0u)
                    {
                        _325 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_291) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_291 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _325 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_291) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_291 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _326 = _325;
            break;
        }
    }
    float3 _389;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _389 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _388;
            switch (0u)
            {
                default:
                {
                    uint _338 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _342 = int(_338 & 2147483647u);
                    if ((_338 & 2147483648u) != 0u)
                    {
                        _388 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_342) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_342 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_342 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _388 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_342) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_342 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_342 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _389 = _388;
            break;
        }
    }
    float3 _416;
    switch (0u)
    {
        default:
        {
            if (_217)
            {
                _416 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _389.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _389.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _389.zzz);
                break;
            }
            _416 = _389;
            break;
        }
    }
    float _453;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _453 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _452;
            switch (0u)
            {
                default:
                {
                    uint _428 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _432 = int(_428 & 2147483647u);
                    if ((_428 & 2147483648u) != 0u)
                    {
                        _452 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_432) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                    else
                    {
                        _452 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_432) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                }
            }
            _453 = _452;
            break;
        }
    }
    float3 _517;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _517 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _516;
            switch (0u)
            {
                default:
                {
                    uint _466 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _470 = int(_466 & 2147483647u);
                    if ((_466 & 2147483648u) != 0u)
                    {
                        _516 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_470) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_470 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_470 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _516 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_470) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_470 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_470 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _517 = _516;
            break;
        }
    }
    float3 _544;
    switch (0u)
    {
        default:
        {
            if (_217)
            {
                _544 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _517.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _517.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _517.zzz);
                break;
            }
            _544 = _517;
            break;
        }
    }
    float3 _612;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _612 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _611;
            switch (0u)
            {
                default:
                {
                    uint _561 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _565 = int(_561 & 2147483647u);
                    if ((_561 & 2147483648u) != 0u)
                    {
                        _611 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_565 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _611 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_565 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _612 = _611;
            break;
        }
    }
    float3 _639;
    switch (0u)
    {
        default:
        {
            if (_217)
            {
                _639 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _612.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _612.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _612.zzz);
                break;
            }
            _639 = _612;
            break;
        }
    }
    float2 _694;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _694 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _693;
            switch (0u)
            {
                default:
                {
                    uint _655 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _659 = int(_655 & 2147483647u);
                    if ((_655 & 2147483648u) != 0u)
                    {
                        _693 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_659) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_659 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _693 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_659) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_659 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _694 = _693;
            break;
        }
    }
    float2 _745;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _745 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _744;
            switch (0u)
            {
                default:
                {
                    uint _706 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _710 = int(_706 & 2147483647u);
                    if ((_706 & 2147483648u) != 0u)
                    {
                        _744 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_710) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_710 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                    else
                    {
                        _744 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_710) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_710 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x);
                        break;
                    }
                }
            }
            _745 = _744;
            break;
        }
    }
    float3 _746 = View.View_WorldCameraOrigin - _237;
    float3 _750 = _746 / float3(fast::max(length(_746), 9.9999999747524270787835121154785e-07));
    float _787;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _787 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _786;
            switch (0u)
            {
                default:
                {
                    uint _762 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _766 = int(_762 & 2147483647u);
                    if ((_762 & 2147483648u) != 0u)
                    {
                        _786 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_766) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                    else
                    {
                        _786 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_766) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _146))).x;
                        break;
                    }
                }
            }
            _787 = _786;
            break;
        }
    }
    float _792 = length(_416);
    float3 _800 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _801 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _800);
    float3 _802 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _800);
    float3 _803 = -_802;
    float3 _804 = -View.View_ViewForward;
    bool _807 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _808 = bool3(_807);
    float3 _809 = select(_750, _544 / float3(fast::max(length(_544), 9.9999999747524270787835121154785e-07)), _808);
    float3 _815 = mix(select(float3(0.0, 0.0, 1.0), _416 / float3(_792), bool3(_792 > 9.9999999747524270787835121154785e-07)), _639 / float3(fast::max(length(_639), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _816 = cross(_809, _815);
    float3 _820 = _816 / float3(fast::max(length(_816), 9.9999999747524270787835121154785e-07));
    float3 _826 = cross(_804, _802);
    float3 _830 = _826 / float3(fast::max(length(_826), 9.9999999747524270787835121154785e-07));
    float3 _832 = cross(_809, _802);
    float3 _836 = _832 / float3(fast::max(length(_832), 9.9999999747524270787835121154785e-07));
    float3 _838 = cross(_750, float3(0.0, 0.0, 1.0));
    float3 _842 = _838 / float3(fast::max(length(_838), 9.9999999747524270787835121154785e-07));
    float3 _880;
    float3 _881;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _878;
        float3 _879;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _875 = float3(fast::clamp((dot(_746, _746) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _878 = mix(cross(_750, _838), _803, _875);
            _879 = mix(_838, _801, _875);
        }
        else
        {
            float3 _864;
            float3 _865;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _864 = _803;
                _865 = _801;
            }
            else
            {
                float3 _862;
                float3 _863;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _862 = cross(_804, _830);
                    _863 = _830;
                }
                else
                {
                    _862 = select(cross(_750, _842), cross(_809, _836), _808);
                    _863 = select(_842, _836, _808);
                }
                _864 = _862;
                _865 = _863;
            }
            _878 = _864;
            _879 = _865;
        }
        _880 = _878;
        _881 = _879;
    }
    else
    {
        _880 = mix(-_815, cross(_809, _820), float3(float(_807)));
        _881 = _820;
    }
    float _887 = (_275 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale) + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _888 = sin(_887);
    float _889 = cos(_887);
    float3 _894 = (_880 * _888) + (_881 * _889);
    float3 _895 = (_880 * _889) - (_881 * _888);
    float2 _898 = float2(int2(sign(_326)));
    float2 _951;
    float2 _952;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _919 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _927 = _898.x;
        float _928 = _898.y;
        uint _935;
        if ((_927 * _928) < 0.0)
        {
            _935 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _919;
        }
        else
        {
            _935 = _919;
        }
        float4 _939 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_453, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _935)));
        float _942 = _939.x;
        float2 _945 = _94;
        _945.x = (_927 < 0.0) ? (1.0 - _942) : _942;
        float _947 = _939.y;
        float2 _950 = _945;
        _950.y = (_928 < 0.0) ? (1.0 - _947) : _947;
        _951 = _950;
        _952 = _939.xy;
    }
    else
    {
        float2 _910 = _96;
        _910.x = (_898.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _916 = _910;
        _916.y = (_898.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _951 = in.in_var_ATTRIBUTE0;
        _952 = _916;
    }
    float _964 = fract(_453);
    float _965 = _453 - _964;
    float2 _978 = (float2(mod(_965, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_965 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_952 - float2(0.5)) * _745))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _983 = _95;
    _983[0] = _894;
    float3x3 _984 = _983;
    _984[1] = _895;
    bool _987 = NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5;
    float3x3 _1018;
    if (_987)
    {
        float3x3 _1017 = _984;
        _1017[2] = normalize(cross(_894, _895));
        _1018 = _1017;
    }
    else
    {
        float3x3 _1014;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1013 = _984;
            _1013[2] = normalize(_237 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1014 = _1013;
        }
        else
        {
            float3x3 _1007 = _984;
            _1007[2] = normalize(_237 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _237 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1014 = _1007;
        }
        _1018 = _1014;
    }
    float4 _1023 = float4((_237 + ((_750 * _787) + (float2x3(_894, _895) * (abs(float4(_326, _275, _453).xy) * (_951 - _694))))) + View.View_PreViewTranslation, 1.0);
    float3x3 _1054;
    if (_987)
    {
        float3x3 _1053 = _984;
        _1053[2] = normalize(cross(_894, _895));
        _1054 = _1053;
    }
    else
    {
        float3x3 _1050;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1049 = _984;
            _1049[2] = normalize(_237 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1050 = _1049;
        }
        else
        {
            float3x3 _1043 = _984;
            _1043[2] = normalize(_237 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _237 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1050 = _1043;
        }
        _1054 = _1050;
    }
    float4 _1061 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_1023.x, _1023.y, _1023.z, _1023.w);
    float4 _1072;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_1061.z < 0.0))
    {
        float4 _1070 = _1061;
        _1070.z = 9.9999999747524270787835121154785e-07;
        float4 _1071 = _1070;
        _1071.w = 1.0;
        _1072 = _1071;
    }
    else
    {
        _1072 = _1061;
    }
    float _1078 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _1054[2]));
    float4 _1100 = float4(_1018[0].x, _1018[0].y, _1018[0].z, float4(0.0).w);
    _1100.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _964 : 0.0;
    spvUnsafeArray<float4, 1> _1110 = { float4(_978.x, _978.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1100;
    out.out_var_TEXCOORD11 = float4(_1018[2], float(int(sign(determinant(_1018)))));
    out_var_TEXCOORD1 = _1110;
    out.out_var_TEXCOORD6 = _1072.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_1078) > 0.0) ? (sqrt(fast::clamp(1.0 - (_1078 * _1078), 0.0, 1.0)) / _1078) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _1023.xyz;
    out.gl_Position = _1072;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

