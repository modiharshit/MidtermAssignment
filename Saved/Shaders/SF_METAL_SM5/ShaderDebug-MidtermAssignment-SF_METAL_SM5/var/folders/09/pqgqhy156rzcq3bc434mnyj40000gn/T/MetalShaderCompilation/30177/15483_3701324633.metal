

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

constant spvUnsafeArray<float2, 1> _96 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _104 = {};
constant float4 _105 = {};

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

vertex Main_out Main_00003c7b_dc9dbb59(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _109;
    for (int _132 = 0; _132 < 5; )
    {
        uint _140 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_132)) * 4u;
        _109[_132].BaryCoordPos = GPUSkinApexCloth.read(uint(_140));
        _109[_132].BaryCoordNormal = GPUSkinApexCloth.read(uint((_140 + 1u)));
        _109[_132].BaryCoordTangent = GPUSkinApexCloth.read(uint((_140 + 2u)));
        uint4 _152 = as_type<uint4>(GPUSkinApexCloth.read(uint((_140 + 3u))));
        uint2 _153 = _152.xy;
        uint2 _156 = (_153 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _109[_132].SimulIndices = uint4(_109[_132].SimulIndices.x, _156.x, _109[_132].SimulIndices.z, _156.y);
        uint2 _160 = _153 & uint2(65535u);
        _109[_132].SimulIndices = uint4(_160.x, _109[_132].SimulIndices.y, _160.y, _109[_132].SimulIndices.w);
        _109[_132].Weight = as_type<float>(_152.z);
        _132++;
        continue;
    }
    float3 _301;
    if (_109[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _111;
        _111 = _109;
        float3 _176;
        float _179;
        int _181;
        _176 = float3(0.0);
        _179 = 0.0;
        _181 = 0;
        float3 _177;
        float _180;
        int _182;
        for (int _183 = 0; _183 < 5; _176 = _177, _179 = _180, _181 = _182, _183++)
        {
            if (_111[_183].SimulIndices.w < 65535u)
            {
                int _200 = int(_111[_183].SimulIndices.x) * 3;
                uint _205 = uint(_200 + 1);
                int _217 = int(_111[_183].SimulIndices.y) * 3;
                uint _221 = uint(_217 + 1);
                int _231 = int(_111[_183].SimulIndices.z) * 3;
                uint _235 = uint(_231 + 1);
                _177 = _176 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_200))).xy, ClothSimulVertsPositionsNormals.read(uint(_205)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_205)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_200 + 2))).xy, 0.0)).xyz * _111[_183].BaryCoordPos.w)) * _111[_183].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_217))).xy, ClothSimulVertsPositionsNormals.read(uint(_221)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_221)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_217 + 2))).xy, 0.0)).xyz * _111[_183].BaryCoordPos.w)) * _111[_183].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_231))).xy, ClothSimulVertsPositionsNormals.read(uint(_235)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_235)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_231 + 2))).xy, 0.0)).xyz * _111[_183].BaryCoordPos.w)) * ((1.0 - _111[_183].BaryCoordPos.x) - _111[_183].BaryCoordPos.y))) * _111[_183].Weight);
                _180 = _179 + _111[_183].Weight;
                _182 = _181 + 1;
            }
            else
            {
                _177 = _176;
                _180 = _179;
                _182 = _181;
            }
        }
        float3 _300;
        if ((_181 > 0) && (_179 > 9.9999997473787516355514526367188e-05))
        {
            _300 = _176 * (1.0 / _179);
        }
        else
        {
            _300 = float3(0.0);
        }
        _301 = _300;
    }
    else
    {
        _301 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _303 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _306 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _312 = int(_306 + (_Globals.InputWeightIndexSize * uint(_303)));
    float3x4 _314;
    _314 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _315;
    for (int _317 = 0; _317 < _303; _314 = _315, _317++)
    {
        int _325 = int(_306 + (_Globals.InputWeightIndexSize * uint(_317)));
        int _330 = int(InputWeightStream.read(uint(uint(_325))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _376 = float4(float(InputWeightStream.read(uint(uint(_312 + _317))).x) * 0.0039215688593685626983642578125);
            int _377 = int((InputWeightStream.read(uint(uint(_325 + 1))).x << 8u) | uint(_330)) * 3;
            _315 = float3x4(_314[0] + (_376 * BoneMatrices.read(uint(uint(_377)))), _314[1] + (_376 * BoneMatrices.read(uint(uint(_377 + 1)))), _314[2] + (_376 * BoneMatrices.read(uint(uint(_377 + 2)))));
        }
        else
        {
            float4 _341 = float4(float(InputWeightStream.read(uint(uint(_312 + _317))).x) * 0.0039215688593685626983642578125);
            int _342 = _330 * 3;
            _315 = float3x4(_314[0] + (_341 * BoneMatrices.read(uint(uint(_342)))), _314[1] + (_341 * BoneMatrices.read(uint(uint(_342 + 1)))), _314[2] + (_341 * BoneMatrices.read(uint(uint(_342 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _108;
    _108 = _109;
    float _579;
    float3x3 _580;
    if (_108[0].SimulIndices.w < 65535u)
    {
        float _408;
        float3 _411;
        float3 _413;
        float _415;
        int _417;
        _408 = _Globals.ClothBlendWeight;
        _411 = float3(0.0);
        _413 = float3(0.0);
        _415 = 0.0;
        _417 = 0;
        float _409;
        float3 _412;
        float3 _414;
        float _416;
        int _418;
        for (int _419 = 0; _419 < 5; _408 = _409, _411 = _412, _413 = _414, _415 = _416, _417 = _418, _419++)
        {
            bool _431 = _108[_419].SimulIndices.w < 65535u;
            if (_431)
            {
                int _437 = int(_108[_419].SimulIndices.x) * 3;
                uint _442 = uint(_437 + 1);
                float3 _451 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_437))).xy, ClothSimulVertsPositionsNormals.read(uint(_442)).x, 1.0)).xyz;
                int _454 = int(_108[_419].SimulIndices.y) * 3;
                uint _458 = uint(_454 + 1);
                float3 _465 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_454))).xy, ClothSimulVertsPositionsNormals.read(uint(_458)).x, 1.0)).xyz;
                int _468 = int(_108[_419].SimulIndices.z) * 3;
                uint _472 = uint(_468 + 1);
                float3 _479 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_468))).xy, ClothSimulVertsPositionsNormals.read(uint(_472)).x, 1.0)).xyz;
                float3 _489 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_442)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_437 + 2))).xy, 0.0)).xyz;
                float3 _499 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_458)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_454 + 2))).xy, 0.0)).xyz;
                float3 _509 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_472)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_468 + 2))).xy, 0.0)).xyz;
                _412 = _411 + (((((_451 + (_489 * _108[_419].BaryCoordNormal.w)) * _108[_419].BaryCoordNormal.x) + ((_465 + (_499 * _108[_419].BaryCoordNormal.w)) * _108[_419].BaryCoordNormal.y)) + ((_479 + (_509 * _108[_419].BaryCoordNormal.w)) * _108[_419].BaryCoordNormal.z)) * _108[_419].Weight);
                _414 = _413 + (((((_451 + (_489 * _108[_419].BaryCoordTangent.w)) * _108[_419].BaryCoordTangent.x) + ((_465 + (_499 * _108[_419].BaryCoordTangent.w)) * _108[_419].BaryCoordTangent.y)) + ((_479 + (_509 * _108[_419].BaryCoordTangent.w)) * _108[_419].BaryCoordTangent.z)) * _108[_419].Weight);
                _416 = _415 + _108[_419].Weight;
                _418 = _417 + 1;
            }
            else
            {
                _412 = _411;
                _414 = _413;
                _416 = _415;
                _418 = _417;
            }
            _409 = _431 ? _Globals.ClothBlendWeight : _408;
        }
        bool _547 = (_417 > 0) && (_415 > 9.9999997473787516355514526367188e-05);
        float3x3 _571;
        if (_547)
        {
            float _551 = 1.0 / _415;
            float3x3 _566 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _568 = _104;
            _568[0] = _566 * normalize((_413 * _551) - _301);
            float3x3 _570 = _568;
            _570[2] = _566 * normalize((_411 * _551) - _301);
            _571 = _570;
        }
        else
        {
            _571 = _104;
        }
        float3x3 _578 = _571;
        _578[1] = cross(_571[2], _571[0]) * in.in_var_ATTRIBUTE2.w;
        _579 = _547 ? _408 : 0.0;
        _580 = _578;
    }
    else
    {
        _579 = 0.0;
        _580 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _586 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _314);
    float3 _592 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _314);
    float3 _597 = float3(_579);
    float3 _605 = float3(1.0 - _579);
    float4 _680;
    switch (0u)
    {
        default:
        {
            if (_109[0].SimulIndices.w < 65535u)
            {
                _680 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _314) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _301, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _629 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _314) + in.in_var_ATTRIBUTE12;
                _680 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _629.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _629.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _629.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _107;
    _107 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _110 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _682 = 0; _682 < 1; )
    {
        _110[_682] = _107[_682];
        _682++;
        continue;
    }
    float4 _692 = View.View_TranslatedWorldToClip * float4(_680.x, _680.y, _680.z, _680.w);
    float4 _695 = _105;
    _695.w = 0.0;
    float3x3 _709 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _709[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _712 = _709;
    _712[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _715 = _712;
    _715[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _716 = _715 * float3x3((_580[0] * _597) + (_586 * _605), (_580[1] * _597) + (normalize(cross(_592, _586) * in.in_var_ATTRIBUTE2.w) * _605), (_580[2] * _597) + (_592 * _605));
    float3 _717 = _716[0];
    spvUnsafeArray<float4, 1> _727 = { float4(_110[0].x, _110[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_717.x, _717.y, _717.z, _695.w);
    out.out_var_TEXCOORD11_centroid = float4(_716[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _727;
    out.gl_Position = _692;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

