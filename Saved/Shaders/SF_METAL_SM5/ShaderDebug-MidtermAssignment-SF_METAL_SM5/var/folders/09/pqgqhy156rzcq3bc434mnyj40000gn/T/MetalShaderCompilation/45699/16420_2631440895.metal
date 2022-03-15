

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

constant float _101 = {};
constant float3x3 _102 = {};
constant float4 _103 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
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

vertex Main_out Main_00004024_9cd899ff(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _106;
    for (int _128 = 0; _128 < 5; )
    {
        uint _136 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_128)) * 4u;
        _106[_128].BaryCoordPos = GPUSkinApexCloth.read(uint(_136));
        _106[_128].BaryCoordNormal = GPUSkinApexCloth.read(uint((_136 + 1u)));
        _106[_128].BaryCoordTangent = GPUSkinApexCloth.read(uint((_136 + 2u)));
        uint4 _148 = as_type<uint4>(GPUSkinApexCloth.read(uint((_136 + 3u))));
        uint2 _149 = _148.xy;
        uint2 _152 = (_149 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _106[_128].SimulIndices = uint4(_106[_128].SimulIndices.x, _152.x, _106[_128].SimulIndices.z, _152.y);
        uint2 _156 = _149 & uint2(65535u);
        _106[_128].SimulIndices = uint4(_156.x, _106[_128].SimulIndices.y, _156.y, _106[_128].SimulIndices.w);
        _106[_128].Weight = as_type<float>(_148.z);
        _128++;
        continue;
    }
    float3 _297;
    if (_106[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _107;
        _107 = _106;
        float3 _172;
        float _175;
        int _177;
        _172 = float3(0.0);
        _175 = 0.0;
        _177 = 0;
        float3 _173;
        float _176;
        int _178;
        for (int _179 = 0; _179 < 5; _172 = _173, _175 = _176, _177 = _178, _179++)
        {
            if (_107[_179].SimulIndices.w < 65535u)
            {
                int _196 = int(_107[_179].SimulIndices.x) * 3;
                uint _201 = uint(_196 + 1);
                int _213 = int(_107[_179].SimulIndices.y) * 3;
                uint _217 = uint(_213 + 1);
                int _227 = int(_107[_179].SimulIndices.z) * 3;
                uint _231 = uint(_227 + 1);
                _173 = _172 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_196))).xy, ClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_201)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_196 + 2))).xy, 0.0)).xyz * _107[_179].BaryCoordPos.w)) * _107[_179].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, ClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_217)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _107[_179].BaryCoordPos.w)) * _107[_179].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, ClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_231)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _107[_179].BaryCoordPos.w)) * ((1.0 - _107[_179].BaryCoordPos.x) - _107[_179].BaryCoordPos.y))) * _107[_179].Weight);
                _176 = _175 + _107[_179].Weight;
                _178 = _177 + 1;
            }
            else
            {
                _173 = _172;
                _176 = _175;
                _178 = _177;
            }
        }
        float3 _296;
        if ((_177 > 0) && (_175 > 9.9999997473787516355514526367188e-05))
        {
            _296 = _172 * (1.0 / _175);
        }
        else
        {
            _296 = float3(0.0);
        }
        _297 = _296;
    }
    else
    {
        _297 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _299 = float4(in.in_var_ATTRIBUTE4.x);
    int _302 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _316 = float4(in.in_var_ATTRIBUTE4.y);
    int _319 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _335 = float4(in.in_var_ATTRIBUTE4.z);
    int _338 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _354 = float4(in.in_var_ATTRIBUTE4.w);
    int _357 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _369 = (((_299 * BoneMatrices.read(uint(uint(_302)))) + (_316 * BoneMatrices.read(uint(uint(_319))))) + (_335 * BoneMatrices.read(uint(uint(_338))))) + (_354 * BoneMatrices.read(uint(uint(_357))));
    float4 _370 = (((_299 * BoneMatrices.read(uint(uint(_302 + 1)))) + (_316 * BoneMatrices.read(uint(uint(_319 + 1))))) + (_335 * BoneMatrices.read(uint(uint(_338 + 1))))) + (_354 * BoneMatrices.read(uint(uint(_357 + 1))));
    float4 _371 = (((_299 * BoneMatrices.read(uint(uint(_302 + 2)))) + (_316 * BoneMatrices.read(uint(uint(_319 + 2))))) + (_335 * BoneMatrices.read(uint(uint(_338 + 2))))) + (_354 * BoneMatrices.read(uint(uint(_357 + 2))));
    float3x4 _455;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _379 = float4(in.in_var_ATTRIBUTE15.x);
        int _382 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _398 = float4(in.in_var_ATTRIBUTE15.y);
        int _401 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _417 = float4(in.in_var_ATTRIBUTE15.z);
        int _420 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _436 = float4(in.in_var_ATTRIBUTE15.w);
        int _439 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _455 = float3x4((((_369 + (_379 * BoneMatrices.read(uint(uint(_382))))) + (_398 * BoneMatrices.read(uint(uint(_401))))) + (_417 * BoneMatrices.read(uint(uint(_420))))) + (_436 * BoneMatrices.read(uint(uint(_439)))), (((_370 + (_379 * BoneMatrices.read(uint(uint(_382 + 1))))) + (_398 * BoneMatrices.read(uint(uint(_401 + 1))))) + (_417 * BoneMatrices.read(uint(uint(_420 + 1))))) + (_436 * BoneMatrices.read(uint(uint(_439 + 1)))), (((_371 + (_379 * BoneMatrices.read(uint(uint(_382 + 2))))) + (_398 * BoneMatrices.read(uint(uint(_401 + 2))))) + (_417 * BoneMatrices.read(uint(uint(_420 + 2))))) + (_436 * BoneMatrices.read(uint(uint(_439 + 2)))));
    }
    else
    {
        _455 = float3x4(_369, _370, _371);
    }
    spvUnsafeArray<FClothVertex, 5> _105;
    _105 = _106;
    float _638;
    float3x3 _639;
    if (_105[0].SimulIndices.w < 65535u)
    {
        float _467;
        float3 _470;
        float3 _472;
        float _474;
        int _476;
        _467 = _Globals.ClothBlendWeight;
        _470 = float3(0.0);
        _472 = float3(0.0);
        _474 = 0.0;
        _476 = 0;
        float _468;
        float3 _471;
        float3 _473;
        float _475;
        int _477;
        for (int _478 = 0; _478 < 5; _467 = _468, _470 = _471, _472 = _473, _474 = _475, _476 = _477, _478++)
        {
            bool _490 = _105[_478].SimulIndices.w < 65535u;
            if (_490)
            {
                int _496 = int(_105[_478].SimulIndices.x) * 3;
                uint _501 = uint(_496 + 1);
                float3 _510 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_496))).xy, ClothSimulVertsPositionsNormals.read(uint(_501)).x, 1.0)).xyz;
                int _513 = int(_105[_478].SimulIndices.y) * 3;
                uint _517 = uint(_513 + 1);
                float3 _524 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_513))).xy, ClothSimulVertsPositionsNormals.read(uint(_517)).x, 1.0)).xyz;
                int _527 = int(_105[_478].SimulIndices.z) * 3;
                uint _531 = uint(_527 + 1);
                float3 _538 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_527))).xy, ClothSimulVertsPositionsNormals.read(uint(_531)).x, 1.0)).xyz;
                float3 _548 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_501)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_496 + 2))).xy, 0.0)).xyz;
                float3 _558 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_517)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_513 + 2))).xy, 0.0)).xyz;
                float3 _568 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_531)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_527 + 2))).xy, 0.0)).xyz;
                _471 = _470 + (((((_510 + (_548 * _105[_478].BaryCoordNormal.w)) * _105[_478].BaryCoordNormal.x) + ((_524 + (_558 * _105[_478].BaryCoordNormal.w)) * _105[_478].BaryCoordNormal.y)) + ((_538 + (_568 * _105[_478].BaryCoordNormal.w)) * _105[_478].BaryCoordNormal.z)) * _105[_478].Weight);
                _473 = _472 + (((((_510 + (_548 * _105[_478].BaryCoordTangent.w)) * _105[_478].BaryCoordTangent.x) + ((_524 + (_558 * _105[_478].BaryCoordTangent.w)) * _105[_478].BaryCoordTangent.y)) + ((_538 + (_568 * _105[_478].BaryCoordTangent.w)) * _105[_478].BaryCoordTangent.z)) * _105[_478].Weight);
                _475 = _474 + _105[_478].Weight;
                _477 = _476 + 1;
            }
            else
            {
                _471 = _470;
                _473 = _472;
                _475 = _474;
                _477 = _476;
            }
            _468 = _490 ? _Globals.ClothBlendWeight : _467;
        }
        bool _606 = (_476 > 0) && (_474 > 9.9999997473787516355514526367188e-05);
        float3x3 _630;
        if (_606)
        {
            float _610 = 1.0 / _474;
            float3x3 _625 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _627 = _102;
            _627[0] = _625 * normalize((_472 * _610) - _297);
            float3x3 _629 = _627;
            _629[2] = _625 * normalize((_470 * _610) - _297);
            _630 = _629;
        }
        else
        {
            _630 = _102;
        }
        float3x3 _637 = _630;
        _637[1] = cross(_630[2], _630[0]) * in.in_var_ATTRIBUTE2.w;
        _638 = _606 ? _467 : 0.0;
        _639 = _637;
    }
    else
    {
        _638 = 0.0;
        _639 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _645 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _455);
    float3 _651 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _455);
    float3 _656 = float3(_638);
    float3 _664 = float3(1.0 - _638);
    float4 _739;
    switch (0u)
    {
        default:
        {
            if (_106[0].SimulIndices.w < 65535u)
            {
                _739 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _455) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _297, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _688 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _455) + in.in_var_ATTRIBUTE12;
                _739 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _688.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _688.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _688.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _753 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _753[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _756 = _753;
    _756[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _759 = _756;
    _759[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _760 = _759 * float3x3((_639[0] * _656) + (_645 * _664), (_639[1] * _656) + (normalize(cross(_651, _645) * in.in_var_ATTRIBUTE2.w) * _664), (_639[2] * _656) + (_651 * _664));
    float3 _761 = _760[2];
    float _762 = _761.x;
    float4 _768 = _103;
    _768.w = 0.0;
    float3 _769 = _760[0];
    float4 _780 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_739.x, _739.y, _739.z, _739.w);
    out.out_var_TEXCOORD10_centroid = float4(_769.x, _769.y, _769.z, _768.w);
    out.out_var_TEXCOORD11_centroid = float4(_762, _761.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _739.xyz;
    out.out_var_TEXCOORD6 = _780;
    out.out_var_TEXCOORD8 = float4(_762, _761.yz, _101).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _780;
    return out;
}

