

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

constant spvUnsafeArray<float2, 1> _83 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float4 _87 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4_0 [[attribute(4)]];
};

vertex MainVertexShader_out Main_0000b30e_2e98cccb(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_NiagaraMeshVF& NiagaraMeshVF [[buffer(5)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataFloat [[texture(0)]], texture_buffer<float> NiagaraMeshVF_NiagaraParticleDataHalf [[texture(1)]], texture_buffer<int> NiagaraMeshVF_SortedIndices [[texture(2)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE4 = {};
    in_var_ATTRIBUTE4[0] = in.in_var_ATTRIBUTE4_0;
    spvUnsafeArray<float2, 1> _113;
    _113 = in_var_ATTRIBUTE4;
    spvUnsafeArray<float2, 1> _114 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    uint _150;
    if (NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset != (-1))
    {
        _150 = uint(NiagaraMeshVF_SortedIndices.read(uint((uint(NiagaraMeshVF.NiagaraMeshVF_SortedIndicesOffset) + (gl_InstanceIndex - gl_BaseInstance)))).x);
    }
    else
    {
        _150 = (gl_InstanceIndex - gl_BaseInstance);
    }
    float3 _213;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset == (-1))
            {
                _213 = NiagaraMeshVF.NiagaraMeshVF_DefaultVelocity;
                break;
            }
            float3 _212;
            switch (0u)
            {
                default:
                {
                    uint _162 = uint(NiagaraMeshVF.NiagaraMeshVF_VelocityDataOffset);
                    int _166 = int(_162 & 2147483647u);
                    if ((_162 & 2147483648u) != 0u)
                    {
                        _212 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_166) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_166 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_166 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x);
                        break;
                    }
                    else
                    {
                        _212 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_166) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_166 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_166 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _150))).x);
                        break;
                    }
                }
            }
            _213 = _212;
            break;
        }
    }
    float _215 = length(_213.xyz);
    bool _216 = _215 > 0.0;
    uint _222 = uint(int(_150));
    float3 _300;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset == (-1))
            {
                _300 = NiagaraMeshVF.NiagaraMeshVF_DefaultPos.xyz;
                break;
            }
            float3 _299;
            switch (0u)
            {
                default:
                {
                    uint _249 = uint(NiagaraMeshVF.NiagaraMeshVF_PositionDataOffset);
                    int _253 = int(_249 & 2147483647u);
                    if ((_249 & 2147483648u) != 0u)
                    {
                        _299 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_253) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_253 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_253 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _299 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_253) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_253 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_253 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _300 = _299;
            break;
        }
    }
    float4 _371;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset == (-1))
            {
                _371 = NiagaraMeshVF.NiagaraMeshVF_DefaultRotation;
                break;
            }
            float4 _370;
            switch (0u)
            {
                default:
                {
                    uint _308 = uint(NiagaraMeshVF.NiagaraMeshVF_RotationDataOffset);
                    int _312 = int(_308 & 2147483647u);
                    if ((_308 & 2147483648u) != 0u)
                    {
                        _370 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_312) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_312 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_312 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_312 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _370 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_312) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_312 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_312 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_312 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _371 = _370;
            break;
        }
    }
    float3 _430;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset == (-1))
            {
                _430 = NiagaraMeshVF.NiagaraMeshVF_DefaultScale;
                break;
            }
            float3 _429;
            switch (0u)
            {
                default:
                {
                    uint _379 = uint(NiagaraMeshVF.NiagaraMeshVF_ScaleDataOffset);
                    int _383 = int(_379 & 2147483647u);
                    if ((_379 & 2147483648u) != 0u)
                    {
                        _429 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_383) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_383 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_383 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _429 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_383) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_383 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_383 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _430 = _429;
            break;
        }
    }
    float3 _433 = _430 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _434 = normalize(_371);
    float _435 = _434.x;
    float _436 = _435 + _435;
    float _437 = _434.y;
    float _438 = _437 + _437;
    float _439 = _434.z;
    float _440 = _439 + _439;
    float _441 = _435 * _436;
    float _442 = _435 * _438;
    float _443 = _435 * _440;
    float _444 = _437 * _438;
    float _445 = _437 * _440;
    float _446 = _439 * _440;
    float _447 = _434.w;
    float _448 = _447 * _436;
    float _449 = _447 * _438;
    float _450 = _447 * _440;
    float3x3 _466 = float3x3(float3(1.0 - (_444 + _446), _442 + _450, _443 - _449), float3(_442 - _450, 1.0 - (_441 + _446), _445 + _448), float3(_443 + _449, _445 - _448, 1.0 - (_441 + _444)));
    bool _469 = NiagaraMeshVF.NiagaraMeshVF_FacingMode != 0u;
    float3x3 _700;
    if (_469)
    {
        bool _474 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
        float3 _576;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _552;
                if (_216)
                {
                    _552 = select(float3(0.0), _213.xyz / float3(_215), bool3(_216)).xyz;
                }
                else
                {
                    float3 _550;
                    switch (0u)
                    {
                        default:
                        {
                            if (_474)
                            {
                                _550 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _550 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _552 = _550;
                }
                _576 = _552;
                break;
            }
            case 2u:
            {
                float3 _501;
                switch (0u)
                {
                    default:
                    {
                        if (_474)
                        {
                            _501 = (((Primitive.Primitive_LocalToWorld[0].xyz * _300.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _300.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _300.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                            break;
                        }
                        _501 = _300;
                        break;
                    }
                }
                float3 _503 = normalize(View.View_WorldCameraOrigin - _501);
                float3 _525;
                switch (0u)
                {
                    default:
                    {
                        if (_474)
                        {
                            _525 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _503;
                            break;
                        }
                        _525 = _503;
                        break;
                    }
                }
                _576 = _525;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _553 = -View.View_ViewForward;
                float3 _575;
                switch (0u)
                {
                    default:
                    {
                        if (_474)
                        {
                            _575 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _553;
                            break;
                        }
                        _575 = _553;
                        break;
                    }
                }
                _576 = _575;
                break;
            }
        }
        float3 _695;
        float3 _696;
        float3 _697;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _627 = !_474;
            bool _629 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _627);
            float3 _680;
            if (_629 && _474)
            {
                _680 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _662;
                if ((!_629) && _627)
                {
                    _662 = (((Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _662 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _680 = _662;
            }
            float3 _691;
            if (abs(dot(_576, _680)) > 0.9900000095367431640625)
            {
                _691 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_680.z) > 0.9900000095367431640625));
            }
            else
            {
                _691 = _576;
            }
            float3 _693 = normalize(cross(_680, _691));
            _695 = _680;
            _696 = _693;
            _697 = cross(_693, _680);
        }
        else
        {
            float3 _597;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _597 = View.View_ViewUp;
            }
            else
            {
                _597 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_576.z))), bool3(abs(_576.z) > 0.9900000095367431640625));
            }
            float3 _619;
            switch (0u)
            {
                default:
                {
                    if (_474)
                    {
                        _619 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _597;
                        break;
                    }
                    _619 = _597;
                    break;
                }
            }
            float3 _621 = normalize(cross(_619, _576));
            _695 = cross(_576, _621);
            _696 = _621;
            _697 = _576;
        }
        _700 = float3x3(_697, _696, _695) * _466;
    }
    else
    {
        _700 = _466;
    }
    bool _705;
    float3 _725;
    switch (0u)
    {
        default:
        {
            _705 = NiagaraMeshVF.NiagaraMeshVF_bLocalSpace != 0u;
            if (_705)
            {
                _725 = (((Primitive.Primitive_LocalToWorld[0].xyz * _300.x) + (Primitive.Primitive_LocalToWorld[1].xyz * _300.y)) + (Primitive.Primitive_LocalToWorld[2].xyz * _300.z)) + Primitive.Primitive_LocalToWorld[3].xyz;
                break;
            }
            _725 = _300;
            break;
        }
    }
    float _758;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset == (-1))
            {
                _758 = NiagaraMeshVF.NiagaraMeshVF_DefaultCamOffset;
                break;
            }
            float _757;
            switch (0u)
            {
                default:
                {
                    uint _733 = uint(NiagaraMeshVF.NiagaraMeshVF_CameraOffsetDataOffset);
                    int _737 = int(_733 & 2147483647u);
                    if ((_733 & 2147483648u) != 0u)
                    {
                        _757 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_737) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x;
                        break;
                    }
                    else
                    {
                        _757 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_737) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x;
                        break;
                    }
                }
            }
            _758 = _757;
            break;
        }
    }
    float3 _760 = normalize(View.View_WorldCameraOrigin - _725);
    float3 _782;
    switch (0u)
    {
        default:
        {
            if (_705)
            {
                _782 = transpose(float3x3(Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _760;
                break;
            }
            _782 = _760;
            break;
        }
    }
    float3 _784 = _300 + (_782 * _758);
    bool _787 = NiagaraMeshVF.NiagaraMeshVF_bPivotOffsetIsWorldSpace != 0;
    bool _788 = !_787;
    float3 _796;
    if (_788)
    {
        _796 = _784 + (_700 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _430));
    }
    else
    {
        _796 = _784;
    }
    float3x3 _804 = _700 * float3x3(float3(_433.x, 0.0, 0.0), float3(0.0, _433.y, 0.0), float3(0.0, 0.0, _433.z));
    float4 _823 = float4(_796, 1.0);
    float4x4 _824 = float4x4(float4(_804[0], 0.0), float4(_804[1], 0.0), float4(_804[2], 0.0), _823);
    float3x3 _825 = _700 * float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    float4x4 _841 = float4x4(float4(_825[0], 0.0), float4(_825[1], 0.0), float4(_825[2], 0.0), _823);
    float3 _904;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevVelocityDataOffset == (-1))
            {
                _904 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevVelocity;
                break;
            }
            float3 _903;
            switch (0u)
            {
                default:
                {
                    uint _853 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevVelocityDataOffset);
                    int _857 = int(_853 & 2147483647u);
                    if ((_853 & 2147483648u) != 0u)
                    {
                        _903 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_857) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_857 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_857 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _903 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_857) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_857 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_857 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _904 = _903;
            break;
        }
    }
    float _906 = length(_904.xyz);
    bool _907 = _906 > 0.0;
    float3 _993;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevPositionDataOffset == (-1))
            {
                _993 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevPos.xyz;
                break;
            }
            float3 _992;
            switch (0u)
            {
                default:
                {
                    uint _942 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevPositionDataOffset);
                    int _946 = int(_942 & 2147483647u);
                    if ((_942 & 2147483648u) != 0u)
                    {
                        _992 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_946) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_946 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_946 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _992 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_946) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_946 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_946 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _993 = _992;
            break;
        }
    }
    float4 _1064;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevRotationDataOffset == (-1))
            {
                _1064 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevRotation;
                break;
            }
            float4 _1063;
            switch (0u)
            {
                default:
                {
                    uint _1001 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevRotationDataOffset);
                    int _1005 = int(_1001 & 2147483647u);
                    if ((_1001 & 2147483648u) != 0u)
                    {
                        _1063 = float4(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1005) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1005 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1005 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1005 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _1063 = float4(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1005) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1005 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1005 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1005 + 3) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _1064 = _1063;
            break;
        }
    }
    float3 _1123;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevScaleDataOffset == (-1))
            {
                _1123 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevScale;
                break;
            }
            float3 _1122;
            switch (0u)
            {
                default:
                {
                    uint _1072 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevScaleDataOffset);
                    int _1076 = int(_1072 & 2147483647u);
                    if ((_1072 & 2147483648u) != 0u)
                    {
                        _1122 = float3(NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1076) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1076 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1076 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                    else
                    {
                        _1122 = float3(NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1076) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1076 + 1) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x, NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1076 + 2) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x);
                        break;
                    }
                }
            }
            _1123 = _1122;
            break;
        }
    }
    float3 _1124 = _1123 * NiagaraMeshVF.NiagaraMeshVF_MeshScale;
    float4 _1125 = normalize(_1064);
    float _1126 = _1125.x;
    float _1127 = _1126 + _1126;
    float _1128 = _1125.y;
    float _1129 = _1128 + _1128;
    float _1130 = _1125.z;
    float _1131 = _1130 + _1130;
    float _1132 = _1126 * _1127;
    float _1133 = _1126 * _1129;
    float _1134 = _1126 * _1131;
    float _1135 = _1128 * _1129;
    float _1136 = _1128 * _1131;
    float _1137 = _1130 * _1131;
    float _1138 = _1125.w;
    float _1139 = _1138 * _1127;
    float _1140 = _1138 * _1129;
    float _1141 = _1138 * _1131;
    float3x3 _1157 = float3x3(float3(1.0 - (_1135 + _1137), _1133 + _1141, _1134 - _1140), float3(_1133 - _1141, 1.0 - (_1132 + _1137), _1136 + _1139), float3(_1134 + _1140, _1136 - _1139, 1.0 - (_1132 + _1135)));
    float3x3 _1385;
    if (_469)
    {
        float3 _1261;
        switch (NiagaraMeshVF.NiagaraMeshVF_FacingMode)
        {
            case 1u:
            {
                float3 _1237;
                if (_907)
                {
                    _1237 = select(float3(0.0), _904.xyz / float3(_906), bool3(_907)).xyz;
                }
                else
                {
                    float3 _1235;
                    switch (0u)
                    {
                        default:
                        {
                            if (_705)
                            {
                                _1235 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(0.0, 0.0, 1.0);
                                break;
                            }
                            _1235 = float3(0.0, 0.0, 1.0);
                            break;
                        }
                    }
                    _1237 = _1235;
                }
                _1261 = _1237;
                break;
            }
            case 2u:
            {
                float3 _1186;
                switch (0u)
                {
                    default:
                    {
                        if (_705)
                        {
                            _1186 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _993.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _993.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _993.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                            break;
                        }
                        _1186 = _993;
                        break;
                    }
                }
                float3 _1188 = normalize(View.View_PrevWorldCameraOrigin - _1186);
                float3 _1210;
                switch (0u)
                {
                    default:
                    {
                        if (_705)
                        {
                            _1210 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1188;
                            break;
                        }
                        _1210 = _1188;
                        break;
                    }
                }
                _1261 = _1210;
                break;
            }
            default:
            {
            }
            case 3u:
            {
                float3 _1238 = -View.View_PrevViewToTranslatedWorld[2].xyz;
                float3 _1260;
                switch (0u)
                {
                    default:
                    {
                        if (_705)
                        {
                            _1260 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1238;
                            break;
                        }
                        _1260 = _1238;
                        break;
                    }
                }
                _1261 = _1260;
                break;
            }
        }
        float3 _1380;
        float3 _1381;
        float3 _1382;
        if (NiagaraMeshVF.NiagaraMeshVF_bLockedAxisEnable != 0u)
        {
            bool _1312 = !_705;
            bool _1314 = (NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 1u) || ((NiagaraMeshVF.NiagaraMeshVF_LockedAxisSpace == 0u) && _1312);
            float3 _1365;
            if (_1314 && _705)
            {
                _1365 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
            }
            else
            {
                float3 _1347;
                if ((!_1314) && _1312)
                {
                    _1347 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[0])) + ((Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[1]))) + ((Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z) * float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2], NiagaraMeshVF.NiagaraMeshVF_LockedAxis[2]));
                }
                else
                {
                    _1347 = float3(NiagaraMeshVF.NiagaraMeshVF_LockedAxis);
                }
                _1365 = _1347;
            }
            float3 _1376;
            if (abs(dot(_1261, _1365)) > 0.9900000095367431640625)
            {
                _1376 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0), bool3(abs(_1365.z) > 0.9900000095367431640625));
            }
            else
            {
                _1376 = _1261;
            }
            float3 _1378 = normalize(cross(_1365, _1376));
            _1380 = _1365;
            _1381 = _1378;
            _1382 = cross(_1378, _1365);
        }
        else
        {
            float3 _1282;
            if (NiagaraMeshVF.NiagaraMeshVF_FacingMode == 3u)
            {
                _1282 = View.View_PrevViewToTranslatedWorld[1].xyz;
            }
            else
            {
                _1282 = select(float3(0.0, 0.0, 1.0), float3(1.0, 0.0, 0.0) * float(-int(sign(_1261.z))), bool3(abs(_1261.z) > 0.9900000095367431640625));
            }
            float3 _1304;
            switch (0u)
            {
                default:
                {
                    if (_705)
                    {
                        _1304 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1282;
                        break;
                    }
                    _1304 = _1282;
                    break;
                }
            }
            float3 _1306 = normalize(cross(_1304, _1261));
            _1380 = cross(_1261, _1306);
            _1381 = _1306;
            _1382 = _1261;
        }
        _1385 = float3x3(_1382, _1381, _1380) * _1157;
    }
    else
    {
        _1385 = _1157;
    }
    float3 _1407;
    switch (0u)
    {
        default:
        {
            if (_705)
            {
                _1407 = (((Primitive.Primitive_PreviousLocalToWorld[0].xyz * _993.x) + (Primitive.Primitive_PreviousLocalToWorld[1].xyz * _993.y)) + (Primitive.Primitive_PreviousLocalToWorld[2].xyz * _993.z)) + Primitive.Primitive_PreviousLocalToWorld[3].xyz;
                break;
            }
            _1407 = _993;
            break;
        }
    }
    float _1440;
    switch (0u)
    {
        default:
        {
            if (NiagaraMeshVF.NiagaraMeshVF_PrevCameraOffsetDataOffset == (-1))
            {
                _1440 = NiagaraMeshVF.NiagaraMeshVF_DefaultPrevCamOffset;
                break;
            }
            float _1439;
            switch (0u)
            {
                default:
                {
                    uint _1415 = uint(NiagaraMeshVF.NiagaraMeshVF_PrevCameraOffsetDataOffset);
                    int _1419 = int(_1415 & 2147483647u);
                    if ((_1415 & 2147483648u) != 0u)
                    {
                        _1439 = NiagaraMeshVF_NiagaraParticleDataHalf.read(uint(((uint(_1419) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x;
                        break;
                    }
                    else
                    {
                        _1439 = NiagaraMeshVF_NiagaraParticleDataFloat.read(uint(((uint(_1419) * NiagaraMeshVF.NiagaraMeshVF_NiagaraFloatDataStride) + _222))).x;
                        break;
                    }
                }
            }
            _1440 = _1439;
            break;
        }
    }
    float3 _1442 = normalize(View.View_PrevWorldCameraOrigin - _1407);
    float3 _1464;
    switch (0u)
    {
        default:
        {
            if (_705)
            {
                _1464 = transpose(float3x3(Primitive.Primitive_PreviousLocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x, Primitive.Primitive_PreviousLocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y, Primitive.Primitive_PreviousLocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z)) * _1442;
                break;
            }
            _1464 = _1442;
            break;
        }
    }
    float3 _1466 = _993 + (_1464 * _1440);
    float3 _1474;
    if (_788)
    {
        _1474 = _1466 + (_1385 * (float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset) * _1123));
    }
    else
    {
        _1474 = _1466;
    }
    float3x3 _1482 = _1385 * float3x3(float3(_1124.x, 0.0, 0.0), float3(0.0, _1124.y, 0.0), float3(0.0, 0.0, _1124.z));
    float4x4 _1502 = float4x4(float4(_1482[0], 0.0), float4(_1482[1], 0.0), float4(_1482[2], 0.0), float4(_1474, 1.0));
    float4x4 _1528;
    float4x4 _1529;
    float4x4 _1530;
    if (_705)
    {
        float4x4 _1507 = Primitive.Primitive_LocalToWorld * _841;
        float4 _1511 = _1507[0];
        float3 _1513 = _1511.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
        float4x4 _1515 = _1507;
        _1515[0] = float4(_1513.x, _1513.y, _1513.z, _1511.w);
        float4 _1517 = _1507[1];
        float3 _1519 = _1517.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
        float4x4 _1521 = _1515;
        _1521[1] = float4(_1519.x, _1519.y, _1519.z, _1517.w);
        float4 _1523 = _1507[2];
        float3 _1525 = _1523.xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
        float4x4 _1527 = _1521;
        _1527[2] = float4(_1525.x, _1525.y, _1525.z, _1523.w);
        _1528 = _1527;
        _1529 = Primitive.Primitive_PreviousLocalToWorld * _1502;
        _1530 = Primitive.Primitive_LocalToWorld * _824;
    }
    else
    {
        _1528 = _841;
        _1529 = _1502;
        _1530 = _824;
    }
    float4x4 _1545;
    float4x4 _1546;
    if (_787)
    {
        float3 _1537 = _1530[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _1539 = _1530;
        _1539[3] = float4(_1537.x, _1537.y, _1537.z, _1530[3].w);
        float3 _1542 = _1529[3].xyz + float3(NiagaraMeshVF.NiagaraMeshVF_PivotOffset);
        float4x4 _1544 = _1529;
        _1544[3] = float4(_1542.x, _1542.y, _1542.z, _1529[3].w);
        _1545 = _1539;
        _1546 = _1544;
    }
    else
    {
        _1545 = _1530;
        _1546 = _1529;
    }
    for (int _1548 = 0; _1548 < 1; )
    {
        _114[_1548] = _113[_1548];
        _1548++;
        continue;
    }
    spvUnsafeArray<float2, 1> _112;
    _112 = _114;
    spvUnsafeArray<float2, 1> _115 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _1564 = 0; _1564 < 1; )
    {
        _115[_1564] = _112[_1564];
        _1564++;
        continue;
    }
    float4 _1575 = _87;
    _1575.w = 0.0;
    float3x3 _1577 = float3x3(float3(0.0), float3(0.0), float3(0.0));
    _1577[2] = in.in_var_ATTRIBUTE2.xyz;
    float3 _1580 = cross(in.in_var_ATTRIBUTE2.xyz, in.in_var_ATTRIBUTE1) * in.in_var_ATTRIBUTE2.w;
    float3x3 _1581 = _1577;
    _1581[1] = _1580;
    float3x3 _1584 = _1581;
    _1584[0] = cross(_1580, in.in_var_ATTRIBUTE2.xyz) * in.in_var_ATTRIBUTE2.w;
    float3x3 _1592 = float3x3(_1528[0].xyz, _1528[1].xyz, _1528[2].xyz) * _1584;
    float3 _1594 = normalize(_1592[0]);
    spvUnsafeArray<float4, 1> _1605 = { float4(_115[0].x, _115[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _1615 = View.View_TranslatedWorldToClip * float4((_1545 * in.in_var_ATTRIBUTE0).xyz + View.View_PreViewTranslation, 1.0);
    float4 _1624 = _1615;
    _1624.z = _1615.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1615.w) : 0.0);
    out.gl_Position = _1624;
    out.out_var_TEXCOORD6 = _1615;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4((_1546 * in.in_var_ATTRIBUTE0).xyz + View.View_PrevPreViewTranslation, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_1594.x, _1594.y, _1594.z, _1575.w);
    out.out_var_TEXCOORD11_centroid = float4(normalize(_1592[2]), in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _1605;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

