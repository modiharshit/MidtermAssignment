

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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
    char _m17_pad[8];
    int NiagaraSpriteVF_CameraOffsetDataOffset;
    char _m18_pad[8];
    int NiagaraSpriteVF_PivotOffsetDataOffset;
    char _m19_pad[16];
    float4 NiagaraSpriteVF_DefaultPos;
    char _m20_pad[16];
    float2 NiagaraSpriteVF_DefaultSize;
    char _m21_pad[16];
    float3 NiagaraSpriteVF_DefaultVelocity;
    char _m22_pad[12];
    float NiagaraSpriteVF_DefaultRotation;
    char _m23_pad[36];
    float NiagaraSpriteVF_DefaultCamOffset;
    char _m24_pad[8];
    float NiagaraSpriteVF_DefaultSubImage;
    float4 NiagaraSpriteVF_DefaultFacing;
    char _m26_pad[16];
    float4 NiagaraSpriteVF_DefaultAlignment;
};

struct type_Globals
{
    uint LayerId;
};

constant float2 _91 = {};
constant float3x3 _92 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainForGS_out Main_000075d2_03d964b6(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_NiagaraSpriteVFLooseParameters& NiagaraSpriteVFLooseParameters [[buffer(7)]], constant type_NiagaraSpriteVF& NiagaraSpriteVF [[buffer(8)]], constant type_Globals& _Globals [[buffer(9)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_CutoutGeometry [[texture(0)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat [[texture(1)]], texture_buffer<float> NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf [[texture(2)]], texture_buffer<int> NiagaraSpriteVFLooseParameters_SortedIndices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainForGS_out out = {};
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
    float3 _688 = View.View_WorldCameraOrigin - _230;
    float _689 = length(_688);
    float _690 = fast::max(_689, 9.9999999747524270787835121154785e-07);
    float3 _691 = float3(_690);
    float3 _692 = _688 / _691;
    float _729;
    switch (0u)
    {
        default:
        {
            if (NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset == (-1))
            {
                _729 = NiagaraSpriteVF.NiagaraSpriteVF_DefaultCamOffset;
                break;
            }
            float _728;
            switch (0u)
            {
                default:
                {
                    uint _704 = uint(NiagaraSpriteVF.NiagaraSpriteVF_CameraOffsetDataOffset);
                    int _708 = int(_704 & 2147483647u);
                    if ((_704 & 2147483648u) != 0u)
                    {
                        _728 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataHalf.read(uint(((uint(_708) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                    else
                    {
                        _728 = NiagaraSpriteVFLooseParameters_NiagaraParticleDataFloat.read(uint(((uint(_708) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NiagaraFloatDataStride) + _139))).x;
                        break;
                    }
                }
            }
            _729 = _728;
            break;
        }
    }
    float3 _730 = _692 * _729;
    float4 _733 = float4(_319, _268, _446);
    float _734 = length(_409);
    float3 _742 = float3(NiagaraSpriteVF.NiagaraSpriteVF_RemoveHMDRoll);
    float3 _743 = mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _742);
    float3 _744 = mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _742);
    float3 _745 = -_744;
    float3 _746 = -View.View_ViewForward;
    bool _749 = NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 2u;
    bool3 _750 = bool3(_749);
    float3 _751 = select(_692, _537 / float3(fast::max(length(_537), 9.9999999747524270787835121154785e-07)), _750);
    float3 _757 = mix(select(float3(0.0, 0.0, 1.0), _409 / float3(_734), bool3(_734 > 9.9999999747524270787835121154785e-07)), _632 / float3(fast::max(length(_632), 9.9999999747524270787835121154785e-07)), float3(float(NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 2u)));
    float3 _758 = cross(_751, _757);
    float3 _762 = _758 / float3(fast::max(length(_758), 9.9999999747524270787835121154785e-07));
    float3 _768 = cross(_746, _744);
    float3 _772 = _768 / float3(fast::max(length(_768), 9.9999999747524270787835121154785e-07));
    float3 _774 = cross(_751, _744);
    float3 _778 = _774 / float3(fast::max(length(_774), 9.9999999747524270787835121154785e-07));
    float3 _780 = cross(_692, float3(0.0, 0.0, 1.0));
    float3 _784 = _780 / float3(fast::max(length(_780), 9.9999999747524270787835121154785e-07));
    float3 _822;
    float3 _823;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleAlignmentMode == 0u)
    {
        float3 _820;
        float3 _821;
        if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 4u)
        {
            float3 _817 = float3(fast::clamp((dot(_688, _688) * NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[1]) - NiagaraSpriteVF.NiagaraSpriteVF_CameraFacingBlend[2], 0.0, 1.0));
            _820 = mix(cross(_692, _780), _745, _817);
            _821 = mix(_780, _743, _817);
        }
        else
        {
            float3 _806;
            float3 _807;
            if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 0u)
            {
                _806 = _745;
                _807 = _743;
            }
            else
            {
                float3 _804;
                float3 _805;
                if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_ParticleFacingMode == 1u)
                {
                    _804 = cross(_746, _772);
                    _805 = _772;
                }
                else
                {
                    _804 = select(cross(_692, _784), cross(_751, _778), _750);
                    _805 = select(_784, _778, _750);
                }
                _806 = _804;
                _807 = _805;
            }
            _820 = _806;
            _821 = _807;
        }
        _822 = _820;
        _823 = _821;
    }
    else
    {
        _822 = mix(-_757, cross(_751, _762), float3(float(_749)));
        _823 = _762;
    }
    float _826 = _268 * NiagaraSpriteVF.NiagaraSpriteVF_RotationScale;
    float _829 = _826 + NiagaraSpriteVF.NiagaraSpriteVF_RotationBias;
    float _830 = sin(_829);
    float _831 = cos(_829);
    float3 _832 = _823 * _830;
    float3 _833 = _822 * _830;
    float3 _834 = _823 * _831;
    float3 _835 = _822 * _831;
    float3 _836 = _833 + _834;
    float3 _837 = _835 - _832;
    float2 _840 = float2(int2(sign(_319)));
    float2 _880;
    if (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame > 0u)
    {
        uint _849 = (gl_VertexIndex - gl_BaseVertex) & ((NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame == 8u) ? 7u : 3u);
        float _857 = _840.x;
        float _858 = _840.y;
        uint _865;
        if ((_857 * _858) < 0.0)
        {
            _865 = (NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame - 1u) - _849;
        }
        else
        {
            _865 = _849;
        }
        float4 _869 = NiagaraSpriteVFLooseParameters_CutoutGeometry.read(uint(((uint(mod(_446, NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.x * NiagaraSpriteVF.NiagaraSpriteVF_SubImageSize.y)) * NiagaraSpriteVFLooseParameters.NiagaraSpriteVFLooseParameters_NumCutoutVerticesPerFrame) + _865)));
        float _871 = _869.x;
        float2 _874 = _91;
        _874.x = (_857 < 0.0) ? (1.0 - _871) : _871;
        float _876 = _869.y;
        float2 _879 = _874;
        _879.y = (_858 < 0.0) ? (1.0 - _876) : _876;
        _880 = _879;
    }
    else
    {
        _880 = in.in_var_ATTRIBUTE0;
    }
    float2 _881 = _733.xy;
    float2 _882 = abs(_881);
    float2x3 _883 = float2x3(_836, _837);
    float2 _884 = _880 - _687;
    float2 _885 = _882 * _884;
    float3 _886 = _883 * _885;
    float3 _887 = _730 + _886;
    float3 _888 = _230 + _887;
    float3 _889 = _888 + View.View_PreViewTranslation;
    float _890 = _889.x;
    float _891 = _889.y;
    float _892 = _889.z;
    float4 _893 = float4(_890, _891, _892, 1.0);
    float3x3 _927;
    if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 0.5)
    {
        float3x3 _926 = _92;
        _926[2] = normalize(cross(_836, _837));
        _927 = _926;
    }
    else
    {
        float3x3 _923;
        if (NiagaraSpriteVF.NiagaraSpriteVF_NormalsType < 1.5)
        {
            float3x3 _922 = _92;
            _922[2] = normalize(_230 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz);
            _923 = _922;
        }
        else
        {
            float3x3 _916 = _92;
            _916[2] = normalize(_230 - (NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz + (NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz * dot(NiagaraSpriteVF.NiagaraSpriteVF_NormalsCylinderUnitDirection.xyz, _230 - NiagaraSpriteVF.NiagaraSpriteVF_NormalsSphereCenter.xyz))));
            _923 = _916;
        }
        _927 = _923;
    }
    float4 _929 = float4(_893.x, _893.y, _893.z, _893.w);
    float4 _934 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _929;
    out.out_var_TEXCOORD6 = _929;
    out.out_var_TEXCOORD8 = _927[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _934;
    return out;
}

