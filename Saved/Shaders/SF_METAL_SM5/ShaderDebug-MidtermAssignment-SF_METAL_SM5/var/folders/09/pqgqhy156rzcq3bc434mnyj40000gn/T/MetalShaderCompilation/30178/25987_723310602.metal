

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

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex Main_out Main_00006583_2b1cd80a(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _101;
    _101 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _102 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _128;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _128 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _128 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _191;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _191 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _190;
            switch (0u)
            {
                default:
                {
                    uint _140 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _144 = int(_140 & 2147483647u);
                    if ((_140 & 2147483648u) != 0u)
                    {
                        _190 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_144) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_144 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_144 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x);
                        break;
                    }
                    else
                    {
                        _190 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_144) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_144 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_144 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _128))).x);
                        break;
                    }
                }
            }
            _191 = _190;
            break;
        }
    }
    float _193 = length(_191.xyz);
    bool _194 = _193 > 0.0;
    uint _200 = uint(int(_128));
    float3 _278;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _278 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _277;
            switch (0u)
            {
                default:
                {
                    uint _227 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _231 = int(_227 & 2147483647u);
                    if ((_227 & 2147483648u) != 0u)
                    {
                        _277 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_231) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_231 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_231 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                    else
                    {
                        _277 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_231) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_231 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_231 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                }
            }
            _278 = _277;
            break;
        }
    }
    float4 _349;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _349 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _348;
            switch (0u)
            {
                default:
                {
                    uint _286 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _290 = int(_286 & 2147483647u);
                    if ((_286 & 2147483648u) != 0u)
                    {
                        _348 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_290) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_290 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_290 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_290 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                    else
                    {
                        _348 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_290) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_290 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_290 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_290 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                }
            }
            _349 = _348;
            break;
        }
    }
    float3 _408;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _408 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _407;
            switch (0u)
            {
                default:
                {
                    uint _357 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _361 = int(_357 & 2147483647u);
                    if ((_357 & 2147483648u) != 0u)
                    {
                        _407 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_361) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_361 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_361 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                    else
                    {
                        _407 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_361) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_361 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_361 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x);
                        break;
                    }
                }
            }
            _408 = _407;
            break;
        }
    }
    float3 _411 = _408 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _412 = normalize(_349);
    float _413 = _412.x;
    float _414 = _413 + _413;
    float _415 = _412.y;
    float _416 = _415 + _415;
    float _417 = _412.z;
    float _418 = _417 + _417;
    float _419 = _413 * _414;
    float _420 = _413 * _416;
    float _421 = _413 * _418;
    float _422 = _415 * _416;
    float _423 = _415 * _418;
    float _424 = _417 * _418;
    float _425 = _412.w;
    float _426 = _425 * _414;
    float _427 = _425 * _416;
    float _428 = _425 * _418;
    float3x3 _444 = float3x3(float3(1.0 - (_422 + _424), _420 + _428, _421 - _427), float3(_420 - _428, 1.0 - (_419 + _424), _423 + _426), float3(_421 + _427, _423 - _426, 1.0 - (_419 + _422)));
    float3x3 _678;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _452 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _554;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _530;
                if (_194)
                {
                    _530 = select(float3(0.0), _191.xyz / float3(_193), bool3(_194)).xyz;
                }
                else
                {
                    float3 _528;
                    switch (0u)
                    {
                        default:
                        {
                            if (_452)
                            {
                                _528 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _528 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _530 = _528;
                }
                _554 = _530;
                break;
            }
            case 2u:
            {
                float3 _479;
                switch (0u)
                {
                    default:
                    {
                        if (_452)
                        {
                            _479 = (((Primitive.Primitive_LocalToWorld[0].xyz * _278.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _278.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _278.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _479 = _278;
                        break;
                    }
                }
                float3 _481 = normalize(View.View_WorldCameraOrigin - _479);
                float3 _503;
                switch (0u)
                {
                    default:
                    {
                        if (_452)
                        {
                            _503 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _481;
                            break;
                        }
                        _503 = _481;
                        break;
                    }
                }
                _554 = _503;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _531 = -View.View_ViewForward;
                float3 _553;
                switch (0u)
                {
                    default:
                    {
                        if (_452)
                        {
                            _553 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _531;
                            break;
                        }
                        _553 = _531;
                        break;
                    }
                }
                _554 = _553;
                break;
            }
        }
        float3 _673;
        float3 _674;
        float3 _675;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _605 = !_452;
            bool _607 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _605);
            float3 _658;
            if (_607 && _452)
            {
                _658 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _640;
                if ((!_607) && _605)
                {
                    _640 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _640 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _658 = _640;
            }
            float3 _669;
            if (abs(dot(_554, _658)) > 0.9900000095367431640625)
            {
                _669 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_658.z) > 0.9900000095367431640625));
            }
            else
            {
                _669 = _554;
            }
            float3 _671 = normalize(cross(_658, _669));
            _673 = _658;
            _674 = _671;
            _675 = cross(_671, _658);
        }
        else
        {
            float3 _575;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _575 = View.View_ViewUp;
            }
            else
            {
                _575 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_554.z))), bool3(abs(_554.z) > 0.9900000095367431640625));
            }
            float3 _597;
            switch (0u)
            {
                default:
                {
                    if (_452)
                    {
                        _597 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _575;
                        break;
                    }
                    _597 = _575;
                    break;
                }
            }
            float3 _599 = normalize(cross(_597, _554));
            _673 = cross(_554, _599);
            _674 = _599;
            _675 = _554;
        }
        _678 = float3x3(_675, _674, _673) * _444;
    }
    else
    {
        _678 = _444;
    }
    bool _683;
    float3 _703;
    switch (0u)
    {
        default:
        {
            _683 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_683)
            {
                _703 = (((Primitive.Primitive_LocalToWorld[0].xyz * _278.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _278.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _278.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _703 = _278;
            break;
        }
    }
    float _736;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _736 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _735;
            switch (0u)
            {
                default:
                {
                    uint _711 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _715 = int(_711 & 2147483647u);
                    if ((_711 & 2147483648u) != 0u)
                    {
                        _735 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_715) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x;
                        break;
                    }
                    else
                    {
                        _735 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_715) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _200))).x;
                        break;
                    }
                }
            }
            _736 = _735;
            break;
        }
    }
    float3 _738 = normalize(View.View_WorldCameraOrigin - _703);
    float3 _760;
    switch (0u)
    {
        default:
        {
            if (_683)
            {
                _760 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _738;
                break;
            }
            _760 = _738;
            break;
        }
    }
    float3 _762 = _278 + (_760 * _736);
    bool _765 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _774;
    if (!_765)
    {
        _774 = _762 + (_678 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _408));
    }
    else
    {
        _774 = _762;
    }
    float3x3 _782 = _678 * float3x3(float3(_411.x, 0.0, 0.0), float3(0.0, _411.y, 0.0), float3(0.0, 0.0, _411.z));
    float4 _801 = float4(_774, 1.0);
    float4x4 _802 = float4x4(float4(_782[0], 0.0), float4(_782[1], 0.0), float4(_782[2], 0.0), _801);
    float3x3 _803 = _678 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _819 = float4x4(float4(_803[0], 0.0), float4(_803[1], 0.0), float4(_803[2], 0.0), _801);
    float4x4 _844;
    float4x4 _845;
    if (_683)
    {
        float4x4 _823 = Primitive.Primitive_LocalToWorld * _819;
        float4 _827 = _823[0];
        float3 _829 = _827.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _831 = _823;
        _831[0] = float4(_829.x, _829.y, _829.z, _827.w);
        float4 _833 = _823[1];
        float3 _835 = _833.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _837 = _831;
        _837[1] = float4(_835.x, _835.y, _835.z, _833.w);
        float4 _839 = _823[2];
        float3 _841 = _839.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _843 = _837;
        _843[2] = float4(_841.x, _841.y, _841.z, _839.w);
        _844 = _843;
        _845 = Primitive.Primitive_LocalToWorld * _802;
    }
    else
    {
        _844 = _819;
        _845 = _802;
    }
    float4x4 _855;
    if (_765)
    {
        float3 _852 = _845[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _854 = _845;
        _854[3] = float4(_852.x, _852.y, _852.z, _845[3].w);
        _855 = _854;
    }
    else
    {
        _855 = _845;
    }
    for (int _857 = 0; _857 < 1; )
    {
        _102[_857] = _101[_857];
        _857++;
        continue;
    }
    float4 _866 = _855 * in.in_var_ATTRIBUTE0;
    float3 _867 = _866.xyz;
    float3 _868 = _867 + View.View_PreViewTranslation;
    float _870 = _868.x;
    float _871 = _868.y;
    float _872 = _868.z;
    float4 _873 = float4(_870, _871, _872, in.in_var_ATTRIBUTE0.w);
    spvUnsafeArray<float2, 1> _100;
    _100 = _102;
    spvUnsafeArray<float2, 1> _103 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _875 = 0; _875 < 1; )
    {
        _103[_875] = _100[_875];
        _875++;
        continue;
    }
    float4 _884 = float4(_873.x, _873.y, _873.z, _873.w);
    float4 _887 = View.View_TranslatedWorldToClip * _884;
    float4 _890 = _85;
    _890.w = 0.0;
    float3x3 _892 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _892[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _895 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _896 = _892;
    _896[1] = _895;
    float3x3 _899 = _896;
    _899[0] = cross(_895, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _907 = float3x3(_844[0].xyz, _844[1].xyz, _844[2].xyz) * _899;
    float3 _909 = normalize(_907[0]);
    spvUnsafeArray<float4, 1> _920 = { float4(_103[0].x, _103[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_909.x, _909.y, _909.z, _890.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_907[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _920;
    out.out_var_TEXCOORD6 = _884;
    out.gl_Position = _887;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

