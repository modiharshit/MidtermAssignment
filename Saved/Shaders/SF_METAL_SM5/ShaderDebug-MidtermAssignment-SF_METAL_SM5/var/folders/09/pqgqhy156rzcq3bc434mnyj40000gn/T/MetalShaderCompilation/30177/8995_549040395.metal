

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

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00002323_20b9b10b(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _89;
    for (int _108 = 0; _108 < 1; )
    {
        uint _115 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_108)) * 4u;
        _89[_108].BaryCoordPos = GPUSkinApexCloth.read(uint(_115));
        _89[_108].BaryCoordNormal = GPUSkinApexCloth.read(uint((_115 + 1u)));
        _89[_108].BaryCoordTangent = GPUSkinApexCloth.read(uint((_115 + 2u)));
        uint4 _127 = as_type<uint4>(GPUSkinApexCloth.read(uint((_115 + 3u))));
        uint2 _128 = _127.xy;
        uint2 _131 = (_128 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _89[_108].SimulIndices = uint4(_89[_108].SimulIndices.x, _131.x, _89[_108].SimulIndices.z, _131.y);
        uint2 _135 = _128 & uint2(65535u);
        _89[_108].SimulIndices = uint4(_135.x, _89[_108].SimulIndices.y, _135.y, _89[_108].SimulIndices.w);
        _89[_108].Weight = as_type<float>(_127.z);
        _108++;
        continue;
    }
    float3 _274;
    if (_89[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _90;
        _90 = _89;
        float3 _151;
        float _154;
        int _156;
        _151 = float3(0.0);
        _154 = 0.0;
        _156 = 0;
        float _155;
        float3 _152;
        int _157;
        for (int _158 = 0; _158 < 1; _151 = _152, _154 = _155, _156 = _157, _158++)
        {
            bool _168 = _90[_158].SimulIndices.w < 65535u;
            if (_168)
            {
                int _174 = int(_90[_158].SimulIndices.x) * 3;
                uint _179 = uint(_174 + 1);
                int _191 = int(_90[_158].SimulIndices.y) * 3;
                uint _195 = uint(_191 + 1);
                int _205 = int(_90[_158].SimulIndices.z) * 3;
                uint _209 = uint(_205 + 1);
                _152 = _151 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_174))).xy, ClothSimulVertsPositionsNormals.read(uint(_179)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_179)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_174 + 2))).xy, 0.0)).xyz * _90[_158].BaryCoordPos.w)) * _90[_158].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_191))).xy, ClothSimulVertsPositionsNormals.read(uint(_195)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_195)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_191 + 2))).xy, 0.0)).xyz * _90[_158].BaryCoordPos.w)) * _90[_158].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_205))).xy, ClothSimulVertsPositionsNormals.read(uint(_209)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_209)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_205 + 2))).xy, 0.0)).xyz * _90[_158].BaryCoordPos.w)) * ((1.0 - _90[_158].BaryCoordPos.x) - _90[_158].BaryCoordPos.y))) * 1.0);
                _157 = _156 + 1;
            }
            else
            {
                _152 = _151;
                _157 = _156;
            }
            _155 = _168 ? 1.0 : _154;
        }
        float3 _273;
        if ((_156 > 0) && (_154 > 9.9999997473787516355514526367188e-05))
        {
            _273 = _151 * (1.0 / _154);
        }
        else
        {
            _273 = float3(0.0);
        }
        _274 = _273;
    }
    else
    {
        _274 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _276 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _279 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _285 = int(_279 + (_Globals.InputWeightIndexSize * uint(_276)));
    float3x4 _287;
    _287 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _288;
    for (int _290 = 0; _290 < _276; _287 = _288, _290++)
    {
        int _298 = int(_279 + (_Globals.InputWeightIndexSize * uint(_290)));
        int _303 = int(InputWeightStream.read(uint(uint(_298))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _349 = float4(float(InputWeightStream.read(uint(uint(_285 + _290))).x) * 0.0039215688593685626983642578125);
            int _350 = int((InputWeightStream.read(uint(uint(_298 + 1))).x << 8u) | uint(_303)) * 3;
            _288 = float3x4(_287[0] + (_349 * BoneMatrices.read(uint(uint(_350)))), _287[1] + (_349 * BoneMatrices.read(uint(uint(_350 + 1)))), _287[2] + (_349 * BoneMatrices.read(uint(uint(_350 + 2)))));
        }
        else
        {
            float4 _314 = float4(float(InputWeightStream.read(uint(uint(_285 + _290))).x) * 0.0039215688593685626983642578125);
            int _315 = _303 * 3;
            _288 = float3x4(_287[0] + (_314 * BoneMatrices.read(uint(uint(_315)))), _287[1] + (_314 * BoneMatrices.read(uint(uint(_315 + 1)))), _287[2] + (_314 * BoneMatrices.read(uint(uint(_315 + 2)))));
        }
    }
    float4 _437;
    switch (0u)
    {
        default:
        {
            if (_89[0].SimulIndices.w < 65535u)
            {
                _437 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _287) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _274, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _386 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _287) + in.in_var_ATTRIBUTE12;
                _437 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _386.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _386.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _386.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _439 = View.View_TranslatedWorldToClip * float4(_437.x, _437.y, _437.z, _437.w);
    out.gl_Position = _439;
    return out;
}

