

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

constant spvUnsafeArray<float2, 1> _101 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _106 = {};
constant float4 _107 = {};

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
    uint4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float4 in_var_ATTRIBUTE4 [[attribute(4)]];
    float2 in_var_ATTRIBUTE5_0 [[attribute(5)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
    uint4 in_var_ATTRIBUTE14 [[attribute(14)]];
    float4 in_var_ATTRIBUTE15 [[attribute(15)]];
};

vertex MainVertexShader_out Main_00005d07_e090e80b(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], texture_buffer<float> PreviousBoneMatrices [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 5> _111;
    for (int _142 = 0; _142 < 5; )
    {
        uint _150 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_142)) * 4u;
        _111[_142].BaryCoordPos = GPUSkinApexCloth.read(uint(_150));
        _111[_142].BaryCoordNormal = GPUSkinApexCloth.read(uint((_150 + 1u)));
        _111[_142].BaryCoordTangent = GPUSkinApexCloth.read(uint((_150 + 2u)));
        uint4 _162 = as_type<uint4>(GPUSkinApexCloth.read(uint((_150 + 3u))));
        uint2 _163 = _162.xy;
        uint2 _166 = (_163 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _111[_142].SimulIndices = uint4(_111[_142].SimulIndices.x, _166.x, _111[_142].SimulIndices.z, _166.y);
        uint2 _170 = _163 & uint2(65535u);
        _111[_142].SimulIndices = uint4(_170.x, _111[_142].SimulIndices.y, _170.y, _111[_142].SimulIndices.w);
        _111[_142].Weight = as_type<float>(_162.z);
        _142++;
        continue;
    }
    float3 _438;
    float3 _439;
    if (_111[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _113;
        _113 = _111;
        float3 _186;
        float _189;
        int _191;
        _186 = float3(0.0);
        _189 = 0.0;
        _191 = 0;
        float3 _187;
        float _190;
        int _192;
        for (int _193 = 0; _193 < 5; _186 = _187, _189 = _190, _191 = _192, _193++)
        {
            if (_113[_193].SimulIndices.w < 65535u)
            {
                int _210 = int(_113[_193].SimulIndices.x) * 3;
                uint _215 = uint(_210 + 1);
                int _227 = int(_113[_193].SimulIndices.y) * 3;
                uint _231 = uint(_227 + 1);
                int _241 = int(_113[_193].SimulIndices.z) * 3;
                uint _245 = uint(_241 + 1);
                _187 = _186 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_210))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_215)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_215)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_210 + 2))).xy, 0.0)).xyz * _113[_193].BaryCoordPos.w)) * _113[_193].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_227))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_231)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_231)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_227 + 2))).xy, 0.0)).xyz * _113[_193].BaryCoordPos.w)) * _113[_193].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_241))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_245)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_245)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_241 + 2))).xy, 0.0)).xyz * _113[_193].BaryCoordPos.w)) * ((1.0 - _113[_193].BaryCoordPos.x) - _113[_193].BaryCoordPos.y))) * _113[_193].Weight);
                _190 = _189 + _113[_193].Weight;
                _192 = _191 + 1;
            }
            else
            {
                _187 = _186;
                _190 = _189;
                _192 = _191;
            }
        }
        float3 _310;
        if ((_191 > 0) && (_189 > 9.9999997473787516355514526367188e-05))
        {
            _310 = _186 * (1.0 / _189);
        }
        else
        {
            _310 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 5> _114;
        _114 = _111;
        float3 _313;
        float _316;
        int _318;
        _313 = float3(0.0);
        _316 = 0.0;
        _318 = 0;
        float3 _314;
        float _317;
        int _319;
        for (int _320 = 0; _320 < 5; _313 = _314, _316 = _317, _318 = _319, _320++)
        {
            if (_114[_320].SimulIndices.w < 65535u)
            {
                int _337 = int(_114[_320].SimulIndices.x) * 3;
                uint _342 = uint(_337 + 1);
                int _354 = int(_114[_320].SimulIndices.y) * 3;
                uint _358 = uint(_354 + 1);
                int _368 = int(_114[_320].SimulIndices.z) * 3;
                uint _372 = uint(_368 + 1);
                _314 = _313 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_337))).xy, ClothSimulVertsPositionsNormals.read(uint(_342)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_342)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_337 + 2))).xy, 0.0)).xyz * _114[_320].BaryCoordPos.w)) * _114[_320].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_354))).xy, ClothSimulVertsPositionsNormals.read(uint(_358)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_358)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_354 + 2))).xy, 0.0)).xyz * _114[_320].BaryCoordPos.w)) * _114[_320].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_368))).xy, ClothSimulVertsPositionsNormals.read(uint(_372)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_372)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_368 + 2))).xy, 0.0)).xyz * _114[_320].BaryCoordPos.w)) * ((1.0 - _114[_320].BaryCoordPos.x) - _114[_320].BaryCoordPos.y))) * _114[_320].Weight);
                _317 = _316 + _114[_320].Weight;
                _319 = _318 + 1;
            }
            else
            {
                _314 = _313;
                _317 = _316;
                _319 = _318;
            }
        }
        float3 _437;
        if ((_318 > 0) && (_316 > 9.9999997473787516355514526367188e-05))
        {
            _437 = _313 * (1.0 / _316);
        }
        else
        {
            _437 = float3(0.0);
        }
        _438 = _437;
        _439 = _310;
    }
    else
    {
        _438 = in.in_var_ATTRIBUTE0.xyz;
        _439 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _441 = float4(in.in_var_ATTRIBUTE4.x);
    int _444 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _445 = uint(_444);
    uint _449 = uint(_444 + 1);
    uint _452 = uint(_444 + 2);
    float4 _458 = float4(in.in_var_ATTRIBUTE4.y);
    int _461 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _462 = uint(_461);
    uint _465 = uint(_461 + 1);
    uint _468 = uint(_461 + 2);
    float4 _477 = float4(in.in_var_ATTRIBUTE4.z);
    int _480 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _481 = uint(_480);
    uint _484 = uint(_480 + 1);
    uint _487 = uint(_480 + 2);
    float4 _496 = float4(in.in_var_ATTRIBUTE4.w);
    int _499 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _500 = uint(_499);
    uint _503 = uint(_499 + 1);
    uint _506 = uint(_499 + 2);
    float4 _511 = (((_441 * BoneMatrices.read(uint(_445))) + (_458 * BoneMatrices.read(uint(_462)))) + (_477 * BoneMatrices.read(uint(_481)))) + (_496 * BoneMatrices.read(uint(_500)));
    float4 _512 = (((_441 * BoneMatrices.read(uint(_449))) + (_458 * BoneMatrices.read(uint(_465)))) + (_477 * BoneMatrices.read(uint(_484)))) + (_496 * BoneMatrices.read(uint(_503)));
    float4 _513 = (((_441 * BoneMatrices.read(uint(_452))) + (_458 * BoneMatrices.read(uint(_468)))) + (_477 * BoneMatrices.read(uint(_487)))) + (_496 * BoneMatrices.read(uint(_506)));
    bool _517 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _597;
    if (_517)
    {
        float4 _521 = float4(in.in_var_ATTRIBUTE15.x);
        int _524 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _540 = float4(in.in_var_ATTRIBUTE15.y);
        int _543 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _559 = float4(in.in_var_ATTRIBUTE15.z);
        int _562 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _578 = float4(in.in_var_ATTRIBUTE15.w);
        int _581 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _597 = float3x4((((_511 + (_521 * BoneMatrices.read(uint(uint(_524))))) + (_540 * BoneMatrices.read(uint(uint(_543))))) + (_559 * BoneMatrices.read(uint(uint(_562))))) + (_578 * BoneMatrices.read(uint(uint(_581)))), (((_512 + (_521 * BoneMatrices.read(uint(uint(_524 + 1))))) + (_540 * BoneMatrices.read(uint(uint(_543 + 1))))) + (_559 * BoneMatrices.read(uint(uint(_562 + 1))))) + (_578 * BoneMatrices.read(uint(uint(_581 + 1)))), (((_513 + (_521 * BoneMatrices.read(uint(uint(_524 + 2))))) + (_540 * BoneMatrices.read(uint(uint(_543 + 2))))) + (_559 * BoneMatrices.read(uint(uint(_562 + 2))))) + (_578 * BoneMatrices.read(uint(uint(_581 + 2)))));
    }
    else
    {
        _597 = float3x4(_511, _512, _513);
    }
    spvUnsafeArray<FClothVertex, 5> _110;
    _110 = _111;
    float _780;
    float3x3 _781;
    if (_110[0].SimulIndices.w < 65535u)
    {
        float _609;
        float3 _612;
        float3 _614;
        float _616;
        int _618;
        _609 = _Globals.ClothBlendWeight;
        _612 = float3(0.0);
        _614 = float3(0.0);
        _616 = 0.0;
        _618 = 0;
        float _610;
        float3 _613;
        float3 _615;
        float _617;
        int _619;
        for (int _620 = 0; _620 < 5; _609 = _610, _612 = _613, _614 = _615, _616 = _617, _618 = _619, _620++)
        {
            bool _632 = _110[_620].SimulIndices.w < 65535u;
            if (_632)
            {
                int _638 = int(_110[_620].SimulIndices.x) * 3;
                uint _643 = uint(_638 + 1);
                float3 _652 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_638))).xy, ClothSimulVertsPositionsNormals.read(uint(_643)).x, 1.0)).xyz;
                int _655 = int(_110[_620].SimulIndices.y) * 3;
                uint _659 = uint(_655 + 1);
                float3 _666 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_655))).xy, ClothSimulVertsPositionsNormals.read(uint(_659)).x, 1.0)).xyz;
                int _669 = int(_110[_620].SimulIndices.z) * 3;
                uint _673 = uint(_669 + 1);
                float3 _680 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_669))).xy, ClothSimulVertsPositionsNormals.read(uint(_673)).x, 1.0)).xyz;
                float3 _690 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_643)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_638 + 2))).xy, 0.0)).xyz;
                float3 _700 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_659)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_655 + 2))).xy, 0.0)).xyz;
                float3 _710 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_673)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_669 + 2))).xy, 0.0)).xyz;
                _613 = _612 + (((((_652 + (_690 * _110[_620].BaryCoordNormal.w)) * _110[_620].BaryCoordNormal.x) + ((_666 + (_700 * _110[_620].BaryCoordNormal.w)) * _110[_620].BaryCoordNormal.y)) + ((_680 + (_710 * _110[_620].BaryCoordNormal.w)) * _110[_620].BaryCoordNormal.z)) * _110[_620].Weight);
                _615 = _614 + (((((_652 + (_690 * _110[_620].BaryCoordTangent.w)) * _110[_620].BaryCoordTangent.x) + ((_666 + (_700 * _110[_620].BaryCoordTangent.w)) * _110[_620].BaryCoordTangent.y)) + ((_680 + (_710 * _110[_620].BaryCoordTangent.w)) * _110[_620].BaryCoordTangent.z)) * _110[_620].Weight);
                _617 = _616 + _110[_620].Weight;
                _619 = _618 + 1;
            }
            else
            {
                _613 = _612;
                _615 = _614;
                _617 = _616;
                _619 = _618;
            }
            _610 = _632 ? _Globals.ClothBlendWeight : _609;
        }
        bool _748 = (_618 > 0) && (_616 > 9.9999997473787516355514526367188e-05);
        float3x3 _772;
        if (_748)
        {
            float _752 = 1.0 / _616;
            float3x3 _767 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _769 = _106;
            _769[0] = _767 * normalize((_614 * _752) - _438);
            float3x3 _771 = _769;
            _771[2] = _767 * normalize((_612 * _752) - _438);
            _772 = _771;
        }
        else
        {
            _772 = _106;
        }
        float3x3 _779 = _772;
        _779[1] = cross(_772[2], _772[0]) * in.in_var_ATTRIBUTE2.w;
        _780 = _748 ? _609 : 0.0;
        _781 = _779;
    }
    else
    {
        _780 = 0.0;
        _781 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _820;
    float3 _787 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _597);
    float3 _793 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _597);
    float3 _798 = float3(_780);
    float3 _806 = float3(1.0 - _780);
    float4 _881;
    switch (0u)
    {
        default:
        {
            _820 = _111[0].SimulIndices.w < 65535u;
            if (_820)
            {
                _881 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _597) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _438, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _830 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _597) + in.in_var_ATTRIBUTE12;
                _881 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _830.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _830.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _830.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _109;
    _109 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _112 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _883 = 0; _883 < 1; )
    {
        _112[_883] = _109[_883];
        _883++;
        continue;
    }
    float4 _894 = _107;
    _894.w = 0.0;
    float3x3 _908 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _908[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _911 = _908;
    _911[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _914 = _911;
    _914[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _915 = _914 * float3x3((_781[0] * _798) + (_787 * _806), (_781[1] * _798) + (normalize(cross(_793, _787) * in.in_var_ATTRIBUTE2.w) * _806), (_781[2] * _798) + (_793 * _806));
    float3 _916 = _915[0];
    spvUnsafeArray<float4, 1> _926 = { float4(_112[0].x, _112[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _1088;
    switch (0u)
    {
        default:
        {
            float4x4 _934 = Primitive.Primitive_PreviousLocalToWorld;
            _934[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _938 = _934;
            _938[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _942 = _938;
            _942[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _1063;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float4 _979 = (((_441 * PreviousBoneMatrices.read(uint(_445))) + (_458 * PreviousBoneMatrices.read(uint(_462)))) + (_477 * PreviousBoneMatrices.read(uint(_481)))) + (_496 * PreviousBoneMatrices.read(uint(_500)));
                float4 _980 = (((_441 * PreviousBoneMatrices.read(uint(_449))) + (_458 * PreviousBoneMatrices.read(uint(_465)))) + (_477 * PreviousBoneMatrices.read(uint(_484)))) + (_496 * PreviousBoneMatrices.read(uint(_503)));
                float4 _981 = (((_441 * PreviousBoneMatrices.read(uint(_452))) + (_458 * PreviousBoneMatrices.read(uint(_468)))) + (_477 * PreviousBoneMatrices.read(uint(_487)))) + (_496 * PreviousBoneMatrices.read(uint(_506)));
                float3x4 _1062;
                if (_517)
                {
                    float4 _986 = float4(in.in_var_ATTRIBUTE15.x);
                    int _989 = int(in.in_var_ATTRIBUTE14.x) * 3;
                    float4 _1005 = float4(in.in_var_ATTRIBUTE15.y);
                    int _1008 = int(in.in_var_ATTRIBUTE14.y) * 3;
                    float4 _1024 = float4(in.in_var_ATTRIBUTE15.z);
                    int _1027 = int(in.in_var_ATTRIBUTE14.z) * 3;
                    float4 _1043 = float4(in.in_var_ATTRIBUTE15.w);
                    int _1046 = int(in.in_var_ATTRIBUTE14.w) * 3;
                    _1062 = float3x4((((_979 + (_986 * PreviousBoneMatrices.read(uint(uint(_989))))) + (_1005 * PreviousBoneMatrices.read(uint(uint(_1008))))) + (_1024 * PreviousBoneMatrices.read(uint(uint(_1027))))) + (_1043 * PreviousBoneMatrices.read(uint(uint(_1046)))), (((_980 + (_986 * PreviousBoneMatrices.read(uint(uint(_989 + 1))))) + (_1005 * PreviousBoneMatrices.read(uint(uint(_1008 + 1))))) + (_1024 * PreviousBoneMatrices.read(uint(uint(_1027 + 1))))) + (_1043 * PreviousBoneMatrices.read(uint(uint(_1046 + 1)))), (((_981 + (_986 * PreviousBoneMatrices.read(uint(uint(_989 + 2))))) + (_1005 * PreviousBoneMatrices.read(uint(uint(_1008 + 2))))) + (_1024 * PreviousBoneMatrices.read(uint(uint(_1027 + 2))))) + (_1043 * PreviousBoneMatrices.read(uint(uint(_1046 + 2)))));
                }
                else
                {
                    _1062 = float3x4(_979, _980, _981);
                }
                _1063 = _1062;
            }
            else
            {
                _1063 = _597;
            }
            float4 _1075 = _942 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _1063) + in.in_var_ATTRIBUTE12, 1.0);
            if (_820)
            {
                _1088 = float4(mix(_1075.xyz, _439 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _1088 = _1075;
            break;
        }
    }
    float4 _1098 = View.View_TranslatedWorldToClip * float4(_881.xyz, 1.0);
    float4 _1107 = _1098;
    _1107.z = _1098.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1098.w) : 0.0);
    out.gl_Position = _1107;
    out.out_var_TEXCOORD6 = _1098;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_1088.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_916.x, _916.y, _916.z, _894.w);
    out.out_var_TEXCOORD11_centroid = float4(_915[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _926;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

