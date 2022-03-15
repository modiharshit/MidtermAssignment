

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

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00005a1a_232d40ed(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _114;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _114 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _114 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _177;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _177 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _176;
            switch (0u)
            {
                default:
                {
                    uint _126 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _130 = int(_126 & 2147483647u);
                    if ((_126 & 2147483648u) != 0u)
                    {
                        _176 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_130) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_130 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_130 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x);
                        break;
                    }
                    else
                    {
                        _176 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_130) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_130 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_130 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _114))).x);
                        break;
                    }
                }
            }
            _177 = _176;
            break;
        }
    }
    float _179 = length(_177.xyz);
    bool _180 = _179 > 0.0;
    uint _186 = uint(int(_114));
    float3 _264;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _264 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _263;
            switch (0u)
            {
                default:
                {
                    uint _213 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _217 = int(_213 & 2147483647u);
                    if ((_213 & 2147483648u) != 0u)
                    {
                        _263 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_217) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_217 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_217 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                    else
                    {
                        _263 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_217) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_217 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_217 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                }
            }
            _264 = _263;
            break;
        }
    }
    float4 _335;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _335 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _334;
            switch (0u)
            {
                default:
                {
                    uint _272 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _276 = int(_272 & 2147483647u);
                    if ((_272 & 2147483648u) != 0u)
                    {
                        _334 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_276) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_276 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_276 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_276 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                    else
                    {
                        _334 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_276) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_276 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_276 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_276 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                }
            }
            _335 = _334;
            break;
        }
    }
    float3 _394;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _394 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _393;
            switch (0u)
            {
                default:
                {
                    uint _343 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _347 = int(_343 & 2147483647u);
                    if ((_343 & 2147483648u) != 0u)
                    {
                        _393 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_347) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_347 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_347 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                    else
                    {
                        _393 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_347) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_347 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_347 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x);
                        break;
                    }
                }
            }
            _394 = _393;
            break;
        }
    }
    float3 _397 = _394 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _398 = normalize(_335);
    float _399 = _398.x;
    float _400 = _399 + _399;
    float _401 = _398.y;
    float _402 = _401 + _401;
    float _403 = _398.z;
    float _404 = _403 + _403;
    float _405 = _399 * _400;
    float _406 = _399 * _402;
    float _407 = _399 * _404;
    float _408 = _401 * _402;
    float _409 = _401 * _404;
    float _410 = _403 * _404;
    float _411 = _398.w;
    float _412 = _411 * _400;
    float _413 = _411 * _402;
    float _414 = _411 * _404;
    float3x3 _430 = float3x3(float3(1.0 - (_408 + _410), _406 + _414, _407 - _413), float3(_406 - _414, 1.0 - (_405 + _410), _409 + _412), float3(_407 + _413, _409 - _412, 1.0 - (_405 + _408)));
    float3x3 _664;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _438 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _540;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _516;
                if (_180)
                {
                    _516 = select(float3(0.0), _177.xyz / float3(_179), bool3(_180)).xyz;
                }
                else
                {
                    float3 _514;
                    switch (0u)
                    {
                        default:
                        {
                            if (_438)
                            {
                                _514 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _514 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _516 = _514;
                }
                _540 = _516;
                break;
            }
            case 2u:
            {
                float3 _465;
                switch (0u)
                {
                    default:
                    {
                        if (_438)
                        {
                            _465 = (((Primitive.Primitive_LocalToWorld[0].xyz * _264.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _264.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _264.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _465 = _264;
                        break;
                    }
                }
                float3 _467 = normalize(View.View_WorldCameraOrigin - _465);
                float3 _489;
                switch (0u)
                {
                    default:
                    {
                        if (_438)
                        {
                            _489 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _467;
                            break;
                        }
                        _489 = _467;
                        break;
                    }
                }
                _540 = _489;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _517 = -View.View_ViewForward;
                float3 _539;
                switch (0u)
                {
                    default:
                    {
                        if (_438)
                        {
                            _539 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _517;
                            break;
                        }
                        _539 = _517;
                        break;
                    }
                }
                _540 = _539;
                break;
            }
        }
        float3 _659;
        float3 _660;
        float3 _661;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _591 = !_438;
            bool _593 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _591);
            float3 _644;
            if (_593 && _438)
            {
                _644 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _626;
                if ((!_593) && _591)
                {
                    _626 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _626 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _644 = _626;
            }
            float3 _655;
            if (abs(dot(_540, _644)) > 0.9900000095367431640625)
            {
                _655 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_644.z) > 0.9900000095367431640625));
            }
            else
            {
                _655 = _540;
            }
            float3 _657 = normalize(cross(_644, _655));
            _659 = _644;
            _660 = _657;
            _661 = cross(_657, _644);
        }
        else
        {
            float3 _561;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _561 = View.View_ViewUp;
            }
            else
            {
                _561 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_540.z))), bool3(abs(_540.z) > 0.9900000095367431640625));
            }
            float3 _583;
            switch (0u)
            {
                default:
                {
                    if (_438)
                    {
                        _583 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _561;
                        break;
                    }
                    _583 = _561;
                    break;
                }
            }
            float3 _585 = normalize(cross(_583, _540));
            _659 = cross(_540, _585);
            _660 = _585;
            _661 = _540;
        }
        _664 = float3x3(_661, _660, _659) * _430;
    }
    else
    {
        _664 = _430;
    }
    bool _669;
    float3 _689;
    switch (0u)
    {
        default:
        {
            _669 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_669)
            {
                _689 = (((Primitive.Primitive_LocalToWorld[0].xyz * _264.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _264.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _264.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _689 = _264;
            break;
        }
    }
    float _722;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _722 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _721;
            switch (0u)
            {
                default:
                {
                    uint _697 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _701 = int(_697 & 2147483647u);
                    if ((_697 & 2147483648u) != 0u)
                    {
                        _721 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_701) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x;
                        break;
                    }
                    else
                    {
                        _721 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_701) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _186))).x;
                        break;
                    }
                }
            }
            _722 = _721;
            break;
        }
    }
    float3 _724 = normalize(View.View_WorldCameraOrigin - _689);
    float3 _746;
    switch (0u)
    {
        default:
        {
            if (_669)
            {
                _746 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _724;
                break;
            }
            _746 = _724;
            break;
        }
    }
    float3 _748 = _264 + (_746 * _722);
    bool _751 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _760;
    if (!_751)
    {
        _760 = _748 + (_664 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _394));
    }
    else
    {
        _760 = _748;
    }
    float3x3 _768 = _664 * float3x3(float3(_397.x, 0.0, 0.0), float3(0.0, _397.y, 0.0), float3(0.0, 0.0, _397.z));
    float4x4 _788 = float4x4(float4(_768[0], 0.0), float4(_768[1], 0.0), float4(_768[2], 0.0), float4(_760, 1.0));
    float4x4 _792;
    if (_669)
    {
        _792 = Primitive.Primitive_LocalToWorld * _788;
    }
    else
    {
        _792 = _788;
    }
    float4x4 _802;
    if (_751)
    {
        float3 _799 = _792[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _801 = _792;
        _801[3] = float4(_799.x, _799.y, _799.z, _792[3].w);
        _802 = _801;
    }
    else
    {
        _802 = _792;
    }
    float4 _810 = float4((_802 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _818 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_810.x, _810.y, _810.z, _810.w);
    float4 _829;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_818.z < 0.0))
    {
        float4 _827 = _818;
        _827.z = 9.9999999747524270787835121154785e-07;
        float4 _828 = _827;
        _828.w = 1.0;
        _829 = _828;
    }
    else
    {
        _829 = _818;
    }
    float _835 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _802[2].xyz));
    out.out_var_TEXCOORD6 = _829.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_835) > 0.0) ? (sqrt(fast::clamp(1.0 - (_835 * _835), 0.0, 1.0)) / _835) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _829;
    return out;
}

