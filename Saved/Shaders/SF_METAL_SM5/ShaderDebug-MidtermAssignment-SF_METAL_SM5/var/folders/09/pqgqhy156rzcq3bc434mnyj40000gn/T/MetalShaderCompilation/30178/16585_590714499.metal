

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

constant float _98 = {};
constant float3x3 _99 = {};

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

vertex Main_out Main_000040c9_23359683(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _102;
    for (int _124 = 0; _124 < 5; )
    {
        uint _132 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_124)) * 4u;
        _102[_124].BaryCoordPos = GPUSkinApexCloth.read(uint(_132));
        _102[_124].BaryCoordNormal = GPUSkinApexCloth.read(uint((_132 + 1u)));
        _102[_124].BaryCoordTangent = GPUSkinApexCloth.read(uint((_132 + 2u)));
        uint4 _144 = as_type<uint4>(GPUSkinApexCloth.read(uint((_132 + 3u))));
        uint2 _145 = _144.xy;
        uint2 _148 = (_145 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _102[_124].SimulIndices = uint4(_102[_124].SimulIndices.x, _148.x, _102[_124].SimulIndices.z, _148.y);
        uint2 _152 = _145 & uint2(65535u);
        _102[_124].SimulIndices = uint4(_152.x, _102[_124].SimulIndices.y, _152.y, _102[_124].SimulIndices.w);
        _102[_124].Weight = as_type<float>(_144.z);
        _124++;
        continue;
    }
    float3 _293;
    if (_102[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _103;
        _103 = _102;
        float3 _168;
        float _171;
        int _173;
        _168 = float3(0.0);
        _171 = 0.0;
        _173 = 0;
        float3 _169;
        float _172;
        int _174;
        for (int _175 = 0; _175 < 5; _168 = _169, _171 = _172, _173 = _174, _175++)
        {
            if (_103[_175].SimulIndices.w < 65535u)
            {
                int _192 = int(_103[_175].SimulIndices.x) * 3;
                uint _197 = uint(_192 + 1);
                int _209 = int(_103[_175].SimulIndices.y) * 3;
                uint _213 = uint(_209 + 1);
                int _223 = int(_103[_175].SimulIndices.z) * 3;
                uint _227 = uint(_223 + 1);
                _169 = _168 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_192))).xy, ClothSimulVertsPositionsNormals.read(uint(_197)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_197)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_192 + 2))).xy, 0.0)).xyz * _103[_175].BaryCoordPos.w)) * _103[_175].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_209))).xy, ClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_213)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_209 + 2))).xy, 0.0)).xyz * _103[_175].BaryCoordPos.w)) * _103[_175].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_223))).xy, ClothSimulVertsPositionsNormals.read(uint(_227)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_227)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_223 + 2))).xy, 0.0)).xyz * _103[_175].BaryCoordPos.w)) * ((1.0 - _103[_175].BaryCoordPos.x) - _103[_175].BaryCoordPos.y))) * _103[_175].Weight);
                _172 = _171 + _103[_175].Weight;
                _174 = _173 + 1;
            }
            else
            {
                _169 = _168;
                _172 = _171;
                _174 = _173;
            }
        }
        float3 _292;
        if ((_173 > 0) && (_171 > 9.9999997473787516355514526367188e-05))
        {
            _292 = _168 * (1.0 / _171);
        }
        else
        {
            _292 = float3(0.0);
        }
        _293 = _292;
    }
    else
    {
        _293 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _295 = float4(in.in_var_ATTRIBUTE4.x);
    int _298 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _312 = float4(in.in_var_ATTRIBUTE4.y);
    int _315 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _331 = float4(in.in_var_ATTRIBUTE4.z);
    int _334 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _350 = float4(in.in_var_ATTRIBUTE4.w);
    int _353 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _365 = (((_295 * BoneMatrices.read(uint(uint(_298)))) + (_312 * BoneMatrices.read(uint(uint(_315))))) + (_331 * BoneMatrices.read(uint(uint(_334))))) + (_350 * BoneMatrices.read(uint(uint(_353))));
    float4 _366 = (((_295 * BoneMatrices.read(uint(uint(_298 + 1)))) + (_312 * BoneMatrices.read(uint(uint(_315 + 1))))) + (_331 * BoneMatrices.read(uint(uint(_334 + 1))))) + (_350 * BoneMatrices.read(uint(uint(_353 + 1))));
    float4 _367 = (((_295 * BoneMatrices.read(uint(uint(_298 + 2)))) + (_312 * BoneMatrices.read(uint(uint(_315 + 2))))) + (_331 * BoneMatrices.read(uint(uint(_334 + 2))))) + (_350 * BoneMatrices.read(uint(uint(_353 + 2))));
    float3x4 _451;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _375 = float4(in.in_var_ATTRIBUTE15.x);
        int _378 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _394 = float4(in.in_var_ATTRIBUTE15.y);
        int _397 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _413 = float4(in.in_var_ATTRIBUTE15.z);
        int _416 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _432 = float4(in.in_var_ATTRIBUTE15.w);
        int _435 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _451 = float3x4((((_365 + (_375 * BoneMatrices.read(uint(uint(_378))))) + (_394 * BoneMatrices.read(uint(uint(_397))))) + (_413 * BoneMatrices.read(uint(uint(_416))))) + (_432 * BoneMatrices.read(uint(uint(_435)))), (((_366 + (_375 * BoneMatrices.read(uint(uint(_378 + 1))))) + (_394 * BoneMatrices.read(uint(uint(_397 + 1))))) + (_413 * BoneMatrices.read(uint(uint(_416 + 1))))) + (_432 * BoneMatrices.read(uint(uint(_435 + 1)))), (((_367 + (_375 * BoneMatrices.read(uint(uint(_378 + 2))))) + (_394 * BoneMatrices.read(uint(uint(_397 + 2))))) + (_413 * BoneMatrices.read(uint(uint(_416 + 2))))) + (_432 * BoneMatrices.read(uint(uint(_435 + 2)))));
    }
    else
    {
        _451 = float3x4(_365, _366, _367);
    }
    spvUnsafeArray<FClothVertex, 5> _101;
    _101 = _102;
    float _634;
    float3x3 _635;
    if (_101[0].SimulIndices.w < 65535u)
    {
        float _463;
        float3 _466;
        float3 _468;
        float _470;
        int _472;
        _463 = _Globals.ClothBlendWeight;
        _466 = float3(0.0);
        _468 = float3(0.0);
        _470 = 0.0;
        _472 = 0;
        float _464;
        float3 _467;
        float3 _469;
        float _471;
        int _473;
        for (int _474 = 0; _474 < 5; _463 = _464, _466 = _467, _468 = _469, _470 = _471, _472 = _473, _474++)
        {
            bool _486 = _101[_474].SimulIndices.w < 65535u;
            if (_486)
            {
                int _492 = int(_101[_474].SimulIndices.x) * 3;
                uint _497 = uint(_492 + 1);
                float3 _506 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_492))).xy, ClothSimulVertsPositionsNormals.read(uint(_497)).x, 1.0)).xyz;
                int _509 = int(_101[_474].SimulIndices.y) * 3;
                uint _513 = uint(_509 + 1);
                float3 _520 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_509))).xy, ClothSimulVertsPositionsNormals.read(uint(_513)).x, 1.0)).xyz;
                int _523 = int(_101[_474].SimulIndices.z) * 3;
                uint _527 = uint(_523 + 1);
                float3 _534 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_523))).xy, ClothSimulVertsPositionsNormals.read(uint(_527)).x, 1.0)).xyz;
                float3 _544 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_497)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_492 + 2))).xy, 0.0)).xyz;
                float3 _554 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_513)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_509 + 2))).xy, 0.0)).xyz;
                float3 _564 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_527)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_523 + 2))).xy, 0.0)).xyz;
                _467 = _466 + (((((_506 + (_544 * _101[_474].BaryCoordNormal.w)) * _101[_474].BaryCoordNormal.x) + ((_520 + (_554 * _101[_474].BaryCoordNormal.w)) * _101[_474].BaryCoordNormal.y)) + ((_534 + (_564 * _101[_474].BaryCoordNormal.w)) * _101[_474].BaryCoordNormal.z)) * _101[_474].Weight);
                _469 = _468 + (((((_506 + (_544 * _101[_474].BaryCoordTangent.w)) * _101[_474].BaryCoordTangent.x) + ((_520 + (_554 * _101[_474].BaryCoordTangent.w)) * _101[_474].BaryCoordTangent.y)) + ((_534 + (_564 * _101[_474].BaryCoordTangent.w)) * _101[_474].BaryCoordTangent.z)) * _101[_474].Weight);
                _471 = _470 + _101[_474].Weight;
                _473 = _472 + 1;
            }
            else
            {
                _467 = _466;
                _469 = _468;
                _471 = _470;
                _473 = _472;
            }
            _464 = _486 ? _Globals.ClothBlendWeight : _463;
        }
        bool _602 = (_472 > 0) && (_470 > 9.9999997473787516355514526367188e-05);
        float3x3 _626;
        if (_602)
        {
            float _606 = 1.0 / _470;
            float3x3 _621 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _623 = _99;
            _623[0] = _621 * normalize((_468 * _606) - _293);
            float3x3 _625 = _623;
            _625[2] = _621 * normalize((_466 * _606) - _293);
            _626 = _625;
        }
        else
        {
            _626 = _99;
        }
        float3x3 _633 = _626;
        _633[1] = cross(_626[2], _626[0]) * in.in_var_ATTRIBUTE2.w;
        _634 = _602 ? _463 : 0.0;
        _635 = _633;
    }
    else
    {
        _634 = 0.0;
        _635 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _641 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _451);
    float3 _647 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _451);
    float3 _652 = float3(_634);
    float3 _660 = float3(1.0 - _634);
    float4 _735;
    switch (0u)
    {
        default:
        {
            if (_102[0].SimulIndices.w < 65535u)
            {
                _735 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _451) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _293, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _684 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _451) + in.in_var_ATTRIBUTE12;
                _735 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _684.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _684.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _684.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _749 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _749[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _752 = _749;
    _752[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _755 = _752;
    _755[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _768 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_735.x, _735.y, _735.z, _735.w);
    float4 _779;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_768.z < 0.0))
    {
        float4 _777 = _768;
        _777.z = 9.9999999747524270787835121154785e-07;
        float4 _778 = _777;
        _778.w = 1.0;
        _779 = _778;
    }
    else
    {
        _779 = _768;
    }
    float _785 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_755 * float3x3((_635[0] * _652) + (_641 * _660), (_635[1] * _652) + (normalize(cross(_647, _641) * in.in_var_ATTRIBUTE2.w) * _660), (_635[2] * _652) + (_647 * _660)))[2], _98).xyz));
    out.out_var_TEXCOORD6 = _779.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_785) > 0.0) ? (sqrt(fast::clamp(1.0 - (_785 * _785), 0.0, 1.0)) / _785) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _779;
    return out;
}

