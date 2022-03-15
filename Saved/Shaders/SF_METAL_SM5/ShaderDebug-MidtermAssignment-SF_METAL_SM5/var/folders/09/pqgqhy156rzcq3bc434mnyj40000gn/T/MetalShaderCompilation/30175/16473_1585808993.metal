

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
    char _m0_pad[1120];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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

constant float _95 = {};
constant float3x3 _96 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
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

vertex Main_out Main_00004059_5e858661(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _99;
    for (int _121 = 0; _121 < 1; )
    {
        uint _128 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_121)) * 4u;
        _99[_121].BaryCoordPos = GPUSkinApexCloth.read(uint(_128));
        _99[_121].BaryCoordNormal = GPUSkinApexCloth.read(uint((_128 + 1u)));
        _99[_121].BaryCoordTangent = GPUSkinApexCloth.read(uint((_128 + 2u)));
        uint4 _140 = as_type<uint4>(GPUSkinApexCloth.read(uint((_128 + 3u))));
        uint2 _141 = _140.xy;
        uint2 _144 = (_141 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _99[_121].SimulIndices = uint4(_99[_121].SimulIndices.x, _144.x, _99[_121].SimulIndices.z, _144.y);
        uint2 _148 = _141 & uint2(65535u);
        _99[_121].SimulIndices = uint4(_148.x, _99[_121].SimulIndices.y, _148.y, _99[_121].SimulIndices.w);
        _99[_121].Weight = as_type<float>(_140.z);
        _121++;
        continue;
    }
    float3 _287;
    if (_99[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _100;
        _100 = _99;
        float3 _164;
        float _167;
        int _169;
        _164 = float3(0.0);
        _167 = 0.0;
        _169 = 0;
        float _168;
        float3 _165;
        int _170;
        for (int _171 = 0; _171 < 1; _164 = _165, _167 = _168, _169 = _170, _171++)
        {
            bool _181 = _100[_171].SimulIndices.w < 65535u;
            if (_181)
            {
                int _187 = int(_100[_171].SimulIndices.x) * 3;
                uint _192 = uint(_187 + 1);
                int _204 = int(_100[_171].SimulIndices.y) * 3;
                uint _208 = uint(_204 + 1);
                int _218 = int(_100[_171].SimulIndices.z) * 3;
                uint _222 = uint(_218 + 1);
                _165 = _164 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_187))).xy, ClothSimulVertsPositionsNormals.read(uint(_192)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_192)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_187 + 2))).xy, 0.0)).xyz * _100[_171].BaryCoordPos.w)) * _100[_171].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_204))).xy, ClothSimulVertsPositionsNormals.read(uint(_208)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_208)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_204 + 2))).xy, 0.0)).xyz * _100[_171].BaryCoordPos.w)) * _100[_171].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_218))).xy, ClothSimulVertsPositionsNormals.read(uint(_222)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_222)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_218 + 2))).xy, 0.0)).xyz * _100[_171].BaryCoordPos.w)) * ((1.0 - _100[_171].BaryCoordPos.x) - _100[_171].BaryCoordPos.y))) * 1.0);
                _170 = _169 + 1;
            }
            else
            {
                _165 = _164;
                _170 = _169;
            }
            _168 = _181 ? 1.0 : _167;
        }
        float3 _286;
        if ((_169 > 0) && (_167 > 9.9999997473787516355514526367188e-05))
        {
            _286 = _164 * (1.0 / _167);
        }
        else
        {
            _286 = float3(0.0);
        }
        _287 = _286;
    }
    else
    {
        _287 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _289 = float4(in.in_var_ATTRIBUTE4.x);
    int _292 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _306 = float4(in.in_var_ATTRIBUTE4.y);
    int _309 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _325 = float4(in.in_var_ATTRIBUTE4.z);
    int _328 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _344 = float4(in.in_var_ATTRIBUTE4.w);
    int _347 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _359 = (((_289 * BoneMatrices.read(uint(uint(_292)))) + (_306 * BoneMatrices.read(uint(uint(_309))))) + (_325 * BoneMatrices.read(uint(uint(_328))))) + (_344 * BoneMatrices.read(uint(uint(_347))));
    float4 _360 = (((_289 * BoneMatrices.read(uint(uint(_292 + 1)))) + (_306 * BoneMatrices.read(uint(uint(_309 + 1))))) + (_325 * BoneMatrices.read(uint(uint(_328 + 1))))) + (_344 * BoneMatrices.read(uint(uint(_347 + 1))));
    float4 _361 = (((_289 * BoneMatrices.read(uint(uint(_292 + 2)))) + (_306 * BoneMatrices.read(uint(uint(_309 + 2))))) + (_325 * BoneMatrices.read(uint(uint(_328 + 2))))) + (_344 * BoneMatrices.read(uint(uint(_347 + 2))));
    float3x4 _445;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _369 = float4(in.in_var_ATTRIBUTE15.x);
        int _372 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _388 = float4(in.in_var_ATTRIBUTE15.y);
        int _391 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _407 = float4(in.in_var_ATTRIBUTE15.z);
        int _410 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _426 = float4(in.in_var_ATTRIBUTE15.w);
        int _429 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _445 = float3x4((((_359 + (_369 * BoneMatrices.read(uint(uint(_372))))) + (_388 * BoneMatrices.read(uint(uint(_391))))) + (_407 * BoneMatrices.read(uint(uint(_410))))) + (_426 * BoneMatrices.read(uint(uint(_429)))), (((_360 + (_369 * BoneMatrices.read(uint(uint(_372 + 1))))) + (_388 * BoneMatrices.read(uint(uint(_391 + 1))))) + (_407 * BoneMatrices.read(uint(uint(_410 + 1))))) + (_426 * BoneMatrices.read(uint(uint(_429 + 1)))), (((_361 + (_369 * BoneMatrices.read(uint(uint(_372 + 2))))) + (_388 * BoneMatrices.read(uint(uint(_391 + 2))))) + (_407 * BoneMatrices.read(uint(uint(_410 + 2))))) + (_426 * BoneMatrices.read(uint(uint(_429 + 2)))));
    }
    else
    {
        _445 = float3x4(_359, _360, _361);
    }
    spvUnsafeArray<FClothVertex, 1> _98;
    _98 = _99;
    float _626;
    float3x3 _627;
    if (_98[0].SimulIndices.w < 65535u)
    {
        float _457;
        float3 _460;
        float3 _462;
        float _464;
        int _466;
        _457 = _Globals.ClothBlendWeight;
        _460 = float3(0.0);
        _462 = float3(0.0);
        _464 = 0.0;
        _466 = 0;
        float _458;
        float _465;
        float3 _461;
        float3 _463;
        int _467;
        for (int _468 = 0; _468 < 1; _457 = _458, _460 = _461, _462 = _463, _464 = _465, _466 = _467, _468++)
        {
            bool _479 = _98[_468].SimulIndices.w < 65535u;
            if (_479)
            {
                int _485 = int(_98[_468].SimulIndices.x) * 3;
                uint _490 = uint(_485 + 1);
                float3 _499 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_485))).xy, ClothSimulVertsPositionsNormals.read(uint(_490)).x, 1.0)).xyz;
                int _502 = int(_98[_468].SimulIndices.y) * 3;
                uint _506 = uint(_502 + 1);
                float3 _513 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_502))).xy, ClothSimulVertsPositionsNormals.read(uint(_506)).x, 1.0)).xyz;
                int _516 = int(_98[_468].SimulIndices.z) * 3;
                uint _520 = uint(_516 + 1);
                float3 _527 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_516))).xy, ClothSimulVertsPositionsNormals.read(uint(_520)).x, 1.0)).xyz;
                float3 _537 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_490)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_485 + 2))).xy, 0.0)).xyz;
                float3 _547 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_506)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_502 + 2))).xy, 0.0)).xyz;
                float3 _557 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_520)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_516 + 2))).xy, 0.0)).xyz;
                _461 = _460 + (((((_499 + (_537 * _98[_468].BaryCoordNormal.w)) * _98[_468].BaryCoordNormal.x) + ((_513 + (_547 * _98[_468].BaryCoordNormal.w)) * _98[_468].BaryCoordNormal.y)) + ((_527 + (_557 * _98[_468].BaryCoordNormal.w)) * _98[_468].BaryCoordNormal.z)) * 1.0);
                _463 = _462 + (((((_499 + (_537 * _98[_468].BaryCoordTangent.w)) * _98[_468].BaryCoordTangent.x) + ((_513 + (_547 * _98[_468].BaryCoordTangent.w)) * _98[_468].BaryCoordTangent.y)) + ((_527 + (_557 * _98[_468].BaryCoordTangent.w)) * _98[_468].BaryCoordTangent.z)) * 1.0);
                _467 = _466 + 1;
            }
            else
            {
                _461 = _460;
                _463 = _462;
                _467 = _466;
            }
            _458 = _479 ? _Globals.ClothBlendWeight : _457;
            _465 = _479 ? 1.0 : _464;
        }
        bool _594 = (_466 > 0) && (_464 > 9.9999997473787516355514526367188e-05);
        float3x3 _618;
        if (_594)
        {
            float _598 = 1.0 / _464;
            float3x3 _613 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _615 = _96;
            _615[0] = _613 * normalize((_462 * _598) - _287);
            float3x3 _617 = _615;
            _617[2] = _613 * normalize((_460 * _598) - _287);
            _618 = _617;
        }
        else
        {
            _618 = _96;
        }
        float3x3 _625 = _618;
        _625[1] = cross(_618[2], _618[0]) * in.in_var_ATTRIBUTE2.w;
        _626 = _594 ? _457 : 0.0;
        _627 = _625;
    }
    else
    {
        _626 = 0.0;
        _627 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _633 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _445);
    float3 _639 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _445);
    float3 _644 = float3(_626);
    float3 _652 = float3(1.0 - _626);
    float4 _727;
    switch (0u)
    {
        default:
        {
            if (_99[0].SimulIndices.w < 65535u)
            {
                _727 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _445) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _287, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _676 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _445) + in.in_var_ATTRIBUTE12;
                _727 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _676.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _676.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _676.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _741 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _741[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _744 = _741;
    _744[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _747 = _744;
    _747[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _760 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_727.x, _727.y, _727.z, _727.w);
    float4 _771;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_760.z < 0.0))
    {
        float4 _769 = _760;
        _769.z = 9.9999999747524270787835121154785e-07;
        float4 _770 = _769;
        _770.w = 1.0;
        _771 = _770;
    }
    else
    {
        _771 = _760;
    }
    float _777 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_747 * float3x3((_627[0] * _644) + (_633 * _652), (_627[1] * _644) + (normalize(cross(_639, _633) * in.in_var_ATTRIBUTE2.w) * _652), (_627[2] * _644) + (_639 * _652)))[2], _95).xyz));
    float4 _802 = _771;
    _802.z = ((_771.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_777) > 0.0) ? (sqrt(fast::clamp(1.0 - (_777 * _777), 0.0, 1.0)) / _777) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _771.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _802;
    return out;
}

