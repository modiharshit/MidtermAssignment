

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

vertex Main_out Main_00003e10_99da97ad(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _105;
    for (int _127 = 0; _127 < 5; )
    {
        uint _135 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_127)) * 4u;
        _105[_127].BaryCoordPos = GPUSkinApexCloth.read(uint(_135));
        _105[_127].BaryCoordNormal = GPUSkinApexCloth.read(uint((_135 + 1u)));
        _105[_127].BaryCoordTangent = GPUSkinApexCloth.read(uint((_135 + 2u)));
        uint4 _147 = as_type<uint4>(GPUSkinApexCloth.read(uint((_135 + 3u))));
        uint2 _148 = _147.xy;
        uint2 _151 = (_148 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _105[_127].SimulIndices = uint4(_105[_127].SimulIndices.x, _151.x, _105[_127].SimulIndices.z, _151.y);
        uint2 _155 = _148 & uint2(65535u);
        _105[_127].SimulIndices = uint4(_155.x, _105[_127].SimulIndices.y, _155.y, _105[_127].SimulIndices.w);
        _105[_127].Weight = as_type<float>(_147.z);
        _127++;
        continue;
    }
    float3 _296;
    if (_105[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _106;
        _106 = _105;
        float3 _171;
        float _174;
        int _176;
        _171 = float3(0.0);
        _174 = 0.0;
        _176 = 0;
        float3 _172;
        float _175;
        int _177;
        for (int _178 = 0; _178 < 5; _171 = _172, _174 = _175, _176 = _177, _178++)
        {
            if (_106[_178].SimulIndices.w < 65535u)
            {
                int _195 = int(_106[_178].SimulIndices.x) * 3;
                uint _200 = uint(_195 + 1);
                int _212 = int(_106[_178].SimulIndices.y) * 3;
                uint _216 = uint(_212 + 1);
                int _226 = int(_106[_178].SimulIndices.z) * 3;
                uint _230 = uint(_226 + 1);
                _172 = _171 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_195))).xy, ClothSimulVertsPositionsNormals.read(uint(_200)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_200)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_195 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * _106[_178].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * _106[_178].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_226))).xy, ClothSimulVertsPositionsNormals.read(uint(_230)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_230)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_226 + 2))).xy, 0.0)).xyz * _106[_178].BaryCoordPos.w)) * ((1.0 - _106[_178].BaryCoordPos.x) - _106[_178].BaryCoordPos.y))) * _106[_178].Weight);
                _175 = _174 + _106[_178].Weight;
                _177 = _176 + 1;
            }
            else
            {
                _172 = _171;
                _175 = _174;
                _177 = _176;
            }
        }
        float3 _295;
        if ((_176 > 0) && (_174 > 9.9999997473787516355514526367188e-05))
        {
            _295 = _171 * (1.0 / _174);
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
    spvUnsafeArray<FClothVertex, 5> _104;
    _104 = _105;
    float _637;
    float3x3 _638;
    if (_104[0].SimulIndices.w < 65535u)
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
        float3 _470;
        float3 _472;
        float _474;
        int _476;
        for (int _477 = 0; _477 < 5; _466 = _467, _469 = _470, _471 = _472, _473 = _474, _475 = _476, _477++)
        {
            bool _489 = _104[_477].SimulIndices.w < 65535u;
            if (_489)
            {
                int _495 = int(_104[_477].SimulIndices.x) * 3;
                uint _500 = uint(_495 + 1);
                float3 _509 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_495))).xy, ClothSimulVertsPositionsNormals.read(uint(_500)).x, 1.0)).xyz;
                int _512 = int(_104[_477].SimulIndices.y) * 3;
                uint _516 = uint(_512 + 1);
                float3 _523 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_512))).xy, ClothSimulVertsPositionsNormals.read(uint(_516)).x, 1.0)).xyz;
                int _526 = int(_104[_477].SimulIndices.z) * 3;
                uint _530 = uint(_526 + 1);
                float3 _537 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_526))).xy, ClothSimulVertsPositionsNormals.read(uint(_530)).x, 1.0)).xyz;
                float3 _547 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_500)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_495 + 2))).xy, 0.0)).xyz;
                float3 _557 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_516)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_512 + 2))).xy, 0.0)).xyz;
                float3 _567 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_530)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_526 + 2))).xy, 0.0)).xyz;
                _470 = _469 + (((((_509 + (_547 * _104[_477].BaryCoordNormal.w)) * _104[_477].BaryCoordNormal.x) + ((_523 + (_557 * _104[_477].BaryCoordNormal.w)) * _104[_477].BaryCoordNormal.y)) + ((_537 + (_567 * _104[_477].BaryCoordNormal.w)) * _104[_477].BaryCoordNormal.z)) * _104[_477].Weight);
                _472 = _471 + (((((_509 + (_547 * _104[_477].BaryCoordTangent.w)) * _104[_477].BaryCoordTangent.x) + ((_523 + (_557 * _104[_477].BaryCoordTangent.w)) * _104[_477].BaryCoordTangent.y)) + ((_537 + (_567 * _104[_477].BaryCoordTangent.w)) * _104[_477].BaryCoordTangent.z)) * _104[_477].Weight);
                _474 = _473 + _104[_477].Weight;
                _476 = _475 + 1;
            }
            else
            {
                _470 = _469;
                _472 = _471;
                _474 = _473;
                _476 = _475;
            }
            _467 = _489 ? _Globals.ClothBlendWeight : _466;
        }
        bool _605 = (_475 > 0) && (_473 > 9.9999997473787516355514526367188e-05);
        float3x3 _629;
        if (_605)
        {
            float _609 = 1.0 / _473;
            float3x3 _624 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _626 = _102;
            _626[0] = _624 * normalize((_471 * _609) - _296);
            float3x3 _628 = _626;
            _628[2] = _624 * normalize((_469 * _609) - _296);
            _629 = _628;
        }
        else
        {
            _629 = _102;
        }
        float3x3 _636 = _629;
        _636[1] = cross(_629[2], _629[0]) * in.in_var_ATTRIBUTE2.w;
        _637 = _605 ? _466 : 0.0;
        _638 = _636;
    }
    else
    {
        _637 = 0.0;
        _638 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _644 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _454);
    float3 _650 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _454);
    float3 _655 = float3(_637);
    float3 _663 = float3(1.0 - _637);
    float4 _738;
    switch (0u)
    {
        default:
        {
            if (_105[0].SimulIndices.w < 65535u)
            {
                _738 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _454) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _296, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _687 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _454) + in.in_var_ATTRIBUTE12;
                _738 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _687.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _687.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _687.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _752 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _752[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _755 = _752;
    _755[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _758 = _755;
    _758[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _771 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_738.x, _738.y, _738.z, _738.w);
    out.out_var_TEXCOORD6 = float4(_738.x, _738.y, _738.z, _738.w);
    out.out_var_TEXCOORD8 = float4((_758 * float3x3((_638[0] * _655) + (_644 * _663), (_638[1] * _655) + (normalize(cross(_650, _644) * in.in_var_ATTRIBUTE2.w) * _663), (_638[2] * _655) + (_650 * _663)))[2], _101).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _771;
    return out;
}

