

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
    char _m2_pad[80];
    float3 View_WorldCameraOrigin;
    char _m3_pad[32];
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

struct type_Globals
{
    uint LayerId;
};

constant float4 _87 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_0000641d_4fd6b1d0(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _124;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _124 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _124 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _187;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _187 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _186;
            switch (0u)
            {
                default:
                {
                    uint _136 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _140 = int(_136 & 2147483647u);
                    if ((_136 & 2147483648u) != 0u)
                    {
                        _186 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_140) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_140 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_140 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x);
                        break;
                    }
                    else
                    {
                        _186 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_140) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_140 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_140 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _124))).x);
                        break;
                    }
                }
            }
            _187 = _186;
            break;
        }
    }
    float _189 = length(_187.xyz);
    bool _190 = _189 > 0.0;
    uint _196 = uint(int(_124));
    float3 _274;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _274 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _273;
            switch (0u)
            {
                default:
                {
                    uint _223 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _227 = int(_223 & 2147483647u);
                    if ((_223 & 2147483648u) != 0u)
                    {
                        _273 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_227) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_227 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_227 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                    else
                    {
                        _273 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_227) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_227 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_227 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                }
            }
            _274 = _273;
            break;
        }
    }
    float4 _345;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _345 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _344;
            switch (0u)
            {
                default:
                {
                    uint _282 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _286 = int(_282 & 2147483647u);
                    if ((_282 & 2147483648u) != 0u)
                    {
                        _344 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_286) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_286 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_286 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_286 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                    else
                    {
                        _344 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_286) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_286 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_286 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_286 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                }
            }
            _345 = _344;
            break;
        }
    }
    float3 _404;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _404 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _403;
            switch (0u)
            {
                default:
                {
                    uint _353 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _357 = int(_353 & 2147483647u);
                    if ((_353 & 2147483648u) != 0u)
                    {
                        _403 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_357) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_357 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_357 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                    else
                    {
                        _403 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_357) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_357 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_357 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x);
                        break;
                    }
                }
            }
            _404 = _403;
            break;
        }
    }
    float3 _407 = _404 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _408 = normalize(_345);
    float _409 = _408.x;
    float _410 = _409 + _409;
    float _411 = _408.y;
    float _412 = _411 + _411;
    float _413 = _408.z;
    float _414 = _413 + _413;
    float _415 = _409 * _410;
    float _416 = _409 * _412;
    float _417 = _409 * _414;
    float _418 = _411 * _412;
    float _419 = _411 * _414;
    float _420 = _413 * _414;
    float _421 = _408.w;
    float _422 = _421 * _410;
    float _423 = _421 * _412;
    float _424 = _421 * _414;
    float3x3 _440 = float3x3(float3(1.0 - (_418 + _420), _416 + _424, _417 - _423), float3(_416 - _424, 1.0 - (_415 + _420), _419 + _422), float3(_417 + _423, _419 - _422, 1.0 - (_415 + _418)));
    float3x3 _674;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _448 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _550;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _526;
                if (_190)
                {
                    _526 = select(float3(0.0), _187.xyz / float3(_189), bool3(_190)).xyz;
                }
                else
                {
                    float3 _524;
                    switch (0u)
                    {
                        default:
                        {
                            if (_448)
                            {
                                _524 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _524 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _526 = _524;
                }
                _550 = _526;
                break;
            }
            case 2u:
            {
                float3 _475;
                switch (0u)
                {
                    default:
                    {
                        if (_448)
                        {
                            _475 = (((Primitive.Primitive_LocalToWorld[0].xyz * _274.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _274.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _274.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _475 = _274;
                        break;
                    }
                }
                float3 _477 = normalize(View.View_WorldCameraOrigin - _475);
                float3 _499;
                switch (0u)
                {
                    default:
                    {
                        if (_448)
                        {
                            _499 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _477;
                            break;
                        }
                        _499 = _477;
                        break;
                    }
                }
                _550 = _499;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _527 = -View.View_ViewForward;
                float3 _549;
                switch (0u)
                {
                    default:
                    {
                        if (_448)
                        {
                            _549 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _527;
                            break;
                        }
                        _549 = _527;
                        break;
                    }
                }
                _550 = _549;
                break;
            }
        }
        float3 _669;
        float3 _670;
        float3 _671;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _601 = !_448;
            bool _603 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _601);
            float3 _654;
            if (_603 && _448)
            {
                _654 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _636;
                if ((!_603) && _601)
                {
                    _636 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _636 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _654 = _636;
            }
            float3 _665;
            if (abs(dot(_550, _654)) > 0.9900000095367431640625)
            {
                _665 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_654.z) > 0.9900000095367431640625));
            }
            else
            {
                _665 = _550;
            }
            float3 _667 = normalize(cross(_654, _665));
            _669 = _654;
            _670 = _667;
            _671 = cross(_667, _654);
        }
        else
        {
            float3 _571;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _571 = View.View_ViewUp;
            }
            else
            {
                _571 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_550.z))), bool3(abs(_550.z) > 0.9900000095367431640625));
            }
            float3 _593;
            switch (0u)
            {
                default:
                {
                    if (_448)
                    {
                        _593 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _571;
                        break;
                    }
                    _593 = _571;
                    break;
                }
            }
            float3 _595 = normalize(cross(_593, _550));
            _669 = cross(_550, _595);
            _670 = _595;
            _671 = _550;
        }
        _674 = float3x3(_671, _670, _669) * _440;
    }
    else
    {
        _674 = _440;
    }
    bool _679;
    float3 _699;
    switch (0u)
    {
        default:
        {
            _679 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_679)
            {
                _699 = (((Primitive.Primitive_LocalToWorld[0].xyz * _274.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _274.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _274.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _699 = _274;
            break;
        }
    }
    float _732;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _732 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _731;
            switch (0u)
            {
                default:
                {
                    uint _707 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _711 = int(_707 & 2147483647u);
                    if ((_707 & 2147483648u) != 0u)
                    {
                        _731 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_711) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x;
                        break;
                    }
                    else
                    {
                        _731 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_711) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _196))).x;
                        break;
                    }
                }
            }
            _732 = _731;
            break;
        }
    }
    float3 _734 = normalize(View.View_WorldCameraOrigin - _699);
    float3 _756;
    switch (0u)
    {
        default:
        {
            if (_679)
            {
                _756 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _734;
                break;
            }
            _756 = _734;
            break;
        }
    }
    float3 _758 = _274 + (_756 * _732);
    bool _761 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _770;
    if (!_761)
    {
        _770 = _758 + (_674 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _404));
    }
    else
    {
        _770 = _758;
    }
    float3x3 _778 = _674 * float3x3(float3(_407.x, 0.0, 0.0), float3(0.0, _407.y, 0.0), float3(0.0, 0.0, _407.z));
    float4 _797 = float4(_770, 1.0);
    float4x4 _798 = float4x4(float4(_778[0], 0.0), float4(_778[1], 0.0), float4(_778[2], 0.0), _797);
    float3x3 _799 = _674 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _815 = float4x4(float4(_799[0], 0.0), float4(_799[1], 0.0), float4(_799[2], 0.0), _797);
    float4x4 _840;
    float4x4 _841;
    if (_679)
    {
        float4x4 _819 = Primitive.Primitive_LocalToWorld * _815;
        float4 _823 = _819[0];
        float3 _825 = _823.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _827 = _819;
        _827[0] = float4(_825.x, _825.y, _825.z, _823.w);
        float4 _829 = _819[1];
        float3 _831 = _829.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _833 = _827;
        _833[1] = float4(_831.x, _831.y, _831.z, _829.w);
        float4 _835 = _819[2];
        float3 _837 = _835.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _839 = _833;
        _839[2] = float4(_837.x, _837.y, _837.z, _835.w);
        _840 = _839;
        _841 = Primitive.Primitive_LocalToWorld * _798;
    }
    else
    {
        _840 = _815;
        _841 = _798;
    }
    float4x4 _851;
    if (_761)
    {
        float3 _848 = _841[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _850 = _841;
        _850[3] = float4(_848.x, _848.y, _848.z, _841[3].w);
        _851 = _850;
    }
    else
    {
        _851 = _841;
    }
    float4 _852 = _851 * in.in_var_ATTRIBUTE0;
    float3 _853 = _852.xyz;
    float3 _854 = _853 + View.View_PreViewTranslation;
    float _856 = _854.x;
    float _857 = _854.y;
    float _858 = _854.z;
    float4 _859 = float4(_856, _857, _858, in.in_var_ATTRIBUTE0.w);
    float4 _862 = float4(_859.x, _859.y, _859.z, _859.w);
    float4 _863 = _87;
    _863.w = 0.0;
    float3x3 _865 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _865[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _868 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _869 = _865;
    _869[1] = _868;
    float3x3 _872 = _869;
    _872[0] = cross(_868, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _880 = float3x3(_840[0].xyz, _840[1].xyz, _840[2].xyz) * _872;
    float3 _882 = normalize(_880[0]);
    float4 _898 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _862;
    out.out_var_TEXCOORD10_centroid = float4(_882.x, _882.y, _882.z, _863.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_880[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _859.xyz;
    out.out_var_TEXCOORD6 = _898;
    out.out_var_TEXCOORD8 = _851[2].xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _898;
    return out;
}

