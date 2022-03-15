

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

constant float _96 = {};
constant float3x3 _97 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
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

vertex Main_out Main_0000404d_4b05f14a(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _100;
    for (int _122 = 0; _122 < 1; )
    {
        uint _129 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_122)) * 4u;
        _100[_122].BaryCoordPos = GPUSkinApexCloth.read(uint(_129));
        _100[_122].BaryCoordNormal = GPUSkinApexCloth.read(uint((_129 + 1u)));
        _100[_122].BaryCoordTangent = GPUSkinApexCloth.read(uint((_129 + 2u)));
        uint4 _141 = as_type<uint4>(GPUSkinApexCloth.read(uint((_129 + 3u))));
        uint2 _142 = _141.xy;
        uint2 _145 = (_142 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _100[_122].SimulIndices = uint4(_100[_122].SimulIndices.x, _145.x, _100[_122].SimulIndices.z, _145.y);
        uint2 _149 = _142 & uint2(65535u);
        _100[_122].SimulIndices = uint4(_149.x, _100[_122].SimulIndices.y, _149.y, _100[_122].SimulIndices.w);
        _100[_122].Weight = as_type<float>(_141.z);
        _122++;
        continue;
    }
    float3 _288;
    if (_100[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _101;
        _101 = _100;
        float3 _165;
        float _168;
        int _170;
        _165 = float3(0.0);
        _168 = 0.0;
        _170 = 0;
        float _169;
        float3 _166;
        int _171;
        for (int _172 = 0; _172 < 1; _165 = _166, _168 = _169, _170 = _171, _172++)
        {
            bool _182 = _101[_172].SimulIndices.w < 65535u;
            if (_182)
            {
                int _188 = int(_101[_172].SimulIndices.x) * 3;
                uint _193 = uint(_188 + 1);
                int _205 = int(_101[_172].SimulIndices.y) * 3;
                uint _209 = uint(_205 + 1);
                int _219 = int(_101[_172].SimulIndices.z) * 3;
                uint _223 = uint(_219 + 1);
                _166 = _165 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_188))).xy, ClothSimulVertsPositionsNormals.read(uint(_193)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_193)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_188 + 2))).xy, 0.0)).xyz * _101[_172].BaryCoordPos.w)) * _101[_172].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_205))).xy, ClothSimulVertsPositionsNormals.read(uint(_209)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_209)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_205 + 2))).xy, 0.0)).xyz * _101[_172].BaryCoordPos.w)) * _101[_172].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_219))).xy, ClothSimulVertsPositionsNormals.read(uint(_223)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_223)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_219 + 2))).xy, 0.0)).xyz * _101[_172].BaryCoordPos.w)) * ((1.0 - _101[_172].BaryCoordPos.x) - _101[_172].BaryCoordPos.y))) * 1.0);
                _171 = _170 + 1;
            }
            else
            {
                _166 = _165;
                _171 = _170;
            }
            _169 = _182 ? 1.0 : _168;
        }
        float3 _287;
        if ((_170 > 0) && (_168 > 9.9999997473787516355514526367188e-05))
        {
            _287 = _165 * (1.0 / _168);
        }
        else
        {
            _287 = float3(0.0);
        }
        _288 = _287;
    }
    else
    {
        _288 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _290 = float4(in.in_var_ATTRIBUTE4.x);
    int _293 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _307 = float4(in.in_var_ATTRIBUTE4.y);
    int _310 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _326 = float4(in.in_var_ATTRIBUTE4.z);
    int _329 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _345 = float4(in.in_var_ATTRIBUTE4.w);
    int _348 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _360 = (((_290 * BoneMatrices.read(uint(uint(_293)))) + (_307 * BoneMatrices.read(uint(uint(_310))))) + (_326 * BoneMatrices.read(uint(uint(_329))))) + (_345 * BoneMatrices.read(uint(uint(_348))));
    float4 _361 = (((_290 * BoneMatrices.read(uint(uint(_293 + 1)))) + (_307 * BoneMatrices.read(uint(uint(_310 + 1))))) + (_326 * BoneMatrices.read(uint(uint(_329 + 1))))) + (_345 * BoneMatrices.read(uint(uint(_348 + 1))));
    float4 _362 = (((_290 * BoneMatrices.read(uint(uint(_293 + 2)))) + (_307 * BoneMatrices.read(uint(uint(_310 + 2))))) + (_326 * BoneMatrices.read(uint(uint(_329 + 2))))) + (_345 * BoneMatrices.read(uint(uint(_348 + 2))));
    float3x4 _446;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _370 = float4(in.in_var_ATTRIBUTE15.x);
        int _373 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _389 = float4(in.in_var_ATTRIBUTE15.y);
        int _392 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _408 = float4(in.in_var_ATTRIBUTE15.z);
        int _411 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _427 = float4(in.in_var_ATTRIBUTE15.w);
        int _430 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _446 = float3x4((((_360 + (_370 * BoneMatrices.read(uint(uint(_373))))) + (_389 * BoneMatrices.read(uint(uint(_392))))) + (_408 * BoneMatrices.read(uint(uint(_411))))) + (_427 * BoneMatrices.read(uint(uint(_430)))), (((_361 + (_370 * BoneMatrices.read(uint(uint(_373 + 1))))) + (_389 * BoneMatrices.read(uint(uint(_392 + 1))))) + (_408 * BoneMatrices.read(uint(uint(_411 + 1))))) + (_427 * BoneMatrices.read(uint(uint(_430 + 1)))), (((_362 + (_370 * BoneMatrices.read(uint(uint(_373 + 2))))) + (_389 * BoneMatrices.read(uint(uint(_392 + 2))))) + (_408 * BoneMatrices.read(uint(uint(_411 + 2))))) + (_427 * BoneMatrices.read(uint(uint(_430 + 2)))));
    }
    else
    {
        _446 = float3x4(_360, _361, _362);
    }
    spvUnsafeArray<FClothVertex, 1> _99;
    _99 = _100;
    float _627;
    float3x3 _628;
    if (_99[0].SimulIndices.w < 65535u)
    {
        float _458;
        float3 _461;
        float3 _463;
        float _465;
        int _467;
        _458 = _Globals.ClothBlendWeight;
        _461 = float3(0.0);
        _463 = float3(0.0);
        _465 = 0.0;
        _467 = 0;
        float _459;
        float _466;
        float3 _462;
        float3 _464;
        int _468;
        for (int _469 = 0; _469 < 1; _458 = _459, _461 = _462, _463 = _464, _465 = _466, _467 = _468, _469++)
        {
            bool _480 = _99[_469].SimulIndices.w < 65535u;
            if (_480)
            {
                int _486 = int(_99[_469].SimulIndices.x) * 3;
                uint _491 = uint(_486 + 1);
                float3 _500 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_486))).xy, ClothSimulVertsPositionsNormals.read(uint(_491)).x, 1.0)).xyz;
                int _503 = int(_99[_469].SimulIndices.y) * 3;
                uint _507 = uint(_503 + 1);
                float3 _514 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_503))).xy, ClothSimulVertsPositionsNormals.read(uint(_507)).x, 1.0)).xyz;
                int _517 = int(_99[_469].SimulIndices.z) * 3;
                uint _521 = uint(_517 + 1);
                float3 _528 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_517))).xy, ClothSimulVertsPositionsNormals.read(uint(_521)).x, 1.0)).xyz;
                float3 _538 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_491)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_486 + 2))).xy, 0.0)).xyz;
                float3 _548 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_507)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_503 + 2))).xy, 0.0)).xyz;
                float3 _558 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_521)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_517 + 2))).xy, 0.0)).xyz;
                _462 = _461 + (((((_500 + (_538 * _99[_469].BaryCoordNormal.w)) * _99[_469].BaryCoordNormal.x) + ((_514 + (_548 * _99[_469].BaryCoordNormal.w)) * _99[_469].BaryCoordNormal.y)) + ((_528 + (_558 * _99[_469].BaryCoordNormal.w)) * _99[_469].BaryCoordNormal.z)) * 1.0);
                _464 = _463 + (((((_500 + (_538 * _99[_469].BaryCoordTangent.w)) * _99[_469].BaryCoordTangent.x) + ((_514 + (_548 * _99[_469].BaryCoordTangent.w)) * _99[_469].BaryCoordTangent.y)) + ((_528 + (_558 * _99[_469].BaryCoordTangent.w)) * _99[_469].BaryCoordTangent.z)) * 1.0);
                _468 = _467 + 1;
            }
            else
            {
                _462 = _461;
                _464 = _463;
                _468 = _467;
            }
            _459 = _480 ? _Globals.ClothBlendWeight : _458;
            _466 = _480 ? 1.0 : _465;
        }
        bool _595 = (_467 > 0) && (_465 > 9.9999997473787516355514526367188e-05);
        float3x3 _619;
        if (_595)
        {
            float _599 = 1.0 / _465;
            float3x3 _614 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _616 = _97;
            _616[0] = _614 * normalize((_463 * _599) - _288);
            float3x3 _618 = _616;
            _618[2] = _614 * normalize((_461 * _599) - _288);
            _619 = _618;
        }
        else
        {
            _619 = _97;
        }
        float3x3 _626 = _619;
        _626[1] = cross(_619[2], _619[0]) * in.in_var_ATTRIBUTE2.w;
        _627 = _595 ? _458 : 0.0;
        _628 = _626;
    }
    else
    {
        _627 = 0.0;
        _628 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _634 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _446);
    float3 _640 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _446);
    float3 _645 = float3(_627);
    float3 _653 = float3(1.0 - _627);
    float4 _728;
    switch (0u)
    {
        default:
        {
            if (_100[0].SimulIndices.w < 65535u)
            {
                _728 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _446) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _288, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _677 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _446) + in.in_var_ATTRIBUTE12;
                _728 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _677.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _677.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _677.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _742 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _742[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _745 = _742;
    _745[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _748 = _745;
    _748[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _761 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_728.x, _728.y, _728.z, _728.w);
    float4 _772;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_761.z < 0.0))
    {
        float4 _770 = _761;
        _770.z = 9.9999999747524270787835121154785e-07;
        float4 _771 = _770;
        _771.w = 1.0;
        _772 = _771;
    }
    else
    {
        _772 = _761;
    }
    float _778 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_748 * float3x3((_628[0] * _645) + (_634 * _653), (_628[1] * _645) + (normalize(cross(_640, _634) * in.in_var_ATTRIBUTE2.w) * _653), (_628[2] * _645) + (_640 * _653)))[2], _96).xyz));
    out.out_var_TEXCOORD6 = _772.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_778) > 0.0) ? (sqrt(fast::clamp(1.0 - (_778 * _778), 0.0, 1.0)) / _778) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _772;
    return out;
}

