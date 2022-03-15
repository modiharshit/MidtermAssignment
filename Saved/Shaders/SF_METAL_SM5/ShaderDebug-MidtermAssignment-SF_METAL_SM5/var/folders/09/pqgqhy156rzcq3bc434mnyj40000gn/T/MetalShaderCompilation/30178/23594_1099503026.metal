

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

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00005c2a_418915b2(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _119;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _119 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _119 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _182;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _182 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _181;
            switch (0u)
            {
                default:
                {
                    uint _131 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _135 = int(_131 & 2147483647u);
                    if ((_131 & 2147483648u) != 0u)
                    {
                        _181 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_135) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_135 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_135 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x);
                        break;
                    }
                    else
                    {
                        _181 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_135) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_135 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_135 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _119))).x);
                        break;
                    }
                }
            }
            _182 = _181;
            break;
        }
    }
    float _184 = length(_182.xyz);
    bool _185 = _184 > 0.0;
    uint _191 = uint(int(_119));
    float3 _269;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _269 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _268;
            switch (0u)
            {
                default:
                {
                    uint _218 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _222 = int(_218 & 2147483647u);
                    if ((_218 & 2147483648u) != 0u)
                    {
                        _268 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_222) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_222 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_222 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                    else
                    {
                        _268 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_222) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_222 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_222 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                }
            }
            _269 = _268;
            break;
        }
    }
    float4 _340;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _340 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _339;
            switch (0u)
            {
                default:
                {
                    uint _277 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _281 = int(_277 & 2147483647u);
                    if ((_277 & 2147483648u) != 0u)
                    {
                        _339 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_281) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_281 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_281 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_281 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                    else
                    {
                        _339 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_281) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_281 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_281 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_281 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                }
            }
            _340 = _339;
            break;
        }
    }
    float3 _399;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _399 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _398;
            switch (0u)
            {
                default:
                {
                    uint _348 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _352 = int(_348 & 2147483647u);
                    if ((_348 & 2147483648u) != 0u)
                    {
                        _398 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_352) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_352 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_352 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                    else
                    {
                        _398 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_352) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_352 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_352 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x);
                        break;
                    }
                }
            }
            _399 = _398;
            break;
        }
    }
    float3 _402 = _399 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _403 = normalize(_340);
    float _404 = _403.x;
    float _405 = _404 + _404;
    float _406 = _403.y;
    float _407 = _406 + _406;
    float _408 = _403.z;
    float _409 = _408 + _408;
    float _410 = _404 * _405;
    float _411 = _404 * _407;
    float _412 = _404 * _409;
    float _413 = _406 * _407;
    float _414 = _406 * _409;
    float _415 = _408 * _409;
    float _416 = _403.w;
    float _417 = _416 * _405;
    float _418 = _416 * _407;
    float _419 = _416 * _409;
    float3x3 _435 = float3x3(float3(1.0 - (_413 + _415), _411 + _419, _412 - _418), float3(_411 - _419, 1.0 - (_410 + _415), _414 + _417), float3(_412 + _418, _414 - _417, 1.0 - (_410 + _413)));
    float3x3 _669;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _443 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _545;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _521;
                if (_185)
                {
                    _521 = select(float3(0.0), _182.xyz / float3(_184), bool3(_185)).xyz;
                }
                else
                {
                    float3 _519;
                    switch (0u)
                    {
                        default:
                        {
                            if (_443)
                            {
                                _519 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _519 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _521 = _519;
                }
                _545 = _521;
                break;
            }
            case 2u:
            {
                float3 _470;
                switch (0u)
                {
                    default:
                    {
                        if (_443)
                        {
                            _470 = (((Primitive.Primitive_LocalToWorld[0].xyz * _269.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _269.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _269.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _470 = _269;
                        break;
                    }
                }
                float3 _472 = normalize(View.View_WorldCameraOrigin - _470);
                float3 _494;
                switch (0u)
                {
                    default:
                    {
                        if (_443)
                        {
                            _494 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _472;
                            break;
                        }
                        _494 = _472;
                        break;
                    }
                }
                _545 = _494;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _522 = -View.View_ViewForward;
                float3 _544;
                switch (0u)
                {
                    default:
                    {
                        if (_443)
                        {
                            _544 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _522;
                            break;
                        }
                        _544 = _522;
                        break;
                    }
                }
                _545 = _544;
                break;
            }
        }
        float3 _664;
        float3 _665;
        float3 _666;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _596 = !_443;
            bool _598 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _596);
            float3 _649;
            if (_598 && _443)
            {
                _649 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _631;
                if ((!_598) && _596)
                {
                    _631 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _631 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _649 = _631;
            }
            float3 _660;
            if (abs(dot(_545, _649)) > 0.9900000095367431640625)
            {
                _660 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_649.z) > 0.9900000095367431640625));
            }
            else
            {
                _660 = _545;
            }
            float3 _662 = normalize(cross(_649, _660));
            _664 = _649;
            _665 = _662;
            _666 = cross(_662, _649);
        }
        else
        {
            float3 _566;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _566 = View.View_ViewUp;
            }
            else
            {
                _566 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_545.z))), bool3(abs(_545.z) > 0.9900000095367431640625));
            }
            float3 _588;
            switch (0u)
            {
                default:
                {
                    if (_443)
                    {
                        _588 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _566;
                        break;
                    }
                    _588 = _566;
                    break;
                }
            }
            float3 _590 = normalize(cross(_588, _545));
            _664 = cross(_545, _590);
            _665 = _590;
            _666 = _545;
        }
        _669 = float3x3(_666, _665, _664) * _435;
    }
    else
    {
        _669 = _435;
    }
    bool _674;
    float3 _694;
    switch (0u)
    {
        default:
        {
            _674 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_674)
            {
                _694 = (((Primitive.Primitive_LocalToWorld[0].xyz * _269.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _269.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _269.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _694 = _269;
            break;
        }
    }
    float _727;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _727 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _726;
            switch (0u)
            {
                default:
                {
                    uint _702 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _706 = int(_702 & 2147483647u);
                    if ((_702 & 2147483648u) != 0u)
                    {
                        _726 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_706) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x;
                        break;
                    }
                    else
                    {
                        _726 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_706) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _191))).x;
                        break;
                    }
                }
            }
            _727 = _726;
            break;
        }
    }
    float3 _729 = normalize(View.View_WorldCameraOrigin - _694);
    float3 _751;
    switch (0u)
    {
        default:
        {
            if (_674)
            {
                _751 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _729;
                break;
            }
            _751 = _729;
            break;
        }
    }
    float3 _753 = _269 + (_751 * _727);
    bool _756 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _765;
    if (!_756)
    {
        _765 = _753 + (_669 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _399));
    }
    else
    {
        _765 = _753;
    }
    float3x3 _773 = _669 * float3x3(float3(_402.x, 0.0, 0.0), float3(0.0, _402.y, 0.0), float3(0.0, 0.0, _402.z));
    float4x4 _793 = float4x4(float4(_773[0], 0.0), float4(_773[1], 0.0), float4(_773[2], 0.0), float4(_765, 1.0));
    float4x4 _797;
    if (_674)
    {
        _797 = Primitive.Primitive_LocalToWorld * _793;
    }
    else
    {
        _797 = _793;
    }
    float4x4 _807;
    if (_756)
    {
        float3 _804 = _797[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _806 = _797;
        _806[3] = float4(_804.x, _804.y, _804.z, _797[3].w);
        _807 = _806;
    }
    else
    {
        _807 = _797;
    }
    float4 _808 = _807 * in.in_var_ATTRIBUTE0;
    float3 _809 = _808.xyz;
    float3 _810 = _809 + View.View_PreViewTranslation;
    float _812 = _810.x;
    float _813 = _810.y;
    float _814 = _810.z;
    float4 _815 = float4(_812, _813, _814, in.in_var_ATTRIBUTE0.w);
    float4 _818 = float4(_815.x, _815.y, _815.z, _815.w);
    float4 _823 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _818;
    out.out_var_TEXCOORD6 = _818;
    out.out_var_TEXCOORD8 = _807[2].xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _823;
    return out;
}

