

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
    float4x4 ClothLocalToWorld;
    char _m1_pad[64];
    float ClothBlendWeight;
    uint InputWeightIndexSize;
    uint2 GPUSkinApexClothStartIndexOffset;
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
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003c77_7f79dd2a(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _103;
    for (int _122 = 0; _122 < 1; )
    {
        uint _129 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_122)) * 4u;
        _103[_122].BaryCoordPos = GPUSkinApexCloth.read(uint(_129));
        _103[_122].BaryCoordNormal = GPUSkinApexCloth.read(uint((_129 + 1u)));
        _103[_122].BaryCoordTangent = GPUSkinApexCloth.read(uint((_129 + 2u)));
        uint4 _141 = as_type<uint4>(GPUSkinApexCloth.read(uint((_129 + 3u))));
        uint2 _142 = _141.xy;
        uint2 _145 = (_142 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _103[_122].SimulIndices = uint4(_103[_122].SimulIndices.x, _145.x, _103[_122].SimulIndices.z, _145.y);
        uint2 _149 = _142 & uint2(65535u);
        _103[_122].SimulIndices = uint4(_149.x, _103[_122].SimulIndices.y, _149.y, _103[_122].SimulIndices.w);
        _103[_122].Weight = as_type<float>(_141.z);
        _122++;
        continue;
    }
    float3 _288;
    if (_103[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _104;
        _104 = _103;
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
            bool _182 = _104[_172].SimulIndices.w < 65535u;
            if (_182)
            {
                int _188 = int(_104[_172].SimulIndices.x) * 3;
                uint _193 = uint(_188 + 1);
                int _205 = int(_104[_172].SimulIndices.y) * 3;
                uint _209 = uint(_205 + 1);
                int _219 = int(_104[_172].SimulIndices.z) * 3;
                uint _223 = uint(_219 + 1);
                _166 = _165 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_188))).xy, ClothSimulVertsPositionsNormals.read(uint(_193)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_193)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_188 + 2))).xy, 0.0)).xyz * _104[_172].BaryCoordPos.w)) * _104[_172].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_205))).xy, ClothSimulVertsPositionsNormals.read(uint(_209)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_209)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_205 + 2))).xy, 0.0)).xyz * _104[_172].BaryCoordPos.w)) * _104[_172].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_219))).xy, ClothSimulVertsPositionsNormals.read(uint(_223)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_223)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_219 + 2))).xy, 0.0)).xyz * _104[_172].BaryCoordPos.w)) * ((1.0 - _104[_172].BaryCoordPos.x) - _104[_172].BaryCoordPos.y))) * 1.0);
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
    int _290 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _293 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _299 = int(_293 + (_Globals.InputWeightIndexSize * uint(_290)));
    float3x4 _301;
    _301 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _302;
    for (int _304 = 0; _304 < _290; _301 = _302, _304++)
    {
        int _312 = int(_293 + (_Globals.InputWeightIndexSize * uint(_304)));
        int _317 = int(InputWeightStream.read(uint(uint(_312))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _363 = float4(float(InputWeightStream.read(uint(uint(_299 + _304))).x) * 0.0039215688593685626983642578125);
            int _364 = int((InputWeightStream.read(uint(uint(_312 + 1))).x << 8u) | uint(_317)) * 3;
            _302 = float3x4(_301[0] + (_363 * BoneMatrices.read(uint(uint(_364)))), _301[1] + (_363 * BoneMatrices.read(uint(uint(_364 + 1)))), _301[2] + (_363 * BoneMatrices.read(uint(uint(_364 + 2)))));
        }
        else
        {
            float4 _328 = float4(float(InputWeightStream.read(uint(uint(_299 + _304))).x) * 0.0039215688593685626983642578125);
            int _329 = _317 * 3;
            _302 = float3x4(_301[0] + (_328 * BoneMatrices.read(uint(uint(_329)))), _301[1] + (_328 * BoneMatrices.read(uint(uint(_329 + 1)))), _301[2] + (_328 * BoneMatrices.read(uint(uint(_329 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _102;
    _102 = _103;
    float _564;
    float3x3 _565;
    if (_102[0].SimulIndices.w < 65535u)
    {
        float _395;
        float3 _398;
        float3 _400;
        float _402;
        int _404;
        _395 = _Globals.ClothBlendWeight;
        _398 = float3(0.0);
        _400 = float3(0.0);
        _402 = 0.0;
        _404 = 0;
        float _396;
        float _403;
        float3 _399;
        float3 _401;
        int _405;
        for (int _406 = 0; _406 < 1; _395 = _396, _398 = _399, _400 = _401, _402 = _403, _404 = _405, _406++)
        {
            bool _417 = _102[_406].SimulIndices.w < 65535u;
            if (_417)
            {
                int _423 = int(_102[_406].SimulIndices.x) * 3;
                uint _428 = uint(_423 + 1);
                float3 _437 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_423))).xy, ClothSimulVertsPositionsNormals.read(uint(_428)).x, 1.0)).xyz;
                int _440 = int(_102[_406].SimulIndices.y) * 3;
                uint _444 = uint(_440 + 1);
                float3 _451 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_440))).xy, ClothSimulVertsPositionsNormals.read(uint(_444)).x, 1.0)).xyz;
                int _454 = int(_102[_406].SimulIndices.z) * 3;
                uint _458 = uint(_454 + 1);
                float3 _465 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_454))).xy, ClothSimulVertsPositionsNormals.read(uint(_458)).x, 1.0)).xyz;
                float3 _475 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_428)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_423 + 2))).xy, 0.0)).xyz;
                float3 _485 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_444)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_440 + 2))).xy, 0.0)).xyz;
                float3 _495 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_458)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_454 + 2))).xy, 0.0)).xyz;
                _399 = _398 + (((((_437 + (_475 * _102[_406].BaryCoordNormal.w)) * _102[_406].BaryCoordNormal.x) + ((_451 + (_485 * _102[_406].BaryCoordNormal.w)) * _102[_406].BaryCoordNormal.y)) + ((_465 + (_495 * _102[_406].BaryCoordNormal.w)) * _102[_406].BaryCoordNormal.z)) * 1.0);
                _401 = _400 + (((((_437 + (_475 * _102[_406].BaryCoordTangent.w)) * _102[_406].BaryCoordTangent.x) + ((_451 + (_485 * _102[_406].BaryCoordTangent.w)) * _102[_406].BaryCoordTangent.y)) + ((_465 + (_495 * _102[_406].BaryCoordTangent.w)) * _102[_406].BaryCoordTangent.z)) * 1.0);
                _405 = _404 + 1;
            }
            else
            {
                _399 = _398;
                _401 = _400;
                _405 = _404;
            }
            _396 = _417 ? _Globals.ClothBlendWeight : _395;
            _403 = _417 ? 1.0 : _402;
        }
        bool _532 = (_404 > 0) && (_402 > 9.9999997473787516355514526367188e-05);
        float3x3 _556;
        if (_532)
        {
            float _536 = 1.0 / _402;
            float3x3 _551 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _553 = _100;
            _553[0] = _551 * normalize((_400 * _536) - _288);
            float3x3 _555 = _553;
            _555[2] = _551 * normalize((_398 * _536) - _288);
            _556 = _555;
        }
        else
        {
            _556 = _100;
        }
        float3x3 _563 = _556;
        _563[1] = cross(_556[2], _556[0]) * in.in_var_ATTRIBUTE2.w;
        _564 = _532 ? _395 : 0.0;
        _565 = _563;
    }
    else
    {
        _564 = 0.0;
        _565 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _571 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _301);
    float3 _577 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _301);
    float3 _582 = float3(_564);
    float3 _590 = float3(1.0 - _564);
    float4 _665;
    switch (0u)
    {
        default:
        {
            if (_103[0].SimulIndices.w < 65535u)
            {
                _665 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _301) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _288, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _614 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _301) + in.in_var_ATTRIBUTE12;
                _665 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _614.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _614.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _614.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _679 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _679[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _682 = _679;
    _682[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _685 = _682;
    _685[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _698 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_665.x, _665.y, _665.z, _665.w);
    float4 _709;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_698.z < 0.0))
    {
        float4 _707 = _698;
        _707.z = 9.9999999747524270787835121154785e-07;
        float4 _708 = _707;
        _708.w = 1.0;
        _709 = _708;
    }
    else
    {
        _709 = _698;
    }
    float _715 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_685 * float3x3((_565[0] * _582) + (_571 * _590), (_565[1] * _582) + (normalize(cross(_577, _571) * in.in_var_ATTRIBUTE2.w) * _590), (_565[2] * _582) + (_577 * _590)))[2], _99).xyz));
    float4 _740 = _709;
    _740.z = ((_709.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_715) > 0.0) ? (sqrt(fast::clamp(1.0 - (_715 * _715), 0.0, 1.0)) / _715) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _709.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _740;
    return out;
}

