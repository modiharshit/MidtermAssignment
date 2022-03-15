

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

constant float2 _86 = {};
constant float3x3 _87 = {};
constant float2 _88 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
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

vertex Main_out Main_00007fcc_0605547c(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(6)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(7)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD1 = {};
    uint _139;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset != 4294967295u)
    {
        _139 = uint(NiagaraSpriteVFLooseParameters_SortedIndices.read(uint((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_SortedIndicesOffset + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _139 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _203;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset == (-1))
            {
                _203 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPos.xyz;
                break;
            }
            float3 _202;
            switch (0u)
            {
                default:
                {
                    uint _152 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PositionDataOffset);
                    int _156 = int(_152 & 2147483647u);
                    if ((_152 & 2147483648u) != 0u)
                    {
                        _202 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_156) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_156 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_156 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _202 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_156) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_156 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_156 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _203 = _202;
            break;
        }
    }
    bool _210;
    float3 _230;
    switch (0u)
    {
        default:
        {
            _210 = NiagaraSpriteVF.NiagaraSpriteVF_bLocalSpace != 0u;
            if (_210)
            {
                _230 = (((Primitive.Primitive_LocalToWorld[0].xyz * _203.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _203.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _203.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _230 = _203;
            break;
        }
    }
    float _267;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset == (-1))
            {
                _267 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultRotation;
                break;
            }
            float _266;
            switch (0u)
            {
                default:
                {
                    uint _242 = uint(NiagaraSpriteVF.NiagaraSpriteVF_RotationDataOffset);
                    int _246 = int(_242 & 2147483647u);
                    if ((_242 & 2147483648u) != 0u)
                    {
                        _266 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_246) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                    else
                    {
                        _266 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_246) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                }
            }
            _267 = _266;
            break;
        }
    }
    float _268 = _267 * 0.0174532942473888397216796875;
    float2 _319;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset == (-1))
            {
                _319 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSize;
                break;
            }
            float2 _318;
            switch (0u)
            {
                default:
                {
                    uint _280 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SizeDataOffset);
                    int _284 = int(_280 & 2147483647u);
                    if ((_280 & 2147483648u) != 0u)
                    {
                        _318 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_284) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_284 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _318 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_284) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_284 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _319 = _318;
            break;
        }
    }
    float3 _382;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset == (-1))
            {
                _382 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultVelocity;
                break;
            }
            float3 _381;
            switch (0u)
            {
                default:
                {
                    uint _331 = uint(NiagaraSpriteVF.NiagaraSpriteVF_VelocityDataOffset);
                    int _335 = int(_331 & 2147483647u);
                    if ((_331 & 2147483648u) != 0u)
                    {
                        _381 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_335) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_335 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_335 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _381 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_335) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_335 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_335 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _382 = _381;
            break;
        }
    }
    float3 _409;
    switch (0u)
    {
        default:
        {
            if (_210)
            {
                _409 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _382.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _382.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _382.zzz);
                break;
            }
            _409 = _382;
            break;
        }
    }
    float _446;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset == (-1))
            {
                _446 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultSubImage;
                break;
            }
            float _445;
            switch (0u)
            {
                default:
                {
                    uint _421 = uint(NiagaraSpriteVF.NiagaraSpriteVF_SubimageDataOffset);
                    int _425 = int(_421 & 2147483647u);
                    if ((_421 & 2147483648u) != 0u)
                    {
                        _445 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_425) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                    else
                    {
                        _445 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_425) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                }
            }
            _446 = _445;
            break;
        }
    }
    float3 _510;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset == (-1))
            {
                _510 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultFacing.xyz;
                break;
            }
            float3 _509;
            switch (0u)
            {
                default:
                {
                    uint _459 = uint(NiagaraSpriteVF.NiagaraSpriteVF_FacingDataOffset);
                    int _463 = int(_459 & 2147483647u);
                    if ((_459 & 2147483648u) != 0u)
                    {
                        _509 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_463) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_463 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_463 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _509 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_463) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_463 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_463 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _510 = _509;
            break;
        }
    }
    float3 _537;
    switch (0u)
    {
        default:
        {
            if (_210)
            {
                _537 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _510.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _510.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _510.zzz);
                break;
            }
            _537 = _510;
            break;
        }
    }
    float3 _605;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset == (-1))
            {
                _605 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultAlignment.xyz;
                break;
            }
            float3 _604;
            switch (0u)
            {
                default:
                {
                    uint _554 = uint(NiagaraSpriteVF.NiagaraSpriteVF_AlignmentDataOffset);
                    int _558 = int(_554 & 2147483647u);
                    if ((_554 & 2147483648u) != 0u)
                    {
                        _604 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_558 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _604 = float3(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_558 + 2) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _605 = _604;
            break;
        }
    }
    float3 _632;
    switch (0u)
    {
        default:
        {
            if (_210)
            {
                _632 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * _605.xxx) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * _605.yyy)) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * _605.zzz);
                break;
            }
            _632 = _605;
            break;
        }
    }
    float2 _687;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset == (-1))
            {
                _687 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultPivotOffset;
                break;
            }
            float2 _686;
            switch (0u)
            {
                default:
                {
                    uint _648 = uint(NiagaraSpriteVF.NiagaraSpriteVF_PivotOffsetDataOffset);
                    int _652 = int(_648 & 2147483647u);
                    if ((_648 & 2147483648u) != 0u)
                    {
                        _686 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_652) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_652 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _686 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_652) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_652 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _687 = _686;
            break;
        }
    }
    float2 _738;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset == (-1))
            {
                _738 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultUVScale;
                break;
            }
            float2 _737;
            switch (0u)
            {
                default:
                {
                    uint _699 = uint(NiagaraSpriteVF.NiagaraSpriteVF_UVScaleDataOffset);
                    int _703 = int(_699 & 2147483647u);
                    if ((_699 & 2147483648u) != 0u)
                    {
                        _737 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_703) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_703 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                    else
                    {
                        _737 = float2(NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_703) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x, NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_703 + 1) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x);
                        break;
                    }
                }
            }
            _738 = _737;
            break;
        }
    }
    float3 _739 = View.View_WorldCameraOrigin - _230;
    float _740 = length(_739);
    float _741 = fast::max(_740, 9.9999999747524270787835121154785e-07);
    float3 _742 = float3(_741);
    float3 _743 = _739 / _742;
    float _780;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _780 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _779;
            switch (0u)
            {
                default:
                {
                    uint _755 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _759 = int(_755 & 2147483647u);
                    if ((_755 & 2147483648u) != 0u)
                    {
                        _779 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_759) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                    else
                    {
                        _779 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_759) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                }
            }
            _780 = _779;
            break;
        }
    }
    float3 _781 = _743 * _780;
    float4 _784 = float4(_319, _268, _446);
    float _785 = length(_409);
    float3 _793 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _794 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _793);
    float3 _795 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _793);
    float3 _796 = -_795;
    float3 _797 = -View.View_ViewForward;
    bool _800 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _801 = bool3(_800);
    float3 _802 = select(_743, _537 / float3(fast::max(length(_537), 9.9999999747524270787835121154785e-07)), _801);
    float3 _808 = mix(select(float3(0.0, 0.0, 1.0), _409 / float3(_785), bool3(_785 > 9.9999999747524270787835121154785e-07)), _632 / float3(fast::max(length(_632), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _809 = cross(_802, _808);
    float3 _813 = _809 / float3(fast::max(length(_809), 9.9999999747524270787835121154785e-07));
    float3 _819 = cross(_797, _795);
    float3 _823 = _819 / float3(fast::max(length(_819), 9.9999999747524270787835121154785e-07));
    float3 _825 = cross(_802, _795);
    float3 _829 = _825 / float3(fast::max(length(_825), 9.9999999747524270787835121154785e-07));
    float3 _831 = cross(_743, float3(0.0, 0.0, 1.0));
    float3 _835 = _831 / float3(fast::max(length(_831), 9.9999999747524270787835121154785e-07));
    float3 _873;
    float3 _874;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _871;
        float3 _872;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _868 = float3(fast::clamp((dot(_739, _739) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _871 = mix(cross(_743, _831), _796, _868);
            _872 = mix(_831, _794, _868);
        }
        else
        {
            float3 _857;
            float3 _858;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _857 = _796;
                _858 = _794;
            }
            else
            {
                float3 _855;
                float3 _856;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _855 = cross(_797, _823);
                    _856 = _823;
                }
                else
                {
                    _855 = select(cross(_743, _835), cross(_802, _829), _801);
                    _856 = select(_835, _829, _801);
                }
                _857 = _855;
                _858 = _856;
            }
            _871 = _857;
            _872 = _858;
        }
        _873 = _871;
        _874 = _872;
    }
    else
    {
        _873 = mix(-_808, cross(_802, _813), float3(float(_800)));
        _874 = _813;
    }
    float _877 = _268 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _880 = _877 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _881 = sin(_880);
    float _882 = cos(_880);
    float3 _883 = _874 * _881;
    float3 _884 = _873 * _881;
    float3 _885 = _874 * _882;
    float3 _886 = _873 * _882;
    float3 _887 = _884 + _885;
    float3 _888 = _886 - _883;
    float2 _891 = float2(int2(sign(_319)));
    float2 _944;
    float2 _945;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _912 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _920 = _891.x;
        float _921 = _891.y;
        uint _928;
        if ((_920 * _921) < 0.0)
        {
            _928 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _912;
        }
        else
        {
            _928 = _912;
        }
        float4 _932 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_446, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _928)));
        float _935 = _932.x;
        float2 _938 = _86;
        _938.x = (_920 < 0.0) ? (1.0 - _935) : _935;
        float _940 = _932.y;
        float2 _943 = _938;
        _943.y = (_921 < 0.0) ? (1.0 - _940) : _940;
        _944 = _943;
        _945 = _932.xy;
    }
    else
    {
        float2 _903 = _88;
        _903.x = (_891.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
        float2 _909 = _903;
        _909.y = (_891.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
        _944 = in.in_var_ATTRIBUTE0;
        _945 = _909;
    }
    float2 _949 = _784.xy;
    float2 _950 = abs(_949);
    float2x3 _951 = float2x3(_887, _888);
    float2 _952 = _944 - _687;
    float2 _953 = _950 * _952;
    float3 _954 = _951 * _953;
    float3 _955 = _781 + _954;
    float3 _956 = _230 + _955;
    float _957 = fract(_446);
    float _958 = _446 - _957;
    float2 _971 = (float2(mod(_958, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x), floor(_958 * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.z)) + (float2(0.5) + ((_945 - float2(0.5)) * _738))) * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.zw;
    float3x3 _976 = _87;
    _976[0] = _887;
    float3x3 _977 = _976;
    _977[1] = _888;
    float3x3 _1011;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _1010 = _977;
        _1010[2] = normalize(cross(_887, _888));
        _1011 = _1010;
    }
    else
    {
        float3x3 _1007;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _1006 = _977;
            _1006[2] = normalize(_230 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _1007 = _1006;
        }
        else
        {
            float3x3 _1000 = _977;
            _1000[2] = normalize(_230 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _230 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _1007 = _1000;
        }
        _1011 = _1007;
    }
    float3 _1012 = _956 + View.View_PreViewTranslation;
    float _1013 = _1012.x;
    float _1014 = _1012.y;
    float _1015 = _1012.z;
    float4 _1016 = float4(_1013, _1014, _1015, 1.0);
    float4 _1017 = float4(_1016.x, _1016.y, _1016.z, _1016.w);
    float4 _1020 = View.View_TranslatedWorldToClip * _1017;
    float4 _1024 = float4(_1011[0].x, _1011[0].y, _1011[0].z, float4(0.0).w);
    _1024.w = (NiagaraSpriteVF.NiagaraSpriteVF_SubImageBlendMode == 1) ? _957 : 0.0;
    spvUnsafeArray<float4, 1> _1034 = { float4(_971.x, _971.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _1024;
    out.out_var_TEXCOORD11 = float4(_1011[2], float(int(sign(determinant(_1011)))));
    out_var_TEXCOORD1 = _1034;
    out.out_var_TEXCOORD6 = _1017;
    out.gl_Position = _1020;
    out.out_var_TEXCOORD1_0 = out_var_TEXCOORD1[0];
    return out;
}

