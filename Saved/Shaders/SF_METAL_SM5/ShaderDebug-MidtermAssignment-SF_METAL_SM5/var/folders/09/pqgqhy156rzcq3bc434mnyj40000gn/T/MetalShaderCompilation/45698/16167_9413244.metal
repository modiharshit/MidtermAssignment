

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

constant float _102 = {};
constant float3x3 _103 = {};
constant float4 _104 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003f27_008fa27c(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _107;
    for (int _126 = 0; _126 < 5; )
    {
        uint _134 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_126)) * 4u;
        _107[_126].BaryCoordPos = GPUSkinApexCloth.read(uint(_134));
        _107[_126].BaryCoordNormal = GPUSkinApexCloth.read(uint((_134 + 1u)));
        _107[_126].BaryCoordTangent = GPUSkinApexCloth.read(uint((_134 + 2u)));
        uint4 _146 = as_type<uint4>(GPUSkinApexCloth.read(uint((_134 + 3u))));
        uint2 _147 = _146.xy;
        uint2 _150 = (_147 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _107[_126].SimulIndices = uint4(_107[_126].SimulIndices.x, _150.x, _107[_126].SimulIndices.z, _150.y);
        uint2 _154 = _147 & uint2(65535u);
        _107[_126].SimulIndices = uint4(_154.x, _107[_126].SimulIndices.y, _154.y, _107[_126].SimulIndices.w);
        _107[_126].Weight = as_type<float>(_146.z);
        _126++;
        continue;
    }
    float3 _295;
    if (_107[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _108;
        _108 = _107;
        float3 _170;
        float _173;
        int _175;
        _170 = float3(0.0);
        _173 = 0.0;
        _175 = 0;
        float3 _171;
        float _174;
        int _176;
        for (int _177 = 0; _177 < 5; _170 = _171, _173 = _174, _175 = _176, _177++)
        {
            if (_108[_177].SimulIndices.w < 65535u)
            {
                int _194 = int(_108[_177].SimulIndices.x) * 3;
                uint _199 = uint(_194 + 1);
                int _211 = int(_108[_177].SimulIndices.y) * 3;
                uint _215 = uint(_211 + 1);
                int _225 = int(_108[_177].SimulIndices.z) * 3;
                uint _229 = uint(_225 + 1);
                _171 = _170 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_194))).xy, ClothSimulVertsPositionsNormals.read(uint(_199)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_199)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_194 + 2))).xy, 0.0)).xyz * _108[_177].BaryCoordPos.w)) * _108[_177].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, ClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_215)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _108[_177].BaryCoordPos.w)) * _108[_177].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_225))).xy, ClothSimulVertsPositionsNormals.read(uint(_229)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_229)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_225 + 2))).xy, 0.0)).xyz * _108[_177].BaryCoordPos.w)) * ((1.0 - _108[_177].BaryCoordPos.x) - _108[_177].BaryCoordPos.y))) * _108[_177].Weight);
                _174 = _173 + _108[_177].Weight;
                _176 = _175 + 1;
            }
            else
            {
                _171 = _170;
                _174 = _173;
                _176 = _175;
            }
        }
        float3 _294;
        if ((_175 > 0) && (_173 > 9.9999997473787516355514526367188e-05))
        {
            _294 = _170 * (1.0 / _173);
        }
        else
        {
            _294 = float3(0.0);
        }
        _295 = _294;
    }
    else
    {
        _295 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _297 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _300 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _306 = int(_300 + (_Globals.InputWeightIndexSize * uint(_297)));
    float3x4 _308;
    _308 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _309;
    for (int _311 = 0; _311 < _297; _308 = _309, _311++)
    {
        int _319 = int(_300 + (_Globals.InputWeightIndexSize * uint(_311)));
        int _324 = int(InputWeightStream.read(uint(uint(_319))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _370 = float4(float(InputWeightStream.read(uint(uint(_306 + _311))).x) * 0.0039215688593685626983642578125);
            int _371 = int((InputWeightStream.read(uint(uint(_319 + 1))).x << 8u) | uint(_324)) * 3;
            _309 = float3x4(_308[0] + (_370 * BoneMatrices.read(uint(uint(_371)))), _308[1] + (_370 * BoneMatrices.read(uint(uint(_371 + 1)))), _308[2] + (_370 * BoneMatrices.read(uint(uint(_371 + 2)))));
        }
        else
        {
            float4 _335 = float4(float(InputWeightStream.read(uint(uint(_306 + _311))).x) * 0.0039215688593685626983642578125);
            int _336 = _324 * 3;
            _309 = float3x4(_308[0] + (_335 * BoneMatrices.read(uint(uint(_336)))), _308[1] + (_335 * BoneMatrices.read(uint(uint(_336 + 1)))), _308[2] + (_335 * BoneMatrices.read(uint(uint(_336 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _106;
    _106 = _107;
    float _573;
    float3x3 _574;
    if (_106[0].SimulIndices.w < 65535u)
    {
        float _402;
        float3 _405;
        float3 _407;
        float _409;
        int _411;
        _402 = _Globals.ClothBlendWeight;
        _405 = float3(0.0);
        _407 = float3(0.0);
        _409 = 0.0;
        _411 = 0;
        float _403;
        float3 _406;
        float3 _408;
        float _410;
        int _412;
        for (int _413 = 0; _413 < 5; _402 = _403, _405 = _406, _407 = _408, _409 = _410, _411 = _412, _413++)
        {
            bool _425 = _106[_413].SimulIndices.w < 65535u;
            if (_425)
            {
                int _431 = int(_106[_413].SimulIndices.x) * 3;
                uint _436 = uint(_431 + 1);
                float3 _445 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_431))).xy, ClothSimulVertsPositionsNormals.read(uint(_436)).x, 1.0)).xyz;
                int _448 = int(_106[_413].SimulIndices.y) * 3;
                uint _452 = uint(_448 + 1);
                float3 _459 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_448))).xy, ClothSimulVertsPositionsNormals.read(uint(_452)).x, 1.0)).xyz;
                int _462 = int(_106[_413].SimulIndices.z) * 3;
                uint _466 = uint(_462 + 1);
                float3 _473 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_462))).xy, ClothSimulVertsPositionsNormals.read(uint(_466)).x, 1.0)).xyz;
                float3 _483 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_436)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_431 + 2))).xy, 0.0)).xyz;
                float3 _493 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_452)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_448 + 2))).xy, 0.0)).xyz;
                float3 _503 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_466)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_462 + 2))).xy, 0.0)).xyz;
                _406 = _405 + (((((_445 + (_483 * _106[_413].BaryCoordNormal.w)) * _106[_413].BaryCoordNormal.x) + ((_459 + (_493 * _106[_413].BaryCoordNormal.w)) * _106[_413].BaryCoordNormal.y)) + ((_473 + (_503 * _106[_413].BaryCoordNormal.w)) * _106[_413].BaryCoordNormal.z)) * _106[_413].Weight);
                _408 = _407 + (((((_445 + (_483 * _106[_413].BaryCoordTangent.w)) * _106[_413].BaryCoordTangent.x) + ((_459 + (_493 * _106[_413].BaryCoordTangent.w)) * _106[_413].BaryCoordTangent.y)) + ((_473 + (_503 * _106[_413].BaryCoordTangent.w)) * _106[_413].BaryCoordTangent.z)) * _106[_413].Weight);
                _410 = _409 + _106[_413].Weight;
                _412 = _411 + 1;
            }
            else
            {
                _406 = _405;
                _408 = _407;
                _410 = _409;
                _412 = _411;
            }
            _403 = _425 ? _Globals.ClothBlendWeight : _402;
        }
        bool _541 = (_411 > 0) && (_409 > 9.9999997473787516355514526367188e-05);
        float3x3 _565;
        if (_541)
        {
            float _545 = 1.0 / _409;
            float3x3 _560 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _562 = _103;
            _562[0] = _560 * normalize((_407 * _545) - _295);
            float3x3 _564 = _562;
            _564[2] = _560 * normalize((_405 * _545) - _295);
            _565 = _564;
        }
        else
        {
            _565 = _103;
        }
        float3x3 _572 = _565;
        _572[1] = cross(_565[2], _565[0]) * in.in_var_ATTRIBUTE2.w;
        _573 = _541 ? _402 : 0.0;
        _574 = _572;
    }
    else
    {
        _573 = 0.0;
        _574 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _580 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _308);
    float3 _586 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _308);
    float3 _591 = float3(_573);
    float3 _599 = float3(1.0 - _573);
    float4 _674;
    switch (0u)
    {
        default:
        {
            if (_107[0].SimulIndices.w < 65535u)
            {
                _674 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _308) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _295, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _623 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _308) + in.in_var_ATTRIBUTE12;
                _674 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _623.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _623.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _623.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _688 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _688[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _691 = _688;
    _691[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _694 = _691;
    _694[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _695 = _694 * float3x3((_574[0] * _591) + (_580 * _599), (_574[1] * _591) + (normalize(cross(_586, _580) * in.in_var_ATTRIBUTE2.w) * _599), (_574[2] * _591) + (_586 * _599));
    float3 _696 = _695[2];
    float _697 = _696.x;
    float4 _707 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_674.x, _674.y, _674.z, _674.w);
    float4 _718;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_707.z < 0.0))
    {
        float4 _716 = _707;
        _716.z = 9.9999999747524270787835121154785e-07;
        float4 _717 = _716;
        _717.w = 1.0;
        _718 = _717;
    }
    else
    {
        _718 = _707;
    }
    float _724 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_697, _696.yz, _102).xyz));
    float4 _749 = _718;
    _749.z = ((_718.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_724) > 0.0) ? (sqrt(fast::clamp(1.0 - (_724 * _724), 0.0, 1.0)) / _724) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _718.w;
    float4 _750 = _104;
    _750.w = 0.0;
    float3 _751 = _695[0];
    out.out_var_TEXCOORD10_centroid = float4(_751.x, _751.y, _751.z, _750.w);
    out.out_var_TEXCOORD11_centroid = float4(_697, _696.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _674.xyz;
    out.gl_Position = _749;
    return out;
}

