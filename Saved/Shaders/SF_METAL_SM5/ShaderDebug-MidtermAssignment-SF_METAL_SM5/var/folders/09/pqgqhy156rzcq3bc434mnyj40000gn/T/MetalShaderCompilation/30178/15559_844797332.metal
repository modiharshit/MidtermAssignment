

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
    float4x4 ClothLocalToWorld;
    char _m1_pad[64];
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

constant float _102 = {};
constant float3x3 _103 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float3 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    uint in_var_ATTRIBUTE3 [[attribute(3)]];
    float3 in_var_ATTRIBUTE11 [[attribute(11)]];
    float3 in_var_ATTRIBUTE12 [[attribute(12)]];
};

vertex Main_out Main_00003cc7_325a9594(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _106;
    for (int _125 = 0; _125 < 5; )
    {
        uint _133 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_125)) * 4u;
        _106[_125].BaryCoordPos = GPUSkinApexCloth.read(uint(_133));
        _106[_125].BaryCoordNormal = GPUSkinApexCloth.read(uint((_133 + 1u)));
        _106[_125].BaryCoordTangent = GPUSkinApexCloth.read(uint((_133 + 2u)));
        uint4 _145 = as_type<uint4>(GPUSkinApexCloth.read(uint((_133 + 3u))));
        uint2 _146 = _145.xy;
        uint2 _149 = (_146 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _106[_125].SimulIndices = uint4(_106[_125].SimulIndices.x, _149.x, _106[_125].SimulIndices.z, _149.y);
        uint2 _153 = _146 & uint2(65535u);
        _106[_125].SimulIndices = uint4(_153.x, _106[_125].SimulIndices.y, _153.y, _106[_125].SimulIndices.w);
        _106[_125].Weight = as_type<float>(_145.z);
        _125++;
        continue;
    }
    float3 _294;
    if (_106[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _107;
        _107 = _106;
        float3 _169;
        float _172;
        int _174;
        _169 = float3(0.0);
        _172 = 0.0;
        _174 = 0;
        float3 _170;
        float _173;
        int _175;
        for (int _176 = 0; _176 < 5; _169 = _170, _172 = _173, _174 = _175, _176++)
        {
            if (_107[_176].SimulIndices.w < 65535u)
            {
                int _193 = int(_107[_176].SimulIndices.x) * 3;
                uint _198 = uint(_193 + 1);
                int _210 = int(_107[_176].SimulIndices.y) * 3;
                uint _214 = uint(_210 + 1);
                int _224 = int(_107[_176].SimulIndices.z) * 3;
                uint _228 = uint(_224 + 1);
                _170 = _169 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_193))).xy, ClothSimulVertsPositionsNormals.read(uint(_198)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_198)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_193 + 2))).xy, 0.0)).xyz * _107[_176].BaryCoordPos.w)) * _107[_176].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_210))).xy, ClothSimulVertsPositionsNormals.read(uint(_214)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_214)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_210 + 2))).xy, 0.0)).xyz * _107[_176].BaryCoordPos.w)) * _107[_176].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_224))).xy, ClothSimulVertsPositionsNormals.read(uint(_228)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_228)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_224 + 2))).xy, 0.0)).xyz * _107[_176].BaryCoordPos.w)) * ((1.0 - _107[_176].BaryCoordPos.x) - _107[_176].BaryCoordPos.y))) * _107[_176].Weight);
                _173 = _172 + _107[_176].Weight;
                _175 = _174 + 1;
            }
            else
            {
                _170 = _169;
                _173 = _172;
                _175 = _174;
            }
        }
        float3 _293;
        if ((_174 > 0) && (_172 > 9.9999997473787516355514526367188e-05))
        {
            _293 = _169 * (1.0 / _172);
        }
        else
        {
            _293 = float3(0.0);
        }
        _294 = _293;
    }
    else
    {
        _294 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _296 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _299 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _305 = int(_299 + (_Globals.InputWeightIndexSize * uint(_296)));
    float3x4 _307;
    _307 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _308;
    for (int _310 = 0; _310 < _296; _307 = _308, _310++)
    {
        int _318 = int(_299 + (_Globals.InputWeightIndexSize * uint(_310)));
        int _323 = int(InputWeightStream.read(uint(uint(_318))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _369 = float4(float(InputWeightStream.read(uint(uint(_305 + _310))).x) * 0.0039215688593685626983642578125);
            int _370 = int((InputWeightStream.read(uint(uint(_318 + 1))).x << 8u) | uint(_323)) * 3;
            _308 = float3x4(_307[0] + (_369 * BoneMatrices.read(uint(uint(_370)))), _307[1] + (_369 * BoneMatrices.read(uint(uint(_370 + 1)))), _307[2] + (_369 * BoneMatrices.read(uint(uint(_370 + 2)))));
        }
        else
        {
            float4 _334 = float4(float(InputWeightStream.read(uint(uint(_305 + _310))).x) * 0.0039215688593685626983642578125);
            int _335 = _323 * 3;
            _308 = float3x4(_307[0] + (_334 * BoneMatrices.read(uint(uint(_335)))), _307[1] + (_334 * BoneMatrices.read(uint(uint(_335 + 1)))), _307[2] + (_334 * BoneMatrices.read(uint(uint(_335 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _105;
    _105 = _106;
    float _572;
    float3x3 _573;
    if (_105[0].SimulIndices.w < 65535u)
    {
        float _401;
        float3 _404;
        float3 _406;
        float _408;
        int _410;
        _401 = _Globals.ClothBlendWeight;
        _404 = float3(0.0);
        _406 = float3(0.0);
        _408 = 0.0;
        _410 = 0;
        float _402;
        float3 _405;
        float3 _407;
        float _409;
        int _411;
        for (int _412 = 0; _412 < 5; _401 = _402, _404 = _405, _406 = _407, _408 = _409, _410 = _411, _412++)
        {
            bool _424 = _105[_412].SimulIndices.w < 65535u;
            if (_424)
            {
                int _430 = int(_105[_412].SimulIndices.x) * 3;
                uint _435 = uint(_430 + 1);
                float3 _444 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_430))).xy, ClothSimulVertsPositionsNormals.read(uint(_435)).x, 1.0)).xyz;
                int _447 = int(_105[_412].SimulIndices.y) * 3;
                uint _451 = uint(_447 + 1);
                float3 _458 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_447))).xy, ClothSimulVertsPositionsNormals.read(uint(_451)).x, 1.0)).xyz;
                int _461 = int(_105[_412].SimulIndices.z) * 3;
                uint _465 = uint(_461 + 1);
                float3 _472 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_461))).xy, ClothSimulVertsPositionsNormals.read(uint(_465)).x, 1.0)).xyz;
                float3 _482 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_435)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_430 + 2))).xy, 0.0)).xyz;
                float3 _492 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_451)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_447 + 2))).xy, 0.0)).xyz;
                float3 _502 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_465)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_461 + 2))).xy, 0.0)).xyz;
                _405 = _404 + (((((_444 + (_482 * _105[_412].BaryCoordNormal.w)) * _105[_412].BaryCoordNormal.x) + ((_458 + (_492 * _105[_412].BaryCoordNormal.w)) * _105[_412].BaryCoordNormal.y)) + ((_472 + (_502 * _105[_412].BaryCoordNormal.w)) * _105[_412].BaryCoordNormal.z)) * _105[_412].Weight);
                _407 = _406 + (((((_444 + (_482 * _105[_412].BaryCoordTangent.w)) * _105[_412].BaryCoordTangent.x) + ((_458 + (_492 * _105[_412].BaryCoordTangent.w)) * _105[_412].BaryCoordTangent.y)) + ((_472 + (_502 * _105[_412].BaryCoordTangent.w)) * _105[_412].BaryCoordTangent.z)) * _105[_412].Weight);
                _409 = _408 + _105[_412].Weight;
                _411 = _410 + 1;
            }
            else
            {
                _405 = _404;
                _407 = _406;
                _409 = _408;
                _411 = _410;
            }
            _402 = _424 ? _Globals.ClothBlendWeight : _401;
        }
        bool _540 = (_410 > 0) && (_408 > 9.9999997473787516355514526367188e-05);
        float3x3 _564;
        if (_540)
        {
            float _544 = 1.0 / _408;
            float3x3 _559 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _561 = _103;
            _561[0] = _559 * normalize((_406 * _544) - _294);
            float3x3 _563 = _561;
            _563[2] = _559 * normalize((_404 * _544) - _294);
            _564 = _563;
        }
        else
        {
            _564 = _103;
        }
        float3x3 _571 = _564;
        _571[1] = cross(_564[2], _564[0]) * in.in_var_ATTRIBUTE2.w;
        _572 = _540 ? _401 : 0.0;
        _573 = _571;
    }
    else
    {
        _572 = 0.0;
        _573 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _579 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _307);
    float3 _585 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _307);
    float3 _590 = float3(_572);
    float3 _598 = float3(1.0 - _572);
    float4 _673;
    switch (0u)
    {
        default:
        {
            if (_106[0].SimulIndices.w < 65535u)
            {
                _673 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _307) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _294, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _622 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _307) + in.in_var_ATTRIBUTE12;
                _673 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _622.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _622.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _622.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _687 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _687[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _690 = _687;
    _690[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _693 = _690;
    _693[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _706 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_673.x, _673.y, _673.z, _673.w);
    float4 _717;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_706.z < 0.0))
    {
        float4 _715 = _706;
        _715.z = 9.9999999747524270787835121154785e-07;
        float4 _716 = _715;
        _716.w = 1.0;
        _717 = _716;
    }
    else
    {
        _717 = _706;
    }
    float _723 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_693 * float3x3((_573[0] * _590) + (_579 * _598), (_573[1] * _590) + (normalize(cross(_585, _579) * in.in_var_ATTRIBUTE2.w) * _598), (_573[2] * _590) + (_585 * _598)))[2], _102).xyz));
    out.out_var_TEXCOORD6 = _717.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_723) > 0.0) ? (sqrt(fast::clamp(1.0 - (_723 * _723), 0.0, 1.0)) / _723) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _717;
    return out;
}

