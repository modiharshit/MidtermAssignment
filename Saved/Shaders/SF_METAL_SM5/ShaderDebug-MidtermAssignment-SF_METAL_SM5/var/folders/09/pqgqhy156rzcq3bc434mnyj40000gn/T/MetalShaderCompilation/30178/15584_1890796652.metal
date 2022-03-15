

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

constant spvUnsafeArray<float2, 1> _95 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _103 = {};
constant float4 _104 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00003ce0_70b3446c(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _108;
    for (int _131 = 0; _131 < 1; )
    {
        uint _138 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_131)) * 4u;
        _108[_131].BaryCoordPos = GPUSkinApexCloth.read(uint(_138));
        _108[_131].BaryCoordNormal = GPUSkinApexCloth.read(uint((_138 + 1u)));
        _108[_131].BaryCoordTangent = GPUSkinApexCloth.read(uint((_138 + 2u)));
        uint4 _150 = as_type<uint4>(GPUSkinApexCloth.read(uint((_138 + 3u))));
        uint2 _151 = _150.xy;
        uint2 _154 = (_151 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _108[_131].SimulIndices = uint4(_108[_131].SimulIndices.x, _154.x, _108[_131].SimulIndices.z, _154.y);
        uint2 _158 = _151 & uint2(65535u);
        _108[_131].SimulIndices = uint4(_158.x, _108[_131].SimulIndices.y, _158.y, _108[_131].SimulIndices.w);
        _108[_131].Weight = as_type<float>(_150.z);
        _131++;
        continue;
    }
    float3 _297;
    if (_108[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _110;
        _110 = _108;
        float3 _174;
        float _177;
        int _179;
        _174 = float3(0.0);
        _177 = 0.0;
        _179 = 0;
        float _178;
        float3 _175;
        int _180;
        for (int _181 = 0; _181 < 1; _174 = _175, _177 = _178, _179 = _180, _181++)
        {
            bool _191 = _110[_181].SimulIndices.w < 65535u;
            if (_191)
            {
                int _197 = int(_110[_181].SimulIndices.x) * 3;
                uint _202 = uint(_197 + 1);
                int _214 = int(_110[_181].SimulIndices.y) * 3;
                uint _218 = uint(_214 + 1);
                int _228 = int(_110[_181].SimulIndices.z) * 3;
                uint _232 = uint(_228 + 1);
                _175 = _174 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_197))).xy, ClothSimulVertsPositionsNormals.read(uint(_202)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_202)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_197 + 2))).xy, 0.0)).xyz * _110[_181].BaryCoordPos.w)) * _110[_181].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_214))).xy, ClothSimulVertsPositionsNormals.read(uint(_218)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_218)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_214 + 2))).xy, 0.0)).xyz * _110[_181].BaryCoordPos.w)) * _110[_181].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_228))).xy, ClothSimulVertsPositionsNormals.read(uint(_232)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_232)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_228 + 2))).xy, 0.0)).xyz * _110[_181].BaryCoordPos.w)) * ((1.0 - _110[_181].BaryCoordPos.x) - _110[_181].BaryCoordPos.y))) * 1.0);
                _180 = _179 + 1;
            }
            else
            {
                _175 = _174;
                _180 = _179;
            }
            _178 = _191 ? 1.0 : _177;
        }
        float3 _296;
        if ((_179 > 0) && (_177 > 9.9999997473787516355514526367188e-05))
        {
            _296 = _174 * (1.0 / _177);
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
    spvUnsafeArray<FClothVertex, 1> _107;
    _107 = _108;
    float _573;
    float3x3 _574;
    if (_107[0].SimulIndices.w < 65535u)
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
        float _412;
        float3 _408;
        float3 _410;
        int _414;
        for (int _415 = 0; _415 < 1; _404 = _405, _407 = _408, _409 = _410, _411 = _412, _413 = _414, _415++)
        {
            bool _426 = _107[_415].SimulIndices.w < 65535u;
            if (_426)
            {
                int _432 = int(_107[_415].SimulIndices.x) * 3;
                uint _437 = uint(_432 + 1);
                float3 _446 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_432))).xy, ClothSimulVertsPositionsNormals.read(uint(_437)).x, 1.0)).xyz;
                int _449 = int(_107[_415].SimulIndices.y) * 3;
                uint _453 = uint(_449 + 1);
                float3 _460 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_449))).xy, ClothSimulVertsPositionsNormals.read(uint(_453)).x, 1.0)).xyz;
                int _463 = int(_107[_415].SimulIndices.z) * 3;
                uint _467 = uint(_463 + 1);
                float3 _474 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_463))).xy, ClothSimulVertsPositionsNormals.read(uint(_467)).x, 1.0)).xyz;
                float3 _484 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_437)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_432 + 2))).xy, 0.0)).xyz;
                float3 _494 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_453)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_449 + 2))).xy, 0.0)).xyz;
                float3 _504 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_467)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_463 + 2))).xy, 0.0)).xyz;
                _408 = _407 + (((((_446 + (_484 * _107[_415].BaryCoordNormal.w)) * _107[_415].BaryCoordNormal.x) + ((_460 + (_494 * _107[_415].BaryCoordNormal.w)) * _107[_415].BaryCoordNormal.y)) + ((_474 + (_504 * _107[_415].BaryCoordNormal.w)) * _107[_415].BaryCoordNormal.z)) * 1.0);
                _410 = _409 + (((((_446 + (_484 * _107[_415].BaryCoordTangent.w)) * _107[_415].BaryCoordTangent.x) + ((_460 + (_494 * _107[_415].BaryCoordTangent.w)) * _107[_415].BaryCoordTangent.y)) + ((_474 + (_504 * _107[_415].BaryCoordTangent.w)) * _107[_415].BaryCoordTangent.z)) * 1.0);
                _414 = _413 + 1;
            }
            else
            {
                _408 = _407;
                _410 = _409;
                _414 = _413;
            }
            _405 = _426 ? _Globals.ClothBlendWeight : _404;
            _412 = _426 ? 1.0 : _411;
        }
        bool _541 = (_413 > 0) && (_411 > 9.9999997473787516355514526367188e-05);
        float3x3 _565;
        if (_541)
        {
            float _545 = 1.0 / _411;
            float3x3 _560 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _562 = _103;
            _562[0] = _560 * normalize((_409 * _545) - _297);
            float3x3 _564 = _562;
            _564[2] = _560 * normalize((_407 * _545) - _297);
            _565 = _564;
        }
        else
        {
            _565 = _103;
        }
        float3x3 _572 = _565;
        _572[1] = cross(_565[2], _565[0]) * in.in_var_ATTRIBUTE2.w;
        _573 = _541 ? _404 : 0.0;
        _574 = _572;
    }
    else
    {
        _573 = 0.0;
        _574 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _580 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _310);
    float3 _586 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _310);
    float3 _591 = float3(_573);
    float3 _599 = float3(1.0 - _573);
    float4 _674;
    switch (0u)
    {
        default:
        {
            if (_108[0].SimulIndices.w < 65535u)
            {
                _674 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _310) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _297, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _623 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _310) + in.in_var_ATTRIBUTE12;
                _674 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _623.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _623.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _623.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _106;
    _106 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _109 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _676 = 0; _676 < 1; )
    {
        _109[_676] = _106[_676];
        _676++;
        continue;
    }
    float4 _686 = View.View_TranslatedWorldToClip * float4(_674.x, _674.y, _674.z, _674.w);
    float4 _689 = _104;
    _689.w = 0.0;
    float3x3 _703 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _703[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _706 = _703;
    _706[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _709 = _706;
    _709[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _710 = _709 * float3x3((_574[0] * _591) + (_580 * _599), (_574[1] * _591) + (normalize(cross(_586, _580) * in.in_var_ATTRIBUTE2.w) * _599), (_574[2] * _591) + (_586 * _599));
    float3 _711 = _710[0];
    spvUnsafeArray<float4, 1> _721 = { float4(_109[0].x, _109[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_711.x, _711.y, _711.z, _689.w);
    out.out_var_TEXCOORD11_centroid = float4(_710[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _721;
    out.out_var_TEXCOORD6 = float4(_674.x, _674.y, _674.z, _674.w);
    out.gl_Position = _686;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

