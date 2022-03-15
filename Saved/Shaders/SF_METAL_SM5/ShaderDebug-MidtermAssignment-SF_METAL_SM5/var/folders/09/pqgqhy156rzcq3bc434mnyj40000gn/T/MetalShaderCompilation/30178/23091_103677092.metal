

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
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00005a33_062dfca4(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(6)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _113;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _113 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _113 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _176;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _176 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _175;
            switch (0u)
            {
                default:
                {
                    uint _125 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _129 = int(_125 & 2147483647u);
                    if ((_125 & 2147483648u) != 0u)
                    {
                        _175 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_129) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_129 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_129 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x);
                        break;
                    }
                    else
                    {
                        _175 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_129) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_129 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_129 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _113))).x);
                        break;
                    }
                }
            }
            _176 = _175;
            break;
        }
    }
    float _178 = length(_176.xyz);
    bool _179 = _178 > 0.0;
    uint _185 = uint(int(_113));
    float3 _263;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _263 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _262;
            switch (0u)
            {
                default:
                {
                    uint _212 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _216 = int(_212 & 2147483647u);
                    if ((_212 & 2147483648u) != 0u)
                    {
                        _262 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_216) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_216 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_216 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                    else
                    {
                        _262 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_216) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_216 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_216 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                }
            }
            _263 = _262;
            break;
        }
    }
    float4 _334;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _334 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _333;
            switch (0u)
            {
                default:
                {
                    uint _271 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _275 = int(_271 & 2147483647u);
                    if ((_271 & 2147483648u) != 0u)
                    {
                        _333 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_275) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_275 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_275 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_275 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                    else
                    {
                        _333 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_275) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_275 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_275 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_275 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                }
            }
            _334 = _333;
            break;
        }
    }
    float3 _393;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _393 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _392;
            switch (0u)
            {
                default:
                {
                    uint _342 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _346 = int(_342 & 2147483647u);
                    if ((_342 & 2147483648u) != 0u)
                    {
                        _392 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_346) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_346 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_346 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                    else
                    {
                        _392 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_346) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_346 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_346 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x);
                        break;
                    }
                }
            }
            _393 = _392;
            break;
        }
    }
    float3 _396 = _393 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _397 = normalize(_334);
    float _398 = _397.x;
    float _399 = _398 + _398;
    float _400 = _397.y;
    float _401 = _400 + _400;
    float _402 = _397.z;
    float _403 = _402 + _402;
    float _404 = _398 * _399;
    float _405 = _398 * _401;
    float _406 = _398 * _403;
    float _407 = _400 * _401;
    float _408 = _400 * _403;
    float _409 = _402 * _403;
    float _410 = _397.w;
    float _411 = _410 * _399;
    float _412 = _410 * _401;
    float _413 = _410 * _403;
    float3x3 _429 = float3x3(float3(1.0 - (_407 + _409), _405 + _413, _406 - _412), float3(_405 - _413, 1.0 - (_404 + _409), _408 + _411), float3(_406 + _412, _408 - _411, 1.0 - (_404 + _407)));
    float3x3 _663;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _437 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _539;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _515;
                if (_179)
                {
                    _515 = select(float3(0.0), _176.xyz / float3(_178), bool3(_179)).xyz;
                }
                else
                {
                    float3 _513;
                    switch (0u)
                    {
                        default:
                        {
                            if (_437)
                            {
                                _513 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _513 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _515 = _513;
                }
                _539 = _515;
                break;
            }
            case 2u:
            {
                float3 _464;
                switch (0u)
                {
                    default:
                    {
                        if (_437)
                        {
                            _464 = (((Primitive.Primitive_LocalToWorld[0].xyz * _263.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _263.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _263.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _464 = _263;
                        break;
                    }
                }
                float3 _466 = normalize(View.View_WorldCameraOrigin - _464);
                float3 _488;
                switch (0u)
                {
                    default:
                    {
                        if (_437)
                        {
                            _488 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _466;
                            break;
                        }
                        _488 = _466;
                        break;
                    }
                }
                _539 = _488;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _516 = -View.View_ViewForward;
                float3 _538;
                switch (0u)
                {
                    default:
                    {
                        if (_437)
                        {
                            _538 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _516;
                            break;
                        }
                        _538 = _516;
                        break;
                    }
                }
                _539 = _538;
                break;
            }
        }
        float3 _658;
        float3 _659;
        float3 _660;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _590 = !_437;
            bool _592 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _590);
            float3 _643;
            if (_592 && _437)
            {
                _643 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _625;
                if ((!_592) && _590)
                {
                    _625 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _625 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _643 = _625;
            }
            float3 _654;
            if (abs(dot(_539, _643)) > 0.9900000095367431640625)
            {
                _654 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_643.z) > 0.9900000095367431640625));
            }
            else
            {
                _654 = _539;
            }
            float3 _656 = normalize(cross(_643, _654));
            _658 = _643;
            _659 = _656;
            _660 = cross(_656, _643);
        }
        else
        {
            float3 _560;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _560 = View.View_ViewUp;
            }
            else
            {
                _560 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_539.z))), bool3(abs(_539.z) > 0.9900000095367431640625));
            }
            float3 _582;
            switch (0u)
            {
                default:
                {
                    if (_437)
                    {
                        _582 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _560;
                        break;
                    }
                    _582 = _560;
                    break;
                }
            }
            float3 _584 = normalize(cross(_582, _539));
            _658 = cross(_539, _584);
            _659 = _584;
            _660 = _539;
        }
        _663 = float3x3(_660, _659, _658) * _429;
    }
    else
    {
        _663 = _429;
    }
    bool _668;
    float3 _688;
    switch (0u)
    {
        default:
        {
            _668 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_668)
            {
                _688 = (((Primitive.Primitive_LocalToWorld[0].xyz * _263.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _263.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _263.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _688 = _263;
            break;
        }
    }
    float _721;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _721 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _720;
            switch (0u)
            {
                default:
                {
                    uint _696 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _700 = int(_696 & 2147483647u);
                    if ((_696 & 2147483648u) != 0u)
                    {
                        _720 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_700) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x;
                        break;
                    }
                    else
                    {
                        _720 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_700) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _185))).x;
                        break;
                    }
                }
            }
            _721 = _720;
            break;
        }
    }
    float3 _723 = normalize(View.View_WorldCameraOrigin - _688);
    float3 _745;
    switch (0u)
    {
        default:
        {
            if (_668)
            {
                _745 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _723;
                break;
            }
            _745 = _723;
            break;
        }
    }
    float3 _747 = _263 + (_745 * _721);
    bool _750 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _759;
    if (!_750)
    {
        _759 = _747 + (_663 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _393));
    }
    else
    {
        _759 = _747;
    }
    float3x3 _767 = _663 * float3x3(float3(_396.x, 0.0, 0.0), float3(0.0, _396.y, 0.0), float3(0.0, 0.0, _396.z));
    float4x4 _787 = float4x4(float4(_767[0], 0.0), float4(_767[1], 0.0), float4(_767[2], 0.0), float4(_759, 1.0));
    float4x4 _791;
    if (_668)
    {
        _791 = Primitive.Primitive_LocalToWorld * _787;
    }
    else
    {
        _791 = _787;
    }
    float4x4 _801;
    if (_750)
    {
        float3 _798 = _791[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _800 = _791;
        _800[3] = float4(_798.x, _798.y, _798.z, _791[3].w);
        _801 = _800;
    }
    else
    {
        _801 = _791;
    }
    float4 _809 = float4((_801 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, in.in_var_ATTRIBUTE0.w);
    float4 _817 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_809.x, _809.y, _809.z, _809.w);
    float4 _828;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_817.z < 0.0))
    {
        float4 _826 = _817;
        _826.z = 9.9999999747524270787835121154785e-07;
        float4 _827 = _826;
        _827.w = 1.0;
        _828 = _827;
    }
    else
    {
        _828 = _817;
    }
    float _834 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _801[2].xyz));
    float4 _859 = _828;
    _859.z = ((_828.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_834) > 0.0) ? (sqrt(fast::clamp(1.0 - (_834 * _834), 0.0, 1.0)) / _834) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _828.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _859;
    return out;
}

