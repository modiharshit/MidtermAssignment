

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
    char _m2_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m3_pad[288];
    float3 View_PrevPreViewTranslation;
    char _m4_pad[336];
    int View_NumSceneColorMSAASamples;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
    float4x4 Primitive_PreviousLocalToWorld;
};

struct type_Globals
{
    uint PerBoneMotionBlur;
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    float4x4 PreviousClothLocalToWorld;
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

constant float3x3 _95 = {};
constant float4 _96 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_000059ac_dd1535c6(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], texture_buffer<float> PreviousBoneMatrices [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 5> _99;
    for (int _128 = 0; _128 < 5; )
    {
        uint _136 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_128)) * 4u;
        _99[_128].BaryCoordPos = GPUSkinApexCloth.read(uint(_136));
        _99[_128].BaryCoordNormal = GPUSkinApexCloth.read(uint((_136 + 1u)));
        _99[_128].BaryCoordTangent = GPUSkinApexCloth.read(uint((_136 + 2u)));
        uint4 _148 = as_type<uint4>(GPUSkinApexCloth.read(uint((_136 + 3u))));
        uint2 _149 = _148.xy;
        uint2 _152 = (_149 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _99[_128].SimulIndices = uint4(_99[_128].SimulIndices.x, _152.x, _99[_128].SimulIndices.z, _152.y);
        uint2 _156 = _149 & uint2(65535u);
        _99[_128].SimulIndices = uint4(_156.x, _99[_128].SimulIndices.y, _156.y, _99[_128].SimulIndices.w);
        _99[_128].Weight = as_type<float>(_148.z);
        _128++;
        continue;
    }
    float3 _424;
    float3 _425;
    if (_99[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _100;
        _100 = _99;
        float3 _172;
        float _175;
        int _177;
        _172 = float3(0.0);
        _175 = 0.0;
        _177 = 0;
        float3 _173;
        float _176;
        int _178;
        for (int _179 = 0; _179 < 5; _172 = _173, _175 = _176, _177 = _178, _179++)
        {
            if (_100[_179].SimulIndices.w < 65535u)
            {
                int _196 = int(_100[_179].SimulIndices.x) * 3;
                uint _201 = uint(_196 + 1);
                int _213 = int(_100[_179].SimulIndices.y) * 3;
                uint _217 = uint(_213 + 1);
                int _227 = int(_100[_179].SimulIndices.z) * 3;
                uint _231 = uint(_227 + 1);
                _173 = _172 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_196))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_201)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_201)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_196 + 2))).xy, 0.0)).xyz * _100[_179].BaryCoordPos.w)) * _100[_179].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_213))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_217)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_217)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_213 + 2))).xy, 0.0)).xyz * _100[_179].BaryCoordPos.w)) * _100[_179].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_231)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _100[_179].BaryCoordPos.w)) * ((1.0 - _100[_179].BaryCoordPos.x) - _100[_179].BaryCoordPos.y))) * _100[_179].Weight);
                _176 = _175 + _100[_179].Weight;
                _178 = _177 + 1;
            }
            else
            {
                _173 = _172;
                _176 = _175;
                _178 = _177;
            }
        }
        float3 _296;
        if ((_177 > 0) && (_175 > 9.9999997473787516355514526367188e-05))
        {
            _296 = _172 * (1.0 / _175);
        }
        else
        {
            _296 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 5> _101;
        _101 = _99;
        float3 _299;
        float _302;
        int _304;
        _299 = float3(0.0);
        _302 = 0.0;
        _304 = 0;
        float3 _300;
        float _303;
        int _305;
        for (int _306 = 0; _306 < 5; _299 = _300, _302 = _303, _304 = _305, _306++)
        {
            if (_101[_306].SimulIndices.w < 65535u)
            {
                int _323 = int(_101[_306].SimulIndices.x) * 3;
                uint _328 = uint(_323 + 1);
                int _340 = int(_101[_306].SimulIndices.y) * 3;
                uint _344 = uint(_340 + 1);
                int _354 = int(_101[_306].SimulIndices.z) * 3;
                uint _358 = uint(_354 + 1);
                _300 = _299 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_323))).xy, ClothSimulVertsPositionsNormals.read(uint(_328)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_328)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_323 + 2))).xy, 0.0)).xyz * _101[_306].BaryCoordPos.w)) * _101[_306].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_340))).xy, ClothSimulVertsPositionsNormals.read(uint(_344)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_344)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_340 + 2))).xy, 0.0)).xyz * _101[_306].BaryCoordPos.w)) * _101[_306].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_354))).xy, ClothSimulVertsPositionsNormals.read(uint(_358)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_358)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_354 + 2))).xy, 0.0)).xyz * _101[_306].BaryCoordPos.w)) * ((1.0 - _101[_306].BaryCoordPos.x) - _101[_306].BaryCoordPos.y))) * _101[_306].Weight);
                _303 = _302 + _101[_306].Weight;
                _305 = _304 + 1;
            }
            else
            {
                _300 = _299;
                _303 = _302;
                _305 = _304;
            }
        }
        float3 _423;
        if ((_304 > 0) && (_302 > 9.9999997473787516355514526367188e-05))
        {
            _423 = _299 * (1.0 / _302);
        }
        else
        {
            _423 = float3(0.0);
        }
        _424 = _423;
        _425 = _296;
    }
    else
    {
        _424 = in.in_var_ATTRIBUTE0.xyz;
        _425 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _427 = float4(in.in_var_ATTRIBUTE4.x);
    int _430 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _431 = uint(_430);
    uint _435 = uint(_430 + 1);
    uint _438 = uint(_430 + 2);
    float4 _444 = float4(in.in_var_ATTRIBUTE4.y);
    int _447 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _448 = uint(_447);
    uint _451 = uint(_447 + 1);
    uint _454 = uint(_447 + 2);
    float4 _463 = float4(in.in_var_ATTRIBUTE4.z);
    int _466 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _467 = uint(_466);
    uint _470 = uint(_466 + 1);
    uint _473 = uint(_466 + 2);
    float4 _482 = float4(in.in_var_ATTRIBUTE4.w);
    int _485 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _486 = uint(_485);
    uint _489 = uint(_485 + 1);
    uint _492 = uint(_485 + 2);
    float4 _497 = (((_427 * BoneMatrices.read(uint(_431))) + (_444 * BoneMatrices.read(uint(_448)))) + (_463 * BoneMatrices.read(uint(_467)))) + (_482 * BoneMatrices.read(uint(_486)));
    float4 _498 = (((_427 * BoneMatrices.read(uint(_435))) + (_444 * BoneMatrices.read(uint(_451)))) + (_463 * BoneMatrices.read(uint(_470)))) + (_482 * BoneMatrices.read(uint(_489)));
    float4 _499 = (((_427 * BoneMatrices.read(uint(_438))) + (_444 * BoneMatrices.read(uint(_454)))) + (_463 * BoneMatrices.read(uint(_473)))) + (_482 * BoneMatrices.read(uint(_492)));
    bool _503 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _583;
    if (_503)
    {
        float4 _507 = float4(in.in_var_ATTRIBUTE15.x);
        int _510 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _526 = float4(in.in_var_ATTRIBUTE15.y);
        int _529 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _545 = float4(in.in_var_ATTRIBUTE15.z);
        int _548 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _564 = float4(in.in_var_ATTRIBUTE15.w);
        int _567 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _583 = float3x4((((_497 + (_507 * BoneMatrices.read(uint(uint(_510))))) + (_526 * BoneMatrices.read(uint(uint(_529))))) + (_545 * BoneMatrices.read(uint(uint(_548))))) + (_564 * BoneMatrices.read(uint(uint(_567)))), (((_498 + (_507 * BoneMatrices.read(uint(uint(_510 + 1))))) + (_526 * BoneMatrices.read(uint(uint(_529 + 1))))) + (_545 * BoneMatrices.read(uint(uint(_548 + 1))))) + (_564 * BoneMatrices.read(uint(uint(_567 + 1)))), (((_499 + (_507 * BoneMatrices.read(uint(uint(_510 + 2))))) + (_526 * BoneMatrices.read(uint(uint(_529 + 2))))) + (_545 * BoneMatrices.read(uint(uint(_548 + 2))))) + (_564 * BoneMatrices.read(uint(uint(_567 + 2)))));
    }
    else
    {
        _583 = float3x4(_497, _498, _499);
    }
    spvUnsafeArray<FClothVertex, 5> _98;
    _98 = _99;
    float _766;
    float3x3 _767;
    if (_98[0].SimulIndices.w < 65535u)
    {
        float _595;
        float3 _598;
        float3 _600;
        float _602;
        int _604;
        _595 = _Globals.ClothBlendWeight;
        _598 = float3(0.0);
        _600 = float3(0.0);
        _602 = 0.0;
        _604 = 0;
        float _596;
        float3 _599;
        float3 _601;
        float _603;
        int _605;
        for (int _606 = 0; _606 < 5; _595 = _596, _598 = _599, _600 = _601, _602 = _603, _604 = _605, _606++)
        {
            bool _618 = _98[_606].SimulIndices.w < 65535u;
            if (_618)
            {
                int _624 = int(_98[_606].SimulIndices.x) * 3;
                uint _629 = uint(_624 + 1);
                float3 _638 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_624))).xy, ClothSimulVertsPositionsNormals.read(uint(_629)).x, 1.0)).xyz;
                int _641 = int(_98[_606].SimulIndices.y) * 3;
                uint _645 = uint(_641 + 1);
                float3 _652 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_641))).xy, ClothSimulVertsPositionsNormals.read(uint(_645)).x, 1.0)).xyz;
                int _655 = int(_98[_606].SimulIndices.z) * 3;
                uint _659 = uint(_655 + 1);
                float3 _666 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_655))).xy, ClothSimulVertsPositionsNormals.read(uint(_659)).x, 1.0)).xyz;
                float3 _676 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_629)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_624 + 2))).xy, 0.0)).xyz;
                float3 _686 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_645)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_641 + 2))).xy, 0.0)).xyz;
                float3 _696 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_659)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_655 + 2))).xy, 0.0)).xyz;
                _599 = _598 + (((((_638 + (_676 * _98[_606].BaryCoordNormal.w)) * _98[_606].BaryCoordNormal.x) + ((_652 + (_686 * _98[_606].BaryCoordNormal.w)) * _98[_606].BaryCoordNormal.y)) + ((_666 + (_696 * _98[_606].BaryCoordNormal.w)) * _98[_606].BaryCoordNormal.z)) * _98[_606].Weight);
                _601 = _600 + (((((_638 + (_676 * _98[_606].BaryCoordTangent.w)) * _98[_606].BaryCoordTangent.x) + ((_652 + (_686 * _98[_606].BaryCoordTangent.w)) * _98[_606].BaryCoordTangent.y)) + ((_666 + (_696 * _98[_606].BaryCoordTangent.w)) * _98[_606].BaryCoordTangent.z)) * _98[_606].Weight);
                _603 = _602 + _98[_606].Weight;
                _605 = _604 + 1;
            }
            else
            {
                _599 = _598;
                _601 = _600;
                _603 = _602;
                _605 = _604;
            }
            _596 = _618 ? _Globals.ClothBlendWeight : _595;
        }
        bool _734 = (_604 > 0) && (_602 > 9.9999997473787516355514526367188e-05);
        float3x3 _758;
        if (_734)
        {
            float _738 = 1.0 / _602;
            float3x3 _753 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _755 = _95;
            _755[0] = _753 * normalize((_600 * _738) - _424);
            float3x3 _757 = _755;
            _757[2] = _753 * normalize((_598 * _738) - _424);
            _758 = _757;
        }
        else
        {
            _758 = _95;
        }
        float3x3 _765 = _758;
        _765[1] = cross(_758[2], _758[0]) * in.in_var_ATTRIBUTE2.w;
        _766 = _734 ? _595 : 0.0;
        _767 = _765;
    }
    else
    {
        _766 = 0.0;
        _767 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _806;
    float3 _773 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _583);
    float3 _779 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _583);
    float3 _784 = float3(_766);
    float3 _792 = float3(1.0 - _766);
    float4 _867;
    switch (0u)
    {
        default:
        {
            _806 = _99[0].SimulIndices.w < 65535u;
            if (_806)
            {
                _867 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _583) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _424, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _816 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _583) + in.in_var_ATTRIBUTE12;
                _867 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _816.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _816.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _816.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _868 = _96;
    _868.w = 0.0;
    float3x3 _882 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _882[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _885 = _882;
    _885[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _888 = _885;
    _888[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _889 = _888 * float3x3((_767[0] * _784) + (_773 * _792), (_767[1] * _784) + (normalize(cross(_779, _773) * in.in_var_ATTRIBUTE2.w) * _792), (_767[2] * _784) + (_779 * _792));
    float3 _890 = _889[0];
    float4 _1061;
    switch (0u)
    {
        default:
        {
            float4x4 _907 = Primitive.Primitive_PreviousLocalToWorld;
            _907[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _911 = _907;
            _911[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _915 = _911;
            _915[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _1036;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float4 _952 = (((_427 * PreviousBoneMatrices.read(uint(_431))) + (_444 * PreviousBoneMatrices.read(uint(_448)))) + (_463 * PreviousBoneMatrices.read(uint(_467)))) + (_482 * PreviousBoneMatrices.read(uint(_486)));
                float4 _953 = (((_427 * PreviousBoneMatrices.read(uint(_435))) + (_444 * PreviousBoneMatrices.read(uint(_451)))) + (_463 * PreviousBoneMatrices.read(uint(_470)))) + (_482 * PreviousBoneMatrices.read(uint(_489)));
                float4 _954 = (((_427 * PreviousBoneMatrices.read(uint(_438))) + (_444 * PreviousBoneMatrices.read(uint(_454)))) + (_463 * PreviousBoneMatrices.read(uint(_473)))) + (_482 * PreviousBoneMatrices.read(uint(_492)));
                float3x4 _1035;
                if (_503)
                {
                    float4 _959 = float4(in.in_var_ATTRIBUTE15.x);
                    int _962 = int(in.in_var_ATTRIBUTE14.x) * 3;
                    float4 _978 = float4(in.in_var_ATTRIBUTE15.y);
                    int _981 = int(in.in_var_ATTRIBUTE14.y) * 3;
                    float4 _997 = float4(in.in_var_ATTRIBUTE15.z);
                    int _1000 = int(in.in_var_ATTRIBUTE14.z) * 3;
                    float4 _1016 = float4(in.in_var_ATTRIBUTE15.w);
                    int _1019 = int(in.in_var_ATTRIBUTE14.w) * 3;
                    _1035 = float3x4((((_952 + (_959 * PreviousBoneMatrices.read(uint(uint(_962))))) + (_978 * PreviousBoneMatrices.read(uint(uint(_981))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019)))), (((_953 + (_959 * PreviousBoneMatrices.read(uint(uint(_962 + 1))))) + (_978 * PreviousBoneMatrices.read(uint(uint(_981 + 1))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000 + 1))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019 + 1)))), (((_954 + (_959 * PreviousBoneMatrices.read(uint(uint(_962 + 2))))) + (_978 * PreviousBoneMatrices.read(uint(uint(_981 + 2))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000 + 2))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019 + 2)))));
                }
                else
                {
                    _1035 = float3x4(_952, _953, _954);
                }
                _1036 = _1035;
            }
            else
            {
                _1036 = _583;
            }
            float4 _1048 = _915 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _1036) + in.in_var_ATTRIBUTE12, 1.0);
            if (_806)
            {
                _1061 = float4(mix(_1048.xyz, _425 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _1061 = _1048;
            break;
        }
    }
    float4 _1071 = View.View_TranslatedWorldToClip * float4(_867.xyz, 1.0);
    float4 _1080 = _1071;
    _1080.z = _1071.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1071.w) : 0.0);
    out.gl_Position = _1080;
    out.out_var_TEXCOORD6 = _1071;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_1061.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_890.x, _890.y, _890.z, _868.w);
    out.out_var_TEXCOORD11_centroid = float4(_889[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

