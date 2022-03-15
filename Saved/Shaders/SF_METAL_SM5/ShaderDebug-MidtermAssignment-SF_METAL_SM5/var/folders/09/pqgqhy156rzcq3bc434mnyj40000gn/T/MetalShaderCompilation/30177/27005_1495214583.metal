

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
    char _m5_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m6_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m7_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_NiagaraMeshVF
{
    uint NiagaraMeshVF_bLocalSpace;
    char _m1_pad[12];
    packed_float3 NiagaraMeshVF_PivotOffset;
    int NiagaraMeshVF_bPivotOffsetIsWorldSpace;
    float3 NiagaraMeshVF_MeshScale;
    char _m4_pad[24];
    float NiagaraMeshVF_DeltaSeconds;
    char _m5_pad[4];
    int NiagaraMeshVF_SortedIndicesOffset;
    int NiagaraMeshVF_PositionDataOffset;
    char _m7_pad[4];
    int NiagaraMeshVF_VelocityDataOffset;
    char _m8_pad[8];
    int NiagaraMeshVF_RotationDataOffset;
    char _m9_pad[4];
    int NiagaraMeshVF_ScaleDataOffset;
    char _m10_pad[32];
    int NiagaraMeshVF_CameraOffsetDataOffset;
    float4 NiagaraMeshVF_DefaultPos;
    char _m12_pad[16];
    float3 NiagaraMeshVF_DefaultVelocity;
    char _m13_pad[32];
    float4 NiagaraMeshVF_DefaultRotation;
    char _m14_pad[16];
    float3 NiagaraMeshVF_DefaultScale;
    char _m15_pad[92];
    float NiagaraMeshVF_DefaultCamOffset;
    char _m16_pad[8];
    uint NiagaraMeshVF_FacingMode;
    uint NiagaraMeshVF_bLockedAxisEnable;
    packed_float3 NiagaraMeshVF_LockedAxis;
    uint NiagaraMeshVF_LockedAxisSpace;
    uint NiagaraMeshVF_NiagaraFloatDataStride;
};

