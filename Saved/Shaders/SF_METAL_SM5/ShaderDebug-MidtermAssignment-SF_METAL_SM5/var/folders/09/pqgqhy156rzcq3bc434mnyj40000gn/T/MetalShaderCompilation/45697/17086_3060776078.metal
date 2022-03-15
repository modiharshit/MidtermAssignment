

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

constant float _96 = {};
constant float3x3 _97 = {};
constant float4 _98 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
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

vertex Main_out Main_000042be_b66fbc8e(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _101;
    for (int _123 = 0; _123 < 1; )
    {
        uint _130 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_123)) * 4u;
        _101[_123].BaryCoordPos = GPUSkinApexCloth.read(uint(_130));
        _101[_123].BaryCoordNormal = GPUSkinApexCloth.read(uint((_130 + 1u)));
        _101[_123].BaryCoordTangent = GPUSkinApexCloth.read(uint((_130 + 2u)));
        uint4 _142 = as_type<uint4>(GPUSkinApexCloth.read(uint((_130 + 3u))));
        uint2 _143 = _142.xy;
        uint2 _146 = (_143 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _101[_123].SimulIndices = uint4(_101[_123].SimulIndices.x, _146.x, _101[_123].SimulIndices.z, _146.y);
        uint2 _150 = _143 & uint2(65535u);
        _101[_123].SimulIndices = uint4(_150.x, _101[_123].SimulIndices.y, _150.y, _101[_123].SimulIndices.w);
        _101[_123].Weight = as_type<float>(_142.z);
        _123++;
        continue;
    }
    float3 _289;
    if (_101[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _102;
        _102 = _101;
        float3 _166;
        float _169;
        int _171;
        _166 = float3(0.0);
        _169 = 0.0;
        _171 = 0;
        float _170;
        float3 _167;
        int _172;
        for (int _173 = 0; _173 < 1; _166 = _167, _169 = _170, _171 = _172, _173++)
        {
            bool _183 = _102[_173].SimulIndices.w < 65535u;
            if (_183)
            {
                int _189 = int(_102[_173].SimulIndices.x) * 3;
                uint _194 = uint(_189 + 1);
                int _206 = int(_102[_173].SimulIndices.y) * 3;
                uint _210 = uint(_206 + 1);
                int _220 = int(_102[_173].SimulIndices.z) * 3;
                uint _224 = uint(_220 + 1);
                _167 = _166 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_189))).xy, ClothSimulVertsPositionsNormals.read(uint(_194)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_194)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_189 + 2))).xy, 0.0)).xyz * _102[_173].BaryCoordPos.w)) * _102[_173].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_206))).xy, ClothSimulVertsPositionsNormals.read(uint(_210)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_210)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_206 + 2))).xy, 0.0)).xyz * _102[_173].BaryCoordPos.w)) * _102[_173].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_220))).xy, ClothSimulVertsPositionsNormals.read(uint(_224)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_224)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_220 + 2))).xy, 0.0)).xyz * _102[_173].BaryCoordPos.w)) * ((1.0 - _102[_173].BaryCoordPos.x) - _102[_173].BaryCoordPos.y))) * 1.0);
                _172 = _171 + 1;
            }
            else
            {
                _167 = _166;
                _172 = _171;
            }
            _170 = _183 ? 1.0 : _169;
        }
        float3 _288;
        if ((_171 > 0) && (_169 > 9.9999997473787516355514526367188e-05))
        {
            _288 = _166 * (1.0 / _169);
        }
        else
        {
            _288 = float3(0.0);
        }
        _289 = _288;
    }
    else
    {
        _289 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _291 = float4(in.in_var_ATTRIBUTE4.x);
    int _294 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _308 = float4(in.in_var_ATTRIBUTE4.y);
    int _311 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _327 = float4(in.in_var_ATTRIBUTE4.z);
    int _330 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _346 = float4(in.in_var_ATTRIBUTE4.w);
    int _349 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _361 = (((_291 * BoneMatrices.read(uint(uint(_294)))) + (_308 * BoneMatrices.read(uint(uint(_311))))) + (_327 * BoneMatrices.read(uint(uint(_330))))) + (_346 * BoneMatrices.read(uint(uint(_349))));
    float4 _362 = (((_291 * BoneMatrices.read(uint(uint(_294 + 1)))) + (_308 * BoneMatrices.read(uint(uint(_311 + 1))))) + (_327 * BoneMatrices.read(uint(uint(_330 + 1))))) + (_346 * BoneMatrices.read(uint(uint(_349 + 1))));
    float4 _363 = (((_291 * BoneMatrices.read(uint(uint(_294 + 2)))) + (_308 * BoneMatrices.read(uint(uint(_311 + 2))))) + (_327 * BoneMatrices.read(uint(uint(_330 + 2))))) + (_346 * BoneMatrices.read(uint(uint(_349 + 2))));
    float3x4 _447;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _371 = float4(in.in_var_ATTRIBUTE15.x);
        int _374 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _390 = float4(in.in_var_ATTRIBUTE15.y);
        int _393 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _409 = float4(in.in_var_ATTRIBUTE15.z);
        int _412 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _428 = float4(in.in_var_ATTRIBUTE15.w);
        int _431 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _447 = float3x4((((_361 + (_371 * BoneMatrices.read(uint(uint(_374))))) + (_390 * BoneMatrices.read(uint(uint(_393))))) + (_409 * BoneMatrices.read(uint(uint(_412))))) + (_428 * BoneMatrices.read(uint(uint(_431)))), (((_362 + (_371 * BoneMatrices.read(uint(uint(_374 + 1))))) + (_390 * BoneMatrices.read(uint(uint(_393 + 1))))) + (_409 * BoneMatrices.read(uint(uint(_412 + 1))))) + (_428 * BoneMatrices.read(uint(uint(_431 + 1)))), (((_363 + (_371 * BoneMatrices.read(uint(uint(_374 + 2))))) + (_390 * BoneMatrices.read(uint(uint(_393 + 2))))) + (_409 * BoneMatrices.read(uint(uint(_412 + 2))))) + (_428 * BoneMatrices.read(uint(uint(_431 + 2)))));
    }
    else
    {
        _447 = float3x4(_361, _362, _363);
    }
    spvUnsafeArray<FClothVertex, 1> _100;
    _100 = _101;
    float _628;
    float3x3 _629;
    if (_100[0].SimulIndices.w < 65535u)
    {
        float _459;
        float3 _462;
        float3 _464;
        float _466;
        int _468;
        _459 = _Globals.ClothBlendWeight;
        _462 = float3(0.0);
        _464 = float3(0.0);
        _466 = 0.0;
        _468 = 0;
        float _460;
        float _467;
        float3 _463;
        float3 _465;
        int _469;
        for (int _470 = 0; _470 < 1; _459 = _460, _462 = _463, _464 = _465, _466 = _467, _468 = _469, _470++)
        {
            bool _481 = _100[_470].SimulIndices.w < 65535u;
            if (_481)
            {
                int _487 = int(_100[_470].SimulIndices.x) * 3;
                uint _492 = uint(_487 + 1);
                float3 _501 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_487))).xy, ClothSimulVertsPositionsNormals.read(uint(_492)).x, 1.0)).xyz;
                int _504 = int(_100[_470].SimulIndices.y) * 3;
                uint _508 = uint(_504 + 1);
                float3 _515 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_504))).xy, ClothSimulVertsPositionsNormals.read(uint(_508)).x, 1.0)).xyz;
                int _518 = int(_100[_470].SimulIndices.z) * 3;
                uint _522 = uint(_518 + 1);
                float3 _529 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_518))).xy, ClothSimulVertsPositionsNormals.read(uint(_522)).x, 1.0)).xyz;
                float3 _539 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_492)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_487 + 2))).xy, 0.0)).xyz;
                float3 _549 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_508)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_504 + 2))).xy, 0.0)).xyz;
                float3 _559 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_522)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_518 + 2))).xy, 0.0)).xyz;
                _463 = _462 + (((((_501 + (_539 * _100[_470].BaryCoordNormal.w)) * _100[_470].BaryCoordNormal.x) + ((_515 + (_549 * _100[_470].BaryCoordNormal.w)) * _100[_470].BaryCoordNormal.y)) + ((_529 + (_559 * _100[_470].BaryCoordNormal.w)) * _100[_470].BaryCoordNormal.z)) * 1.0);
                _465 = _464 + (((((_501 + (_539 * _100[_470].BaryCoordTangent.w)) * _100[_470].BaryCoordTangent.x) + ((_515 + (_549 * _100[_470].BaryCoordTangent.w)) * _100[_470].BaryCoordTangent.y)) + ((_529 + (_559 * _100[_470].BaryCoordTangent.w)) * _100[_470].BaryCoordTangent.z)) * 1.0);
                _469 = _468 + 1;
            }
            else
            {
                _463 = _462;
                _465 = _464;
                _469 = _468;
            }
            _460 = _481 ? _Globals.ClothBlendWeight : _459;
            _467 = _481 ? 1.0 : _466;
        }
        bool _596 = (_468 > 0) && (_466 > 9.9999997473787516355514526367188e-05);
        float3x3 _620;
        if (_596)
        {
            float _600 = 1.0 / _466;
            float3x3 _615 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _617 = _97;
            _617[0] = _615 * normalize((_464 * _600) - _289);
            float3x3 _619 = _617;
            _619[2] = _615 * normalize((_462 * _600) - _289);
            _620 = _619;
        }
        else
        {
            _620 = _97;
        }
        float3x3 _627 = _620;
        _627[1] = cross(_620[2], _620[0]) * in.in_var_ATTRIBUTE2.w;
        _628 = _596 ? _459 : 0.0;
        _629 = _627;
    }
    else
    {
        _628 = 0.0;
        _629 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _635 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _447);
    float3 _641 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _447);
    float3 _646 = float3(_628);
    float3 _654 = float3(1.0 - _628);
    float4 _729;
    switch (0u)
    {
        default:
        {
            if (_101[0].SimulIndices.w < 65535u)
            {
                _729 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _447) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _289, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _678 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _447) + in.in_var_ATTRIBUTE12;
                _729 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _678.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _678.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _678.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _743 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _743[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _746 = _743;
    _746[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _749 = _746;
    _749[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _750 = _749 * float3x3((_629[0] * _646) + (_635 * _654), (_629[1] * _646) + (normalize(cross(_641, _635) * in.in_var_ATTRIBUTE2.w) * _654), (_629[2] * _646) + (_641 * _654));
    float3 _751 = _750[2];
    float _752 = _751.x;
    float4 _762 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_729.x, _729.y, _729.z, _729.w);
    float4 _773;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_762.z < 0.0))
    {
        float4 _771 = _762;
        _771.z = 9.9999999747524270787835121154785e-07;
        float4 _772 = _771;
        _772.w = 1.0;
        _773 = _772;
    }
    else
    {
        _773 = _762;
    }
    float _779 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_752, _751.yz, _96).xyz));
    float4 _804 = _773;
    _804.z = ((_773.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_779) > 0.0) ? (sqrt(fast::clamp(1.0 - (_779 * _779), 0.0, 1.0)) / _779) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _773.w;
    float4 _805 = _98;
    _805.w = 0.0;
    float3 _806 = _750[0];
    out.out_var_TEXCOORD10_centroid = float4(_806.x, _806.y, _806.z, _805.w);
    out.out_var_TEXCOORD11_centroid = float4(_752, _751.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _729.xyz;
    out.gl_Position = _804;
    return out;
}

