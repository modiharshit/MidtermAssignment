

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

constant spvUnsafeArray<float2, 1> _94 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _102 = {};
constant float4 _103 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003c23_e4c800d8(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _107;
    for (int _130 = 0; _130 < 1; )
    {
        uint _137 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_130)) * 4u;
        _107[_130].BaryCoordPos = GPUSkinApexCloth.read(uint(_137));
        _107[_130].BaryCoordNormal = GPUSkinApexCloth.read(uint((_137 + 1u)));
        _107[_130].BaryCoordTangent = GPUSkinApexCloth.read(uint((_137 + 2u)));
        uint4 _149 = as_type<uint4>(GPUSkinApexCloth.read(uint((_137 + 3u))));
        uint2 _150 = _149.xy;
        uint2 _153 = (_150 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _107[_130].SimulIndices = uint4(_107[_130].SimulIndices.x, _153.x, _107[_130].SimulIndices.z, _153.y);
        uint2 _157 = _150 & uint2(65535u);
        _107[_130].SimulIndices = uint4(_157.x, _107[_130].SimulIndices.y, _157.y, _107[_130].SimulIndices.w);
        _107[_130].Weight = as_type<float>(_149.z);
        _130++;
        continue;
    }
    float3 _296;
    if (_107[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _109;
        _109 = _107;
        float3 _173;
        float _176;
        int _178;
        _173 = float3(0.0);
        _176 = 0.0;
        _178 = 0;
        float _177;
        float3 _174;
        int _179;
        for (int _180 = 0; _180 < 1; _173 = _174, _176 = _177, _178 = _179, _180++)
        {
            bool _190 = _109[_180].SimulIndices.w < 65535u;
            if (_190)
            {
                int _196 = int(_109[_180].SimulIndices.x) * 3;
                uint _201 = uint(_196 + 1);
                int _213 = int(_109[_180].SimulIndices.y) * 3;
                uint _217 = uint(_213 + 1);
                int _227 = int(_109[_180].SimulIndices.z) * 3;
                uint _231 = uint(_227 + 1);
                _174 = _173 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_196))).xy, ClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_201)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_196 + 2))).xy, 0.0)).xyz * _109[_180].BaryCoordPos.w)) * _109[_180].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _109[_180].BaryCoordPos.w)) * _109[_180].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, ClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_231)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _109[_180].BaryCoordPos.w)) * ((1.0 - _109[_180].BaryCoordPos.x) - _109[_180].BaryCoordPos.y))) * 1.0);
                _179 = _178 + 1;
            }
            else
            {
                _174 = _173;
                _179 = _178;
            }
            _177 = _190 ? 1.0 : _176;
        }
        float3 _295;
        if ((_178 > 0) && (_176 > 9.9999997473787516355514526367188e-05))
        {
            _295 = _173 * (1.0 / _176);
        }
        else
        {
            _295 = float3(0.0);
        }
        _296 = _295;
    }
    else
    {
        _296 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _298 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _301 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _307 = int(_301 + (_Globals.InputWeightIndexSize * uint(_298)));
    float3x4 _309;
    _309 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _310;
    for (int _312 = 0; _312 < _298; _309 = _310, _312++)
    {
        int _320 = int(_301 + (_Globals.InputWeightIndexSize * uint(_312)));
        int _325 = int(InputWeightStream.read(uint(uint(_320))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _371 = float4(float(InputWeightStream.read(uint(uint(_307 + _312))).x) * 0.0039215688593685626983642578125);
            int _372 = int((InputWeightStream.read(uint(uint(_320 + 1))).x << 8u) | uint(_325)) * 3;
            _310 = float3x4(_309[0] + (_371 * BoneMatrices.read(uint(uint(_372)))), _309[1] + (_371 * BoneMatrices.read(uint(uint(_372 + 1)))), _309[2] + (_371 * BoneMatrices.read(uint(uint(_372 + 2)))));
        }
        else
        {
            float4 _336 = float4(float(InputWeightStream.read(uint(uint(_307 + _312))).x) * 0.0039215688593685626983642578125);
            int _337 = _325 * 3;
            _310 = float3x4(_309[0] + (_336 * BoneMatrices.read(uint(uint(_337)))), _309[1] + (_336 * BoneMatrices.read(uint(uint(_337 + 1)))), _309[2] + (_336 * BoneMatrices.read(uint(uint(_337 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _106;
    _106 = _107;
    float _572;
    float3x3 _573;
    if (_106[0].SimulIndices.w < 65535u)
    {
        float _403;
        float3 _406;
        float3 _408;
        float _410;
        int _412;
        _403 = _Globals.ClothBlendWeight;
        _406 = float3(0.0);
        _408 = float3(0.0);
        _410 = 0.0;
        _412 = 0;
        float _404;
        float _411;
        float3 _407;
        float3 _409;
        int _413;
        for (int _414 = 0; _414 < 1; _403 = _404, _406 = _407, _408 = _409, _410 = _411, _412 = _413, _414++)
        {
            bool _425 = _106[_414].SimulIndices.w < 65535u;
            if (_425)
            {
                int _431 = int(_106[_414].SimulIndices.x) * 3;
                uint _436 = uint(_431 + 1);
                float3 _445 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_431))).xy, ClothSimulVertsPositionsNormals.read(uint(_436)).x, 1.0)).xyz;
                int _448 = int(_106[_414].SimulIndices.y) * 3;
                uint _452 = uint(_448 + 1);
                float3 _459 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_448))).xy, ClothSimulVertsPositionsNormals.read(uint(_452)).x, 1.0)).xyz;
                int _462 = int(_106[_414].SimulIndices.z) * 3;
                uint _466 = uint(_462 + 1);
                float3 _473 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_462))).xy, ClothSimulVertsPositionsNormals.read(uint(_466)).x, 1.0)).xyz;
                float3 _483 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_436)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_431 + 2))).xy, 0.0)).xyz;
                float3 _493 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_452)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_448 + 2))).xy, 0.0)).xyz;
                float3 _503 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_466)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_462 + 2))).xy, 0.0)).xyz;
                _407 = _406 + (((((_445 + (_483 * _106[_414].BaryCoordNormal.w)) * _106[_414].BaryCoordNormal.x) + ((_459 + (_493 * _106[_414].BaryCoordNormal.w)) * _106[_414].BaryCoordNormal.y)) + ((_473 + (_503 * _106[_414].BaryCoordNormal.w)) * _106[_414].BaryCoordNormal.z)) * 1.0);
                _409 = _408 + (((((_445 + (_483 * _106[_414].BaryCoordTangent.w)) * _106[_414].BaryCoordTangent.x) + ((_459 + (_493 * _106[_414].BaryCoordTangent.w)) * _106[_414].BaryCoordTangent.y)) + ((_473 + (_503 * _106[_414].BaryCoordTangent.w)) * _106[_414].BaryCoordTangent.z)) * 1.0);
                _413 = _412 + 1;
            }
            else
            {
                _407 = _406;
                _409 = _408;
                _413 = _412;
            }
            _404 = _425 ? _Globals.ClothBlendWeight : _403;
            _411 = _425 ? 1.0 : _410;
        }
        bool _540 = (_412 > 0) && (_410 > 9.9999997473787516355514526367188e-05);
        float3x3 _564;
        if (_540)
        {
            float _544 = 1.0 / _410;
            float3x3 _559 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _561 = _102;
            _561[0] = _559 * normalize((_408 * _544) - _296);
            float3x3 _563 = _561;
            _563[2] = _559 * normalize((_406 * _544) - _296);
            _564 = _563;
        }
        else
        {
            _564 = _102;
        }
        float3x3 _571 = _564;
        _571[1] = cross(_564[2], _564[0]) * in.in_var_ATTRIBUTE2.w;
        _572 = _540 ? _403 : 0.0;
        _573 = _571;
    }
    else
    {
        _572 = 0.0;
        _573 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _579 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _309);
    float3 _585 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _309);
    float3 _590 = float3(_572);
    float3 _598 = float3(1.0 - _572);
    float4 _673;
    switch (0u)
    {
        default:
        {
            if (_107[0].SimulIndices.w < 65535u)
            {
                _673 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _309) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _296, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _622 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _309) + in.in_var_ATTRIBUTE12;
                _673 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _622.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _622.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _622.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _105;
    _105 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _108 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _675 = 0; _675 < 1; )
    {
        _108[_675] = _105[_675];
        _675++;
        continue;
    }
    float4 _685 = View.View_TranslatedWorldToClip * float4(_673.x, _673.y, _673.z, _673.w);
    float4 _688 = _103;
    _688.w = 0.0;
    float3x3 _702 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _702[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _705 = _702;
    _705[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _708 = _705;
    _708[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _709 = _708 * float3x3((_573[0] * _590) + (_579 * _598), (_573[1] * _590) + (normalize(cross(_585, _579) * in.in_var_ATTRIBUTE2.w) * _598), (_573[2] * _590) + (_585 * _598));
    float3 _710 = _709[0];
    spvUnsafeArray<float4, 1> _720 = { float4(_108[0].x, _108[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_710.x, _710.y, _710.z, _688.w);
    out.out_var_TEXCOORD11_centroid = float4(_709[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _720;
    out.gl_Position = _685;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

