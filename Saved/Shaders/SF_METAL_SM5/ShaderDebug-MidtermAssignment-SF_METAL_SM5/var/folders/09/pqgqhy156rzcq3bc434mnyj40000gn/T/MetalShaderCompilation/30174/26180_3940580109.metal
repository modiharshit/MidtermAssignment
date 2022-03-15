

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
    char _m3_pad[80];
    float3 View_WorldCameraOrigin;
    char _m4_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
};

struct type_NiagaraMeshVF
{
    uint NiagaraMeshVF_bLocalSpace;
    char _m1_pad[12];
    packed_float3 NiagaraMeshVF_PivotOffset;
    int NiagaraMeshVF_bPivotOffsetIsWorldSpace;
    float3 NiagaraMeshVF_MeshScale;
    char _m4_pad[32];
    int NiagaraMeshVF_SortedIndicesOffset;
    int NiagaraMeshVF_PositionDataOffset;
    char _m6_pad[4];
    int NiagaraMeshVF_VelocityDataOffset;
    char _m7_pad[8];
    int NiagaraMeshVF_RotationDataOffset;
    char _m8_pad[4];
    int NiagaraMeshVF_ScaleDataOffset;
    char _m9_pad[32];
    int NiagaraMeshVF_CameraOffsetDataOffset;
    float4 NiagaraMeshVF_DefaultPos;
    char _m11_pad[16];
    float3 NiagaraMeshVF_DefaultVelocity;
    char _m12_pad[32];
    float4 NiagaraMeshVF_DefaultRotation;
    char _m13_pad[16];
    float3 NiagaraMeshVF_DefaultScale;
    char _m14_pad[92];
    float NiagaraMeshVF_DefaultCamOffset;
    char _m15_pad[8];
    uint NiagaraMeshVF_FacingMode;
    uint NiagaraMeshVF_bLockedAxisEnable;
    packed_float3 NiagaraMeshVF_LockedAxis;
    uint NiagaraMeshVF_LockedAxisSpace;
    uint NiagaraMeshVF_NiagaraFloatDataStride;
};

