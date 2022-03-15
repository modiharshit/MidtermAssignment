

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

vertex Main_out Main_00002346_aa311d6e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _91;
    for (int _110 = 0; _110 < 5; )
    {
        uint _118 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_110)) * 4u;
        _91[_110].BaryCoordPos = GPUSkinApexCloth.read(uint(_118));
        _91[_110].BaryCoordNormal = GPUSkinApexCloth.read(uint((_118 + 1u)));
        _91[_110].BaryCoordTangent = GPUSkinApexCloth.read(uint((_118 + 2u)));
        uint4 _130 = as_type<uint4>(GPUSkinApexCloth.read(uint((_118 + 3u))));
        uint2 _131 = _130.xy;
        uint2 _134 = (_131 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _91[_110].SimulIndices = uint4(_91[_110].SimulIndices.x, _134.x, _91[_110].SimulIndices.z, _134.y);
        uint2 _138 = _131 & uint2(65535u);
        _91[_110].SimulIndices = uint4(_138.x, _91[_110].SimulIndices.y, _138.y, _91[_110].SimulIndices.w);
        _91[_110].Weight = as_type<float>(_130.z);
        _110++;
        continue;
    }
    float3 _279;
    if (_91[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _92;
        _92 = _91;
        float3 _154;
        float _157;
        int _159;
        _154 = float3(0.0);
        _157 = 0.0;
        _159 = 0;
        float3 _155;
        float _158;
        int _160;
        for (int _161 = 0; _161 < 5; _154 = _155, _157 = _158, _159 = _160, _161++)
        {
            if (_92[_161].SimulIndices.w < 65535u)
            {
                int _178 = int(_92[_161].SimulIndices.x) * 3;
                uint _183 = uint(_178 + 1);
                int _195 = int(_92[_161].SimulIndices.y) * 3;
                uint _199 = uint(_195 + 1);
                int _209 = int(_92[_161].SimulIndices.z) * 3;
                uint _213 = uint(_209 + 1);
                _155 = _154 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_178))).xy, ClothSimulVertsPositionsNormals.read(uint(_183)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_183)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_178 + 2))).xy, 0.0)).xyz * _92[_161].BaryCoordPos.w)) * _92[_161].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_195))).xy, ClothSimulVertsPositionsNormals.read(uint(_199)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_199)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_195 + 2))).xy, 0.0)).xyz * _92[_161].BaryCoordPos.w)) * _92[_161].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_209))).xy, ClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_213)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_209 + 2))).xy, 0.0)).xyz * _92[_161].BaryCoordPos.w)) * ((1.0 - _92[_161].BaryCoordPos.x) - _92[_161].BaryCoordPos.y))) * _92[_161].Weight);
                _158 = _157 + _92[_161].Weight;
                _160 = _159 + 1;
            }
            else
            {
                _155 = _154;
                _158 = _157;
                _160 = _159;
            }
        }
        float3 _278;
        if ((_159 > 0) && (_157 > 9.9999997473787516355514526367188e-05))
        {
            _278 = _154 * (1.0 / _157);
        }
        else
        {
            _278 = float3(0.0);
        }
        _279 = _278;
    }
    else
    {
        _279 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _281 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _284 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _290 = int(_284 + (_Globals.InputWeightIndexSize * uint(_281)));
    float3x4 _292;
    _292 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _293;
    for (int _295 = 0; _295 < _281; _292 = _293, _295++)
    {
        int _303 = int(_284 + (_Globals.InputWeightIndexSize * uint(_295)));
        int _308 = int(InputWeightStream.read(uint(uint(_303))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _354 = float4(float(InputWeightStream.read(uint(uint(_290 + _295))).x) * 0.0039215688593685626983642578125);
            int _355 = int((InputWeightStream.read(uint(uint(_303 + 1))).x << 8u) | uint(_308)) * 3;
            _293 = float3x4(_292[0] + (_354 * BoneMatrices.read(uint(uint(_355)))), _292[1] + (_354 * BoneMatrices.read(uint(uint(_355 + 1)))), _292[2] + (_354 * BoneMatrices.read(uint(uint(_355 + 2)))));
        }
        else
        {
            float4 _319 = float4(float(InputWeightStream.read(uint(uint(_290 + _295))).x) * 0.0039215688593685626983642578125);
            int _320 = _308 * 3;
            _293 = float3x4(_292[0] + (_319 * BoneMatrices.read(uint(uint(_320)))), _292[1] + (_319 * BoneMatrices.read(uint(uint(_320 + 1)))), _292[2] + (_319 * BoneMatrices.read(uint(uint(_320 + 2)))));
        }
    }
    float4 _442;
    switch (0u)
    {
        default:
        {
            if (_91[0].SimulIndices.w < 65535u)
            {
                _442 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _292) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _279, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _391 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _292) + in.in_var_ATTRIBUTE12;
                _442 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _391.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _391.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _391.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _444 = View.View_TranslatedWorldToClip * float4(_442.x, _442.y, _442.z, _442.w);
    out.gl_Position = _444;
    return out;
}

