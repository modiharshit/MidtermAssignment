

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000055cf_a0d1d3c6(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _109;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _109 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _109 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _172;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _172 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _171;
            switch (0u)
            {
                default:
                {
                    uint _121 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _125 = int(_121 & 2147483647u);
                    if ((_121 & 2147483648u) != 0u)
                    {
                        _171 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_125) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_125 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_125 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x);
                        break;
                    }
                    else
                    {
                        _171 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_125) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_125 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_125 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _109))).x);
                        break;
                    }
                }
            }
            _172 = _171;
            break;
        }
    }
    float _174 = length(_172.xyz);
    bool _175 = _174 > 0.0;
    uint _181 = uint(int(_109));
    float3 _259;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _259 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _258;
            switch (0u)
            {
                default:
                {
                    uint _208 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _212 = int(_208 & 2147483647u);
                    if ((_208 & 2147483648u) != 0u)
                    {
                        _258 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_212) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_212 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_212 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                    else
                    {
                        _258 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_212) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_212 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_212 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                }
            }
            _259 = _258;
            break;
        }
    }
    float4 _330;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _330 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _329;
            switch (0u)
            {
                default:
                {
                    uint _267 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _271 = int(_267 & 2147483647u);
                    if ((_267 & 2147483648u) != 0u)
                    {
                        _329 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_271) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_271 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_271 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_271 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                    else
                    {
                        _329 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_271) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_271 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_271 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_271 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                }
            }
            _330 = _329;
            break;
        }
    }
    float3 _389;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _389 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _388;
            switch (0u)
            {
                default:
                {
                    uint _338 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _342 = int(_338 & 2147483647u);
                    if ((_338 & 2147483648u) != 0u)
                    {
                        _388 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_342) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_342 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_342 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                    else
                    {
                        _388 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_342) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_342 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_342 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x);
                        break;
                    }
                }
            }
            _389 = _388;
            break;
        }
    }
    float3 _392 = _389 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _393 = normalize(_330);
    float _394 = _393.x;
    float _395 = _394 + _394;
    float _396 = _393.y;
    float _397 = _396 + _396;
    float _398 = _393.z;
    float _399 = _398 + _398;
    float _400 = _394 * _395;
    float _401 = _394 * _397;
    float _402 = _394 * _399;
    float _403 = _396 * _397;
    float _404 = _396 * _399;
    float _405 = _398 * _399;
    float _406 = _393.w;
    float _407 = _406 * _395;
    float _408 = _406 * _397;
    float _409 = _406 * _399;
    float3x3 _425 = float3x3(float3(1.0 - (_403 + _405), _401 + _409, _402 - _408), float3(_401 - _409, 1.0 - (_400 + _405), _404 + _407), float3(_402 + _408, _404 - _407, 1.0 - (_400 + _403)));
    float3x3 _659;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _433 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _535;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _511;
                if (_175)
                {
                    _511 = select(float3(0.0), _172.xyz / float3(_174), bool3(_175)).xyz;
                }
                else
                {
                    float3 _509;
                    switch (0u)
                    {
                        default:
                        {
                            if (_433)
                            {
                                _509 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _509 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _511 = _509;
                }
                _535 = _511;
                break;
            }
            case 2u:
            {
                float3 _460;
                switch (0u)
                {
                    default:
                    {
                        if (_433)
                        {
                            _460 = (((Primitive.Primitive_LocalToWorld[0].xyz * _259.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _259.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _259.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _460 = _259;
                        break;
                    }
                }
                float3 _462 = normalize(View.View_WorldCameraOrigin - _460);
                float3 _484;
                switch (0u)
                {
                    default:
                    {
                        if (_433)
                        {
                            _484 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _462;
                            break;
                        }
                        _484 = _462;
                        break;
                    }
                }
                _535 = _484;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _512 = -View.View_ViewForward;
                float3 _534;
                switch (0u)
                {
                    default:
                    {
                        if (_433)
                        {
                            _534 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _512;
                            break;
                        }
                        _534 = _512;
                        break;
                    }
                }
                _535 = _534;
                break;
            }
        }
        float3 _654;
        float3 _655;
        float3 _656;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _586 = !_433;
            bool _588 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _586);
            float3 _639;
            if (_588 && _433)
            {
                _639 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _621;
                if ((!_588) && _586)
                {
                    _621 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _621 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _639 = _621;
            }
            float3 _650;
            if (abs(dot(_535, _639)) > 0.9900000095367431640625)
            {
                _650 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_639.z) > 0.9900000095367431640625));
            }
            else
            {
                _650 = _535;
            }
            float3 _652 = normalize(cross(_639, _650));
            _654 = _639;
            _655 = _652;
            _656 = cross(_652, _639);
        }
        else
        {
            float3 _556;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _556 = View.View_ViewUp;
            }
            else
            {
                _556 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_535.z))), bool3(abs(_535.z) > 0.9900000095367431640625));
            }
            float3 _578;
            switch (0u)
            {
                default:
                {
                    if (_433)
                    {
                        _578 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _556;
                        break;
                    }
                    _578 = _556;
                    break;
                }
            }
            float3 _580 = normalize(cross(_578, _535));
            _654 = cross(_535, _580);
            _655 = _580;
            _656 = _535;
        }
        _659 = float3x3(_656, _655, _654) * _425;
    }
    else
    {
        _659 = _425;
    }
    bool _664;
    float3 _684;
    switch (0u)
    {
        default:
        {
            _664 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_664)
            {
                _684 = (((Primitive.Primitive_LocalToWorld[0].xyz * _259.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _259.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _259.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _684 = _259;
            break;
        }
    }
    float _717;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _717 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _716;
            switch (0u)
            {
                default:
                {
                    uint _692 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _696 = int(_692 & 2147483647u);
                    if ((_692 & 2147483648u) != 0u)
                    {
                        _716 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_696) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x;
                        break;
                    }
                    else
                    {
                        _716 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_696) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _181))).x;
                        break;
                    }
                }
            }
            _717 = _716;
            break;
        }
    }
    float3 _719 = normalize(View.View_WorldCameraOrigin - _684);
    float3 _741;
    switch (0u)
    {
        default:
        {
            if (_664)
            {
                _741 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _719;
                break;
            }
            _741 = _719;
            break;
        }
    }
    float3 _743 = _259 + (_741 * _717);
    bool _746 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _755;
    if (!_746)
    {
        _755 = _743 + (_659 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _389));
    }
    else
    {
        _755 = _743;
    }
    float3x3 _763 = _659 * float3x3(float3(_392.x, 0.0, 0.0), float3(0.0, _392.y, 0.0), float3(0.0, 0.0, _392.z));
    float4x4 _783 = float4x4(float4(_763[0], 0.0), float4(_763[1], 0.0), float4(_763[2], 0.0), float4(_755, 1.0));
    float4x4 _787;
    if (_664)
    {
        _787 = Primitive.Primitive_LocalToWorld * _783;
    }
    else
    {
        _787 = _783;
    }
    float4x4 _797;
    if (_746)
    {
        float3 _794 = _787[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _796 = _787;
        _796[3] = float4(_794.x, _794.y, _794.z, _787[3].w);
        _797 = _796;
    }
    else
    {
        _797 = _787;
    }
    float4 _798 = _797 * in.in_var_ATTRIBUTE0;
    float3 _799 = _798.xyz;
    float3 _800 = _799 + View.View_PreViewTranslation;
    float _802 = _800.x;
    float _803 = _800.y;
    float _804 = _800.z;
    float4 _805 = float4(_802, _803, _804, in.in_var_ATTRIBUTE0.w);
    float4 _806 = float4(_805.x, _805.y, _805.z, _805.w);
    float4 _807 = View.View_TranslatedWorldToClip * _806;
    out.gl_Position = _807;
    return out;
}

