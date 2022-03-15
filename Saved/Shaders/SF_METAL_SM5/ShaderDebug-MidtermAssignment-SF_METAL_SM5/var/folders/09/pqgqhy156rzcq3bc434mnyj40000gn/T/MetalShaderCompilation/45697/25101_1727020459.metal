

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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

constant float4 _83 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_0000620d_66f03dab(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _120;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _120 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _120 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _183;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _183 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _182;
            switch (0u)
            {
                default:
                {
                    uint _132 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _136 = int(_132 & 2147483647u);
                    if ((_132 & 2147483648u) != 0u)
                    {
                        _182 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_136) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_136 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_136 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x);
                        break;
                    }
                    else
                    {
                        _182 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_136) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_136 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_136 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _120))).x);
                        break;
                    }
                }
            }
            _183 = _182;
            break;
        }
    }
    float _185 = length(_183.xyz);
    bool _186 = _185 > 0.0;
    uint _192 = uint(int(_120));
    float3 _270;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _270 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _269;
            switch (0u)
            {
                default:
                {
                    uint _219 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _223 = int(_219 & 2147483647u);
                    if ((_219 & 2147483648u) != 0u)
                    {
                        _269 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_223) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_223 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_223 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                    else
                    {
                        _269 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_223) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_223 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_223 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                }
            }
            _270 = _269;
            break;
        }
    }
    float4 _341;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _341 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _340;
            switch (0u)
            {
                default:
                {
                    uint _278 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _282 = int(_278 & 2147483647u);
                    if ((_278 & 2147483648u) != 0u)
                    {
                        _340 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_282) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_282 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_282 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_282 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                    else
                    {
                        _340 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_282) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_282 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_282 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_282 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                }
            }
            _341 = _340;
            break;
        }
    }
    float3 _400;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _400 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _399;
            switch (0u)
            {
                default:
                {
                    uint _349 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _353 = int(_349 & 2147483647u);
                    if ((_349 & 2147483648u) != 0u)
                    {
                        _399 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_353) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_353 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_353 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                    else
                    {
                        _399 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_353) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_353 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_353 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x);
                        break;
                    }
                }
            }
            _400 = _399;
            break;
        }
    }
    float3 _403 = _400 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _404 = normalize(_341);
    float _405 = _404.x;
    float _406 = _405 + _405;
    float _407 = _404.y;
    float _408 = _407 + _407;
    float _409 = _404.z;
    float _410 = _409 + _409;
    float _411 = _405 * _406;
    float _412 = _405 * _408;
    float _413 = _405 * _410;
    float _414 = _407 * _408;
    float _415 = _407 * _410;
    float _416 = _409 * _410;
    float _417 = _404.w;
    float _418 = _417 * _406;
    float _419 = _417 * _408;
    float _420 = _417 * _410;
    float3x3 _436 = float3x3(float3(1.0 - (_414 + _416), _412 + _420, _413 - _419), float3(_412 - _420, 1.0 - (_411 + _416), _415 + _418), float3(_413 + _419, _415 - _418, 1.0 - (_411 + _414)));
    float3x3 _670;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _444 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _546;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _522;
                if (_186)
                {
                    _522 = select(float3(0.0), _183.xyz / float3(_185), bool3(_186)).xyz;
                }
                else
                {
                    float3 _520;
                    switch (0u)
                    {
                        default:
                        {
                            if (_444)
                            {
                                _520 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _520 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _522 = _520;
                }
                _546 = _522;
                break;
            }
            case 2u:
            {
                float3 _471;
                switch (0u)
                {
                    default:
                    {
                        if (_444)
                        {
                            _471 = (((Primitive.Primitive_LocalToWorld[0].xyz * _270.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _270.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _270.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _471 = _270;
                        break;
                    }
                }
                float3 _473 = normalize(View.View_WorldCameraOrigin - _471);
                float3 _495;
                switch (0u)
                {
                    default:
                    {
                        if (_444)
                        {
                            _495 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _473;
                            break;
                        }
                        _495 = _473;
                        break;
                    }
                }
                _546 = _495;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _523 = -View.View_ViewForward;
                float3 _545;
                switch (0u)
                {
                    default:
                    {
                        if (_444)
                        {
                            _545 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _523;
                            break;
                        }
                        _545 = _523;
                        break;
                    }
                }
                _546 = _545;
                break;
            }
        }
        float3 _665;
        float3 _666;
        float3 _667;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _597 = !_444;
            bool _599 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _597);
            float3 _650;
            if (_599 && _444)
            {
                _650 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _632;
                if ((!_599) && _597)
                {
                    _632 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _632 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _650 = _632;
            }
            float3 _661;
            if (abs(dot(_546, _650)) > 0.9900000095367431640625)
            {
                _661 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_650.z) > 0.9900000095367431640625));
            }
            else
            {
                _661 = _546;
            }
            float3 _663 = normalize(cross(_650, _661));
            _665 = _650;
            _666 = _663;
            _667 = cross(_663, _650);
        }
        else
        {
            float3 _567;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _567 = View.View_ViewUp;
            }
            else
            {
                _567 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_546.z))), bool3(abs(_546.z) > 0.9900000095367431640625));
            }
            float3 _589;
            switch (0u)
            {
                default:
                {
                    if (_444)
                    {
                        _589 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _567;
                        break;
                    }
                    _589 = _567;
                    break;
                }
            }
            float3 _591 = normalize(cross(_589, _546));
            _665 = cross(_546, _591);
            _666 = _591;
            _667 = _546;
        }
        _670 = float3x3(_667, _666, _665) * _436;
    }
    else
    {
        _670 = _436;
    }
    bool _675;
    float3 _695;
    switch (0u)
    {
        default:
        {
            _675 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_675)
            {
                _695 = (((Primitive.Primitive_LocalToWorld[0].xyz * _270.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _270.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _270.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _695 = _270;
            break;
        }
    }
    float _728;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _728 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _727;
            switch (0u)
            {
                default:
                {
                    uint _703 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _707 = int(_703 & 2147483647u);
                    if ((_703 & 2147483648u) != 0u)
                    {
                        _727 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_707) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x;
                        break;
                    }
                    else
                    {
                        _727 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_707) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _192))).x;
                        break;
                    }
                }
            }
            _728 = _727;
            break;
        }
    }
    float3 _730 = normalize(View.View_WorldCameraOrigin - _695);
    float3 _752;
    switch (0u)
    {
        default:
        {
            if (_675)
            {
                _752 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _730;
                break;
            }
            _752 = _730;
            break;
        }
    }
    float3 _754 = _270 + (_752 * _728);
    bool _757 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _766;
    if (!_757)
    {
        _766 = _754 + (_670 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _400));
    }
    else
    {
        _766 = _754;
    }
    float3x3 _774 = _670 * float3x3(float3(_403.x, 0.0, 0.0), float3(0.0, _403.y, 0.0), float3(0.0, 0.0, _403.z));
    float4 _793 = float4(_766, 1.0);
    float4x4 _794 = float4x4(float4(_774[0], 0.0), float4(_774[1], 0.0), float4(_774[2], 0.0), _793);
    float3x3 _795 = _670 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _811 = float4x4(float4(_795[0], 0.0), float4(_795[1], 0.0), float4(_795[2], 0.0), _793);
    float4x4 _836;
    float4x4 _837;
    if (_675)
    {
        float4x4 _815 = Primitive.Primitive_LocalToWorld * _811;
        float4 _819 = _815[0];
        float3 _821 = _819.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _823 = _815;
        _823[0] = float4(_821.x, _821.y, _821.z, _819.w);
        float4 _825 = _815[1];
        float3 _827 = _825.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _829 = _823;
        _829[1] = float4(_827.x, _827.y, _827.z, _825.w);
        float4 _831 = _815[2];
        float3 _833 = _831.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _835 = _829;
        _835[2] = float4(_833.x, _833.y, _833.z, _831.w);
        _836 = _835;
        _837 = Primitive.Primitive_LocalToWorld * _794;
    }
    else
    {
        _836 = _811;
        _837 = _794;
    }
    float4x4 _847;
    if (_757)
    {
        float3 _844 = _837[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _846 = _837;
        _846[3] = float4(_844.x, _844.y, _844.z, _837[3].w);
        _847 = _846;
    }
    else
    {
        _847 = _837;
    }
    float4 _855 = float4((_847 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _863 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_855.x, _855.y, _855.z, _855.w);
    float4 _874;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_863.z < 0.0))
    {
        float4 _872 = _863;
        _872.z = 9.9999999747524270787835121154785e-07;
        float4 _873 = _872;
        _873.w = 1.0;
        _874 = _873;
    }
    else
    {
        _874 = _863;
    }
    float _880 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _847[2].xyz));
    float4 _899 = _83;
    _899.w = 0.0;
    float3x3 _901 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _901[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _904 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _905 = _901;
    _905[1] = _904;
    float3x3 _908 = _905;
    _908[0] = cross(_904, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _916 = float3x3(_836[0].xyz, _836[1].xyz, _836[2].xyz) * _908;
    float3 _918 = normalize(_916[0]);
    out.out_var_TEXCOORD10_centroid = float4(_918.x, _918.y, _918.z, _899.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_916[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _874.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_880) > 0.0) ? (sqrt(fast::clamp(1.0 - (_880 * _880), 0.0, 1.0)) / _880) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _855.xyz;
    out.gl_Position = _874;
    return out;
}

