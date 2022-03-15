

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

constant float3x3 _89 = {};
constant float4 _90 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
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

vertex Main_out Main_00003d26_0eb8ce03(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _93;
    for (int _117 = 0; _117 < 5; )
    {
        uint _125 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_117)) * 4u;
        _93[_117].BaryCoordPos = GPUSkinApexCloth.read(uint(_125));
        _93[_117].BaryCoordNormal = GPUSkinApexCloth.read(uint((_125 + 1u)));
        _93[_117].BaryCoordTangent = GPUSkinApexCloth.read(uint((_125 + 2u)));
        uint4 _137 = as_type<uint4>(GPUSkinApexCloth.read(uint((_125 + 3u))));
        uint2 _138 = _137.xy;
        uint2 _141 = (_138 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _93[_117].SimulIndices = uint4(_93[_117].SimulIndices.x, _141.x, _93[_117].SimulIndices.z, _141.y);
        uint2 _145 = _138 & uint2(65535u);
        _93[_117].SimulIndices = uint4(_145.x, _93[_117].SimulIndices.y, _145.y, _93[_117].SimulIndices.w);
        _93[_117].Weight = as_type<float>(_137.z);
        _117++;
        continue;
    }
    float3 _286;
    if (_93[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _94;
        _94 = _93;
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
            if (_94[_168].SimulIndices.w < 65535u)
            {
                int _185 = int(_94[_168].SimulIndices.x) * 3;
                uint _190 = uint(_185 + 1);
                int _202 = int(_94[_168].SimulIndices.y) * 3;
                uint _206 = uint(_202 + 1);
                int _216 = int(_94[_168].SimulIndices.z) * 3;
                uint _220 = uint(_216 + 1);
                _162 = _161 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_185))).xy, ClothSimulVertsPositionsNormals.read(uint(_190)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_190)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_185 + 2))).xy, 0.0)).xyz * _94[_168].BaryCoordPos.w)) * _94[_168].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_202))).xy, ClothSimulVertsPositionsNormals.read(uint(_206)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_206)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_202 + 2))).xy, 0.0)).xyz * _94[_168].BaryCoordPos.w)) * _94[_168].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_216))).xy, ClothSimulVertsPositionsNormals.read(uint(_220)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_220)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_216 + 2))).xy, 0.0)).xyz * _94[_168].BaryCoordPos.w)) * ((1.0 - _94[_168].BaryCoordPos.x) - _94[_168].BaryCoordPos.y))) * _94[_168].Weight);
                _165 = _164 + _94[_168].Weight;
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
    float4 _288 = float4(in.in_var_ATTRIBUTE4.x);
    int _291 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _305 = float4(in.in_var_ATTRIBUTE4.y);
    int _308 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _324 = float4(in.in_var_ATTRIBUTE4.z);
    int _327 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _343 = float4(in.in_var_ATTRIBUTE4.w);
    int _346 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _358 = (((_288 * BoneMatrices.read(uint(uint(_291)))) + (_305 * BoneMatrices.read(uint(uint(_308))))) + (_324 * BoneMatrices.read(uint(uint(_327))))) + (_343 * BoneMatrices.read(uint(uint(_346))));
    float4 _359 = (((_288 * BoneMatrices.read(uint(uint(_291 + 1)))) + (_305 * BoneMatrices.read(uint(uint(_308 + 1))))) + (_324 * BoneMatrices.read(uint(uint(_327 + 1))))) + (_343 * BoneMatrices.read(uint(uint(_346 + 1))));
    float4 _360 = (((_288 * BoneMatrices.read(uint(uint(_291 + 2)))) + (_305 * BoneMatrices.read(uint(uint(_308 + 2))))) + (_324 * BoneMatrices.read(uint(uint(_327 + 2))))) + (_343 * BoneMatrices.read(uint(uint(_346 + 2))));
    float3x4 _444;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _368 = float4(in.in_var_ATTRIBUTE15.x);
        int _371 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _387 = float4(in.in_var_ATTRIBUTE15.y);
        int _390 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _406 = float4(in.in_var_ATTRIBUTE15.z);
        int _409 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _425 = float4(in.in_var_ATTRIBUTE15.w);
        int _428 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _444 = float3x4((((_358 + (_368 * BoneMatrices.read(uint(uint(_371))))) + (_387 * BoneMatrices.read(uint(uint(_390))))) + (_406 * BoneMatrices.read(uint(uint(_409))))) + (_425 * BoneMatrices.read(uint(uint(_428)))), (((_359 + (_368 * BoneMatrices.read(uint(uint(_371 + 1))))) + (_387 * BoneMatrices.read(uint(uint(_390 + 1))))) + (_406 * BoneMatrices.read(uint(uint(_409 + 1))))) + (_425 * BoneMatrices.read(uint(uint(_428 + 1)))), (((_360 + (_368 * BoneMatrices.read(uint(uint(_371 + 2))))) + (_387 * BoneMatrices.read(uint(uint(_390 + 2))))) + (_406 * BoneMatrices.read(uint(uint(_409 + 2))))) + (_425 * BoneMatrices.read(uint(uint(_428 + 2)))));
    }
    else
    {
        _444 = float3x4(_358, _359, _360);
    }
    spvUnsafeArray<FClothVertex, 5> _92;
    _92 = _93;
    float _627;
    float3x3 _628;
    if (_92[0].SimulIndices.w < 65535u)
    {
        float _456;
        float3 _459;
        float3 _461;
        float _463;
        int _465;
        _456 = _Globals.ClothBlendWeight;
        _459 = float3(0.0);
        _461 = float3(0.0);
        _463 = 0.0;
        _465 = 0;
        float _457;
        float3 _460;
        float3 _462;
        float _464;
        int _466;
        for (int _467 = 0; _467 < 5; _456 = _457, _459 = _460, _461 = _462, _463 = _464, _465 = _466, _467++)
        {
            bool _479 = _92[_467].SimulIndices.w < 65535u;
            if (_479)
            {
                int _485 = int(_92[_467].SimulIndices.x) * 3;
                uint _490 = uint(_485 + 1);
                float3 _499 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_485))).xy, ClothSimulVertsPositionsNormals.read(uint(_490)).x, 1.0)).xyz;
                int _502 = int(_92[_467].SimulIndices.y) * 3;
                uint _506 = uint(_502 + 1);
                float3 _513 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_502))).xy, ClothSimulVertsPositionsNormals.read(uint(_506)).x, 1.0)).xyz;
                int _516 = int(_92[_467].SimulIndices.z) * 3;
                uint _520 = uint(_516 + 1);
                float3 _527 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_516))).xy, ClothSimulVertsPositionsNormals.read(uint(_520)).x, 1.0)).xyz;
                float3 _537 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_490)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_485 + 2))).xy, 0.0)).xyz;
                float3 _547 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_506)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_502 + 2))).xy, 0.0)).xyz;
                float3 _557 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_520)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_516 + 2))).xy, 0.0)).xyz;
                _460 = _459 + (((((_499 + (_537 * _92[_467].BaryCoordNormal.w)) * _92[_467].BaryCoordNormal.x) + ((_513 + (_547 * _92[_467].BaryCoordNormal.w)) * _92[_467].BaryCoordNormal.y)) + ((_527 + (_557 * _92[_467].BaryCoordNormal.w)) * _92[_467].BaryCoordNormal.z)) * _92[_467].Weight);
                _462 = _461 + (((((_499 + (_537 * _92[_467].BaryCoordTangent.w)) * _92[_467].BaryCoordTangent.x) + ((_513 + (_547 * _92[_467].BaryCoordTangent.w)) * _92[_467].BaryCoordTangent.y)) + ((_527 + (_557 * _92[_467].BaryCoordTangent.w)) * _92[_467].BaryCoordTangent.z)) * _92[_467].Weight);
                _464 = _463 + _92[_467].Weight;
                _466 = _465 + 1;
            }
            else
            {
                _460 = _459;
                _462 = _461;
                _464 = _463;
                _466 = _465;
            }
            _457 = _479 ? _Globals.ClothBlendWeight : _456;
        }
        bool _595 = (_465 > 0) && (_463 > 9.9999997473787516355514526367188e-05);
        float3x3 _619;
        if (_595)
        {
            float _599 = 1.0 / _463;
            float3x3 _614 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _616 = _89;
            _616[0] = _614 * normalize((_461 * _599) - _286);
            float3x3 _618 = _616;
            _618[2] = _614 * normalize((_459 * _599) - _286);
            _619 = _618;
        }
        else
        {
            _619 = _89;
        }
        float3x3 _626 = _619;
        _626[1] = cross(_619[2], _619[0]) * in.in_var_ATTRIBUTE2.w;
        _627 = _595 ? _456 : 0.0;
        _628 = _626;
    }
    else
    {
        _627 = 0.0;
        _628 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _634 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _444);
    float3 _640 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _444);
    float3 _645 = float3(_627);
    float3 _653 = float3(1.0 - _627);
    float4 _728;
    switch (0u)
    {
        default:
        {
            if (_93[0].SimulIndices.w < 65535u)
            {
                _728 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _444) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _286, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _677 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _444) + in.in_var_ATTRIBUTE12;
                _728 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _677.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _677.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _677.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _730 = View.View_TranslatedWorldToClip * float4(_728.x, _728.y, _728.z, _728.w);
    float4 _731 = _90;
    _731.w = 0.0;
    float3x3 _745 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _745[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _748 = _745;
    _748[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _751 = _748;
    _751[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _752 = _751 * float3x3((_628[0] * _645) + (_634 * _653), (_628[1] * _645) + (normalize(cross(_640, _634) * in.in_var_ATTRIBUTE2.w) * _653), (_628[2] * _645) + (_640 * _653));
    float3 _753 = _752[0];
    out.out_var_TEXCOORD10_centroid = float4(_753.x, _753.y, _753.z, _731.w);
    out.out_var_TEXCOORD11_centroid = float4(_752[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _730;
    return out;
}

