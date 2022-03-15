

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
constant float4 _99 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_000042a3_900731dd(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _102;
    for (int _124 = 0; _124 < 1; )
    {
        uint _131 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_124)) * 4u;
        _102[_124].BaryCoordPos = GPUSkinApexCloth.read(uint(_131));
        _102[_124].BaryCoordNormal = GPUSkinApexCloth.read(uint((_131 + 1u)));
        _102[_124].BaryCoordTangent = GPUSkinApexCloth.read(uint((_131 + 2u)));
        uint4 _143 = as_type<uint4>(GPUSkinApexCloth.read(uint((_131 + 3u))));
        uint2 _144 = _143.xy;
        uint2 _147 = (_144 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _102[_124].SimulIndices = uint4(_102[_124].SimulIndices.x, _147.x, _102[_124].SimulIndices.z, _147.y);
        uint2 _151 = _144 & uint2(65535u);
        _102[_124].SimulIndices = uint4(_151.x, _102[_124].SimulIndices.y, _151.y, _102[_124].SimulIndices.w);
        _102[_124].Weight = as_type<float>(_143.z);
        _124++;
        continue;
    }
    float3 _290;
    if (_102[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _103;
        _103 = _102;
        float3 _167;
        float _170;
        int _172;
        _167 = float3(0.0);
        _170 = 0.0;
        _172 = 0;
        float _171;
        float3 _168;
        int _173;
        for (int _174 = 0; _174 < 1; _167 = _168, _170 = _171, _172 = _173, _174++)
        {
            bool _184 = _103[_174].SimulIndices.w < 65535u;
            if (_184)
            {
                int _190 = int(_103[_174].SimulIndices.x) * 3;
                uint _195 = uint(_190 + 1);
                int _207 = int(_103[_174].SimulIndices.y) * 3;
                uint _211 = uint(_207 + 1);
                int _221 = int(_103[_174].SimulIndices.z) * 3;
                uint _225 = uint(_221 + 1);
                _168 = _167 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_190))).xy, ClothSimulVertsPositionsNormals.read(uint(_195)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_195)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_190 + 2))).xy, 0.0)).xyz * _103[_174].BaryCoordPos.w)) * _103[_174].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_207))).xy, ClothSimulVertsPositionsNormals.read(uint(_211)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_211)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_207 + 2))).xy, 0.0)).xyz * _103[_174].BaryCoordPos.w)) * _103[_174].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_221))).xy, ClothSimulVertsPositionsNormals.read(uint(_225)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_225)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_221 + 2))).xy, 0.0)).xyz * _103[_174].BaryCoordPos.w)) * ((1.0 - _103[_174].BaryCoordPos.x) - _103[_174].BaryCoordPos.y))) * 1.0);
                _173 = _172 + 1;
            }
            else
            {
                _168 = _167;
                _173 = _172;
            }
            _171 = _184 ? 1.0 : _170;
        }
        float3 _289;
        if ((_172 > 0) && (_170 > 9.9999997473787516355514526367188e-05))
        {
            _289 = _167 * (1.0 / _170);
        }
        else
        {
            _289 = float3(0.0);
        }
        _290 = _289;
    }
    else
    {
        _290 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _292 = float4(in.in_var_ATTRIBUTE4.x);
    int _295 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _309 = float4(in.in_var_ATTRIBUTE4.y);
    int _312 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _328 = float4(in.in_var_ATTRIBUTE4.z);
    int _331 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _347 = float4(in.in_var_ATTRIBUTE4.w);
    int _350 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _362 = (((_292 * BoneMatrices.read(uint(uint(_295)))) + (_309 * BoneMatrices.read(uint(uint(_312))))) + (_328 * BoneMatrices.read(uint(uint(_331))))) + (_347 * BoneMatrices.read(uint(uint(_350))));
    float4 _363 = (((_292 * BoneMatrices.read(uint(uint(_295 + 1)))) + (_309 * BoneMatrices.read(uint(uint(_312 + 1))))) + (_328 * BoneMatrices.read(uint(uint(_331 + 1))))) + (_347 * BoneMatrices.read(uint(uint(_350 + 1))));
    float4 _364 = (((_292 * BoneMatrices.read(uint(uint(_295 + 2)))) + (_309 * BoneMatrices.read(uint(uint(_312 + 2))))) + (_328 * BoneMatrices.read(uint(uint(_331 + 2))))) + (_347 * BoneMatrices.read(uint(uint(_350 + 2))));
    float3x4 _448;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _372 = float4(in.in_var_ATTRIBUTE15.x);
        int _375 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _391 = float4(in.in_var_ATTRIBUTE15.y);
        int _394 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _410 = float4(in.in_var_ATTRIBUTE15.z);
        int _413 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _429 = float4(in.in_var_ATTRIBUTE15.w);
        int _432 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _448 = float3x4((((_362 + (_372 * BoneMatrices.read(uint(uint(_375))))) + (_391 * BoneMatrices.read(uint(uint(_394))))) + (_410 * BoneMatrices.read(uint(uint(_413))))) + (_429 * BoneMatrices.read(uint(uint(_432)))), (((_363 + (_372 * BoneMatrices.read(uint(uint(_375 + 1))))) + (_391 * BoneMatrices.read(uint(uint(_394 + 1))))) + (_410 * BoneMatrices.read(uint(uint(_413 + 1))))) + (_429 * BoneMatrices.read(uint(uint(_432 + 1)))), (((_364 + (_372 * BoneMatrices.read(uint(uint(_375 + 2))))) + (_391 * BoneMatrices.read(uint(uint(_394 + 2))))) + (_410 * BoneMatrices.read(uint(uint(_413 + 2))))) + (_429 * BoneMatrices.read(uint(uint(_432 + 2)))));
    }
    else
    {
        _448 = float3x4(_362, _363, _364);
    }
    spvUnsafeArray<FClothVertex, 1> _101;
    _101 = _102;
    float _629;
    float3x3 _630;
    if (_101[0].SimulIndices.w < 65535u)
    {
        float _460;
        float3 _463;
        float3 _465;
        float _467;
        int _469;
        _460 = _Globals.ClothBlendWeight;
        _463 = float3(0.0);
        _465 = float3(0.0);
        _467 = 0.0;
        _469 = 0;
        float _461;
        float _468;
        float3 _464;
        float3 _466;
        int _470;
        for (int _471 = 0; _471 < 1; _460 = _461, _463 = _464, _465 = _466, _467 = _468, _469 = _470, _471++)
        {
            bool _482 = _101[_471].SimulIndices.w < 65535u;
            if (_482)
            {
                int _488 = int(_101[_471].SimulIndices.x) * 3;
                uint _493 = uint(_488 + 1);
                float3 _502 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_488))).xy, ClothSimulVertsPositionsNormals.read(uint(_493)).x, 1.0)).xyz;
                int _505 = int(_101[_471].SimulIndices.y) * 3;
                uint _509 = uint(_505 + 1);
                float3 _516 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_505))).xy, ClothSimulVertsPositionsNormals.read(uint(_509)).x, 1.0)).xyz;
                int _519 = int(_101[_471].SimulIndices.z) * 3;
                uint _523 = uint(_519 + 1);
                float3 _530 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_519))).xy, ClothSimulVertsPositionsNormals.read(uint(_523)).x, 1.0)).xyz;
                float3 _540 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_493)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_488 + 2))).xy, 0.0)).xyz;
                float3 _550 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_509)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_505 + 2))).xy, 0.0)).xyz;
                float3 _560 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_523)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_519 + 2))).xy, 0.0)).xyz;
                _464 = _463 + (((((_502 + (_540 * _101[_471].BaryCoordNormal.w)) * _101[_471].BaryCoordNormal.x) + ((_516 + (_550 * _101[_471].BaryCoordNormal.w)) * _101[_471].BaryCoordNormal.y)) + ((_530 + (_560 * _101[_471].BaryCoordNormal.w)) * _101[_471].BaryCoordNormal.z)) * 1.0);
                _466 = _465 + (((((_502 + (_540 * _101[_471].BaryCoordTangent.w)) * _101[_471].BaryCoordTangent.x) + ((_516 + (_550 * _101[_471].BaryCoordTangent.w)) * _101[_471].BaryCoordTangent.y)) + ((_530 + (_560 * _101[_471].BaryCoordTangent.w)) * _101[_471].BaryCoordTangent.z)) * 1.0);
                _470 = _469 + 1;
            }
            else
            {
                _464 = _463;
                _466 = _465;
                _470 = _469;
            }
            _461 = _482 ? _Globals.ClothBlendWeight : _460;
            _468 = _482 ? 1.0 : _467;
        }
        bool _597 = (_469 > 0) && (_467 > 9.9999997473787516355514526367188e-05);
        float3x3 _621;
        if (_597)
        {
            float _601 = 1.0 / _467;
            float3x3 _616 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _618 = _98;
            _618[0] = _616 * normalize((_465 * _601) - _290);
            float3x3 _620 = _618;
            _620[2] = _616 * normalize((_463 * _601) - _290);
            _621 = _620;
        }
        else
        {
            _621 = _98;
        }
        float3x3 _628 = _621;
        _628[1] = cross(_621[2], _621[0]) * in.in_var_ATTRIBUTE2.w;
        _629 = _597 ? _460 : 0.0;
        _630 = _628;
    }
    else
    {
        _629 = 0.0;
        _630 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _636 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _448);
    float3 _642 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _448);
    float3 _647 = float3(_629);
    float3 _655 = float3(1.0 - _629);
    float4 _730;
    switch (0u)
    {
        default:
        {
            if (_102[0].SimulIndices.w < 65535u)
            {
                _730 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _448) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _290, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _679 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _448) + in.in_var_ATTRIBUTE12;
                _730 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _679.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _679.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _679.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _744 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _744[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _747 = _744;
    _747[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _750 = _747;
    _750[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _751 = _750 * float3x3((_630[0] * _647) + (_636 * _655), (_630[1] * _647) + (normalize(cross(_642, _636) * in.in_var_ATTRIBUTE2.w) * _655), (_630[2] * _647) + (_642 * _655));
    float3 _752 = _751[2];
    float _753 = _752.x;
    float4 _763 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_730.x, _730.y, _730.z, _730.w);
    float4 _774;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_763.z < 0.0))
    {
        float4 _772 = _763;
        _772.z = 9.9999999747524270787835121154785e-07;
        float4 _773 = _772;
        _773.w = 1.0;
        _774 = _773;
    }
    else
    {
        _774 = _763;
    }
    float _780 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_753, _752.yz, _97).xyz));
    float4 _799 = _99;
    _799.w = 0.0;
    float3 _800 = _751[0];
    out.out_var_TEXCOORD10_centroid = float4(_800.x, _800.y, _800.z, _799.w);
    out.out_var_TEXCOORD11_centroid = float4(_753, _752.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _774.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_780) > 0.0) ? (sqrt(fast::clamp(1.0 - (_780 * _780), 0.0, 1.0)) / _780) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _730.xyz;
    out.gl_Position = _774;
    return out;
}

