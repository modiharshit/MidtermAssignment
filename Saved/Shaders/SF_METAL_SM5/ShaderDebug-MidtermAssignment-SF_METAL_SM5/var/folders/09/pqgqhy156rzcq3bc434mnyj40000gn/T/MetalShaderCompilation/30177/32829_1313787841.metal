

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
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex Main_out Main_0000803d_4e4ecfc1(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _142;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _142 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _142 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _206;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _206 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _205;
            switch (0u)
            {
                default:
                {
                    uint _155 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _159 = int(_155 & 2147483647u);
                    if ((_155 & 2147483648u) != 0u)
                    {
                        _205 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_159) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_159 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_159 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _205 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_159) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_159 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_159 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _206 = _205;
            break;
        }
    }
    bool _213;
    float3 _233;
    switch (0u)
    {
        default:
        {
            _213 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_213)
            {
                _233 = (((Primitive.Primitive_LocalToWorld[0].xyz * _206.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _206.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _206.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _233 = _206;
            break;
        }
    }
    float _270;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _270 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _269;
            switch (0u)
            {
                default:
                {
                    uint _245 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _249 = int(_245 & 2147483647u);
                    if ((_245 & 2147483648u) != 0u)
                    {
                        _269 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_249) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                    else
                    {
                        _269 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_249) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                }
            }
            _270 = _269;
            break;
        }
    }
    float _271 = _270 * 0.0174532942473888397216796875;
    float2 _322;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _322 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _321;
            switch (0u)
            {
                default:
                {
                    uint _283 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _287 = int(_283 & 2147483647u);
                    if ((_283 & 2147483648u) != 0u)
                    {
                        _321 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_287) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_287 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _321 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_287) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_287 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _322 = _321;
            break;
        }
    }
    float3 _385;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _385 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _384;
            switch (0u)
            {
                default:
                {
                    uint _334 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _338 = int(_334 & 2147483647u);
                    if ((_334 & 2147483648u) != 0u)
                    {
                        _384 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_338) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_338 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_338 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _384 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_338) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_338 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_338 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _385 = _384;
            break;
        }
    }
    float3 _412;
    switch (0u)
    {
        default:
        {
            if (_213)
            {
                _412 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _385.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _385.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _385.zzz);
                break;
            }
            _412 = _385;
            break;
        }
    }
    float _449;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _449 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _448;
            switch (0u)
            {
                default:
                {
                    uint _424 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _428 = int(_424 & 2147483647u);
                    if ((_424 & 2147483648u) != 0u)
                    {
                        _448 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_428) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                    else
                    {
                        _448 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_428) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                }
            }
            _449 = _448;
            break;
        }
    }
    float3 _513;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _513 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _512;
            switch (0u)
            {
                default:
                {
                    uint _462 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _466 = int(_462 & 2147483647u);
                    if ((_462 & 2147483648u) != 0u)
                    {
                        _512 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_466) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_466 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_466 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _512 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_466) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_466 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_466 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _513 = _512;
            break;
        }
    }
    float3 _540;
    switch (0u)
    {
        default:
        {
            if (_213)
            {
                _540 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _513.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _513.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _513.zzz);
                break;
            }
            _540 = _513;
            break;
        }
    }
    float3 _608;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _608 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _607;
            switch (0u)
            {
                default:
                {
                    uint _557 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _561 = int(_557 & 2147483647u);
                    if ((_557 & 2147483648u) != 0u)
                    {
                        _607 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_561) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_561 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_561 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _607 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_561) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_561 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_561 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _608 = _607;
            break;
        }
    }
    float3 _635;
    switch (0u)
    {
        default:
        {
            if (_213)
            {
                _635 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _608.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _608.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _608.zzz);
                break;
            }
            _635 = _608;
            break;
        }
    }
    float2 _690;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _690 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _689;
            switch (0u)
            {
                default:
                {
                    uint _651 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _655 = int(_651 & 2147483647u);
                    if ((_651 & 2147483648u) != 0u)
                    {
                        _689 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_655) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_655 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _689 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_655) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_655 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _690 = _689;
            break;
        }
    }
    float2 _741;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _741 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _740;
            switch (0u)
            {
                default:
                {
                    uint _702 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _706 = int(_702 & 2147483647u);
                    if ((_702 & 2147483648u) != 0u)
                    {
                        _740 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_706) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_706 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                    else
                    {
                        _740 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_706) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_706 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x);
                        break;
                    }
                }
            }
            _741 = _740;
            break;
        }
    }
    float3 _742 = View.View_WorldCameraOrigin - _233;
    float _743 = length(_742);
    float _744 = fast::max(_743, 9.9999999747524270787835121154785e-07);
    float3 _745 = float3(_744);
    float3 _746 = _742 / _745;
    float _783;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _783 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _782;
            switch (0u)
            {
                default:
                {
                    uint _758 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _762 = int(_758 & 2147483647u);
                    if ((_758 & 2147483648u) != 0u)
                    {
                        _782 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_762) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                    else
                    {
                        _782 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_762) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _142))).x;
                        break;
                    }
                }
            }
            _783 = _782;
            break;
        }
    }
    float3 _784 = _746 * _783;
    float4 _787 = float4(_322, _271, _449);
    float _788 = length(_412);
    float3 _796 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _797 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _796);
    float3 _798 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _796);
    float3 _799 = -_798;
    float3 _800 = -View.View_ViewForward;
    bool _803 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _804 = bool3(_803);
    float3 _805 = select(_746, _540 / float3(fast::max(length(_540), 9.9999999747524270787835121154785e-07)), _804);
    float3 _811 = mix(select(float3(0.0, 0.0, 1.0), _412 / float3(_788), bool3(_788 > 9.9999999747524270787835121154785e-07)), _635 / float3(fast::max(length(_635), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _812 = cross(_805, _811);
    float3 _816 = _812 / float3(fast::max(length(_812), 9.9999999747524270787835121154785e-07));
    float3 _822 = cross(_800, _798);
    float3 _826 = _822 / float3(fast::max(length(_822), 9.9999999747524270787835121154785e-07));
    float3 _828 = cross(_805, _798);
    float3 _832 = _828 / float3(fast::max(length(_828), 9.9999999747524270787835121154785e-07));
    float3 _834 = cross(_746, float3(0.0, 0.0, 1.0));
    float3 _838 = _834 / float3(fast::max(length(_834), 9.9999999747524270787835121154785e-07));
    float3 _876;
    float3 _877;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _874;
        float3 _875;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _871 = float3(fast::clamp((dot(_742, _742) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _874 = mix(cross(_746, _834), _799, _871);
            _875 = mix(_834, _797, _871);
        }
        else
        {
            float3 _860;
            float3 _861;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _860 = _799;
                _861 = _797;
            }
            else
            {
                float3 _858;
                float3 _859;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _858 = cross(_800, _826);
                    _859 = _826;
                }
                else
                {
                    _858 = select(cross(_746, _838), cross(_805, _832), _804);
                    _859 = select(_838, _832, _804);
                }
                _860 = _858;
                _861 = _859;
            }
            _874 = _860;
            _875 = _861;
        }
        _876 = _874;
        _877 = _875;
    }
    else
    {
        _876 = mix(-_811, cross(_805, _816), float3(float(_803)));
        _877 = _816;
    }
    float _880 = _271 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _883 = _880 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _884 = sin(_883);
    float _885 = cos(_883);
    float3 _886 = _877 * _884;
    float3 _887 = _876 * _884;
    float3 _888 = _877 * _885;
    float3 _889 = _876 * _885;
    float3 _890 = _887 + _888;
    float3 _891 = _889 - _886;
    float2 _894 = float2(int2(sign(_322)));
    float2 _947;
    float2 _948;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _915 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _923 = _894.x;
        float _924 = _894.y;
        uint _931;
        if ((_923 * _924) < 0.0)
        {
            _931 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _915;
        }
        else
        {
            _931 = _915;
        }
        float4 _935 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_449, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _931)));
        float _938 = _935.x;
        float2 _941 = _89;
        _941.x = (_923 < 0.0) ? (1.0 - _938) : _938;
        float _943 = _935.y;
        float2 _946 = _941;
        _946.y = (_924 < 0.0) ? (1.0 - _943) : _943;
        _947 = _946;
        _948 = _935.xy;
    }
    else
    {
        float2 _906 = _91;
        _906.x = (_894.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _912 = _906;
        _912.y = (_894.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _947 = in.in_var_ATTRIBUTE0;
        _948 = _912;
    }
    float2 _952 = _787.xy;
    float2 _953 = abs(_952);
    float2x3 _954 = float2x3(_890, _891);
    float2 _955 = _947 - _690;
    float2 _956 = _953 * _955;
    float3 _957 = _954 * _956;
    float3 _958 = _784 + _957;
    float3 _959 = _233 + _958;
    float _960 = fract(_449);
    float _961 = _449 - _960;
    float2 _974 = (float2(mod(_961, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_961 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_948 - float2(0.5)) * _741))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _979 = _90;
    _979[0] = _890;
    float3x3 _980 = _979;
    _980[1] = _891;
    float3x3 _1014;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1013 = _980;
        _1013[2] = normalize(cross(_890, _891));
        _1014 = _1013;
    }
    else
    {
        float3x3 _1010;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1009 = _980;
            _1009[2] = normalize(_233 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1010 = _1009;
        }
        else
        {
            float3x3 _1003 = _980;
            _1003[2] = normalize(_233 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _233 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1010 = _1003;
        }
        _1014 = _1010;
    }
    float3 _1015 = _959 + View.View_PreViewTranslation;
    float _1016 = _1015.x;
    float _1017 = _1015.y;
    float _1018 = _1015.z;
    float4 _1019 = float4(_1016, _1017, _1018, 1.0);
    float4 _1020 = float4(_1019.x, _1019.y, _1019.z, _1019.w);
    float4 _1023 = View.View_TranslatedWorldToClip * _1020;
    float4 _1027 = float4(_1014[0].x, _1014[0].y, _1014[0].z, float4(0.0).w);
    _1027.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _960 : 0.0;
    spvUnsafeArray<float4, 1> _1037 = { float4(_974.x, _974.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1027;
    out.out_var_TEXCOORD11 = float4(_1014[2], float(int(sign(determinant(_1014)))));
    out_var_TEXCOORD1 = _1037;
    out.out_var_PARTICLE_LIGHTING_OFFSET = float3(0.0);
    out.out_var_TEXCOORD6 = _1020;
    out.gl_Position = _1023;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

