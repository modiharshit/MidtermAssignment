

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

constant float3x3 _88 = {};
constant float4 _89 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_00003d90_7f7bbb08(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 1> _92;
    for (int _116 = 0; _116 < 1; )
    {
        uint _123 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_116)) * 4u;
        _92[_116].BaryCoordPos = GPUSkinApexCloth.read(uint(_123));
        _92[_116].BaryCoordNormal = GPUSkinApexCloth.read(uint((_123 + 1u)));
        _92[_116].BaryCoordTangent = GPUSkinApexCloth.read(uint((_123 + 2u)));
        uint4 _135 = as_type<uint4>(GPUSkinApexCloth.read(uint((_123 + 3u))));
        uint2 _136 = _135.xy;
        uint2 _139 = (_136 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _92[_116].SimulIndices = uint4(_92[_116].SimulIndices.x, _139.x, _92[_116].SimulIndices.z, _139.y);
        uint2 _143 = _136 & uint2(65535u);
        _92[_116].SimulIndices = uint4(_143.x, _92[_116].SimulIndices.y, _143.y, _92[_116].SimulIndices.w);
        _92[_116].Weight = as_type<float>(_135.z);
        _116++;
        continue;
    }
    float3 _282;
    if (_92[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _93;
        _93 = _92;
        float3 _159;
        float _162;
        int _164;
        _159 = float3(0.0);
        _162 = 0.0;
        _164 = 0;
        float _163;
        float3 _160;
        int _165;
        for (int _166 = 0; _166 < 1; _159 = _160, _162 = _163, _164 = _165, _166++)
        {
            bool _176 = _93[_166].SimulIndices.w < 65535u;
            if (_176)
            {
                int _182 = int(_93[_166].SimulIndices.x) * 3;
                uint _187 = uint(_182 + 1);
                int _199 = int(_93[_166].SimulIndices.y) * 3;
                uint _203 = uint(_199 + 1);
                int _213 = int(_93[_166].SimulIndices.z) * 3;
                uint _217 = uint(_213 + 1);
                _160 = _159 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_182))).xy, ClothSimulVertsPositionsNormals.read(uint(_187)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_187)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_182 + 2))).xy, 0.0)).xyz * _93[_166].BaryCoordPos.w)) * _93[_166].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_199))).xy, ClothSimulVertsPositionsNormals.read(uint(_203)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_203)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_199 + 2))).xy, 0.0)).xyz * _93[_166].BaryCoordPos.w)) * _93[_166].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _93[_166].BaryCoordPos.w)) * ((1.0 - _93[_166].BaryCoordPos.x) - _93[_166].BaryCoordPos.y))) * 1.0);
                _165 = _164 + 1;
            }
            else
            {
                _160 = _159;
                _165 = _164;
            }
            _163 = _176 ? 1.0 : _162;
        }
        float3 _281;
        if ((_164 > 0) && (_162 > 9.9999997473787516355514526367188e-05))
        {
            _281 = _159 * (1.0 / _162);
        }
        else
        {
            _281 = float3(0.0);
        }
        _282 = _281;
    }
    else
    {
        _282 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _284 = float4(in.in_var_ATTRIBUTE4.x);
    int _287 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _301 = float4(in.in_var_ATTRIBUTE4.y);
    int _304 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _320 = float4(in.in_var_ATTRIBUTE4.z);
    int _323 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _339 = float4(in.in_var_ATTRIBUTE4.w);
    int _342 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _354 = (((_284 * BoneMatrices.read(uint(uint(_287)))) + (_301 * BoneMatrices.read(uint(uint(_304))))) + (_320 * BoneMatrices.read(uint(uint(_323))))) + (_339 * BoneMatrices.read(uint(uint(_342))));
    float4 _355 = (((_284 * BoneMatrices.read(uint(uint(_287 + 1)))) + (_301 * BoneMatrices.read(uint(uint(_304 + 1))))) + (_320 * BoneMatrices.read(uint(uint(_323 + 1))))) + (_339 * BoneMatrices.read(uint(uint(_342 + 1))));
    float4 _356 = (((_284 * BoneMatrices.read(uint(uint(_287 + 2)))) + (_301 * BoneMatrices.read(uint(uint(_304 + 2))))) + (_320 * BoneMatrices.read(uint(uint(_323 + 2))))) + (_339 * BoneMatrices.read(uint(uint(_342 + 2))));
    float3x4 _440;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _364 = float4(in.in_var_ATTRIBUTE15.x);
        int _367 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _383 = float4(in.in_var_ATTRIBUTE15.y);
        int _386 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _402 = float4(in.in_var_ATTRIBUTE15.z);
        int _405 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _421 = float4(in.in_var_ATTRIBUTE15.w);
        int _424 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _440 = float3x4((((_354 + (_364 * BoneMatrices.read(uint(uint(_367))))) + (_383 * BoneMatrices.read(uint(uint(_386))))) + (_402 * BoneMatrices.read(uint(uint(_405))))) + (_421 * BoneMatrices.read(uint(uint(_424)))), (((_355 + (_364 * BoneMatrices.read(uint(uint(_367 + 1))))) + (_383 * BoneMatrices.read(uint(uint(_386 + 1))))) + (_402 * BoneMatrices.read(uint(uint(_405 + 1))))) + (_421 * BoneMatrices.read(uint(uint(_424 + 1)))), (((_356 + (_364 * BoneMatrices.read(uint(uint(_367 + 2))))) + (_383 * BoneMatrices.read(uint(uint(_386 + 2))))) + (_402 * BoneMatrices.read(uint(uint(_405 + 2))))) + (_421 * BoneMatrices.read(uint(uint(_424 + 2)))));
    }
    else
    {
        _440 = float3x4(_354, _355, _356);
    }
    spvUnsafeArray<FClothVertex, 1> _91;
    _91 = _92;
    float _621;
    float3x3 _622;
    if (_91[0].SimulIndices.w < 65535u)
    {
        float _452;
        float3 _455;
        float3 _457;
        float _459;
        int _461;
        _452 = _Globals.ClothBlendWeight;
        _455 = float3(0.0);
        _457 = float3(0.0);
        _459 = 0.0;
        _461 = 0;
        float _453;
        float _460;
        float3 _456;
        float3 _458;
        int _462;
        for (int _463 = 0; _463 < 1; _452 = _453, _455 = _456, _457 = _458, _459 = _460, _461 = _462, _463++)
        {
            bool _474 = _91[_463].SimulIndices.w < 65535u;
            if (_474)
            {
                int _480 = int(_91[_463].SimulIndices.x) * 3;
                uint _485 = uint(_480 + 1);
                float3 _494 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_480))).xy, ClothSimulVertsPositionsNormals.read(uint(_485)).x, 1.0)).xyz;
                int _497 = int(_91[_463].SimulIndices.y) * 3;
                uint _501 = uint(_497 + 1);
                float3 _508 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_497))).xy, ClothSimulVertsPositionsNormals.read(uint(_501)).x, 1.0)).xyz;
                int _511 = int(_91[_463].SimulIndices.z) * 3;
                uint _515 = uint(_511 + 1);
                float3 _522 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_511))).xy, ClothSimulVertsPositionsNormals.read(uint(_515)).x, 1.0)).xyz;
                float3 _532 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_485)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_480 + 2))).xy, 0.0)).xyz;
                float3 _542 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_501)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_497 + 2))).xy, 0.0)).xyz;
                float3 _552 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_515)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_511 + 2))).xy, 0.0)).xyz;
                _456 = _455 + (((((_494 + (_532 * _91[_463].BaryCoordNormal.w)) * _91[_463].BaryCoordNormal.x) + ((_508 + (_542 * _91[_463].BaryCoordNormal.w)) * _91[_463].BaryCoordNormal.y)) + ((_522 + (_552 * _91[_463].BaryCoordNormal.w)) * _91[_463].BaryCoordNormal.z)) * 1.0);
                _458 = _457 + (((((_494 + (_532 * _91[_463].BaryCoordTangent.w)) * _91[_463].BaryCoordTangent.x) + ((_508 + (_542 * _91[_463].BaryCoordTangent.w)) * _91[_463].BaryCoordTangent.y)) + ((_522 + (_552 * _91[_463].BaryCoordTangent.w)) * _91[_463].BaryCoordTangent.z)) * 1.0);
                _462 = _461 + 1;
            }
            else
            {
                _456 = _455;
                _458 = _457;
                _462 = _461;
            }
            _453 = _474 ? _Globals.ClothBlendWeight : _452;
            _460 = _474 ? 1.0 : _459;
        }
        bool _589 = (_461 > 0) && (_459 > 9.9999997473787516355514526367188e-05);
        float3x3 _613;
        if (_589)
        {
            float _593 = 1.0 / _459;
            float3x3 _608 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _610 = _88;
            _610[0] = _608 * normalize((_457 * _593) - _282);
            float3x3 _612 = _610;
            _612[2] = _608 * normalize((_455 * _593) - _282);
            _613 = _612;
        }
        else
        {
            _613 = _88;
        }
        float3x3 _620 = _613;
        _620[1] = cross(_613[2], _613[0]) * in.in_var_ATTRIBUTE2.w;
        _621 = _589 ? _452 : 0.0;
        _622 = _620;
    }
    else
    {
        _621 = 0.0;
        _622 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _628 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _440);
    float3 _634 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _440);
    float3 _639 = float3(_621);
    float3 _647 = float3(1.0 - _621);
    float4 _722;
    switch (0u)
    {
        default:
        {
            if (_92[0].SimulIndices.w < 65535u)
            {
                _722 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _440) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _282, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _671 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _440) + in.in_var_ATTRIBUTE12;
                _722 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _671.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _671.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _671.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _724 = View.View_TranslatedWorldToClip * float4(_722.x, _722.y, _722.z, _722.w);
    float4 _725 = _89;
    _725.w = 0.0;
    float3x3 _739 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _739[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _742 = _739;
    _742[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _745 = _742;
    _745[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _746 = _745 * float3x3((_622[0] * _639) + (_628 * _647), (_622[1] * _639) + (normalize(cross(_634, _628) * in.in_var_ATTRIBUTE2.w) * _647), (_622[2] * _639) + (_634 * _647));
    float3 _747 = _746[0];
    out.out_var_TEXCOORD10_centroid = float4(_747.x, _747.y, _747.z, _725.w);
    out.out_var_TEXCOORD11_centroid = float4(_746[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_722.x, _722.y, _722.z, _722.w);
    out.gl_Position = _724;
    return out;
}

