

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

vertex Main_out Main_0000274d_1cd9ef9c(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _87;
    for (int _109 = 0; _109 < 5; )
    {
        uint _117 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_109)) * 4u;
        _87[_109].BaryCoordPos = GPUSkinApexCloth.read(uint(_117));
        _87[_109].BaryCoordNormal = GPUSkinApexCloth.read(uint((_117 + 1u)));
        _87[_109].BaryCoordTangent = GPUSkinApexCloth.read(uint((_117 + 2u)));
        uint4 _129 = as_type<uint4>(GPUSkinApexCloth.read(uint((_117 + 3u))));
        uint2 _130 = _129.xy;
        uint2 _133 = (_130 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _87[_109].SimulIndices = uint4(_87[_109].SimulIndices.x, _133.x, _87[_109].SimulIndices.z, _133.y);
        uint2 _137 = _130 & uint2(65535u);
        _87[_109].SimulIndices = uint4(_137.x, _87[_109].SimulIndices.y, _137.y, _87[_109].SimulIndices.w);
        _87[_109].Weight = as_type<float>(_129.z);
        _109++;
        continue;
    }
    float3 _278;
    if (_87[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _88;
        _88 = _87;
        float3 _153;
        float _156;
        int _158;
        _153 = float3(0.0);
        _156 = 0.0;
        _158 = 0;
        float3 _154;
        float _157;
        int _159;
        for (int _160 = 0; _160 < 5; _153 = _154, _156 = _157, _158 = _159, _160++)
        {
            if (_88[_160].SimulIndices.w < 65535u)
            {
                int _177 = int(_88[_160].SimulIndices.x) * 3;
                uint _182 = uint(_177 + 1);
                int _194 = int(_88[_160].SimulIndices.y) * 3;
                uint _198 = uint(_194 + 1);
                int _208 = int(_88[_160].SimulIndices.z) * 3;
                uint _212 = uint(_208 + 1);
                _154 = _153 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_177))).xy, ClothSimulVertsPositionsNormals.read(uint(_182)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_182)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_177 + 2))).xy, 0.0)).xyz * _88[_160].BaryCoordPos.w)) * _88[_160].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_194))).xy, ClothSimulVertsPositionsNormals.read(uint(_198)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_198)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_194 + 2))).xy, 0.0)).xyz * _88[_160].BaryCoordPos.w)) * _88[_160].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_208))).xy, ClothSimulVertsPositionsNormals.read(uint(_212)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_212)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_208 + 2))).xy, 0.0)).xyz * _88[_160].BaryCoordPos.w)) * ((1.0 - _88[_160].BaryCoordPos.x) - _88[_160].BaryCoordPos.y))) * _88[_160].Weight);
                _157 = _156 + _88[_160].Weight;
                _159 = _158 + 1;
            }
            else
            {
                _154 = _153;
                _157 = _156;
                _159 = _158;
            }
        }
        float3 _277;
        if ((_158 > 0) && (_156 > 9.9999997473787516355514526367188e-05))
        {
            _277 = _153 * (1.0 / _156);
        }
        else
        {
            _277 = float3(0.0);
        }
        _278 = _277;
    }
    else
    {
        _278 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _280 = float4(in.in_var_ATTRIBUTE4.x);
    int _283 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _297 = float4(in.in_var_ATTRIBUTE4.y);
    int _300 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _316 = float4(in.in_var_ATTRIBUTE4.z);
    int _319 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _335 = float4(in.in_var_ATTRIBUTE4.w);
    int _338 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _350 = (((_280 * BoneMatrices.read(uint(uint(_283)))) + (_297 * BoneMatrices.read(uint(uint(_300))))) + (_316 * BoneMatrices.read(uint(uint(_319))))) + (_335 * BoneMatrices.read(uint(uint(_338))));
    float4 _351 = (((_280 * BoneMatrices.read(uint(uint(_283 + 1)))) + (_297 * BoneMatrices.read(uint(uint(_300 + 1))))) + (_316 * BoneMatrices.read(uint(uint(_319 + 1))))) + (_335 * BoneMatrices.read(uint(uint(_338 + 1))));
    float4 _352 = (((_280 * BoneMatrices.read(uint(uint(_283 + 2)))) + (_297 * BoneMatrices.read(uint(uint(_300 + 2))))) + (_316 * BoneMatrices.read(uint(uint(_319 + 2))))) + (_335 * BoneMatrices.read(uint(uint(_338 + 2))));
    float3x4 _436;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _360 = float4(in.in_var_ATTRIBUTE15.x);
        int _363 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _379 = float4(in.in_var_ATTRIBUTE15.y);
        int _382 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _398 = float4(in.in_var_ATTRIBUTE15.z);
        int _401 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _417 = float4(in.in_var_ATTRIBUTE15.w);
        int _420 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _436 = float3x4((((_350 + (_360 * BoneMatrices.read(uint(uint(_363))))) + (_379 * BoneMatrices.read(uint(uint(_382))))) + (_398 * BoneMatrices.read(uint(uint(_401))))) + (_417 * BoneMatrices.read(uint(uint(_420)))), (((_351 + (_360 * BoneMatrices.read(uint(uint(_363 + 1))))) + (_379 * BoneMatrices.read(uint(uint(_382 + 1))))) + (_398 * BoneMatrices.read(uint(uint(_401 + 1))))) + (_417 * BoneMatrices.read(uint(uint(_420 + 1)))), (((_352 + (_360 * BoneMatrices.read(uint(uint(_363 + 2))))) + (_379 * BoneMatrices.read(uint(uint(_382 + 2))))) + (_398 * BoneMatrices.read(uint(uint(_401 + 2))))) + (_417 * BoneMatrices.read(uint(uint(_420 + 2)))));
    }
    else
    {
        _436 = float3x4(_350, _351, _352);
    }
    float4 _504;
    switch (0u)
    {
        default:
        {
            if (_87[0].SimulIndices.w < 65535u)
            {
                _504 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _436) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _278, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _453 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _436) + in.in_var_ATTRIBUTE12;
                _504 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _453.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _453.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _453.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _506 = View.View_TranslatedWorldToClip * float4(_504.x, _504.y, _504.z, _504.w);
    out.gl_Position = _506;
    return out;
}

