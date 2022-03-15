

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

constant float _97 = {};
constant float3x3 _98 = {};

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

vertex Main_out Main_000040e4_cd96d946(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _101;
    for (int _123 = 0; _123 < 5; )
    {
        uint _131 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_123)) * 4u;
        _101[_123].BaryCoordPos = GPUSkinApexCloth.read(uint(_131));
        _101[_123].BaryCoordNormal = GPUSkinApexCloth.read(uint((_131 + 1u)));
        _101[_123].BaryCoordTangent = GPUSkinApexCloth.read(uint((_131 + 2u)));
        uint4 _143 = as_type<uint4>(GPUSkinApexCloth.read(uint((_131 + 3u))));
        uint2 _144 = _143.xy;
        uint2 _147 = (_144 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _101[_123].SimulIndices = uint4(_101[_123].SimulIndices.x, _147.x, _101[_123].SimulIndices.z, _147.y);
        uint2 _151 = _144 & uint2(65535u);
        _101[_123].SimulIndices = uint4(_151.x, _101[_123].SimulIndices.y, _151.y, _101[_123].SimulIndices.w);
        _101[_123].Weight = as_type<float>(_143.z);
        _123++;
        continue;
    }
    float3 _292;
    if (_101[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _102;
        _102 = _101;
        float3 _167;
        float _170;
        int _172;
        _167 = float3(0.0);
        _170 = 0.0;
        _172 = 0;
        float3 _168;
        float _171;
        int _173;
        for (int _174 = 0; _174 < 5; _167 = _168, _170 = _171, _172 = _173, _174++)
        {
            if (_102[_174].SimulIndices.w < 65535u)
            {
                int _191 = int(_102[_174].SimulIndices.x) * 3;
                uint _196 = uint(_191 + 1);
                int _208 = int(_102[_174].SimulIndices.y) * 3;
                uint _212 = uint(_208 + 1);
                int _222 = int(_102[_174].SimulIndices.z) * 3;
                uint _226 = uint(_222 + 1);
                _168 = _167 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_191))).xy, ClothSimulVertsPositionsNormals.read(uint(_196)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_196)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_191 + 2))).xy, 0.0)).xyz * _102[_174].BaryCoordPos.w)) * _102[_174].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_208))).xy, ClothSimulVertsPositionsNormals.read(uint(_212)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_212)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_208 + 2))).xy, 0.0)).xyz * _102[_174].BaryCoordPos.w)) * _102[_174].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_222))).xy, ClothSimulVertsPositionsNormals.read(uint(_226)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_226)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_222 + 2))).xy, 0.0)).xyz * _102[_174].BaryCoordPos.w)) * ((1.0 - _102[_174].BaryCoordPos.x) - _102[_174].BaryCoordPos.y))) * _102[_174].Weight);
                _171 = _170 + _102[_174].Weight;
                _173 = _172 + 1;
            }
            else
            {
                _168 = _167;
                _171 = _170;
                _173 = _172;
            }
        }
        float3 _291;
        if ((_172 > 0) && (_170 > 9.9999997473787516355514526367188e-05))
        {
            _291 = _167 * (1.0 / _170);
        }
        else
        {
            _291 = float3(0.0);
        }
        _292 = _291;
    }
    else
    {
        _292 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _294 = float4(in.in_var_ATTRIBUTE4.x);
    int _297 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _311 = float4(in.in_var_ATTRIBUTE4.y);
    int _314 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _330 = float4(in.in_var_ATTRIBUTE4.z);
    int _333 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _349 = float4(in.in_var_ATTRIBUTE4.w);
    int _352 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _364 = (((_294 * BoneMatrices.read(uint(uint(_297)))) + (_311 * BoneMatrices.read(uint(uint(_314))))) + (_330 * BoneMatrices.read(uint(uint(_333))))) + (_349 * BoneMatrices.read(uint(uint(_352))));
    float4 _365 = (((_294 * BoneMatrices.read(uint(uint(_297 + 1)))) + (_311 * BoneMatrices.read(uint(uint(_314 + 1))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 1))))) + (_349 * BoneMatrices.read(uint(uint(_352 + 1))));
    float4 _366 = (((_294 * BoneMatrices.read(uint(uint(_297 + 2)))) + (_311 * BoneMatrices.read(uint(uint(_314 + 2))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 2))))) + (_349 * BoneMatrices.read(uint(uint(_352 + 2))));
    float3x4 _450;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _374 = float4(in.in_var_ATTRIBUTE15.x);
        int _377 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _393 = float4(in.in_var_ATTRIBUTE15.y);
        int _396 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _412 = float4(in.in_var_ATTRIBUTE15.z);
        int _415 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _431 = float4(in.in_var_ATTRIBUTE15.w);
        int _434 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _450 = float3x4((((_364 + (_374 * BoneMatrices.read(uint(uint(_377))))) + (_393 * BoneMatrices.read(uint(uint(_396))))) + (_412 * BoneMatrices.read(uint(uint(_415))))) + (_431 * BoneMatrices.read(uint(uint(_434)))), (((_365 + (_374 * BoneMatrices.read(uint(uint(_377 + 1))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 1))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 1))))) + (_431 * BoneMatrices.read(uint(uint(_434 + 1)))), (((_366 + (_374 * BoneMatrices.read(uint(uint(_377 + 2))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 2))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 2))))) + (_431 * BoneMatrices.read(uint(uint(_434 + 2)))));
    }
    else
    {
        _450 = float3x4(_364, _365, _366);
    }
    spvUnsafeArray<FClothVertex, 5> _100;
    _100 = _101;
    float _633;
    float3x3 _634;
    if (_100[0].SimulIndices.w < 65535u)
    {
        float _462;
        float3 _465;
        float3 _467;
        float _469;
        int _471;
        _462 = _Globals.ClothBlendWeight;
        _465 = float3(0.0);
        _467 = float3(0.0);
        _469 = 0.0;
        _471 = 0;
        float _463;
        float3 _466;
        float3 _468;
        float _470;
        int _472;
        for (int _473 = 0; _473 < 5; _462 = _463, _465 = _466, _467 = _468, _469 = _470, _471 = _472, _473++)
        {
            bool _485 = _100[_473].SimulIndices.w < 65535u;
            if (_485)
            {
                int _491 = int(_100[_473].SimulIndices.x) * 3;
                uint _496 = uint(_491 + 1);
                float3 _505 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_491))).xy, ClothSimulVertsPositionsNormals.read(uint(_496)).x, 1.0)).xyz;
                int _508 = int(_100[_473].SimulIndices.y) * 3;
                uint _512 = uint(_508 + 1);
                float3 _519 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_508))).xy, ClothSimulVertsPositionsNormals.read(uint(_512)).x, 1.0)).xyz;
                int _522 = int(_100[_473].SimulIndices.z) * 3;
                uint _526 = uint(_522 + 1);
                float3 _533 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_522))).xy, ClothSimulVertsPositionsNormals.read(uint(_526)).x, 1.0)).xyz;
                float3 _543 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_496)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_491 + 2))).xy, 0.0)).xyz;
                float3 _553 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_512)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_508 + 2))).xy, 0.0)).xyz;
                float3 _563 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_526)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_522 + 2))).xy, 0.0)).xyz;
                _466 = _465 + (((((_505 + (_543 * _100[_473].BaryCoordNormal.w)) * _100[_473].BaryCoordNormal.x) + ((_519 + (_553 * _100[_473].BaryCoordNormal.w)) * _100[_473].BaryCoordNormal.y)) + ((_533 + (_563 * _100[_473].BaryCoordNormal.w)) * _100[_473].BaryCoordNormal.z)) * _100[_473].Weight);
                _468 = _467 + (((((_505 + (_543 * _100[_473].BaryCoordTangent.w)) * _100[_473].BaryCoordTangent.x) + ((_519 + (_553 * _100[_473].BaryCoordTangent.w)) * _100[_473].BaryCoordTangent.y)) + ((_533 + (_563 * _100[_473].BaryCoordTangent.w)) * _100[_473].BaryCoordTangent.z)) * _100[_473].Weight);
                _470 = _469 + _100[_473].Weight;
                _472 = _471 + 1;
            }
            else
            {
                _466 = _465;
                _468 = _467;
                _470 = _469;
                _472 = _471;
            }
            _463 = _485 ? _Globals.ClothBlendWeight : _462;
        }
        bool _601 = (_471 > 0) && (_469 > 9.9999997473787516355514526367188e-05);
        float3x3 _625;
        if (_601)
        {
            float _605 = 1.0 / _469;
            float3x3 _620 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _622 = _98;
            _622[0] = _620 * normalize((_467 * _605) - _292);
            float3x3 _624 = _622;
            _624[2] = _620 * normalize((_465 * _605) - _292);
            _625 = _624;
        }
        else
        {
            _625 = _98;
        }
        float3x3 _632 = _625;
        _632[1] = cross(_625[2], _625[0]) * in.in_var_ATTRIBUTE2.w;
        _633 = _601 ? _462 : 0.0;
        _634 = _632;
    }
    else
    {
        _633 = 0.0;
        _634 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _640 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _450);
    float3 _646 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _450);
    float3 _651 = float3(_633);
    float3 _659 = float3(1.0 - _633);
    float4 _734;
    switch (0u)
    {
        default:
        {
            if (_101[0].SimulIndices.w < 65535u)
            {
                _734 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _450) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _292, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _683 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _450) + in.in_var_ATTRIBUTE12;
                _734 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _683.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _683.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _683.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _748 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _748[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _751 = _748;
    _751[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _754 = _751;
    _754[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _767 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_734.x, _734.y, _734.z, _734.w);
    float4 _778;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_767.z < 0.0))
    {
        float4 _776 = _767;
        _776.z = 9.9999999747524270787835121154785e-07;
        float4 _777 = _776;
        _777.w = 1.0;
        _778 = _777;
    }
    else
    {
        _778 = _767;
    }
    float _784 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_754 * float3x3((_634[0] * _651) + (_640 * _659), (_634[1] * _651) + (normalize(cross(_646, _640) * in.in_var_ATTRIBUTE2.w) * _659), (_634[2] * _651) + (_646 * _659)))[2], _97).xyz));
    float4 _809 = _778;
    _809.z = ((_778.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_784) > 0.0) ? (sqrt(fast::clamp(1.0 - (_784 * _784), 0.0, 1.0)) / _784) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _778.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _809;
    return out;
}

