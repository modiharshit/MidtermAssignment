

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

constant spvUnsafeArray<float2, 1> _95 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _103 = {};
constant float4 _104 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003c73_bf3278de(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _108;
    for (int _129 = 0; _129 < 1; )
    {
        uint _136 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_129)) * 4u;
        _108[_129].BaryCoordPos = GPUSkinApexCloth.read(uint(_136));
        _108[_129].BaryCoordNormal = GPUSkinApexCloth.read(uint((_136 + 1u)));
        _108[_129].BaryCoordTangent = GPUSkinApexCloth.read(uint((_136 + 2u)));
        uint4 _148 = as_type<uint4>(GPUSkinApexCloth.read(uint((_136 + 3u))));
        uint2 _149 = _148.xy;
        uint2 _152 = (_149 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _108[_129].SimulIndices = uint4(_108[_129].SimulIndices.x, _152.x, _108[_129].SimulIndices.z, _152.y);
        uint2 _156 = _149 & uint2(65535u);
        _108[_129].SimulIndices = uint4(_156.x, _108[_129].SimulIndices.y, _156.y, _108[_129].SimulIndices.w);
        _108[_129].Weight = as_type<float>(_148.z);
        _129++;
        continue;
    }
    float3 _295;
    if (_108[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _110;
        _110 = _108;
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
            bool _189 = _110[_179].SimulIndices.w < 65535u;
            if (_189)
            {
                int _195 = int(_110[_179].SimulIndices.x) * 3;
                uint _200 = uint(_195 + 1);
                int _212 = int(_110[_179].SimulIndices.y) * 3;
                uint _216 = uint(_212 + 1);
                int _226 = int(_110[_179].SimulIndices.z) * 3;
                uint _230 = uint(_226 + 1);
                _173 = _172 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_195))).xy, ClothSimulVertsPositionsNormals.read(uint(_200)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_200)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_195 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * _110[_179].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_212))).xy, ClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_216)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_212 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * _110[_179].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_226))).xy, ClothSimulVertsPositionsNormals.read(uint(_230)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_230)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_226 + 2))).xy, 0.0)).xyz * _110[_179].BaryCoordPos.w)) * ((1.0 - _110[_179].BaryCoordPos.x) - _110[_179].BaryCoordPos.y))) * 1.0);
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
    int _297 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _300 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _306 = int(_300 + (_Globals.InputWeightIndexSize * uint(_297)));
    float3x4 _308;
    _308 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _309;
    for (int _311 = 0; _311 < _297; _308 = _309, _311++)
    {
        int _319 = int(_300 + (_Globals.InputWeightIndexSize * uint(_311)));
        int _324 = int(InputWeightStream.read(uint(uint(_319))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _370 = float4(float(InputWeightStream.read(uint(uint(_306 + _311))).x) * 0.0039215688593685626983642578125);
            int _371 = int((InputWeightStream.read(uint(uint(_319 + 1))).x << 8u) | uint(_324)) * 3;
            _309 = float3x4(_308[0] + (_370 * BoneMatrices.read(uint(uint(_371)))), _308[1] + (_370 * BoneMatrices.read(uint(uint(_371 + 1)))), _308[2] + (_370 * BoneMatrices.read(uint(uint(_371 + 2)))));
        }
        else
        {
            float4 _335 = float4(float(InputWeightStream.read(uint(uint(_306 + _311))).x) * 0.0039215688593685626983642578125);
            int _336 = _324 * 3;
            _309 = float3x4(_308[0] + (_335 * BoneMatrices.read(uint(uint(_336)))), _308[1] + (_335 * BoneMatrices.read(uint(uint(_336 + 1)))), _308[2] + (_335 * BoneMatrices.read(uint(uint(_336 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _107;
    _107 = _108;
    float _571;
    float3x3 _572;
    if (_107[0].SimulIndices.w < 65535u)
    {
        float _402;
        float3 _405;
        float3 _407;
        float _409;
        int _411;
        _402 = _Globals.ClothBlendWeight;
        _405 = float3(0.0);
        _407 = float3(0.0);
        _409 = 0.0;
        _411 = 0;
        float _403;
        float _410;
        float3 _406;
        float3 _408;
        int _412;
        for (int _413 = 0; _413 < 1; _402 = _403, _405 = _406, _407 = _408, _409 = _410, _411 = _412, _413++)
        {
            bool _424 = _107[_413].SimulIndices.w < 65535u;
            if (_424)
            {
                int _430 = int(_107[_413].SimulIndices.x) * 3;
                uint _435 = uint(_430 + 1);
                float3 _444 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_430))).xy, ClothSimulVertsPositionsNormals.read(uint(_435)).x, 1.0)).xyz;
                int _447 = int(_107[_413].SimulIndices.y) * 3;
                uint _451 = uint(_447 + 1);
                float3 _458 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_447))).xy, ClothSimulVertsPositionsNormals.read(uint(_451)).x, 1.0)).xyz;
                int _461 = int(_107[_413].SimulIndices.z) * 3;
                uint _465 = uint(_461 + 1);
                float3 _472 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_461))).xy, ClothSimulVertsPositionsNormals.read(uint(_465)).x, 1.0)).xyz;
                float3 _482 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_435)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_430 + 2))).xy, 0.0)).xyz;
                float3 _492 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_451)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_447 + 2))).xy, 0.0)).xyz;
                float3 _502 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_465)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_461 + 2))).xy, 0.0)).xyz;
                _406 = _405 + (((((_444 + (_482 * _107[_413].BaryCoordNormal.w)) * _107[_413].BaryCoordNormal.x) + ((_458 + (_492 * _107[_413].BaryCoordNormal.w)) * _107[_413].BaryCoordNormal.y)) + ((_472 + (_502 * _107[_413].BaryCoordNormal.w)) * _107[_413].BaryCoordNormal.z)) * 1.0);
                _408 = _407 + (((((_444 + (_482 * _107[_413].BaryCoordTangent.w)) * _107[_413].BaryCoordTangent.x) + ((_458 + (_492 * _107[_413].BaryCoordTangent.w)) * _107[_413].BaryCoordTangent.y)) + ((_472 + (_502 * _107[_413].BaryCoordTangent.w)) * _107[_413].BaryCoordTangent.z)) * 1.0);
                _412 = _411 + 1;
            }
            else
            {
                _406 = _405;
                _408 = _407;
                _412 = _411;
            }
            _403 = _424 ? _Globals.ClothBlendWeight : _402;
            _410 = _424 ? 1.0 : _409;
        }
        bool _539 = (_411 > 0) && (_409 > 9.9999997473787516355514526367188e-05);
        float3x3 _563;
        if (_539)
        {
            float _543 = 1.0 / _409;
            float3x3 _558 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _560 = _103;
            _560[0] = _558 * normalize((_407 * _543) - _295);
            float3x3 _562 = _560;
            _562[2] = _558 * normalize((_405 * _543) - _295);
            _563 = _562;
        }
        else
        {
            _563 = _103;
        }
        float3x3 _570 = _563;
        _570[1] = cross(_563[2], _563[0]) * in.in_var_ATTRIBUTE2.w;
        _571 = _539 ? _402 : 0.0;
        _572 = _570;
    }
    else
    {
        _571 = 0.0;
        _572 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _578 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _308);
    float3 _584 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _308);
    float3 _589 = float3(_571);
    float3 _597 = float3(1.0 - _571);
    float4 _672;
    switch (0u)
    {
        default:
        {
            if (_108[0].SimulIndices.w < 65535u)
            {
                _672 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _308) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _295, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _621 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _308) + in.in_var_ATTRIBUTE12;
                _672 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _621.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _621.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _621.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _106;
    _106 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _109 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _674 = 0; _674 < 1; )
    {
        _109[_674] = _106[_674];
        _674++;
        continue;
    }
    float4 _686 = View.View_TranslatedWorldToClip * float4(_672.x, _672.y, _672.z, _672.w);
    float4 _689 = _104;
    _689.w = 0.0;
    float3x3 _703 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _703[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _706 = _703;
    _706[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _709 = _706;
    _709[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _710 = _709 * float3x3((_572[0] * _589) + (_578 * _597), (_572[1] * _589) + (normalize(cross(_584, _578) * in.in_var_ATTRIBUTE2.w) * _597), (_572[2] * _589) + (_584 * _597));
    float3 _711 = _710[0];
    spvUnsafeArray<float4, 1> _721 = { float4(_109[0].x, _109[0].y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10_centroid = float4(_711.x, _711.y, _711.z, _689.w);
    out.out_var_TEXCOORD11_centroid = float4(_710[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _721;
    out.out_var_TEXCOORD6 = float4(_672.x, _672.y, _672.z, _672.w);
    out.gl_Position = _686;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

