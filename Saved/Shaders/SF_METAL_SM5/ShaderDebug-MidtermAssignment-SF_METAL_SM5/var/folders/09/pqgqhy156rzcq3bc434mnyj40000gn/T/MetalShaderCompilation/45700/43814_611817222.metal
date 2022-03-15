

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
    char _m6_pad[64];
    float4x4 View_PrevViewToTranslatedWorld;
    char _m7_pad[128];
    float3 View_PrevWorldCameraOrigin;
    char _m8_pad[16];
    float3 View_PrevPreViewTranslation;
    char _m9_pad[336];
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
    char _m4_pad[32];
    int NiagaraMeshVF_SortedIndicesOffset;
    int NiagaraMeshVF_PositionDataOffset;
    int NiagaraMeshVF_PrevPositionDataOffset;
    int NiagaraMeshVF_VelocityDataOffset;
    int NiagaraMeshVF_PrevVelocityDataOffset;
    char _m9_pad[4];
    int NiagaraMeshVF_RotationDataOffset;
    int NiagaraMeshVF_PrevRotationDataOffset;
    int NiagaraMeshVF_ScaleDataOffset;
    int NiagaraMeshVF_PrevScaleDataOffset;
    char _m13_pad[28];
    int NiagaraMeshVF_CameraOffsetDataOffset;
    int NiagaraMeshVF_PrevCameraOffsetDataOffset;
    float4 NiagaraMeshVF_DefaultPos;
    float4 NiagaraMeshVF_DefaultPrevPos;
    float3 NiagaraMeshVF_DefaultVelocity;
    float3 NiagaraMeshVF_DefaultPrevVelocity;
    char _m19_pad[16];
    float4 NiagaraMeshVF_DefaultRotation;
    float4 NiagaraMeshVF_DefaultPrevRotation;
    float3 NiagaraMeshVF_DefaultScale;
    float3 NiagaraMeshVF_DefaultPrevScale;
    char _m23_pad[76];
    float NiagaraMeshVF_DefaultCamOffset;
    float NiagaraMeshVF_DefaultPrevCamOffset;
    char _m25_pad[4];
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

