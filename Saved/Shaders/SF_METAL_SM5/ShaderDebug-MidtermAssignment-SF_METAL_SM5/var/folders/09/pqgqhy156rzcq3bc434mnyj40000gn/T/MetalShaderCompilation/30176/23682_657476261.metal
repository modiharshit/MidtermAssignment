

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

constant spvUnsafeArray<float2, 1> _100 = spvUnsafeArray<float2, 1>({ float2(0.0) });

constant float3x3 _105 = {};
constant float4 _106 = {};

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

vertex MainVertexShader_out Main_00005c82_27304aa5(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(5)]], constant type_Primitive& Primitive [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> PreviousClothSimulVertsPositionsNormals [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], texture_buffer<float> PreviousBoneMatrices [[texture(4)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    spvUnsafeArray<float2, 1> in_var_ATTRIBUTE5 = {};
    in_var_ATTRIBUTE5[0] = in.in_var_ATTRIBUTE5_0;
    spvUnsafeArray<FClothVertex, 1> _110;
    for (int _141 = 0; _141 < 1; )
    {
        uint _148 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0]) + uint(_141)) * 4u;
        _110[_141].BaryCoordPos = GPUSkinApexCloth.read(uint(_148));
        _110[_141].BaryCoordNormal = GPUSkinApexCloth.read(uint((_148 + 1u)));
        _110[_141].BaryCoordTangent = GPUSkinApexCloth.read(uint((_148 + 2u)));
        uint4 _160 = as_type<uint4>(GPUSkinApexCloth.read(uint((_148 + 3u))));
        uint2 _161 = _160.xy;
        uint2 _164 = (_161 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _110[_141].SimulIndices = uint4(_110[_141].SimulIndices.x, _164.x, _110[_141].SimulIndices.z, _164.y);
        uint2 _168 = _161 & uint2(65535u);
        _110[_141].SimulIndices = uint4(_168.x, _110[_141].SimulIndices.y, _168.y, _110[_141].SimulIndices.w);
        _110[_141].Weight = as_type<float>(_160.z);
        _141++;
        continue;
    }
    float3 _432;
    float3 _433;
    if (_110[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _112;
        _112 = _110;
        float3 _184;
        float _187;
        int _189;
        _184 = float3(0.0);
        _187 = 0.0;
        _189 = 0;
        float _188;
        float3 _185;
        int _190;
        for (int _191 = 0; _191 < 1; _184 = _185, _187 = _188, _189 = _190, _191++)
        {
            bool _201 = _112[_191].SimulIndices.w < 65535u;
            if (_201)
            {
                int _207 = int(_112[_191].SimulIndices.x) * 3;
                uint _212 = uint(_207 + 1);
                int _224 = int(_112[_191].SimulIndices.y) * 3;
                uint _228 = uint(_224 + 1);
                int _238 = int(_112[_191].SimulIndices.z) * 3;
                uint _242 = uint(_238 + 1);
                _185 = _184 + ((((((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_207))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_212)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_212)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_207 + 2))).xy, 0.0)).xyz * _112[_191].BaryCoordPos.w)) * _112[_191].BaryCoordPos.x) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_224))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_228)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_228)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_224 + 2))).xy, 0.0)).xyz * _112[_191].BaryCoordPos.w)) * _112[_191].BaryCoordPos.y)) + (((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(uint(_238))).xy, PreviousClothSimulVertsPositionsNormals.read(uint(_242)).x, 1.0)).xyz + ((_Globals.PreviousClothLocalToWorld * float4(PreviousClothSimulVertsPositionsNormals.read(uint(_242)).y, PreviousClothSimulVertsPositionsNormals.read(uint(uint(_238 + 2))).xy, 0.0)).xyz * _112[_191].BaryCoordPos.w)) * ((1.0 - _112[_191].BaryCoordPos.x) - _112[_191].BaryCoordPos.y))) * 1.0);
                _190 = _189 + 1;
            }
            else
            {
                _185 = _184;
                _190 = _189;
            }
            _188 = _201 ? 1.0 : _187;
        }
        float3 _306;
        if ((_189 > 0) && (_187 > 9.9999997473787516355514526367188e-05))
        {
            _306 = _184 * (1.0 / _187);
        }
        else
        {
            _306 = float3(0.0);
        }
        spvUnsafeArray<FClothVertex, 1> _113;
        _113 = _110;
        float3 _309;
        float _312;
        int _314;
        _309 = float3(0.0);
        _312 = 0.0;
        _314 = 0;
        float _313;
        float3 _310;
        int _315;
        for (int _316 = 0; _316 < 1; _309 = _310, _312 = _313, _314 = _315, _316++)
        {
            bool _326 = _113[_316].SimulIndices.w < 65535u;
            if (_326)
            {
                int _332 = int(_113[_316].SimulIndices.x) * 3;
                uint _337 = uint(_332 + 1);
                int _349 = int(_113[_316].SimulIndices.y) * 3;
                uint _353 = uint(_349 + 1);
                int _363 = int(_113[_316].SimulIndices.z) * 3;
                uint _367 = uint(_363 + 1);
                _310 = _309 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_332))).xy, ClothSimulVertsPositionsNormals.read(uint(_337)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_337)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_332 + 2))).xy, 0.0)).xyz * _113[_316].BaryCoordPos.w)) * _113[_316].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_349))).xy, ClothSimulVertsPositionsNormals.read(uint(_353)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_353)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_349 + 2))).xy, 0.0)).xyz * _113[_316].BaryCoordPos.w)) * _113[_316].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_363))).xy, ClothSimulVertsPositionsNormals.read(uint(_367)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_367)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_363 + 2))).xy, 0.0)).xyz * _113[_316].BaryCoordPos.w)) * ((1.0 - _113[_316].BaryCoordPos.x) - _113[_316].BaryCoordPos.y))) * 1.0);
                _315 = _314 + 1;
            }
            else
            {
                _310 = _309;
                _315 = _314;
            }
            _313 = _326 ? 1.0 : _312;
        }
        float3 _431;
        if ((_314 > 0) && (_312 > 9.9999997473787516355514526367188e-05))
        {
            _431 = _309 * (1.0 / _312);
        }
        else
        {
            _431 = float3(0.0);
        }
        _432 = _431;
        _433 = _306;
    }
    else
    {
        _432 = in.in_var_ATTRIBUTE0.xyz;
        _433 = in.in_var_ATTRIBUTE0.xyz;
    }
    float4 _435 = float4(in.in_var_ATTRIBUTE4.x);
    int _438 = int(in.in_var_ATTRIBUTE3.x) * 3;
    uint _439 = uint(_438);
    uint _443 = uint(_438 + 1);
    uint _446 = uint(_438 + 2);
    float4 _452 = float4(in.in_var_ATTRIBUTE4.y);
    int _455 = int(in.in_var_ATTRIBUTE3.y) * 3;
    uint _456 = uint(_455);
    uint _459 = uint(_455 + 1);
    uint _462 = uint(_455 + 2);
    float4 _471 = float4(in.in_var_ATTRIBUTE4.z);
    int _474 = int(in.in_var_ATTRIBUTE3.z) * 3;
    uint _475 = uint(_474);
    uint _478 = uint(_474 + 1);
    uint _481 = uint(_474 + 2);
    float4 _490 = float4(in.in_var_ATTRIBUTE4.w);
    int _493 = int(in.in_var_ATTRIBUTE3.w) * 3;
    uint _494 = uint(_493);
    uint _497 = uint(_493 + 1);
    uint _500 = uint(_493 + 2);
    float4 _505 = (((_435 * BoneMatrices.read(uint(_439))) + (_452 * BoneMatrices.read(uint(_456)))) + (_471 * BoneMatrices.read(uint(_475)))) + (_490 * BoneMatrices.read(uint(_494)));
    float4 _506 = (((_435 * BoneMatrices.read(uint(_443))) + (_452 * BoneMatrices.read(uint(_459)))) + (_471 * BoneMatrices.read(uint(_478)))) + (_490 * BoneMatrices.read(uint(_497)));
    float4 _507 = (((_435 * BoneMatrices.read(uint(_446))) + (_452 * BoneMatrices.read(uint(_462)))) + (_471 * BoneMatrices.read(uint(_481)))) + (_490 * BoneMatrices.read(uint(_500)));
    bool _511 = _Globals.NumBoneInfluencesParam > 4u;
    float3x4 _591;
    if (_511)
    {
        float4 _515 = float4(in.in_var_ATTRIBUTE15.x);
        int _518 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _534 = float4(in.in_var_ATTRIBUTE15.y);
        int _537 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _553 = float4(in.in_var_ATTRIBUTE15.z);
        int _556 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _572 = float4(in.in_var_ATTRIBUTE15.w);
        int _575 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _591 = float3x4((((_505 + (_515 * BoneMatrices.read(uint(uint(_518))))) + (_534 * BoneMatrices.read(uint(uint(_537))))) + (_553 * BoneMatrices.read(uint(uint(_556))))) + (_572 * BoneMatrices.read(uint(uint(_575)))), (((_506 + (_515 * BoneMatrices.read(uint(uint(_518 + 1))))) + (_534 * BoneMatrices.read(uint(uint(_537 + 1))))) + (_553 * BoneMatrices.read(uint(uint(_556 + 1))))) + (_572 * BoneMatrices.read(uint(uint(_575 + 1)))), (((_507 + (_515 * BoneMatrices.read(uint(uint(_518 + 2))))) + (_534 * BoneMatrices.read(uint(uint(_537 + 2))))) + (_553 * BoneMatrices.read(uint(uint(_556 + 2))))) + (_572 * BoneMatrices.read(uint(uint(_575 + 2)))));
    }
    else
    {
        _591 = float3x4(_505, _506, _507);
    }
    spvUnsafeArray<FClothVertex, 1> _109;
    _109 = _110;
    float _772;
    float3x3 _773;
    if (_109[0].SimulIndices.w < 65535u)
    {
        float _603;
        float3 _606;
        float3 _608;
        float _610;
        int _612;
        _603 = _Globals.ClothBlendWeight;
        _606 = float3(0.0);
        _608 = float3(0.0);
        _610 = 0.0;
        _612 = 0;
        float _604;
        float _611;
        float3 _607;
        float3 _609;
        int _613;
        for (int _614 = 0; _614 < 1; _603 = _604, _606 = _607, _608 = _609, _610 = _611, _612 = _613, _614++)
        {
            bool _625 = _109[_614].SimulIndices.w < 65535u;
            if (_625)
            {
                int _631 = int(_109[_614].SimulIndices.x) * 3;
                uint _636 = uint(_631 + 1);
                float3 _645 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_631))).xy, ClothSimulVertsPositionsNormals.read(uint(_636)).x, 1.0)).xyz;
                int _648 = int(_109[_614].SimulIndices.y) * 3;
                uint _652 = uint(_648 + 1);
                float3 _659 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_648))).xy, ClothSimulVertsPositionsNormals.read(uint(_652)).x, 1.0)).xyz;
                int _662 = int(_109[_614].SimulIndices.z) * 3;
                uint _666 = uint(_662 + 1);
                float3 _673 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_662))).xy, ClothSimulVertsPositionsNormals.read(uint(_666)).x, 1.0)).xyz;
                float3 _683 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_636)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_631 + 2))).xy, 0.0)).xyz;
                float3 _693 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_652)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_648 + 2))).xy, 0.0)).xyz;
                float3 _703 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_666)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_662 + 2))).xy, 0.0)).xyz;
                _607 = _606 + (((((_645 + (_683 * _109[_614].BaryCoordNormal.w)) * _109[_614].BaryCoordNormal.x) + ((_659 + (_693 * _109[_614].BaryCoordNormal.w)) * _109[_614].BaryCoordNormal.y)) + ((_673 + (_703 * _109[_614].BaryCoordNormal.w)) * _109[_614].BaryCoordNormal.z)) * 1.0);
                _609 = _608 + (((((_645 + (_683 * _109[_614].BaryCoordTangent.w)) * _109[_614].BaryCoordTangent.x) + ((_659 + (_693 * _109[_614].BaryCoordTangent.w)) * _109[_614].BaryCoordTangent.y)) + ((_673 + (_703 * _109[_614].BaryCoordTangent.w)) * _109[_614].BaryCoordTangent.z)) * 1.0);
                _613 = _612 + 1;
            }
            else
            {
                _607 = _606;
                _609 = _608;
                _613 = _612;
            }
            _604 = _625 ? _Globals.ClothBlendWeight : _603;
            _611 = _625 ? 1.0 : _610;
        }
        bool _740 = (_612 > 0) && (_610 > 9.9999997473787516355514526367188e-05);
        float3x3 _764;
        if (_740)
        {
            float _744 = 1.0 / _610;
            float3x3 _759 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _761 = _105;
            _761[0] = _759 * normalize((_608 * _744) - _432);
            float3x3 _763 = _761;
            _763[2] = _759 * normalize((_606 * _744) - _432);
            _764 = _763;
        }
        else
        {
            _764 = _105;
        }
        float3x3 _771 = _764;
        _771[1] = cross(_764[2], _764[0]) * in.in_var_ATTRIBUTE2.w;
        _772 = _740 ? _603 : 0.0;
        _773 = _771;
    }
    else
    {
        _772 = 0.0;
        _773 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    bool _812;
    float3 _779 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _591);
    float3 _785 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _591);
    float3 _790 = float3(_772);
    float3 _798 = float3(1.0 - _772);
    float4 _873;
    switch (0u)
    {
        default:
        {
            _812 = _110[0].SimulIndices.w < 65535u;
            if (_812)
            {
                _873 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _591) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _432, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _822 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _591) + in.in_var_ATTRIBUTE12;
                _873 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _822.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _822.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _822.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    spvUnsafeArray<float2, 1> _108;
    _108 = in_var_ATTRIBUTE5;
    spvUnsafeArray<float2, 1> _111 = spvUnsafeArray<float2, 1>({ float2(0.0) });
    for (int _875 = 0; _875 < 1; )
    {
        _111[_875] = _108[_875];
        _875++;
        continue;
    }
    float4 _886 = _106;
    _886.w = 0.0;
    float3x3 _900 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _900[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _903 = _900;
    _903[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _906 = _903;
    _906[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _907 = _906 * float3x3((_773[0] * _790) + (_779 * _798), (_773[1] * _790) + (normalize(cross(_785, _779) * in.in_var_ATTRIBUTE2.w) * _798), (_773[2] * _790) + (_785 * _798));
    float3 _908 = _907[0];
    spvUnsafeArray<float4, 1> _918 = { float4(_111[0].x, _111[0].y, float4(0.0).z, float4(0.0).w) };
    float4 _1080;
    switch (0u)
    {
        default:
        {
            float4x4 _926 = Primitive.Primitive_PreviousLocalToWorld;
            _926[3].x = Primitive.Primitive_PreviousLocalToWorld[3].x + View.View_PrevPreViewTranslation.x;
            float4x4 _930 = _926;
            _930[3].y = Primitive.Primitive_PreviousLocalToWorld[3].y + View.View_PrevPreViewTranslation.y;
            float4x4 _934 = _930;
            _934[3].z = Primitive.Primitive_PreviousLocalToWorld[3].z + View.View_PrevPreViewTranslation.z;
            float3x4 _1055;
            if (_Globals.PerBoneMotionBlur != 0u)
            {
                float4 _971 = (((_435 * PreviousBoneMatrices.read(uint(_439))) + (_452 * PreviousBoneMatrices.read(uint(_456)))) + (_471 * PreviousBoneMatrices.read(uint(_475)))) + (_490 * PreviousBoneMatrices.read(uint(_494)));
                float4 _972 = (((_435 * PreviousBoneMatrices.read(uint(_443))) + (_452 * PreviousBoneMatrices.read(uint(_459)))) + (_471 * PreviousBoneMatrices.read(uint(_478)))) + (_490 * PreviousBoneMatrices.read(uint(_497)));
                float4 _973 = (((_435 * PreviousBoneMatrices.read(uint(_446))) + (_452 * PreviousBoneMatrices.read(uint(_462)))) + (_471 * PreviousBoneMatrices.read(uint(_481)))) + (_490 * PreviousBoneMatrices.read(uint(_500)));
                float3x4 _1054;
                if (_511)
                {
                    float4 _978 = float4(in.in_var_ATTRIBUTE15.x);
                    int _981 = int(in.in_var_ATTRIBUTE14.x) * 3;
                    float4 _997 = float4(in.in_var_ATTRIBUTE15.y);
                    int _1000 = int(in.in_var_ATTRIBUTE14.y) * 3;
                    float4 _1016 = float4(in.in_var_ATTRIBUTE15.z);
                    int _1019 = int(in.in_var_ATTRIBUTE14.z) * 3;
                    float4 _1035 = float4(in.in_var_ATTRIBUTE15.w);
                    int _1038 = int(in.in_var_ATTRIBUTE14.w) * 3;
                    _1054 = float3x4((((_971 + (_978 * PreviousBoneMatrices.read(uint(uint(_981))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019))))) + (_1035 * PreviousBoneMatrices.read(uint(uint(_1038)))), (((_972 + (_978 * PreviousBoneMatrices.read(uint(uint(_981 + 1))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000 + 1))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019 + 1))))) + (_1035 * PreviousBoneMatrices.read(uint(uint(_1038 + 1)))), (((_973 + (_978 * PreviousBoneMatrices.read(uint(uint(_981 + 2))))) + (_997 * PreviousBoneMatrices.read(uint(uint(_1000 + 2))))) + (_1016 * PreviousBoneMatrices.read(uint(uint(_1019 + 2))))) + (_1035 * PreviousBoneMatrices.read(uint(uint(_1038 + 2)))));
                }
                else
                {
                    _1054 = float3x4(_971, _972, _973);
                }
                _1055 = _1054;
            }
            else
            {
                _1055 = _591;
            }
            float4 _1067 = _934 * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _1055) + in.in_var_ATTRIBUTE12, 1.0);
            if (_812)
            {
                _1080 = float4(mix(_1067.xyz, _433 + View.View_PrevPreViewTranslation, float3(_Globals.ClothBlendWeight)), 1.0);
                break;
            }
            _1080 = _1067;
            break;
        }
    }
    float4 _1090 = View.View_TranslatedWorldToClip * float4(_873.xyz, 1.0);
    float4 _1099 = _1090;
    _1099.z = _1090.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _1090.w) : 0.0);
    out.gl_Position = _1099;
    out.out_var_TEXCOORD6 = _1090;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_1080.xyz, 1.0);
    out.out_var_TEXCOORD10_centroid = float4(_908.x, _908.y, _908.z, _886.w);
    out.out_var_TEXCOORD11_centroid = float4(_907[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out_var_TEXCOORD0 = _918;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

