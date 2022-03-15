

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

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
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

vertex Main_out Main_00003cdc_91cc527e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _110;
    for (int _131 = 0; _131 < 5; )
    {
        uint _139 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_131)) * 4u;
        _110[_131].BaryCoordPos = GPUSkinApexCloth.read(uint(_139));
        _110[_131].BaryCoordNormal = GPUSkinApexCloth.read(uint((_139 + 1u)));
        _110[_131].BaryCoordTangent = GPUSkinApexCloth.read(uint((_139 + 2u)));
        uint4 _151 = as_type<uint4>(GPUSkinApexCloth.read(uint((_139 + 3u))));
        uint2 _152 = _151.xy;
        uint2 _155 = (_152 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _110[_131].SimulIndices = uint4(_110[_131].SimulIndices.x, _155.x, _110[_131].SimulIndices.z, _155.y);
        uint2 _159 = _152 & uint2(65535u);
        _110[_131].SimulIndices = uint4(_159.x, _110[_131].SimulIndices.y, _159.y, _110[_131].SimulIndices.w);
        _110[_131].Weight = as_type<float>(_151.z);
        _131++;
        continue;
    }
    float3 _300;
    if (_110[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _112;
        _112 = _110;
        float3 _175;
        float _178;
        int _180;
        _175 = float3(0.0);
        _178 = 0.0;
        _180 = 0;
        float3 _176;
        float _179;
        int _181;
        for (int _182 = 0; _182 < 5; _175 = _176, _178 = _179, _180 = _181, _182++)
        {
            if (_112[_182].SimulIndices.w < 65535u)
            {
                int _199 = int(_112[_182].SimulIndices.x) * 3;
                uint _204 = uint(_199 + 1);
                int _216 = int(_112[_182].SimulIndices.y) * 3;
                uint _220 = uint(_216 + 1);
                int _230 = int(_112[_182].SimulIndices.z) * 3;
                uint _234 = uint(_230 + 1);
                _176 = _175 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_199))).xy, ClothSimulVertsPositionsNormals.read(uint(_204)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_204)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_199 + 2))).xy, 0.0)).xyz * _112[_182].BaryCoordPos.w)) * _112[_182].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_216))).xy, ClothSimulVertsPositionsNormals.read(uint(_220)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_220)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_216 + 2))).xy, 0.0)).xyz * _112[_182].BaryCoordPos.w)) * _112[_182].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_230))).xy, ClothSimulVertsPositionsNormals.read(uint(_234)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_234)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_230 + 2))).xy, 0.0)).xyz * _112[_182].BaryCoordPos.w)) * ((1.0 - _112[_182].BaryCoordPos.x) - _112[_182].BaryCoordPos.y))) * _112[_182].Weight);
                _179 = _178 + _112[_182].Weight;
                _181 = _180 + 1;
            }
            else
            {
                _176 = _175;
                _179 = _178;
                _181 = _180;
            }
        }
        float3 _299;
        if ((_180 > 0) && (_178 > 9.9999997473787516355514526367188e-05))
        {
            _299 = _175 * (1.0 / _178);
        }
        else
        {
            _299 = float3(0.0);
        }
        _300 = _299;
    }
    else
    {
        _300 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _302 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _305 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _311 = int(_305 + (_Globals.InputWeightIndexSize * uint(_302)));
    float3x4 _313;
    _313 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _314;
    for (int _316 = 0; _316 < _302; _313 = _314, _316++)
    {
        int _324 = int(_305 + (_Globals.InputWeightIndexSize * uint(_316)));
        int _329 = int(InputWeightStream.read(uint(uint(_324))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _375 = float4(float(InputWeightStream.read(uint(uint(_311 + _316))).x) * 0.0039215688593685626983642578125);
            int _376 = int((InputWeightStream.read(uint(uint(_324 + 1))).x << 8u) | uint(_329)) * 3;
            _314 = float3x4(_313[0] + (_375 * BoneMatrices.read(uint(uint(_376)))), _313[1] + (_375 * BoneMatrices.read(uint(uint(_376 + 1)))), _313[2] + (_375 * BoneMatrices.read(uint(uint(_376 + 2)))));
        }
        else
        {
            float4 _340 = float4(float(InputWeightStream.read(uint(uint(_311 + _316))).x) * 0.0039215688593685626983642578125);
            int _341 = _329 * 3;
            _314 = float3x4(_313[0] + (_340 * BoneMatrices.read(uint(uint(_341)))), _313[1] + (_340 * BoneMatrices.read(uint(uint(_341 + 1)))), _313[2] + (_340 * BoneMatrices.read(uint(uint(_341 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _109;
    _109 = _110;
    float _578;
    float3x3 _579;
    if (_109[0].SimulIndices.w < 65535u)
    {
        float _407;
        float3 _410;
        float3 _412;
        float _414;
        int _416;
        _407 = _Globals.ClothBlendWeight;
        _410 = float3(0.0);
        _412 = float3(0.0);
        _414 = 0.0;
        _416 = 0;
        float _408;
        float3 _411;
        float3 _413;
        float _415;
        int _417;
        for (int _418 = 0; _418 < 5; _407 = _408, _410 = _411, _412 = _413, _414 = _415, _416 = _417, _418++)
        {
            bool _430 = _109[_418].SimulIndices.w < 65535u;
            if (_430)
            {
                int _436 = int(_109[_418].SimulIndices.x) * 3;
                uint _441 = uint(_436 + 1);
                float3 _450 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_436))).xy, ClothSimulVertsPositionsNormals.read(uint(_441)).x, 1.0)).xyz;
                int _453 = int(_109[_418].SimulIndices.y) * 3;
                uint _457 = uint(_453 + 1);
                float3 _464 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_453))).xy, ClothSimulVertsPositionsNormals.read(uint(_457)).x, 1.0)).xyz;
                int _467 = int(_109[_418].SimulIndices.z) * 3;
                uint _471 = uint(_467 + 1);
                float3 _478 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_467))).xy, ClothSimulVertsPositionsNormals.read(uint(_471)).x, 1.0)).xyz;
                float3 _488 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_441)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_436 + 2))).xy, 0.0)).xyz;
                float3 _498 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_457)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_453 + 2))).xy, 0.0)).xyz;
                float3 _508 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_471)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_467 + 2))).xy, 0.0)).xyz;
                _411 = _410 + (((((_450 + (_488 * _109[_418].BaryCoordNormal.w)) * _109[_418].BaryCoordNormal.x) + ((_464 + (_498 * _109[_418].BaryCoordNormal.w)) * _109[_418].BaryCoordNormal.y)) + ((_478 + (_508 * _109[_418].BaryCoordNormal.w)) * _109[_418].BaryCoordNormal.z)) * _109[_418].Weight);
                _413 = _412 + (((((_450 + (_488 * _109[_418].BaryCoordTangent.w)) * _109[_418].BaryCoordTangent.x) + ((_464 + (_498 * _109[_418].BaryCoordTangent.w)) * _109[_418].BaryCoordTangent.y)) + ((_478 + (_508 * _109[_418].BaryCoordTangent.w)) * _109[_418].BaryCoordTangent.z)) * _109[_418].Weight);
                _415 = _414 + _109[_418].Weight;
                _417 = _416 + 1;
            }
            else
            {
                _411 = _410;
                _413 = _412;
                _415 = _414;
                _417 = _416;
            }
            _408 = _430 ? _Globals.ClothBlendWeight : _407;
        }
        bool _546 = (_416 > 0) && (_414 > 9.9999997473787516355514526367188e-05);
        float3x3 _570;
        if (_546)
        {
            float _550 = 1.0 / _414;
            float3x3 _565 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _567 = _105;
            _567[0] = _565 * normalize((_412 * _550) - _300);
            float3x3 _569 = _567;
            _569[2] = _565 * normalize((_410 * _550) - _300);
            _570 = _569;
        }
        else
        {
            _570 = _105;
        }
        float3x3 _577 = _570;
        _577[1] = cross(_570[2], _570[0]) * in.in_var_ATTRIBUTE2.w;
        _578 = _546 ? _407 : 0.0;
        _579 = _577;
    }
    else
    {
        _578 = 0.0;
        _579 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _585 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _313);
    float3 _591 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _313);
    float3 _596 = float3(_578);
    float3 _604 = float3(1.0 - _578);
    float4 _679;
    switch (0u)
    {
        default:
        {
            if (_110[0].SimulIndices.w < 65535u)
            {
                _679 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _313) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _300, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _628 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _313) + in.in_var_ATTRIBUTE12;
                _679 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _628.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _628.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _628.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _108;
    _108 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _111 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _681 = 0; _681 < 1; )
    {
        _111[_681] = _108[_681];
        _681++;
        continue;
    }
    float4 _693 = View.View_TranslatedWorldToClip * float4(_679.x, _679.y, _679.z, _679.w);
    float4 _696 = _106;
    _696.w = 0.0;
    float3x3 _710 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _710[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _713 = _710;
    _713[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _716 = _713;
    _716[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _717 = _716 * float3x3((_579[0] * _596) + (_585 * _604), (_579[1] * _596) + (normalize(cross(_591, _585) * in.in_var_ATTRIBUTE2.w) * _604), (_579[2] * _596) + (_591 * _604));
    float3 _718 = _717[0];
    spvUnsafeArray<float4, 1> _728 = { float4(_111[0].x, _111[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_718.x, _718.y, _718.z, _696.w);
    out.out_var_TEXCOORD11_centroid = float4(_717[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _728;
    out.out_var_TEXCOORD6 = float4(_679.x, _679.y, _679.z, _679.w);
    out.gl_Position = _693;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

