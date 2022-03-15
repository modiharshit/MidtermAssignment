

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
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
};

struct type_Globals
{
    float4x4 ClothLocalToWorld;
    char _m1_pad[64];
    float ClothBlendWeight;
    uint InputWeightIndexSize;
    uint2 GPUSkinApexClothStartIndexOffset;
};

struct FClothVertex
{
    float4 BaryCoordPos;
    float4 BaryCoordNormal;
    float4 BaryCoordTangent;
    uint4 SimulIndices;
    float Weight;
};

constant float3x3 _94 = {};
constant float4 _95 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003989_825cb2e3(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _98;
    for (int _119 = 0; _119 < 5; )
    {
        uint _127 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_119)) * 4u;
        _98[_119].BaryCoordPos = GPUSkinApexCloth.read(uint(_127));
        _98[_119].BaryCoordNormal = GPUSkinApexCloth.read(uint((_127 + 1u)));
        _98[_119].BaryCoordTangent = GPUSkinApexCloth.read(uint((_127 + 2u)));
        uint4 _139 = as_type<uint4>(GPUSkinApexCloth.read(uint((_127 + 3u))));
        uint2 _140 = _139.xy;
        uint2 _143 = (_140 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _98[_119].SimulIndices = uint4(_98[_119].SimulIndices.x, _143.x, _98[_119].SimulIndices.z, _143.y);
        uint2 _147 = _140 & uint2(65535u);
        _98[_119].SimulIndices = uint4(_147.x, _98[_119].SimulIndices.y, _147.y, _98[_119].SimulIndices.w);
        _98[_119].Weight = as_type<float>(_139.z);
        _119++;
        continue;
    }
    float3 _288;
    if (_98[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _99;
        _99 = _98;
        float3 _163;
        float _166;
        int _168;
        _163 = float3(0.0);
        _166 = 0.0;
        _168 = 0;
        float3 _164;
        float _167;
        int _169;
        for (int _170 = 0; _170 < 5; _163 = _164, _166 = _167, _168 = _169, _170++)
        {
            if (_99[_170].SimulIndices.w < 65535u)
            {
                int _187 = int(_99[_170].SimulIndices.x) * 3;
                uint _192 = uint(_187 + 1);
                int _204 = int(_99[_170].SimulIndices.y) * 3;
                uint _208 = uint(_204 + 1);
                int _218 = int(_99[_170].SimulIndices.z) * 3;
                uint _222 = uint(_218 + 1);
                _164 = _163 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_187))).xy, ClothSimulVertsPositionsNormals.read(uint(_192)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_192)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_187 + 2))).xy, 0.0)).xyz * _99[_170].BaryCoordPos.w)) * _99[_170].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_204))).xy, ClothSimulVertsPositionsNormals.read(uint(_208)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_208)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_204 + 2))).xy, 0.0)).xyz * _99[_170].BaryCoordPos.w)) * _99[_170].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_218))).xy, ClothSimulVertsPositionsNormals.read(uint(_222)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_222)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_218 + 2))).xy, 0.0)).xyz * _99[_170].BaryCoordPos.w)) * ((1.0 - _99[_170].BaryCoordPos.x) - _99[_170].BaryCoordPos.y))) * _99[_170].Weight);
                _167 = _166 + _99[_170].Weight;
                _169 = _168 + 1;
            }
            else
            {
                _164 = _163;
                _167 = _166;
                _169 = _168;
            }
        }
        float3 _287;
        if ((_168 > 0) && (_166 > 9.9999997473787516355514526367188e-05))
        {
            _287 = _163 * (1.0 / _166);
        }
        else
        {
            _287 = float3(0.0);
        }
        _288 = _287;
    }
    else
    {
        _288 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _290 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _293 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _299 = int(_293 + (_Globals.InputWeightIndexSize * uint(_290)));
    float3x4 _301;
    _301 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _302;
    for (int _304 = 0; _304 < _290; _301 = _302, _304++)
    {
        int _312 = int(_293 + (_Globals.InputWeightIndexSize * uint(_304)));
        int _317 = int(InputWeightStream.read(uint(uint(_312))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _363 = float4(float(InputWeightStream.read(uint(uint(_299 + _304))).x) * 0.0039215688593685626983642578125);
            int _364 = int((InputWeightStream.read(uint(uint(_312 + 1))).x << 8u) | uint(_317)) * 3;
            _302 = float3x4(_301[0] + (_363 * BoneMatrices.read(uint(uint(_364)))), _301[1] + (_363 * BoneMatrices.read(uint(uint(_364 + 1)))), _301[2] + (_363 * BoneMatrices.read(uint(uint(_364 + 2)))));
        }
        else
        {
            float4 _328 = float4(float(InputWeightStream.read(uint(uint(_299 + _304))).x) * 0.0039215688593685626983642578125);
            int _329 = _317 * 3;
            _302 = float3x4(_301[0] + (_328 * BoneMatrices.read(uint(uint(_329)))), _301[1] + (_328 * BoneMatrices.read(uint(uint(_329 + 1)))), _301[2] + (_328 * BoneMatrices.read(uint(uint(_329 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _97;
    _97 = _98;
    float _566;
    float3x3 _567;
    if (_97[0].SimulIndices.w < 65535u)
    {
        float _395;
        float3 _398;
        float3 _400;
        float _402;
        int _404;
        _395 = _Globals.ClothBlendWeight;
        _398 = float3(0.0);
        _400 = float3(0.0);
        _402 = 0.0;
        _404 = 0;
        float _396;
        float3 _399;
        float3 _401;
        float _403;
        int _405;
        for (int _406 = 0; _406 < 5; _395 = _396, _398 = _399, _400 = _401, _402 = _403, _404 = _405, _406++)
        {
            bool _418 = _97[_406].SimulIndices.w < 65535u;
            if (_418)
            {
                int _424 = int(_97[_406].SimulIndices.x) * 3;
                uint _429 = uint(_424 + 1);
                float3 _438 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_424))).xy, ClothSimulVertsPositionsNormals.read(uint(_429)).x, 1.0)).xyz;
                int _441 = int(_97[_406].SimulIndices.y) * 3;
                uint _445 = uint(_441 + 1);
                float3 _452 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_441))).xy, ClothSimulVertsPositionsNormals.read(uint(_445)).x, 1.0)).xyz;
                int _455 = int(_97[_406].SimulIndices.z) * 3;
                uint _459 = uint(_455 + 1);
                float3 _466 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_455))).xy, ClothSimulVertsPositionsNormals.read(uint(_459)).x, 1.0)).xyz;
                float3 _476 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_429)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_424 + 2))).xy, 0.0)).xyz;
                float3 _486 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_445)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_441 + 2))).xy, 0.0)).xyz;
                float3 _496 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_459)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_455 + 2))).xy, 0.0)).xyz;
                _399 = _398 + (((((_438 + (_476 * _97[_406].BaryCoordNormal.w)) * _97[_406].BaryCoordNormal.x) + ((_452 + (_486 * _97[_406].BaryCoordNormal.w)) * _97[_406].BaryCoordNormal.y)) + ((_466 + (_496 * _97[_406].BaryCoordNormal.w)) * _97[_406].BaryCoordNormal.z)) * _97[_406].Weight);
                _401 = _400 + (((((_438 + (_476 * _97[_406].BaryCoordTangent.w)) * _97[_406].BaryCoordTangent.x) + ((_452 + (_486 * _97[_406].BaryCoordTangent.w)) * _97[_406].BaryCoordTangent.y)) + ((_466 + (_496 * _97[_406].BaryCoordTangent.w)) * _97[_406].BaryCoordTangent.z)) * _97[_406].Weight);
                _403 = _402 + _97[_406].Weight;
                _405 = _404 + 1;
            }
            else
            {
                _399 = _398;
                _401 = _400;
                _403 = _402;
                _405 = _404;
            }
            _396 = _418 ? _Globals.ClothBlendWeight : _395;
        }
        bool _534 = (_404 > 0) && (_402 > 9.9999997473787516355514526367188e-05);
        float3x3 _558;
        if (_534)
        {
            float _538 = 1.0 / _402;
            float3x3 _553 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _555 = _94;
            _555[0] = _553 * normalize((_400 * _538) - _288);
            float3x3 _557 = _555;
            _557[2] = _553 * normalize((_398 * _538) - _288);
            _558 = _557;
        }
        else
        {
            _558 = _94;
        }
        float3x3 _565 = _558;
        _565[1] = cross(_558[2], _558[0]) * in.in_var_ATTRIBUTE2.w;
        _566 = _534 ? _395 : 0.0;
        _567 = _565;
    }
    else
    {
        _566 = 0.0;
        _567 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _573 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _301);
    float3 _579 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _301);
    float3 _584 = float3(_566);
    float3 _592 = float3(1.0 - _566);
    float4 _667;
    switch (0u)
    {
        default:
        {
            if (_98[0].SimulIndices.w < 65535u)
            {
                _667 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _301) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _288, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _616 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _301) + in.in_var_ATTRIBUTE12;
                _667 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _616.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _616.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _616.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _669 = View.View_TranslatedWorldToClip * float4(_667.x, _667.y, _667.z, _667.w);
    float4 _670 = _95;
    _670.w = 0.0;
    float3x3 _684 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _684[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _687 = _684;
    _687[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _690 = _687;
    _690[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _691 = _690 * float3x3((_567[0] * _584) + (_573 * _592), (_567[1] * _584) + (normalize(cross(_579, _573) * in.in_var_ATTRIBUTE2.w) * _592), (_567[2] * _584) + (_579 * _592));
    float3 _692 = _691[0];
    out.gl_Position = _669;
    out.out_var_TEXCOORD10_centroid = float4(_692.x, _692.y, _692.z, _670.w);
    out.out_var_TEXCOORD11_centroid = float4(_691[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_667.x, _667.y, _667.z, _667.w);
    return out;
}

