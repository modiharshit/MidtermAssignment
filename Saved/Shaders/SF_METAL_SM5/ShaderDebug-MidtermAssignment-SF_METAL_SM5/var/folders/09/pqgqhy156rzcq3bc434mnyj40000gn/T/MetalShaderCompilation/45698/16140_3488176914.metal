

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

constant float _103 = {};
constant float3x3 _104 = {};
constant float4 _105 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003f0c_cfe95b12(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _108;
    for (int _127 = 0; _127 < 5; )
    {
        uint _135 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_127)) * 4u;
        _108[_127].BaryCoordPos = GPUSkinApexCloth.read(uint(_135));
        _108[_127].BaryCoordNormal = GPUSkinApexCloth.read(uint((_135 + 1u)));
        _108[_127].BaryCoordTangent = GPUSkinApexCloth.read(uint((_135 + 2u)));
        uint4 _147 = as_type<uint4>(GPUSkinApexCloth.read(uint((_135 + 3u))));
        uint2 _148 = _147.xy;
        uint2 _151 = (_148 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _108[_127].SimulIndices = uint4(_108[_127].SimulIndices.x, _151.x, _108[_127].SimulIndices.z, _151.y);
        uint2 _155 = _148 & uint2(65535u);
        _108[_127].SimulIndices = uint4(_155.x, _108[_127].SimulIndices.y, _155.y, _108[_127].SimulIndices.w);
        _108[_127].Weight = as_type<float>(_147.z);
        _127++;
        continue;
    }
    float3 _296;
    if (_108[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _109;
        _109 = _108;
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
            if (_109[_178].SimulIndices.w < 65535u)
            {
                int _195 = int(_109[_178].SimulIndices.x) * 3;
                uint _200 = uint(_195 + 1);
                int _212 = int(_109[_178].SimulIndices.y) * 3;
                uint _216 = uint(_212 + 1);
                int _226 = int(_109[_178].SimulIndices.z) * 3;
                uint _230 = uint(_226 + 1);
                _172 = _171 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_195))).xy, ClothSimulVertsPositionsNormals.read(uint(_200)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_200)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_195 + 2))).xy, 0.0)).xyz * _109[_178].BaryCoordPos.w)) * _109[_178].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _109[_178].BaryCoordPos.w)) * _109[_178].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_226))).xy, ClothSimulVertsPositionsNormals.read(uint(_230)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_230)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_226 + 2))).xy, 0.0)).xyz * _109[_178].BaryCoordPos.w)) * ((1.0 - _109[_178].BaryCoordPos.x) - _109[_178].BaryCoordPos.y))) * _109[_178].Weight);
                _175 = _174 + _109[_178].Weight;
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
    int _298 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _301 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _307 = int(_301 + (_Globals.InputWeightIndexSize * uint(_298)));
    float3x4 _309;
    _309 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _310;
    for (int _312 = 0; _312 < _298; _309 = _310, _312++)
    {
        int _320 = int(_301 + (_Globals.InputWeightIndexSize * uint(_312)));
        int _325 = int(InputWeightStream.read(uint(uint(_320))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _371 = float4(float(InputWeightStream.read(uint(uint(_307 + _312))).x) * 0.0039215688593685626983642578125);
            int _372 = int((InputWeightStream.read(uint(uint(_320 + 1))).x << 8u) | uint(_325)) * 3;
            _310 = float3x4(_309[0] + (_371 * BoneMatrices.read(uint(uint(_372)))), _309[1] + (_371 * BoneMatrices.read(uint(uint(_372 + 1)))), _309[2] + (_371 * BoneMatrices.read(uint(uint(_372 + 2)))));
        }
        else
        {
            float4 _336 = float4(float(InputWeightStream.read(uint(uint(_307 + _312))).x) * 0.0039215688593685626983642578125);
            int _337 = _325 * 3;
            _310 = float3x4(_309[0] + (_336 * BoneMatrices.read(uint(uint(_337)))), _309[1] + (_336 * BoneMatrices.read(uint(uint(_337 + 1)))), _309[2] + (_336 * BoneMatrices.read(uint(uint(_337 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _107;
    _107 = _108;
    float _574;
    float3x3 _575;
    if (_107[0].SimulIndices.w < 65535u)
    {
        float _403;
        float3 _406;
        float3 _408;
        float _410;
        int _412;
        _403 = _Globals.ClothBlendWeight;
        _406 = float3(0.0);
        _408 = float3(0.0);
        _410 = 0.0;
        _412 = 0;
        float _404;
        float3 _407;
        float3 _409;
        float _411;
        int _413;
        for (int _414 = 0; _414 < 5; _403 = _404, _406 = _407, _408 = _409, _410 = _411, _412 = _413, _414++)
        {
            bool _426 = _107[_414].SimulIndices.w < 65535u;
            if (_426)
            {
                int _432 = int(_107[_414].SimulIndices.x) * 3;
                uint _437 = uint(_432 + 1);
                float3 _446 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_432))).xy, ClothSimulVertsPositionsNormals.read(uint(_437)).x, 1.0)).xyz;
                int _449 = int(_107[_414].SimulIndices.y) * 3;
                uint _453 = uint(_449 + 1);
                float3 _460 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_449))).xy, ClothSimulVertsPositionsNormals.read(uint(_453)).x, 1.0)).xyz;
                int _463 = int(_107[_414].SimulIndices.z) * 3;
                uint _467 = uint(_463 + 1);
                float3 _474 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_463))).xy, ClothSimulVertsPositionsNormals.read(uint(_467)).x, 1.0)).xyz;
                float3 _484 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_437)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_432 + 2))).xy, 0.0)).xyz;
                float3 _494 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_453)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_449 + 2))).xy, 0.0)).xyz;
                float3 _504 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_467)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_463 + 2))).xy, 0.0)).xyz;
                _407 = _406 + (((((_446 + (_484 * _107[_414].BaryCoordNormal.w)) * _107[_414].BaryCoordNormal.x) + ((_460 + (_494 * _107[_414].BaryCoordNormal.w)) * _107[_414].BaryCoordNormal.y)) + ((_474 + (_504 * _107[_414].BaryCoordNormal.w)) * _107[_414].BaryCoordNormal.z)) * _107[_414].Weight);
                _409 = _408 + (((((_446 + (_484 * _107[_414].BaryCoordTangent.w)) * _107[_414].BaryCoordTangent.x) + ((_460 + (_494 * _107[_414].BaryCoordTangent.w)) * _107[_414].BaryCoordTangent.y)) + ((_474 + (_504 * _107[_414].BaryCoordTangent.w)) * _107[_414].BaryCoordTangent.z)) * _107[_414].Weight);
                _411 = _410 + _107[_414].Weight;
                _413 = _412 + 1;
            }
            else
            {
                _407 = _406;
                _409 = _408;
                _411 = _410;
                _413 = _412;
            }
            _404 = _426 ? _Globals.ClothBlendWeight : _403;
        }
        bool _542 = (_412 > 0) && (_410 > 9.9999997473787516355514526367188e-05);
        float3x3 _566;
        if (_542)
        {
            float _546 = 1.0 / _410;
            float3x3 _561 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _563 = _104;
            _563[0] = _561 * normalize((_408 * _546) - _296);
            float3x3 _565 = _563;
            _565[2] = _561 * normalize((_406 * _546) - _296);
            _566 = _565;
        }
        else
        {
            _566 = _104;
        }
        float3x3 _573 = _566;
        _573[1] = cross(_566[2], _566[0]) * in.in_var_ATTRIBUTE2.w;
        _574 = _542 ? _403 : 0.0;
        _575 = _573;
    }
    else
    {
        _574 = 0.0;
        _575 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _581 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _309);
    float3 _587 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _309);
    float3 _592 = float3(_574);
    float3 _600 = float3(1.0 - _574);
    float4 _675;
    switch (0u)
    {
        default:
        {
            if (_108[0].SimulIndices.w < 65535u)
            {
                _675 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _309) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _296, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _624 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _309) + in.in_var_ATTRIBUTE12;
                _675 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _624.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _624.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _624.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _689 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _689[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _692 = _689;
    _692[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _695 = _692;
    _695[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _696 = _695 * float3x3((_575[0] * _592) + (_581 * _600), (_575[1] * _592) + (normalize(cross(_587, _581) * in.in_var_ATTRIBUTE2.w) * _600), (_575[2] * _592) + (_587 * _600));
    float3 _697 = _696[2];
    float _698 = _697.x;
    float4 _708 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_675.x, _675.y, _675.z, _675.w);
    float4 _719;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_708.z < 0.0))
    {
        float4 _717 = _708;
        _717.z = 9.9999999747524270787835121154785e-07;
        float4 _718 = _717;
        _718.w = 1.0;
        _719 = _718;
    }
    else
    {
        _719 = _708;
    }
    float _725 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_698, _697.yz, _103).xyz));
    float4 _744 = _105;
    _744.w = 0.0;
    float3 _745 = _696[0];
    out.out_var_TEXCOORD10_centroid = float4(_745.x, _745.y, _745.z, _744.w);
    out.out_var_TEXCOORD11_centroid = float4(_698, _697.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _719.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_725) > 0.0) ? (sqrt(fast::clamp(1.0 - (_725 * _725), 0.0, 1.0)) / _725) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _675.xyz;
    out.gl_Position = _719;
    return out;
}

