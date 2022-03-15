

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

constant float3x3 _88 = {};
constant float4 _89 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_00003d23_416eaa0e(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _92;
    for (int _114 = 0; _114 < 1; )
    {
        uint _121 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_114)) * 4u;
        _92[_114].BaryCoordPos = GPUSkinApexCloth.read(uint(_121));
        _92[_114].BaryCoordNormal = GPUSkinApexCloth.read(uint((_121 + 1u)));
        _92[_114].BaryCoordTangent = GPUSkinApexCloth.read(uint((_121 + 2u)));
        uint4 _133 = as_type<uint4>(GPUSkinApexCloth.read(uint((_121 + 3u))));
        uint2 _134 = _133.xy;
        uint2 _137 = (_134 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _92[_114].SimulIndices = uint4(_92[_114].SimulIndices.x, _137.x, _92[_114].SimulIndices.z, _137.y);
        uint2 _141 = _134 & uint2(65535u);
        _92[_114].SimulIndices = uint4(_141.x, _92[_114].SimulIndices.y, _141.y, _92[_114].SimulIndices.w);
        _92[_114].Weight = as_type<float>(_133.z);
        _114++;
        continue;
    }
    float3 _280;
    if (_92[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _93;
        _93 = _92;
        float3 _157;
        float _160;
        int _162;
        _157 = float3(0.0);
        _160 = 0.0;
        _162 = 0;
        float _161;
        float3 _158;
        int _163;
        for (int _164 = 0; _164 < 1; _157 = _158, _160 = _161, _162 = _163, _164++)
        {
            bool _174 = _93[_164].SimulIndices.w < 65535u;
            if (_174)
            {
                int _180 = int(_93[_164].SimulIndices.x) * 3;
                uint _185 = uint(_180 + 1);
                int _197 = int(_93[_164].SimulIndices.y) * 3;
                uint _201 = uint(_197 + 1);
                int _211 = int(_93[_164].SimulIndices.z) * 3;
                uint _215 = uint(_211 + 1);
                _158 = _157 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_180))).xy, ClothSimulVertsPositionsNormals.read(uint(_185)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_185)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_180 + 2))).xy, 0.0)).xyz * _93[_164].BaryCoordPos.w)) * _93[_164].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_197))).xy, ClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_201)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_197 + 2))).xy, 0.0)).xyz * _93[_164].BaryCoordPos.w)) * _93[_164].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, ClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_215)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _93[_164].BaryCoordPos.w)) * ((1.0 - _93[_164].BaryCoordPos.x) - _93[_164].BaryCoordPos.y))) * 1.0);
                _163 = _162 + 1;
            }
            else
            {
                _158 = _157;
                _163 = _162;
            }
            _161 = _174 ? 1.0 : _160;
        }
        float3 _279;
        if ((_162 > 0) && (_160 > 9.9999997473787516355514526367188e-05))
        {
            _279 = _157 * (1.0 / _160);
        }
        else
        {
            _279 = float3(0.0);
        }
        _280 = _279;
    }
    else
    {
        _280 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _282 = float4(in.in_var_ATTRIBUTE4.x);
    int _285 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _299 = float4(in.in_var_ATTRIBUTE4.y);
    int _302 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _318 = float4(in.in_var_ATTRIBUTE4.z);
    int _321 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _337 = float4(in.in_var_ATTRIBUTE4.w);
    int _340 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _352 = (((_282 * BoneMatrices.read(uint(uint(_285)))) + (_299 * BoneMatrices.read(uint(uint(_302))))) + (_318 * BoneMatrices.read(uint(uint(_321))))) + (_337 * BoneMatrices.read(uint(uint(_340))));
    float4 _353 = (((_282 * BoneMatrices.read(uint(uint(_285 + 1)))) + (_299 * BoneMatrices.read(uint(uint(_302 + 1))))) + (_318 * BoneMatrices.read(uint(uint(_321 + 1))))) + (_337 * BoneMatrices.read(uint(uint(_340 + 1))));
    float4 _354 = (((_282 * BoneMatrices.read(uint(uint(_285 + 2)))) + (_299 * BoneMatrices.read(uint(uint(_302 + 2))))) + (_318 * BoneMatrices.read(uint(uint(_321 + 2))))) + (_337 * BoneMatrices.read(uint(uint(_340 + 2))));
    float3x4 _438;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _362 = float4(in.in_var_ATTRIBUTE15.x);
        int _365 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _381 = float4(in.in_var_ATTRIBUTE15.y);
        int _384 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _400 = float4(in.in_var_ATTRIBUTE15.z);
        int _403 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _419 = float4(in.in_var_ATTRIBUTE15.w);
        int _422 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _438 = float3x4((((_352 + (_362 * BoneMatrices.read(uint(uint(_365))))) + (_381 * BoneMatrices.read(uint(uint(_384))))) + (_400 * BoneMatrices.read(uint(uint(_403))))) + (_419 * BoneMatrices.read(uint(uint(_422)))), (((_353 + (_362 * BoneMatrices.read(uint(uint(_365 + 1))))) + (_381 * BoneMatrices.read(uint(uint(_384 + 1))))) + (_400 * BoneMatrices.read(uint(uint(_403 + 1))))) + (_419 * BoneMatrices.read(uint(uint(_422 + 1)))), (((_354 + (_362 * BoneMatrices.read(uint(uint(_365 + 2))))) + (_381 * BoneMatrices.read(uint(uint(_384 + 2))))) + (_400 * BoneMatrices.read(uint(uint(_403 + 2))))) + (_419 * BoneMatrices.read(uint(uint(_422 + 2)))));
    }
    else
    {
        _438 = float3x4(_352, _353, _354);
    }
    spvUnsafeArray<FClothVertex, 1> _91;
    _91 = _92;
    float _619;
    float3x3 _620;
    if (_91[0].SimulIndices.w < 65535u)
    {
        float _450;
        float3 _453;
        float3 _455;
        float _457;
        int _459;
        _450 = _Globals.ClothBlendWeight;
        _453 = float3(0.0);
        _455 = float3(0.0);
        _457 = 0.0;
        _459 = 0;
        float _451;
        float _458;
        float3 _454;
        float3 _456;
        int _460;
        for (int _461 = 0; _461 < 1; _450 = _451, _453 = _454, _455 = _456, _457 = _458, _459 = _460, _461++)
        {
            bool _472 = _91[_461].SimulIndices.w < 65535u;
            if (_472)
            {
                int _478 = int(_91[_461].SimulIndices.x) * 3;
                uint _483 = uint(_478 + 1);
                float3 _492 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_478))).xy, ClothSimulVertsPositionsNormals.read(uint(_483)).x, 1.0)).xyz;
                int _495 = int(_91[_461].SimulIndices.y) * 3;
                uint _499 = uint(_495 + 1);
                float3 _506 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_495))).xy, ClothSimulVertsPositionsNormals.read(uint(_499)).x, 1.0)).xyz;
                int _509 = int(_91[_461].SimulIndices.z) * 3;
                uint _513 = uint(_509 + 1);
                float3 _520 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_509))).xy, ClothSimulVertsPositionsNormals.read(uint(_513)).x, 1.0)).xyz;
                float3 _530 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_483)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_478 + 2))).xy, 0.0)).xyz;
                float3 _540 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_499)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_495 + 2))).xy, 0.0)).xyz;
                float3 _550 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_513)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_509 + 2))).xy, 0.0)).xyz;
                _454 = _453 + (((((_492 + (_530 * _91[_461].BaryCoordNormal.w)) * _91[_461].BaryCoordNormal.x) + ((_506 + (_540 * _91[_461].BaryCoordNormal.w)) * _91[_461].BaryCoordNormal.y)) + ((_520 + (_550 * _91[_461].BaryCoordNormal.w)) * _91[_461].BaryCoordNormal.z)) * 1.0);
                _456 = _455 + (((((_492 + (_530 * _91[_461].BaryCoordTangent.w)) * _91[_461].BaryCoordTangent.x) + ((_506 + (_540 * _91[_461].BaryCoordTangent.w)) * _91[_461].BaryCoordTangent.y)) + ((_520 + (_550 * _91[_461].BaryCoordTangent.w)) * _91[_461].BaryCoordTangent.z)) * 1.0);
                _460 = _459 + 1;
            }
            else
            {
                _454 = _453;
                _456 = _455;
                _460 = _459;
            }
            _451 = _472 ? _Globals.ClothBlendWeight : _450;
            _458 = _472 ? 1.0 : _457;
        }
        bool _587 = (_459 > 0) && (_457 > 9.9999997473787516355514526367188e-05);
        float3x3 _611;
        if (_587)
        {
            float _591 = 1.0 / _457;
            float3x3 _606 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _608 = _88;
            _608[0] = _606 * normalize((_455 * _591) - _280);
            float3x3 _610 = _608;
            _610[2] = _606 * normalize((_453 * _591) - _280);
            _611 = _610;
        }
        else
        {
            _611 = _88;
        }
        float3x3 _618 = _611;
        _618[1] = cross(_611[2], _611[0]) * in.in_var_ATTRIBUTE2.w;
        _619 = _587 ? _450 : 0.0;
        _620 = _618;
    }
    else
    {
        _619 = 0.0;
        _620 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _626 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _438);
    float3 _632 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _438);
    float3 _637 = float3(_619);
    float3 _645 = float3(1.0 - _619);
    float4 _720;
    switch (0u)
    {
        default:
        {
            if (_92[0].SimulIndices.w < 65535u)
            {
                _720 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _438) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _280, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _669 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _438) + in.in_var_ATTRIBUTE12;
                _720 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _669.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _669.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _669.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _724 = View.View_TranslatedWorldToClip * float4(_720.x, _720.y, _720.z, _720.w);
    float4 _725 = _89;
    _725.w = 0.0;
    float3x3 _739 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _739[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _742 = _739;
    _742[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _745 = _742;
    _745[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _746 = _745 * float3x3((_620[0] * _637) + (_626 * _645), (_620[1] * _637) + (normalize(cross(_632, _626) * in.in_var_ATTRIBUTE2.w) * _645), (_620[2] * _637) + (_632 * _645));
    float3 _747 = _746[0];
    out.out_var_TEXCOORD10_centroid = float4(_747.x, _747.y, _747.z, _725.w);
    out.out_var_TEXCOORD11_centroid = float4(_746[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_720.x, _720.y, _720.z, _720.w);
    out.gl_Position = _724;
    return out;
}

