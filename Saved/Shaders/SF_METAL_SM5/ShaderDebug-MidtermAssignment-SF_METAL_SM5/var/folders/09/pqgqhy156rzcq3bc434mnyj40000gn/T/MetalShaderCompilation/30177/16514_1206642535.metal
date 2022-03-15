

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

constant spvUnsafeArray<float2, 1> _95 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _100 = {};
constant float4 _101 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
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

vertex Main_out Main_00004082_47ebe767(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _105;
    for (int _131 = 0; _131 < 5; )
    {
        uint _139 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_131)) * 4u;
        _105[_131].BaryCoordPos = GPUSkinApexCloth.read(uint(_139));
        _105[_131].BaryCoordNormal = GPUSkinApexCloth.read(uint((_139 + 1u)));
        _105[_131].BaryCoordTangent = GPUSkinApexCloth.read(uint((_139 + 2u)));
        uint4 _151 = as_type<uint4>(GPUSkinApexCloth.read(uint((_139 + 3u))));
        uint2 _152 = _151.xy;
        uint2 _155 = (_152 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _105[_131].SimulIndices = uint4(_105[_131].SimulIndices.x, _155.x, _105[_131].SimulIndices.z, _155.y);
        uint2 _159 = _152 & uint2(65535u);
        _105[_131].SimulIndices = uint4(_159.x, _105[_131].SimulIndices.y, _159.y, _105[_131].SimulIndices.w);
        _105[_131].Weight = as_type<float>(_151.z);
        _131++;
        continue;
    }
    float3 _300;
    if (_105[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _107;
        _107 = _105;
        float3 _175;
        float _178;
        int _180;
        _175 = float3(0.0);
        _178 = 0.0;
        _180 = 0;
        float3 _176;
        float _179;
        int _181;
        for (int _182 = 0; _182 < 5; _175 = _176, _178 = _179, _180 = _181, _182++)
        {
            if (_107[_182].SimulIndices.w < 65535u)
            {
                int _199 = int(_107[_182].SimulIndices.x) * 3;
                uint _204 = uint(_199 + 1);
                int _216 = int(_107[_182].SimulIndices.y) * 3;
                uint _220 = uint(_216 + 1);
                int _230 = int(_107[_182].SimulIndices.z) * 3;
                uint _234 = uint(_230 + 1);
                _176 = _175 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_199))).xy, ClothSimulVertsPositionsNormals.read(uint(_204)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_204)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_199 + 2))).xy, 0.0)).xyz * _107[_182].BaryCoordPos.w)) * _107[_182].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_216))).xy, ClothSimulVertsPositionsNormals.read(uint(_220)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_220)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_216 + 2))).xy, 0.0)).xyz * _107[_182].BaryCoordPos.w)) * _107[_182].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_230))).xy, ClothSimulVertsPositionsNormals.read(uint(_234)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_234)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_230 + 2))).xy, 0.0)).xyz * _107[_182].BaryCoordPos.w)) * ((1.0 - _107[_182].BaryCoordPos.x) - _107[_182].BaryCoordPos.y))) * _107[_182].Weight);
                _179 = _178 + _107[_182].Weight;
                _181 = _180 + 1;
            }
            else
            {
                _176 = _175;
                _179 = _178;
                _181 = _180;
            }
        }
        float3 _299;
        if ((_180 > 0) && (_178 > 9.9999997473787516355514526367188e-05))
        {
            _299 = _175 * (1.0 / _178);
        }
        else
        {
            _299 = float3(0.0);
        }
        _300 = _299;
    }
    else
    {
        _300 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _302 = float4(in.in_var_ATTRIBUTE4.x);
    int _305 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _319 = float4(in.in_var_ATTRIBUTE4.y);
    int _322 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _338 = float4(in.in_var_ATTRIBUTE4.z);
    int _341 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _357 = float4(in.in_var_ATTRIBUTE4.w);
    int _360 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _372 = (((_302 * BoneMatrices.read(uint(uint(_305)))) + (_319 * BoneMatrices.read(uint(uint(_322))))) + (_338 * BoneMatrices.read(uint(uint(_341))))) + (_357 * BoneMatrices.read(uint(uint(_360))));
    float4 _373 = (((_302 * BoneMatrices.read(uint(uint(_305 + 1)))) + (_319 * BoneMatrices.read(uint(uint(_322 + 1))))) + (_338 * BoneMatrices.read(uint(uint(_341 + 1))))) + (_357 * BoneMatrices.read(uint(uint(_360 + 1))));
    float4 _374 = (((_302 * BoneMatrices.read(uint(uint(_305 + 2)))) + (_319 * BoneMatrices.read(uint(uint(_322 + 2))))) + (_338 * BoneMatrices.read(uint(uint(_341 + 2))))) + (_357 * BoneMatrices.read(uint(uint(_360 + 2))));
    float3x4 _458;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _382 = float4(in.in_var_ATTRIBUTE15.x);
        int _385 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _401 = float4(in.in_var_ATTRIBUTE15.y);
        int _404 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _420 = float4(in.in_var_ATTRIBUTE15.z);
        int _423 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _439 = float4(in.in_var_ATTRIBUTE15.w);
        int _442 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _458 = float3x4((((_372 + (_382 * BoneMatrices.read(uint(uint(_385))))) + (_401 * BoneMatrices.read(uint(uint(_404))))) + (_420 * BoneMatrices.read(uint(uint(_423))))) + (_439 * BoneMatrices.read(uint(uint(_442)))), (((_373 + (_382 * BoneMatrices.read(uint(uint(_385 + 1))))) + (_401 * BoneMatrices.read(uint(uint(_404 + 1))))) + (_420 * BoneMatrices.read(uint(uint(_423 + 1))))) + (_439 * BoneMatrices.read(uint(uint(_442 + 1)))), (((_374 + (_382 * BoneMatrices.read(uint(uint(_385 + 2))))) + (_401 * BoneMatrices.read(uint(uint(_404 + 2))))) + (_420 * BoneMatrices.read(uint(uint(_423 + 2))))) + (_439 * BoneMatrices.read(uint(uint(_442 + 2)))));
    }
    else
    {
        _458 = float3x4(_372, _373, _374);
    }
    spvUnsafeArray<FClothVertex, 5> _104;
    _104 = _105;
    float _641;
    float3x3 _642;
    if (_104[0].SimulIndices.w < 65535u)
    {
        float _470;
        float3 _473;
        float3 _475;
        float _477;
        int _479;
        _470 = _Globals.ClothBlendWeight;
        _473 = float3(0.0);
        _475 = float3(0.0);
        _477 = 0.0;
        _479 = 0;
        float _471;
        float3 _474;
        float3 _476;
        float _478;
        int _480;
        for (int _481 = 0; _481 < 5; _470 = _471, _473 = _474, _475 = _476, _477 = _478, _479 = _480, _481++)
        {
            bool _493 = _104[_481].SimulIndices.w < 65535u;
            if (_493)
            {
                int _499 = int(_104[_481].SimulIndices.x) * 3;
                uint _504 = uint(_499 + 1);
                float3 _513 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_499))).xy, ClothSimulVertsPositionsNormals.read(uint(_504)).x, 1.0)).xyz;
                int _516 = int(_104[_481].SimulIndices.y) * 3;
                uint _520 = uint(_516 + 1);
                float3 _527 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_516))).xy, ClothSimulVertsPositionsNormals.read(uint(_520)).x, 1.0)).xyz;
                int _530 = int(_104[_481].SimulIndices.z) * 3;
                uint _534 = uint(_530 + 1);
                float3 _541 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_530))).xy, ClothSimulVertsPositionsNormals.read(uint(_534)).x, 1.0)).xyz;
                float3 _551 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_504)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_499 + 2))).xy, 0.0)).xyz;
                float3 _561 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_520)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_516 + 2))).xy, 0.0)).xyz;
                float3 _571 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_534)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_530 + 2))).xy, 0.0)).xyz;
                _474 = _473 + (((((_513 + (_551 * _104[_481].BaryCoordNormal.w)) * _104[_481].BaryCoordNormal.x) + ((_527 + (_561 * _104[_481].BaryCoordNormal.w)) * _104[_481].BaryCoordNormal.y)) + ((_541 + (_571 * _104[_481].BaryCoordNormal.w)) * _104[_481].BaryCoordNormal.z)) * _104[_481].Weight);
                _476 = _475 + (((((_513 + (_551 * _104[_481].BaryCoordTangent.w)) * _104[_481].BaryCoordTangent.x) + ((_527 + (_561 * _104[_481].BaryCoordTangent.w)) * _104[_481].BaryCoordTangent.y)) + ((_541 + (_571 * _104[_481].BaryCoordTangent.w)) * _104[_481].BaryCoordTangent.z)) * _104[_481].Weight);
                _478 = _477 + _104[_481].Weight;
                _480 = _479 + 1;
            }
            else
            {
                _474 = _473;
                _476 = _475;
                _478 = _477;
                _480 = _479;
            }
            _471 = _493 ? _Globals.ClothBlendWeight : _470;
        }
        bool _609 = (_479 > 0) && (_477 > 9.9999997473787516355514526367188e-05);
        float3x3 _633;
        if (_609)
        {
            float _613 = 1.0 / _477;
            float3x3 _628 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _630 = _100;
            _630[0] = _628 * normalize((_475 * _613) - _300);
            float3x3 _632 = _630;
            _632[2] = _628 * normalize((_473 * _613) - _300);
            _633 = _632;
        }
        else
        {
            _633 = _100;
        }
        float3x3 _640 = _633;
        _640[1] = cross(_633[2], _633[0]) * in.in_var_ATTRIBUTE2.w;
        _641 = _609 ? _470 : 0.0;
        _642 = _640;
    }
    else
    {
        _641 = 0.0;
        _642 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _648 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _458);
    float3 _654 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _458);
    float3 _659 = float3(_641);
    float3 _667 = float3(1.0 - _641);
    float4 _742;
    switch (0u)
    {
        default:
        {
            if (_105[0].SimulIndices.w < 65535u)
            {
                _742 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _458) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _300, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _691 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _458) + in.in_var_ATTRIBUTE12;
                _742 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _691.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _691.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _691.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _103;
    _103 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _106 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _744 = 0; _744 < 1; )
    {
        _106[_744] = _103[_744];
        _744++;
        continue;
    }
    float4 _754 = View.View_TranslatedWorldToClip * float4(_742.x, _742.y, _742.z, _742.w);
    float4 _757 = _101;
    _757.w = 0.0;
    float3x3 _771 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _771[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _774 = _771;
    _774[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _777 = _774;
    _777[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _778 = _777 * float3x3((_642[0] * _659) + (_648 * _667), (_642[1] * _659) + (normalize(cross(_654, _648) * in.in_var_ATTRIBUTE2.w) * _667), (_642[2] * _659) + (_654 * _667));
    float3 _779 = _778[0];
    spvUnsafeArray<float4, 1> _789 = { float4(_106[0].x, _106[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_779.x, _779.y, _779.z, _757.w);
    out.out_var_TEXCOORD11_centroid = float4(_778[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _789;
    out.gl_Position = _754;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

