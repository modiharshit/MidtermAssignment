

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

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex Main_out Main_0000272a_fe8caa8a(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _85;
    for (int _107 = 0; _107 < 1; )
    {
        uint _114 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_107)) * 4u;
        _85[_107].BaryCoordPos = GPUSkinApexCloth.read(uint(_114));
        _85[_107].BaryCoordNormal = GPUSkinApexCloth.read(uint((_114 + 1u)));
        _85[_107].BaryCoordTangent = GPUSkinApexCloth.read(uint((_114 + 2u)));
        uint4 _126 = as_type<uint4>(GPUSkinApexCloth.read(uint((_114 + 3u))));
        uint2 _127 = _126.xy;
        uint2 _130 = (_127 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _85[_107].SimulIndices = uint4(_85[_107].SimulIndices.x, _130.x, _85[_107].SimulIndices.z, _130.y);
        uint2 _134 = _127 & uint2(65535u);
        _85[_107].SimulIndices = uint4(_134.x, _85[_107].SimulIndices.y, _134.y, _85[_107].SimulIndices.w);
        _85[_107].Weight = as_type<float>(_126.z);
        _107++;
        continue;
    }
    float3 _273;
    if (_85[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _86;
        _86 = _85;
        float3 _150;
        float _153;
        int _155;
        _150 = float3(0.0);
        _153 = 0.0;
        _155 = 0;
        float _154;
        float3 _151;
        int _156;
        for (int _157 = 0; _157 < 1; _150 = _151, _153 = _154, _155 = _156, _157++)
        {
            bool _167 = _86[_157].SimulIndices.w < 65535u;
            if (_167)
            {
                int _173 = int(_86[_157].SimulIndices.x) * 3;
                uint _178 = uint(_173 + 1);
                int _190 = int(_86[_157].SimulIndices.y) * 3;
                uint _194 = uint(_190 + 1);
                int _204 = int(_86[_157].SimulIndices.z) * 3;
                uint _208 = uint(_204 + 1);
                _151 = _150 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_173))).xy, ClothSimulVertsPositionsNormals.read(uint(_178)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_178)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_173 + 2))).xy, 0.0)).xyz * _86[_157].BaryCoordPos.w)) * _86[_157].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_190))).xy, ClothSimulVertsPositionsNormals.read(uint(_194)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_194)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_190 + 2))).xy, 0.0)).xyz * _86[_157].BaryCoordPos.w)) * _86[_157].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_204))).xy, ClothSimulVertsPositionsNormals.read(uint(_208)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_208)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_204 + 2))).xy, 0.0)).xyz * _86[_157].BaryCoordPos.w)) * ((1.0 - _86[_157].BaryCoordPos.x) - _86[_157].BaryCoordPos.y))) * 1.0);
                _156 = _155 + 1;
            }
            else
            {
                _151 = _150;
                _156 = _155;
            }
            _154 = _167 ? 1.0 : _153;
        }
        float3 _272;
        if ((_155 > 0) && (_153 > 9.9999997473787516355514526367188e-05))
        {
            _272 = _150 * (1.0 / _153);
        }
        else
        {
            _272 = float3(0.0);
        }
        _273 = _272;
    }
    else
    {
        _273 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _275 = float4(in.in_var_ATTRIBUTE4.x);
    int _278 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _292 = float4(in.in_var_ATTRIBUTE4.y);
    int _295 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _311 = float4(in.in_var_ATTRIBUTE4.z);
    int _314 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _330 = float4(in.in_var_ATTRIBUTE4.w);
    int _333 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _345 = (((_275 * BoneMatrices.read(uint(uint(_278)))) + (_292 * BoneMatrices.read(uint(uint(_295))))) + (_311 * BoneMatrices.read(uint(uint(_314))))) + (_330 * BoneMatrices.read(uint(uint(_333))));
    float4 _346 = (((_275 * BoneMatrices.read(uint(uint(_278 + 1)))) + (_292 * BoneMatrices.read(uint(uint(_295 + 1))))) + (_311 * BoneMatrices.read(uint(uint(_314 + 1))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 1))));
    float4 _347 = (((_275 * BoneMatrices.read(uint(uint(_278 + 2)))) + (_292 * BoneMatrices.read(uint(uint(_295 + 2))))) + (_311 * BoneMatrices.read(uint(uint(_314 + 2))))) + (_330 * BoneMatrices.read(uint(uint(_333 + 2))));
    float3x4 _431;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _355 = float4(in.in_var_ATTRIBUTE15.x);
        int _358 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _374 = float4(in.in_var_ATTRIBUTE15.y);
        int _377 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _393 = float4(in.in_var_ATTRIBUTE15.z);
        int _396 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _412 = float4(in.in_var_ATTRIBUTE15.w);
        int _415 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _431 = float3x4((((_345 + (_355 * BoneMatrices.read(uint(uint(_358))))) + (_374 * BoneMatrices.read(uint(uint(_377))))) + (_393 * BoneMatrices.read(uint(uint(_396))))) + (_412 * BoneMatrices.read(uint(uint(_415)))), (((_346 + (_355 * BoneMatrices.read(uint(uint(_358 + 1))))) + (_374 * BoneMatrices.read(uint(uint(_377 + 1))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 1))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 1)))), (((_347 + (_355 * BoneMatrices.read(uint(uint(_358 + 2))))) + (_374 * BoneMatrices.read(uint(uint(_377 + 2))))) + (_393 * BoneMatrices.read(uint(uint(_396 + 2))))) + (_412 * BoneMatrices.read(uint(uint(_415 + 2)))));
    }
    else
    {
        _431 = float3x4(_345, _346, _347);
    }
    float4 _499;
    switch (0u)
    {
        default:
        {
            if (_85[0].SimulIndices.w < 65535u)
            {
                _499 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _431) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _273, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _448 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _431) + in.in_var_ATTRIBUTE12;
                _499 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _448.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _448.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _448.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _501 = View.View_TranslatedWorldToClip * float4(_499.x, _499.y, _499.z, _499.w);
    out.gl_Position = _501;
    return out;
}

