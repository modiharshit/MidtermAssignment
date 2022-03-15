

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
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
};

struct type_Globals
{
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    char _m2_pad[64];
    float ClothBlendWeight;
    packed_uint2 GPUSkinApexClothStartIndexOffset;
    uint LayerId;
};

struct FClothVertex
{
    float4 BaryCoordPos;
    float4 BaryCoordNormal;
    float4 BaryCoordTangent;
    uint4 SimulIndices;
    float Weight;
};

constant float _99 = {};
constant float3x3 _100 = {};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
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

vertex Main_out Main_00003da5_dc3f9c99(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _103;
    for (int _125 = 0; _125 < 1; )
    {
        uint _132 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_125)) * 4u;
        _103[_125].BaryCoordPos = GPUSkinApexCloth.read(uint(_132));
        _103[_125].BaryCoordNormal = GPUSkinApexCloth.read(uint((_132 + 1u)));
        _103[_125].BaryCoordTangent = GPUSkinApexCloth.read(uint((_132 + 2u)));
        uint4 _144 = as_type<uint4>(GPUSkinApexCloth.read(uint((_132 + 3u))));
        uint2 _145 = _144.xy;
        uint2 _148 = (_145 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _103[_125].SimulIndices = uint4(_103[_125].SimulIndices.x, _148.x, _103[_125].SimulIndices.z, _148.y);
        uint2 _152 = _145 & uint2(65535u);
        _103[_125].SimulIndices = uint4(_152.x, _103[_125].SimulIndices.y, _152.y, _103[_125].SimulIndices.w);
        _103[_125].Weight = as_type<float>(_144.z);
        _125++;
        continue;
    }
    float3 _291;
    if (_103[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _104;
        _104 = _103;
        float3 _168;
        float _171;
        int _173;
        _168 = float3(0.0);
        _171 = 0.0;
        _173 = 0;
        float _172;
        float3 _169;
        int _174;
        for (int _175 = 0; _175 < 1; _168 = _169, _171 = _172, _173 = _174, _175++)
        {
            bool _185 = _104[_175].SimulIndices.w < 65535u;
            if (_185)
            {
                int _191 = int(_104[_175].SimulIndices.x) * 3;
                uint _196 = uint(_191 + 1);
                int _208 = int(_104[_175].SimulIndices.y) * 3;
                uint _212 = uint(_208 + 1);
                int _222 = int(_104[_175].SimulIndices.z) * 3;
                uint _226 = uint(_222 + 1);
                _169 = _168 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_191))).xy, ClothSimulVertsPositionsNormals.read(uint(_196)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_196)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_191 + 2))).xy, 0.0)).xyz * _104[_175].BaryCoordPos.w)) * _104[_175].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_208))).xy, ClothSimulVertsPositionsNormals.read(uint(_212)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_212)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_208 + 2))).xy, 0.0)).xyz * _104[_175].BaryCoordPos.w)) * _104[_175].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_222))).xy, ClothSimulVertsPositionsNormals.read(uint(_226)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_226)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_222 + 2))).xy, 0.0)).xyz * _104[_175].BaryCoordPos.w)) * ((1.0 - _104[_175].BaryCoordPos.x) - _104[_175].BaryCoordPos.y))) * 1.0);
                _174 = _173 + 1;
            }
            else
            {
                _169 = _168;
                _174 = _173;
            }
            _172 = _185 ? 1.0 : _171;
        }
        float3 _290;
        if ((_173 > 0) && (_171 > 9.9999997473787516355514526367188e-05))
        {
            _290 = _168 * (1.0 / _171);
        }
        else
        {
            _290 = float3(0.0);
        }
        _291 = _290;
    }
    else
    {
        _291 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _293 = float4(in.in_var_ATTRIBUTE4.x);
    int _296 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _310 = float4(in.in_var_ATTRIBUTE4.y);
    int _313 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _329 = float4(in.in_var_ATTRIBUTE4.z);
    int _332 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _348 = float4(in.in_var_ATTRIBUTE4.w);
    int _351 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _363 = (((_293 * BoneMatrices.read(uint(uint(_296)))) + (_310 * BoneMatrices.read(uint(uint(_313))))) + (_329 * BoneMatrices.read(uint(uint(_332))))) + (_348 * BoneMatrices.read(uint(uint(_351))));
    float4 _364 = (((_293 * BoneMatrices.read(uint(uint(_296 + 1)))) + (_310 * BoneMatrices.read(uint(uint(_313 + 1))))) + (_329 * BoneMatrices.read(uint(uint(_332 + 1))))) + (_348 * BoneMatrices.read(uint(uint(_351 + 1))));
    float4 _365 = (((_293 * BoneMatrices.read(uint(uint(_296 + 2)))) + (_310 * BoneMatrices.read(uint(uint(_313 + 2))))) + (_329 * BoneMatrices.read(uint(uint(_332 + 2))))) + (_348 * BoneMatrices.read(uint(uint(_351 + 2))));
    float3x4 _449;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _373 = float4(in.in_var_ATTRIBUTE15.x);
        int _376 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _392 = float4(in.in_var_ATTRIBUTE15.y);
        int _395 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _411 = float4(in.in_var_ATTRIBUTE15.z);
        int _414 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _430 = float4(in.in_var_ATTRIBUTE15.w);
        int _433 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _449 = float3x4((((_363 + (_373 * BoneMatrices.read(uint(uint(_376))))) + (_392 * BoneMatrices.read(uint(uint(_395))))) + (_411 * BoneMatrices.read(uint(uint(_414))))) + (_430 * BoneMatrices.read(uint(uint(_433)))), (((_364 + (_373 * BoneMatrices.read(uint(uint(_376 + 1))))) + (_392 * BoneMatrices.read(uint(uint(_395 + 1))))) + (_411 * BoneMatrices.read(uint(uint(_414 + 1))))) + (_430 * BoneMatrices.read(uint(uint(_433 + 1)))), (((_365 + (_373 * BoneMatrices.read(uint(uint(_376 + 2))))) + (_392 * BoneMatrices.read(uint(uint(_395 + 2))))) + (_411 * BoneMatrices.read(uint(uint(_414 + 2))))) + (_430 * BoneMatrices.read(uint(uint(_433 + 2)))));
    }
    else
    {
        _449 = float3x4(_363, _364, _365);
    }
    spvUnsafeArray<FClothVertex, 1> _102;
    _102 = _103;
    float _630;
    float3x3 _631;
    if (_102[0].SimulIndices.w < 65535u)
    {
        float _461;
        float3 _464;
        float3 _466;
        float _468;
        int _470;
        _461 = _Globals.ClothBlendWeight;
        _464 = float3(0.0);
        _466 = float3(0.0);
        _468 = 0.0;
        _470 = 0;
        float _462;
        float _469;
        float3 _465;
        float3 _467;
        int _471;
        for (int _472 = 0; _472 < 1; _461 = _462, _464 = _465, _466 = _467, _468 = _469, _470 = _471, _472++)
        {
            bool _483 = _102[_472].SimulIndices.w < 65535u;
            if (_483)
            {
                int _489 = int(_102[_472].SimulIndices.x) * 3;
                uint _494 = uint(_489 + 1);
                float3 _503 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_489))).xy, ClothSimulVertsPositionsNormals.read(uint(_494)).x, 1.0)).xyz;
                int _506 = int(_102[_472].SimulIndices.y) * 3;
                uint _510 = uint(_506 + 1);
                float3 _517 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_506))).xy, ClothSimulVertsPositionsNormals.read(uint(_510)).x, 1.0)).xyz;
                int _520 = int(_102[_472].SimulIndices.z) * 3;
                uint _524 = uint(_520 + 1);
                float3 _531 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_520))).xy, ClothSimulVertsPositionsNormals.read(uint(_524)).x, 1.0)).xyz;
                float3 _541 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_494)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_489 + 2))).xy, 0.0)).xyz;
                float3 _551 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_510)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_506 + 2))).xy, 0.0)).xyz;
                float3 _561 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_524)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_520 + 2))).xy, 0.0)).xyz;
                _465 = _464 + (((((_503 + (_541 * _102[_472].BaryCoordNormal.w)) * _102[_472].BaryCoordNormal.x) + ((_517 + (_551 * _102[_472].BaryCoordNormal.w)) * _102[_472].BaryCoordNormal.y)) + ((_531 + (_561 * _102[_472].BaryCoordNormal.w)) * _102[_472].BaryCoordNormal.z)) * 1.0);
                _467 = _466 + (((((_503 + (_541 * _102[_472].BaryCoordTangent.w)) * _102[_472].BaryCoordTangent.x) + ((_517 + (_551 * _102[_472].BaryCoordTangent.w)) * _102[_472].BaryCoordTangent.y)) + ((_531 + (_561 * _102[_472].BaryCoordTangent.w)) * _102[_472].BaryCoordTangent.z)) * 1.0);
                _471 = _470 + 1;
            }
            else
            {
                _465 = _464;
                _467 = _466;
                _471 = _470;
            }
            _462 = _483 ? _Globals.ClothBlendWeight : _461;
            _469 = _483 ? 1.0 : _468;
        }
        bool _598 = (_470 > 0) && (_468 > 9.9999997473787516355514526367188e-05);
        float3x3 _622;
        if (_598)
        {
            float _602 = 1.0 / _468;
            float3x3 _617 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _619 = _100;
            _619[0] = _617 * normalize((_466 * _602) - _291);
            float3x3 _621 = _619;
            _621[2] = _617 * normalize((_464 * _602) - _291);
            _622 = _621;
        }
        else
        {
            _622 = _100;
        }
        float3x3 _629 = _622;
        _629[1] = cross(_622[2], _622[0]) * in.in_var_ATTRIBUTE2.w;
        _630 = _598 ? _461 : 0.0;
        _631 = _629;
    }
    else
    {
        _630 = 0.0;
        _631 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _637 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _449);
    float3 _643 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _449);
    float3 _648 = float3(_630);
    float3 _656 = float3(1.0 - _630);
    float4 _731;
    switch (0u)
    {
        default:
        {
            if (_103[0].SimulIndices.w < 65535u)
            {
                _731 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _449) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _291, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _680 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _449) + in.in_var_ATTRIBUTE12;
                _731 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _680.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _680.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _680.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _745 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _745[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _748 = _745;
    _748[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _751 = _748;
    _751[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _764 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_731.x, _731.y, _731.z, _731.w);
    out.out_var_TEXCOORD6 = float4(_731.x, _731.y, _731.z, _731.w);
    out.out_var_TEXCOORD8 = float4((_751 * float3x3((_631[0] * _648) + (_637 * _656), (_631[1] * _648) + (normalize(cross(_643, _637) * in.in_var_ATTRIBUTE2.w) * _656), (_631[2] * _648) + (_643 * _656)))[2], _99).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _764;
    return out;
}

