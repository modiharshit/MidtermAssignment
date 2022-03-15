

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

constant float _99 = {};
constant float3x3 _100 = {};
constant float4 _101 = {};

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

vertex Main_out Main_00004311_42698bd4(Main_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _104;
    for (int _126 = 0; _126 < 5; )
    {
        uint _134 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_126)) * 4u;
        _104[_126].BaryCoordPos = GPUSkinApexCloth.read(uint(_134));
        _104[_126].BaryCoordNormal = GPUSkinApexCloth.read(uint((_134 + 1u)));
        _104[_126].BaryCoordTangent = GPUSkinApexCloth.read(uint((_134 + 2u)));
        uint4 _146 = as_type<uint4>(GPUSkinApexCloth.read(uint((_134 + 3u))));
        uint2 _147 = _146.xy;
        uint2 _150 = (_147 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _104[_126].SimulIndices = uint4(_104[_126].SimulIndices.x, _150.x, _104[_126].SimulIndices.z, _150.y);
        uint2 _154 = _147 & uint2(65535u);
        _104[_126].SimulIndices = uint4(_154.x, _104[_126].SimulIndices.y, _154.y, _104[_126].SimulIndices.w);
        _104[_126].Weight = as_type<float>(_146.z);
        _126++;
        continue;
    }
    float3 _295;
    if (_104[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _105;
        _105 = _104;
        float3 _170;
        float _173;
        int _175;
        _170 = float3(0.0);
        _173 = 0.0;
        _175 = 0;
        float3 _171;
        float _174;
        int _176;
        for (int _177 = 0; _177 < 5; _170 = _171, _173 = _174, _175 = _176, _177++)
        {
            if (_105[_177].SimulIndices.w < 65535u)
            {
                int _194 = int(_105[_177].SimulIndices.x) * 3;
                uint _199 = uint(_194 + 1);
                int _211 = int(_105[_177].SimulIndices.y) * 3;
                uint _215 = uint(_211 + 1);
                int _225 = int(_105[_177].SimulIndices.z) * 3;
                uint _229 = uint(_225 + 1);
                _171 = _170 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_194))).xy, ClothSimulVertsPositionsNormals.read(uint(_199)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_199)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_194 + 2))).xy, 0.0)).xyz * _105[_177].BaryCoordPos.w)) * _105[_177].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, ClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_215)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _105[_177].BaryCoordPos.w)) * _105[_177].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_225))).xy, ClothSimulVertsPositionsNormals.read(uint(_229)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_229)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_225 + 2))).xy, 0.0)).xyz * _105[_177].BaryCoordPos.w)) * ((1.0 - _105[_177].BaryCoordPos.x) - _105[_177].BaryCoordPos.y))) * _105[_177].Weight);
                _174 = _173 + _105[_177].Weight;
                _176 = _175 + 1;
            }
            else
            {
                _171 = _170;
                _174 = _173;
                _176 = _175;
            }
        }
        float3 _294;
        if ((_175 > 0) && (_173 > 9.9999997473787516355514526367188e-05))
        {
            _294 = _170 * (1.0 / _173);
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
    float4 _297 = float4(in.in_var_ATTRIBUTE4.x);
    int _300 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _314 = float4(in.in_var_ATTRIBUTE4.y);
    int _317 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _333 = float4(in.in_var_ATTRIBUTE4.z);
    int _336 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _352 = float4(in.in_var_ATTRIBUTE4.w);
    int _355 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _367 = (((_297 * BoneMatrices.read(uint(uint(_300)))) + (_314 * BoneMatrices.read(uint(uint(_317))))) + (_333 * BoneMatrices.read(uint(uint(_336))))) + (_352 * BoneMatrices.read(uint(uint(_355))));
    float4 _368 = (((_297 * BoneMatrices.read(uint(uint(_300 + 1)))) + (_314 * BoneMatrices.read(uint(uint(_317 + 1))))) + (_333 * BoneMatrices.read(uint(uint(_336 + 1))))) + (_352 * BoneMatrices.read(uint(uint(_355 + 1))));
    float4 _369 = (((_297 * BoneMatrices.read(uint(uint(_300 + 2)))) + (_314 * BoneMatrices.read(uint(uint(_317 + 2))))) + (_333 * BoneMatrices.read(uint(uint(_336 + 2))))) + (_352 * BoneMatrices.read(uint(uint(_355 + 2))));
    float3x4 _453;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _377 = float4(in.in_var_ATTRIBUTE15.x);
        int _380 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _396 = float4(in.in_var_ATTRIBUTE15.y);
        int _399 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _415 = float4(in.in_var_ATTRIBUTE15.z);
        int _418 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _434 = float4(in.in_var_ATTRIBUTE15.w);
        int _437 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _453 = float3x4((((_367 + (_377 * BoneMatrices.read(uint(uint(_380))))) + (_396 * BoneMatrices.read(uint(uint(_399))))) + (_415 * BoneMatrices.read(uint(uint(_418))))) + (_434 * BoneMatrices.read(uint(uint(_437)))), (((_368 + (_377 * BoneMatrices.read(uint(uint(_380 + 1))))) + (_396 * BoneMatrices.read(uint(uint(_399 + 1))))) + (_415 * BoneMatrices.read(uint(uint(_418 + 1))))) + (_434 * BoneMatrices.read(uint(uint(_437 + 1)))), (((_369 + (_377 * BoneMatrices.read(uint(uint(_380 + 2))))) + (_396 * BoneMatrices.read(uint(uint(_399 + 2))))) + (_415 * BoneMatrices.read(uint(uint(_418 + 2))))) + (_434 * BoneMatrices.read(uint(uint(_437 + 2)))));
    }
    else
    {
        _453 = float3x4(_367, _368, _369);
    }
    spvUnsafeArray<FClothVertex, 5> _103;
    _103 = _104;
    float _636;
    float3x3 _637;
    if (_103[0].SimulIndices.w < 65535u)
    {
        float _465;
        float3 _468;
        float3 _470;
        float _472;
        int _474;
        _465 = _Globals.ClothBlendWeight;
        _468 = float3(0.0);
        _470 = float3(0.0);
        _472 = 0.0;
        _474 = 0;
        float _466;
        float3 _469;
        float3 _471;
        float _473;
        int _475;
        for (int _476 = 0; _476 < 5; _465 = _466, _468 = _469, _470 = _471, _472 = _473, _474 = _475, _476++)
        {
            bool _488 = _103[_476].SimulIndices.w < 65535u;
            if (_488)
            {
                int _494 = int(_103[_476].SimulIndices.x) * 3;
                uint _499 = uint(_494 + 1);
                float3 _508 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_494))).xy, ClothSimulVertsPositionsNormals.read(uint(_499)).x, 1.0)).xyz;
                int _511 = int(_103[_476].SimulIndices.y) * 3;
                uint _515 = uint(_511 + 1);
                float3 _522 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_511))).xy, ClothSimulVertsPositionsNormals.read(uint(_515)).x, 1.0)).xyz;
                int _525 = int(_103[_476].SimulIndices.z) * 3;
                uint _529 = uint(_525 + 1);
                float3 _536 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_525))).xy, ClothSimulVertsPositionsNormals.read(uint(_529)).x, 1.0)).xyz;
                float3 _546 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_499)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_494 + 2))).xy, 0.0)).xyz;
                float3 _556 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_515)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_511 + 2))).xy, 0.0)).xyz;
                float3 _566 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_529)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_525 + 2))).xy, 0.0)).xyz;
                _469 = _468 + (((((_508 + (_546 * _103[_476].BaryCoordNormal.w)) * _103[_476].BaryCoordNormal.x) + ((_522 + (_556 * _103[_476].BaryCoordNormal.w)) * _103[_476].BaryCoordNormal.y)) + ((_536 + (_566 * _103[_476].BaryCoordNormal.w)) * _103[_476].BaryCoordNormal.z)) * _103[_476].Weight);
                _471 = _470 + (((((_508 + (_546 * _103[_476].BaryCoordTangent.w)) * _103[_476].BaryCoordTangent.x) + ((_522 + (_556 * _103[_476].BaryCoordTangent.w)) * _103[_476].BaryCoordTangent.y)) + ((_536 + (_566 * _103[_476].BaryCoordTangent.w)) * _103[_476].BaryCoordTangent.z)) * _103[_476].Weight);
                _473 = _472 + _103[_476].Weight;
                _475 = _474 + 1;
            }
            else
            {
                _469 = _468;
                _471 = _470;
                _473 = _472;
                _475 = _474;
            }
            _466 = _488 ? _Globals.ClothBlendWeight : _465;
        }
        bool _604 = (_474 > 0) && (_472 > 9.9999997473787516355514526367188e-05);
        float3x3 _628;
        if (_604)
        {
            float _608 = 1.0 / _472;
            float3x3 _623 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _625 = _100;
            _625[0] = _623 * normalize((_470 * _608) - _295);
            float3x3 _627 = _625;
            _627[2] = _623 * normalize((_468 * _608) - _295);
            _628 = _627;
        }
        else
        {
            _628 = _100;
        }
        float3x3 _635 = _628;
        _635[1] = cross(_628[2], _628[0]) * in.in_var_ATTRIBUTE2.w;
        _636 = _604 ? _465 : 0.0;
        _637 = _635;
    }
    else
    {
        _636 = 0.0;
        _637 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _643 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _453);
    float3 _649 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _453);
    float3 _654 = float3(_636);
    float3 _662 = float3(1.0 - _636);
    float4 _737;
    switch (0u)
    {
        default:
        {
            if (_104[0].SimulIndices.w < 65535u)
            {
                _737 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _295, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _686 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12;
                _737 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _686.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _686.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _686.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _751 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _751[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _754 = _751;
    _754[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _757 = _754;
    _757[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _758 = _757 * float3x3((_637[0] * _654) + (_643 * _662), (_637[1] * _654) + (normalize(cross(_649, _643) * in.in_var_ATTRIBUTE2.w) * _662), (_637[2] * _654) + (_649 * _662));
    float3 _759 = _758[2];
    float _760 = _759.x;
    float4 _770 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_737.x, _737.y, _737.z, _737.w);
    float4 _781;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_770.z < 0.0))
    {
        float4 _779 = _770;
        _779.z = 9.9999999747524270787835121154785e-07;
        float4 _780 = _779;
        _780.w = 1.0;
        _781 = _780;
    }
    else
    {
        _781 = _770;
    }
    float _787 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4(_760, _759.yz, _99).xyz));
    float4 _806 = _101;
    _806.w = 0.0;
    float3 _807 = _758[0];
    out.out_var_TEXCOORD10_centroid = float4(_807.x, _807.y, _807.z, _806.w);
    out.out_var_TEXCOORD11_centroid = float4(_760, _759.yz, in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = _781.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_787) > 0.0) ? (sqrt(fast::clamp(1.0 - (_787 * _787), 0.0, 1.0)) / _787) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _737.xyz;
    out.gl_Position = _781;
    return out;
}

