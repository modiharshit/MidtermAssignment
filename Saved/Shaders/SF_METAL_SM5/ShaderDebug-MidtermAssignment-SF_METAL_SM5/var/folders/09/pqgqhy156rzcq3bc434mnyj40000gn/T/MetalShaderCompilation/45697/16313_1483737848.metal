

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    char _m2_pad[64];
    float ClothBlendWeight;
    packed_uint2 GPUSkinApexClothStartIndexOffset;
    uint LayerId;
};

struct FClothVertex
{
    float4 BaryCoordPos;
    float4 BaryCoordNormal;
    float4 BaryCoordTangent;
    uint4 SimulIndices;
    float Weight;
};

constant float _99 = {};
constant float3x3 _100 = {};
constant float4 _101 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
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

vertex Main_out Main_00003fb9_58700af8(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _104;
    for (int _126 = 0; _126 < 1; )
    {
        uint _133 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_126)) * 4u;
        _104[_126].BaryCoordPos = GPUSkinApexCloth.read(uint(_133));
        _104[_126].BaryCoordNormal = GPUSkinApexCloth.read(uint((_133 + 1u)));
        _104[_126].BaryCoordTangent = GPUSkinApexCloth.read(uint((_133 + 2u)));
        uint4 _145 = as_type<uint4>(GPUSkinApexCloth.read(uint((_133 + 3u))));
        uint2 _146 = _145.xy;
        uint2 _149 = (_146 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _104[_126].SimulIndices = uint4(_104[_126].SimulIndices.x, _149.x, _104[_126].SimulIndices.z, _149.y);
        uint2 _153 = _146 & uint2(65535u);
        _104[_126].SimulIndices = uint4(_153.x, _104[_126].SimulIndices.y, _153.y, _104[_126].SimulIndices.w);
        _104[_126].Weight = as_type<float>(_145.z);
        _126++;
        continue;
    }
    float3 _292;
    if (_104[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _105;
        _105 = _104;
        float3 _169;
        float _172;
        int _174;
        _169 = float3(0.0);
        _172 = 0.0;
        _174 = 0;
        float _173;
        float3 _170;
        int _175;
        for (int _176 = 0; _176 < 1; _169 = _170, _172 = _173, _174 = _175, _176++)
        {
            bool _186 = _105[_176].SimulIndices.w < 65535u;
            if (_186)
            {
                int _192 = int(_105[_176].SimulIndices.x) * 3;
                uint _197 = uint(_192 + 1);
                int _209 = int(_105[_176].SimulIndices.y) * 3;
                uint _213 = uint(_209 + 1);
                int _223 = int(_105[_176].SimulIndices.z) * 3;
                uint _227 = uint(_223 + 1);
                _170 = _169 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_192))).xy, ClothSimulVertsPositionsNormals.read(uint(_197)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_197)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_192 + 2))).xy, 0.0)).xyz * _105[_176].BaryCoordPos.w)) * _105[_176].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_209))).xy, ClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_213)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_209 + 2))).xy, 0.0)).xyz * _105[_176].BaryCoordPos.w)) * _105[_176].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_223))).xy, ClothSimulVertsPositionsNormals.read(uint(_227)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_227)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_223 + 2))).xy, 0.0)).xyz * _105[_176].BaryCoordPos.w)) * ((1.0 - _105[_176].BaryCoordPos.x) - _105[_176].BaryCoordPos.y))) * 1.0);
                _175 = _174 + 1;
            }
            else
            {
                _170 = _169;
                _175 = _174;
            }
            _173 = _186 ? 1.0 : _172;
        }
        float3 _291;
        if ((_174 > 0) && (_172 > 9.9999997473787516355514526367188e-05))
        {
            _291 = _169 * (1.0 / _172);
        }
        else
        {
            _291 = float3(0.0);
        }
        _292 = _291;
    }
    else
    {
        _292 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _294 = float4(in.in_var_ATTRIBUTE4.x);
    int _297 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _311 = float4(in.in_var_ATTRIBUTE4.y);
    int _314 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _330 = float4(in.in_var_ATTRIBUTE4.z);
    int _333 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _349 = float4(in.in_var_ATTRIBUTE4.w);
    int _352 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _364 = (((_294 * BoneMatrices.read(uint(uint(_297)))) + (_311 * BoneMatrices.read(uint(uint(_314))))) + (_330 * BoneMatrices.read(uint(uint(_333))))) + (_349 * BoneMatrices.read(uint(uint(_352))));
    float4 _365 = (((_294 * BoneMatrices.read(uint(uint(_297 + 1)))) + (_311 * BoneMatrices.read(uint(uint(_314 + 1))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 1))))) + (_349 * BoneMatrices.read(uint(uint(_352 + 1))));
    float4 _366 = (((_294 * BoneMatrices.read(uint(uint(_297 + 2)))) + (_311 * BoneMatrices.read(uint(uint(_314 + 2))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 2))))) + (_349 * BoneMatrices.read(uint(uint(_352 + 2))));
    float3x4 _450;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _374 = float4(in.in_var_ATTRIBUTE15.x);
        int _377 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _393 = float4(in.in_var_ATTRIBUTE15.y);
        int _396 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _412 = float4(in.in_var_ATTRIBUTE15.z);
        int _415 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _431 = float4(in.in_var_ATTRIBUTE15.w);
        int _434 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _450 = float3x4((((_364 + (_374 * BoneMatrices.read(uint(uint(_377))))) + (_393 * BoneMatrices.read(uint(uint(_396))))) + (_412 * BoneMatrices.read(uint(uint(_415))))) + (_431 * BoneMatrices.read(uint(uint(_434)))), (((_365 + (_374 * BoneMatrices.read(uint(uint(_377 + 1))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 1))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 1))))) + (_431 * BoneMatrices.read(uint(uint(_434 + 1)))), (((_366 + (_374 * BoneMatrices.read(uint(uint(_377 + 2))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 2))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 2))))) + (_431 * BoneMatrices.read(uint(uint(_434 + 2)))));
    }
    else
    {
        _450 = float3x4(_364, _365, _366);
    }
    spvUnsafeArray<FClothVertex, 1> _103;
    _103 = _104;
    float _631;
    float3x3 _632;
    if (_103[0].SimulIndices.w < 65535u)
    {
        float _462;
        float3 _465;
        float3 _467;
        float _469;
        int _471;
        _462 = _Globals.ClothBlendWeight;
        _465 = float3(0.0);
        _467 = float3(0.0);
        _469 = 0.0;
        _471 = 0;
        float _463;
        float _470;
        float3 _466;
        float3 _468;
        int _472;
        for (int _473 = 0; _473 < 1; _462 = _463, _465 = _466, _467 = _468, _469 = _470, _471 = _472, _473++)
        {
            bool _484 = _103[_473].SimulIndices.w < 65535u;
            if (_484)
            {
                int _490 = int(_103[_473].SimulIndices.x) * 3;
                uint _495 = uint(_490 + 1);
                float3 _504 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_490))).xy, ClothSimulVertsPositionsNormals.read(uint(_495)).x, 1.0)).xyz;
                int _507 = int(_103[_473].SimulIndices.y) * 3;
                uint _511 = uint(_507 + 1);
                float3 _518 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_507))).xy, ClothSimulVertsPositionsNormals.read(uint(_511)).x, 1.0)).xyz;
                int _521 = int(_103[_473].SimulIndices.z) * 3;
                uint _525 = uint(_521 + 1);
                float3 _532 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_521))).xy, ClothSimulVertsPositionsNormals.read(uint(_525)).x, 1.0)).xyz;
                float3 _542 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_495)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_490 + 2))).xy, 0.0)).xyz;
                float3 _552 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_511)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_507 + 2))).xy, 0.0)).xyz;
                float3 _562 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_525)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_521 + 2))).xy, 0.0)).xyz;
                _466 = _465 + (((((_504 + (_542 * _103[_473].BaryCoordNormal.w)) * _103[_473].BaryCoordNormal.x) + ((_518 + (_552 * _103[_473].BaryCoordNormal.w)) * _103[_473].BaryCoordNormal.y)) + ((_532 + (_562 * _103[_473].BaryCoordNormal.w)) * _103[_473].BaryCoordNormal.z)) * 1.0);
                _468 = _467 + (((((_504 + (_542 * _103[_473].BaryCoordTangent.w)) * _103[_473].BaryCoordTangent.x) + ((_518 + (_552 * _103[_473].BaryCoordTangent.w)) * _103[_473].BaryCoordTangent.y)) + ((_532 + (_562 * _103[_473].BaryCoordTangent.w)) * _103[_473].BaryCoordTangent.z)) * 1.0);
                _472 = _471 + 1;
            }
            else
            {
                _466 = _465;
                _468 = _467;
                _472 = _471;
            }
            _463 = _484 ? _Globals.ClothBlendWeight : _462;
            _470 = _484 ? 1.0 : _469;
        }
        bool _599 = (_471 > 0) && (_469 > 9.9999997473787516355514526367188e-05);
        float3x3 _623;
        if (_599)
        {
            float _603 = 1.0 / _469;
            float3x3 _618 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _620 = _100;
            _620[0] = _618 * normalize((_467 * _603) - _292);
            float3x3 _622 = _620;
            _622[2] = _618 * normalize((_465 * _603) - _292);
            _623 = _622;
        }
        else
        {
            _623 = _100;
        }
        float3x3 _630 = _623;
        _630[1] = cross(_623[2], _623[0]) * in.in_var_ATTRIBUTE2.w;
        _631 = _599 ? _462 : 0.0;
        _632 = _630;
    }
    else
    {
        _631 = 0.0;
        _632 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _638 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _450);
    float3 _644 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _450);
    float3 _649 = float3(_631);
    float3 _657 = float3(1.0 - _631);
    float4 _732;
    switch (0u)
    {
        default:
        {
            if (_104[0].SimulIndices.w < 65535u)
            {
                _732 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _450) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _292, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _681 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _450) + in.in_var_ATTRIBUTE12;
                _732 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _681.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _681.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _681.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _746 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _746[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _749 = _746;
    _749[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _752 = _749;
    _752[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _753 = _752 * float3x3((_632[0] * _649) + (_638 * _657), (_632[1] * _649) + (normalize(cross(_644, _638) * in.in_var_ATTRIBUTE2.w) * _657), (_632[2] * _649) + (_644 * _657));
    float3 _754 = _753[2];
    float _755 = _754.x;
    float4 _761 = _101;
    _761.w = 0.0;
    float3 _762 = _753[0];
    float4 _773 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_732.x, _732.y, _732.z, _732.w);
    out.out_var_TEXCOORD10_centroid = float4(_762.x, _762.y, _762.z, _761.w);
    out.out_var_TEXCOORD11_centroid = float4(_755, _754.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _732.xyz;
    out.out_var_TEXCOORD6 = _773;
    out.out_var_TEXCOORD8 = float4(_755, _754.yz, _99).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _773;
    return out;
}

