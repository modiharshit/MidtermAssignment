

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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

constant float _98 = {};
constant float3x3 _99 = {};
constant float4 _100 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
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

vertex Main_out Main_00004329_30642585(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _103;
    for (int _125 = 0; _125 < 5; )
    {
        uint _133 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_125)) * 4u;
        _103[_125].BaryCoordPos = GPUSkinApexCloth.read(uint(_133));
        _103[_125].BaryCoordNormal = GPUSkinApexCloth.read(uint((_133 + 1u)));
        _103[_125].BaryCoordTangent = GPUSkinApexCloth.read(uint((_133 + 2u)));
        uint4 _145 = as_type<uint4>(GPUSkinApexCloth.read(uint((_133 + 3u))));
        uint2 _146 = _145.xy;
        uint2 _149 = (_146 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _103[_125].SimulIndices = uint4(_103[_125].SimulIndices.x, _149.x, _103[_125].SimulIndices.z, _149.y);
        uint2 _153 = _146 & uint2(65535u);
        _103[_125].SimulIndices = uint4(_153.x, _103[_125].SimulIndices.y, _153.y, _103[_125].SimulIndices.w);
        _103[_125].Weight = as_type<float>(_145.z);
        _125++;
        continue;
    }
    float3 _294;
    if (_103[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _104;
        _104 = _103;
        float3 _169;
        float _172;
        int _174;
        _169 = float3(0.0);
        _172 = 0.0;
        _174 = 0;
        float3 _170;
        float _173;
        int _175;
        for (int _176 = 0; _176 < 5; _169 = _170, _172 = _173, _174 = _175, _176++)
        {
            if (_104[_176].SimulIndices.w < 65535u)
            {
                int _193 = int(_104[_176].SimulIndices.x) * 3;
                uint _198 = uint(_193 + 1);
                int _210 = int(_104[_176].SimulIndices.y) * 3;
                uint _214 = uint(_210 + 1);
                int _224 = int(_104[_176].SimulIndices.z) * 3;
                uint _228 = uint(_224 + 1);
                _170 = _169 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_193))).xy, ClothSimulVertsPositionsNormals.read(uint(_198)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_198)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_193 + 2))).xy, 0.0)).xyz * _104[_176].BaryCoordPos.w)) * _104[_176].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_210))).xy, ClothSimulVertsPositionsNormals.read(uint(_214)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_214)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_210 + 2))).xy, 0.0)).xyz * _104[_176].BaryCoordPos.w)) * _104[_176].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_224))).xy, ClothSimulVertsPositionsNormals.read(uint(_228)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_228)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_224 + 2))).xy, 0.0)).xyz * _104[_176].BaryCoordPos.w)) * ((1.0 - _104[_176].BaryCoordPos.x) - _104[_176].BaryCoordPos.y))) * _104[_176].Weight);
                _173 = _172 + _104[_176].Weight;
                _175 = _174 + 1;
            }
            else
            {
                _170 = _169;
                _173 = _172;
                _175 = _174;
            }
        }
        float3 _293;
        if ((_174 > 0) && (_172 > 9.9999997473787516355514526367188e-05))
        {
            _293 = _169 * (1.0 / _172);
        }
        else
        {
            _293 = float3(0.0);
        }
        _294 = _293;
    }
    else
    {
        _294 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _296 = float4(in.in_var_ATTRIBUTE4.x);
    int _299 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _313 = float4(in.in_var_ATTRIBUTE4.y);
    int _316 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _332 = float4(in.in_var_ATTRIBUTE4.z);
    int _335 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _351 = float4(in.in_var_ATTRIBUTE4.w);
    int _354 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _366 = (((_296 * BoneMatrices.read(uint(uint(_299)))) + (_313 * BoneMatrices.read(uint(uint(_316))))) + (_332 * BoneMatrices.read(uint(uint(_335))))) + (_351 * BoneMatrices.read(uint(uint(_354))));
    float4 _367 = (((_296 * BoneMatrices.read(uint(uint(_299 + 1)))) + (_313 * BoneMatrices.read(uint(uint(_316 + 1))))) + (_332 * BoneMatrices.read(uint(uint(_335 + 1))))) + (_351 * BoneMatrices.read(uint(uint(_354 + 1))));
    float4 _368 = (((_296 * BoneMatrices.read(uint(uint(_299 + 2)))) + (_313 * BoneMatrices.read(uint(uint(_316 + 2))))) + (_332 * BoneMatrices.read(uint(uint(_335 + 2))))) + (_351 * BoneMatrices.read(uint(uint(_354 + 2))));
    float3x4 _452;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _376 = float4(in.in_var_ATTRIBUTE15.x);
        int _379 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _395 = float4(in.in_var_ATTRIBUTE15.y);
        int _398 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _414 = float4(in.in_var_ATTRIBUTE15.z);
        int _417 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _433 = float4(in.in_var_ATTRIBUTE15.w);
        int _436 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _452 = float3x4((((_366 + (_376 * BoneMatrices.read(uint(uint(_379))))) + (_395 * BoneMatrices.read(uint(uint(_398))))) + (_414 * BoneMatrices.read(uint(uint(_417))))) + (_433 * BoneMatrices.read(uint(uint(_436)))), (((_367 + (_376 * BoneMatrices.read(uint(uint(_379 + 1))))) + (_395 * BoneMatrices.read(uint(uint(_398 + 1))))) + (_414 * BoneMatrices.read(uint(uint(_417 + 1))))) + (_433 * BoneMatrices.read(uint(uint(_436 + 1)))), (((_368 + (_376 * BoneMatrices.read(uint(uint(_379 + 2))))) + (_395 * BoneMatrices.read(uint(uint(_398 + 2))))) + (_414 * BoneMatrices.read(uint(uint(_417 + 2))))) + (_433 * BoneMatrices.read(uint(uint(_436 + 2)))));
    }
    else
    {
        _452 = float3x4(_366, _367, _368);
    }
    spvUnsafeArray<FClothVertex, 5> _102;
    _102 = _103;
    float _635;
    float3x3 _636;
    if (_102[0].SimulIndices.w < 65535u)
    {
        float _464;
        float3 _467;
        float3 _469;
        float _471;
        int _473;
        _464 = _Globals.ClothBlendWeight;
        _467 = float3(0.0);
        _469 = float3(0.0);
        _471 = 0.0;
        _473 = 0;
        float _465;
        float3 _468;
        float3 _470;
        float _472;
        int _474;
        for (int _475 = 0; _475 < 5; _464 = _465, _467 = _468, _469 = _470, _471 = _472, _473 = _474, _475++)
        {
            bool _487 = _102[_475].SimulIndices.w < 65535u;
            if (_487)
            {
                int _493 = int(_102[_475].SimulIndices.x) * 3;
                uint _498 = uint(_493 + 1);
                float3 _507 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_493))).xy, ClothSimulVertsPositionsNormals.read(uint(_498)).x, 1.0)).xyz;
                int _510 = int(_102[_475].SimulIndices.y) * 3;
                uint _514 = uint(_510 + 1);
                float3 _521 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_510))).xy, ClothSimulVertsPositionsNormals.read(uint(_514)).x, 1.0)).xyz;
                int _524 = int(_102[_475].SimulIndices.z) * 3;
                uint _528 = uint(_524 + 1);
                float3 _535 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_524))).xy, ClothSimulVertsPositionsNormals.read(uint(_528)).x, 1.0)).xyz;
                float3 _545 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_498)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_493 + 2))).xy, 0.0)).xyz;
                float3 _555 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_514)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_510 + 2))).xy, 0.0)).xyz;
                float3 _565 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_528)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_524 + 2))).xy, 0.0)).xyz;
                _468 = _467 + (((((_507 + (_545 * _102[_475].BaryCoordNormal.w)) * _102[_475].BaryCoordNormal.x) + ((_521 + (_555 * _102[_475].BaryCoordNormal.w)) * _102[_475].BaryCoordNormal.y)) + ((_535 + (_565 * _102[_475].BaryCoordNormal.w)) * _102[_475].BaryCoordNormal.z)) * _102[_475].Weight);
                _470 = _469 + (((((_507 + (_545 * _102[_475].BaryCoordTangent.w)) * _102[_475].BaryCoordTangent.x) + ((_521 + (_555 * _102[_475].BaryCoordTangent.w)) * _102[_475].BaryCoordTangent.y)) + ((_535 + (_565 * _102[_475].BaryCoordTangent.w)) * _102[_475].BaryCoordTangent.z)) * _102[_475].Weight);
                _472 = _471 + _102[_475].Weight;
                _474 = _473 + 1;
            }
            else
            {
                _468 = _467;
                _470 = _469;
                _472 = _471;
                _474 = _473;
            }
            _465 = _487 ? _Globals.ClothBlendWeight : _464;
        }
        bool _603 = (_473 > 0) && (_471 > 9.9999997473787516355514526367188e-05);
        float3x3 _627;
        if (_603)
        {
            float _607 = 1.0 / _471;
            float3x3 _622 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _624 = _99;
            _624[0] = _622 * normalize((_469 * _607) - _294);
            float3x3 _626 = _624;
            _626[2] = _622 * normalize((_467 * _607) - _294);
            _627 = _626;
        }
        else
        {
            _627 = _99;
        }
        float3x3 _634 = _627;
        _634[1] = cross(_627[2], _627[0]) * in.in_var_ATTRIBUTE2.w;
        _635 = _603 ? _464 : 0.0;
        _636 = _634;
    }
    else
    {
        _635 = 0.0;
        _636 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _642 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _452);
    float3 _648 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _452);
    float3 _653 = float3(_635);
    float3 _661 = float3(1.0 - _635);
    float4 _736;
    switch (0u)
    {
        default:
        {
            if (_103[0].SimulIndices.w < 65535u)
            {
                _736 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _452) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _294, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _685 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _452) + in.in_var_ATTRIBUTE12;
                _736 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _685.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _685.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _685.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _750 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _750[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _753 = _750;
    _753[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _756 = _753;
    _756[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _757 = _756 * float3x3((_636[0] * _653) + (_642 * _661), (_636[1] * _653) + (normalize(cross(_648, _642) * in.in_var_ATTRIBUTE2.w) * _661), (_636[2] * _653) + (_648 * _661));
    float3 _758 = _757[2];
    float _759 = _758.x;
    float4 _769 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_736.x, _736.y, _736.z, _736.w);
    float4 _780;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_769.z < 0.0))
    {
        float4 _778 = _769;
        _778.z = 9.9999999747524270787835121154785e-07;
        float4 _779 = _778;
        _779.w = 1.0;
        _780 = _779;
    }
    else
    {
        _780 = _769;
    }
    float _786 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_759, _758.yz, _98).xyz));
    float4 _811 = _780;
    _811.z = ((_780.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_786) > 0.0) ? (sqrt(fast::clamp(1.0 - (_786 * _786), 0.0, 1.0)) / _786) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _780.w;
    float4 _812 = _100;
    _812.w = 0.0;
    float3 _813 = _757[0];
    out.out_var_TEXCOORD10_centroid = float4(_813.x, _813.y, _813.z, _812.w);
    out.out_var_TEXCOORD11_centroid = float4(_759, _758.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _736.xyz;
    out.gl_Position = _811;
    return out;
}

