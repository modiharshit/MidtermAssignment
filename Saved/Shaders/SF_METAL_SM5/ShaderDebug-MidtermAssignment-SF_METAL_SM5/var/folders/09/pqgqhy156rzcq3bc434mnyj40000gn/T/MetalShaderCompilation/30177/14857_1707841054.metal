

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
    float4x4 ClothLocalToWorld;
    char _m1_pad[64];
    float ClothBlendWeight;
    uint InputWeightIndexSize;
    uint2 GPUSkinApexClothStartIndexOffset;
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

constant float _105 = {};
constant float3x3 _106 = {};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003a09_65cb961e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _109;
    for (int _128 = 0; _128 < 5; )
    {
        uint _136 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_128)) * 4u;
        _109[_128].BaryCoordPos = GPUSkinApexCloth.read(uint(_136));
        _109[_128].BaryCoordNormal = GPUSkinApexCloth.read(uint((_136 + 1u)));
        _109[_128].BaryCoordTangent = GPUSkinApexCloth.read(uint((_136 + 2u)));
        uint4 _148 = as_type<uint4>(GPUSkinApexCloth.read(uint((_136 + 3u))));
        uint2 _149 = _148.xy;
        uint2 _152 = (_149 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _109[_128].SimulIndices = uint4(_109[_128].SimulIndices.x, _152.x, _109[_128].SimulIndices.z, _152.y);
        uint2 _156 = _149 & uint2(65535u);
        _109[_128].SimulIndices = uint4(_156.x, _109[_128].SimulIndices.y, _156.y, _109[_128].SimulIndices.w);
        _109[_128].Weight = as_type<float>(_148.z);
        _128++;
        continue;
    }
    float3 _297;
    if (_109[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _110;
        _110 = _109;
        float3 _172;
        float _175;
        int _177;
        _172 = float3(0.0);
        _175 = 0.0;
        _177 = 0;
        float3 _173;
        float _176;
        int _178;
        for (int _179 = 0; _179 < 5; _172 = _173, _175 = _176, _177 = _178, _179++)
        {
            if (_110[_179].SimulIndices.w < 65535u)
            {
                int _196 = int(_110[_179].SimulIndices.x) * 3;
                uint _201 = uint(_196 + 1);
                int _213 = int(_110[_179].SimulIndices.y) * 3;
                uint _217 = uint(_213 + 1);
                int _227 = int(_110[_179].SimulIndices.z) * 3;
                uint _231 = uint(_227 + 1);
                _173 = _172 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_196))).xy, ClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_201)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_196 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * _110[_179].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * _110[_179].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, ClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_231)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * ((1.0 - _110[_179].BaryCoordPos.x) - _110[_179].BaryCoordPos.y))) * _110[_179].Weight);
                _176 = _175 + _110[_179].Weight;
                _178 = _177 + 1;
            }
            else
            {
                _173 = _172;
                _176 = _175;
                _178 = _177;
            }
        }
        float3 _296;
        if ((_177 > 0) && (_175 > 9.9999997473787516355514526367188e-05))
        {
            _296 = _172 * (1.0 / _175);
        }
        else
        {
            _296 = float3(0.0);
        }
        _297 = _296;
    }
    else
    {
        _297 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _299 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _302 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _308 = int(_302 + (_Globals.InputWeightIndexSize * uint(_299)));
    float3x4 _310;
    _310 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _311;
    for (int _313 = 0; _313 < _299; _310 = _311, _313++)
    {
        int _321 = int(_302 + (_Globals.InputWeightIndexSize * uint(_313)));
        int _326 = int(InputWeightStream.read(uint(uint(_321))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _372 = float4(float(InputWeightStream.read(uint(uint(_308 + _313))).x) * 0.0039215688593685626983642578125);
            int _373 = int((InputWeightStream.read(uint(uint(_321 + 1))).x << 8u) | uint(_326)) * 3;
            _311 = float3x4(_310[0] + (_372 * BoneMatrices.read(uint(uint(_373)))), _310[1] + (_372 * BoneMatrices.read(uint(uint(_373 + 1)))), _310[2] + (_372 * BoneMatrices.read(uint(uint(_373 + 2)))));
        }
        else
        {
            float4 _337 = float4(float(InputWeightStream.read(uint(uint(_308 + _313))).x) * 0.0039215688593685626983642578125);
            int _338 = _326 * 3;
            _311 = float3x4(_310[0] + (_337 * BoneMatrices.read(uint(uint(_338)))), _310[1] + (_337 * BoneMatrices.read(uint(uint(_338 + 1)))), _310[2] + (_337 * BoneMatrices.read(uint(uint(_338 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _108;
    _108 = _109;
    float _575;
    float3x3 _576;
    if (_108[0].SimulIndices.w < 65535u)
    {
        float _404;
        float3 _407;
        float3 _409;
        float _411;
        int _413;
        _404 = _Globals.ClothBlendWeight;
        _407 = float3(0.0);
        _409 = float3(0.0);
        _411 = 0.0;
        _413 = 0;
        float _405;
        float3 _408;
        float3 _410;
        float _412;
        int _414;
        for (int _415 = 0; _415 < 5; _404 = _405, _407 = _408, _409 = _410, _411 = _412, _413 = _414, _415++)
        {
            bool _427 = _108[_415].SimulIndices.w < 65535u;
            if (_427)
            {
                int _433 = int(_108[_415].SimulIndices.x) * 3;
                uint _438 = uint(_433 + 1);
                float3 _447 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_433))).xy, ClothSimulVertsPositionsNormals.read(uint(_438)).x, 1.0)).xyz;
                int _450 = int(_108[_415].SimulIndices.y) * 3;
                uint _454 = uint(_450 + 1);
                float3 _461 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_450))).xy, ClothSimulVertsPositionsNormals.read(uint(_454)).x, 1.0)).xyz;
                int _464 = int(_108[_415].SimulIndices.z) * 3;
                uint _468 = uint(_464 + 1);
                float3 _475 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_464))).xy, ClothSimulVertsPositionsNormals.read(uint(_468)).x, 1.0)).xyz;
                float3 _485 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_438)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_433 + 2))).xy, 0.0)).xyz;
                float3 _495 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_454)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_450 + 2))).xy, 0.0)).xyz;
                float3 _505 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_468)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_464 + 2))).xy, 0.0)).xyz;
                _408 = _407 + (((((_447 + (_485 * _108[_415].BaryCoordNormal.w)) * _108[_415].BaryCoordNormal.x) + ((_461 + (_495 * _108[_415].BaryCoordNormal.w)) * _108[_415].BaryCoordNormal.y)) + ((_475 + (_505 * _108[_415].BaryCoordNormal.w)) * _108[_415].BaryCoordNormal.z)) * _108[_415].Weight);
                _410 = _409 + (((((_447 + (_485 * _108[_415].BaryCoordTangent.w)) * _108[_415].BaryCoordTangent.x) + ((_461 + (_495 * _108[_415].BaryCoordTangent.w)) * _108[_415].BaryCoordTangent.y)) + ((_475 + (_505 * _108[_415].BaryCoordTangent.w)) * _108[_415].BaryCoordTangent.z)) * _108[_415].Weight);
                _412 = _411 + _108[_415].Weight;
                _414 = _413 + 1;
            }
            else
            {
                _408 = _407;
                _410 = _409;
                _412 = _411;
                _414 = _413;
            }
            _405 = _427 ? _Globals.ClothBlendWeight : _404;
        }
        bool _543 = (_413 > 0) && (_411 > 9.9999997473787516355514526367188e-05);
        float3x3 _567;
        if (_543)
        {
            float _547 = 1.0 / _411;
            float3x3 _562 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _564 = _106;
            _564[0] = _562 * normalize((_409 * _547) - _297);
            float3x3 _566 = _564;
            _566[2] = _562 * normalize((_407 * _547) - _297);
            _567 = _566;
        }
        else
        {
            _567 = _106;
        }
        float3x3 _574 = _567;
        _574[1] = cross(_567[2], _567[0]) * in.in_var_ATTRIBUTE2.w;
        _575 = _543 ? _404 : 0.0;
        _576 = _574;
    }
    else
    {
        _575 = 0.0;
        _576 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _582 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _310);
    float3 _588 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _310);
    float3 _593 = float3(_575);
    float3 _601 = float3(1.0 - _575);
    float4 _676;
    switch (0u)
    {
        default:
        {
            if (_109[0].SimulIndices.w < 65535u)
            {
                _676 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _310) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _297, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _625 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _310) + in.in_var_ATTRIBUTE12;
                _676 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _625.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _625.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _625.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _690 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _690[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _693 = _690;
    _693[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _696 = _693;
    _696[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _709 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_676.x, _676.y, _676.z, _676.w);
    out.out_var_TEXCOORD6 = float4(_676.x, _676.y, _676.z, _676.w);
    out.out_var_TEXCOORD8 = float4((_696 * float3x3((_576[0] * _593) + (_582 * _601), (_576[1] * _593) + (normalize(cross(_588, _582) * in.in_var_ATTRIBUTE2.w) * _601), (_576[2] * _593) + (_588 * _601)))[2], _105).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _709;
    return out;
}

