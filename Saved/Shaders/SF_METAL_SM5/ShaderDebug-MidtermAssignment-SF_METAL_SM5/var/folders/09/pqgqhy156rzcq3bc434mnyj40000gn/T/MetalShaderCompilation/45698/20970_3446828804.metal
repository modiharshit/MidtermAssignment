

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
    float4x4 ClothLocalToWorld;
    float4x4 PreviousClothLocalToWorld;
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

constant float3x3 _99 = {};
constant float4 _100 = {};

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
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_000051ea_cd726f04(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<uint> InputWeightStream [[texture(2)]], texture_buffer<float> GPUSkinApexCloth [[texture(3)]], texture_buffer<float> BoneMatrices [[texture(4)]], texture_buffer<float> PreviousBoneMatrices [[texture(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 5> _103;
    for (int _129 = 0; _129 < 5; )
    {
        uint _137 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_129)) * 4u;
        _103[_129].BaryCoordPos = GPUSkinApexCloth.read(uint(_137));
        _103[_129].BaryCoordNormal = GPUSkinApexCloth.read(uint((_137 + 1u)));
        _103[_129].BaryCoordTangent = GPUSkinApexCloth.read(uint((_137 + 2u)));
        uint4 _149 = as_type<uint4>(GPUSkinApexCloth.read(uint((_137 + 3u))));
        uint2 _150 = _149.xy;
        uint2 _153 = (_150 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _103[_129].SimulIndices = uint4(_103[_129].SimulIndices.x, _153.x, _103[_129].SimulIndices.z, _153.y);
        uint2 _157 = _150 & uint2(65535u);
        _103[_129].SimulIndices = uint4(_157.x, _103[_129].SimulIndices.y, _157.y, _103[_129].SimulIndices.w);
        _103[_129].Weight = as_type<float>(_149.z);
        _129++;
        continue;
    }
    float3 _425;
    float3 _426;
    if (_103[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _104;
        _104 = _103;
        float3 _173;
        float _176;
        int _178;
        _173 = float3(0.0);
        _176 = 0.0;
        _178 = 0;
        float3 _174;
        float _177;
        int _179;
        for (int _180 = 0; _180 < 5; _173 = _174, _176 = _177, _178 = _179, _180++)
        {
            if (_104[_180].SimulIndices.w < 65535u)
            {
                int _197 = int(_104[_180].SimulIndices.x) * 3;
                uint _202 = uint(_197 + 1);
                int _214 = int(_104[_180].SimulIndices.y) * 3;
                uint _218 = uint(_214 + 1);
                int _228 = int(_104[_180].SimulIndices.z) * 3;
                uint _232 = uint(_228 + 1);
                _174 = _173 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_197))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_202)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_202)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_197 + 2))).xy, 0.0)).xyz * _104[_180].BaryCoordPos.w)) * _104[_180].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_214))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_218)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_218)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_214 + 2))).xy, 0.0)).xyz * _104[_180].BaryCoordPos.w)) * _104[_180].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_228))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_232)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_232)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_228 + 2))).xy, 0.0)).xyz * _104[_180].BaryCoordPos.w)) * ((1.0 - _104[_180].BaryCoordPos.x) - _104[_180].BaryCoordPos.y))) * _104[_180].Weight);
                _177 = _176 + _104[_180].Weight;
                _179 = _178 + 1;
            }
            else
            {
                _174 = _173;
                _177 = _176;
                _179 = _178;
            }
        }
        float3 _297;
        if ((_178 > 0) && (_176 > 9.9999997473787516355514526367188e-05))
        {
            _297 = _173 * (1.0 / _176);
        }
        else
        {
            _297 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 5> _105;
        _105 = _103;
        float3 _300;
        float _303;
        int _305;
        _300 = float3(0.0);
        _303 = 0.0;
        _305 = 0;
        float3 _301;
        float _304;
        int _306;
        for (int _307 = 0; _307 < 5; _300 = _301, _303 = _304, _305 = _306, _307++)
        {
            if (_105[_307].SimulIndices.w < 65535u)
            {
                int _324 = int(_105[_307].SimulIndices.x) * 3;
                uint _329 = uint(_324 + 1);
                int _341 = int(_105[_307].SimulIndices.y) * 3;
                uint _345 = uint(_341 + 1);
                int _355 = int(_105[_307].SimulIndices.z) * 3;
                uint _359 = uint(_355 + 1);
                _301 = _300 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_324))).xy, ClothSimulVertsPositionsNormals.read(uint(_329)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_329)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_324 + 2))).xy, 0.0)).xyz * _105[_307].BaryCoordPos.w)) * _105[_307].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_341))).xy, ClothSimulVertsPositionsNormals.read(uint(_345)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_345)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_341 + 2))).xy, 0.0)).xyz * _105[_307].BaryCoordPos.w)) * _105[_307].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_355))).xy, ClothSimulVertsPositionsNormals.read(uint(_359)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_359)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_355 + 2))).xy, 0.0)).xyz * _105[_307].BaryCoordPos.w)) * ((1.0 - _105[_307].BaryCoordPos.x) - _105[_307].BaryCoordPos.y))) * _105[_307].Weight);
                _304 = _303 + _105[_307].Weight;
                _306 = _305 + 1;
            }
            else
            {
                _301 = _300;
                _304 = _303;
                _306 = _305;
            }
        }
        float3 _424;
        if ((_305 > 0) && (_303 > 9.9999997473787516355514526367188e-05))
        {
            _424 = _300 * (1.0 / _303);
        }
        else
        {
            _424 = float3(0.0);
        }
        _425 = _424;
        _426 = _297;
    }
    else
    {
        _425 = in.in_var_ATTRIBUTE0.xyz;
        _426 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _428 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _431 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _437 = int(_431 + (_Globals.InputWeightIndexSize * uint(_428)));
    float3x4 _439;
    _439 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _440;
    for (int _442 = 0; _442 < _428; _439 = _440, _442++)
    {
        int _450 = int(_431 + (_Globals.InputWeightIndexSize * uint(_442)));
        int _455 = int(InputWeightStream.read(uint(uint(_450))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _501 = float4(float(InputWeightStream.read(uint(uint(_437 + _442))).x) * 0.0039215688593685626983642578125);
            int _502 = int((InputWeightStream.read(uint(uint(_450 + 1))).x << 8u) | uint(_455)) * 3;
            _440 = float3x4(_439[0] + (_501 * BoneMatrices.read(uint(uint(_502)))), _439[1] + (_501 * BoneMatrices.read(uint(uint(_502 + 1)))), _439[2] + (_501 * BoneMatrices.read(uint(uint(_502 + 2)))));
        }
        else
        {
            float4 _466 = float4(float(InputWeightStream.read(uint(uint(_437 + _442))).x) * 0.0039215688593685626983642578125);
            int _467 = _455 * 3;
            _440 = float3x4(_439[0] + (_466 * BoneMatrices.read(uint(uint(_467)))), _439[1] + (_466 * BoneMatrices.read(uint(uint(_467 + 1)))), _439[2] + (_466 * BoneMatrices.read(uint(uint(_467 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _102;
    _102 = _103;
    float _704;
    float3x3 _705;
    if (_102[0].SimulIndices.w < 65535u)
    {
        float _533;
        float3 _536;
        float3 _538;
        float _540;
        int _542;
        _533 = _Globals.ClothBlendWeight;
        _536 = float3(0.0);
        _538 = float3(0.0);
        _540 = 0.0;
        _542 = 0;
        float _534;
        float3 _537;
        float3 _539;
        float _541;
        int _543;
        for (int _544 = 0; _544 < 5; _533 = _534, _536 = _537, _538 = _539, _540 = _541, _542 = _543, _544++)
        {
            bool _556 = _102[_544].SimulIndices.w < 65535u;
            if (_556)
            {
                int _562 = int(_102[_544].SimulIndices.x) * 3;
                uint _567 = uint(_562 + 1);
                float3 _576 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_562))).xy, ClothSimulVertsPositionsNormals.read(uint(_567)).x, 1.0)).xyz;
                int _579 = int(_102[_544].SimulIndices.y) * 3;
                uint _583 = uint(_579 + 1);
                float3 _590 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_579))).xy, ClothSimulVertsPositionsNormals.read(uint(_583)).x, 1.0)).xyz;
                int _593 = int(_102[_544].SimulIndices.z) * 3;
                uint _597 = uint(_593 + 1);
                float3 _604 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_593))).xy, ClothSimulVertsPositionsNormals.read(uint(_597)).x, 1.0)).xyz;
                float3 _614 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_567)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_562 + 2))).xy, 0.0)).xyz;
                float3 _624 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_583)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_579 + 2))).xy, 0.0)).xyz;
                float3 _634 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_597)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_593 + 2))).xy, 0.0)).xyz;
                _537 = _536 + (((((_576 + (_614 * _102[_544].BaryCoordNormal.w)) * _102[_544].BaryCoordNormal.x) + ((_590 + (_624 * _102[_544].BaryCoordNormal.w)) * _102[_544].BaryCoordNormal.y)) + ((_604 + (_634 * _102[_544].BaryCoordNormal.w)) * _102[_544].BaryCoordNormal.z)) * _102[_544].Weight);
                _539 = _538 + (((((_576 + (_614 * _102[_544].BaryCoordTangent.w)) * _102[_544].BaryCoordTangent.x) + ((_590 + (_624 * _102[_544].BaryCoordTangent.w)) * _102[_544].BaryCoordTangent.y)) + ((_604 + (_634 * _102[_544].BaryCoordTangent.w)) * _102[_544].BaryCoordTangent.z)) * _102[_544].Weight);
                _541 = _540 + _102[_544].Weight;
                _543 = _542 + 1;
            }
            else
            {
                _537 = _536;
                _539 = _538;
                _541 = _540;
                _543 = _542;
            }
            _534 = _556 ? _Globals.ClothBlendWeight : _533;
        }
        bool _672 = (_542 > 0) && (_540 > 9.9999997473787516355514526367188e-05);
        float3x3 _696;
        if (_672)
        {
            float _676 = 1.0 / _540;
            float3x3 _691 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _693 = _99;
            _693[0] = _691 * normalize((_538 * _676) - _425);
            float3x3 _695 = _693;
            _695[2] = _691 * normalize((_536 * _676) - _425);
            _696 = _695;
        }
        else
        {
            _696 = _99;
        }
        float3x3 _703 = _696;
        _703[1] = cross(_696[2], _696[0]) * in.in_var_ATTRIBUTE2.w;
        _704 = _672 ? _533 : 0.0;
        _705 = _703;
    }
    else
    {
        _704 = 0.0;
        _705 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _744;
    float3 _711 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _439);
    float3 _717 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _439);
    float3 _722 = float3(_704);
    float3 _730 = float3(1.0 - _704);
    float4 _805;
    switch (0u)
    {
        default:
        {
            _744 = _103[0].SimulIndices.w < 65535u;
            if (_744)
            {
                _805 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _439) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _425, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _754 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _439) + in.in_var_ATTRIBUTE12;
                _805 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _754.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _754.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _754.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _806 = _100;
    _806.w = 0.0;
    float3x3 _820 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _820[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _823 = _820;
    _823[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _826 = _823;
    _826[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _827 = _826 * float3x3((_705[0] * _722) + (_711 * _730), (_705[1] * _722) + (normalize(cross(_717, _711) * in.in_var_ATTRIBUTE2.w) * _730), (_705[2] * _722) + (_717 * _730));
    float3 _828 = _827[0];
    float4 _968;
    switch (0u)
    {
        default:
        {
            float4x4 _845 = Primitive.Primitive_PreviousLocalToWorld;
            _845[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _849 = _845;
            _849[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _853 = _849;
            _853[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _943;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float3x4 _860;
                _860 = float3x4(float4(0.0), float4(0.0), float4(0.0));
                float3x4 _861;
                for (int _863 = 0; _863 < _428; _860 = _861, _863++)
                {
                    int _871 = int(_431 + (_Globals.InputWeightIndexSize * uint(_863)));
                    int _876 = int(InputWeightStream.read(uint(uint(_871))).x);
                    if (_Globals.InputWeightIndexSize > 1u)
                    {
                        float4 _922 = float4(float(InputWeightStream.read(uint(uint(_437 + _863))).x) * 0.0039215688593685626983642578125);
                        int _923 = int((InputWeightStream.read(uint(uint(_871 + 1))).x << 8u) | uint(_876)) * 3;
                        _861 = float3x4(_860[0] + (_922 * PreviousBoneMatrices.read(uint(uint(_923)))), _860[1] + (_922 * PreviousBoneMatrices.read(uint(uint(_923 + 1)))), _860[2] + (_922 * PreviousBoneMatrices.read(uint(uint(_923 + 2)))));
                    }
                    else
                    {
                        float4 _887 = float4(float(InputWeightStream.read(uint(uint(_437 + _863))).x) * 0.0039215688593685626983642578125);
                        int _888 = _876 * 3;
                        _861 = float3x4(_860[0] + (_887 * PreviousBoneMatrices.read(uint(uint(_888)))), _860[1] + (_887 * PreviousBoneMatrices.read(uint(uint(_888 + 1)))), _860[2] + (_887 * PreviousBoneMatrices.read(uint(uint(_888 + 2)))));
                    }
                }
                _943 = _860;
            }
            else
            {
                _943 = _439;
            }
            float4 _955 = _853 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _943) + in.in_var_ATTRIBUTE12, 1.0);
            if (_744)
            {
                _968 = float4(mix(_955.xyz, _426 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _968 = _955;
            break;
        }
    }
    float4 _978 = View.View_TranslatedWorldToClip * float4(_805.xyz, 1.0);
    float4 _987 = _978;
    _987.z = _978.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _978.w) : 0.0);
    out.gl_Position = _987;
    out.out_var_TEXCOORD6 = _978;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_968.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_828.x, _828.y, _828.z, _806.w);
    out.out_var_TEXCOORD11_centroid = float4(_827[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

