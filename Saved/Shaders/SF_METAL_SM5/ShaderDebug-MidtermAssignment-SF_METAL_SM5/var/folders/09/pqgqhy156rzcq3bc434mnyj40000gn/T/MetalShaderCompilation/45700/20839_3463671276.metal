

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

constant float3x3 _98 = {};
constant float4 _99 = {};

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

vertex MainVertexShader_out Main_00005167_ce736dec(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<uint> InputWeightStream [[texture(2)]], texture_buffer<float> GPUSkinApexCloth [[texture(3)]], texture_buffer<float> BoneMatrices [[texture(4)]], texture_buffer<float> PreviousBoneMatrices [[texture(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 1> _102;
    for (int _128 = 0; _128 < 1; )
    {
        uint _135 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_128)) * 4u;
        _102[_128].BaryCoordPos = GPUSkinApexCloth.read(uint(_135));
        _102[_128].BaryCoordNormal = GPUSkinApexCloth.read(uint((_135 + 1u)));
        _102[_128].BaryCoordTangent = GPUSkinApexCloth.read(uint((_135 + 2u)));
        uint4 _147 = as_type<uint4>(GPUSkinApexCloth.read(uint((_135 + 3u))));
        uint2 _148 = _147.xy;
        uint2 _151 = (_148 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _102[_128].SimulIndices = uint4(_102[_128].SimulIndices.x, _151.x, _102[_128].SimulIndices.z, _151.y);
        uint2 _155 = _148 & uint2(65535u);
        _102[_128].SimulIndices = uint4(_155.x, _102[_128].SimulIndices.y, _155.y, _102[_128].SimulIndices.w);
        _102[_128].Weight = as_type<float>(_147.z);
        _128++;
        continue;
    }
    float3 _419;
    float3 _420;
    if (_102[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _103;
        _103 = _102;
        float3 _171;
        float _174;
        int _176;
        _171 = float3(0.0);
        _174 = 0.0;
        _176 = 0;
        float _175;
        float3 _172;
        int _177;
        for (int _178 = 0; _178 < 1; _171 = _172, _174 = _175, _176 = _177, _178++)
        {
            bool _188 = _103[_178].SimulIndices.w < 65535u;
            if (_188)
            {
                int _194 = int(_103[_178].SimulIndices.x) * 3;
                uint _199 = uint(_194 + 1);
                int _211 = int(_103[_178].SimulIndices.y) * 3;
                uint _215 = uint(_211 + 1);
                int _225 = int(_103[_178].SimulIndices.z) * 3;
                uint _229 = uint(_225 + 1);
                _172 = _171 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_194))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_199)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_199)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_194 + 2))).xy, 0.0)).xyz * _103[_178].BaryCoordPos.w)) * _103[_178].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_215)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _103[_178].BaryCoordPos.w)) * _103[_178].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_225))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_229)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_229)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_225 + 2))).xy, 0.0)).xyz * _103[_178].BaryCoordPos.w)) * ((1.0 - _103[_178].BaryCoordPos.x) - _103[_178].BaryCoordPos.y))) * 1.0);
                _177 = _176 + 1;
            }
            else
            {
                _172 = _171;
                _177 = _176;
            }
            _175 = _188 ? 1.0 : _174;
        }
        float3 _293;
        if ((_176 > 0) && (_174 > 9.9999997473787516355514526367188e-05))
        {
            _293 = _171 * (1.0 / _174);
        }
        else
        {
            _293 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 1> _104;
        _104 = _102;
        float3 _296;
        float _299;
        int _301;
        _296 = float3(0.0);
        _299 = 0.0;
        _301 = 0;
        float _300;
        float3 _297;
        int _302;
        for (int _303 = 0; _303 < 1; _296 = _297, _299 = _300, _301 = _302, _303++)
        {
            bool _313 = _104[_303].SimulIndices.w < 65535u;
            if (_313)
            {
                int _319 = int(_104[_303].SimulIndices.x) * 3;
                uint _324 = uint(_319 + 1);
                int _336 = int(_104[_303].SimulIndices.y) * 3;
                uint _340 = uint(_336 + 1);
                int _350 = int(_104[_303].SimulIndices.z) * 3;
                uint _354 = uint(_350 + 1);
                _297 = _296 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_319))).xy, ClothSimulVertsPositionsNormals.read(uint(_324)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_324)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_319 + 2))).xy, 0.0)).xyz * _104[_303].BaryCoordPos.w)) * _104[_303].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_336))).xy, ClothSimulVertsPositionsNormals.read(uint(_340)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_340)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_336 + 2))).xy, 0.0)).xyz * _104[_303].BaryCoordPos.w)) * _104[_303].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_350))).xy, ClothSimulVertsPositionsNormals.read(uint(_354)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_354)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_350 + 2))).xy, 0.0)).xyz * _104[_303].BaryCoordPos.w)) * ((1.0 - _104[_303].BaryCoordPos.x) - _104[_303].BaryCoordPos.y))) * 1.0);
                _302 = _301 + 1;
            }
            else
            {
                _297 = _296;
                _302 = _301;
            }
            _300 = _313 ? 1.0 : _299;
        }
        float3 _418;
        if ((_301 > 0) && (_299 > 9.9999997473787516355514526367188e-05))
        {
            _418 = _296 * (1.0 / _299);
        }
        else
        {
            _418 = float3(0.0);
        }
        _419 = _418;
        _420 = _293;
    }
    else
    {
        _419 = in.in_var_ATTRIBUTE0.xyz;
        _420 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _422 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _425 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _431 = int(_425 + (_Globals.InputWeightIndexSize * uint(_422)));
    float3x4 _433;
    _433 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _434;
    for (int _436 = 0; _436 < _422; _433 = _434, _436++)
    {
        int _444 = int(_425 + (_Globals.InputWeightIndexSize * uint(_436)));
        int _449 = int(InputWeightStream.read(uint(uint(_444))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _495 = float4(float(InputWeightStream.read(uint(uint(_431 + _436))).x) * 0.0039215688593685626983642578125);
            int _496 = int((InputWeightStream.read(uint(uint(_444 + 1))).x << 8u) | uint(_449)) * 3;
            _434 = float3x4(_433[0] + (_495 * BoneMatrices.read(uint(uint(_496)))), _433[1] + (_495 * BoneMatrices.read(uint(uint(_496 + 1)))), _433[2] + (_495 * BoneMatrices.read(uint(uint(_496 + 2)))));
        }
        else
        {
            float4 _460 = float4(float(InputWeightStream.read(uint(uint(_431 + _436))).x) * 0.0039215688593685626983642578125);
            int _461 = _449 * 3;
            _434 = float3x4(_433[0] + (_460 * BoneMatrices.read(uint(uint(_461)))), _433[1] + (_460 * BoneMatrices.read(uint(uint(_461 + 1)))), _433[2] + (_460 * BoneMatrices.read(uint(uint(_461 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _101;
    _101 = _102;
    float _696;
    float3x3 _697;
    if (_101[0].SimulIndices.w < 65535u)
    {
        float _527;
        float3 _530;
        float3 _532;
        float _534;
        int _536;
        _527 = _Globals.ClothBlendWeight;
        _530 = float3(0.0);
        _532 = float3(0.0);
        _534 = 0.0;
        _536 = 0;
        float _528;
        float _535;
        float3 _531;
        float3 _533;
        int _537;
        for (int _538 = 0; _538 < 1; _527 = _528, _530 = _531, _532 = _533, _534 = _535, _536 = _537, _538++)
        {
            bool _549 = _101[_538].SimulIndices.w < 65535u;
            if (_549)
            {
                int _555 = int(_101[_538].SimulIndices.x) * 3;
                uint _560 = uint(_555 + 1);
                float3 _569 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_555))).xy, ClothSimulVertsPositionsNormals.read(uint(_560)).x, 1.0)).xyz;
                int _572 = int(_101[_538].SimulIndices.y) * 3;
                uint _576 = uint(_572 + 1);
                float3 _583 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_572))).xy, ClothSimulVertsPositionsNormals.read(uint(_576)).x, 1.0)).xyz;
                int _586 = int(_101[_538].SimulIndices.z) * 3;
                uint _590 = uint(_586 + 1);
                float3 _597 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_586))).xy, ClothSimulVertsPositionsNormals.read(uint(_590)).x, 1.0)).xyz;
                float3 _607 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_560)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_555 + 2))).xy, 0.0)).xyz;
                float3 _617 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_576)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_572 + 2))).xy, 0.0)).xyz;
                float3 _627 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_590)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_586 + 2))).xy, 0.0)).xyz;
                _531 = _530 + (((((_569 + (_607 * _101[_538].BaryCoordNormal.w)) * _101[_538].BaryCoordNormal.x) + ((_583 + (_617 * _101[_538].BaryCoordNormal.w)) * _101[_538].BaryCoordNormal.y)) + ((_597 + (_627 * _101[_538].BaryCoordNormal.w)) * _101[_538].BaryCoordNormal.z)) * 1.0);
                _533 = _532 + (((((_569 + (_607 * _101[_538].BaryCoordTangent.w)) * _101[_538].BaryCoordTangent.x) + ((_583 + (_617 * _101[_538].BaryCoordTangent.w)) * _101[_538].BaryCoordTangent.y)) + ((_597 + (_627 * _101[_538].BaryCoordTangent.w)) * _101[_538].BaryCoordTangent.z)) * 1.0);
                _537 = _536 + 1;
            }
            else
            {
                _531 = _530;
                _533 = _532;
                _537 = _536;
            }
            _528 = _549 ? _Globals.ClothBlendWeight : _527;
            _535 = _549 ? 1.0 : _534;
        }
        bool _664 = (_536 > 0) && (_534 > 9.9999997473787516355514526367188e-05);
        float3x3 _688;
        if (_664)
        {
            float _668 = 1.0 / _534;
            float3x3 _683 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _685 = _98;
            _685[0] = _683 * normalize((_532 * _668) - _419);
            float3x3 _687 = _685;
            _687[2] = _683 * normalize((_530 * _668) - _419);
            _688 = _687;
        }
        else
        {
            _688 = _98;
        }
        float3x3 _695 = _688;
        _695[1] = cross(_688[2], _688[0]) * in.in_var_ATTRIBUTE2.w;
        _696 = _664 ? _527 : 0.0;
        _697 = _695;
    }
    else
    {
        _696 = 0.0;
        _697 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _736;
    float3 _703 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _433);
    float3 _709 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _433);
    float3 _714 = float3(_696);
    float3 _722 = float3(1.0 - _696);
    float4 _797;
    switch (0u)
    {
        default:
        {
            _736 = _102[0].SimulIndices.w < 65535u;
            if (_736)
            {
                _797 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _433) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _419, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _746 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _433) + in.in_var_ATTRIBUTE12;
                _797 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _746.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _746.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _746.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _798 = _99;
    _798.w = 0.0;
    float3x3 _812 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _812[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _815 = _812;
    _815[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _818 = _815;
    _818[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _819 = _818 * float3x3((_697[0] * _714) + (_703 * _722), (_697[1] * _714) + (normalize(cross(_709, _703) * in.in_var_ATTRIBUTE2.w) * _722), (_697[2] * _714) + (_709 * _722));
    float3 _820 = _819[0];
    float4 _960;
    switch (0u)
    {
        default:
        {
            float4x4 _837 = Primitive.Primitive_PreviousLocalToWorld;
            _837[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _841 = _837;
            _841[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _845 = _841;
            _845[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _935;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float3x4 _852;
                _852 = float3x4(float4(0.0), float4(0.0), float4(0.0));
                float3x4 _853;
                for (int _855 = 0; _855 < _422; _852 = _853, _855++)
                {
                    int _863 = int(_425 + (_Globals.InputWeightIndexSize * uint(_855)));
                    int _868 = int(InputWeightStream.read(uint(uint(_863))).x);
                    if (_Globals.InputWeightIndexSize > 1u)
                    {
                        float4 _914 = float4(float(InputWeightStream.read(uint(uint(_431 + _855))).x) * 0.0039215688593685626983642578125);
                        int _915 = int((InputWeightStream.read(uint(uint(_863 + 1))).x << 8u) | uint(_868)) * 3;
                        _853 = float3x4(_852[0] + (_914 * PreviousBoneMatrices.read(uint(uint(_915)))), _852[1] + (_914 * PreviousBoneMatrices.read(uint(uint(_915 + 1)))), _852[2] + (_914 * PreviousBoneMatrices.read(uint(uint(_915 + 2)))));
                    }
                    else
                    {
                        float4 _879 = float4(float(InputWeightStream.read(uint(uint(_431 + _855))).x) * 0.0039215688593685626983642578125);
                        int _880 = _868 * 3;
                        _853 = float3x4(_852[0] + (_879 * PreviousBoneMatrices.read(uint(uint(_880)))), _852[1] + (_879 * PreviousBoneMatrices.read(uint(uint(_880 + 1)))), _852[2] + (_879 * PreviousBoneMatrices.read(uint(uint(_880 + 2)))));
                    }
                }
                _935 = _852;
            }
            else
            {
                _935 = _433;
            }
            float4 _947 = _845 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _935) + in.in_var_ATTRIBUTE12, 1.0);
            if (_736)
            {
                _960 = float4(mix(_947.xyz, _420 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _960 = _947;
            break;
        }
    }
    float4 _970 = View.View_TranslatedWorldToClip * float4(_797.xyz, 1.0);
    float4 _979 = _970;
    _979.z = _970.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _970.w) : 0.0);
    out.gl_Position = _979;
    out.out_var_TEXCOORD6 = _970;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_960.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_820.x, _820.y, _820.z, _798.w);
    out.out_var_TEXCOORD11_centroid = float4(_819[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

