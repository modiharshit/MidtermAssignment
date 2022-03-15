

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
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    char _m2_pad[64];
    float ClothBlendWeight;
    packed_uint2 GPUSkinApexClothStartIndexOffset;
};

struct FClothVertex
{
    float4 BaryCoordPos;
    float4 BaryCoordNormal;
    float4 BaryCoordTangent;
    uint4 SimulIndices;
    float Weight;
};

constant float3x3 _90 = {};
constant float4 _91 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00003d87_ac5d06bb(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _94;
    for (int _116 = 0; _116 < 5; )
    {
        uint _124 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_116)) * 4u;
        _94[_116].BaryCoordPos = GPUSkinApexCloth.read(uint(_124));
        _94[_116].BaryCoordNormal = GPUSkinApexCloth.read(uint((_124 + 1u)));
        _94[_116].BaryCoordTangent = GPUSkinApexCloth.read(uint((_124 + 2u)));
        uint4 _136 = as_type<uint4>(GPUSkinApexCloth.read(uint((_124 + 3u))));
        uint2 _137 = _136.xy;
        uint2 _140 = (_137 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _94[_116].SimulIndices = uint4(_94[_116].SimulIndices.x, _140.x, _94[_116].SimulIndices.z, _140.y);
        uint2 _144 = _137 & uint2(65535u);
        _94[_116].SimulIndices = uint4(_144.x, _94[_116].SimulIndices.y, _144.y, _94[_116].SimulIndices.w);
        _94[_116].Weight = as_type<float>(_136.z);
        _116++;
        continue;
    }
    float3 _285;
    if (_94[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _95;
        _95 = _94;
        float3 _160;
        float _163;
        int _165;
        _160 = float3(0.0);
        _163 = 0.0;
        _165 = 0;
        float3 _161;
        float _164;
        int _166;
        for (int _167 = 0; _167 < 5; _160 = _161, _163 = _164, _165 = _166, _167++)
        {
            if (_95[_167].SimulIndices.w < 65535u)
            {
                int _184 = int(_95[_167].SimulIndices.x) * 3;
                uint _189 = uint(_184 + 1);
                int _201 = int(_95[_167].SimulIndices.y) * 3;
                uint _205 = uint(_201 + 1);
                int _215 = int(_95[_167].SimulIndices.z) * 3;
                uint _219 = uint(_215 + 1);
                _161 = _160 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_184))).xy, ClothSimulVertsPositionsNormals.read(uint(_189)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_189)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_184 + 2))).xy, 0.0)).xyz * _95[_167].BaryCoordPos.w)) * _95[_167].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_201))).xy, ClothSimulVertsPositionsNormals.read(uint(_205)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_205)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_201 + 2))).xy, 0.0)).xyz * _95[_167].BaryCoordPos.w)) * _95[_167].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_215))).xy, ClothSimulVertsPositionsNormals.read(uint(_219)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_219)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_215 + 2))).xy, 0.0)).xyz * _95[_167].BaryCoordPos.w)) * ((1.0 - _95[_167].BaryCoordPos.x) - _95[_167].BaryCoordPos.y))) * _95[_167].Weight);
                _164 = _163 + _95[_167].Weight;
                _166 = _165 + 1;
            }
            else
            {
                _161 = _160;
                _164 = _163;
                _166 = _165;
            }
        }
        float3 _284;
        if ((_165 > 0) && (_163 > 9.9999997473787516355514526367188e-05))
        {
            _284 = _160 * (1.0 / _163);
        }
        else
        {
            _284 = float3(0.0);
        }
        _285 = _284;
    }
    else
    {
        _285 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _287 = float4(in.in_var_ATTRIBUTE4.x);
    int _290 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _304 = float4(in.in_var_ATTRIBUTE4.y);
    int _307 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _323 = float4(in.in_var_ATTRIBUTE4.z);
    int _326 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _342 = float4(in.in_var_ATTRIBUTE4.w);
    int _345 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _357 = (((_287 * BoneMatrices.read(uint(uint(_290)))) + (_304 * BoneMatrices.read(uint(uint(_307))))) + (_323 * BoneMatrices.read(uint(uint(_326))))) + (_342 * BoneMatrices.read(uint(uint(_345))));
    float4 _358 = (((_287 * BoneMatrices.read(uint(uint(_290 + 1)))) + (_304 * BoneMatrices.read(uint(uint(_307 + 1))))) + (_323 * BoneMatrices.read(uint(uint(_326 + 1))))) + (_342 * BoneMatrices.read(uint(uint(_345 + 1))));
    float4 _359 = (((_287 * BoneMatrices.read(uint(uint(_290 + 2)))) + (_304 * BoneMatrices.read(uint(uint(_307 + 2))))) + (_323 * BoneMatrices.read(uint(uint(_326 + 2))))) + (_342 * BoneMatrices.read(uint(uint(_345 + 2))));
    float3x4 _443;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _367 = float4(in.in_var_ATTRIBUTE15.x);
        int _370 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _386 = float4(in.in_var_ATTRIBUTE15.y);
        int _389 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _405 = float4(in.in_var_ATTRIBUTE15.z);
        int _408 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _424 = float4(in.in_var_ATTRIBUTE15.w);
        int _427 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _443 = float3x4((((_357 + (_367 * BoneMatrices.read(uint(uint(_370))))) + (_386 * BoneMatrices.read(uint(uint(_389))))) + (_405 * BoneMatrices.read(uint(uint(_408))))) + (_424 * BoneMatrices.read(uint(uint(_427)))), (((_358 + (_367 * BoneMatrices.read(uint(uint(_370 + 1))))) + (_386 * BoneMatrices.read(uint(uint(_389 + 1))))) + (_405 * BoneMatrices.read(uint(uint(_408 + 1))))) + (_424 * BoneMatrices.read(uint(uint(_427 + 1)))), (((_359 + (_367 * BoneMatrices.read(uint(uint(_370 + 2))))) + (_386 * BoneMatrices.read(uint(uint(_389 + 2))))) + (_405 * BoneMatrices.read(uint(uint(_408 + 2))))) + (_424 * BoneMatrices.read(uint(uint(_427 + 2)))));
    }
    else
    {
        _443 = float3x4(_357, _358, _359);
    }
    spvUnsafeArray<FClothVertex, 5> _93;
    _93 = _94;
    float _626;
    float3x3 _627;
    if (_93[0].SimulIndices.w < 65535u)
    {
        float _455;
        float3 _458;
        float3 _460;
        float _462;
        int _464;
        _455 = _Globals.ClothBlendWeight;
        _458 = float3(0.0);
        _460 = float3(0.0);
        _462 = 0.0;
        _464 = 0;
        float _456;
        float3 _459;
        float3 _461;
        float _463;
        int _465;
        for (int _466 = 0; _466 < 5; _455 = _456, _458 = _459, _460 = _461, _462 = _463, _464 = _465, _466++)
        {
            bool _478 = _93[_466].SimulIndices.w < 65535u;
            if (_478)
            {
                int _484 = int(_93[_466].SimulIndices.x) * 3;
                uint _489 = uint(_484 + 1);
                float3 _498 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_484))).xy, ClothSimulVertsPositionsNormals.read(uint(_489)).x, 1.0)).xyz;
                int _501 = int(_93[_466].SimulIndices.y) * 3;
                uint _505 = uint(_501 + 1);
                float3 _512 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_501))).xy, ClothSimulVertsPositionsNormals.read(uint(_505)).x, 1.0)).xyz;
                int _515 = int(_93[_466].SimulIndices.z) * 3;
                uint _519 = uint(_515 + 1);
                float3 _526 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_515))).xy, ClothSimulVertsPositionsNormals.read(uint(_519)).x, 1.0)).xyz;
                float3 _536 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_489)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_484 + 2))).xy, 0.0)).xyz;
                float3 _546 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_505)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_501 + 2))).xy, 0.0)).xyz;
                float3 _556 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_519)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_515 + 2))).xy, 0.0)).xyz;
                _459 = _458 + (((((_498 + (_536 * _93[_466].BaryCoordNormal.w)) * _93[_466].BaryCoordNormal.x) + ((_512 + (_546 * _93[_466].BaryCoordNormal.w)) * _93[_466].BaryCoordNormal.y)) + ((_526 + (_556 * _93[_466].BaryCoordNormal.w)) * _93[_466].BaryCoordNormal.z)) * _93[_466].Weight);
                _461 = _460 + (((((_498 + (_536 * _93[_466].BaryCoordTangent.w)) * _93[_466].BaryCoordTangent.x) + ((_512 + (_546 * _93[_466].BaryCoordTangent.w)) * _93[_466].BaryCoordTangent.y)) + ((_526 + (_556 * _93[_466].BaryCoordTangent.w)) * _93[_466].BaryCoordTangent.z)) * _93[_466].Weight);
                _463 = _462 + _93[_466].Weight;
                _465 = _464 + 1;
            }
            else
            {
                _459 = _458;
                _461 = _460;
                _463 = _462;
                _465 = _464;
            }
            _456 = _478 ? _Globals.ClothBlendWeight : _455;
        }
        bool _594 = (_464 > 0) && (_462 > 9.9999997473787516355514526367188e-05);
        float3x3 _618;
        if (_594)
        {
            float _598 = 1.0 / _462;
            float3x3 _613 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _615 = _90;
            _615[0] = _613 * normalize((_460 * _598) - _285);
            float3x3 _617 = _615;
            _617[2] = _613 * normalize((_458 * _598) - _285);
            _618 = _617;
        }
        else
        {
            _618 = _90;
        }
        float3x3 _625 = _618;
        _625[1] = cross(_618[2], _618[0]) * in.in_var_ATTRIBUTE2.w;
        _626 = _594 ? _455 : 0.0;
        _627 = _625;
    }
    else
    {
        _626 = 0.0;
        _627 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _633 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _443);
    float3 _639 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _443);
    float3 _644 = float3(_626);
    float3 _652 = float3(1.0 - _626);
    float4 _727;
    switch (0u)
    {
        default:
        {
            if (_94[0].SimulIndices.w < 65535u)
            {
                _727 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _443) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _285, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _676 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _443) + in.in_var_ATTRIBUTE12;
                _727 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _676.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _676.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _676.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _731 = View.View_TranslatedWorldToClip * float4(_727.x, _727.y, _727.z, _727.w);
    float4 _732 = _91;
    _732.w = 0.0;
    float3x3 _746 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _746[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _749 = _746;
    _749[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _752 = _749;
    _752[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _753 = _752 * float3x3((_627[0] * _644) + (_633 * _652), (_627[1] * _644) + (normalize(cross(_639, _633) * in.in_var_ATTRIBUTE2.w) * _652), (_627[2] * _644) + (_639 * _652));
    float3 _754 = _753[0];
    out.out_var_TEXCOORD10_centroid = float4(_754.x, _754.y, _754.z, _732.w);
    out.out_var_TEXCOORD11_centroid = float4(_753[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_727.x, _727.y, _727.z, _727.w);
    out.gl_Position = _731;
    return out;
}

