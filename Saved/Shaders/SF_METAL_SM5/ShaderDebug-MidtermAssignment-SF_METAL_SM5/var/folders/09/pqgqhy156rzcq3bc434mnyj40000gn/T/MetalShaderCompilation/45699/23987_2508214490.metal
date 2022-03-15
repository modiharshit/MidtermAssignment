

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

constant float4 _74 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex Main_out Main_00005db3_958050da(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _112;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _112 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _112 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _175;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _175 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _174;
            switch (0u)
            {
                default:
                {
                    uint _124 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _128 = int(_124 & 2147483647u);
                    if ((_124 & 2147483648u) != 0u)
                    {
                        _174 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_128) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_128 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_128 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x);
                        break;
                    }
                    else
                    {
                        _174 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_128) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_128 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_128 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _112))).x);
                        break;
                    }
                }
            }
            _175 = _174;
            break;
        }
    }
    float _177 = length(_175.xyz);
    bool _178 = _177 > 0.0;
    uint _184 = uint(int(_112));
    float3 _262;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _262 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _261;
            switch (0u)
            {
                default:
                {
                    uint _211 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _215 = int(_211 & 2147483647u);
                    if ((_211 & 2147483648u) != 0u)
                    {
                        _261 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_215) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_215 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_215 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                    else
                    {
                        _261 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_215) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_215 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_215 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                }
            }
            _262 = _261;
            break;
        }
    }
    float4 _333;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _333 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _332;
            switch (0u)
            {
                default:
                {
                    uint _270 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _274 = int(_270 & 2147483647u);
                    if ((_270 & 2147483648u) != 0u)
                    {
                        _332 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_274) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_274 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_274 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_274 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                    else
                    {
                        _332 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_274) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_274 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_274 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_274 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                }
            }
            _333 = _332;
            break;
        }
    }
    float3 _392;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _392 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _391;
            switch (0u)
            {
                default:
                {
                    uint _341 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _345 = int(_341 & 2147483647u);
                    if ((_341 & 2147483648u) != 0u)
                    {
                        _391 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_345) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_345 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_345 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                    else
                    {
                        _391 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_345) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_345 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_345 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x);
                        break;
                    }
                }
            }
            _392 = _391;
            break;
        }
    }
    float3 _395 = _392 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _396 = normalize(_333);
    float _397 = _396.x;
    float _398 = _397 + _397;
    float _399 = _396.y;
    float _400 = _399 + _399;
    float _401 = _396.z;
    float _402 = _401 + _401;
    float _403 = _397 * _398;
    float _404 = _397 * _400;
    float _405 = _397 * _402;
    float _406 = _399 * _400;
    float _407 = _399 * _402;
    float _408 = _401 * _402;
    float _409 = _396.w;
    float _410 = _409 * _398;
    float _411 = _409 * _400;
    float _412 = _409 * _402;
    float3x3 _428 = float3x3(float3(1.0 - (_406 + _408), _404 + _412, _405 - _411), float3(_404 - _412, 1.0 - (_403 + _408), _407 + _410), float3(_405 + _411, _407 - _410, 1.0 - (_403 + _406)));
    float3x3 _662;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _436 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _538;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _514;
                if (_178)
                {
                    _514 = select(float3(0.0), _175.xyz / float3(_177), bool3(_178)).xyz;
                }
                else
                {
                    float3 _512;
                    switch (0u)
                    {
                        default:
                        {
                            if (_436)
                            {
                                _512 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _512 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _514 = _512;
                }
                _538 = _514;
                break;
            }
            case 2u:
            {
                float3 _463;
                switch (0u)
                {
                    default:
                    {
                        if (_436)
                        {
                            _463 = (((Primitive.Primitive_LocalToWorld[0].xyz * _262.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _262.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _262.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _463 = _262;
                        break;
                    }
                }
                float3 _465 = normalize(View.View_WorldCameraOrigin - _463);
                float3 _487;
                switch (0u)
                {
                    default:
                    {
                        if (_436)
                        {
                            _487 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _465;
                            break;
                        }
                        _487 = _465;
                        break;
                    }
                }
                _538 = _487;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _515 = -View.View_ViewForward;
                float3 _537;
                switch (0u)
                {
                    default:
                    {
                        if (_436)
                        {
                            _537 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _515;
                            break;
                        }
                        _537 = _515;
                        break;
                    }
                }
                _538 = _537;
                break;
            }
        }
        float3 _657;
        float3 _658;
        float3 _659;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _589 = !_436;
            bool _591 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _589);
            float3 _642;
            if (_591 && _436)
            {
                _642 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _624;
                if ((!_591) && _589)
                {
                    _624 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _624 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _642 = _624;
            }
            float3 _653;
            if (abs(dot(_538, _642)) > 0.9900000095367431640625)
            {
                _653 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_642.z) > 0.9900000095367431640625));
            }
            else
            {
                _653 = _538;
            }
            float3 _655 = normalize(cross(_642, _653));
            _657 = _642;
            _658 = _655;
            _659 = cross(_655, _642);
        }
        else
        {
            float3 _559;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _559 = View.View_ViewUp;
            }
            else
            {
                _559 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_538.z))), bool3(abs(_538.z) > 0.9900000095367431640625));
            }
            float3 _581;
            switch (0u)
            {
                default:
                {
                    if (_436)
                    {
                        _581 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _559;
                        break;
                    }
                    _581 = _559;
                    break;
                }
            }
            float3 _583 = normalize(cross(_581, _538));
            _657 = cross(_538, _583);
            _658 = _583;
            _659 = _538;
        }
        _662 = float3x3(_659, _658, _657) * _428;
    }
    else
    {
        _662 = _428;
    }
    bool _667;
    float3 _687;
    switch (0u)
    {
        default:
        {
            _667 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_667)
            {
                _687 = (((Primitive.Primitive_LocalToWorld[0].xyz * _262.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _262.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _262.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _687 = _262;
            break;
        }
    }
    float _720;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _720 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _719;
            switch (0u)
            {
                default:
                {
                    uint _695 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _699 = int(_695 & 2147483647u);
                    if ((_695 & 2147483648u) != 0u)
                    {
                        _719 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_699) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x;
                        break;
                    }
                    else
                    {
                        _719 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_699) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _184))).x;
                        break;
                    }
                }
            }
            _720 = _719;
            break;
        }
    }
    float3 _722 = normalize(View.View_WorldCameraOrigin - _687);
    float3 _744;
    switch (0u)
    {
        default:
        {
            if (_667)
            {
                _744 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _722;
                break;
            }
            _744 = _722;
            break;
        }
    }
    float3 _746 = _262 + (_744 * _720);
    bool _749 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _758;
    if (!_749)
    {
        _758 = _746 + (_662 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _392));
    }
    else
    {
        _758 = _746;
    }
    float3x3 _766 = _662 * float3x3(float3(_395.x, 0.0, 0.0), float3(0.0, _395.y, 0.0), float3(0.0, 0.0, _395.z));
    float4 _785 = float4(_758, 1.0);
    float4x4 _786 = float4x4(float4(_766[0], 0.0), float4(_766[1], 0.0), float4(_766[2], 0.0), _785);
    float3x3 _787 = _662 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _803 = float4x4(float4(_787[0], 0.0), float4(_787[1], 0.0), float4(_787[2], 0.0), _785);
    float4x4 _828;
    float4x4 _829;
    if (_667)
    {
        float4x4 _807 = Primitive.Primitive_LocalToWorld * _803;
        float4 _811 = _807[0];
        float3 _813 = _811.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _815 = _807;
        _815[0] = float4(_813.x, _813.y, _813.z, _811.w);
        float4 _817 = _807[1];
        float3 _819 = _817.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _821 = _815;
        _821[1] = float4(_819.x, _819.y, _819.z, _817.w);
        float4 _823 = _807[2];
        float3 _825 = _823.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _827 = _821;
        _827[2] = float4(_825.x, _825.y, _825.z, _823.w);
        _828 = _827;
        _829 = Primitive.Primitive_LocalToWorld * _786;
    }
    else
    {
        _828 = _803;
        _829 = _786;
    }
    float4x4 _839;
    if (_749)
    {
        float3 _836 = _829[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _838 = _829;
        _838[3] = float4(_836.x, _836.y, _836.z, _829[3].w);
        _839 = _838;
    }
    else
    {
        _839 = _829;
    }
    float4 _840 = _839 * in.in_var_ATTRIBUTE0;
    float3 _841 = _840.xyz;
    float3 _842 = _841 + View.View_PreViewTranslation;
    float _844 = _842.x;
    float _845 = _842.y;
    float _846 = _842.z;
    float4 _847 = float4(_844, _845, _846, in.in_var_ATTRIBUTE0.w);
    float4 _848 = float4(_847.x, _847.y, _847.z, _847.w);
    float4 _851 = View.View_TranslatedWorldToClip * _848;
    float4 _852 = _74;
    _852.w = 0.0;
    float3x3 _854 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _854[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _857 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _858 = _854;
    _858[1] = _857;
    float3x3 _861 = _858;
    _861[0] = cross(_857, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _869 = float3x3(_828[0].xyz, _828[1].xyz, _828[2].xyz) * _861;
    float3 _871 = normalize(_869[0]);
    out.out_var_TEXCOORD10_centroid = float4(_871.x, _871.y, _871.z, _852.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_869[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _848;
    out.gl_Position = _851;
    return out;
}

