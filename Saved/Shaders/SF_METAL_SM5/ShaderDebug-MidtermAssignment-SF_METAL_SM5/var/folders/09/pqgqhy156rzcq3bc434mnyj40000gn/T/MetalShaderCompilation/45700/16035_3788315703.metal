

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

constant float _101 = {};
constant float3x3 _102 = {};
constant float4 _103 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00003ea3_e1cd1c37(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _106;
    for (int _125 = 0; _125 < 1; )
    {
        uint _132 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_125)) * 4u;
        _106[_125].BaryCoordPos = GPUSkinApexCloth.read(uint(_132));
        _106[_125].BaryCoordNormal = GPUSkinApexCloth.read(uint((_132 + 1u)));
        _106[_125].BaryCoordTangent = GPUSkinApexCloth.read(uint((_132 + 2u)));
        uint4 _144 = as_type<uint4>(GPUSkinApexCloth.read(uint((_132 + 3u))));
        uint2 _145 = _144.xy;
        uint2 _148 = (_145 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _106[_125].SimulIndices = uint4(_106[_125].SimulIndices.x, _148.x, _106[_125].SimulIndices.z, _148.y);
        uint2 _152 = _145 & uint2(65535u);
        _106[_125].SimulIndices = uint4(_152.x, _106[_125].SimulIndices.y, _152.y, _106[_125].SimulIndices.w);
        _106[_125].Weight = as_type<float>(_144.z);
        _125++;
        continue;
    }
    float3 _291;
    if (_106[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _107;
        _107 = _106;
        float3 _168;
        float _171;
        int _173;
        _168 = float3(0.0);
        _171 = 0.0;
        _173 = 0;
        float _172;
        float3 _169;
        int _174;
        for (int _175 = 0; _175 < 1; _168 = _169, _171 = _172, _173 = _174, _175++)
        {
            bool _185 = _107[_175].SimulIndices.w < 65535u;
            if (_185)
            {
                int _191 = int(_107[_175].SimulIndices.x) * 3;
                uint _196 = uint(_191 + 1);
                int _208 = int(_107[_175].SimulIndices.y) * 3;
                uint _212 = uint(_208 + 1);
                int _222 = int(_107[_175].SimulIndices.z) * 3;
                uint _226 = uint(_222 + 1);
                _169 = _168 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_191))).xy, ClothSimulVertsPositionsNormals.read(uint(_196)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_196)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_191 + 2))).xy, 0.0)).xyz * _107[_175].BaryCoordPos.w)) * _107[_175].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_208))).xy, ClothSimulVertsPositionsNormals.read(uint(_212)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_212)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_208 + 2))).xy, 0.0)).xyz * _107[_175].BaryCoordPos.w)) * _107[_175].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_222))).xy, ClothSimulVertsPositionsNormals.read(uint(_226)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_226)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_222 + 2))).xy, 0.0)).xyz * _107[_175].BaryCoordPos.w)) * ((1.0 - _107[_175].BaryCoordPos.x) - _107[_175].BaryCoordPos.y))) * 1.0);
                _174 = _173 + 1;
            }
            else
            {
                _169 = _168;
                _174 = _173;
            }
            _172 = _185 ? 1.0 : _171;
        }
        float3 _290;
        if ((_173 > 0) && (_171 > 9.9999997473787516355514526367188e-05))
        {
            _290 = _168 * (1.0 / _171);
        }
        else
        {
            _290 = float3(0.0);
        }
        _291 = _290;
    }
    else
    {
        _291 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _293 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _296 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _302 = int(_296 + (_Globals.InputWeightIndexSize * uint(_293)));
    float3x4 _304;
    _304 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _305;
    for (int _307 = 0; _307 < _293; _304 = _305, _307++)
    {
        int _315 = int(_296 + (_Globals.InputWeightIndexSize * uint(_307)));
        int _320 = int(InputWeightStream.read(uint(uint(_315))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _366 = float4(float(InputWeightStream.read(uint(uint(_302 + _307))).x) * 0.0039215688593685626983642578125);
            int _367 = int((InputWeightStream.read(uint(uint(_315 + 1))).x << 8u) | uint(_320)) * 3;
            _305 = float3x4(_304[0] + (_366 * BoneMatrices.read(uint(uint(_367)))), _304[1] + (_366 * BoneMatrices.read(uint(uint(_367 + 1)))), _304[2] + (_366 * BoneMatrices.read(uint(uint(_367 + 2)))));
        }
        else
        {
            float4 _331 = float4(float(InputWeightStream.read(uint(uint(_302 + _307))).x) * 0.0039215688593685626983642578125);
            int _332 = _320 * 3;
            _305 = float3x4(_304[0] + (_331 * BoneMatrices.read(uint(uint(_332)))), _304[1] + (_331 * BoneMatrices.read(uint(uint(_332 + 1)))), _304[2] + (_331 * BoneMatrices.read(uint(uint(_332 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _105;
    _105 = _106;
    float _567;
    float3x3 _568;
    if (_105[0].SimulIndices.w < 65535u)
    {
        float _398;
        float3 _401;
        float3 _403;
        float _405;
        int _407;
        _398 = _Globals.ClothBlendWeight;
        _401 = float3(0.0);
        _403 = float3(0.0);
        _405 = 0.0;
        _407 = 0;
        float _399;
        float _406;
        float3 _402;
        float3 _404;
        int _408;
        for (int _409 = 0; _409 < 1; _398 = _399, _401 = _402, _403 = _404, _405 = _406, _407 = _408, _409++)
        {
            bool _420 = _105[_409].SimulIndices.w < 65535u;
            if (_420)
            {
                int _426 = int(_105[_409].SimulIndices.x) * 3;
                uint _431 = uint(_426 + 1);
                float3 _440 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_426))).xy, ClothSimulVertsPositionsNormals.read(uint(_431)).x, 1.0)).xyz;
                int _443 = int(_105[_409].SimulIndices.y) * 3;
                uint _447 = uint(_443 + 1);
                float3 _454 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_443))).xy, ClothSimulVertsPositionsNormals.read(uint(_447)).x, 1.0)).xyz;
                int _457 = int(_105[_409].SimulIndices.z) * 3;
                uint _461 = uint(_457 + 1);
                float3 _468 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_457))).xy, ClothSimulVertsPositionsNormals.read(uint(_461)).x, 1.0)).xyz;
                float3 _478 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_431)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_426 + 2))).xy, 0.0)).xyz;
                float3 _488 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_447)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_443 + 2))).xy, 0.0)).xyz;
                float3 _498 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_461)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_457 + 2))).xy, 0.0)).xyz;
                _402 = _401 + (((((_440 + (_478 * _105[_409].BaryCoordNormal.w)) * _105[_409].BaryCoordNormal.x) + ((_454 + (_488 * _105[_409].BaryCoordNormal.w)) * _105[_409].BaryCoordNormal.y)) + ((_468 + (_498 * _105[_409].BaryCoordNormal.w)) * _105[_409].BaryCoordNormal.z)) * 1.0);
                _404 = _403 + (((((_440 + (_478 * _105[_409].BaryCoordTangent.w)) * _105[_409].BaryCoordTangent.x) + ((_454 + (_488 * _105[_409].BaryCoordTangent.w)) * _105[_409].BaryCoordTangent.y)) + ((_468 + (_498 * _105[_409].BaryCoordTangent.w)) * _105[_409].BaryCoordTangent.z)) * 1.0);
                _408 = _407 + 1;
            }
            else
            {
                _402 = _401;
                _404 = _403;
                _408 = _407;
            }
            _399 = _420 ? _Globals.ClothBlendWeight : _398;
            _406 = _420 ? 1.0 : _405;
        }
        bool _535 = (_407 > 0) && (_405 > 9.9999997473787516355514526367188e-05);
        float3x3 _559;
        if (_535)
        {
            float _539 = 1.0 / _405;
            float3x3 _554 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _556 = _102;
            _556[0] = _554 * normalize((_403 * _539) - _291);
            float3x3 _558 = _556;
            _558[2] = _554 * normalize((_401 * _539) - _291);
            _559 = _558;
        }
        else
        {
            _559 = _102;
        }
        float3x3 _566 = _559;
        _566[1] = cross(_559[2], _559[0]) * in.in_var_ATTRIBUTE2.w;
        _567 = _535 ? _398 : 0.0;
        _568 = _566;
    }
    else
    {
        _567 = 0.0;
        _568 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _574 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _304);
    float3 _580 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _304);
    float3 _585 = float3(_567);
    float3 _593 = float3(1.0 - _567);
    float4 _668;
    switch (0u)
    {
        default:
        {
            if (_106[0].SimulIndices.w < 65535u)
            {
                _668 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _304) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _291, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _617 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _304) + in.in_var_ATTRIBUTE12;
                _668 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _617.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _617.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _617.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _682 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _682[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _685 = _682;
    _685[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _688 = _685;
    _688[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _689 = _688 * float3x3((_568[0] * _585) + (_574 * _593), (_568[1] * _585) + (normalize(cross(_580, _574) * in.in_var_ATTRIBUTE2.w) * _593), (_568[2] * _585) + (_580 * _593));
    float3 _690 = _689[2];
    float _691 = _690.x;
    float4 _701 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_668.x, _668.y, _668.z, _668.w);
    float4 _712;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_701.z < 0.0))
    {
        float4 _710 = _701;
        _710.z = 9.9999999747524270787835121154785e-07;
        float4 _711 = _710;
        _711.w = 1.0;
        _712 = _711;
    }
    else
    {
        _712 = _701;
    }
    float _718 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_691, _690.yz, _101).xyz));
    float4 _737 = _103;
    _737.w = 0.0;
    float3 _738 = _689[0];
    out.out_var_TEXCOORD10_centroid = float4(_738.x, _738.y, _738.z, _737.w);
    out.out_var_TEXCOORD11_centroid = float4(_691, _690.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _712.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_718) > 0.0) ? (sqrt(fast::clamp(1.0 - (_718 * _718), 0.0, 1.0)) / _718) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _668.xyz;
    out.gl_Position = _712;
    return out;
}

