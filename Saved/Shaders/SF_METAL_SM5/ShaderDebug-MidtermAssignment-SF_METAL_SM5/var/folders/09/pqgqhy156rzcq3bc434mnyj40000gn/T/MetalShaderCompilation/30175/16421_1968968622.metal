

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

constant spvUnsafeArray<float2, 1> _93 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _98 = {};
constant float4 _99 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
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

vertex Main_out Main_00004025_755c13ae(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _103;
    for (int _129 = 0; _129 < 1; )
    {
        uint _136 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_129)) * 4u;
        _103[_129].BaryCoordPos = GPUSkinApexCloth.read(uint(_136));
        _103[_129].BaryCoordNormal = GPUSkinApexCloth.read(uint((_136 + 1u)));
        _103[_129].BaryCoordTangent = GPUSkinApexCloth.read(uint((_136 + 2u)));
        uint4 _148 = as_type<uint4>(GPUSkinApexCloth.read(uint((_136 + 3u))));
        uint2 _149 = _148.xy;
        uint2 _152 = (_149 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _103[_129].SimulIndices = uint4(_103[_129].SimulIndices.x, _152.x, _103[_129].SimulIndices.z, _152.y);
        uint2 _156 = _149 & uint2(65535u);
        _103[_129].SimulIndices = uint4(_156.x, _103[_129].SimulIndices.y, _156.y, _103[_129].SimulIndices.w);
        _103[_129].Weight = as_type<float>(_148.z);
        _129++;
        continue;
    }
    float3 _295;
    if (_103[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _105;
        _105 = _103;
        float3 _172;
        float _175;
        int _177;
        _172 = float3(0.0);
        _175 = 0.0;
        _177 = 0;
        float _176;
        float3 _173;
        int _178;
        for (int _179 = 0; _179 < 1; _172 = _173, _175 = _176, _177 = _178, _179++)
        {
            bool _189 = _105[_179].SimulIndices.w < 65535u;
            if (_189)
            {
                int _195 = int(_105[_179].SimulIndices.x) * 3;
                uint _200 = uint(_195 + 1);
                int _212 = int(_105[_179].SimulIndices.y) * 3;
                uint _216 = uint(_212 + 1);
                int _226 = int(_105[_179].SimulIndices.z) * 3;
                uint _230 = uint(_226 + 1);
                _173 = _172 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_195))).xy, ClothSimulVertsPositionsNormals.read(uint(_200)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_200)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_195 + 2))).xy, 0.0)).xyz * _105[_179].BaryCoordPos.w)) * _105[_179].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _105[_179].BaryCoordPos.w)) * _105[_179].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_226))).xy, ClothSimulVertsPositionsNormals.read(uint(_230)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_230)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_226 + 2))).xy, 0.0)).xyz * _105[_179].BaryCoordPos.w)) * ((1.0 - _105[_179].BaryCoordPos.x) - _105[_179].BaryCoordPos.y))) * 1.0);
                _178 = _177 + 1;
            }
            else
            {
                _173 = _172;
                _178 = _177;
            }
            _176 = _189 ? 1.0 : _175;
        }
        float3 _294;
        if ((_177 > 0) && (_175 > 9.9999997473787516355514526367188e-05))
        {
            _294 = _172 * (1.0 / _175);
        }
        else
        {
            _294 = float3(0.0);
        }
        _295 = _294;
    }
    else
    {
        _295 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _297 = float4(in.in_var_ATTRIBUTE4.x);
    int _300 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _314 = float4(in.in_var_ATTRIBUTE4.y);
    int _317 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _333 = float4(in.in_var_ATTRIBUTE4.z);
    int _336 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _352 = float4(in.in_var_ATTRIBUTE4.w);
    int _355 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _367 = (((_297 * BoneMatrices.read(uint(uint(_300)))) + (_314 * BoneMatrices.read(uint(uint(_317))))) + (_333 * BoneMatrices.read(uint(uint(_336))))) + (_352 * BoneMatrices.read(uint(uint(_355))));
    float4 _368 = (((_297 * BoneMatrices.read(uint(uint(_300 + 1)))) + (_314 * BoneMatrices.read(uint(uint(_317 + 1))))) + (_333 * BoneMatrices.read(uint(uint(_336 + 1))))) + (_352 * BoneMatrices.read(uint(uint(_355 + 1))));
    float4 _369 = (((_297 * BoneMatrices.read(uint(uint(_300 + 2)))) + (_314 * BoneMatrices.read(uint(uint(_317 + 2))))) + (_333 * BoneMatrices.read(uint(uint(_336 + 2))))) + (_352 * BoneMatrices.read(uint(uint(_355 + 2))));
    float3x4 _453;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _377 = float4(in.in_var_ATTRIBUTE15.x);
        int _380 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _396 = float4(in.in_var_ATTRIBUTE15.y);
        int _399 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _415 = float4(in.in_var_ATTRIBUTE15.z);
        int _418 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _434 = float4(in.in_var_ATTRIBUTE15.w);
        int _437 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _453 = float3x4((((_367 + (_377 * BoneMatrices.read(uint(uint(_380))))) + (_396 * BoneMatrices.read(uint(uint(_399))))) + (_415 * BoneMatrices.read(uint(uint(_418))))) + (_434 * BoneMatrices.read(uint(uint(_437)))), (((_368 + (_377 * BoneMatrices.read(uint(uint(_380 + 1))))) + (_396 * BoneMatrices.read(uint(uint(_399 + 1))))) + (_415 * BoneMatrices.read(uint(uint(_418 + 1))))) + (_434 * BoneMatrices.read(uint(uint(_437 + 1)))), (((_369 + (_377 * BoneMatrices.read(uint(uint(_380 + 2))))) + (_396 * BoneMatrices.read(uint(uint(_399 + 2))))) + (_415 * BoneMatrices.read(uint(uint(_418 + 2))))) + (_434 * BoneMatrices.read(uint(uint(_437 + 2)))));
    }
    else
    {
        _453 = float3x4(_367, _368, _369);
    }
    spvUnsafeArray<FClothVertex, 1> _102;
    _102 = _103;
    float _634;
    float3x3 _635;
    if (_102[0].SimulIndices.w < 65535u)
    {
        float _465;
        float3 _468;
        float3 _470;
        float _472;
        int _474;
        _465 = _Globals.ClothBlendWeight;
        _468 = float3(0.0);
        _470 = float3(0.0);
        _472 = 0.0;
        _474 = 0;
        float _466;
        float _473;
        float3 _469;
        float3 _471;
        int _475;
        for (int _476 = 0; _476 < 1; _465 = _466, _468 = _469, _470 = _471, _472 = _473, _474 = _475, _476++)
        {
            bool _487 = _102[_476].SimulIndices.w < 65535u;
            if (_487)
            {
                int _493 = int(_102[_476].SimulIndices.x) * 3;
                uint _498 = uint(_493 + 1);
                float3 _507 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_493))).xy, ClothSimulVertsPositionsNormals.read(uint(_498)).x, 1.0)).xyz;
                int _510 = int(_102[_476].SimulIndices.y) * 3;
                uint _514 = uint(_510 + 1);
                float3 _521 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_510))).xy, ClothSimulVertsPositionsNormals.read(uint(_514)).x, 1.0)).xyz;
                int _524 = int(_102[_476].SimulIndices.z) * 3;
                uint _528 = uint(_524 + 1);
                float3 _535 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_524))).xy, ClothSimulVertsPositionsNormals.read(uint(_528)).x, 1.0)).xyz;
                float3 _545 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_498)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_493 + 2))).xy, 0.0)).xyz;
                float3 _555 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_514)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_510 + 2))).xy, 0.0)).xyz;
                float3 _565 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_528)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_524 + 2))).xy, 0.0)).xyz;
                _469 = _468 + (((((_507 + (_545 * _102[_476].BaryCoordNormal.w)) * _102[_476].BaryCoordNormal.x) + ((_521 + (_555 * _102[_476].BaryCoordNormal.w)) * _102[_476].BaryCoordNormal.y)) + ((_535 + (_565 * _102[_476].BaryCoordNormal.w)) * _102[_476].BaryCoordNormal.z)) * 1.0);
                _471 = _470 + (((((_507 + (_545 * _102[_476].BaryCoordTangent.w)) * _102[_476].BaryCoordTangent.x) + ((_521 + (_555 * _102[_476].BaryCoordTangent.w)) * _102[_476].BaryCoordTangent.y)) + ((_535 + (_565 * _102[_476].BaryCoordTangent.w)) * _102[_476].BaryCoordTangent.z)) * 1.0);
                _475 = _474 + 1;
            }
            else
            {
                _469 = _468;
                _471 = _470;
                _475 = _474;
            }
            _466 = _487 ? _Globals.ClothBlendWeight : _465;
            _473 = _487 ? 1.0 : _472;
        }
        bool _602 = (_474 > 0) && (_472 > 9.9999997473787516355514526367188e-05);
        float3x3 _626;
        if (_602)
        {
            float _606 = 1.0 / _472;
            float3x3 _621 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _623 = _98;
            _623[0] = _621 * normalize((_470 * _606) - _295);
            float3x3 _625 = _623;
            _625[2] = _621 * normalize((_468 * _606) - _295);
            _626 = _625;
        }
        else
        {
            _626 = _98;
        }
        float3x3 _633 = _626;
        _633[1] = cross(_626[2], _626[0]) * in.in_var_ATTRIBUTE2.w;
        _634 = _602 ? _465 : 0.0;
        _635 = _633;
    }
    else
    {
        _634 = 0.0;
        _635 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _641 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _453);
    float3 _647 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _453);
    float3 _652 = float3(_634);
    float3 _660 = float3(1.0 - _634);
    float4 _735;
    switch (0u)
    {
        default:
        {
            if (_103[0].SimulIndices.w < 65535u)
            {
                _735 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _295, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _684 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12;
                _735 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _684.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _684.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _684.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _101;
    _101 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _104 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _737 = 0; _737 < 1; )
    {
        _104[_737] = _101[_737];
        _737++;
        continue;
    }
    float4 _747 = View.View_TranslatedWorldToClip * float4(_735.x, _735.y, _735.z, _735.w);
    float4 _750 = _99;
    _750.w = 0.0;
    float3x3 _764 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _764[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _767 = _764;
    _767[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _770 = _767;
    _770[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _771 = _770 * float3x3((_635[0] * _652) + (_641 * _660), (_635[1] * _652) + (normalize(cross(_647, _641) * in.in_var_ATTRIBUTE2.w) * _660), (_635[2] * _652) + (_647 * _660));
    float3 _772 = _771[0];
    spvUnsafeArray<float4, 1> _782 = { float4(_104[0].x, _104[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_772.x, _772.y, _772.z, _750.w);
    out.out_var_TEXCOORD11_centroid = float4(_771[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _782;
    out.gl_Position = _747;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

