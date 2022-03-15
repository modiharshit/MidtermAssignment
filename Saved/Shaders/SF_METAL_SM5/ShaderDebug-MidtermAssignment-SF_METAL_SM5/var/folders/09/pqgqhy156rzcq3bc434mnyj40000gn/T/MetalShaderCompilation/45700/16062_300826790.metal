

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

constant float _100 = {};
constant float3x3 _101 = {};
constant float4 _102 = {};

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

vertex Main_out Main_00003ebe_11ee40a6(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _105;
    for (int _124 = 0; _124 < 1; )
    {
        uint _131 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_124)) * 4u;
        _105[_124].BaryCoordPos = GPUSkinApexCloth.read(uint(_131));
        _105[_124].BaryCoordNormal = GPUSkinApexCloth.read(uint((_131 + 1u)));
        _105[_124].BaryCoordTangent = GPUSkinApexCloth.read(uint((_131 + 2u)));
        uint4 _143 = as_type<uint4>(GPUSkinApexCloth.read(uint((_131 + 3u))));
        uint2 _144 = _143.xy;
        uint2 _147 = (_144 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _105[_124].SimulIndices = uint4(_105[_124].SimulIndices.x, _147.x, _105[_124].SimulIndices.z, _147.y);
        uint2 _151 = _144 & uint2(65535u);
        _105[_124].SimulIndices = uint4(_151.x, _105[_124].SimulIndices.y, _151.y, _105[_124].SimulIndices.w);
        _105[_124].Weight = as_type<float>(_143.z);
        _124++;
        continue;
    }
    float3 _290;
    if (_105[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _106;
        _106 = _105;
        float3 _167;
        float _170;
        int _172;
        _167 = float3(0.0);
        _170 = 0.0;
        _172 = 0;
        float _171;
        float3 _168;
        int _173;
        for (int _174 = 0; _174 < 1; _167 = _168, _170 = _171, _172 = _173, _174++)
        {
            bool _184 = _106[_174].SimulIndices.w < 65535u;
            if (_184)
            {
                int _190 = int(_106[_174].SimulIndices.x) * 3;
                uint _195 = uint(_190 + 1);
                int _207 = int(_106[_174].SimulIndices.y) * 3;
                uint _211 = uint(_207 + 1);
                int _221 = int(_106[_174].SimulIndices.z) * 3;
                uint _225 = uint(_221 + 1);
                _168 = _167 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_190))).xy, ClothSimulVertsPositionsNormals.read(uint(_195)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_195)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_190 + 2))).xy, 0.0)).xyz * _106[_174].BaryCoordPos.w)) * _106[_174].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_207))).xy, ClothSimulVertsPositionsNormals.read(uint(_211)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_211)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_207 + 2))).xy, 0.0)).xyz * _106[_174].BaryCoordPos.w)) * _106[_174].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_221))).xy, ClothSimulVertsPositionsNormals.read(uint(_225)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_225)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_221 + 2))).xy, 0.0)).xyz * _106[_174].BaryCoordPos.w)) * ((1.0 - _106[_174].BaryCoordPos.x) - _106[_174].BaryCoordPos.y))) * 1.0);
                _173 = _172 + 1;
            }
            else
            {
                _168 = _167;
                _173 = _172;
            }
            _171 = _184 ? 1.0 : _170;
        }
        float3 _289;
        if ((_172 > 0) && (_170 > 9.9999997473787516355514526367188e-05))
        {
            _289 = _167 * (1.0 / _170);
        }
        else
        {
            _289 = float3(0.0);
        }
        _290 = _289;
    }
    else
    {
        _290 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _292 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _295 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _301 = int(_295 + (_Globals.InputWeightIndexSize * uint(_292)));
    float3x4 _303;
    _303 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _304;
    for (int _306 = 0; _306 < _292; _303 = _304, _306++)
    {
        int _314 = int(_295 + (_Globals.InputWeightIndexSize * uint(_306)));
        int _319 = int(InputWeightStream.read(uint(uint(_314))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _365 = float4(float(InputWeightStream.read(uint(uint(_301 + _306))).x) * 0.0039215688593685626983642578125);
            int _366 = int((InputWeightStream.read(uint(uint(_314 + 1))).x << 8u) | uint(_319)) * 3;
            _304 = float3x4(_303[0] + (_365 * BoneMatrices.read(uint(uint(_366)))), _303[1] + (_365 * BoneMatrices.read(uint(uint(_366 + 1)))), _303[2] + (_365 * BoneMatrices.read(uint(uint(_366 + 2)))));
        }
        else
        {
            float4 _330 = float4(float(InputWeightStream.read(uint(uint(_301 + _306))).x) * 0.0039215688593685626983642578125);
            int _331 = _319 * 3;
            _304 = float3x4(_303[0] + (_330 * BoneMatrices.read(uint(uint(_331)))), _303[1] + (_330 * BoneMatrices.read(uint(uint(_331 + 1)))), _303[2] + (_330 * BoneMatrices.read(uint(uint(_331 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _104;
    _104 = _105;
    float _566;
    float3x3 _567;
    if (_104[0].SimulIndices.w < 65535u)
    {
        float _397;
        float3 _400;
        float3 _402;
        float _404;
        int _406;
        _397 = _Globals.ClothBlendWeight;
        _400 = float3(0.0);
        _402 = float3(0.0);
        _404 = 0.0;
        _406 = 0;
        float _398;
        float _405;
        float3 _401;
        float3 _403;
        int _407;
        for (int _408 = 0; _408 < 1; _397 = _398, _400 = _401, _402 = _403, _404 = _405, _406 = _407, _408++)
        {
            bool _419 = _104[_408].SimulIndices.w < 65535u;
            if (_419)
            {
                int _425 = int(_104[_408].SimulIndices.x) * 3;
                uint _430 = uint(_425 + 1);
                float3 _439 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_425))).xy, ClothSimulVertsPositionsNormals.read(uint(_430)).x, 1.0)).xyz;
                int _442 = int(_104[_408].SimulIndices.y) * 3;
                uint _446 = uint(_442 + 1);
                float3 _453 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_442))).xy, ClothSimulVertsPositionsNormals.read(uint(_446)).x, 1.0)).xyz;
                int _456 = int(_104[_408].SimulIndices.z) * 3;
                uint _460 = uint(_456 + 1);
                float3 _467 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_456))).xy, ClothSimulVertsPositionsNormals.read(uint(_460)).x, 1.0)).xyz;
                float3 _477 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_430)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_425 + 2))).xy, 0.0)).xyz;
                float3 _487 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_446)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_442 + 2))).xy, 0.0)).xyz;
                float3 _497 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_460)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_456 + 2))).xy, 0.0)).xyz;
                _401 = _400 + (((((_439 + (_477 * _104[_408].BaryCoordNormal.w)) * _104[_408].BaryCoordNormal.x) + ((_453 + (_487 * _104[_408].BaryCoordNormal.w)) * _104[_408].BaryCoordNormal.y)) + ((_467 + (_497 * _104[_408].BaryCoordNormal.w)) * _104[_408].BaryCoordNormal.z)) * 1.0);
                _403 = _402 + (((((_439 + (_477 * _104[_408].BaryCoordTangent.w)) * _104[_408].BaryCoordTangent.x) + ((_453 + (_487 * _104[_408].BaryCoordTangent.w)) * _104[_408].BaryCoordTangent.y)) + ((_467 + (_497 * _104[_408].BaryCoordTangent.w)) * _104[_408].BaryCoordTangent.z)) * 1.0);
                _407 = _406 + 1;
            }
            else
            {
                _401 = _400;
                _403 = _402;
                _407 = _406;
            }
            _398 = _419 ? _Globals.ClothBlendWeight : _397;
            _405 = _419 ? 1.0 : _404;
        }
        bool _534 = (_406 > 0) && (_404 > 9.9999997473787516355514526367188e-05);
        float3x3 _558;
        if (_534)
        {
            float _538 = 1.0 / _404;
            float3x3 _553 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _555 = _101;
            _555[0] = _553 * normalize((_402 * _538) - _290);
            float3x3 _557 = _555;
            _557[2] = _553 * normalize((_400 * _538) - _290);
            _558 = _557;
        }
        else
        {
            _558 = _101;
        }
        float3x3 _565 = _558;
        _565[1] = cross(_558[2], _558[0]) * in.in_var_ATTRIBUTE2.w;
        _566 = _534 ? _397 : 0.0;
        _567 = _565;
    }
    else
    {
        _566 = 0.0;
        _567 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _573 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _303);
    float3 _579 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _303);
    float3 _584 = float3(_566);
    float3 _592 = float3(1.0 - _566);
    float4 _667;
    switch (0u)
    {
        default:
        {
            if (_105[0].SimulIndices.w < 65535u)
            {
                _667 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _303) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _290, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _616 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _303) + in.in_var_ATTRIBUTE12;
                _667 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _616.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _616.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _616.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _681 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _681[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _684 = _681;
    _684[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _687 = _684;
    _687[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _688 = _687 * float3x3((_567[0] * _584) + (_573 * _592), (_567[1] * _584) + (normalize(cross(_579, _573) * in.in_var_ATTRIBUTE2.w) * _592), (_567[2] * _584) + (_579 * _592));
    float3 _689 = _688[2];
    float _690 = _689.x;
    float4 _700 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_667.x, _667.y, _667.z, _667.w);
    float4 _711;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_700.z < 0.0))
    {
        float4 _709 = _700;
        _709.z = 9.9999999747524270787835121154785e-07;
        float4 _710 = _709;
        _710.w = 1.0;
        _711 = _710;
    }
    else
    {
        _711 = _700;
    }
    float _717 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_690, _689.yz, _100).xyz));
    float4 _742 = _711;
    _742.z = ((_711.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_717) > 0.0) ? (sqrt(fast::clamp(1.0 - (_717 * _717), 0.0, 1.0)) / _717) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _711.w;
    float4 _743 = _102;
    _743.w = 0.0;
    float3 _744 = _688[0];
    out.out_var_TEXCOORD10_centroid = float4(_744.x, _744.y, _744.z, _743.w);
    out.out_var_TEXCOORD11_centroid = float4(_690, _689.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _667.xyz;
    out.gl_Position = _742;
    return out;
}

