

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
    float4x4 ClothLocalToWorld;
    char _m1_pad[64];
    float ClothBlendWeight;
    uint InputWeightIndexSize;
    uint2 GPUSkinApexClothStartIndexOffset;
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

constant float _103 = {};
constant float3x3 _104 = {};
constant float4 _105 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainForGS_out Main_00003be6_c042645d(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    spvUnsafeArray<FClothVertex, 1> _108;
    for (int _127 = 0; _127 < 1; )
    {
        uint _134 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_127)) * 4u;
        _108[_127].BaryCoordPos = GPUSkinApexCloth.read(uint(_134));
        _108[_127].BaryCoordNormal = GPUSkinApexCloth.read(uint((_134 + 1u)));
        _108[_127].BaryCoordTangent = GPUSkinApexCloth.read(uint((_134 + 2u)));
        uint4 _146 = as_type<uint4>(GPUSkinApexCloth.read(uint((_134 + 3u))));
        uint2 _147 = _146.xy;
        uint2 _150 = (_147 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _108[_127].SimulIndices = uint4(_108[_127].SimulIndices.x, _150.x, _108[_127].SimulIndices.z, _150.y);
        uint2 _154 = _147 & uint2(65535u);
        _108[_127].SimulIndices = uint4(_154.x, _108[_127].SimulIndices.y, _154.y, _108[_127].SimulIndices.w);
        _108[_127].Weight = as_type<float>(_146.z);
        _127++;
        continue;
    }
    float3 _293;
    if (_108[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _109;
        _109 = _108;
        float3 _170;
        float _173;
        int _175;
        _170 = float3(0.0);
        _173 = 0.0;
        _175 = 0;
        float _174;
        float3 _171;
        int _176;
        for (int _177 = 0; _177 < 1; _170 = _171, _173 = _174, _175 = _176, _177++)
        {
            bool _187 = _109[_177].SimulIndices.w < 65535u;
            if (_187)
            {
                int _193 = int(_109[_177].SimulIndices.x) * 3;
                uint _198 = uint(_193 + 1);
                int _210 = int(_109[_177].SimulIndices.y) * 3;
                uint _214 = uint(_210 + 1);
                int _224 = int(_109[_177].SimulIndices.z) * 3;
                uint _228 = uint(_224 + 1);
                _171 = _170 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_193))).xy, ClothSimulVertsPositionsNormals.read(uint(_198)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_198)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_193 + 2))).xy, 0.0)).xyz * _109[_177].BaryCoordPos.w)) * _109[_177].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_210))).xy, ClothSimulVertsPositionsNormals.read(uint(_214)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_214)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_210 + 2))).xy, 0.0)).xyz * _109[_177].BaryCoordPos.w)) * _109[_177].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_224))).xy, ClothSimulVertsPositionsNormals.read(uint(_228)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_228)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_224 + 2))).xy, 0.0)).xyz * _109[_177].BaryCoordPos.w)) * ((1.0 - _109[_177].BaryCoordPos.x) - _109[_177].BaryCoordPos.y))) * 1.0);
                _176 = _175 + 1;
            }
            else
            {
                _171 = _170;
                _176 = _175;
            }
            _174 = _187 ? 1.0 : _173;
        }
        float3 _292;
        if ((_175 > 0) && (_173 > 9.9999997473787516355514526367188e-05))
        {
            _292 = _170 * (1.0 / _173);
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
    spvUnsafeArray<FClothVertex, 1> _107;
    _107 = _108;
    float _569;
    float3x3 _570;
    if (_107[0].SimulIndices.w < 65535u)
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
        float _408;
        float3 _404;
        float3 _406;
        int _410;
        for (int _411 = 0; _411 < 1; _400 = _401, _403 = _404, _405 = _406, _407 = _408, _409 = _410, _411++)
        {
            bool _422 = _107[_411].SimulIndices.w < 65535u;
            if (_422)
            {
                int _428 = int(_107[_411].SimulIndices.x) * 3;
                uint _433 = uint(_428 + 1);
                float3 _442 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_428))).xy, ClothSimulVertsPositionsNormals.read(uint(_433)).x, 1.0)).xyz;
                int _445 = int(_107[_411].SimulIndices.y) * 3;
                uint _449 = uint(_445 + 1);
                float3 _456 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_445))).xy, ClothSimulVertsPositionsNormals.read(uint(_449)).x, 1.0)).xyz;
                int _459 = int(_107[_411].SimulIndices.z) * 3;
                uint _463 = uint(_459 + 1);
                float3 _470 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_459))).xy, ClothSimulVertsPositionsNormals.read(uint(_463)).x, 1.0)).xyz;
                float3 _480 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_433)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_428 + 2))).xy, 0.0)).xyz;
                float3 _490 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_449)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_445 + 2))).xy, 0.0)).xyz;
                float3 _500 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_463)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_459 + 2))).xy, 0.0)).xyz;
                _404 = _403 + (((((_442 + (_480 * _107[_411].BaryCoordNormal.w)) * _107[_411].BaryCoordNormal.x) + ((_456 + (_490 * _107[_411].BaryCoordNormal.w)) * _107[_411].BaryCoordNormal.y)) + ((_470 + (_500 * _107[_411].BaryCoordNormal.w)) * _107[_411].BaryCoordNormal.z)) * 1.0);
                _406 = _405 + (((((_442 + (_480 * _107[_411].BaryCoordTangent.w)) * _107[_411].BaryCoordTangent.x) + ((_456 + (_490 * _107[_411].BaryCoordTangent.w)) * _107[_411].BaryCoordTangent.y)) + ((_470 + (_500 * _107[_411].BaryCoordTangent.w)) * _107[_411].BaryCoordTangent.z)) * 1.0);
                _410 = _409 + 1;
            }
            else
            {
                _404 = _403;
                _406 = _405;
                _410 = _409;
            }
            _401 = _422 ? _Globals.ClothBlendWeight : _400;
            _408 = _422 ? 1.0 : _407;
        }
        bool _537 = (_409 > 0) && (_407 > 9.9999997473787516355514526367188e-05);
        float3x3 _561;
        if (_537)
        {
            float _541 = 1.0 / _407;
            float3x3 _556 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _558 = _104;
            _558[0] = _556 * normalize((_405 * _541) - _293);
            float3x3 _560 = _558;
            _560[2] = _556 * normalize((_403 * _541) - _293);
            _561 = _560;
        }
        else
        {
            _561 = _104;
        }
        float3x3 _568 = _561;
        _568[1] = cross(_561[2], _561[0]) * in.in_var_ATTRIBUTE2.w;
        _569 = _537 ? _400 : 0.0;
        _570 = _568;
    }
    else
    {
        _569 = 0.0;
        _570 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _576 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _306);
    float3 _582 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _306);
    float3 _587 = float3(_569);
    float3 _595 = float3(1.0 - _569);
    float4 _670;
    switch (0u)
    {
        default:
        {
            if (_108[0].SimulIndices.w < 65535u)
            {
                _670 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _306) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _293, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _619 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _306) + in.in_var_ATTRIBUTE12;
                _670 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _619.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _619.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _619.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _684 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _684[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _687 = _684;
    _687[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _690 = _687;
    _690[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _691 = _690 * float3x3((_570[0] * _587) + (_576 * _595), (_570[1] * _587) + (normalize(cross(_582, _576) * in.in_var_ATTRIBUTE2.w) * _595), (_570[2] * _587) + (_582 * _595));
    float3 _692 = _691[2];
    float _693 = _692.x;
    float4 _699 = _105;
    _699.w = 0.0;
    float3 _700 = _691[0];
    float4 _711 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_670.x, _670.y, _670.z, _670.w);
    out.out_var_TEXCOORD10_centroid = float4(_700.x, _700.y, _700.z, _699.w);
    out.out_var_TEXCOORD11_centroid = float4(_693, _692.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD7 = _670.xyz;
    out.out_var_TEXCOORD6 = _711;
    out.out_var_TEXCOORD8 = float4(_693, _692.yz, _103).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _711;
    return out;
}