constant spvUnsafeArray<float2, 1> _83 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _87 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex MainVertexShader_out Main_0000697d_591f29f7(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _104;
    _104 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _105 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _137;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _137 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _137 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _200;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _200 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _199;
            switch (0u)
            {
                default:
                {
                    uint _149 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _153 = int(_149 & 2147483647u);
                    if ((_149 & 2147483648u) != 0u)
                    {
                        _199 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_153) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_153 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_153 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x);
                        break;
                    }
                    else
                    {
                        _199 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_153) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_153 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_153 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _137))).x);
                        break;
                    }
                }
            }
            _200 = _199;
            break;
        }
    }
    float _202 = length(_200.xyz);
    bool _203 = _202 > 0.0;
    float3 _207 = select(float3(0.0), _200.xyz / float3(_202), bool3(_203));
    uint _209 = uint(int(_137));
    float3 _287;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _287 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _286;
            switch (0u)
            {
                default:
                {
                    uint _236 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _240 = int(_236 & 2147483647u);
                    if ((_236 & 2147483648u) != 0u)
                    {
                        _286 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_240) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_240 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_240 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                    else
                    {
                        _286 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_240) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_240 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_240 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                }
            }
            _287 = _286;
            break;
        }
    }
    float4 _358;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _358 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _357;
            switch (0u)
            {
                default:
                {
                    uint _295 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _299 = int(_295 & 2147483647u);
                    if ((_295 & 2147483648u) != 0u)
                    {
                        _357 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_299) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_299 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_299 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_299 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                    else
                    {
                        _357 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_299) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_299 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_299 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_299 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                }
            }
            _358 = _357;
            break;
        }
    }
    float3 _417;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _417 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _416;
            switch (0u)
            {
                default:
                {
                    uint _366 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _370 = int(_366 & 2147483647u);
                    if ((_366 & 2147483648u) != 0u)
                    {
                        _416 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_370) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_370 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_370 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                    else
                    {
                        _416 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_370) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_370 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_370 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x);
                        break;
                    }
                }
            }
            _417 = _416;
            break;
        }
    }
    float3 _420 = _417 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _421 = normalize(_358);
    float _422 = _421.x;
    float _423 = _422 + _422;
    float _424 = _421.y;
    float _425 = _424 + _424;
    float _426 = _421.z;
    float _427 = _426 + _426;
    float _428 = _422 * _423;
    float _429 = _422 * _425;
    float _430 = _422 * _427;
    float _431 = _424 * _425;
    float _432 = _424 * _427;
    float _433 = _426 * _427;
    float _434 = _421.w;
    float _435 = _434 * _423;
    float _436 = _434 * _425;
    float _437 = _434 * _427;
    float3x3 _453 = float3x3(float3(1.0 - (_431 + _433), _429 + _437, _430 - _436), float3(_429 - _437, 1.0 - (_428 + _433), _432 + _435), float3(_430 + _436, _432 - _435, 1.0 - (_428 + _431)));
    float3x3 _687;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _461 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _563;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _539;
                if (_203)
                {
                    _539 = _207.xyz;
                }
                else
                {
                    float3 _537;
                    switch (0u)
                    {
                        default:
                        {
                            if (_461)
                            {
                                _537 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _537 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _539 = _537;
                }
                _563 = _539;
                break;
            }
            case 2u:
            {
                float3 _488;
                switch (0u)
                {
                    default:
                    {
                        if (_461)
                        {
                            _488 = (((Primitive.Primitive_LocalToWorld[0].xyz * _287.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _287.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _287.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _488 = _287;
                        break;
                    }
                }
                float3 _490 = normalize(View.View_WorldCameraOrigin - _488);
                float3 _512;
                switch (0u)
                {
                    default:
                    {
                        if (_461)
                        {
                            _512 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _490;
                            break;
                        }
                        _512 = _490;
                        break;
                    }
                }
                _563 = _512;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _540 = -View.View_ViewForward;
                float3 _562;
                switch (0u)
                {
                    default:
                    {
                        if (_461)
                        {
                            _562 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _540;
                            break;
                        }
                        _562 = _540;
                        break;
                    }
                }
                _563 = _562;
                break;
            }
        }
        float3 _682;
        float3 _683;
        float3 _684;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _614 = !_461;
            bool _616 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _614);
            float3 _667;
            if (_616 && _461)
            {
                _667 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _649;
                if ((!_616) && _614)
                {
                    _649 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _649 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _667 = _649;
            }
            float3 _678;
            if (abs(dot(_563, _667)) > 0.9900000095367431640625)
            {
                _678 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_667.z) > 0.9900000095367431640625));
            }
            else
            {
                _678 = _563;
            }
            float3 _680 = normalize(cross(_667, _678));
            _682 = _667;
            _683 = _680;
            _684 = cross(_680, _667);
        }
        else
        {
            float3 _584;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _584 = View.View_ViewUp;
            }
            else
            {
                _584 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_563.z))), bool3(abs(_563.z) > 0.9900000095367431640625));
            }
            float3 _606;
            switch (0u)
            {
                default:
                {
                    if (_461)
                    {
                        _606 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _584;
                        break;
                    }
                    _606 = _584;
                    break;
                }
            }
            float3 _608 = normalize(cross(_606, _563));
            _682 = cross(_563, _608);
            _683 = _608;
            _684 = _563;
        }
        _687 = float3x3(_684, _683, _682) * _453;
    }
    else
    {
        _687 = _453;
    }
    bool _692;
    float3 _712;
    switch (0u)
    {
        default:
        {
            _692 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_692)
            {
                _712 = (((Primitive.Primitive_LocalToWorld[0].xyz * _287.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _287.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _287.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _712 = _287;
            break;
        }
    }
    float _745;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _745 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _744;
            switch (0u)
            {
                default:
                {
                    uint _720 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _724 = int(_720 & 2147483647u);
                    if ((_720 & 2147483648u) != 0u)
                    {
                        _744 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_724) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x;
                        break;
                    }
                    else
                    {
                        _744 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_724) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _209))).x;
                        break;
                    }
                }
            }
            _745 = _744;
            break;
        }
    }
    float3 _747 = normalize(View.View_WorldCameraOrigin - _712);
    float3 _769;
    switch (0u)
    {
        default:
        {
            if (_692)
            {
                _769 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _747;
                break;
            }
            _769 = _747;
            break;
        }
    }
    float3 _771 = _287 + (_769 * _745);
    bool _774 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _783;
    if (!_774)
    {
        _783 = _771 + (_687 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _417));
    }
    else
    {
        _783 = _771;
    }
    float3x3 _791 = _687 * float3x3(float3(_420.x, 0.0, 0.0), float3(0.0, _420.y, 0.0), float3(0.0, 0.0, _420.z));
    float4 _810 = float4(_783, 1.0);
    float4x4 _811 = float4x4(float4(_791[0], 0.0), float4(_791[1], 0.0), float4(_791[2], 0.0), _810);
    float3x3 _812 = _687 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _828 = float4x4(float4(_812[0], 0.0), float4(_812[1], 0.0), float4(_812[2], 0.0), _810);
    float3 _835 = _810.xyz - ((_207.xyz * _202) * NiagaraMeshVF.NiagaraMeshVF_DeltaSeconds);
    float4x4 _837 = _811;
    _837[3] = float4(_835.x, _835.y, _835.z, _810.w);
    float4x4 _865;
    float4x4 _866;
    float4x4 _867;
    if (_692)
    {
        float4x4 _844 = Primitive.Primitive_LocalToWorld * _828;
        float4 _848 = _844[0];
        float3 _850 = _848.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _852 = _844;
        _852[0] = float4(_850.x, _850.y, _850.z, _848.w);
        float4 _854 = _844[1];
        float3 _856 = _854.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _858 = _852;
        _858[1] = float4(_856.x, _856.y, _856.z, _854.w);
        float4 _860 = _844[2];
        float3 _862 = _860.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _864 = _858;
        _864[2] = float4(_862.x, _862.y, _862.z, _860.w);
        _865 = _864;
        _866 = Primitive.Primitive_PreviousLocalToWorld * _837;
        _867 = Primitive.Primitive_LocalToWorld * _811;
    }
    else
    {
        _865 = _828;
        _866 = _837;
        _867 = _811;
    }
    float4x4 _882;
    float4x4 _883;
    if (_774)
    {
        float3 _874 = _867[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _876 = _867;
        _876[3] = float4(_874.x, _874.y, _874.z, _867[3].w);
        float3 _879 = _866[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _881 = _866;
        _881[3] = float4(_879.x, _879.y, _879.z, _866[3].w);
        _882 = _876;
        _883 = _881;
    }
    else
    {
        _882 = _867;
        _883 = _866;
    }
    for (int _885 = 0; _885 < 1; )
    {
        _105[_885] = _104[_885];
        _885++;
        continue;
    }
    spvUnsafeArray<float2, 1> _103;
    _103 = _105;
    spvUnsafeArray<float2, 1> _106 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _901 = 0; _901 < 1; )
    {
        _106[_901] = _103[_901];
        _901++;
        continue;
    }
    float4 _912 = _87;
    _912.w = 0.0;
    float3x3 _914 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _914[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _917 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _918 = _914;
    _918[1] = _917;
    float3x3 _921 = _918;
    _921[0] = cross(_917, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _929 = float3x3(_865[0].xyz, _865[1].xyz, _865[2].xyz) * _921;
    float3 _931 = normalize(_929[0]);
    spvUnsafeArray<float4, 1> _942 = { float4(_106[0].x, _106[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _952 = View.View_TranslatedWorldToClip * float4((_882 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, 1.0);
    float4 _961 = _952;
    _961.z = _952.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _952.w) : 0.0);
    out.gl_Position = _961;
    out.out_var_TEXCOORD6 = _952;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_883 * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_931.x, _931.y, _931.z, _912.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_929[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _942;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

