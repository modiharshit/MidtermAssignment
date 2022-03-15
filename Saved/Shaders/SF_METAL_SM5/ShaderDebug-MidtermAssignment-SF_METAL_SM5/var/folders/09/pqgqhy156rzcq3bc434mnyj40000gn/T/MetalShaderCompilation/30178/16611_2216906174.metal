

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

constant spvUnsafeArray<float2, 1> _96 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _101 = {};
constant float4 _102 = {};

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

vertex Main_out Main_000040e3_84234dbe(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _106;
    for (int _130 = 0; _130 < 5; )
    {
        uint _138 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_130)) * 4u;
        _106[_130].BaryCoordPos = GPUSkinApexCloth.read(uint(_138));
        _106[_130].BaryCoordNormal = GPUSkinApexCloth.read(uint((_138 + 1u)));
        _106[_130].BaryCoordTangent = GPUSkinApexCloth.read(uint((_138 + 2u)));
        uint4 _150 = as_type<uint4>(GPUSkinApexCloth.read(uint((_138 + 3u))));
        uint2 _151 = _150.xy;
        uint2 _154 = (_151 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _106[_130].SimulIndices = uint4(_106[_130].SimulIndices.x, _154.x, _106[_130].SimulIndices.z, _154.y);
        uint2 _158 = _151 & uint2(65535u);
        _106[_130].SimulIndices = uint4(_158.x, _106[_130].SimulIndices.y, _158.y, _106[_130].SimulIndices.w);
        _106[_130].Weight = as_type<float>(_150.z);
        _130++;
        continue;
    }
    float3 _299;
    if (_106[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _108;
        _108 = _106;
        float3 _174;
        float _177;
        int _179;
        _174 = float3(0.0);
        _177 = 0.0;
        _179 = 0;
        float3 _175;
        float _178;
        int _180;
        for (int _181 = 0; _181 < 5; _174 = _175, _177 = _178, _179 = _180, _181++)
        {
            if (_108[_181].SimulIndices.w < 65535u)
            {
                int _198 = int(_108[_181].SimulIndices.x) * 3;
                uint _203 = uint(_198 + 1);
                int _215 = int(_108[_181].SimulIndices.y) * 3;
                uint _219 = uint(_215 + 1);
                int _229 = int(_108[_181].SimulIndices.z) * 3;
                uint _233 = uint(_229 + 1);
                _175 = _174 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_198))).xy, ClothSimulVertsPositionsNormals.read(uint(_203)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_203)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_198 + 2))).xy, 0.0)).xyz * _108[_181].BaryCoordPos.w)) * _108[_181].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_215))).xy, ClothSimulVertsPositionsNormals.read(uint(_219)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_219)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_215 + 2))).xy, 0.0)).xyz * _108[_181].BaryCoordPos.w)) * _108[_181].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_229))).xy, ClothSimulVertsPositionsNormals.read(uint(_233)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_233)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_229 + 2))).xy, 0.0)).xyz * _108[_181].BaryCoordPos.w)) * ((1.0 - _108[_181].BaryCoordPos.x) - _108[_181].BaryCoordPos.y))) * _108[_181].Weight);
                _178 = _177 + _108[_181].Weight;
                _180 = _179 + 1;
            }
            else
            {
                _175 = _174;
                _178 = _177;
                _180 = _179;
            }
        }
        float3 _298;
        if ((_179 > 0) && (_177 > 9.9999997473787516355514526367188e-05))
        {
            _298 = _174 * (1.0 / _177);
        }
        else
        {
            _298 = float3(0.0);
        }
        _299 = _298;
    }
    else
    {
        _299 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _301 = float4(in.in_var_ATTRIBUTE4.x);
    int _304 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _318 = float4(in.in_var_ATTRIBUTE4.y);
    int _321 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _337 = float4(in.in_var_ATTRIBUTE4.z);
    int _340 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _356 = float4(in.in_var_ATTRIBUTE4.w);
    int _359 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _371 = (((_301 * BoneMatrices.read(uint(uint(_304)))) + (_318 * BoneMatrices.read(uint(uint(_321))))) + (_337 * BoneMatrices.read(uint(uint(_340))))) + (_356 * BoneMatrices.read(uint(uint(_359))));
    float4 _372 = (((_301 * BoneMatrices.read(uint(uint(_304 + 1)))) + (_318 * BoneMatrices.read(uint(uint(_321 + 1))))) + (_337 * BoneMatrices.read(uint(uint(_340 + 1))))) + (_356 * BoneMatrices.read(uint(uint(_359 + 1))));
    float4 _373 = (((_301 * BoneMatrices.read(uint(uint(_304 + 2)))) + (_318 * BoneMatrices.read(uint(uint(_321 + 2))))) + (_337 * BoneMatrices.read(uint(uint(_340 + 2))))) + (_356 * BoneMatrices.read(uint(uint(_359 + 2))));
    float3x4 _457;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _381 = float4(in.in_var_ATTRIBUTE15.x);
        int _384 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _400 = float4(in.in_var_ATTRIBUTE15.y);
        int _403 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _419 = float4(in.in_var_ATTRIBUTE15.z);
        int _422 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _438 = float4(in.in_var_ATTRIBUTE15.w);
        int _441 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _457 = float3x4((((_371 + (_381 * BoneMatrices.read(uint(uint(_384))))) + (_400 * BoneMatrices.read(uint(uint(_403))))) + (_419 * BoneMatrices.read(uint(uint(_422))))) + (_438 * BoneMatrices.read(uint(uint(_441)))), (((_372 + (_381 * BoneMatrices.read(uint(uint(_384 + 1))))) + (_400 * BoneMatrices.read(uint(uint(_403 + 1))))) + (_419 * BoneMatrices.read(uint(uint(_422 + 1))))) + (_438 * BoneMatrices.read(uint(uint(_441 + 1)))), (((_373 + (_381 * BoneMatrices.read(uint(uint(_384 + 2))))) + (_400 * BoneMatrices.read(uint(uint(_403 + 2))))) + (_419 * BoneMatrices.read(uint(uint(_422 + 2))))) + (_438 * BoneMatrices.read(uint(uint(_441 + 2)))));
    }
    else
    {
        _457 = float3x4(_371, _372, _373);
    }
    spvUnsafeArray<FClothVertex, 5> _105;
    _105 = _106;
    float _640;
    float3x3 _641;
    if (_105[0].SimulIndices.w < 65535u)
    {
        float _469;
        float3 _472;
        float3 _474;
        float _476;
        int _478;
        _469 = _Globals.ClothBlendWeight;
        _472 = float3(0.0);
        _474 = float3(0.0);
        _476 = 0.0;
        _478 = 0;
        float _470;
        float3 _473;
        float3 _475;
        float _477;
        int _479;
        for (int _480 = 0; _480 < 5; _469 = _470, _472 = _473, _474 = _475, _476 = _477, _478 = _479, _480++)
        {
            bool _492 = _105[_480].SimulIndices.w < 65535u;
            if (_492)
            {
                int _498 = int(_105[_480].SimulIndices.x) * 3;
                uint _503 = uint(_498 + 1);
                float3 _512 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_498))).xy, ClothSimulVertsPositionsNormals.read(uint(_503)).x, 1.0)).xyz;
                int _515 = int(_105[_480].SimulIndices.y) * 3;
                uint _519 = uint(_515 + 1);
                float3 _526 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_515))).xy, ClothSimulVertsPositionsNormals.read(uint(_519)).x, 1.0)).xyz;
                int _529 = int(_105[_480].SimulIndices.z) * 3;
                uint _533 = uint(_529 + 1);
                float3 _540 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_529))).xy, ClothSimulVertsPositionsNormals.read(uint(_533)).x, 1.0)).xyz;
                float3 _550 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_503)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_498 + 2))).xy, 0.0)).xyz;
                float3 _560 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_519)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_515 + 2))).xy, 0.0)).xyz;
                float3 _570 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_533)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_529 + 2))).xy, 0.0)).xyz;
                _473 = _472 + (((((_512 + (_550 * _105[_480].BaryCoordNormal.w)) * _105[_480].BaryCoordNormal.x) + ((_526 + (_560 * _105[_480].BaryCoordNormal.w)) * _105[_480].BaryCoordNormal.y)) + ((_540 + (_570 * _105[_480].BaryCoordNormal.w)) * _105[_480].BaryCoordNormal.z)) * _105[_480].Weight);
                _475 = _474 + (((((_512 + (_550 * _105[_480].BaryCoordTangent.w)) * _105[_480].BaryCoordTangent.x) + ((_526 + (_560 * _105[_480].BaryCoordTangent.w)) * _105[_480].BaryCoordTangent.y)) + ((_540 + (_570 * _105[_480].BaryCoordTangent.w)) * _105[_480].BaryCoordTangent.z)) * _105[_480].Weight);
                _477 = _476 + _105[_480].Weight;
                _479 = _478 + 1;
            }
            else
            {
                _473 = _472;
                _475 = _474;
                _477 = _476;
                _479 = _478;
            }
            _470 = _492 ? _Globals.ClothBlendWeight : _469;
        }
        bool _608 = (_478 > 0) && (_476 > 9.9999997473787516355514526367188e-05);
        float3x3 _632;
        if (_608)
        {
            float _612 = 1.0 / _476;
            float3x3 _627 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _629 = _101;
            _629[0] = _627 * normalize((_474 * _612) - _299);
            float3x3 _631 = _629;
            _631[2] = _627 * normalize((_472 * _612) - _299);
            _632 = _631;
        }
        else
        {
            _632 = _101;
        }
        float3x3 _639 = _632;
        _639[1] = cross(_632[2], _632[0]) * in.in_var_ATTRIBUTE2.w;
        _640 = _608 ? _469 : 0.0;
        _641 = _639;
    }
    else
    {
        _640 = 0.0;
        _641 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _647 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _457);
    float3 _653 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _457);
    float3 _658 = float3(_640);
    float3 _666 = float3(1.0 - _640);
    float4 _741;
    switch (0u)
    {
        default:
        {
            if (_106[0].SimulIndices.w < 65535u)
            {
                _741 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _457) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _299, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _690 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _457) + in.in_var_ATTRIBUTE12;
                _741 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _690.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _690.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _690.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _104;
    _104 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _107 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _743 = 0; _743 < 1; )
    {
        _107[_743] = _104[_743];
        _743++;
        continue;
    }
    float4 _755 = View.View_TranslatedWorldToClip * float4(_741.x, _741.y, _741.z, _741.w);
    float4 _758 = _102;
    _758.w = 0.0;
    float3x3 _772 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _772[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _775 = _772;
    _775[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _778 = _775;
    _778[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _779 = _778 * float3x3((_641[0] * _658) + (_647 * _666), (_641[1] * _658) + (normalize(cross(_653, _647) * in.in_var_ATTRIBUTE2.w) * _666), (_641[2] * _658) + (_653 * _666));
    float3 _780 = _779[0];
    spvUnsafeArray<float4, 1> _790 = { float4(_107[0].x, _107[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_780.x, _780.y, _780.z, _758.w);
    out.out_var_TEXCOORD11_centroid = float4(_779[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _790;
    out.out_var_TEXCOORD6 = float4(_741.x, _741.y, _741.z, _741.w);
    out.gl_Position = _755;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

