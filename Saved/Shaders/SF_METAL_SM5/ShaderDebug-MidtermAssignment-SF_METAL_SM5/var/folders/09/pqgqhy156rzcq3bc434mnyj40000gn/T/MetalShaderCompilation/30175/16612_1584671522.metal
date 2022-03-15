

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

constant spvUnsafeArray<float2, 1> _94 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _99 = {};
constant float4 _100 = {};

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

vertex MainVertexShader_out Main_000040e4_5e742b22(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _104;
    for (int _130 = 0; _130 < 1; )
    {
        uint _137 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_130)) * 4u;
        _104[_130].BaryCoordPos = GPUSkinApexCloth.read(uint(_137));
        _104[_130].BaryCoordNormal = GPUSkinApexCloth.read(uint((_137 + 1u)));
        _104[_130].BaryCoordTangent = GPUSkinApexCloth.read(uint((_137 + 2u)));
        uint4 _149 = as_type<uint4>(GPUSkinApexCloth.read(uint((_137 + 3u))));
        uint2 _150 = _149.xy;
        uint2 _153 = (_150 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _104[_130].SimulIndices = uint4(_104[_130].SimulIndices.x, _153.x, _104[_130].SimulIndices.z, _153.y);
        uint2 _157 = _150 & uint2(65535u);
        _104[_130].SimulIndices = uint4(_157.x, _104[_130].SimulIndices.y, _157.y, _104[_130].SimulIndices.w);
        _104[_130].Weight = as_type<float>(_149.z);
        _130++;
        continue;
    }
    float3 _296;
    if (_104[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _106;
        _106 = _104;
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
            bool _190 = _106[_180].SimulIndices.w < 65535u;
            if (_190)
            {
                int _196 = int(_106[_180].SimulIndices.x) * 3;
                uint _201 = uint(_196 + 1);
                int _213 = int(_106[_180].SimulIndices.y) * 3;
                uint _217 = uint(_213 + 1);
                int _227 = int(_106[_180].SimulIndices.z) * 3;
                uint _231 = uint(_227 + 1);
                _174 = _173 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_196))).xy, ClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_201)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_196 + 2))).xy, 0.0)).xyz * _106[_180].BaryCoordPos.w)) * _106[_180].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _106[_180].BaryCoordPos.w)) * _106[_180].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, ClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_231)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _106[_180].BaryCoordPos.w)) * ((1.0 - _106[_180].BaryCoordPos.x) - _106[_180].BaryCoordPos.y))) * 1.0);
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
    float4 _298 = float4(in.in_var_ATTRIBUTE4.x);
    int _301 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _315 = float4(in.in_var_ATTRIBUTE4.y);
    int _318 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _334 = float4(in.in_var_ATTRIBUTE4.z);
    int _337 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _353 = float4(in.in_var_ATTRIBUTE4.w);
    int _356 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _368 = (((_298 * BoneMatrices.read(uint(uint(_301)))) + (_315 * BoneMatrices.read(uint(uint(_318))))) + (_334 * BoneMatrices.read(uint(uint(_337))))) + (_353 * BoneMatrices.read(uint(uint(_356))));
    float4 _369 = (((_298 * BoneMatrices.read(uint(uint(_301 + 1)))) + (_315 * BoneMatrices.read(uint(uint(_318 + 1))))) + (_334 * BoneMatrices.read(uint(uint(_337 + 1))))) + (_353 * BoneMatrices.read(uint(uint(_356 + 1))));
    float4 _370 = (((_298 * BoneMatrices.read(uint(uint(_301 + 2)))) + (_315 * BoneMatrices.read(uint(uint(_318 + 2))))) + (_334 * BoneMatrices.read(uint(uint(_337 + 2))))) + (_353 * BoneMatrices.read(uint(uint(_356 + 2))));
    float3x4 _454;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _378 = float4(in.in_var_ATTRIBUTE15.x);
        int _381 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _397 = float4(in.in_var_ATTRIBUTE15.y);
        int _400 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _416 = float4(in.in_var_ATTRIBUTE15.z);
        int _419 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _435 = float4(in.in_var_ATTRIBUTE15.w);
        int _438 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _454 = float3x4((((_368 + (_378 * BoneMatrices.read(uint(uint(_381))))) + (_397 * BoneMatrices.read(uint(uint(_400))))) + (_416 * BoneMatrices.read(uint(uint(_419))))) + (_435 * BoneMatrices.read(uint(uint(_438)))), (((_369 + (_378 * BoneMatrices.read(uint(uint(_381 + 1))))) + (_397 * BoneMatrices.read(uint(uint(_400 + 1))))) + (_416 * BoneMatrices.read(uint(uint(_419 + 1))))) + (_435 * BoneMatrices.read(uint(uint(_438 + 1)))), (((_370 + (_378 * BoneMatrices.read(uint(uint(_381 + 2))))) + (_397 * BoneMatrices.read(uint(uint(_400 + 2))))) + (_416 * BoneMatrices.read(uint(uint(_419 + 2))))) + (_435 * BoneMatrices.read(uint(uint(_438 + 2)))));
    }
    else
    {
        _454 = float3x4(_368, _369, _370);
    }
    spvUnsafeArray<FClothVertex, 1> _103;
    _103 = _104;
    float _635;
    float3x3 _636;
    if (_103[0].SimulIndices.w < 65535u)
    {
        float _466;
        float3 _469;
        float3 _471;
        float _473;
        int _475;
        _466 = _Globals.ClothBlendWeight;
        _469 = float3(0.0);
        _471 = float3(0.0);
        _473 = 0.0;
        _475 = 0;
        float _467;
        float _474;
        float3 _470;
        float3 _472;
        int _476;
        for (int _477 = 0; _477 < 1; _466 = _467, _469 = _470, _471 = _472, _473 = _474, _475 = _476, _477++)
        {
            bool _488 = _103[_477].SimulIndices.w < 65535u;
            if (_488)
            {
                int _494 = int(_103[_477].SimulIndices.x) * 3;
                uint _499 = uint(_494 + 1);
                float3 _508 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_494))).xy, ClothSimulVertsPositionsNormals.read(uint(_499)).x, 1.0)).xyz;
                int _511 = int(_103[_477].SimulIndices.y) * 3;
                uint _515 = uint(_511 + 1);
                float3 _522 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_511))).xy, ClothSimulVertsPositionsNormals.read(uint(_515)).x, 1.0)).xyz;
                int _525 = int(_103[_477].SimulIndices.z) * 3;
                uint _529 = uint(_525 + 1);
                float3 _536 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_525))).xy, ClothSimulVertsPositionsNormals.read(uint(_529)).x, 1.0)).xyz;
                float3 _546 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_499)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_494 + 2))).xy, 0.0)).xyz;
                float3 _556 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_515)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_511 + 2))).xy, 0.0)).xyz;
                float3 _566 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_529)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_525 + 2))).xy, 0.0)).xyz;
                _470 = _469 + (((((_508 + (_546 * _103[_477].BaryCoordNormal.w)) * _103[_477].BaryCoordNormal.x) + ((_522 + (_556 * _103[_477].BaryCoordNormal.w)) * _103[_477].BaryCoordNormal.y)) + ((_536 + (_566 * _103[_477].BaryCoordNormal.w)) * _103[_477].BaryCoordNormal.z)) * 1.0);
                _472 = _471 + (((((_508 + (_546 * _103[_477].BaryCoordTangent.w)) * _103[_477].BaryCoordTangent.x) + ((_522 + (_556 * _103[_477].BaryCoordTangent.w)) * _103[_477].BaryCoordTangent.y)) + ((_536 + (_566 * _103[_477].BaryCoordTangent.w)) * _103[_477].BaryCoordTangent.z)) * 1.0);
                _476 = _475 + 1;
            }
            else
            {
                _470 = _469;
                _472 = _471;
                _476 = _475;
            }
            _467 = _488 ? _Globals.ClothBlendWeight : _466;
            _474 = _488 ? 1.0 : _473;
        }
        bool _603 = (_475 > 0) && (_473 > 9.9999997473787516355514526367188e-05);
        float3x3 _627;
        if (_603)
        {
            float _607 = 1.0 / _473;
            float3x3 _622 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _624 = _99;
            _624[0] = _622 * normalize((_471 * _607) - _296);
            float3x3 _626 = _624;
            _626[2] = _622 * normalize((_469 * _607) - _296);
            _627 = _626;
        }
        else
        {
            _627 = _99;
        }
        float3x3 _634 = _627;
        _634[1] = cross(_627[2], _627[0]) * in.in_var_ATTRIBUTE2.w;
        _635 = _603 ? _466 : 0.0;
        _636 = _634;
    }
    else
    {
        _635 = 0.0;
        _636 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _642 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _454);
    float3 _648 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _454);
    float3 _653 = float3(_635);
    float3 _661 = float3(1.0 - _635);
    float4 _736;
    switch (0u)
    {
        default:
        {
            if (_104[0].SimulIndices.w < 65535u)
            {
                _736 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _454) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _296, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _685 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _454) + in.in_var_ATTRIBUTE12;
                _736 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _685.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _685.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _685.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _102;
    _102 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _105 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _738 = 0; _738 < 1; )
    {
        _105[_738] = _102[_738];
        _738++;
        continue;
    }
    float4 _748 = View.View_TranslatedWorldToClip * float4(_736.x, _736.y, _736.z, _736.w);
    float4 _751 = _100;
    _751.w = 0.0;
    float3x3 _765 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _765[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _768 = _765;
    _768[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _771 = _768;
    _771[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _772 = _771 * float3x3((_636[0] * _653) + (_642 * _661), (_636[1] * _653) + (normalize(cross(_648, _642) * in.in_var_ATTRIBUTE2.w) * _661), (_636[2] * _653) + (_648 * _661));
    float3 _773 = _772[0];
    spvUnsafeArray<float4, 1> _783 = { float4(_105[0].x, _105[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_773.x, _773.y, _773.z, _751.w);
    out.out_var_TEXCOORD11_centroid = float4(_772[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _783;
    out.out_var_TEXCOORD6 = float4(_736.x, _736.y, _736.z, _736.w);
    out.gl_Position = _748;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

