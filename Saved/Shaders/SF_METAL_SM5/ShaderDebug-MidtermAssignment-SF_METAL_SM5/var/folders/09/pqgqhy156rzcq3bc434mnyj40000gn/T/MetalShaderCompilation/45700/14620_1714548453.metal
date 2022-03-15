

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

constant float3x3 _92 = {};
constant float4 _93 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
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

vertex Main_out Main_0000391c_6631eee5(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _96;
    for (int _115 = 0; _115 < 1; )
    {
        uint _122 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_115)) * 4u;
        _96[_115].BaryCoordPos = GPUSkinApexCloth.read(uint(_122));
        _96[_115].BaryCoordNormal = GPUSkinApexCloth.read(uint((_122 + 1u)));
        _96[_115].BaryCoordTangent = GPUSkinApexCloth.read(uint((_122 + 2u)));
        uint4 _134 = as_type<uint4>(GPUSkinApexCloth.read(uint((_122 + 3u))));
        uint2 _135 = _134.xy;
        uint2 _138 = (_135 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _96[_115].SimulIndices = uint4(_96[_115].SimulIndices.x, _138.x, _96[_115].SimulIndices.z, _138.y);
        uint2 _142 = _135 & uint2(65535u);
        _96[_115].SimulIndices = uint4(_142.x, _96[_115].SimulIndices.y, _142.y, _96[_115].SimulIndices.w);
        _96[_115].Weight = as_type<float>(_134.z);
        _115++;
        continue;
    }
    float3 _281;
    if (_96[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _97;
        _97 = _96;
        float3 _158;
        float _161;
        int _163;
        _158 = float3(0.0);
        _161 = 0.0;
        _163 = 0;
        float _162;
        float3 _159;
        int _164;
        for (int _165 = 0; _165 < 1; _158 = _159, _161 = _162, _163 = _164, _165++)
        {
            bool _175 = _97[_165].SimulIndices.w < 65535u;
            if (_175)
            {
                int _181 = int(_97[_165].SimulIndices.x) * 3;
                uint _186 = uint(_181 + 1);
                int _198 = int(_97[_165].SimulIndices.y) * 3;
                uint _202 = uint(_198 + 1);
                int _212 = int(_97[_165].SimulIndices.z) * 3;
                uint _216 = uint(_212 + 1);
                _159 = _158 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_181))).xy, ClothSimulVertsPositionsNormals.read(uint(_186)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_186)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_181 + 2))).xy, 0.0)).xyz * _97[_165].BaryCoordPos.w)) * _97[_165].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_198))).xy, ClothSimulVertsPositionsNormals.read(uint(_202)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_202)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_198 + 2))).xy, 0.0)).xyz * _97[_165].BaryCoordPos.w)) * _97[_165].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _97[_165].BaryCoordPos.w)) * ((1.0 - _97[_165].BaryCoordPos.x) - _97[_165].BaryCoordPos.y))) * 1.0);
                _164 = _163 + 1;
            }
            else
            {
                _159 = _158;
                _164 = _163;
            }
            _162 = _175 ? 1.0 : _161;
        }
        float3 _280;
        if ((_163 > 0) && (_161 > 9.9999997473787516355514526367188e-05))
        {
            _280 = _158 * (1.0 / _161);
        }
        else
        {
            _280 = float3(0.0);
        }
        _281 = _280;
    }
    else
    {
        _281 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _283 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _286 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _292 = int(_286 + (_Globals.InputWeightIndexSize * uint(_283)));
    float3x4 _294;
    _294 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _295;
    for (int _297 = 0; _297 < _283; _294 = _295, _297++)
    {
        int _305 = int(_286 + (_Globals.InputWeightIndexSize * uint(_297)));
        int _310 = int(InputWeightStream.read(uint(uint(_305))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _356 = float4(float(InputWeightStream.read(uint(uint(_292 + _297))).x) * 0.0039215688593685626983642578125);
            int _357 = int((InputWeightStream.read(uint(uint(_305 + 1))).x << 8u) | uint(_310)) * 3;
            _295 = float3x4(_294[0] + (_356 * BoneMatrices.read(uint(uint(_357)))), _294[1] + (_356 * BoneMatrices.read(uint(uint(_357 + 1)))), _294[2] + (_356 * BoneMatrices.read(uint(uint(_357 + 2)))));
        }
        else
        {
            float4 _321 = float4(float(InputWeightStream.read(uint(uint(_292 + _297))).x) * 0.0039215688593685626983642578125);
            int _322 = _310 * 3;
            _295 = float3x4(_294[0] + (_321 * BoneMatrices.read(uint(uint(_322)))), _294[1] + (_321 * BoneMatrices.read(uint(uint(_322 + 1)))), _294[2] + (_321 * BoneMatrices.read(uint(uint(_322 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _95;
    _95 = _96;
    float _557;
    float3x3 _558;
    if (_95[0].SimulIndices.w < 65535u)
    {
        float _388;
        float3 _391;
        float3 _393;
        float _395;
        int _397;
        _388 = _Globals.ClothBlendWeight;
        _391 = float3(0.0);
        _393 = float3(0.0);
        _395 = 0.0;
        _397 = 0;
        float _389;
        float _396;
        float3 _392;
        float3 _394;
        int _398;
        for (int _399 = 0; _399 < 1; _388 = _389, _391 = _392, _393 = _394, _395 = _396, _397 = _398, _399++)
        {
            bool _410 = _95[_399].SimulIndices.w < 65535u;
            if (_410)
            {
                int _416 = int(_95[_399].SimulIndices.x) * 3;
                uint _421 = uint(_416 + 1);
                float3 _430 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_416))).xy, ClothSimulVertsPositionsNormals.read(uint(_421)).x, 1.0)).xyz;
                int _433 = int(_95[_399].SimulIndices.y) * 3;
                uint _437 = uint(_433 + 1);
                float3 _444 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_433))).xy, ClothSimulVertsPositionsNormals.read(uint(_437)).x, 1.0)).xyz;
                int _447 = int(_95[_399].SimulIndices.z) * 3;
                uint _451 = uint(_447 + 1);
                float3 _458 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_447))).xy, ClothSimulVertsPositionsNormals.read(uint(_451)).x, 1.0)).xyz;
                float3 _468 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_421)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_416 + 2))).xy, 0.0)).xyz;
                float3 _478 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_437)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_433 + 2))).xy, 0.0)).xyz;
                float3 _488 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_451)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_447 + 2))).xy, 0.0)).xyz;
                _392 = _391 + (((((_430 + (_468 * _95[_399].BaryCoordNormal.w)) * _95[_399].BaryCoordNormal.x) + ((_444 + (_478 * _95[_399].BaryCoordNormal.w)) * _95[_399].BaryCoordNormal.y)) + ((_458 + (_488 * _95[_399].BaryCoordNormal.w)) * _95[_399].BaryCoordNormal.z)) * 1.0);
                _394 = _393 + (((((_430 + (_468 * _95[_399].BaryCoordTangent.w)) * _95[_399].BaryCoordTangent.x) + ((_444 + (_478 * _95[_399].BaryCoordTangent.w)) * _95[_399].BaryCoordTangent.y)) + ((_458 + (_488 * _95[_399].BaryCoordTangent.w)) * _95[_399].BaryCoordTangent.z)) * 1.0);
                _398 = _397 + 1;
            }
            else
            {
                _392 = _391;
                _394 = _393;
                _398 = _397;
            }
            _389 = _410 ? _Globals.ClothBlendWeight : _388;
            _396 = _410 ? 1.0 : _395;
        }
        bool _525 = (_397 > 0) && (_395 > 9.9999997473787516355514526367188e-05);
        float3x3 _549;
        if (_525)
        {
            float _529 = 1.0 / _395;
            float3x3 _544 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _546 = _92;
            _546[0] = _544 * normalize((_393 * _529) - _281);
            float3x3 _548 = _546;
            _548[2] = _544 * normalize((_391 * _529) - _281);
            _549 = _548;
        }
        else
        {
            _549 = _92;
        }
        float3x3 _556 = _549;
        _556[1] = cross(_549[2], _549[0]) * in.in_var_ATTRIBUTE2.w;
        _557 = _525 ? _388 : 0.0;
        _558 = _556;
    }
    else
    {
        _557 = 0.0;
        _558 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _564 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _294);
    float3 _570 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _294);
    float3 _575 = float3(_557);
    float3 _583 = float3(1.0 - _557);
    float4 _658;
    switch (0u)
    {
        default:
        {
            if (_96[0].SimulIndices.w < 65535u)
            {
                _658 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _294) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _281, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _607 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _294) + in.in_var_ATTRIBUTE12;
                _658 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _607.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _607.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _607.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _662 = View.View_TranslatedWorldToClip * float4(_658.x, _658.y, _658.z, _658.w);
    float4 _663 = _93;
    _663.w = 0.0;
    float3x3 _677 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _677[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _680 = _677;
    _680[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _683 = _680;
    _683[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _684 = _683 * float3x3((_558[0] * _575) + (_564 * _583), (_558[1] * _575) + (normalize(cross(_570, _564) * in.in_var_ATTRIBUTE2.w) * _583), (_558[2] * _575) + (_570 * _583));
    float3 _685 = _684[0];
    out.out_var_TEXCOORD10_centroid = float4(_685.x, _685.y, _685.z, _663.w);
    out.out_var_TEXCOORD11_centroid = float4(_684[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_658.x, _658.y, _658.z, _658.w);
    out.gl_Position = _662;
    return out;
}

