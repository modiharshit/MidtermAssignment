

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

constant spvUnsafeArray<float2, 1> _80 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _84 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex Main_out Main_00006553_3dd34ba1(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _100;
    _100 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _101 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _129;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _129 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _129 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _192;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _192 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _191;
            switch (0u)
            {
                default:
                {
                    uint _141 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _145 = int(_141 & 2147483647u);
                    if ((_141 & 2147483648u) != 0u)
                    {
                        _191 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_145) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_145 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_145 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x);
                        break;
                    }
                    else
                    {
                        _191 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_145) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_145 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_145 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _129))).x);
                        break;
                    }
                }
            }
            _192 = _191;
            break;
        }
    }
    float _194 = length(_192.xyz);
    bool _195 = _194 > 0.0;
    uint _201 = uint(int(_129));
    float3 _279;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _279 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _278;
            switch (0u)
            {
                default:
                {
                    uint _228 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _232 = int(_228 & 2147483647u);
                    if ((_228 & 2147483648u) != 0u)
                    {
                        _278 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_232) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_232 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_232 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                    else
                    {
                        _278 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_232) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_232 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_232 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                }
            }
            _279 = _278;
            break;
        }
    }
    float4 _350;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _350 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _349;
            switch (0u)
            {
                default:
                {
                    uint _287 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _291 = int(_287 & 2147483647u);
                    if ((_287 & 2147483648u) != 0u)
                    {
                        _349 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_291) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_291 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_291 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_291 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                    else
                    {
                        _349 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_291) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_291 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_291 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_291 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                }
            }
            _350 = _349;
            break;
        }
    }
    float3 _409;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _409 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _408;
            switch (0u)
            {
                default:
                {
                    uint _358 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _362 = int(_358 & 2147483647u);
                    if ((_358 & 2147483648u) != 0u)
                    {
                        _408 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_362) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_362 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_362 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                    else
                    {
                        _408 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_362) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_362 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_362 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x);
                        break;
                    }
                }
            }
            _409 = _408;
            break;
        }
    }
    float3 _412 = _409 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _413 = normalize(_350);
    float _414 = _413.x;
    float _415 = _414 + _414;
    float _416 = _413.y;
    float _417 = _416 + _416;
    float _418 = _413.z;
    float _419 = _418 + _418;
    float _420 = _414 * _415;
    float _421 = _414 * _417;
    float _422 = _414 * _419;
    float _423 = _416 * _417;
    float _424 = _416 * _419;
    float _425 = _418 * _419;
    float _426 = _413.w;
    float _427 = _426 * _415;
    float _428 = _426 * _417;
    float _429 = _426 * _419;
    float3x3 _445 = float3x3(float3(1.0 - (_423 + _425), _421 + _429, _422 - _428), float3(_421 - _429, 1.0 - (_420 + _425), _424 + _427), float3(_422 + _428, _424 - _427, 1.0 - (_420 + _423)));
    float3x3 _679;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _453 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _555;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _531;
                if (_195)
                {
                    _531 = select(float3(0.0), _192.xyz / float3(_194), bool3(_195)).xyz;
                }
                else
                {
                    float3 _529;
                    switch (0u)
                    {
                        default:
                        {
                            if (_453)
                            {
                                _529 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _529 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _531 = _529;
                }
                _555 = _531;
                break;
            }
            case 2u:
            {
                float3 _480;
                switch (0u)
                {
                    default:
                    {
                        if (_453)
                        {
                            _480 = (((Primitive.Primitive_LocalToWorld[0].xyz * _279.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _279.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _279.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _480 = _279;
                        break;
                    }
                }
                float3 _482 = normalize(View.View_WorldCameraOrigin - _480);
                float3 _504;
                switch (0u)
                {
                    default:
                    {
                        if (_453)
                        {
                            _504 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _482;
                            break;
                        }
                        _504 = _482;
                        break;
                    }
                }
                _555 = _504;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _532 = -View.View_ViewForward;
                float3 _554;
                switch (0u)
                {
                    default:
                    {
                        if (_453)
                        {
                            _554 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _532;
                            break;
                        }
                        _554 = _532;
                        break;
                    }
                }
                _555 = _554;
                break;
            }
        }
        float3 _674;
        float3 _675;
        float3 _676;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _606 = !_453;
            bool _608 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _606);
            float3 _659;
            if (_608 && _453)
            {
                _659 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _641;
                if ((!_608) && _606)
                {
                    _641 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _641 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _659 = _641;
            }
            float3 _670;
            if (abs(dot(_555, _659)) > 0.9900000095367431640625)
            {
                _670 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_659.z) > 0.9900000095367431640625));
            }
            else
            {
                _670 = _555;
            }
            float3 _672 = normalize(cross(_659, _670));
            _674 = _659;
            _675 = _672;
            _676 = cross(_672, _659);
        }
        else
        {
            float3 _576;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _576 = View.View_ViewUp;
            }
            else
            {
                _576 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_555.z))), bool3(abs(_555.z) > 0.9900000095367431640625));
            }
            float3 _598;
            switch (0u)
            {
                default:
                {
                    if (_453)
                    {
                        _598 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _576;
                        break;
                    }
                    _598 = _576;
                    break;
                }
            }
            float3 _600 = normalize(cross(_598, _555));
            _674 = cross(_555, _600);
            _675 = _600;
            _676 = _555;
        }
        _679 = float3x3(_676, _675, _674) * _445;
    }
    else
    {
        _679 = _445;
    }
    bool _684;
    float3 _704;
    switch (0u)
    {
        default:
        {
            _684 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_684)
            {
                _704 = (((Primitive.Primitive_LocalToWorld[0].xyz * _279.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _279.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _279.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _704 = _279;
            break;
        }
    }
    float _737;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _737 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _736;
            switch (0u)
            {
                default:
                {
                    uint _712 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _716 = int(_712 & 2147483647u);
                    if ((_712 & 2147483648u) != 0u)
                    {
                        _736 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_716) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x;
                        break;
                    }
                    else
                    {
                        _736 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_716) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _201))).x;
                        break;
                    }
                }
            }
            _737 = _736;
            break;
        }
    }
    float3 _739 = normalize(View.View_WorldCameraOrigin - _704);
    float3 _761;
    switch (0u)
    {
        default:
        {
            if (_684)
            {
                _761 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _739;
                break;
            }
            _761 = _739;
            break;
        }
    }
    float3 _763 = _279 + (_761 * _737);
    bool _766 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _775;
    if (!_766)
    {
        _775 = _763 + (_679 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _409));
    }
    else
    {
        _775 = _763;
    }
    float3x3 _783 = _679 * float3x3(float3(_412.x, 0.0, 0.0), float3(0.0, _412.y, 0.0), float3(0.0, 0.0, _412.z));
    float4 _802 = float4(_775, 1.0);
    float4x4 _803 = float4x4(float4(_783[0], 0.0), float4(_783[1], 0.0), float4(_783[2], 0.0), _802);
    float3x3 _804 = _679 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _820 = float4x4(float4(_804[0], 0.0), float4(_804[1], 0.0), float4(_804[2], 0.0), _802);
    float4x4 _845;
    float4x4 _846;
    if (_684)
    {
        float4x4 _824 = Primitive.Primitive_LocalToWorld * _820;
        float4 _828 = _824[0];
        float3 _830 = _828.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _832 = _824;
        _832[0] = float4(_830.x, _830.y, _830.z, _828.w);
        float4 _834 = _824[1];
        float3 _836 = _834.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _838 = _832;
        _838[1] = float4(_836.x, _836.y, _836.z, _834.w);
        float4 _840 = _824[2];
        float3 _842 = _840.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _844 = _838;
        _844[2] = float4(_842.x, _842.y, _842.z, _840.w);
        _845 = _844;
        _846 = Primitive.Primitive_LocalToWorld * _803;
    }
    else
    {
        _845 = _820;
        _846 = _803;
    }
    float4x4 _856;
    if (_766)
    {
        float3 _853 = _846[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _855 = _846;
        _855[3] = float4(_853.x, _853.y, _853.z, _846[3].w);
        _856 = _855;
    }
    else
    {
        _856 = _846;
    }
    for (int _858 = 0; _858 < 1; )
    {
        _101[_858] = _100[_858];
        _858++;
        continue;
    }
    float4 _867 = _856 * in.in_var_ATTRIBUTE0;
    float3 _868 = _867.xyz;
    float3 _869 = _868 + View.View_PreViewTranslation;
    float _871 = _869.x;
    float _872 = _869.y;
    float _873 = _869.z;
    float4 _874 = float4(_871, _872, _873, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _99;
    _99 = _101;
    spvUnsafeArray<float2, 1> _102 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _876 = 0; _876 < 1; )
    {
        _102[_876] = _99[_876];
        _876++;
        continue;
    }
    float4 _885 = float4(_874.x, _874.y, _874.z, _874.w);
    float4 _886 = View.View_TranslatedWorldToClip * _885;
    float4 _889 = _84;
    _889.w = 0.0;
    float3x3 _891 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _891[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _894 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _895 = _891;
    _895[1] = _894;
    float3x3 _898 = _895;
    _898[0] = cross(_894, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _906 = float3x3(_845[0].xyz, _845[1].xyz, _845[2].xyz) * _898;
    float3 _908 = normalize(_906[0]);
    spvUnsafeArray<float4, 1> _919 = { float4(_102[0].x, _102[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_908.x, _908.y, _908.z, _889.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_906[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _919;
    out.gl_Position = _886;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