vertex MainVertexShader_out Main_0000ab26_24779706(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _134;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _134 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _134 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _197;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _197 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _196;
            switch (0u)
            {
                default:
                {
                    uint _146 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _150 = int(_146 & 2147483647u);
                    if ((_146 & 2147483648u) != 0u)
                    {
                        _196 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_150) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_150 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_150 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                    else
                    {
                        _196 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_150) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_150 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_150 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _134))).x);
                        break;
                    }
                }
            }
            _197 = _196;
            break;
        }
    }
    float _199 = length(_197.xyz);
    bool _200 = _199 > 0.0;
    uint _206 = uint(int(_134));
    float3 _284;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _284 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _283;
            switch (0u)
            {
                default:
                {
                    uint _233 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _237 = int(_233 & 2147483647u);
                    if ((_233 & 2147483648u) != 0u)
                    {
                        _283 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_237) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_237 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_237 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _283 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_237) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_237 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_237 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _284 = _283;
            break;
        }
    }
    float4 _355;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _355 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _354;
            switch (0u)
            {
                default:
                {
                    uint _292 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _296 = int(_292 & 2147483647u);
                    if ((_292 & 2147483648u) != 0u)
                    {
                        _354 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_296) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_296 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_296 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_296 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _354 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_296) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_296 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_296 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_296 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _355 = _354;
            break;
        }
    }
    float3 _414;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _414 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _413;
            switch (0u)
            {
                default:
                {
                    uint _363 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _367 = int(_363 & 2147483647u);
                    if ((_363 & 2147483648u) != 0u)
                    {
                        _413 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_367) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_367 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_367 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _413 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_367) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_367 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_367 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _414 = _413;
            break;
        }
    }
    float3 _417 = _414 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _418 = normalize(_355);
    float _419 = _418.x;
    float _420 = _419 + _419;
    float _421 = _418.y;
    float _422 = _421 + _421;
    float _423 = _418.z;
    float _424 = _423 + _423;
    float _425 = _419 * _420;
    float _426 = _419 * _422;
    float _427 = _419 * _424;
    float _428 = _421 * _422;
    float _429 = _421 * _424;
    float _430 = _423 * _424;
    float _431 = _418.w;
    float _432 = _431 * _420;
    float _433 = _431 * _422;
    float _434 = _431 * _424;
    float3x3 _450 = float3x3(float3(1.0 - (_428 + _430), _426 + _434, _427 - _433), float3(_426 - _434, 1.0 - (_425 + _430), _429 + _432), float3(_427 + _433, _429 - _432, 1.0 - (_425 + _428)));
    bool _453 = NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u;
    float3x3 _684;
    if (_453)
    {
        bool _458 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _560;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _536;
                if (_200)
                {
                    _536 = select(float3(0.0), _197.xyz / float3(_199), bool3(_200)).xyz;
                }
                else
                {
                    float3 _534;
                    switch (0u)
                    {
                        default:
                        {
                            if (_458)
                            {
                                _534 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _534 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _536 = _534;
                }
                _560 = _536;
                break;
            }
            case 2u:
            {
                float3 _485;
                switch (0u)
                {
                    default:
                    {
                        if (_458)
                        {
                            _485 = (((Primitive.Primitive_LocalToWorld[0].xyz * _284.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _284.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _284.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _485 = _284;
                        break;
                    }
                }
                float3 _487 = normalize(View.View_WorldCameraOrigin - _485);
                float3 _509;
                switch (0u)
                {
                    default:
                    {
                        if (_458)
                        {
                            _509 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _487;
                            break;
                        }
                        _509 = _487;
                        break;
                    }
                }
                _560 = _509;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _537 = -View.View_ViewForward;
                float3 _559;
                switch (0u)
                {
                    default:
                    {
                        if (_458)
                        {
                            _559 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _537;
                            break;
                        }
                        _559 = _537;
                        break;
                    }
                }
                _560 = _559;
                break;
            }
        }
        float3 _679;
        float3 _680;
        float3 _681;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _611 = !_458;
            bool _613 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _611);
            float3 _664;
            if (_613 && _458)
            {
                _664 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _646;
                if ((!_613) && _611)
                {
                    _646 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _646 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _664 = _646;
            }
            float3 _675;
            if (abs(dot(_560, _664)) > 0.9900000095367431640625)
            {
                _675 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_664.z) > 0.9900000095367431640625));
            }
            else
            {
                _675 = _560;
            }
            float3 _677 = normalize(cross(_664, _675));
            _679 = _664;
            _680 = _677;
            _681 = cross(_677, _664);
        }
        else
        {
            float3 _581;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _581 = View.View_ViewUp;
            }
            else
            {
                _581 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_560.z))), bool3(abs(_560.z) > 0.9900000095367431640625));
            }
            float3 _603;
            switch (0u)
            {
                default:
                {
                    if (_458)
                    {
                        _603 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _581;
                        break;
                    }
                    _603 = _581;
                    break;
                }
            }
            float3 _605 = normalize(cross(_603, _560));
            _679 = cross(_560, _605);
            _680 = _605;
            _681 = _560;
        }
        _684 = float3x3(_681, _680, _679) * _450;
    }
    else
    {
        _684 = _450;
    }
    bool _689;
    float3 _709;
    switch (0u)
    {
        default:
        {
            _689 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_689)
            {
                _709 = (((Primitive.Primitive_LocalToWorld[0].xyz * _284.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _284.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _284.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _709 = _284;
            break;
        }
    }
    float _742;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _742 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _741;
            switch (0u)
            {
                default:
                {
                    uint _717 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _721 = int(_717 & 2147483647u);
                    if ((_717 & 2147483648u) != 0u)
                    {
                        _741 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_721) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x;
                        break;
                    }
                    else
                    {
                        _741 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_721) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x;
                        break;
                    }
                }
            }
            _742 = _741;
            break;
        }
    }
    float3 _744 = normalize(View.View_WorldCameraOrigin - _709);
    float3 _766;
    switch (0u)
    {
        default:
        {
            if (_689)
            {
                _766 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _744;
                break;
            }
            _766 = _744;
            break;
        }
    }
    float3 _768 = _284 + (_766 * _742);
    bool _771 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    bool _772 = !_771;
    float3 _780;
    if (_772)
    {
        _780 = _768 + (_684 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _414));
    }
    else
    {
        _780 = _768;
    }
    float3x3 _788 = _684 * float3x3(float3(_417.x, 0.0, 0.0), float3(0.0, _417.y, 0.0), float3(0.0, 0.0, _417.z));
    float4 _807 = float4(_780, 1.0);
    float4x4 _808 = float4x4(float4(_788[0], 0.0), float4(_788[1], 0.0), float4(_788[2], 0.0), _807);
    float3x3 _809 = _684 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _825 = float4x4(float4(_809[0], 0.0), float4(_809[1], 0.0), float4(_809[2], 0.0), _807);
    float3 _888;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevVelocityDataOffset == (-1))
            {
                _888 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevVelocity;
                break;
            }
            float3 _887;
            switch (0u)
            {
                default:
                {
                    uint _837 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevVelocityDataOffset);
                    int _841 = int(_837 & 2147483647u);
                    if ((_837 & 2147483648u) != 0u)
                    {
                        _887 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_841) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_841 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_841 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _887 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_841) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_841 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_841 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _888 = _887;
            break;
        }
    }
    float _890 = length(_888.xyz);
    bool _891 = _890 > 0.0;
    float3 _977;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevPositionDataOffset == (-1))
            {
                _977 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevPos.xyz;
                break;
            }
            float3 _976;
            switch (0u)
            {
                default:
                {
                    uint _926 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevPositionDataOffset);
                    int _930 = int(_926 & 2147483647u);
                    if ((_926 & 2147483648u) != 0u)
                    {
                        _976 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_930) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_930 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_930 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _976 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_930) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_930 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_930 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _977 = _976;
            break;
        }
    }
    float4 _1048;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevRotationDataOffset == (-1))
            {
                _1048 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevRotation;
                break;
            }
            float4 _1047;
            switch (0u)
            {
                default:
                {
                    uint _985 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevRotationDataOffset);
                    int _989 = int(_985 & 2147483647u);
                    if ((_985 & 2147483648u) != 0u)
                    {
                        _1047 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_989) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_989 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_989 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_989 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _1047 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_989) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_989 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_989 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_989 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _1048 = _1047;
            break;
        }
    }
    float3 _1107;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevScaleDataOffset == (-1))
            {
                _1107 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevScale;
                break;
            }
            float3 _1106;
            switch (0u)
            {
                default:
                {
                    uint _1056 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevScaleDataOffset);
                    int _1060 = int(_1056 & 2147483647u);
                    if ((_1056 & 2147483648u) != 0u)
                    {
                        _1106 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1060) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1060 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1060 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                    else
                    {
                        _1106 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1060) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1060 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1060 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x);
                        break;
                    }
                }
            }
            _1107 = _1106;
            break;
        }
    }
    float3 _1108 = _1107 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _1109 = normalize(_1048);
    float _1110 = _1109.x;
    float _1111 = _1110 + _1110;
    float _1112 = _1109.y;
    float _1113 = _1112 + _1112;
    float _1114 = _1109.z;
    float _1115 = _1114 + _1114;
    float _1116 = _1110 * _1111;
    float _1117 = _1110 * _1113;
    float _1118 = _1110 * _1115;
    float _1119 = _1112 * _1113;
    float _1120 = _1112 * _1115;
    float _1121 = _1114 * _1115;
    float _1122 = _1109.w;
    float _1123 = _1122 * _1111;
    float _1124 = _1122 * _1113;
    float _1125 = _1122 * _1115;
    float3x3 _1141 = float3x3(float3(1.0 - (_1119 + _1121), _1117 + _1125, _1118 - _1124), float3(_1117 - _1125, 1.0 - (_1116 + _1121), _1120 + _1123), float3(_1118 + _1124, _1120 - _1123, 1.0 - (_1116 + _1119)));
    float3x3 _1369;
    if (_453)
    {
        float3 _1245;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _1221;
                if (_891)
                {
                    _1221 = select(float3(0.0), _888.xyz / float3(_890), bool3(_891)).xyz;
                }
                else
                {
                    float3 _1219;
                    switch (0u)
                    {
                        default:
                        {
                            if (_689)
                            {
                                _1219 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _1219 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _1221 = _1219;
                }
                _1245 = _1221;
                break;
            }
            case 2u:
            {
                float3 _1170;
                switch (0u)
                {
                    default:
                    {
                        if (_689)
                        {
                            _1170 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _977.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _977.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _977.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                            break;
                        }
                        _1170 = _977;
                        break;
                    }
                }
                float3 _1172 = normalize(View.View_PrevWorldCameraOrigin - _1170);
                float3 _1194;
                switch (0u)
                {
                    default:
                    {
                        if (_689)
                        {
                            _1194 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1172;
                            break;
                        }
                        _1194 = _1172;
                        break;
                    }
                }
                _1245 = _1194;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _1222 = -View.View_PrevViewToTranslatedWorld[2].xyz;
                float3 _1244;
                switch (0u)
                {
                    default:
                    {
                        if (_689)
                        {
                            _1244 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1222;
                            break;
                        }
                        _1244 = _1222;
                        break;
                    }
                }
                _1245 = _1244;
                break;
            }
        }
        float3 _1364;
        float3 _1365;
        float3 _1366;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _1296 = !_689;
            bool _1298 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _1296);
            float3 _1349;
            if (_1298 && _689)
            {
                _1349 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _1331;
                if ((!_1298) && _1296)
                {
                    _1331 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _1331 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _1349 = _1331;
            }
            float3 _1360;
            if (abs(dot(_1245, _1349)) > 0.9900000095367431640625)
            {
                _1360 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_1349.z) > 0.9900000095367431640625));
            }
            else
            {
                _1360 = _1245;
            }
            float3 _1362 = normalize(cross(_1349, _1360));
            _1364 = _1349;
            _1365 = _1362;
            _1366 = cross(_1362, _1349);
        }
        else
        {
            float3 _1266;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _1266 = View.View_PrevViewToTranslatedWorld[1].xyz;
            }
            else
            {
                _1266 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_1245.z))), bool3(abs(_1245.z) > 0.9900000095367431640625));
            }
            float3 _1288;
            switch (0u)
            {
                default:
                {
                    if (_689)
                    {
                        _1288 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1266;
                        break;
                    }
                    _1288 = _1266;
                    break;
                }
            }
            float3 _1290 = normalize(cross(_1288, _1245));
            _1364 = cross(_1245, _1290);
            _1365 = _1290;
            _1366 = _1245;
        }
        _1369 = float3x3(_1366, _1365, _1364) * _1141;
    }
    else
    {
        _1369 = _1141;
    }
    float3 _1391;
    switch (0u)
    {
        default:
        {
            if (_689)
            {
                _1391 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _977.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _977.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _977.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                break;
            }
            _1391 = _977;
            break;
        }
    }
    float _1424;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevCameraOffsetDataOffset == (-1))
            {
                _1424 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevCamOffset;
                break;
            }
            float _1423;
            switch (0u)
            {
                default:
                {
                    uint _1399 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevCameraOffsetDataOffset);
                    int _1403 = int(_1399 & 2147483647u);
                    if ((_1399 & 2147483648u) != 0u)
                    {
                        _1423 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1403) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x;
                        break;
                    }
                    else
                    {
                        _1423 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1403) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _206))).x;
                        break;
                    }
                }
            }
            _1424 = _1423;
            break;
        }
    }
    float3 _1426 = normalize(View.View_PrevWorldCameraOrigin - _1391);
    float3 _1448;
    switch (0u)
    {
        default:
        {
            if (_689)
            {
                _1448 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1426;
                break;
            }
            _1448 = _1426;
            break;
        }
    }
    float3 _1450 = _977 + (_1448 * _1424);
    float3 _1458;
    if (_772)
    {
        _1458 = _1450 + (_1369 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _1107));
    }
    else
    {
        _1458 = _1450;
    }
    float3x3 _1466 = _1369 * float3x3(float3(_1108.x, 0.0, 0.0), float3(0.0, _1108.y, 0.0), float3(0.0, 0.0, _1108.z));
    float4x4 _1486 = float4x4(float4(_1466[0], 0.0), float4(_1466[1], 0.0), float4(_1466[2], 0.0), float4(_1458, 1.0));
    float4x4 _1512;
    float4x4 _1513;
    float4x4 _1514;
    if (_689)
    {
        float4x4 _1491 = Primitive.Primitive_LocalToWorld * _825;
        float4 _1495 = _1491[0];
        float3 _1497 = _1495.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _1499 = _1491;
        _1499[0] = float4(_1497.x, _1497.y, _1497.z, _1495.w);
        float4 _1501 = _1491[1];
        float3 _1503 = _1501.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _1505 = _1499;
        _1505[1] = float4(_1503.x, _1503.y, _1503.z, _1501.w);
        float4 _1507 = _1491[2];
        float3 _1509 = _1507.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _1511 = _1505;
        _1511[2] = float4(_1509.x, _1509.y, _1509.z, _1507.w);
        _1512 = _1511;
        _1513 = Primitive.Primitive_PreviousLocalToWorld * _1486;
        _1514 = Primitive.Primitive_LocalToWorld * _808;
    }
    else
    {
        _1512 = _825;
        _1513 = _1486;
        _1514 = _808;
    }
    float4x4 _1529;
    float4x4 _1530;
    if (_771)
    {
        float3 _1521 = _1514[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _1523 = _1514;
        _1523[3] = float4(_1521.x, _1521.y, _1521.z, _1514[3].w);
        float3 _1526 = _1513[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _1528 = _1513;
        _1528[3] = float4(_1526.x, _1526.y, _1526.z, _1513[3].w);
        _1529 = _1523;
        _1530 = _1528;
    }
    else
    {
        _1529 = _1514;
        _1530 = _1513;
    }
    float4 _1537 = _76;
    _1537.w = 0.0;
    float3x3 _1539 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _1539[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _1542 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _1543 = _1539;
    _1543[1] = _1542;
    float3x3 _1546 = _1543;
    _1546[0] = cross(_1542, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _1554 = float3x3(_1512[0].xyz, _1512[1].xyz, _1512[2].xyz) * _1546;
    float3 _1556 = normalize(_1554[0]);
    float4 _1576 = View.View_TranslatedWorldToClip * float4((_1529 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, 1.0);
    float4 _1585 = _1576;
    _1585.z = _1576.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1576.w) : 0.0);
    out.gl_Position = _1585;
    out.out_var_TEXCOORD6 = _1576;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_1530 * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_1556.x, _1556.y, _1556.z, _1537.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_1554[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

