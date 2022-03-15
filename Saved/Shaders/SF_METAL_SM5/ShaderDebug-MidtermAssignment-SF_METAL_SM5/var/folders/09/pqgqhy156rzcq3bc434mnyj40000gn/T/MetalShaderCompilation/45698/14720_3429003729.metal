

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

vertex Main_out Main_00003980_cc6271d1(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _98;
    for (int _117 = 0; _117 < 5; )
    {
        uint _125 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_117)) * 4u;
        _98[_117].BaryCoordPos = GPUSkinApexCloth.read(uint(_125));
        _98[_117].BaryCoordNormal = GPUSkinApexCloth.read(uint((_125 + 1u)));
        _98[_117].BaryCoordTangent = GPUSkinApexCloth.read(uint((_125 + 2u)));
        uint4 _137 = as_type<uint4>(GPUSkinApexCloth.read(uint((_125 + 3u))));
        uint2 _138 = _137.xy;
        uint2 _141 = (_138 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _98[_117].SimulIndices = uint4(_98[_117].SimulIndices.x, _141.x, _98[_117].SimulIndices.z, _141.y);
        uint2 _145 = _138 & uint2(65535u);
        _98[_117].SimulIndices = uint4(_145.x, _98[_117].SimulIndices.y, _145.y, _98[_117].SimulIndices.w);
        _98[_117].Weight = as_type<float>(_137.z);
        _117++;
        continue;
    }
    float3 _286;
    if (_98[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _99;
        _99 = _98;
        float3 _161;
        float _164;
        int _166;
        _161 = float3(0.0);
        _164 = 0.0;
        _166 = 0;
        float3 _162;
        float _165;
        int _167;
        for (int _168 = 0; _168 < 5; _161 = _162, _164 = _165, _166 = _167, _168++)
        {
            if (_99[_168].SimulIndices.w < 65535u)
            {
                int _185 = int(_99[_168].SimulIndices.x) * 3;
                uint _190 = uint(_185 + 1);
                int _202 = int(_99[_168].SimulIndices.y) * 3;
                uint _206 = uint(_202 + 1);
                int _216 = int(_99[_168].SimulIndices.z) * 3;
                uint _220 = uint(_216 + 1);
                _162 = _161 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_185))).xy, ClothSimulVertsPositionsNormals.read(uint(_190)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_190)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_185 + 2))).xy, 0.0)).xyz * _99[_168].BaryCoordPos.w)) * _99[_168].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_202))).xy, ClothSimulVertsPositionsNormals.read(uint(_206)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_206)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_202 + 2))).xy, 0.0)).xyz * _99[_168].BaryCoordPos.w)) * _99[_168].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_216))).xy, ClothSimulVertsPositionsNormals.read(uint(_220)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_220)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_216 + 2))).xy, 0.0)).xyz * _99[_168].BaryCoordPos.w)) * ((1.0 - _99[_168].BaryCoordPos.x) - _99[_168].BaryCoordPos.y))) * _99[_168].Weight);
                _165 = _164 + _99[_168].Weight;
                _167 = _166 + 1;
            }
            else
            {
                _162 = _161;
                _165 = _164;
                _167 = _166;
            }
        }
        float3 _285;
        if ((_166 > 0) && (_164 > 9.9999997473787516355514526367188e-05))
        {
            _285 = _161 * (1.0 / _164);
        }
        else
        {
            _285 = float3(0.0);
        }
        _286 = _285;
    }
    else
    {
        _286 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _288 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _291 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _297 = int(_291 + (_Globals.InputWeightIndexSize * uint(_288)));
    float3x4 _299;
    _299 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _300;
    for (int _302 = 0; _302 < _288; _299 = _300, _302++)
    {
        int _310 = int(_291 + (_Globals.InputWeightIndexSize * uint(_302)));
        int _315 = int(InputWeightStream.read(uint(uint(_310))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _361 = float4(float(InputWeightStream.read(uint(uint(_297 + _302))).x) * 0.0039215688593685626983642578125);
            int _362 = int((InputWeightStream.read(uint(uint(_310 + 1))).x << 8u) | uint(_315)) * 3;
            _300 = float3x4(_299[0] + (_361 * BoneMatrices.read(uint(uint(_362)))), _299[1] + (_361 * BoneMatrices.read(uint(uint(_362 + 1)))), _299[2] + (_361 * BoneMatrices.read(uint(uint(_362 + 2)))));
        }
        else
        {
            float4 _326 = float4(float(InputWeightStream.read(uint(uint(_297 + _302))).x) * 0.0039215688593685626983642578125);
            int _327 = _315 * 3;
            _300 = float3x4(_299[0] + (_326 * BoneMatrices.read(uint(uint(_327)))), _299[1] + (_326 * BoneMatrices.read(uint(uint(_327 + 1)))), _299[2] + (_326 * BoneMatrices.read(uint(uint(_327 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _97;
    _97 = _98;
    float _564;
    float3x3 _565;
    if (_97[0].SimulIndices.w < 65535u)
    {
        float _393;
        float3 _396;
        float3 _398;
        float _400;
        int _402;
        _393 = _Globals.ClothBlendWeight;
        _396 = float3(0.0);
        _398 = float3(0.0);
        _400 = 0.0;
        _402 = 0;
        float _394;
        float3 _397;
        float3 _399;
        float _401;
        int _403;
        for (int _404 = 0; _404 < 5; _393 = _394, _396 = _397, _398 = _399, _400 = _401, _402 = _403, _404++)
        {
            bool _416 = _97[_404].SimulIndices.w < 65535u;
            if (_416)
            {
                int _422 = int(_97[_404].SimulIndices.x) * 3;
                uint _427 = uint(_422 + 1);
                float3 _436 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_422))).xy, ClothSimulVertsPositionsNormals.read(uint(_427)).x, 1.0)).xyz;
                int _439 = int(_97[_404].SimulIndices.y) * 3;
                uint _443 = uint(_439 + 1);
                float3 _450 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_439))).xy, ClothSimulVertsPositionsNormals.read(uint(_443)).x, 1.0)).xyz;
                int _453 = int(_97[_404].SimulIndices.z) * 3;
                uint _457 = uint(_453 + 1);
                float3 _464 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_453))).xy, ClothSimulVertsPositionsNormals.read(uint(_457)).x, 1.0)).xyz;
                float3 _474 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_427)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_422 + 2))).xy, 0.0)).xyz;
                float3 _484 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_443)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_439 + 2))).xy, 0.0)).xyz;
                float3 _494 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_457)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_453 + 2))).xy, 0.0)).xyz;
                _397 = _396 + (((((_436 + (_474 * _97[_404].BaryCoordNormal.w)) * _97[_404].BaryCoordNormal.x) + ((_450 + (_484 * _97[_404].BaryCoordNormal.w)) * _97[_404].BaryCoordNormal.y)) + ((_464 + (_494 * _97[_404].BaryCoordNormal.w)) * _97[_404].BaryCoordNormal.z)) * _97[_404].Weight);
                _399 = _398 + (((((_436 + (_474 * _97[_404].BaryCoordTangent.w)) * _97[_404].BaryCoordTangent.x) + ((_450 + (_484 * _97[_404].BaryCoordTangent.w)) * _97[_404].BaryCoordTangent.y)) + ((_464 + (_494 * _97[_404].BaryCoordTangent.w)) * _97[_404].BaryCoordTangent.z)) * _97[_404].Weight);
                _401 = _400 + _97[_404].Weight;
                _403 = _402 + 1;
            }
            else
            {
                _397 = _396;
                _399 = _398;
                _401 = _400;
                _403 = _402;
            }
            _394 = _416 ? _Globals.ClothBlendWeight : _393;
        }
        bool _532 = (_402 > 0) && (_400 > 9.9999997473787516355514526367188e-05);
        float3x3 _556;
        if (_532)
        {
            float _536 = 1.0 / _400;
            float3x3 _551 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _553 = _94;
            _553[0] = _551 * normalize((_398 * _536) - _286);
            float3x3 _555 = _553;
            _555[2] = _551 * normalize((_396 * _536) - _286);
            _556 = _555;
        }
        else
        {
            _556 = _94;
        }
        float3x3 _563 = _556;
        _563[1] = cross(_556[2], _556[0]) * in.in_var_ATTRIBUTE2.w;
        _564 = _532 ? _393 : 0.0;
        _565 = _563;
    }
    else
    {
        _564 = 0.0;
        _565 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _571 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _299);
    float3 _577 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _299);
    float3 _582 = float3(_564);
    float3 _590 = float3(1.0 - _564);
    float4 _665;
    switch (0u)
    {
        default:
        {
            if (_98[0].SimulIndices.w < 65535u)
            {
                _665 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _299) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _286, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _614 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _299) + in.in_var_ATTRIBUTE12;
                _665 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _614.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _614.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _614.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _669 = View.View_TranslatedWorldToClip * float4(_665.x, _665.y, _665.z, _665.w);
    float4 _670 = _95;
    _670.w = 0.0;
    float3x3 _684 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _684[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _687 = _684;
    _687[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _690 = _687;
    _690[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _691 = _690 * float3x3((_565[0] * _582) + (_571 * _590), (_565[1] * _582) + (normalize(cross(_577, _571) * in.in_var_ATTRIBUTE2.w) * _590), (_565[2] * _582) + (_577 * _590));
    float3 _692 = _691[0];
    out.out_var_TEXCOORD10_centroid = float4(_692.x, _692.y, _692.z, _670.w);
    out.out_var_TEXCOORD11_centroid = float4(_691[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_665.x, _665.y, _665.z, _665.w);
    out.gl_Position = _669;
    return out;
}

