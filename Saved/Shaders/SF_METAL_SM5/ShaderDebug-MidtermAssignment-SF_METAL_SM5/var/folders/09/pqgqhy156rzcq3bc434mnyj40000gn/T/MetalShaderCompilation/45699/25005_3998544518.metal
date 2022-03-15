

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
    char _m5_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m6_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m7_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[80];
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_NiagaraMeshVF
{
    uint NiagaraMeshVF_bLocalSpace;
    char _m1_pad[12];
    packed_float3 NiagaraMeshVF_PivotOffset;
    int NiagaraMeshVF_bPivotOffsetIsWorldSpace;
    float3 NiagaraMeshVF_MeshScale;
    char _m4_pad[24];
    float NiagaraMeshVF_DeltaSeconds;
    char _m5_pad[4];
    int NiagaraMeshVF_SortedIndicesOffset;
    int NiagaraMeshVF_PositionDataOffset;
    char _m7_pad[4];
    int NiagaraMeshVF_VelocityDataOffset;
    char _m8_pad[8];
    int NiagaraMeshVF_RotationDataOffset;
    char _m9_pad[4];
    int NiagaraMeshVF_ScaleDataOffset;
    char _m10_pad[32];
    int NiagaraMeshVF_CameraOffsetDataOffset;
    float4 NiagaraMeshVF_DefaultPos;
    char _m12_pad[16];
    float3 NiagaraMeshVF_DefaultVelocity;
    char _m13_pad[32];
    float4 NiagaraMeshVF_DefaultRotation;
    char _m14_pad[16];
    float3 NiagaraMeshVF_DefaultScale;
    char _m15_pad[92];
    float NiagaraMeshVF_DefaultCamOffset;
    char _m16_pad[8];
    uint NiagaraMeshVF_FacingMode;
    uint NiagaraMeshVF_bLockedAxisEnable;
    packed_float3 NiagaraMeshVF_LockedAxis;
    uint NiagaraMeshVF_LockedAxisSpace;
    uint NiagaraMeshVF_NiagaraFloatDataStride;
};

constant float4 _76 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
};

