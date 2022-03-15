

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

constant float3x3 _87 = {};
constant float4 _88 = {};

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

vertex Main_out Main_00003cc2_7f1f126f(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _91;
    for (int _115 = 0; _115 < 1; )
    {
        uint _122 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_115)) * 4u;
        _91[_115].BaryCoordPos = GPUSkinApexCloth.read(uint(_122));
        _91[_115].BaryCoordNormal = GPUSkinApexCloth.read(uint((_122 + 1u)));
        _91[_115].BaryCoordTangent = GPUSkinApexCloth.read(uint((_122 + 2u)));
        uint4 _134 = as_type<uint4>(GPUSkinApexCloth.read(uint((_122 + 3u))));
        uint2 _135 = _134.xy;
        uint2 _138 = (_135 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _91[_115].SimulIndices = uint4(_91[_115].SimulIndices.x, _138.x, _91[_115].SimulIndices.z, _138.y);
        uint2 _142 = _135 & uint2(65535u);
        _91[_115].SimulIndices = uint4(_142.x, _91[_115].SimulIndices.y, _142.y, _91[_115].SimulIndices.w);
        _91[_115].Weight = as_type<float>(_134.z);
        _115++;
        continue;
    }
    float3 _281;
    if (_91[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _92;
        _92 = _91;
        float3 _158;
        float _161;
        int _163;
        _158 = float3(0.0);
        _161 = 0.0;
        _163 = 0;
        float _162;
        float3 _159;
        int _164;
        for (int _165 = 0; _165 < 1; _158 = _159, _161 = _162, _163 = _164, _165++)
        {
            bool _175 = _92[_165].SimulIndices.w < 65535u;
            if (_175)
            {
                int _181 = int(_92[_165].SimulIndices.x) * 3;
                uint _186 = uint(_181 + 1);
                int _198 = int(_92[_165].SimulIndices.y) * 3;
                uint _202 = uint(_198 + 1);
                int _212 = int(_92[_165].SimulIndices.z) * 3;
                uint _216 = uint(_212 + 1);
                _159 = _158 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_181))).xy, ClothSimulVertsPositionsNormals.read(uint(_186)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_186)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_181 + 2))).xy, 0.0)).xyz * _92[_165].BaryCoordPos.w)) * _92[_165].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_198))).xy, ClothSimulVertsPositionsNormals.read(uint(_202)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_202)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_198 + 2))).xy, 0.0)).xyz * _92[_165].BaryCoordPos.w)) * _92[_165].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _92[_165].BaryCoordPos.w)) * ((1.0 - _92[_165].BaryCoordPos.x) - _92[_165].BaryCoordPos.y))) * 1.0);
                _164 = _163 + 1;
            }
            else
            {
                _159 = _158;
                _164 = _163;
            }
            _162 = _175 ? 1.0 : _161;
        }
        float3 _280;
        if ((_163 > 0) && (_161 > 9.9999997473787516355514526367188e-05))
        {
            _280 = _158 * (1.0 / _161);
        }
        else
        {
            _280 = float3(0.0);
        }
        _281 = _280;
    }
    else
    {
        _281 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _283 = float4(in.in_var_ATTRIBUTE4.x);
    int _286 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _300 = float4(in.in_var_ATTRIBUTE4.y);
    int _303 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _319 = float4(in.in_var_ATTRIBUTE4.z);
    int _322 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _338 = float4(in.in_var_ATTRIBUTE4.w);
    int _341 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _353 = (((_283 * BoneMatrices.read(uint(uint(_286)))) + (_300 * BoneMatrices.read(uint(uint(_303))))) + (_319 * BoneMatrices.read(uint(uint(_322))))) + (_338 * BoneMatrices.read(uint(uint(_341))));
    float4 _354 = (((_283 * BoneMatrices.read(uint(uint(_286 + 1)))) + (_300 * BoneMatrices.read(uint(uint(_303 + 1))))) + (_319 * BoneMatrices.read(uint(uint(_322 + 1))))) + (_338 * BoneMatrices.read(uint(uint(_341 + 1))));
    float4 _355 = (((_283 * BoneMatrices.read(uint(uint(_286 + 2)))) + (_300 * BoneMatrices.read(uint(uint(_303 + 2))))) + (_319 * BoneMatrices.read(uint(uint(_322 + 2))))) + (_338 * BoneMatrices.read(uint(uint(_341 + 2))));
    float3x4 _439;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _363 = float4(in.in_var_ATTRIBUTE15.x);
        int _366 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _382 = float4(in.in_var_ATTRIBUTE15.y);
        int _385 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _401 = float4(in.in_var_ATTRIBUTE15.z);
        int _404 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _420 = float4(in.in_var_ATTRIBUTE15.w);
        int _423 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _439 = float3x4((((_353 + (_363 * BoneMatrices.read(uint(uint(_366))))) + (_382 * BoneMatrices.read(uint(uint(_385))))) + (_401 * BoneMatrices.read(uint(uint(_404))))) + (_420 * BoneMatrices.read(uint(uint(_423)))), (((_354 + (_363 * BoneMatrices.read(uint(uint(_366 + 1))))) + (_382 * BoneMatrices.read(uint(uint(_385 + 1))))) + (_401 * BoneMatrices.read(uint(uint(_404 + 1))))) + (_420 * BoneMatrices.read(uint(uint(_423 + 1)))), (((_355 + (_363 * BoneMatrices.read(uint(uint(_366 + 2))))) + (_382 * BoneMatrices.read(uint(uint(_385 + 2))))) + (_401 * BoneMatrices.read(uint(uint(_404 + 2))))) + (_420 * BoneMatrices.read(uint(uint(_423 + 2)))));
    }
    else
    {
        _439 = float3x4(_353, _354, _355);
    }
    spvUnsafeArray<FClothVertex, 1> _90;
    _90 = _91;
    float _620;
    float3x3 _621;
    if (_90[0].SimulIndices.w < 65535u)
    {
        float _451;
        float3 _454;
        float3 _456;
        float _458;
        int _460;
        _451 = _Globals.ClothBlendWeight;
        _454 = float3(0.0);
        _456 = float3(0.0);
        _458 = 0.0;
        _460 = 0;
        float _452;
        float _459;
        float3 _455;
        float3 _457;
        int _461;
        for (int _462 = 0; _462 < 1; _451 = _452, _454 = _455, _456 = _457, _458 = _459, _460 = _461, _462++)
        {
            bool _473 = _90[_462].SimulIndices.w < 65535u;
            if (_473)
            {
                int _479 = int(_90[_462].SimulIndices.x) * 3;
                uint _484 = uint(_479 + 1);
                float3 _493 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_479))).xy, ClothSimulVertsPositionsNormals.read(uint(_484)).x, 1.0)).xyz;
                int _496 = int(_90[_462].SimulIndices.y) * 3;
                uint _500 = uint(_496 + 1);
                float3 _507 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_496))).xy, ClothSimulVertsPositionsNormals.read(uint(_500)).x, 1.0)).xyz;
                int _510 = int(_90[_462].SimulIndices.z) * 3;
                uint _514 = uint(_510 + 1);
                float3 _521 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_510))).xy, ClothSimulVertsPositionsNormals.read(uint(_514)).x, 1.0)).xyz;
                float3 _531 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_484)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_479 + 2))).xy, 0.0)).xyz;
                float3 _541 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_500)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_496 + 2))).xy, 0.0)).xyz;
                float3 _551 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_514)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_510 + 2))).xy, 0.0)).xyz;
                _455 = _454 + (((((_493 + (_531 * _90[_462].BaryCoordNormal.w)) * _90[_462].BaryCoordNormal.x) + ((_507 + (_541 * _90[_462].BaryCoordNormal.w)) * _90[_462].BaryCoordNormal.y)) + ((_521 + (_551 * _90[_462].BaryCoordNormal.w)) * _90[_462].BaryCoordNormal.z)) * 1.0);
                _457 = _456 + (((((_493 + (_531 * _90[_462].BaryCoordTangent.w)) * _90[_462].BaryCoordTangent.x) + ((_507 + (_541 * _90[_462].BaryCoordTangent.w)) * _90[_462].BaryCoordTangent.y)) + ((_521 + (_551 * _90[_462].BaryCoordTangent.w)) * _90[_462].BaryCoordTangent.z)) * 1.0);
                _461 = _460 + 1;
            }
            else
            {
                _455 = _454;
                _457 = _456;
                _461 = _460;
            }
            _452 = _473 ? _Globals.ClothBlendWeight : _451;
            _459 = _473 ? 1.0 : _458;
        }
        bool _588 = (_460 > 0) && (_458 > 9.9999997473787516355514526367188e-05);
        float3x3 _612;
        if (_588)
        {
            float _592 = 1.0 / _458;
            float3x3 _607 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _609 = _87;
            _609[0] = _607 * normalize((_456 * _592) - _281);
            float3x3 _611 = _609;
            _611[2] = _607 * normalize((_454 * _592) - _281);
            _612 = _611;
        }
        else
        {
            _612 = _87;
        }
        float3x3 _619 = _612;
        _619[1] = cross(_612[2], _612[0]) * in.in_var_ATTRIBUTE2.w;
        _620 = _588 ? _451 : 0.0;
        _621 = _619;
    }
    else
    {
        _620 = 0.0;
        _621 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _627 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _439);
    float3 _633 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _439);
    float3 _638 = float3(_620);
    float3 _646 = float3(1.0 - _620);
    float4 _721;
    switch (0u)
    {
        default:
        {
            if (_91[0].SimulIndices.w < 65535u)
            {
                _721 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _439) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _281, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _670 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _439) + in.in_var_ATTRIBUTE12;
                _721 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _670.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _670.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _670.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _723 = View.View_TranslatedWorldToClip * float4(_721.x, _721.y, _721.z, _721.w);
    float4 _724 = _88;
    _724.w = 0.0;
    float3x3 _738 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _738[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _741 = _738;
    _741[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _744 = _741;
    _744[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _745 = _744 * float3x3((_621[0] * _638) + (_627 * _646), (_621[1] * _638) + (normalize(cross(_633, _627) * in.in_var_ATTRIBUTE2.w) * _646), (_621[2] * _638) + (_633 * _646));
    float3 _746 = _745[0];
    out.out_var_TEXCOORD10_centroid = float4(_746.x, _746.y, _746.z, _724.w);
    out.out_var_TEXCOORD11_centroid = float4(_745[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _723;
    return out;
}

