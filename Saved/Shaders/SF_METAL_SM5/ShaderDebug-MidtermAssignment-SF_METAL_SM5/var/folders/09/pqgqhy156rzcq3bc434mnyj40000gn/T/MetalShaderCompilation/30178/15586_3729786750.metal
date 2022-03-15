

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

constant float _101 = {};
constant float3x3 _102 = {};

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

vertex Main_out Main_00003ce2_de50077e(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _105;
    for (int _124 = 0; _124 < 5; )
    {
        uint _132 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_124)) * 4u;
        _105[_124].BaryCoordPos = GPUSkinApexCloth.read(uint(_132));
        _105[_124].BaryCoordNormal = GPUSkinApexCloth.read(uint((_132 + 1u)));
        _105[_124].BaryCoordTangent = GPUSkinApexCloth.read(uint((_132 + 2u)));
        uint4 _144 = as_type<uint4>(GPUSkinApexCloth.read(uint((_132 + 3u))));
        uint2 _145 = _144.xy;
        uint2 _148 = (_145 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _105[_124].SimulIndices = uint4(_105[_124].SimulIndices.x, _148.x, _105[_124].SimulIndices.z, _148.y);
        uint2 _152 = _145 & uint2(65535u);
        _105[_124].SimulIndices = uint4(_152.x, _105[_124].SimulIndices.y, _152.y, _105[_124].SimulIndices.w);
        _105[_124].Weight = as_type<float>(_144.z);
        _124++;
        continue;
    }
    float3 _293;
    if (_105[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _106;
        _106 = _105;
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
            if (_106[_175].SimulIndices.w < 65535u)
            {
                int _192 = int(_106[_175].SimulIndices.x) * 3;
                uint _197 = uint(_192 + 1);
                int _209 = int(_106[_175].SimulIndices.y) * 3;
                uint _213 = uint(_209 + 1);
                int _223 = int(_106[_175].SimulIndices.z) * 3;
                uint _227 = uint(_223 + 1);
                _169 = _168 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_192))).xy, ClothSimulVertsPositionsNormals.read(uint(_197)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_197)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_192 + 2))).xy, 0.0)).xyz * _106[_175].BaryCoordPos.w)) * _106[_175].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_209))).xy, ClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_213)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_209 + 2))).xy, 0.0)).xyz * _106[_175].BaryCoordPos.w)) * _106[_175].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_223))).xy, ClothSimulVertsPositionsNormals.read(uint(_227)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_227)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_223 + 2))).xy, 0.0)).xyz * _106[_175].BaryCoordPos.w)) * ((1.0 - _106[_175].BaryCoordPos.x) - _106[_175].BaryCoordPos.y))) * _106[_175].Weight);
                _172 = _171 + _106[_175].Weight;
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
    int _295 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _298 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _304 = int(_298 + (_Globals.InputWeightIndexSize * uint(_295)));
    float3x4 _306;
    _306 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _307;
    for (int _309 = 0; _309 < _295; _306 = _307, _309++)
    {
        int _317 = int(_298 + (_Globals.InputWeightIndexSize * uint(_309)));
        int _322 = int(InputWeightStream.read(uint(uint(_317))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _368 = float4(float(InputWeightStream.read(uint(uint(_304 + _309))).x) * 0.0039215688593685626983642578125);
            int _369 = int((InputWeightStream.read(uint(uint(_317 + 1))).x << 8u) | uint(_322)) * 3;
            _307 = float3x4(_306[0] + (_368 * BoneMatrices.read(uint(uint(_369)))), _306[1] + (_368 * BoneMatrices.read(uint(uint(_369 + 1)))), _306[2] + (_368 * BoneMatrices.read(uint(uint(_369 + 2)))));
        }
        else
        {
            float4 _333 = float4(float(InputWeightStream.read(uint(uint(_304 + _309))).x) * 0.0039215688593685626983642578125);
            int _334 = _322 * 3;
            _307 = float3x4(_306[0] + (_333 * BoneMatrices.read(uint(uint(_334)))), _306[1] + (_333 * BoneMatrices.read(uint(uint(_334 + 1)))), _306[2] + (_333 * BoneMatrices.read(uint(uint(_334 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _104;
    _104 = _105;
    float _571;
    float3x3 _572;
    if (_104[0].SimulIndices.w < 65535u)
    {
        float _400;
        float3 _403;
        float3 _405;
        float _407;
        int _409;
        _400 = _Globals.ClothBlendWeight;
        _403 = float3(0.0);
        _405 = float3(0.0);
        _407 = 0.0;
        _409 = 0;
        float _401;
        float3 _404;
        float3 _406;
        float _408;
        int _410;
        for (int _411 = 0; _411 < 5; _400 = _401, _403 = _404, _405 = _406, _407 = _408, _409 = _410, _411++)
        {
            bool _423 = _104[_411].SimulIndices.w < 65535u;
            if (_423)
            {
                int _429 = int(_104[_411].SimulIndices.x) * 3;
                uint _434 = uint(_429 + 1);
                float3 _443 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_429))).xy, ClothSimulVertsPositionsNormals.read(uint(_434)).x, 1.0)).xyz;
                int _446 = int(_104[_411].SimulIndices.y) * 3;
                uint _450 = uint(_446 + 1);
                float3 _457 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_446))).xy, ClothSimulVertsPositionsNormals.read(uint(_450)).x, 1.0)).xyz;
                int _460 = int(_104[_411].SimulIndices.z) * 3;
                uint _464 = uint(_460 + 1);
                float3 _471 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_460))).xy, ClothSimulVertsPositionsNormals.read(uint(_464)).x, 1.0)).xyz;
                float3 _481 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_434)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_429 + 2))).xy, 0.0)).xyz;
                float3 _491 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_450)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_446 + 2))).xy, 0.0)).xyz;
                float3 _501 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_464)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_460 + 2))).xy, 0.0)).xyz;
                _404 = _403 + (((((_443 + (_481 * _104[_411].BaryCoordNormal.w)) * _104[_411].BaryCoordNormal.x) + ((_457 + (_491 * _104[_411].BaryCoordNormal.w)) * _104[_411].BaryCoordNormal.y)) + ((_471 + (_501 * _104[_411].BaryCoordNormal.w)) * _104[_411].BaryCoordNormal.z)) * _104[_411].Weight);
                _406 = _405 + (((((_443 + (_481 * _104[_411].BaryCoordTangent.w)) * _104[_411].BaryCoordTangent.x) + ((_457 + (_491 * _104[_411].BaryCoordTangent.w)) * _104[_411].BaryCoordTangent.y)) + ((_471 + (_501 * _104[_411].BaryCoordTangent.w)) * _104[_411].BaryCoordTangent.z)) * _104[_411].Weight);
                _408 = _407 + _104[_411].Weight;
                _410 = _409 + 1;
            }
            else
            {
                _404 = _403;
                _406 = _405;
                _408 = _407;
                _410 = _409;
            }
            _401 = _423 ? _Globals.ClothBlendWeight : _400;
        }
        bool _539 = (_409 > 0) && (_407 > 9.9999997473787516355514526367188e-05);
        float3x3 _563;
        if (_539)
        {
            float _543 = 1.0 / _407;
            float3x3 _558 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _560 = _102;
            _560[0] = _558 * normalize((_405 * _543) - _293);
            float3x3 _562 = _560;
            _562[2] = _558 * normalize((_403 * _543) - _293);
            _563 = _562;
        }
        else
        {
            _563 = _102;
        }
        float3x3 _570 = _563;
        _570[1] = cross(_563[2], _563[0]) * in.in_var_ATTRIBUTE2.w;
        _571 = _539 ? _400 : 0.0;
        _572 = _570;
    }
    else
    {
        _571 = 0.0;
        _572 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _578 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _306);
    float3 _584 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _306);
    float3 _589 = float3(_571);
    float3 _597 = float3(1.0 - _571);
    float4 _672;
    switch (0u)
    {
        default:
        {
            if (_105[0].SimulIndices.w < 65535u)
            {
                _672 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _306) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _293, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _621 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _306) + in.in_var_ATTRIBUTE12;
                _672 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _621.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _621.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _621.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _686 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _686[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _689 = _686;
    _689[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _692 = _689;
    _692[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _705 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_672.x, _672.y, _672.z, _672.w);
    float4 _716;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_705.z < 0.0))
    {
        float4 _714 = _705;
        _714.z = 9.9999999747524270787835121154785e-07;
        float4 _715 = _714;
        _715.w = 1.0;
        _716 = _715;
    }
    else
    {
        _716 = _705;
    }
    float _722 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_692 * float3x3((_572[0] * _589) + (_578 * _597), (_572[1] * _589) + (normalize(cross(_584, _578) * in.in_var_ATTRIBUTE2.w) * _597), (_572[2] * _589) + (_584 * _597)))[2], _101).xyz));
    float4 _747 = _716;
    _747.z = ((_716.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_722) > 0.0) ? (sqrt(fast::clamp(1.0 - (_722 * _722), 0.0, 1.0)) / _722) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _716.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _747;
    return out;
}

