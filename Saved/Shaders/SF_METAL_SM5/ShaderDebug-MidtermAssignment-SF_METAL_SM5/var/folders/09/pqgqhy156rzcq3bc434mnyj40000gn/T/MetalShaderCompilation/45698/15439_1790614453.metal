

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
constant float4 _107 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainForGS_out Main_00003c4f_6aba9bb5(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    spvUnsafeArray<FClothVertex, 5> _110;
    for (int _129 = 0; _129 < 5; )
    {
        uint _137 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_129)) * 4u;
        _110[_129].BaryCoordPos = GPUSkinApexCloth.read(uint(_137));
        _110[_129].BaryCoordNormal = GPUSkinApexCloth.read(uint((_137 + 1u)));
        _110[_129].BaryCoordTangent = GPUSkinApexCloth.read(uint((_137 + 2u)));
        uint4 _149 = as_type<uint4>(GPUSkinApexCloth.read(uint((_137 + 3u))));
        uint2 _150 = _149.xy;
        uint2 _153 = (_150 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _110[_129].SimulIndices = uint4(_110[_129].SimulIndices.x, _153.x, _110[_129].SimulIndices.z, _153.y);
        uint2 _157 = _150 & uint2(65535u);
        _110[_129].SimulIndices = uint4(_157.x, _110[_129].SimulIndices.y, _157.y, _110[_129].SimulIndices.w);
        _110[_129].Weight = as_type<float>(_149.z);
        _129++;
        continue;
    }
    float3 _298;
    if (_110[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _111;
        _111 = _110;
        float3 _173;
        float _176;
        int _178;
        _173 = float3(0.0);
        _176 = 0.0;
        _178 = 0;
        float3 _174;
        float _177;
        int _179;
        for (int _180 = 0; _180 < 5; _173 = _174, _176 = _177, _178 = _179, _180++)
        {
            if (_111[_180].SimulIndices.w < 65535u)
            {
                int _197 = int(_111[_180].SimulIndices.x) * 3;
                uint _202 = uint(_197 + 1);
                int _214 = int(_111[_180].SimulIndices.y) * 3;
                uint _218 = uint(_214 + 1);
                int _228 = int(_111[_180].SimulIndices.z) * 3;
                uint _232 = uint(_228 + 1);
                _174 = _173 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_197))).xy, ClothSimulVertsPositionsNormals.read(uint(_202)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_202)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_197 + 2))).xy, 0.0)).xyz * _111[_180].BaryCoordPos.w)) * _111[_180].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_214))).xy, ClothSimulVertsPositionsNormals.read(uint(_218)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_218)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_214 + 2))).xy, 0.0)).xyz * _111[_180].BaryCoordPos.w)) * _111[_180].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_228))).xy, ClothSimulVertsPositionsNormals.read(uint(_232)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_232)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_228 + 2))).xy, 0.0)).xyz * _111[_180].BaryCoordPos.w)) * ((1.0 - _111[_180].BaryCoordPos.x) - _111[_180].BaryCoordPos.y))) * _111[_180].Weight);
                _177 = _176 + _111[_180].Weight;
                _179 = _178 + 1;
            }
            else
            {
                _174 = _173;
                _177 = _176;
                _179 = _178;
            }
        }
        float3 _297;
        if ((_178 > 0) && (_176 > 9.9999997473787516355514526367188e-05))
        {
            _297 = _173 * (1.0 / _176);
        }
        else
        {
            _297 = float3(0.0);
        }
        _298 = _297;
    }
    else
    {
        _298 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _300 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _303 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _309 = int(_303 + (_Globals.InputWeightIndexSize * uint(_300)));
    float3x4 _311;
    _311 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _312;
    for (int _314 = 0; _314 < _300; _311 = _312, _314++)
    {
        int _322 = int(_303 + (_Globals.InputWeightIndexSize * uint(_314)));
        int _327 = int(InputWeightStream.read(uint(uint(_322))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _373 = float4(float(InputWeightStream.read(uint(uint(_309 + _314))).x) * 0.0039215688593685626983642578125);
            int _374 = int((InputWeightStream.read(uint(uint(_322 + 1))).x << 8u) | uint(_327)) * 3;
            _312 = float3x4(_311[0] + (_373 * BoneMatrices.read(uint(uint(_374)))), _311[1] + (_373 * BoneMatrices.read(uint(uint(_374 + 1)))), _311[2] + (_373 * BoneMatrices.read(uint(uint(_374 + 2)))));
        }
        else
        {
            float4 _338 = float4(float(InputWeightStream.read(uint(uint(_309 + _314))).x) * 0.0039215688593685626983642578125);
            int _339 = _327 * 3;
            _312 = float3x4(_311[0] + (_338 * BoneMatrices.read(uint(uint(_339)))), _311[1] + (_338 * BoneMatrices.read(uint(uint(_339 + 1)))), _311[2] + (_338 * BoneMatrices.read(uint(uint(_339 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _109;
    _109 = _110;
    float _576;
    float3x3 _577;
    if (_109[0].SimulIndices.w < 65535u)
    {
        float _405;
        float3 _408;
        float3 _410;
        float _412;
        int _414;
        _405 = _Globals.ClothBlendWeight;
        _408 = float3(0.0);
        _410 = float3(0.0);
        _412 = 0.0;
        _414 = 0;
        float _406;
        float3 _409;
        float3 _411;
        float _413;
        int _415;
        for (int _416 = 0; _416 < 5; _405 = _406, _408 = _409, _410 = _411, _412 = _413, _414 = _415, _416++)
        {
            bool _428 = _109[_416].SimulIndices.w < 65535u;
            if (_428)
            {
                int _434 = int(_109[_416].SimulIndices.x) * 3;
                uint _439 = uint(_434 + 1);
                float3 _448 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_434))).xy, ClothSimulVertsPositionsNormals.read(uint(_439)).x, 1.0)).xyz;
                int _451 = int(_109[_416].SimulIndices.y) * 3;
                uint _455 = uint(_451 + 1);
                float3 _462 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_451))).xy, ClothSimulVertsPositionsNormals.read(uint(_455)).x, 1.0)).xyz;
                int _465 = int(_109[_416].SimulIndices.z) * 3;
                uint _469 = uint(_465 + 1);
                float3 _476 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_465))).xy, ClothSimulVertsPositionsNormals.read(uint(_469)).x, 1.0)).xyz;
                float3 _486 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_439)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_434 + 2))).xy, 0.0)).xyz;
                float3 _496 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_455)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_451 + 2))).xy, 0.0)).xyz;
                float3 _506 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_469)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_465 + 2))).xy, 0.0)).xyz;
                _409 = _408 + (((((_448 + (_486 * _109[_416].BaryCoordNormal.w)) * _109[_416].BaryCoordNormal.x) + ((_462 + (_496 * _109[_416].BaryCoordNormal.w)) * _109[_416].BaryCoordNormal.y)) + ((_476 + (_506 * _109[_416].BaryCoordNormal.w)) * _109[_416].BaryCoordNormal.z)) * _109[_416].Weight);
                _411 = _410 + (((((_448 + (_486 * _109[_416].BaryCoordTangent.w)) * _109[_416].BaryCoordTangent.x) + ((_462 + (_496 * _109[_416].BaryCoordTangent.w)) * _109[_416].BaryCoordTangent.y)) + ((_476 + (_506 * _109[_416].BaryCoordTangent.w)) * _109[_416].BaryCoordTangent.z)) * _109[_416].Weight);
                _413 = _412 + _109[_416].Weight;
                _415 = _414 + 1;
            }
            else
            {
                _409 = _408;
                _411 = _410;
                _413 = _412;
                _415 = _414;
            }
            _406 = _428 ? _Globals.ClothBlendWeight : _405;
        }
        bool _544 = (_414 > 0) && (_412 > 9.9999997473787516355514526367188e-05);
        float3x3 _568;
        if (_544)
        {
            float _548 = 1.0 / _412;
            float3x3 _563 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _565 = _106;
            _565[0] = _563 * normalize((_410 * _548) - _298);
            float3x3 _567 = _565;
            _567[2] = _563 * normalize((_408 * _548) - _298);
            _568 = _567;
        }
        else
        {
            _568 = _106;
        }
        float3x3 _575 = _568;
        _575[1] = cross(_568[2], _568[0]) * in.in_var_ATTRIBUTE2.w;
        _576 = _544 ? _405 : 0.0;
        _577 = _575;
    }
    else
    {
        _576 = 0.0;
        _577 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _583 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _311);
    float3 _589 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _311);
    float3 _594 = float3(_576);
    float3 _602 = float3(1.0 - _576);
    float4 _677;
    switch (0u)
    {
        default:
        {
            if (_110[0].SimulIndices.w < 65535u)
            {
                _677 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _311) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _298, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _626 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _311) + in.in_var_ATTRIBUTE12;
                _677 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _626.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _626.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _626.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _691 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _691[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _694 = _691;
    _694[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _697 = _694;
    _697[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _698 = _697 * float3x3((_577[0] * _594) + (_583 * _602), (_577[1] * _594) + (normalize(cross(_589, _583) * in.in_var_ATTRIBUTE2.w) * _602), (_577[2] * _594) + (_589 * _602));
    float3 _699 = _698[2];
    float _700 = _699.x;
    float4 _706 = _107;
    _706.w = 0.0;
    float3 _707 = _698[0];
    float4 _718 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_677.x, _677.y, _677.z, _677.w);
    out.out_var_TEXCOORD10_centroid = float4(_707.x, _707.y, _707.z, _706.w);
    out.out_var_TEXCOORD11_centroid = float4(_700, _699.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _677.xyz;
    out.out_var_TEXCOORD6 = _718;
    out.out_var_TEXCOORD8 = float4(_700, _699.yz, _105).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _718;
    return out;
}