constant spvUnsafeArray<float2, 1> _81 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _83 = {};
constant float4 _86 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_PARTICLE_VELOCITY [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex Main_out Main_00006644_eae07b0d(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _102;
    _102 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _103 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _131;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _131 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _131 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _194;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _194 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _193;
            switch (0u)
            {
                default:
                {
                    uint _143 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _147 = int(_143 & 2147483647u);
                    if ((_143 & 2147483648u) != 0u)
                    {
                        _193 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_147) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_147 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_147 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x);
                        break;
                    }
                    else
                    {
                        _193 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_147) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_147 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_147 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _131))).x);
                        break;
                    }
                }
            }
            _194 = _193;
            break;
        }
    }
    float _197 = length(_194.xyz);
    float4 _198 = float4(_194.x, _194.y, _194.z, _83.w);
    _198.w = _197;
    bool _199 = _197 > 0.0;
    float3 _204 = select(float3(0.0), _198.xyz / float3(_197), bool3(_199));
    uint _207 = uint(int(_131));
    float3 _285;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _285 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _284;
            switch (0u)
            {
                default:
                {
                    uint _234 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _238 = int(_234 & 2147483647u);
                    if ((_234 & 2147483648u) != 0u)
                    {
                        _284 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_238) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_238 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_238 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                    else
                    {
                        _284 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_238) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_238 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_238 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                }
            }
            _285 = _284;
            break;
        }
    }
    float4 _356;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _356 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _355;
            switch (0u)
            {
                default:
                {
                    uint _293 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _297 = int(_293 & 2147483647u);
                    if ((_293 & 2147483648u) != 0u)
                    {
                        _355 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_297) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_297 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_297 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_297 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                    else
                    {
                        _355 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_297) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_297 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_297 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_297 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                }
            }
            _356 = _355;
            break;
        }
    }
    float3 _415;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _415 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _414;
            switch (0u)
            {
                default:
                {
                    uint _364 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _368 = int(_364 & 2147483647u);
                    if ((_364 & 2147483648u) != 0u)
                    {
                        _414 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_368) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_368 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_368 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                    else
                    {
                        _414 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_368) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_368 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_368 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x);
                        break;
                    }
                }
            }
            _415 = _414;
            break;
        }
    }
    float3 _418 = _415 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _419 = normalize(_356);
    float _420 = _419.x;
    float _421 = _420 + _420;
    float _422 = _419.y;
    float _423 = _422 + _422;
    float _424 = _419.z;
    float _425 = _424 + _424;
    float _426 = _420 * _421;
    float _427 = _420 * _423;
    float _428 = _420 * _425;
    float _429 = _422 * _423;
    float _430 = _422 * _425;
    float _431 = _424 * _425;
    float _432 = _419.w;
    float _433 = _432 * _421;
    float _434 = _432 * _423;
    float _435 = _432 * _425;
    float3x3 _451 = float3x3(float3(1.0 - (_429 + _431), _427 + _435, _428 - _434), float3(_427 - _435, 1.0 - (_426 + _431), _430 + _433), float3(_428 + _434, _430 - _433, 1.0 - (_426 + _429)));
    float3x3 _685;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _459 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _561;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _537;
                if (_199)
                {
                    _537 = _204.xyz;
                }
                else
                {
                    float3 _535;
                    switch (0u)
                    {
                        default:
                        {
                            if (_459)
                            {
                                _535 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _535 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _537 = _535;
                }
                _561 = _537;
                break;
            }
            case 2u:
            {
                float3 _486;
                switch (0u)
                {
                    default:
                    {
                        if (_459)
                        {
                            _486 = (((Primitive.Primitive_LocalToWorld[0].xyz * _285.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _285.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _285.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _486 = _285;
                        break;
                    }
                }
                float3 _488 = normalize(View.View_WorldCameraOrigin - _486);
                float3 _510;
                switch (0u)
                {
                    default:
                    {
                        if (_459)
                        {
                            _510 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _488;
                            break;
                        }
                        _510 = _488;
                        break;
                    }
                }
                _561 = _510;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _538 = -View.View_ViewForward;
                float3 _560;
                switch (0u)
                {
                    default:
                    {
                        if (_459)
                        {
                            _560 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _538;
                            break;
                        }
                        _560 = _538;
                        break;
                    }
                }
                _561 = _560;
                break;
            }
        }
        float3 _680;
        float3 _681;
        float3 _682;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _612 = !_459;
            bool _614 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _612);
            float3 _665;
            if (_614 && _459)
            {
                _665 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _647;
                if ((!_614) && _612)
                {
                    _647 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _647 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _665 = _647;
            }
            float3 _676;
            if (abs(dot(_561, _665)) > 0.9900000095367431640625)
            {
                _676 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_665.z) > 0.9900000095367431640625));
            }
            else
            {
                _676 = _561;
            }
            float3 _678 = normalize(cross(_665, _676));
            _680 = _665;
            _681 = _678;
            _682 = cross(_678, _665);
        }
        else
        {
            float3 _582;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _582 = View.View_ViewUp;
            }
            else
            {
                _582 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_561.z))), bool3(abs(_561.z) > 0.9900000095367431640625));
            }
            float3 _604;
            switch (0u)
            {
                default:
                {
                    if (_459)
                    {
                        _604 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _582;
                        break;
                    }
                    _604 = _582;
                    break;
                }
            }
            float3 _606 = normalize(cross(_604, _561));
            _680 = cross(_561, _606);
            _681 = _606;
            _682 = _561;
        }
        _685 = float3x3(_682, _681, _680) * _451;
    }
    else
    {
        _685 = _451;
    }
    bool _690;
    float3 _710;
    switch (0u)
    {
        default:
        {
            _690 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_690)
            {
                _710 = (((Primitive.Primitive_LocalToWorld[0].xyz * _285.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _285.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _285.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _710 = _285;
            break;
        }
    }
    float _743;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _743 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _742;
            switch (0u)
            {
                default:
                {
                    uint _718 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _722 = int(_718 & 2147483647u);
                    if ((_718 & 2147483648u) != 0u)
                    {
                        _742 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_722) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x;
                        break;
                    }
                    else
                    {
                        _742 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_722) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _207))).x;
                        break;
                    }
                }
            }
            _743 = _742;
            break;
        }
    }
    float3 _745 = normalize(View.View_WorldCameraOrigin - _710);
    float3 _767;
    switch (0u)
    {
        default:
        {
            if (_690)
            {
                _767 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _745;
                break;
            }
            _767 = _745;
            break;
        }
    }
    float3 _769 = _285 + (_767 * _743);
    bool _772 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _781;
    if (!_772)
    {
        _781 = _769 + (_685 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _415));
    }
    else
    {
        _781 = _769;
    }
    float3x3 _789 = _685 * float3x3(float3(_418.x, 0.0, 0.0), float3(0.0, _418.y, 0.0), float3(0.0, 0.0, _418.z));
    float4 _808 = float4(_781, 1.0);
    float4x4 _809 = float4x4(float4(_789[0], 0.0), float4(_789[1], 0.0), float4(_789[2], 0.0), _808);
    float3x3 _810 = _685 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _826 = float4x4(float4(_810[0], 0.0), float4(_810[1], 0.0), float4(_810[2], 0.0), _808);
    float4x4 _851;
    float4x4 _852;
    if (_690)
    {
        float4x4 _830 = Primitive.Primitive_LocalToWorld * _826;
        float4 _834 = _830[0];
        float3 _836 = _834.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _838 = _830;
        _838[0] = float4(_836.x, _836.y, _836.z, _834.w);
        float4 _840 = _830[1];
        float3 _842 = _840.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _844 = _838;
        _844[1] = float4(_842.x, _842.y, _842.z, _840.w);
        float4 _846 = _830[2];
        float3 _848 = _846.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _850 = _844;
        _850[2] = float4(_848.x, _848.y, _848.z, _846.w);
        _851 = _850;
        _852 = Primitive.Primitive_LocalToWorld * _809;
    }
    else
    {
        _851 = _826;
        _852 = _809;
    }
    float4x4 _862;
    if (_772)
    {
        float3 _859 = _852[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _861 = _852;
        _861[3] = float4(_859.x, _859.y, _859.z, _852[3].w);
        _862 = _861;
    }
    else
    {
        _862 = _852;
    }
    for (int _864 = 0; _864 < 1; )
    {
        _103[_864] = _102[_864];
        _864++;
        continue;
    }
    float4 _873 = _862 * in.in_var_ATTRIBUTE0;
    float3 _874 = _873.xyz;
    float3 _875 = _874 + View.View_PreViewTranslation;
    float _877 = _875.x;
    float _878 = _875.y;
    float _879 = _875.z;
    float4 _880 = float4(_877, _878, _879, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _101;
    _101 = _103;
    spvUnsafeArray<float2, 1> _104 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _882 = 0; _882 < 1; )
    {
        _104[_882] = _101[_882];
        _882++;
        continue;
    }
    float4 _891 = float4(_880.x, _880.y, _880.z, _880.w);
    float4 _892 = View.View_TranslatedWorldToClip * _891;
    float4 _895 = _86;
    _895.w = 0.0;
    float3x3 _897 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _897[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _900 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _901 = _897;
    _901[1] = _900;
    float3x3 _904 = _901;
    _904[0] = cross(_900, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _912 = float3x3(_851[0].xyz, _851[1].xyz, _851[2].xyz) * _904;
    float3 _914 = normalize(_912[0]);
    spvUnsafeArray<float4, 1> _925 = { float4(_104[0].x, _104[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_914.x, _914.y, _914.z, _895.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_912[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _925;
    out.out_var_PARTICLE_VELOCITY = float4(_204.x, _204.y, _204.z, _198.w);
    out.gl_Position = _892;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

