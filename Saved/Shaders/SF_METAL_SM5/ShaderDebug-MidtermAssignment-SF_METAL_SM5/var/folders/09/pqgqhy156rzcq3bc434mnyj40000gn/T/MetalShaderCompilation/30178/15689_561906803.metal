

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

constant spvUnsafeArray<float2, 1> _97 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _105 = {};
constant float4 _106 = {};

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

vertex MainVertexShader_out Main_00003d49_217e0473(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _110;
    for (int _133 = 0; _133 < 5; )
    {
        uint _141 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_133)) * 4u;
        _110[_133].BaryCoordPos = GPUSkinApexCloth.read(uint(_141));
        _110[_133].BaryCoordNormal = GPUSkinApexCloth.read(uint((_141 + 1u)));
        _110[_133].BaryCoordTangent = GPUSkinApexCloth.read(uint((_141 + 2u)));
        uint4 _153 = as_type<uint4>(GPUSkinApexCloth.read(uint((_141 + 3u))));
        uint2 _154 = _153.xy;
        uint2 _157 = (_154 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _110[_133].SimulIndices = uint4(_110[_133].SimulIndices.x, _157.x, _110[_133].SimulIndices.z, _157.y);
        uint2 _161 = _154 & uint2(65535u);
        _110[_133].SimulIndices = uint4(_161.x, _110[_133].SimulIndices.y, _161.y, _110[_133].SimulIndices.w);
        _110[_133].Weight = as_type<float>(_153.z);
        _133++;
        continue;
    }
    float3 _302;
    if (_110[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _112;
        _112 = _110;
        float3 _177;
        float _180;
        int _182;
        _177 = float3(0.0);
        _180 = 0.0;
        _182 = 0;
        float3 _178;
        float _181;
        int _183;
        for (int _184 = 0; _184 < 5; _177 = _178, _180 = _181, _182 = _183, _184++)
        {
            if (_112[_184].SimulIndices.w < 65535u)
            {
                int _201 = int(_112[_184].SimulIndices.x) * 3;
                uint _206 = uint(_201 + 1);
                int _218 = int(_112[_184].SimulIndices.y) * 3;
                uint _222 = uint(_218 + 1);
                int _232 = int(_112[_184].SimulIndices.z) * 3;
                uint _236 = uint(_232 + 1);
                _178 = _177 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_201))).xy, ClothSimulVertsPositionsNormals.read(uint(_206)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_206)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_201 + 2))).xy, 0.0)).xyz * _112[_184].BaryCoordPos.w)) * _112[_184].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_218))).xy, ClothSimulVertsPositionsNormals.read(uint(_222)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_222)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_218 + 2))).xy, 0.0)).xyz * _112[_184].BaryCoordPos.w)) * _112[_184].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_232))).xy, ClothSimulVertsPositionsNormals.read(uint(_236)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_236)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_232 + 2))).xy, 0.0)).xyz * _112[_184].BaryCoordPos.w)) * ((1.0 - _112[_184].BaryCoordPos.x) - _112[_184].BaryCoordPos.y))) * _112[_184].Weight);
                _181 = _180 + _112[_184].Weight;
                _183 = _182 + 1;
            }
            else
            {
                _178 = _177;
                _181 = _180;
                _183 = _182;
            }
        }
        float3 _301;
        if ((_182 > 0) && (_180 > 9.9999997473787516355514526367188e-05))
        {
            _301 = _177 * (1.0 / _180);
        }
        else
        {
            _301 = float3(0.0);
        }
        _302 = _301;
    }
    else
    {
        _302 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _304 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _307 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _313 = int(_307 + (_Globals.InputWeightIndexSize * uint(_304)));
    float3x4 _315;
    _315 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _316;
    for (int _318 = 0; _318 < _304; _315 = _316, _318++)
    {
        int _326 = int(_307 + (_Globals.InputWeightIndexSize * uint(_318)));
        int _331 = int(InputWeightStream.read(uint(uint(_326))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _377 = float4(float(InputWeightStream.read(uint(uint(_313 + _318))).x) * 0.0039215688593685626983642578125);
            int _378 = int((InputWeightStream.read(uint(uint(_326 + 1))).x << 8u) | uint(_331)) * 3;
            _316 = float3x4(_315[0] + (_377 * BoneMatrices.read(uint(uint(_378)))), _315[1] + (_377 * BoneMatrices.read(uint(uint(_378 + 1)))), _315[2] + (_377 * BoneMatrices.read(uint(uint(_378 + 2)))));
        }
        else
        {
            float4 _342 = float4(float(InputWeightStream.read(uint(uint(_313 + _318))).x) * 0.0039215688593685626983642578125);
            int _343 = _331 * 3;
            _316 = float3x4(_315[0] + (_342 * BoneMatrices.read(uint(uint(_343)))), _315[1] + (_342 * BoneMatrices.read(uint(uint(_343 + 1)))), _315[2] + (_342 * BoneMatrices.read(uint(uint(_343 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _109;
    _109 = _110;
    float _580;
    float3x3 _581;
    if (_109[0].SimulIndices.w < 65535u)
    {
        float _409;
        float3 _412;
        float3 _414;
        float _416;
        int _418;
        _409 = _Globals.ClothBlendWeight;
        _412 = float3(0.0);
        _414 = float3(0.0);
        _416 = 0.0;
        _418 = 0;
        float _410;
        float3 _413;
        float3 _415;
        float _417;
        int _419;
        for (int _420 = 0; _420 < 5; _409 = _410, _412 = _413, _414 = _415, _416 = _417, _418 = _419, _420++)
        {
            bool _432 = _109[_420].SimulIndices.w < 65535u;
            if (_432)
            {
                int _438 = int(_109[_420].SimulIndices.x) * 3;
                uint _443 = uint(_438 + 1);
                float3 _452 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_438))).xy, ClothSimulVertsPositionsNormals.read(uint(_443)).x, 1.0)).xyz;
                int _455 = int(_109[_420].SimulIndices.y) * 3;
                uint _459 = uint(_455 + 1);
                float3 _466 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_455))).xy, ClothSimulVertsPositionsNormals.read(uint(_459)).x, 1.0)).xyz;
                int _469 = int(_109[_420].SimulIndices.z) * 3;
                uint _473 = uint(_469 + 1);
                float3 _480 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_469))).xy, ClothSimulVertsPositionsNormals.read(uint(_473)).x, 1.0)).xyz;
                float3 _490 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_443)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_438 + 2))).xy, 0.0)).xyz;
                float3 _500 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_459)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_455 + 2))).xy, 0.0)).xyz;
                float3 _510 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_473)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_469 + 2))).xy, 0.0)).xyz;
                _413 = _412 + (((((_452 + (_490 * _109[_420].BaryCoordNormal.w)) * _109[_420].BaryCoordNormal.x) + ((_466 + (_500 * _109[_420].BaryCoordNormal.w)) * _109[_420].BaryCoordNormal.y)) + ((_480 + (_510 * _109[_420].BaryCoordNormal.w)) * _109[_420].BaryCoordNormal.z)) * _109[_420].Weight);
                _415 = _414 + (((((_452 + (_490 * _109[_420].BaryCoordTangent.w)) * _109[_420].BaryCoordTangent.x) + ((_466 + (_500 * _109[_420].BaryCoordTangent.w)) * _109[_420].BaryCoordTangent.y)) + ((_480 + (_510 * _109[_420].BaryCoordTangent.w)) * _109[_420].BaryCoordTangent.z)) * _109[_420].Weight);
                _417 = _416 + _109[_420].Weight;
                _419 = _418 + 1;
            }
            else
            {
                _413 = _412;
                _415 = _414;
                _417 = _416;
                _419 = _418;
            }
            _410 = _432 ? _Globals.ClothBlendWeight : _409;
        }
        bool _548 = (_418 > 0) && (_416 > 9.9999997473787516355514526367188e-05);
        float3x3 _572;
        if (_548)
        {
            float _552 = 1.0 / _416;
            float3x3 _567 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _569 = _105;
            _569[0] = _567 * normalize((_414 * _552) - _302);
            float3x3 _571 = _569;
            _571[2] = _567 * normalize((_412 * _552) - _302);
            _572 = _571;
        }
        else
        {
            _572 = _105;
        }
        float3x3 _579 = _572;
        _579[1] = cross(_572[2], _572[0]) * in.in_var_ATTRIBUTE2.w;
        _580 = _548 ? _409 : 0.0;
        _581 = _579;
    }
    else
    {
        _580 = 0.0;
        _581 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _587 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _315);
    float3 _593 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _315);
    float3 _598 = float3(_580);
    float3 _606 = float3(1.0 - _580);
    float4 _681;
    switch (0u)
    {
        default:
        {
            if (_110[0].SimulIndices.w < 65535u)
            {
                _681 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _315) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _302, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _630 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _315) + in.in_var_ATTRIBUTE12;
                _681 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _630.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _630.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _630.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _108;
    _108 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _111 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _683 = 0; _683 < 1; )
    {
        _111[_683] = _108[_683];
        _683++;
        continue;
    }
    float4 _693 = View.View_TranslatedWorldToClip * float4(_681.x, _681.y, _681.z, _681.w);
    float4 _696 = _106;
    _696.w = 0.0;
    float3x3 _710 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _710[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _713 = _710;
    _713[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _716 = _713;
    _716[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _717 = _716 * float3x3((_581[0] * _598) + (_587 * _606), (_581[1] * _598) + (normalize(cross(_593, _587) * in.in_var_ATTRIBUTE2.w) * _606), (_581[2] * _598) + (_593 * _606));
    float3 _718 = _717[0];
    spvUnsafeArray<float4, 1> _728 = { float4(_111[0].x, _111[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_718.x, _718.y, _718.z, _696.w);
    out.out_var_TEXCOORD11_centroid = float4(_717[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _728;
    out.out_var_TEXCOORD6 = float4(_681.x, _681.y, _681.z, _681.w);
    out.gl_Position = _693;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

