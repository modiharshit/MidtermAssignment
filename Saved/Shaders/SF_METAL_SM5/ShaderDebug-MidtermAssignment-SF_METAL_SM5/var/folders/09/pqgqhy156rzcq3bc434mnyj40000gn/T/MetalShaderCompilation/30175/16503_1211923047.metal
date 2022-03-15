

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

constant spvUnsafeArray<float2, 1> _94 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _99 = {};
constant float4 _100 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00004077_483c7a67(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _104;
    for (int _128 = 0; _128 < 1; )
    {
        uint _135 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_128)) * 4u;
        _104[_128].BaryCoordPos = GPUSkinApexCloth.read(uint(_135));
        _104[_128].BaryCoordNormal = GPUSkinApexCloth.read(uint((_135 + 1u)));
        _104[_128].BaryCoordTangent = GPUSkinApexCloth.read(uint((_135 + 2u)));
        uint4 _147 = as_type<uint4>(GPUSkinApexCloth.read(uint((_135 + 3u))));
        uint2 _148 = _147.xy;
        uint2 _151 = (_148 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _104[_128].SimulIndices = uint4(_104[_128].SimulIndices.x, _151.x, _104[_128].SimulIndices.z, _151.y);
        uint2 _155 = _148 & uint2(65535u);
        _104[_128].SimulIndices = uint4(_155.x, _104[_128].SimulIndices.y, _155.y, _104[_128].SimulIndices.w);
        _104[_128].Weight = as_type<float>(_147.z);
        _128++;
        continue;
    }
    float3 _294;
    if (_104[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _106;
        _106 = _104;
        float3 _171;
        float _174;
        int _176;
        _171 = float3(0.0);
        _174 = 0.0;
        _176 = 0;
        float _175;
        float3 _172;
        int _177;
        for (int _178 = 0; _178 < 1; _171 = _172, _174 = _175, _176 = _177, _178++)
        {
            bool _188 = _106[_178].SimulIndices.w < 65535u;
            if (_188)
            {
                int _194 = int(_106[_178].SimulIndices.x) * 3;
                uint _199 = uint(_194 + 1);
                int _211 = int(_106[_178].SimulIndices.y) * 3;
                uint _215 = uint(_211 + 1);
                int _225 = int(_106[_178].SimulIndices.z) * 3;
                uint _229 = uint(_225 + 1);
                _172 = _171 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_194))).xy, ClothSimulVertsPositionsNormals.read(uint(_199)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_199)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_194 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * _106[_178].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, ClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_215)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * _106[_178].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_225))).xy, ClothSimulVertsPositionsNormals.read(uint(_229)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_229)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_225 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * ((1.0 - _106[_178].BaryCoordPos.x) - _106[_178].BaryCoordPos.y))) * 1.0);
                _177 = _176 + 1;
            }
            else
            {
                _172 = _171;
                _177 = _176;
            }
            _175 = _188 ? 1.0 : _174;
        }
        float3 _293;
        if ((_176 > 0) && (_174 > 9.9999997473787516355514526367188e-05))
        {
            _293 = _171 * (1.0 / _174);
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
    spvUnsafeArray<FClothVertex, 1> _103;
    _103 = _104;
    float _633;
    float3x3 _634;
    if (_103[0].SimulIndices.w < 65535u)
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
        float _472;
        float3 _468;
        float3 _470;
        int _474;
        for (int _475 = 0; _475 < 1; _464 = _465, _467 = _468, _469 = _470, _471 = _472, _473 = _474, _475++)
        {
            bool _486 = _103[_475].SimulIndices.w < 65535u;
            if (_486)
            {
                int _492 = int(_103[_475].SimulIndices.x) * 3;
                uint _497 = uint(_492 + 1);
                float3 _506 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_492))).xy, ClothSimulVertsPositionsNormals.read(uint(_497)).x, 1.0)).xyz;
                int _509 = int(_103[_475].SimulIndices.y) * 3;
                uint _513 = uint(_509 + 1);
                float3 _520 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_509))).xy, ClothSimulVertsPositionsNormals.read(uint(_513)).x, 1.0)).xyz;
                int _523 = int(_103[_475].SimulIndices.z) * 3;
                uint _527 = uint(_523 + 1);
                float3 _534 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_523))).xy, ClothSimulVertsPositionsNormals.read(uint(_527)).x, 1.0)).xyz;
                float3 _544 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_497)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_492 + 2))).xy, 0.0)).xyz;
                float3 _554 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_513)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_509 + 2))).xy, 0.0)).xyz;
                float3 _564 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_527)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_523 + 2))).xy, 0.0)).xyz;
                _468 = _467 + (((((_506 + (_544 * _103[_475].BaryCoordNormal.w)) * _103[_475].BaryCoordNormal.x) + ((_520 + (_554 * _103[_475].BaryCoordNormal.w)) * _103[_475].BaryCoordNormal.y)) + ((_534 + (_564 * _103[_475].BaryCoordNormal.w)) * _103[_475].BaryCoordNormal.z)) * 1.0);
                _470 = _469 + (((((_506 + (_544 * _103[_475].BaryCoordTangent.w)) * _103[_475].BaryCoordTangent.x) + ((_520 + (_554 * _103[_475].BaryCoordTangent.w)) * _103[_475].BaryCoordTangent.y)) + ((_534 + (_564 * _103[_475].BaryCoordTangent.w)) * _103[_475].BaryCoordTangent.z)) * 1.0);
                _474 = _473 + 1;
            }
            else
            {
                _468 = _467;
                _470 = _469;
                _474 = _473;
            }
            _465 = _486 ? _Globals.ClothBlendWeight : _464;
            _472 = _486 ? 1.0 : _471;
        }
        bool _601 = (_473 > 0) && (_471 > 9.9999997473787516355514526367188e-05);
        float3x3 _625;
        if (_601)
        {
            float _605 = 1.0 / _471;
            float3x3 _620 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _622 = _99;
            _622[0] = _620 * normalize((_469 * _605) - _294);
            float3x3 _624 = _622;
            _624[2] = _620 * normalize((_467 * _605) - _294);
            _625 = _624;
        }
        else
        {
            _625 = _99;
        }
        float3x3 _632 = _625;
        _632[1] = cross(_625[2], _625[0]) * in.in_var_ATTRIBUTE2.w;
        _633 = _601 ? _464 : 0.0;
        _634 = _632;
    }
    else
    {
        _633 = 0.0;
        _634 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _640 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _452);
    float3 _646 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _452);
    float3 _651 = float3(_633);
    float3 _659 = float3(1.0 - _633);
    float4 _734;
    switch (0u)
    {
        default:
        {
            if (_104[0].SimulIndices.w < 65535u)
            {
                _734 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _452) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _294, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _683 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _452) + in.in_var_ATTRIBUTE12;
                _734 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _683.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _683.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _683.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _102;
    _102 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _105 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _736 = 0; _736 < 1; )
    {
        _105[_736] = _102[_736];
        _736++;
        continue;
    }
    float4 _748 = View.View_TranslatedWorldToClip * float4(_734.x, _734.y, _734.z, _734.w);
    float4 _751 = _100;
    _751.w = 0.0;
    float3x3 _765 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _765[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _768 = _765;
    _768[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _771 = _768;
    _771[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _772 = _771 * float3x3((_634[0] * _651) + (_640 * _659), (_634[1] * _651) + (normalize(cross(_646, _640) * in.in_var_ATTRIBUTE2.w) * _659), (_634[2] * _651) + (_646 * _659));
    float3 _773 = _772[0];
    spvUnsafeArray<float4, 1> _783 = { float4(_105[0].x, _105[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_773.x, _773.y, _773.z, _751.w);
    out.out_var_TEXCOORD11_centroid = float4(_772[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _783;
    out.out_var_TEXCOORD6 = float4(_734.x, _734.y, _734.z, _734.w);
    out.gl_Position = _748;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

