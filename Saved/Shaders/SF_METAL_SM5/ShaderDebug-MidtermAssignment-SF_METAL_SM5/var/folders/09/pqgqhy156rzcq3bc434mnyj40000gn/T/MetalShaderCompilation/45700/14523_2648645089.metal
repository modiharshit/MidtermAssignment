

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

constant float3x3 _91 = {};
constant float4 _92 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
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

vertex Main_out Main_000038bb_9ddf1de1(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _95;
    for (int _116 = 0; _116 < 1; )
    {
        uint _123 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_116)) * 4u;
        _95[_116].BaryCoordPos = GPUSkinApexCloth.read(uint(_123));
        _95[_116].BaryCoordNormal = GPUSkinApexCloth.read(uint((_123 + 1u)));
        _95[_116].BaryCoordTangent = GPUSkinApexCloth.read(uint((_123 + 2u)));
        uint4 _135 = as_type<uint4>(GPUSkinApexCloth.read(uint((_123 + 3u))));
        uint2 _136 = _135.xy;
        uint2 _139 = (_136 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _95[_116].SimulIndices = uint4(_95[_116].SimulIndices.x, _139.x, _95[_116].SimulIndices.z, _139.y);
        uint2 _143 = _136 & uint2(65535u);
        _95[_116].SimulIndices = uint4(_143.x, _95[_116].SimulIndices.y, _143.y, _95[_116].SimulIndices.w);
        _95[_116].Weight = as_type<float>(_135.z);
        _116++;
        continue;
    }
    float3 _282;
    if (_95[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _96;
        _96 = _95;
        float3 _159;
        float _162;
        int _164;
        _159 = float3(0.0);
        _162 = 0.0;
        _164 = 0;
        float _163;
        float3 _160;
        int _165;
        for (int _166 = 0; _166 < 1; _159 = _160, _162 = _163, _164 = _165, _166++)
        {
            bool _176 = _96[_166].SimulIndices.w < 65535u;
            if (_176)
            {
                int _182 = int(_96[_166].SimulIndices.x) * 3;
                uint _187 = uint(_182 + 1);
                int _199 = int(_96[_166].SimulIndices.y) * 3;
                uint _203 = uint(_199 + 1);
                int _213 = int(_96[_166].SimulIndices.z) * 3;
                uint _217 = uint(_213 + 1);
                _160 = _159 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_182))).xy, ClothSimulVertsPositionsNormals.read(uint(_187)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_187)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_182 + 2))).xy, 0.0)).xyz * _96[_166].BaryCoordPos.w)) * _96[_166].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_199))).xy, ClothSimulVertsPositionsNormals.read(uint(_203)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_203)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_199 + 2))).xy, 0.0)).xyz * _96[_166].BaryCoordPos.w)) * _96[_166].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _96[_166].BaryCoordPos.w)) * ((1.0 - _96[_166].BaryCoordPos.x) - _96[_166].BaryCoordPos.y))) * 1.0);
                _165 = _164 + 1;
            }
            else
            {
                _160 = _159;
                _165 = _164;
            }
            _163 = _176 ? 1.0 : _162;
        }
        float3 _281;
        if ((_164 > 0) && (_162 > 9.9999997473787516355514526367188e-05))
        {
            _281 = _159 * (1.0 / _162);
        }
        else
        {
            _281 = float3(0.0);
        }
        _282 = _281;
    }
    else
    {
        _282 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _284 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _287 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _293 = int(_287 + (_Globals.InputWeightIndexSize * uint(_284)));
    float3x4 _295;
    _295 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _296;
    for (int _298 = 0; _298 < _284; _295 = _296, _298++)
    {
        int _306 = int(_287 + (_Globals.InputWeightIndexSize * uint(_298)));
        int _311 = int(InputWeightStream.read(uint(uint(_306))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _357 = float4(float(InputWeightStream.read(uint(uint(_293 + _298))).x) * 0.0039215688593685626983642578125);
            int _358 = int((InputWeightStream.read(uint(uint(_306 + 1))).x << 8u) | uint(_311)) * 3;
            _296 = float3x4(_295[0] + (_357 * BoneMatrices.read(uint(uint(_358)))), _295[1] + (_357 * BoneMatrices.read(uint(uint(_358 + 1)))), _295[2] + (_357 * BoneMatrices.read(uint(uint(_358 + 2)))));
        }
        else
        {
            float4 _322 = float4(float(InputWeightStream.read(uint(uint(_293 + _298))).x) * 0.0039215688593685626983642578125);
            int _323 = _311 * 3;
            _296 = float3x4(_295[0] + (_322 * BoneMatrices.read(uint(uint(_323)))), _295[1] + (_322 * BoneMatrices.read(uint(uint(_323 + 1)))), _295[2] + (_322 * BoneMatrices.read(uint(uint(_323 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _94;
    _94 = _95;
    float _558;
    float3x3 _559;
    if (_94[0].SimulIndices.w < 65535u)
    {
        float _389;
        float3 _392;
        float3 _394;
        float _396;
        int _398;
        _389 = _Globals.ClothBlendWeight;
        _392 = float3(0.0);
        _394 = float3(0.0);
        _396 = 0.0;
        _398 = 0;
        float _390;
        float _397;
        float3 _393;
        float3 _395;
        int _399;
        for (int _400 = 0; _400 < 1; _389 = _390, _392 = _393, _394 = _395, _396 = _397, _398 = _399, _400++)
        {
            bool _411 = _94[_400].SimulIndices.w < 65535u;
            if (_411)
            {
                int _417 = int(_94[_400].SimulIndices.x) * 3;
                uint _422 = uint(_417 + 1);
                float3 _431 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_417))).xy, ClothSimulVertsPositionsNormals.read(uint(_422)).x, 1.0)).xyz;
                int _434 = int(_94[_400].SimulIndices.y) * 3;
                uint _438 = uint(_434 + 1);
                float3 _445 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_434))).xy, ClothSimulVertsPositionsNormals.read(uint(_438)).x, 1.0)).xyz;
                int _448 = int(_94[_400].SimulIndices.z) * 3;
                uint _452 = uint(_448 + 1);
                float3 _459 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_448))).xy, ClothSimulVertsPositionsNormals.read(uint(_452)).x, 1.0)).xyz;
                float3 _469 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_422)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_417 + 2))).xy, 0.0)).xyz;
                float3 _479 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_438)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_434 + 2))).xy, 0.0)).xyz;
                float3 _489 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_452)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_448 + 2))).xy, 0.0)).xyz;
                _393 = _392 + (((((_431 + (_469 * _94[_400].BaryCoordNormal.w)) * _94[_400].BaryCoordNormal.x) + ((_445 + (_479 * _94[_400].BaryCoordNormal.w)) * _94[_400].BaryCoordNormal.y)) + ((_459 + (_489 * _94[_400].BaryCoordNormal.w)) * _94[_400].BaryCoordNormal.z)) * 1.0);
                _395 = _394 + (((((_431 + (_469 * _94[_400].BaryCoordTangent.w)) * _94[_400].BaryCoordTangent.x) + ((_445 + (_479 * _94[_400].BaryCoordTangent.w)) * _94[_400].BaryCoordTangent.y)) + ((_459 + (_489 * _94[_400].BaryCoordTangent.w)) * _94[_400].BaryCoordTangent.z)) * 1.0);
                _399 = _398 + 1;
            }
            else
            {
                _393 = _392;
                _395 = _394;
                _399 = _398;
            }
            _390 = _411 ? _Globals.ClothBlendWeight : _389;
            _397 = _411 ? 1.0 : _396;
        }
        bool _526 = (_398 > 0) && (_396 > 9.9999997473787516355514526367188e-05);
        float3x3 _550;
        if (_526)
        {
            float _530 = 1.0 / _396;
            float3x3 _545 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _547 = _91;
            _547[0] = _545 * normalize((_394 * _530) - _282);
            float3x3 _549 = _547;
            _549[2] = _545 * normalize((_392 * _530) - _282);
            _550 = _549;
        }
        else
        {
            _550 = _91;
        }
        float3x3 _557 = _550;
        _557[1] = cross(_550[2], _550[0]) * in.in_var_ATTRIBUTE2.w;
        _558 = _526 ? _389 : 0.0;
        _559 = _557;
    }
    else
    {
        _558 = 0.0;
        _559 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _565 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _295);
    float3 _571 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _295);
    float3 _576 = float3(_558);
    float3 _584 = float3(1.0 - _558);
    float4 _659;
    switch (0u)
    {
        default:
        {
            if (_95[0].SimulIndices.w < 65535u)
            {
                _659 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _295) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _282, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _608 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _295) + in.in_var_ATTRIBUTE12;
                _659 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _608.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _608.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _608.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _661 = View.View_TranslatedWorldToClip * float4(_659.x, _659.y, _659.z, _659.w);
    float4 _662 = _92;
    _662.w = 0.0;
    float3x3 _676 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _676[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _679 = _676;
    _679[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _682 = _679;
    _682[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _683 = _682 * float3x3((_559[0] * _576) + (_565 * _584), (_559[1] * _576) + (normalize(cross(_571, _565) * in.in_var_ATTRIBUTE2.w) * _584), (_559[2] * _576) + (_571 * _584));
    float3 _684 = _683[0];
    out.out_var_TEXCOORD10_centroid = float4(_684.x, _684.y, _684.z, _662.w);
    out.out_var_TEXCOORD11_centroid = float4(_683[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _661;
    return out;
}