vertex MainVertexShader_out Main_000061ad_ee54f286(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _121;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _121 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _121 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _184;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _184 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _183;
            switch (0u)
            {
                default:
                {
                    uint _133 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _137 = int(_133 & 2147483647u);
                    if ((_133 & 2147483648u) != 0u)
                    {
                        _183 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_137) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_137 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_137 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x);
                        break;
                    }
                    else
                    {
                        _183 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_137) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_137 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_137 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _121))).x);
                        break;
                    }
                }
            }
            _184 = _183;
            break;
        }
    }
    float _186 = length(_184.xyz);
    bool _187 = _186 > 0.0;
    float3 _191 = select(float3(0.0), _184.xyz / float3(_186), bool3(_187));
    uint _193 = uint(int(_121));
    float3 _271;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _271 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _270;
            switch (0u)
            {
                default:
                {
                    uint _220 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _224 = int(_220 & 2147483647u);
                    if ((_220 & 2147483648u) != 0u)
                    {
                        _270 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_224) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_224 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_224 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                    else
                    {
                        _270 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_224) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_224 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_224 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                }
            }
            _271 = _270;
            break;
        }
    }
    float4 _342;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _342 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _341;
            switch (0u)
            {
                default:
                {
                    uint _279 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _283 = int(_279 & 2147483647u);
                    if ((_279 & 2147483648u) != 0u)
                    {
                        _341 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_283) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_283 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_283 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_283 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                    else
                    {
                        _341 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_283) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_283 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_283 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_283 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                }
            }
            _342 = _341;
            break;
        }
    }
    float3 _401;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _401 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _400;
            switch (0u)
            {
                default:
                {
                    uint _350 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _354 = int(_350 & 2147483647u);
                    if ((_350 & 2147483648u) != 0u)
                    {
                        _400 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_354) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_354 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_354 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                    else
                    {
                        _400 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_354) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_354 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_354 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x);
                        break;
                    }
                }
            }
            _401 = _400;
            break;
        }
    }
    float3 _404 = _401 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _405 = normalize(_342);
    float _406 = _405.x;
    float _407 = _406 + _406;
    float _408 = _405.y;
    float _409 = _408 + _408;
    float _410 = _405.z;
    float _411 = _410 + _410;
    float _412 = _406 * _407;
    float _413 = _406 * _409;
    float _414 = _406 * _411;
    float _415 = _408 * _409;
    float _416 = _408 * _411;
    float _417 = _410 * _411;
    float _418 = _405.w;
    float _419 = _418 * _407;
    float _420 = _418 * _409;
    float _421 = _418 * _411;
    float3x3 _437 = float3x3(float3(1.0 - (_415 + _417), _413 + _421, _414 - _420), float3(_413 - _421, 1.0 - (_412 + _417), _416 + _419), float3(_414 + _420, _416 - _419, 1.0 - (_412 + _415)));
    float3x3 _671;
    if (NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u)
    {
        bool _445 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _547;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _523;
                if (_187)
                {
                    _523 = _191.xyz;
                }
                else
                {
                    float3 _521;
                    switch (0u)
                    {
                        default:
                        {
                            if (_445)
                            {
                                _521 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _521 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _523 = _521;
                }
                _547 = _523;
                break;
            }
            case 2u:
            {
                float3 _472;
                switch (0u)
                {
                    default:
                    {
                        if (_445)
                        {
                            _472 = (((Primitive.Primitive_LocalToWorld[0].xyz * _271.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _271.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _271.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _472 = _271;
                        break;
                    }
                }
                float3 _474 = normalize(View.View_WorldCameraOrigin - _472);
                float3 _496;
                switch (0u)
                {
                    default:
                    {
                        if (_445)
                        {
                            _496 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _474;
                            break;
                        }
                        _496 = _474;
                        break;
                    }
                }
                _547 = _496;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _524 = -View.View_ViewForward;
                float3 _546;
                switch (0u)
                {
                    default:
                    {
                        if (_445)
                        {
                            _546 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _524;
                            break;
                        }
                        _546 = _524;
                        break;
                    }
                }
                _547 = _546;
                break;
            }
        }
        float3 _666;
        float3 _667;
        float3 _668;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _598 = !_445;
            bool _600 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _598);
            float3 _651;
            if (_600 && _445)
            {
                _651 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _633;
                if ((!_600) && _598)
                {
                    _633 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _633 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _651 = _633;
            }
            float3 _662;
            if (abs(dot(_547, _651)) > 0.9900000095367431640625)
            {
                _662 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_651.z) > 0.9900000095367431640625));
            }
            else
            {
                _662 = _547;
            }
            float3 _664 = normalize(cross(_651, _662));
            _666 = _651;
            _667 = _664;
            _668 = cross(_664, _651);
        }
        else
        {
            float3 _568;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _568 = View.View_ViewUp;
            }
            else
            {
                _568 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_547.z))), bool3(abs(_547.z) > 0.9900000095367431640625));
            }
            float3 _590;
            switch (0u)
            {
                default:
                {
                    if (_445)
                    {
                        _590 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _568;
                        break;
                    }
                    _590 = _568;
                    break;
                }
            }
            float3 _592 = normalize(cross(_590, _547));
            _666 = cross(_547, _592);
            _667 = _592;
            _668 = _547;
        }
        _671 = float3x3(_668, _667, _666) * _437;
    }
    else
    {
        _671 = _437;
    }
    bool _676;
    float3 _696;
    switch (0u)
    {
        default:
        {
            _676 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_676)
            {
                _696 = (((Primitive.Primitive_LocalToWorld[0].xyz * _271.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _271.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _271.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _696 = _271;
            break;
        }
    }
    float _729;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _729 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _728;
            switch (0u)
            {
                default:
                {
                    uint _704 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _708 = int(_704 & 2147483647u);
                    if ((_704 & 2147483648u) != 0u)
                    {
                        _728 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_708) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x;
                        break;
                    }
                    else
                    {
                        _728 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_708) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _193))).x;
                        break;
                    }
                }
            }
            _729 = _728;
            break;
        }
    }
    float3 _731 = normalize(View.View_WorldCameraOrigin - _696);
    float3 _753;
    switch (0u)
    {
        default:
        {
            if (_676)
            {
                _753 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _731;
                break;
            }
            _753 = _731;
            break;
        }
    }
    float3 _755 = _271 + (_753 * _729);
    bool _758 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    float3 _767;
    if (!_758)
    {
        _767 = _755 + (_671 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _401));
    }
    else
    {
        _767 = _755;
    }
    float3x3 _775 = _671 * float3x3(float3(_404.x, 0.0, 0.0), float3(0.0, _404.y, 0.0), float3(0.0, 0.0, _404.z));
    float4 _794 = float4(_767, 1.0);
    float4x4 _795 = float4x4(float4(_775[0], 0.0), float4(_775[1], 0.0), float4(_775[2], 0.0), _794);
    float3x3 _796 = _671 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _812 = float4x4(float4(_796[0], 0.0), float4(_796[1], 0.0), float4(_796[2], 0.0), _794);
    float3 _819 = _794.xyz - ((_191.xyz * _186) * NiagaraMeshVF.NiagaraMeshVF_DeltaSeconds);
    float4x4 _821 = _795;
    _821[3] = float4(_819.x, _819.y, _819.z, _794.w);
    float4x4 _849;
    float4x4 _850;
    float4x4 _851;
    if (_676)
    {
        float4x4 _828 = Primitive.Primitive_LocalToWorld * _812;
        float4 _832 = _828[0];
        float3 _834 = _832.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _836 = _828;
        _836[0] = float4(_834.x, _834.y, _834.z, _832.w);
        float4 _838 = _828[1];
        float3 _840 = _838.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _842 = _836;
        _842[1] = float4(_840.x, _840.y, _840.z, _838.w);
        float4 _844 = _828[2];
        float3 _846 = _844.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _848 = _842;
        _848[2] = float4(_846.x, _846.y, _846.z, _844.w);
        _849 = _848;
        _850 = Primitive.Primitive_PreviousLocalToWorld * _821;
        _851 = Primitive.Primitive_LocalToWorld * _795;
    }
    else
    {
        _849 = _812;
        _850 = _821;
        _851 = _795;
    }
    float4x4 _866;
    float4x4 _867;
    if (_758)
    {
        float3 _858 = _851[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _860 = _851;
        _860[3] = float4(_858.x, _858.y, _858.z, _851[3].w);
        float3 _863 = _850[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _865 = _850;
        _865[3] = float4(_863.x, _863.y, _863.z, _850[3].w);
        _866 = _860;
        _867 = _865;
    }
    else
    {
        _866 = _851;
        _867 = _850;
    }
    float4 _874 = _76;
    _874.w = 0.0;
    float3x3 _876 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _876[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _879 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _880 = _876;
    _880[1] = _879;
    float3x3 _883 = _880;
    _883[0] = cross(_879, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _891 = float3x3(_849[0].xyz, _849[1].xyz, _849[2].xyz) * _883;
    float3 _893 = normalize(_891[0]);
    float4 _913 = View.View_TranslatedWorldToClip * float4((_866 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, 1.0);
    float4 _922 = _913;
    _922.z = _913.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _913.w) : 0.0);
    out.gl_Position = _922;
    out.out_var_TEXCOORD6 = _913;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_867 * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_893.x, _893.y, _893.z, _874.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_891[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

