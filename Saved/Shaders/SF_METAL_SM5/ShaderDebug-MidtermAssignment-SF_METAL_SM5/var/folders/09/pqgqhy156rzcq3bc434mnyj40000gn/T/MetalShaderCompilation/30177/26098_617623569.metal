

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

constant float4 _85 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex MainVertexShader_out Main_000065f2_24d03011(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _101;
    _101 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _102 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _130;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _130 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _130 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _193;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _193 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _192;
            switch (0u)
            {
                default:
                {
                    uint _142 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _146 = int(_142 & 2147483647u);
                    if ((_142 & 2147483648u) != 0u)
                    {
                        _192 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_146) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_146 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_146 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x);
                        break;
                    }
                    else
                    {
                        _192 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_146) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_146 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_146 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _130))).x);
                        break;
                    }
                }
            }
            _193 = _192;
            break;
        }
    }
    float _195 = length(_193.xyz);
    bool _196 = _195 > 0.0;
    uint _202 = uint(int(_130));
    float3 _280;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _280 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _279;
            switch (0u)
            {
                default:
                {
                    uint _229 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _233 = int(_229 & 2147483647u);
                    if ((_229 & 2147483648u) != 0u)
                    {
                        _279 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_233) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_233 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_233 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                    else
                    {
                        _279 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_233) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_233 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_233 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                }
            }
            _280 = _279;
            break;
        }
    }
    float4 _351;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _351 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _350;
            switch (0u)
            {
                default:
                {
                    uint _288 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _292 = int(_288 & 2147483647u);
                    if ((_288 & 2147483648u) != 0u)
                    {
                        _350 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_292) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_292 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_292 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_292 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                    else
                    {
                        _350 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_292) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_292 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_292 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_292 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                }
            }
            _351 = _350;
            break;
        }
    }
    float3 _410;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _410 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _409;
            switch (0u)
            {
                default:
                {
                    uint _359 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _363 = int(_359 & 2147483647u);
                    if ((_359 & 2147483648u) != 0u)
                    {
                        _409 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_363) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_363 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_363 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                    else
                    {
                        _409 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_363) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_363 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_363 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x);
                        break;
                    }
                }
            }
            _410 = _409;
            break;
        }
    }
    float3 _413 = _410 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _414 = normalize(_351);
    float _415 = _414.x;
    float _416 = _415 + _415;
    float _417 = _414.y;
    float _418 = _417 + _417;
    float _419 = _414.z;
    float _420 = _419 + _419;
    float _421 = _415 * _416;
    float _422 = _415 * _418;
    float _423 = _415 * _420;
    float _424 = _417 * _418;
    float _425 = _417 * _420;
    float _426 = _419 * _420;
    float _427 = _414.w;
    float _428 = _427 * _416;
    float _429 = _427 * _418;
    float _430 = _427 * _420;
    float3x3 _446 = float3x3(float3(1.0 - (_424 + _426), _422 + _430, _423 - _429), float3(_422 - _430, 1.0 - (_421 + _426), _425 + _428), float3(_423 + _429, _425 - _428, 1.0 - (_421 + _424)));
    float3x3 _680;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _454 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _556;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _532;
                if (_196)
                {
                    _532 = select(float3(0.0), _193.xyz / float3(_195), bool3(_196)).xyz;
                }
                else
                {
                    float3 _530;
                    switch (0u)
                    {
                        default:
                        {
                            if (_454)
                            {
                                _530 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _530 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _532 = _530;
                }
                _556 = _532;
                break;
            }
            case 2u:
            {
                float3 _481;
                switch (0u)
                {
                    default:
                    {
                        if (_454)
                        {
                            _481 = (((Primitive.Primitive_LocalToWorld[0].xyz * _280.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _280.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _280.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _481 = _280;
                        break;
                    }
                }
                float3 _483 = normalize(View.View_WorldCameraOrigin - _481);
                float3 _505;
                switch (0u)
                {
                    default:
                    {
                        if (_454)
                        {
                            _505 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _483;
                            break;
                        }
                        _505 = _483;
                        break;
                    }
                }
                _556 = _505;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _533 = -View.View_ViewForward;
                float3 _555;
                switch (0u)
                {
                    default:
                    {
                        if (_454)
                        {
                            _555 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _533;
                            break;
                        }
                        _555 = _533;
                        break;
                    }
                }
                _556 = _555;
                break;
            }
        }
        float3 _675;
        float3 _676;
        float3 _677;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _607 = !_454;
            bool _609 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _607);
            float3 _660;
            if (_609 && _454)
            {
                _660 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _642;
                if ((!_609) && _607)
                {
                    _642 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _642 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _660 = _642;
            }
            float3 _671;
            if (abs(dot(_556, _660)) > 0.9900000095367431640625)
            {
                _671 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_660.z) > 0.9900000095367431640625));
            }
            else
            {
                _671 = _556;
            }
            float3 _673 = normalize(cross(_660, _671));
            _675 = _660;
            _676 = _673;
            _677 = cross(_673, _660);
        }
        else
        {
            float3 _577;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _577 = View.View_ViewUp;
            }
            else
            {
                _577 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_556.z))), bool3(abs(_556.z) > 0.9900000095367431640625));
            }
            float3 _599;
            switch (0u)
            {
                default:
                {
                    if (_454)
                    {
                        _599 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _577;
                        break;
                    }
                    _599 = _577;
                    break;
                }
            }
            float3 _601 = normalize(cross(_599, _556));
            _675 = cross(_556, _601);
            _676 = _601;
            _677 = _556;
        }
        _680 = float3x3(_677, _676, _675) * _446;
    }
    else
    {
        _680 = _446;
    }
    bool _685;
    float3 _705;
    switch (0u)
    {
        default:
        {
            _685 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_685)
            {
                _705 = (((Primitive.Primitive_LocalToWorld[0].xyz * _280.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _280.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _280.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _705 = _280;
            break;
        }
    }
    float _738;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _738 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _737;
            switch (0u)
            {
                default:
                {
                    uint _713 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _717 = int(_713 & 2147483647u);
                    if ((_713 & 2147483648u) != 0u)
                    {
                        _737 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_717) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x;
                        break;
                    }
                    else
                    {
                        _737 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_717) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _202))).x;
                        break;
                    }
                }
            }
            _738 = _737;
            break;
        }
    }
    float3 _740 = normalize(View.View_WorldCameraOrigin - _705);
    float3 _762;
    switch (0u)
    {
        default:
        {
            if (_685)
            {
                _762 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _740;
                break;
            }
            _762 = _740;
            break;
        }
    }
    float3 _764 = _280 + (_762 * _738);
    bool _767 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _776;
    if (!_767)
    {
        _776 = _764 + (_680 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _410));
    }
    else
    {
        _776 = _764;
    }
    float3x3 _784 = _680 * float3x3(float3(_413.x, 0.0, 0.0), float3(0.0, _413.y, 0.0), float3(0.0, 0.0, _413.z));
    float4 _803 = float4(_776, 1.0);
    float4x4 _804 = float4x4(float4(_784[0], 0.0), float4(_784[1], 0.0), float4(_784[2], 0.0), _803);
    float3x3 _805 = _680 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _821 = float4x4(float4(_805[0], 0.0), float4(_805[1], 0.0), float4(_805[2], 0.0), _803);
    float4x4 _846;
    float4x4 _847;
    if (_685)
    {
        float4x4 _825 = Primitive.Primitive_LocalToWorld * _821;
        float4 _829 = _825[0];
        float3 _831 = _829.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _833 = _825;
        _833[0] = float4(_831.x, _831.y, _831.z, _829.w);
        float4 _835 = _825[1];
        float3 _837 = _835.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _839 = _833;
        _839[1] = float4(_837.x, _837.y, _837.z, _835.w);
        float4 _841 = _825[2];
        float3 _843 = _841.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _845 = _839;
        _845[2] = float4(_843.x, _843.y, _843.z, _841.w);
        _846 = _845;
        _847 = Primitive.Primitive_LocalToWorld * _804;
    }
    else
    {
        _846 = _821;
        _847 = _804;
    }
    float4x4 _857;
    if (_767)
    {
        float3 _854 = _847[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _856 = _847;
        _856[3] = float4(_854.x, _854.y, _854.z, _847[3].w);
        _857 = _856;
    }
    else
    {
        _857 = _847;
    }
    for (int _859 = 0; _859 < 1; )
    {
        _102[_859] = _101[_859];
        _859++;
        continue;
    }
    float4 _868 = _857 * in.in_var_ATTRIBUTE0;
    float3 _869 = _868.xyz;
    float3 _870 = _869 + View.View_PreViewTranslation;
    float _872 = _870.x;
    float _873 = _870.y;
    float _874 = _870.z;
    float4 _875 = float4(_872, _873, _874, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _100;
    _100 = _102;
    spvUnsafeArray<float2, 1> _103 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _877 = 0; _877 < 1; )
    {
        _103[_877] = _100[_877];
        _877++;
        continue;
    }
    float4 _886 = float4(_875.x, _875.y, _875.z, _875.w);
    float4 _887 = View.View_TranslatedWorldToClip * _886;
    float4 _890 = _85;
    _890.w = 0.0;
    float3x3 _892 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _892[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _895 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _896 = _892;
    _896[1] = _895;
    float3x3 _899 = _896;
    _899[0] = cross(_895, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _907 = float3x3(_846[0].xyz, _846[1].xyz, _846[2].xyz) * _899;
    float3 _909 = normalize(_907[0]);
    spvUnsafeArray<float4, 1> _920 = { float4(_103[0].x, _103[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_909.x, _909.y, _909.z, _890.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_907[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _920;
    out.out_var_TEXCOORD6 = _886;
    out.gl_Position = _887;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

