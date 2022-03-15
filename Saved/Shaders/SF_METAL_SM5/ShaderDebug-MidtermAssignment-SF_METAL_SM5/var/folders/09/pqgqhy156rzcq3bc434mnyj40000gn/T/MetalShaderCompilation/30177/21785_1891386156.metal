

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

constant spvUnsafeArray<float2, 1> _102 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _110 = {};
constant float4 _111 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10_centroid [[user(locn2)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn3)]];
    float4 out_var_TEXCOORD0_0 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex MainVertexShader_out Main_00005519_70bc432c(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<uint> InputWeightStream [[texture(2)]], texture_buffer<float> GPUSkinApexCloth [[texture(3)]], texture_buffer<float> BoneMatrices [[texture(4)]], texture_buffer<float> PreviousBoneMatrices [[texture(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _115;
    for (int _143 = 0; _143 < 5; )
    {
        uint _151 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_143)) * 4u;
        _115[_143].BaryCoordPos = GPUSkinApexCloth.read(uint(_151));
        _115[_143].BaryCoordNormal = GPUSkinApexCloth.read(uint((_151 + 1u)));
        _115[_143].BaryCoordTangent = GPUSkinApexCloth.read(uint((_151 + 2u)));
        uint4 _163 = as_type<uint4>(GPUSkinApexCloth.read(uint((_151 + 3u))));
        uint2 _164 = _163.xy;
        uint2 _167 = (_164 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _115[_143].SimulIndices = uint4(_115[_143].SimulIndices.x, _167.x, _115[_143].SimulIndices.z, _167.y);
        uint2 _171 = _164 & uint2(65535u);
        _115[_143].SimulIndices = uint4(_171.x, _115[_143].SimulIndices.y, _171.y, _115[_143].SimulIndices.w);
        _115[_143].Weight = as_type<float>(_163.z);
        _143++;
        continue;
    }
    float3 _439;
    float3 _440;
    if (_115[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _117;
        _117 = _115;
        float3 _187;
        float _190;
        int _192;
        _187 = float3(0.0);
        _190 = 0.0;
        _192 = 0;
        float3 _188;
        float _191;
        int _193;
        for (int _194 = 0; _194 < 5; _187 = _188, _190 = _191, _192 = _193, _194++)
        {
            if (_117[_194].SimulIndices.w < 65535u)
            {
                int _211 = int(_117[_194].SimulIndices.x) * 3;
                uint _216 = uint(_211 + 1);
                int _228 = int(_117[_194].SimulIndices.y) * 3;
                uint _232 = uint(_228 + 1);
                int _242 = int(_117[_194].SimulIndices.z) * 3;
                uint _246 = uint(_242 + 1);
                _188 = _187 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_211))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_216)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_216)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_211 + 2))).xy, 0.0)).xyz * _117[_194].BaryCoordPos.w)) * _117[_194].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_228))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_232)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_232)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_228 + 2))).xy, 0.0)).xyz * _117[_194].BaryCoordPos.w)) * _117[_194].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_242))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_246)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_246)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_242 + 2))).xy, 0.0)).xyz * _117[_194].BaryCoordPos.w)) * ((1.0 - _117[_194].BaryCoordPos.x) - _117[_194].BaryCoordPos.y))) * _117[_194].Weight);
                _191 = _190 + _117[_194].Weight;
                _193 = _192 + 1;
            }
            else
            {
                _188 = _187;
                _191 = _190;
                _193 = _192;
            }
        }
        float3 _311;
        if ((_192 > 0) && (_190 > 9.9999997473787516355514526367188e-05))
        {
            _311 = _187 * (1.0 / _190);
        }
        else
        {
            _311 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 5> _118;
        _118 = _115;
        float3 _314;
        float _317;
        int _319;
        _314 = float3(0.0);
        _317 = 0.0;
        _319 = 0;
        float3 _315;
        float _318;
        int _320;
        for (int _321 = 0; _321 < 5; _314 = _315, _317 = _318, _319 = _320, _321++)
        {
            if (_118[_321].SimulIndices.w < 65535u)
            {
                int _338 = int(_118[_321].SimulIndices.x) * 3;
                uint _343 = uint(_338 + 1);
                int _355 = int(_118[_321].SimulIndices.y) * 3;
                uint _359 = uint(_355 + 1);
                int _369 = int(_118[_321].SimulIndices.z) * 3;
                uint _373 = uint(_369 + 1);
                _315 = _314 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_338))).xy, ClothSimulVertsPositionsNormals.read(uint(_343)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_343)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_338 + 2))).xy, 0.0)).xyz * _118[_321].BaryCoordPos.w)) * _118[_321].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_355))).xy, ClothSimulVertsPositionsNormals.read(uint(_359)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_359)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_355 + 2))).xy, 0.0)).xyz * _118[_321].BaryCoordPos.w)) * _118[_321].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_369))).xy, ClothSimulVertsPositionsNormals.read(uint(_373)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_373)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_369 + 2))).xy, 0.0)).xyz * _118[_321].BaryCoordPos.w)) * ((1.0 - _118[_321].BaryCoordPos.x) - _118[_321].BaryCoordPos.y))) * _118[_321].Weight);
                _318 = _317 + _118[_321].Weight;
                _320 = _319 + 1;
            }
            else
            {
                _315 = _314;
                _318 = _317;
                _320 = _319;
            }
        }
        float3 _438;
        if ((_319 > 0) && (_317 > 9.9999997473787516355514526367188e-05))
        {
            _438 = _314 * (1.0 / _317);
        }
        else
        {
            _438 = float3(0.0);
        }
        _439 = _438;
        _440 = _311;
    }
    else
    {
        _439 = in.in_var_ATTRIBUTE0.xyz;
        _440 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _442 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _445 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _451 = int(_445 + (_Globals.InputWeightIndexSize * uint(_442)));
    float3x4 _453;
    _453 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _454;
    for (int _456 = 0; _456 < _442; _453 = _454, _456++)
    {
        int _464 = int(_445 + (_Globals.InputWeightIndexSize * uint(_456)));
        int _469 = int(InputWeightStream.read(uint(uint(_464))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _515 = float4(float(InputWeightStream.read(uint(uint(_451 + _456))).x) * 0.0039215688593685626983642578125);
            int _516 = int((InputWeightStream.read(uint(uint(_464 + 1))).x << 8u) | uint(_469)) * 3;
            _454 = float3x4(_453[0] + (_515 * BoneMatrices.read(uint(uint(_516)))), _453[1] + (_515 * BoneMatrices.read(uint(uint(_516 + 1)))), _453[2] + (_515 * BoneMatrices.read(uint(uint(_516 + 2)))));
        }
        else
        {
            float4 _480 = float4(float(InputWeightStream.read(uint(uint(_451 + _456))).x) * 0.0039215688593685626983642578125);
            int _481 = _469 * 3;
            _454 = float3x4(_453[0] + (_480 * BoneMatrices.read(uint(uint(_481)))), _453[1] + (_480 * BoneMatrices.read(uint(uint(_481 + 1)))), _453[2] + (_480 * BoneMatrices.read(uint(uint(_481 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _114;
    _114 = _115;
    float _718;
    float3x3 _719;
    if (_114[0].SimulIndices.w < 65535u)
    {
        float _547;
        float3 _550;
        float3 _552;
        float _554;
        int _556;
        _547 = _Globals.ClothBlendWeight;
        _550 = float3(0.0);
        _552 = float3(0.0);
        _554 = 0.0;
        _556 = 0;
        float _548;
        float3 _551;
        float3 _553;
        float _555;
        int _557;
        for (int _558 = 0; _558 < 5; _547 = _548, _550 = _551, _552 = _553, _554 = _555, _556 = _557, _558++)
        {
            bool _570 = _114[_558].SimulIndices.w < 65535u;
            if (_570)
            {
                int _576 = int(_114[_558].SimulIndices.x) * 3;
                uint _581 = uint(_576 + 1);
                float3 _590 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_576))).xy, ClothSimulVertsPositionsNormals.read(uint(_581)).x, 1.0)).xyz;
                int _593 = int(_114[_558].SimulIndices.y) * 3;
                uint _597 = uint(_593 + 1);
                float3 _604 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_593))).xy, ClothSimulVertsPositionsNormals.read(uint(_597)).x, 1.0)).xyz;
                int _607 = int(_114[_558].SimulIndices.z) * 3;
                uint _611 = uint(_607 + 1);
                float3 _618 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_607))).xy, ClothSimulVertsPositionsNormals.read(uint(_611)).x, 1.0)).xyz;
                float3 _628 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_581)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_576 + 2))).xy, 0.0)).xyz;
                float3 _638 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_597)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_593 + 2))).xy, 0.0)).xyz;
                float3 _648 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_611)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_607 + 2))).xy, 0.0)).xyz;
                _551 = _550 + (((((_590 + (_628 * _114[_558].BaryCoordNormal.w)) * _114[_558].BaryCoordNormal.x) + ((_604 + (_638 * _114[_558].BaryCoordNormal.w)) * _114[_558].BaryCoordNormal.y)) + ((_618 + (_648 * _114[_558].BaryCoordNormal.w)) * _114[_558].BaryCoordNormal.z)) * _114[_558].Weight);
                _553 = _552 + (((((_590 + (_628 * _114[_558].BaryCoordTangent.w)) * _114[_558].BaryCoordTangent.x) + ((_604 + (_638 * _114[_558].BaryCoordTangent.w)) * _114[_558].BaryCoordTangent.y)) + ((_618 + (_648 * _114[_558].BaryCoordTangent.w)) * _114[_558].BaryCoordTangent.z)) * _114[_558].Weight);
                _555 = _554 + _114[_558].Weight;
                _557 = _556 + 1;
            }
            else
            {
                _551 = _550;
                _553 = _552;
                _555 = _554;
                _557 = _556;
            }
            _548 = _570 ? _Globals.ClothBlendWeight : _547;
        }
        bool _686 = (_556 > 0) && (_554 > 9.9999997473787516355514526367188e-05);
        float3x3 _710;
        if (_686)
        {
            float _690 = 1.0 / _554;
            float3x3 _705 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _707 = _110;
            _707[0] = _705 * normalize((_552 * _690) - _439);
            float3x3 _709 = _707;
            _709[2] = _705 * normalize((_550 * _690) - _439);
            _710 = _709;
        }
        else
        {
            _710 = _110;
        }
        float3x3 _717 = _710;
        _717[1] = cross(_710[2], _710[0]) * in.in_var_ATTRIBUTE2.w;
        _718 = _686 ? _547 : 0.0;
        _719 = _717;
    }
    else
    {
        _718 = 0.0;
        _719 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _758;
    float3 _725 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _453);
    float3 _731 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _453);
    float3 _736 = float3(_718);
    float3 _744 = float3(1.0 - _718);
    float4 _819;
    switch (0u)
    {
        default:
        {
            _758 = _115[0].SimulIndices.w < 65535u;
            if (_758)
            {
                _819 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _439, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _768 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _453) + in.in_var_ATTRIBUTE12;
                _819 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _768.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _768.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _768.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _113;
    _113 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _116 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _821 = 0; _821 < 1; )
    {
        _116[_821] = _113[_821];
        _821++;
        continue;
    }
    float4 _832 = _111;
    _832.w = 0.0;
    float3x3 _846 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _846[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _849 = _846;
    _849[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _852 = _849;
    _852[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _853 = _852 * float3x3((_719[0] * _736) + (_725 * _744), (_719[1] * _736) + (normalize(cross(_731, _725) * in.in_var_ATTRIBUTE2.w) * _744), (_719[2] * _736) + (_731 * _744));
    float3 _854 = _853[0];
    spvUnsafeArray<float4, 1> _864 = { float4(_116[0].x, _116[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _995;
    switch (0u)
    {
        default:
        {
            float4x4 _872 = Primitive.Primitive_PreviousLocalToWorld;
            _872[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _876 = _872;
            _876[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _880 = _876;
            _880[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _970;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float3x4 _887;
                _887 = float3x4(float4(0.0), float4(0.0), float4(0.0));
                float3x4 _888;
                for (int _890 = 0; _890 < _442; _887 = _888, _890++)
                {
                    int _898 = int(_445 + (_Globals.InputWeightIndexSize * uint(_890)));
                    int _903 = int(InputWeightStream.read(uint(uint(_898))).x);
                    if (_Globals.InputWeightIndexSize > 1u)
                    {
                        float4 _949 = float4(float(InputWeightStream.read(uint(uint(_451 + _890))).x) * 0.0039215688593685626983642578125);
                        int _950 = int((InputWeightStream.read(uint(uint(_898 + 1))).x << 8u) | uint(_903)) * 3;
                        _888 = float3x4(_887[0] + (_949 * PreviousBoneMatrices.read(uint(uint(_950)))), _887[1] + (_949 * PreviousBoneMatrices.read(uint(uint(_950 + 1)))), _887[2] + (_949 * PreviousBoneMatrices.read(uint(uint(_950 + 2)))));
                    }
                    else
                    {
                        float4 _914 = float4(float(InputWeightStream.read(uint(uint(_451 + _890))).x) * 0.0039215688593685626983642578125);
                        int _915 = _903 * 3;
                        _888 = float3x4(_887[0] + (_914 * PreviousBoneMatrices.read(uint(uint(_915)))), _887[1] + (_914 * PreviousBoneMatrices.read(uint(uint(_915 + 1)))), _887[2] + (_914 * PreviousBoneMatrices.read(uint(uint(_915 + 2)))));
                    }
                }
                _970 = _887;
            }
            else
            {
                _970 = _453;
            }
            float4 _982 = _880 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _970) + in.in_var_ATTRIBUTE12, 1.0);
            if (_758)
            {
                _995 = float4(mix(_982.xyz, _440 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _995 = _982;
            break;
        }
    }
    float4 _1005 = View.View_TranslatedWorldToClip * float4(_819.xyz, 1.0);
    float4 _1014 = _1005;
    _1014.z = _1005.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1005.w) : 0.0);
    out.gl_Position = _1014;
    out.out_var_TEXCOORD6 = _1005;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_995.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_854.x, _854.y, _854.z, _832.w);
    out.out_var_TEXCOORD11_centroid = float4(_853[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _864;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

