

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
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    char _m2_pad[64];
    float ClothBlendWeight;
    packed_uint2 GPUSkinApexClothStartIndexOffset;
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

constant float3x3 _101 = {};
constant float4 _102 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00004150_3f6c553a(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _106;
    for (int _132 = 0; _132 < 5; )
    {
        uint _140 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_132)) * 4u;
        _106[_132].BaryCoordPos = GPUSkinApexCloth.read(uint(_140));
        _106[_132].BaryCoordNormal = GPUSkinApexCloth.read(uint((_140 + 1u)));
        _106[_132].BaryCoordTangent = GPUSkinApexCloth.read(uint((_140 + 2u)));
        uint4 _152 = as_type<uint4>(GPUSkinApexCloth.read(uint((_140 + 3u))));
        uint2 _153 = _152.xy;
        uint2 _156 = (_153 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _106[_132].SimulIndices = uint4(_106[_132].SimulIndices.x, _156.x, _106[_132].SimulIndices.z, _156.y);
        uint2 _160 = _153 & uint2(65535u);
        _106[_132].SimulIndices = uint4(_160.x, _106[_132].SimulIndices.y, _160.y, _106[_132].SimulIndices.w);
        _106[_132].Weight = as_type<float>(_152.z);
        _132++;
        continue;
    }
    float3 _301;
    if (_106[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _108;
        _108 = _106;
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
            if (_108[_183].SimulIndices.w < 65535u)
            {
                int _200 = int(_108[_183].SimulIndices.x) * 3;
                uint _205 = uint(_200 + 1);
                int _217 = int(_108[_183].SimulIndices.y) * 3;
                uint _221 = uint(_217 + 1);
                int _231 = int(_108[_183].SimulIndices.z) * 3;
                uint _235 = uint(_231 + 1);
                _177 = _176 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_200))).xy, ClothSimulVertsPositionsNormals.read(uint(_205)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_205)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_200 + 2))).xy, 0.0)).xyz * _108[_183].BaryCoordPos.w)) * _108[_183].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_217))).xy, ClothSimulVertsPositionsNormals.read(uint(_221)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_221)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_217 + 2))).xy, 0.0)).xyz * _108[_183].BaryCoordPos.w)) * _108[_183].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_231))).xy, ClothSimulVertsPositionsNormals.read(uint(_235)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_235)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_231 + 2))).xy, 0.0)).xyz * _108[_183].BaryCoordPos.w)) * ((1.0 - _108[_183].BaryCoordPos.x) - _108[_183].BaryCoordPos.y))) * _108[_183].Weight);
                _180 = _179 + _108[_183].Weight;
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
    float4 _303 = float4(in.in_var_ATTRIBUTE4.x);
    int _306 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _320 = float4(in.in_var_ATTRIBUTE4.y);
    int _323 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _339 = float4(in.in_var_ATTRIBUTE4.z);
    int _342 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _358 = float4(in.in_var_ATTRIBUTE4.w);
    int _361 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _373 = (((_303 * BoneMatrices.read(uint(uint(_306)))) + (_320 * BoneMatrices.read(uint(uint(_323))))) + (_339 * BoneMatrices.read(uint(uint(_342))))) + (_358 * BoneMatrices.read(uint(uint(_361))));
    float4 _374 = (((_303 * BoneMatrices.read(uint(uint(_306 + 1)))) + (_320 * BoneMatrices.read(uint(uint(_323 + 1))))) + (_339 * BoneMatrices.read(uint(uint(_342 + 1))))) + (_358 * BoneMatrices.read(uint(uint(_361 + 1))));
    float4 _375 = (((_303 * BoneMatrices.read(uint(uint(_306 + 2)))) + (_320 * BoneMatrices.read(uint(uint(_323 + 2))))) + (_339 * BoneMatrices.read(uint(uint(_342 + 2))))) + (_358 * BoneMatrices.read(uint(uint(_361 + 2))));
    float3x4 _459;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _383 = float4(in.in_var_ATTRIBUTE15.x);
        int _386 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _402 = float4(in.in_var_ATTRIBUTE15.y);
        int _405 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _421 = float4(in.in_var_ATTRIBUTE15.z);
        int _424 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _440 = float4(in.in_var_ATTRIBUTE15.w);
        int _443 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _459 = float3x4((((_373 + (_383 * BoneMatrices.read(uint(uint(_386))))) + (_402 * BoneMatrices.read(uint(uint(_405))))) + (_421 * BoneMatrices.read(uint(uint(_424))))) + (_440 * BoneMatrices.read(uint(uint(_443)))), (((_374 + (_383 * BoneMatrices.read(uint(uint(_386 + 1))))) + (_402 * BoneMatrices.read(uint(uint(_405 + 1))))) + (_421 * BoneMatrices.read(uint(uint(_424 + 1))))) + (_440 * BoneMatrices.read(uint(uint(_443 + 1)))), (((_375 + (_383 * BoneMatrices.read(uint(uint(_386 + 2))))) + (_402 * BoneMatrices.read(uint(uint(_405 + 2))))) + (_421 * BoneMatrices.read(uint(uint(_424 + 2))))) + (_440 * BoneMatrices.read(uint(uint(_443 + 2)))));
    }
    else
    {
        _459 = float3x4(_373, _374, _375);
    }
    spvUnsafeArray<FClothVertex, 5> _105;
    _105 = _106;
    float _642;
    float3x3 _643;
    if (_105[0].SimulIndices.w < 65535u)
    {
        float _471;
        float3 _474;
        float3 _476;
        float _478;
        int _480;
        _471 = _Globals.ClothBlendWeight;
        _474 = float3(0.0);
        _476 = float3(0.0);
        _478 = 0.0;
        _480 = 0;
        float _472;
        float3 _475;
        float3 _477;
        float _479;
        int _481;
        for (int _482 = 0; _482 < 5; _471 = _472, _474 = _475, _476 = _477, _478 = _479, _480 = _481, _482++)
        {
            bool _494 = _105[_482].SimulIndices.w < 65535u;
            if (_494)
            {
                int _500 = int(_105[_482].SimulIndices.x) * 3;
                uint _505 = uint(_500 + 1);
                float3 _514 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_500))).xy, ClothSimulVertsPositionsNormals.read(uint(_505)).x, 1.0)).xyz;
                int _517 = int(_105[_482].SimulIndices.y) * 3;
                uint _521 = uint(_517 + 1);
                float3 _528 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_517))).xy, ClothSimulVertsPositionsNormals.read(uint(_521)).x, 1.0)).xyz;
                int _531 = int(_105[_482].SimulIndices.z) * 3;
                uint _535 = uint(_531 + 1);
                float3 _542 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_531))).xy, ClothSimulVertsPositionsNormals.read(uint(_535)).x, 1.0)).xyz;
                float3 _552 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_505)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_500 + 2))).xy, 0.0)).xyz;
                float3 _562 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_521)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_517 + 2))).xy, 0.0)).xyz;
                float3 _572 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_535)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_531 + 2))).xy, 0.0)).xyz;
                _475 = _474 + (((((_514 + (_552 * _105[_482].BaryCoordNormal.w)) * _105[_482].BaryCoordNormal.x) + ((_528 + (_562 * _105[_482].BaryCoordNormal.w)) * _105[_482].BaryCoordNormal.y)) + ((_542 + (_572 * _105[_482].BaryCoordNormal.w)) * _105[_482].BaryCoordNormal.z)) * _105[_482].Weight);
                _477 = _476 + (((((_514 + (_552 * _105[_482].BaryCoordTangent.w)) * _105[_482].BaryCoordTangent.x) + ((_528 + (_562 * _105[_482].BaryCoordTangent.w)) * _105[_482].BaryCoordTangent.y)) + ((_542 + (_572 * _105[_482].BaryCoordTangent.w)) * _105[_482].BaryCoordTangent.z)) * _105[_482].Weight);
                _479 = _478 + _105[_482].Weight;
                _481 = _480 + 1;
            }
            else
            {
                _475 = _474;
                _477 = _476;
                _479 = _478;
                _481 = _480;
            }
            _472 = _494 ? _Globals.ClothBlendWeight : _471;
        }
        bool _610 = (_480 > 0) && (_478 > 9.9999997473787516355514526367188e-05);
        float3x3 _634;
        if (_610)
        {
            float _614 = 1.0 / _478;
            float3x3 _629 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _631 = _101;
            _631[0] = _629 * normalize((_476 * _614) - _301);
            float3x3 _633 = _631;
            _633[2] = _629 * normalize((_474 * _614) - _301);
            _634 = _633;
        }
        else
        {
            _634 = _101;
        }
        float3x3 _641 = _634;
        _641[1] = cross(_634[2], _634[0]) * in.in_var_ATTRIBUTE2.w;
        _642 = _610 ? _471 : 0.0;
        _643 = _641;
    }
    else
    {
        _642 = 0.0;
        _643 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _649 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _459);
    float3 _655 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _459);
    float3 _660 = float3(_642);
    float3 _668 = float3(1.0 - _642);
    float4 _743;
    switch (0u)
    {
        default:
        {
            if (_106[0].SimulIndices.w < 65535u)
            {
                _743 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _459) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _301, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _692 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _459) + in.in_var_ATTRIBUTE12;
                _743 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _692.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _692.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _692.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _104;
    _104 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _107 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _745 = 0; _745 < 1; )
    {
        _107[_745] = _104[_745];
        _745++;
        continue;
    }
    float4 _755 = View.View_TranslatedWorldToClip * float4(_743.x, _743.y, _743.z, _743.w);
    float4 _758 = _102;
    _758.w = 0.0;
    float3x3 _772 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _772[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _775 = _772;
    _775[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _778 = _775;
    _778[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _779 = _778 * float3x3((_643[0] * _660) + (_649 * _668), (_643[1] * _660) + (normalize(cross(_655, _649) * in.in_var_ATTRIBUTE2.w) * _668), (_643[2] * _660) + (_655 * _668));
    float3 _780 = _779[0];
    spvUnsafeArray<float4, 1> _790 = { float4(_107[0].x, _107[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_780.x, _780.y, _780.z, _758.w);
    out.out_var_TEXCOORD11_centroid = float4(_779[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _790;
    out.out_var_TEXCOORD6 = float4(_743.x, _743.y, _743.z, _743.w);
    out.gl_Position = _755;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

