

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

constant spvUnsafeArray<float2, 1> _101 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _109 = {};
constant float4 _110 = {};

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

vertex MainVertexShader_out Main_00005493_6debd790(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(6)]], constant type_Primitive& Primitive [[buffer(7)]], constant type_Globals& _Globals [[buffer(8)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<uint> InputWeightStream [[texture(2)]], texture_buffer<float> GPUSkinApexCloth [[texture(3)]], texture_buffer<float> BoneMatrices [[texture(4)]], texture_buffer<float> PreviousBoneMatrices [[texture(5)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _114;
    for (int _142 = 0; _142 < 1; )
    {
        uint _149 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_142)) * 4u;
        _114[_142].BaryCoordPos = GPUSkinApexCloth.read(uint(_149));
        _114[_142].BaryCoordNormal = GPUSkinApexCloth.read(uint((_149 + 1u)));
        _114[_142].BaryCoordTangent = GPUSkinApexCloth.read(uint((_149 + 2u)));
        uint4 _161 = as_type<uint4>(GPUSkinApexCloth.read(uint((_149 + 3u))));
        uint2 _162 = _161.xy;
        uint2 _165 = (_162 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _114[_142].SimulIndices = uint4(_114[_142].SimulIndices.x, _165.x, _114[_142].SimulIndices.z, _165.y);
        uint2 _169 = _162 & uint2(65535u);
        _114[_142].SimulIndices = uint4(_169.x, _114[_142].SimulIndices.y, _169.y, _114[_142].SimulIndices.w);
        _114[_142].Weight = as_type<float>(_161.z);
        _142++;
        continue;
    }
    float3 _433;
    float3 _434;
    if (_114[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _116;
        _116 = _114;
        float3 _185;
        float _188;
        int _190;
        _185 = float3(0.0);
        _188 = 0.0;
        _190 = 0;
        float _189;
        float3 _186;
        int _191;
        for (int _192 = 0; _192 < 1; _185 = _186, _188 = _189, _190 = _191, _192++)
        {
            bool _202 = _116[_192].SimulIndices.w < 65535u;
            if (_202)
            {
                int _208 = int(_116[_192].SimulIndices.x) * 3;
                uint _213 = uint(_208 + 1);
                int _225 = int(_116[_192].SimulIndices.y) * 3;
                uint _229 = uint(_225 + 1);
                int _239 = int(_116[_192].SimulIndices.z) * 3;
                uint _243 = uint(_239 + 1);
                _186 = _185 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_208))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_213)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_213)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_208 + 2))).xy, 0.0)).xyz * _116[_192].BaryCoordPos.w)) * _116[_192].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_225))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_229)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_229)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_225 + 2))).xy, 0.0)).xyz * _116[_192].BaryCoordPos.w)) * _116[_192].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_239))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_243)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_243)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_239 + 2))).xy, 0.0)).xyz * _116[_192].BaryCoordPos.w)) * ((1.0 - _116[_192].BaryCoordPos.x) - _116[_192].BaryCoordPos.y))) * 1.0);
                _191 = _190 + 1;
            }
            else
            {
                _186 = _185;
                _191 = _190;
            }
            _189 = _202 ? 1.0 : _188;
        }
        float3 _307;
        if ((_190 > 0) && (_188 > 9.9999997473787516355514526367188e-05))
        {
            _307 = _185 * (1.0 / _188);
        }
        else
        {
            _307 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 1> _117;
        _117 = _114;
        float3 _310;
        float _313;
        int _315;
        _310 = float3(0.0);
        _313 = 0.0;
        _315 = 0;
        float _314;
        float3 _311;
        int _316;
        for (int _317 = 0; _317 < 1; _310 = _311, _313 = _314, _315 = _316, _317++)
        {
            bool _327 = _117[_317].SimulIndices.w < 65535u;
            if (_327)
            {
                int _333 = int(_117[_317].SimulIndices.x) * 3;
                uint _338 = uint(_333 + 1);
                int _350 = int(_117[_317].SimulIndices.y) * 3;
                uint _354 = uint(_350 + 1);
                int _364 = int(_117[_317].SimulIndices.z) * 3;
                uint _368 = uint(_364 + 1);
                _311 = _310 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_333))).xy, ClothSimulVertsPositionsNormals.read(uint(_338)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_338)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_333 + 2))).xy, 0.0)).xyz * _117[_317].BaryCoordPos.w)) * _117[_317].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_350))).xy, ClothSimulVertsPositionsNormals.read(uint(_354)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_354)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_350 + 2))).xy, 0.0)).xyz * _117[_317].BaryCoordPos.w)) * _117[_317].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_364))).xy, ClothSimulVertsPositionsNormals.read(uint(_368)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_368)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_364 + 2))).xy, 0.0)).xyz * _117[_317].BaryCoordPos.w)) * ((1.0 - _117[_317].BaryCoordPos.x) - _117[_317].BaryCoordPos.y))) * 1.0);
                _316 = _315 + 1;
            }
            else
            {
                _311 = _310;
                _316 = _315;
            }
            _314 = _327 ? 1.0 : _313;
        }
        float3 _432;
        if ((_315 > 0) && (_313 > 9.9999997473787516355514526367188e-05))
        {
            _432 = _310 * (1.0 / _313);
        }
        else
        {
            _432 = float3(0.0);
        }
        _433 = _432;
        _434 = _307;
    }
    else
    {
        _433 = in.in_var_ATTRIBUTE0.xyz;
        _434 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _436 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _439 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _445 = int(_439 + (_Globals.InputWeightIndexSize * uint(_436)));
    float3x4 _447;
    _447 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _448;
    for (int _450 = 0; _450 < _436; _447 = _448, _450++)
    {
        int _458 = int(_439 + (_Globals.InputWeightIndexSize * uint(_450)));
        int _463 = int(InputWeightStream.read(uint(uint(_458))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _509 = float4(float(InputWeightStream.read(uint(uint(_445 + _450))).x) * 0.0039215688593685626983642578125);
            int _510 = int((InputWeightStream.read(uint(uint(_458 + 1))).x << 8u) | uint(_463)) * 3;
            _448 = float3x4(_447[0] + (_509 * BoneMatrices.read(uint(uint(_510)))), _447[1] + (_509 * BoneMatrices.read(uint(uint(_510 + 1)))), _447[2] + (_509 * BoneMatrices.read(uint(uint(_510 + 2)))));
        }
        else
        {
            float4 _474 = float4(float(InputWeightStream.read(uint(uint(_445 + _450))).x) * 0.0039215688593685626983642578125);
            int _475 = _463 * 3;
            _448 = float3x4(_447[0] + (_474 * BoneMatrices.read(uint(uint(_475)))), _447[1] + (_474 * BoneMatrices.read(uint(uint(_475 + 1)))), _447[2] + (_474 * BoneMatrices.read(uint(uint(_475 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _113;
    _113 = _114;
    float _710;
    float3x3 _711;
    if (_113[0].SimulIndices.w < 65535u)
    {
        float _541;
        float3 _544;
        float3 _546;
        float _548;
        int _550;
        _541 = _Globals.ClothBlendWeight;
        _544 = float3(0.0);
        _546 = float3(0.0);
        _548 = 0.0;
        _550 = 0;
        float _542;
        float _549;
        float3 _545;
        float3 _547;
        int _551;
        for (int _552 = 0; _552 < 1; _541 = _542, _544 = _545, _546 = _547, _548 = _549, _550 = _551, _552++)
        {
            bool _563 = _113[_552].SimulIndices.w < 65535u;
            if (_563)
            {
                int _569 = int(_113[_552].SimulIndices.x) * 3;
                uint _574 = uint(_569 + 1);
                float3 _583 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_569))).xy, ClothSimulVertsPositionsNormals.read(uint(_574)).x, 1.0)).xyz;
                int _586 = int(_113[_552].SimulIndices.y) * 3;
                uint _590 = uint(_586 + 1);
                float3 _597 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_586))).xy, ClothSimulVertsPositionsNormals.read(uint(_590)).x, 1.0)).xyz;
                int _600 = int(_113[_552].SimulIndices.z) * 3;
                uint _604 = uint(_600 + 1);
                float3 _611 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_600))).xy, ClothSimulVertsPositionsNormals.read(uint(_604)).x, 1.0)).xyz;
                float3 _621 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_574)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_569 + 2))).xy, 0.0)).xyz;
                float3 _631 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_590)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_586 + 2))).xy, 0.0)).xyz;
                float3 _641 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_604)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_600 + 2))).xy, 0.0)).xyz;
                _545 = _544 + (((((_583 + (_621 * _113[_552].BaryCoordNormal.w)) * _113[_552].BaryCoordNormal.x) + ((_597 + (_631 * _113[_552].BaryCoordNormal.w)) * _113[_552].BaryCoordNormal.y)) + ((_611 + (_641 * _113[_552].BaryCoordNormal.w)) * _113[_552].BaryCoordNormal.z)) * 1.0);
                _547 = _546 + (((((_583 + (_621 * _113[_552].BaryCoordTangent.w)) * _113[_552].BaryCoordTangent.x) + ((_597 + (_631 * _113[_552].BaryCoordTangent.w)) * _113[_552].BaryCoordTangent.y)) + ((_611 + (_641 * _113[_552].BaryCoordTangent.w)) * _113[_552].BaryCoordTangent.z)) * 1.0);
                _551 = _550 + 1;
            }
            else
            {
                _545 = _544;
                _547 = _546;
                _551 = _550;
            }
            _542 = _563 ? _Globals.ClothBlendWeight : _541;
            _549 = _563 ? 1.0 : _548;
        }
        bool _678 = (_550 > 0) && (_548 > 9.9999997473787516355514526367188e-05);
        float3x3 _702;
        if (_678)
        {
            float _682 = 1.0 / _548;
            float3x3 _697 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _699 = _109;
            _699[0] = _697 * normalize((_546 * _682) - _433);
            float3x3 _701 = _699;
            _701[2] = _697 * normalize((_544 * _682) - _433);
            _702 = _701;
        }
        else
        {
            _702 = _109;
        }
        float3x3 _709 = _702;
        _709[1] = cross(_702[2], _702[0]) * in.in_var_ATTRIBUTE2.w;
        _710 = _678 ? _541 : 0.0;
        _711 = _709;
    }
    else
    {
        _710 = 0.0;
        _711 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _750;
    float3 _717 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _447);
    float3 _723 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _447);
    float3 _728 = float3(_710);
    float3 _736 = float3(1.0 - _710);
    float4 _811;
    switch (0u)
    {
        default:
        {
            _750 = _114[0].SimulIndices.w < 65535u;
            if (_750)
            {
                _811 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _447) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _433, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _760 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _447) + in.in_var_ATTRIBUTE12;
                _811 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _760.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _760.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _760.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _112;
    _112 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _115 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _813 = 0; _813 < 1; )
    {
        _115[_813] = _112[_813];
        _813++;
        continue;
    }
    float4 _824 = _110;
    _824.w = 0.0;
    float3x3 _838 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _838[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _841 = _838;
    _841[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _844 = _841;
    _844[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _845 = _844 * float3x3((_711[0] * _728) + (_717 * _736), (_711[1] * _728) + (normalize(cross(_723, _717) * in.in_var_ATTRIBUTE2.w) * _736), (_711[2] * _728) + (_723 * _736));
    float3 _846 = _845[0];
    spvUnsafeArray<float4, 1> _856 = { float4(_115[0].x, _115[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _987;
    switch (0u)
    {
        default:
        {
            float4x4 _864 = Primitive.Primitive_PreviousLocalToWorld;
            _864[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _868 = _864;
            _868[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _872 = _868;
            _872[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _962;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float3x4 _879;
                _879 = float3x4(float4(0.0), float4(0.0), float4(0.0));
                float3x4 _880;
                for (int _882 = 0; _882 < _436; _879 = _880, _882++)
                {
                    int _890 = int(_439 + (_Globals.InputWeightIndexSize * uint(_882)));
                    int _895 = int(InputWeightStream.read(uint(uint(_890))).x);
                    if (_Globals.InputWeightIndexSize > 1u)
                    {
                        float4 _941 = float4(float(InputWeightStream.read(uint(uint(_445 + _882))).x) * 0.0039215688593685626983642578125);
                        int _942 = int((InputWeightStream.read(uint(uint(_890 + 1))).x << 8u) | uint(_895)) * 3;
                        _880 = float3x4(_879[0] + (_941 * PreviousBoneMatrices.read(uint(uint(_942)))), _879[1] + (_941 * PreviousBoneMatrices.read(uint(uint(_942 + 1)))), _879[2] + (_941 * PreviousBoneMatrices.read(uint(uint(_942 + 2)))));
                    }
                    else
                    {
                        float4 _906 = float4(float(InputWeightStream.read(uint(uint(_445 + _882))).x) * 0.0039215688593685626983642578125);
                        int _907 = _895 * 3;
                        _880 = float3x4(_879[0] + (_906 * PreviousBoneMatrices.read(uint(uint(_907)))), _879[1] + (_906 * PreviousBoneMatrices.read(uint(uint(_907 + 1)))), _879[2] + (_906 * PreviousBoneMatrices.read(uint(uint(_907 + 2)))));
                    }
                }
                _962 = _879;
            }
            else
            {
                _962 = _447;
            }
            float4 _974 = _872 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _962) + in.in_var_ATTRIBUTE12, 1.0);
            if (_750)
            {
                _987 = float4(mix(_974.xyz, _434 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _987 = _974;
            break;
        }
    }
    float4 _997 = View.View_TranslatedWorldToClip * float4(_811.xyz, 1.0);
    float4 _1006 = _997;
    _1006.z = _997.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _997.w) : 0.0);
    out.gl_Position = _1006;
    out.out_var_TEXCOORD6 = _997;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_987.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_846.x, _846.y, _846.z, _824.w);
    out.out_var_TEXCOORD11_centroid = float4(_845[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _856;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

