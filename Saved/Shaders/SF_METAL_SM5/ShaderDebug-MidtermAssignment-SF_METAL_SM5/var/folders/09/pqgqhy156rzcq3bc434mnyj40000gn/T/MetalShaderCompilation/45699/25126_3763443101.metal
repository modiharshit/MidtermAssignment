

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

constant float4 _82 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00006226_e051959d(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
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
    float4 _792 = float4(_765, 1.0);
    float4x4 _793 = float4x4(float4(_773[0], 0.0), float4(_773[1], 0.0), float4(_773[2], 0.0), _792);
    float3x3 _794 = _669 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _810 = float4x4(float4(_794[0], 0.0), float4(_794[1], 0.0), float4(_794[2], 0.0), _792);
    float4x4 _835;
    float4x4 _836;
    if (_674)
    {
        float4x4 _814 = Primitive.Primitive_LocalToWorld * _810;
        float4 _818 = _814[0];
        float3 _820 = _818.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _822 = _814;
        _822[0] = float4(_820.x, _820.y, _820.z, _818.w);
        float4 _824 = _814[1];
        float3 _826 = _824.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _828 = _822;
        _828[1] = float4(_826.x, _826.y, _826.z, _824.w);
        float4 _830 = _814[2];
        float3 _832 = _830.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _834 = _828;
        _834[2] = float4(_832.x, _832.y, _832.z, _830.w);
        _835 = _834;
        _836 = Primitive.Primitive_LocalToWorld * _793;
    }
    else
    {
        _835 = _810;
        _836 = _793;
    }
    float4x4 _846;
    if (_756)
    {
        float3 _843 = _836[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _845 = _836;
        _845[3] = float4(_843.x, _843.y, _843.z, _836[3].w);
        _846 = _845;
    }
    else
    {
        _846 = _836;
    }
    float4 _854 = float4((_846 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _862 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_854.x, _854.y, _854.z, _854.w);
    float4 _873;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_862.z < 0.0))
    {
        float4 _871 = _862;
        _871.z = 9.9999999747524270787835121154785e-07;
        float4 _872 = _871;
        _872.w = 1.0;
        _873 = _872;
    }
    else
    {
        _873 = _862;
    }
    float _879 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _846[2].xyz));
    float4 _904 = _873;
    _904.z = ((_873.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_879) > 0.0) ? (sqrt(fast::clamp(1.0 - (_879 * _879), 0.0, 1.0)) / _879) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _873.w;
    float4 _905 = _82;
    _905.w = 0.0;
    float3x3 _907 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _907[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _910 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _911 = _907;
    _911[1] = _910;
    float3x3 _914 = _911;
    _914[0] = cross(_910, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _922 = float3x3(_835[0].xyz, _835[1].xyz, _835[2].xyz) * _914;
    float3 _924 = normalize(_922[0]);
    out.out_var_TEXCOORD10_centroid = float4(_924.x, _924.y, _924.z, _905.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_922[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _854.xyz;
    out.gl_Position = _904;
    return out;
}

