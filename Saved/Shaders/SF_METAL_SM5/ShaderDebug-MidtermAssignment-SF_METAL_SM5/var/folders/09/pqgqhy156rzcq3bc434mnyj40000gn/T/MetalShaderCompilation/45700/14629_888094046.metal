

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

vertex Main_out Main_00003925_34ef3d5e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _96;
    for (int _117 = 0; _117 < 1; )
    {
        uint _124 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_117)) * 4u;
        _96[_117].BaryCoordPos = GPUSkinApexCloth.read(uint(_124));
        _96[_117].BaryCoordNormal = GPUSkinApexCloth.read(uint((_124 + 1u)));
        _96[_117].BaryCoordTangent = GPUSkinApexCloth.read(uint((_124 + 2u)));
        uint4 _136 = as_type<uint4>(GPUSkinApexCloth.read(uint((_124 + 3u))));
        uint2 _137 = _136.xy;
        uint2 _140 = (_137 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _96[_117].SimulIndices = uint4(_96[_117].SimulIndices.x, _140.x, _96[_117].SimulIndices.z, _140.y);
        uint2 _144 = _137 & uint2(65535u);
        _96[_117].SimulIndices = uint4(_144.x, _96[_117].SimulIndices.y, _144.y, _96[_117].SimulIndices.w);
        _96[_117].Weight = as_type<float>(_136.z);
        _117++;
        continue;
    }
    float3 _283;
    if (_96[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _97;
        _97 = _96;
        float3 _160;
        float _163;
        int _165;
        _160 = float3(0.0);
        _163 = 0.0;
        _165 = 0;
        float _164;
        float3 _161;
        int _166;
        for (int _167 = 0; _167 < 1; _160 = _161, _163 = _164, _165 = _166, _167++)
        {
            bool _177 = _97[_167].SimulIndices.w < 65535u;
            if (_177)
            {
                int _183 = int(_97[_167].SimulIndices.x) * 3;
                uint _188 = uint(_183 + 1);
                int _200 = int(_97[_167].SimulIndices.y) * 3;
                uint _204 = uint(_200 + 1);
                int _214 = int(_97[_167].SimulIndices.z) * 3;
                uint _218 = uint(_214 + 1);
                _161 = _160 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_183))).xy, ClothSimulVertsPositionsNormals.read(uint(_188)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_188)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_183 + 2))).xy, 0.0)).xyz * _97[_167].BaryCoordPos.w)) * _97[_167].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_200))).xy, ClothSimulVertsPositionsNormals.read(uint(_204)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_204)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_200 + 2))).xy, 0.0)).xyz * _97[_167].BaryCoordPos.w)) * _97[_167].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_214))).xy, ClothSimulVertsPositionsNormals.read(uint(_218)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_218)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_214 + 2))).xy, 0.0)).xyz * _97[_167].BaryCoordPos.w)) * ((1.0 - _97[_167].BaryCoordPos.x) - _97[_167].BaryCoordPos.y))) * 1.0);
                _166 = _165 + 1;
            }
            else
            {
                _161 = _160;
                _166 = _165;
            }
            _164 = _177 ? 1.0 : _163;
        }
        float3 _282;
        if ((_165 > 0) && (_163 > 9.9999997473787516355514526367188e-05))
        {
            _282 = _160 * (1.0 / _163);
        }
        else
        {
            _282 = float3(0.0);
        }
        _283 = _282;
    }
    else
    {
        _283 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _285 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _288 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _294 = int(_288 + (_Globals.InputWeightIndexSize * uint(_285)));
    float3x4 _296;
    _296 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _297;
    for (int _299 = 0; _299 < _285; _296 = _297, _299++)
    {
        int _307 = int(_288 + (_Globals.InputWeightIndexSize * uint(_299)));
        int _312 = int(InputWeightStream.read(uint(uint(_307))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _358 = float4(float(InputWeightStream.read(uint(uint(_294 + _299))).x) * 0.0039215688593685626983642578125);
            int _359 = int((InputWeightStream.read(uint(uint(_307 + 1))).x << 8u) | uint(_312)) * 3;
            _297 = float3x4(_296[0] + (_358 * BoneMatrices.read(uint(uint(_359)))), _296[1] + (_358 * BoneMatrices.read(uint(uint(_359 + 1)))), _296[2] + (_358 * BoneMatrices.read(uint(uint(_359 + 2)))));
        }
        else
        {
            float4 _323 = float4(float(InputWeightStream.read(uint(uint(_294 + _299))).x) * 0.0039215688593685626983642578125);
            int _324 = _312 * 3;
            _297 = float3x4(_296[0] + (_323 * BoneMatrices.read(uint(uint(_324)))), _296[1] + (_323 * BoneMatrices.read(uint(uint(_324 + 1)))), _296[2] + (_323 * BoneMatrices.read(uint(uint(_324 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _95;
    _95 = _96;
    float _559;
    float3x3 _560;
    if (_95[0].SimulIndices.w < 65535u)
    {
        float _390;
        float3 _393;
        float3 _395;
        float _397;
        int _399;
        _390 = _Globals.ClothBlendWeight;
        _393 = float3(0.0);
        _395 = float3(0.0);
        _397 = 0.0;
        _399 = 0;
        float _391;
        float _398;
        float3 _394;
        float3 _396;
        int _400;
        for (int _401 = 0; _401 < 1; _390 = _391, _393 = _394, _395 = _396, _397 = _398, _399 = _400, _401++)
        {
            bool _412 = _95[_401].SimulIndices.w < 65535u;
            if (_412)
            {
                int _418 = int(_95[_401].SimulIndices.x) * 3;
                uint _423 = uint(_418 + 1);
                float3 _432 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_418))).xy, ClothSimulVertsPositionsNormals.read(uint(_423)).x, 1.0)).xyz;
                int _435 = int(_95[_401].SimulIndices.y) * 3;
                uint _439 = uint(_435 + 1);
                float3 _446 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_435))).xy, ClothSimulVertsPositionsNormals.read(uint(_439)).x, 1.0)).xyz;
                int _449 = int(_95[_401].SimulIndices.z) * 3;
                uint _453 = uint(_449 + 1);
                float3 _460 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_449))).xy, ClothSimulVertsPositionsNormals.read(uint(_453)).x, 1.0)).xyz;
                float3 _470 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_423)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_418 + 2))).xy, 0.0)).xyz;
                float3 _480 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_439)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_435 + 2))).xy, 0.0)).xyz;
                float3 _490 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_453)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_449 + 2))).xy, 0.0)).xyz;
                _394 = _393 + (((((_432 + (_470 * _95[_401].BaryCoordNormal.w)) * _95[_401].BaryCoordNormal.x) + ((_446 + (_480 * _95[_401].BaryCoordNormal.w)) * _95[_401].BaryCoordNormal.y)) + ((_460 + (_490 * _95[_401].BaryCoordNormal.w)) * _95[_401].BaryCoordNormal.z)) * 1.0);
                _396 = _395 + (((((_432 + (_470 * _95[_401].BaryCoordTangent.w)) * _95[_401].BaryCoordTangent.x) + ((_446 + (_480 * _95[_401].BaryCoordTangent.w)) * _95[_401].BaryCoordTangent.y)) + ((_460 + (_490 * _95[_401].BaryCoordTangent.w)) * _95[_401].BaryCoordTangent.z)) * 1.0);
                _400 = _399 + 1;
            }
            else
            {
                _394 = _393;
                _396 = _395;
                _400 = _399;
            }
            _391 = _412 ? _Globals.ClothBlendWeight : _390;
            _398 = _412 ? 1.0 : _397;
        }
        bool _527 = (_399 > 0) && (_397 > 9.9999997473787516355514526367188e-05);
        float3x3 _551;
        if (_527)
        {
            float _531 = 1.0 / _397;
            float3x3 _546 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _548 = _92;
            _548[0] = _546 * normalize((_395 * _531) - _283);
            float3x3 _550 = _548;
            _550[2] = _546 * normalize((_393 * _531) - _283);
            _551 = _550;
        }
        else
        {
            _551 = _92;
        }
        float3x3 _558 = _551;
        _558[1] = cross(_551[2], _551[0]) * in.in_var_ATTRIBUTE2.w;
        _559 = _527 ? _390 : 0.0;
        _560 = _558;
    }
    else
    {
        _559 = 0.0;
        _560 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _566 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _296);
    float3 _572 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _296);
    float3 _577 = float3(_559);
    float3 _585 = float3(1.0 - _559);
    float4 _660;
    switch (0u)
    {
        default:
        {
            if (_96[0].SimulIndices.w < 65535u)
            {
                _660 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _296) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _283, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _609 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _296) + in.in_var_ATTRIBUTE12;
                _660 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _609.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _609.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _609.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _662 = View.View_TranslatedWorldToClip * float4(_660.x, _660.y, _660.z, _660.w);
    float4 _663 = _93;
    _663.w = 0.0;
    float3x3 _677 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _677[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _680 = _677;
    _680[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _683 = _680;
    _683[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _684 = _683 * float3x3((_560[0] * _577) + (_566 * _585), (_560[1] * _577) + (normalize(cross(_572, _566) * in.in_var_ATTRIBUTE2.w) * _585), (_560[2] * _577) + (_572 * _585));
    float3 _685 = _684[0];
    out.gl_Position = _662;
    out.out_var_TEXCOORD10_centroid = float4(_685.x, _685.y, _685.z, _663.w);
    out.out_var_TEXCOORD11_centroid = float4(_684[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_660.x, _660.y, _660.z, _660.w);
    return out;
}

