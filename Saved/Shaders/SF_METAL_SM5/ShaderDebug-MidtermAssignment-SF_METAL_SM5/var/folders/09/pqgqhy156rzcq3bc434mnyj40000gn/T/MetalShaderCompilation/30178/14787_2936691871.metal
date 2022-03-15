

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

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
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

vertex MainForGS_out Main_000039c3_af0a5c9f(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    spvUnsafeArray<FClothVertex, 1> _107;
    for (int _126 = 0; _126 < 1; )
    {
        uint _133 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_126)) * 4u;
        _107[_126].BaryCoordPos = GPUSkinApexCloth.read(uint(_133));
        _107[_126].BaryCoordNormal = GPUSkinApexCloth.read(uint((_133 + 1u)));
        _107[_126].BaryCoordTangent = GPUSkinApexCloth.read(uint((_133 + 2u)));
        uint4 _145 = as_type<uint4>(GPUSkinApexCloth.read(uint((_133 + 3u))));
        uint2 _146 = _145.xy;
        uint2 _149 = (_146 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _107[_126].SimulIndices = uint4(_107[_126].SimulIndices.x, _149.x, _107[_126].SimulIndices.z, _149.y);
        uint2 _153 = _146 & uint2(65535u);
        _107[_126].SimulIndices = uint4(_153.x, _107[_126].SimulIndices.y, _153.y, _107[_126].SimulIndices.w);
        _107[_126].Weight = as_type<float>(_145.z);
        _126++;
        continue;
    }
    float3 _292;
    if (_107[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _108;
        _108 = _107;
        float3 _169;
        float _172;
        int _174;
        _169 = float3(0.0);
        _172 = 0.0;
        _174 = 0;
        float _173;
        float3 _170;
        int _175;
        for (int _176 = 0; _176 < 1; _169 = _170, _172 = _173, _174 = _175, _176++)
        {
            bool _186 = _108[_176].SimulIndices.w < 65535u;
            if (_186)
            {
                int _192 = int(_108[_176].SimulIndices.x) * 3;
                uint _197 = uint(_192 + 1);
                int _209 = int(_108[_176].SimulIndices.y) * 3;
                uint _213 = uint(_209 + 1);
                int _223 = int(_108[_176].SimulIndices.z) * 3;
                uint _227 = uint(_223 + 1);
                _170 = _169 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_192))).xy, ClothSimulVertsPositionsNormals.read(uint(_197)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_197)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_192 + 2))).xy, 0.0)).xyz * _108[_176].BaryCoordPos.w)) * _108[_176].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_209))).xy, ClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_213)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_209 + 2))).xy, 0.0)).xyz * _108[_176].BaryCoordPos.w)) * _108[_176].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_223))).xy, ClothSimulVertsPositionsNormals.read(uint(_227)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_227)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_223 + 2))).xy, 0.0)).xyz * _108[_176].BaryCoordPos.w)) * ((1.0 - _108[_176].BaryCoordPos.x) - _108[_176].BaryCoordPos.y))) * 1.0);
                _175 = _174 + 1;
            }
            else
            {
                _170 = _169;
                _175 = _174;
            }
            _173 = _186 ? 1.0 : _172;
        }
        float3 _291;
        if ((_174 > 0) && (_172 > 9.9999997473787516355514526367188e-05))
        {
            _291 = _169 * (1.0 / _172);
        }
        else
        {
            _291 = float3(0.0);
        }
        _292 = _291;
    }
    else
    {
        _292 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _294 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _297 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _303 = int(_297 + (_Globals.InputWeightIndexSize * uint(_294)));
    float3x4 _305;
    _305 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _306;
    for (int _308 = 0; _308 < _294; _305 = _306, _308++)
    {
        int _316 = int(_297 + (_Globals.InputWeightIndexSize * uint(_308)));
        int _321 = int(InputWeightStream.read(uint(uint(_316))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _367 = float4(float(InputWeightStream.read(uint(uint(_303 + _308))).x) * 0.0039215688593685626983642578125);
            int _368 = int((InputWeightStream.read(uint(uint(_316 + 1))).x << 8u) | uint(_321)) * 3;
            _306 = float3x4(_305[0] + (_367 * BoneMatrices.read(uint(uint(_368)))), _305[1] + (_367 * BoneMatrices.read(uint(uint(_368 + 1)))), _305[2] + (_367 * BoneMatrices.read(uint(uint(_368 + 2)))));
        }
        else
        {
            float4 _332 = float4(float(InputWeightStream.read(uint(uint(_303 + _308))).x) * 0.0039215688593685626983642578125);
            int _333 = _321 * 3;
            _306 = float3x4(_305[0] + (_332 * BoneMatrices.read(uint(uint(_333)))), _305[1] + (_332 * BoneMatrices.read(uint(uint(_333 + 1)))), _305[2] + (_332 * BoneMatrices.read(uint(uint(_333 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _106;
    _106 = _107;
    float _568;
    float3x3 _569;
    if (_106[0].SimulIndices.w < 65535u)
    {
        float _399;
        float3 _402;
        float3 _404;
        float _406;
        int _408;
        _399 = _Globals.ClothBlendWeight;
        _402 = float3(0.0);
        _404 = float3(0.0);
        _406 = 0.0;
        _408 = 0;
        float _400;
        float _407;
        float3 _403;
        float3 _405;
        int _409;
        for (int _410 = 0; _410 < 1; _399 = _400, _402 = _403, _404 = _405, _406 = _407, _408 = _409, _410++)
        {
            bool _421 = _106[_410].SimulIndices.w < 65535u;
            if (_421)
            {
                int _427 = int(_106[_410].SimulIndices.x) * 3;
                uint _432 = uint(_427 + 1);
                float3 _441 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_427))).xy, ClothSimulVertsPositionsNormals.read(uint(_432)).x, 1.0)).xyz;
                int _444 = int(_106[_410].SimulIndices.y) * 3;
                uint _448 = uint(_444 + 1);
                float3 _455 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_444))).xy, ClothSimulVertsPositionsNormals.read(uint(_448)).x, 1.0)).xyz;
                int _458 = int(_106[_410].SimulIndices.z) * 3;
                uint _462 = uint(_458 + 1);
                float3 _469 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_458))).xy, ClothSimulVertsPositionsNormals.read(uint(_462)).x, 1.0)).xyz;
                float3 _479 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_432)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_427 + 2))).xy, 0.0)).xyz;
                float3 _489 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_448)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_444 + 2))).xy, 0.0)).xyz;
                float3 _499 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_462)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_458 + 2))).xy, 0.0)).xyz;
                _403 = _402 + (((((_441 + (_479 * _106[_410].BaryCoordNormal.w)) * _106[_410].BaryCoordNormal.x) + ((_455 + (_489 * _106[_410].BaryCoordNormal.w)) * _106[_410].BaryCoordNormal.y)) + ((_469 + (_499 * _106[_410].BaryCoordNormal.w)) * _106[_410].BaryCoordNormal.z)) * 1.0);
                _405 = _404 + (((((_441 + (_479 * _106[_410].BaryCoordTangent.w)) * _106[_410].BaryCoordTangent.x) + ((_455 + (_489 * _106[_410].BaryCoordTangent.w)) * _106[_410].BaryCoordTangent.y)) + ((_469 + (_499 * _106[_410].BaryCoordTangent.w)) * _106[_410].BaryCoordTangent.z)) * 1.0);
                _409 = _408 + 1;
            }
            else
            {
                _403 = _402;
                _405 = _404;
                _409 = _408;
            }
            _400 = _421 ? _Globals.ClothBlendWeight : _399;
            _407 = _421 ? 1.0 : _406;
        }
        bool _536 = (_408 > 0) && (_406 > 9.9999997473787516355514526367188e-05);
        float3x3 _560;
        if (_536)
        {
            float _540 = 1.0 / _406;
            float3x3 _555 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _557 = _104;
            _557[0] = _555 * normalize((_404 * _540) - _292);
            float3x3 _559 = _557;
            _559[2] = _555 * normalize((_402 * _540) - _292);
            _560 = _559;
        }
        else
        {
            _560 = _104;
        }
        float3x3 _567 = _560;
        _567[1] = cross(_560[2], _560[0]) * in.in_var_ATTRIBUTE2.w;
        _568 = _536 ? _399 : 0.0;
        _569 = _567;
    }
    else
    {
        _568 = 0.0;
        _569 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _575 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _305);
    float3 _581 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _305);
    float3 _586 = float3(_568);
    float3 _594 = float3(1.0 - _568);
    float4 _669;
    switch (0u)
    {
        default:
        {
            if (_107[0].SimulIndices.w < 65535u)
            {
                _669 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _305) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _292, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _618 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _305) + in.in_var_ATTRIBUTE12;
                _669 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _618.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _618.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _618.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _683 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _683[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _686 = _683;
    _686[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _689 = _686;
    _689[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _702 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * float4(_669.x, _669.y, _669.z, _669.w);
    out.out_var_TEXCOORD6 = float4(_669.x, _669.y, _669.z, _669.w);
    out.out_var_TEXCOORD8 = float4((_689 * float3x3((_569[0] * _586) + (_575 * _594), (_569[1] * _586) + (normalize(cross(_581, _575) * in.in_var_ATTRIBUTE2.w) * _594), (_569[2] * _586) + (_581 * _594)))[2], _103).xyz;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _702;
    return out;
}

