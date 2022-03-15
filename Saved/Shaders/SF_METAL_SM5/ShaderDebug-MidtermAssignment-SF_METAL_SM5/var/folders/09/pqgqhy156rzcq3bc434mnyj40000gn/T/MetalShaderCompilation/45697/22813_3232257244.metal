

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

constant float3x3 _94 = {};
constant float4 _95 = {};

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

vertex MainVertexShader_out Main_0000591d_c0a854dc(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], texture_buffer<float> PreviousBoneMatrices [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 1> _98;
    for (int _127 = 0; _127 < 1; )
    {
        uint _134 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_127)) * 4u;
        _98[_127].BaryCoordPos = GPUSkinApexCloth.read(uint(_134));
        _98[_127].BaryCoordNormal = GPUSkinApexCloth.read(uint((_134 + 1u)));
        _98[_127].BaryCoordTangent = GPUSkinApexCloth.read(uint((_134 + 2u)));
        uint4 _146 = as_type<uint4>(GPUSkinApexCloth.read(uint((_134 + 3u))));
        uint2 _147 = _146.xy;
        uint2 _150 = (_147 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _98[_127].SimulIndices = uint4(_98[_127].SimulIndices.x, _150.x, _98[_127].SimulIndices.z, _150.y);
        uint2 _154 = _147 & uint2(65535u);
        _98[_127].SimulIndices = uint4(_154.x, _98[_127].SimulIndices.y, _154.y, _98[_127].SimulIndices.w);
        _98[_127].Weight = as_type<float>(_146.z);
        _127++;
        continue;
    }
    float3 _418;
    float3 _419;
    if (_98[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _99;
        _99 = _98;
        float3 _170;
        float _173;
        int _175;
        _170 = float3(0.0);
        _173 = 0.0;
        _175 = 0;
        float _174;
        float3 _171;
        int _176;
        for (int _177 = 0; _177 < 1; _170 = _171, _173 = _174, _175 = _176, _177++)
        {
            bool _187 = _99[_177].SimulIndices.w < 65535u;
            if (_187)
            {
                int _193 = int(_99[_177].SimulIndices.x) * 3;
                uint _198 = uint(_193 + 1);
                int _210 = int(_99[_177].SimulIndices.y) * 3;
                uint _214 = uint(_210 + 1);
                int _224 = int(_99[_177].SimulIndices.z) * 3;
                uint _228 = uint(_224 + 1);
                _171 = _170 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_193))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_198)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_198)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_193 + 2))).xy, 0.0)).xyz * _99[_177].BaryCoordPos.w)) * _99[_177].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_210))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_214)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_214)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_210 + 2))).xy, 0.0)).xyz * _99[_177].BaryCoordPos.w)) * _99[_177].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_224))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_228)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_228)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_224 + 2))).xy, 0.0)).xyz * _99[_177].BaryCoordPos.w)) * ((1.0 - _99[_177].BaryCoordPos.x) - _99[_177].BaryCoordPos.y))) * 1.0);
                _176 = _175 + 1;
            }
            else
            {
                _171 = _170;
                _176 = _175;
            }
            _174 = _187 ? 1.0 : _173;
        }
        float3 _292;
        if ((_175 > 0) && (_173 > 9.9999997473787516355514526367188e-05))
        {
            _292 = _170 * (1.0 / _173);
        }
        else
        {
            _292 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 1> _100;
        _100 = _98;
        float3 _295;
        float _298;
        int _300;
        _295 = float3(0.0);
        _298 = 0.0;
        _300 = 0;
        float _299;
        float3 _296;
        int _301;
        for (int _302 = 0; _302 < 1; _295 = _296, _298 = _299, _300 = _301, _302++)
        {
            bool _312 = _100[_302].SimulIndices.w < 65535u;
            if (_312)
            {
                int _318 = int(_100[_302].SimulIndices.x) * 3;
                uint _323 = uint(_318 + 1);
                int _335 = int(_100[_302].SimulIndices.y) * 3;
                uint _339 = uint(_335 + 1);
                int _349 = int(_100[_302].SimulIndices.z) * 3;
                uint _353 = uint(_349 + 1);
                _296 = _295 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_318))).xy, ClothSimulVertsPositionsNormals.read(uint(_323)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_323)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_318 + 2))).xy, 0.0)).xyz * _100[_302].BaryCoordPos.w)) * _100[_302].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_335))).xy, ClothSimulVertsPositionsNormals.read(uint(_339)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_339)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_335 + 2))).xy, 0.0)).xyz * _100[_302].BaryCoordPos.w)) * _100[_302].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_349))).xy, ClothSimulVertsPositionsNormals.read(uint(_353)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_353)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_349 + 2))).xy, 0.0)).xyz * _100[_302].BaryCoordPos.w)) * ((1.0 - _100[_302].BaryCoordPos.x) - _100[_302].BaryCoordPos.y))) * 1.0);
                _301 = _300 + 1;
            }
            else
            {
                _296 = _295;
                _301 = _300;
            }
            _299 = _312 ? 1.0 : _298;
        }
        float3 _417;
        if ((_300 > 0) && (_298 > 9.9999997473787516355514526367188e-05))
        {
            _417 = _295 * (1.0 / _298);
        }
        else
        {
            _417 = float3(0.0);
        }
        _418 = _417;
        _419 = _292;
    }
    else
    {
        _418 = in.in_var_ATTRIBUTE0.xyz;
        _419 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _421 = float4(in.in_var_ATTRIBUTE4.x);
    int _424 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _425 = uint(_424);
    uint _429 = uint(_424 + 1);
    uint _432 = uint(_424 + 2);
    float4 _438 = float4(in.in_var_ATTRIBUTE4.y);
    int _441 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _442 = uint(_441);
    uint _445 = uint(_441 + 1);
    uint _448 = uint(_441 + 2);
    float4 _457 = float4(in.in_var_ATTRIBUTE4.z);
    int _460 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _461 = uint(_460);
    uint _464 = uint(_460 + 1);
    uint _467 = uint(_460 + 2);
    float4 _476 = float4(in.in_var_ATTRIBUTE4.w);
    int _479 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _480 = uint(_479);
    uint _483 = uint(_479 + 1);
    uint _486 = uint(_479 + 2);
    float4 _491 = (((_421 * BoneMatrices.read(uint(_425))) + (_438 * BoneMatrices.read(uint(_442)))) + (_457 * BoneMatrices.read(uint(_461)))) + (_476 * BoneMatrices.read(uint(_480)));
    float4 _492 = (((_421 * BoneMatrices.read(uint(_429))) + (_438 * BoneMatrices.read(uint(_445)))) + (_457 * BoneMatrices.read(uint(_464)))) + (_476 * BoneMatrices.read(uint(_483)));
    float4 _493 = (((_421 * BoneMatrices.read(uint(_432))) + (_438 * BoneMatrices.read(uint(_448)))) + (_457 * BoneMatrices.read(uint(_467)))) + (_476 * BoneMatrices.read(uint(_486)));
    bool _497 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _577;
    if (_497)
    {
        float4 _501 = float4(in.in_var_ATTRIBUTE15.x);
        int _504 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _520 = float4(in.in_var_ATTRIBUTE15.y);
        int _523 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _539 = float4(in.in_var_ATTRIBUTE15.z);
        int _542 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _558 = float4(in.in_var_ATTRIBUTE15.w);
        int _561 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _577 = float3x4((((_491 + (_501 * BoneMatrices.read(uint(uint(_504))))) + (_520 * BoneMatrices.read(uint(uint(_523))))) + (_539 * BoneMatrices.read(uint(uint(_542))))) + (_558 * BoneMatrices.read(uint(uint(_561)))), (((_492 + (_501 * BoneMatrices.read(uint(uint(_504 + 1))))) + (_520 * BoneMatrices.read(uint(uint(_523 + 1))))) + (_539 * BoneMatrices.read(uint(uint(_542 + 1))))) + (_558 * BoneMatrices.read(uint(uint(_561 + 1)))), (((_493 + (_501 * BoneMatrices.read(uint(uint(_504 + 2))))) + (_520 * BoneMatrices.read(uint(uint(_523 + 2))))) + (_539 * BoneMatrices.read(uint(uint(_542 + 2))))) + (_558 * BoneMatrices.read(uint(uint(_561 + 2)))));
    }
    else
    {
        _577 = float3x4(_491, _492, _493);
    }
    spvUnsafeArray<FClothVertex, 1> _97;
    _97 = _98;
    float _758;
    float3x3 _759;
    if (_97[0].SimulIndices.w < 65535u)
    {
        float _589;
        float3 _592;
        float3 _594;
        float _596;
        int _598;
        _589 = _Globals.ClothBlendWeight;
        _592 = float3(0.0);
        _594 = float3(0.0);
        _596 = 0.0;
        _598 = 0;
        float _590;
        float _597;
        float3 _593;
        float3 _595;
        int _599;
        for (int _600 = 0; _600 < 1; _589 = _590, _592 = _593, _594 = _595, _596 = _597, _598 = _599, _600++)
        {
            bool _611 = _97[_600].SimulIndices.w < 65535u;
            if (_611)
            {
                int _617 = int(_97[_600].SimulIndices.x) * 3;
                uint _622 = uint(_617 + 1);
                float3 _631 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_617))).xy, ClothSimulVertsPositionsNormals.read(uint(_622)).x, 1.0)).xyz;
                int _634 = int(_97[_600].SimulIndices.y) * 3;
                uint _638 = uint(_634 + 1);
                float3 _645 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_634))).xy, ClothSimulVertsPositionsNormals.read(uint(_638)).x, 1.0)).xyz;
                int _648 = int(_97[_600].SimulIndices.z) * 3;
                uint _652 = uint(_648 + 1);
                float3 _659 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_648))).xy, ClothSimulVertsPositionsNormals.read(uint(_652)).x, 1.0)).xyz;
                float3 _669 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_622)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_617 + 2))).xy, 0.0)).xyz;
                float3 _679 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_638)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_634 + 2))).xy, 0.0)).xyz;
                float3 _689 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_652)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_648 + 2))).xy, 0.0)).xyz;
                _593 = _592 + (((((_631 + (_669 * _97[_600].BaryCoordNormal.w)) * _97[_600].BaryCoordNormal.x) + ((_645 + (_679 * _97[_600].BaryCoordNormal.w)) * _97[_600].BaryCoordNormal.y)) + ((_659 + (_689 * _97[_600].BaryCoordNormal.w)) * _97[_600].BaryCoordNormal.z)) * 1.0);
                _595 = _594 + (((((_631 + (_669 * _97[_600].BaryCoordTangent.w)) * _97[_600].BaryCoordTangent.x) + ((_645 + (_679 * _97[_600].BaryCoordTangent.w)) * _97[_600].BaryCoordTangent.y)) + ((_659 + (_689 * _97[_600].BaryCoordTangent.w)) * _97[_600].BaryCoordTangent.z)) * 1.0);
                _599 = _598 + 1;
            }
            else
            {
                _593 = _592;
                _595 = _594;
                _599 = _598;
            }
            _590 = _611 ? _Globals.ClothBlendWeight : _589;
            _597 = _611 ? 1.0 : _596;
        }
        bool _726 = (_598 > 0) && (_596 > 9.9999997473787516355514526367188e-05);
        float3x3 _750;
        if (_726)
        {
            float _730 = 1.0 / _596;
            float3x3 _745 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _747 = _94;
            _747[0] = _745 * normalize((_594 * _730) - _418);
            float3x3 _749 = _747;
            _749[2] = _745 * normalize((_592 * _730) - _418);
            _750 = _749;
        }
        else
        {
            _750 = _94;
        }
        float3x3 _757 = _750;
        _757[1] = cross(_750[2], _750[0]) * in.in_var_ATTRIBUTE2.w;
        _758 = _726 ? _589 : 0.0;
        _759 = _757;
    }
    else
    {
        _758 = 0.0;
        _759 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _798;
    float3 _765 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _577);
    float3 _771 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _577);
    float3 _776 = float3(_758);
    float3 _784 = float3(1.0 - _758);
    float4 _859;
    switch (0u)
    {
        default:
        {
            _798 = _98[0].SimulIndices.w < 65535u;
            if (_798)
            {
                _859 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _577) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _418, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _808 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _577) + in.in_var_ATTRIBUTE12;
                _859 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _808.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _808.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _808.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _860 = _95;
    _860.w = 0.0;
    float3x3 _874 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _874[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _877 = _874;
    _877[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _880 = _877;
    _880[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _881 = _880 * float3x3((_759[0] * _776) + (_765 * _784), (_759[1] * _776) + (normalize(cross(_771, _765) * in.in_var_ATTRIBUTE2.w) * _784), (_759[2] * _776) + (_771 * _784));
    float3 _882 = _881[0];
    float4 _1053;
    switch (0u)
    {
        default:
        {
            float4x4 _899 = Primitive.Primitive_PreviousLocalToWorld;
            _899[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _903 = _899;
            _903[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _907 = _903;
            _907[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _1028;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float4 _944 = (((_421 * PreviousBoneMatrices.read(uint(_425))) + (_438 * PreviousBoneMatrices.read(uint(_442)))) + (_457 * PreviousBoneMatrices.read(uint(_461)))) + (_476 * PreviousBoneMatrices.read(uint(_480)));
                float4 _945 = (((_421 * PreviousBoneMatrices.read(uint(_429))) + (_438 * PreviousBoneMatrices.read(uint(_445)))) + (_457 * PreviousBoneMatrices.read(uint(_464)))) + (_476 * PreviousBoneMatrices.read(uint(_483)));
                float4 _946 = (((_421 * PreviousBoneMatrices.read(uint(_432))) + (_438 * PreviousBoneMatrices.read(uint(_448)))) + (_457 * PreviousBoneMatrices.read(uint(_467)))) + (_476 * PreviousBoneMatrices.read(uint(_486)));
                float3x4 _1027;
                if (_497)
                {
                    float4 _951 = float4(in.in_var_ATTRIBUTE15.x);
                    int _954 = int(in.in_var_ATTRIBUTE14.x) * 3;
                    float4 _970 = float4(in.in_var_ATTRIBUTE15.y);
                    int _973 = int(in.in_var_ATTRIBUTE14.y) * 3;
                    float4 _989 = float4(in.in_var_ATTRIBUTE15.z);
                    int _992 = int(in.in_var_ATTRIBUTE14.z) * 3;
                    float4 _1008 = float4(in.in_var_ATTRIBUTE15.w);
                    int _1011 = int(in.in_var_ATTRIBUTE14.w) * 3;
                    _1027 = float3x4((((_944 + (_951 * PreviousBoneMatrices.read(uint(uint(_954))))) + (_970 * PreviousBoneMatrices.read(uint(uint(_973))))) + (_989 * PreviousBoneMatrices.read(uint(uint(_992))))) + (_1008 * PreviousBoneMatrices.read(uint(uint(_1011)))), (((_945 + (_951 * PreviousBoneMatrices.read(uint(uint(_954 + 1))))) + (_970 * PreviousBoneMatrices.read(uint(uint(_973 + 1))))) + (_989 * PreviousBoneMatrices.read(uint(uint(_992 + 1))))) + (_1008 * PreviousBoneMatrices.read(uint(uint(_1011 + 1)))), (((_946 + (_951 * PreviousBoneMatrices.read(uint(uint(_954 + 2))))) + (_970 * PreviousBoneMatrices.read(uint(uint(_973 + 2))))) + (_989 * PreviousBoneMatrices.read(uint(uint(_992 + 2))))) + (_1008 * PreviousBoneMatrices.read(uint(uint(_1011 + 2)))));
                }
                else
                {
                    _1027 = float3x4(_944, _945, _946);
                }
                _1028 = _1027;
            }
            else
            {
                _1028 = _577;
            }
            float4 _1040 = _907 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _1028) + in.in_var_ATTRIBUTE12, 1.0);
            if (_798)
            {
                _1053 = float4(mix(_1040.xyz, _419 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _1053 = _1040;
            break;
        }
    }
    float4 _1063 = View.View_TranslatedWorldToClip * float4(_859.xyz, 1.0);
    float4 _1072 = _1063;
    _1072.z = _1063.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1063.w) : 0.0);
    out.gl_Position = _1072;
    out.out_var_TEXCOORD6 = _1063;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_1053.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_882.x, _882.y, _882.z, _860.w);
    out.out_var_TEXCOORD11_centroid = float4(_881[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    return out;
}

