

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

constant float _100 = {};
constant float3x3 _101 = {};

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

vertex Main_out Main_00003c5e_1056e540(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 1> _104;
    for (int _123 = 0; _123 < 1; )
    {
        uint _130 = ((((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x) + uint(_123)) * 4u;
        _104[_123].BaryCoordPos = GPUSkinApexCloth.read(uint(_130));
        _104[_123].BaryCoordNormal = GPUSkinApexCloth.read(uint((_130 + 1u)));
        _104[_123].BaryCoordTangent = GPUSkinApexCloth.read(uint((_130 + 2u)));
        uint4 _142 = as_type<uint4>(GPUSkinApexCloth.read(uint((_130 + 3u))));
        uint2 _143 = _142.xy;
        uint2 _146 = (_143 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _104[_123].SimulIndices = uint4(_104[_123].SimulIndices.x, _146.x, _104[_123].SimulIndices.z, _146.y);
        uint2 _150 = _143 & uint2(65535u);
        _104[_123].SimulIndices = uint4(_150.x, _104[_123].SimulIndices.y, _150.y, _104[_123].SimulIndices.w);
        _104[_123].Weight = as_type<float>(_142.z);
        _123++;
        continue;
    }
    float3 _289;
    if (_104[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 1> _105;
        _105 = _104;
        float3 _166;
        float _169;
        int _171;
        _166 = float3(0.0);
        _169 = 0.0;
        _171 = 0;
        float _170;
        float3 _167;
        int _172;
        for (int _173 = 0; _173 < 1; _166 = _167, _169 = _170, _171 = _172, _173++)
        {
            bool _183 = _105[_173].SimulIndices.w < 65535u;
            if (_183)
            {
                int _189 = int(_105[_173].SimulIndices.x) * 3;
                uint _194 = uint(_189 + 1);
                int _206 = int(_105[_173].SimulIndices.y) * 3;
                uint _210 = uint(_206 + 1);
                int _220 = int(_105[_173].SimulIndices.z) * 3;
                uint _224 = uint(_220 + 1);
                _167 = _166 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_189))).xy, ClothSimulVertsPositionsNormals.read(uint(_194)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_194)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_189 + 2))).xy, 0.0)).xyz * _105[_173].BaryCoordPos.w)) * _105[_173].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_206))).xy, ClothSimulVertsPositionsNormals.read(uint(_210)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_210)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_206 + 2))).xy, 0.0)).xyz * _105[_173].BaryCoordPos.w)) * _105[_173].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_220))).xy, ClothSimulVertsPositionsNormals.read(uint(_224)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_224)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_220 + 2))).xy, 0.0)).xyz * _105[_173].BaryCoordPos.w)) * ((1.0 - _105[_173].BaryCoordPos.x) - _105[_173].BaryCoordPos.y))) * 1.0);
                _172 = _171 + 1;
            }
            else
            {
                _167 = _166;
                _172 = _171;
            }
            _170 = _183 ? 1.0 : _169;
        }
        float3 _288;
        if ((_171 > 0) && (_169 > 9.9999997473787516355514526367188e-05))
        {
            _288 = _166 * (1.0 / _169);
        }
        else
        {
            _288 = float3(0.0);
        }
        _289 = _288;
    }
    else
    {
        _289 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _291 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _294 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _300 = int(_294 + (_Globals.InputWeightIndexSize * uint(_291)));
    float3x4 _302;
    _302 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _303;
    for (int _305 = 0; _305 < _291; _302 = _303, _305++)
    {
        int _313 = int(_294 + (_Globals.InputWeightIndexSize * uint(_305)));
        int _318 = int(InputWeightStream.read(uint(uint(_313))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _364 = float4(float(InputWeightStream.read(uint(uint(_300 + _305))).x) * 0.0039215688593685626983642578125);
            int _365 = int((InputWeightStream.read(uint(uint(_313 + 1))).x << 8u) | uint(_318)) * 3;
            _303 = float3x4(_302[0] + (_364 * BoneMatrices.read(uint(uint(_365)))), _302[1] + (_364 * BoneMatrices.read(uint(uint(_365 + 1)))), _302[2] + (_364 * BoneMatrices.read(uint(uint(_365 + 2)))));
        }
        else
        {
            float4 _329 = float4(float(InputWeightStream.read(uint(uint(_300 + _305))).x) * 0.0039215688593685626983642578125);
            int _330 = _318 * 3;
            _303 = float3x4(_302[0] + (_329 * BoneMatrices.read(uint(uint(_330)))), _302[1] + (_329 * BoneMatrices.read(uint(uint(_330 + 1)))), _302[2] + (_329 * BoneMatrices.read(uint(uint(_330 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 1> _103;
    _103 = _104;
    float _565;
    float3x3 _566;
    if (_103[0].SimulIndices.w < 65535u)
    {
        float _396;
        float3 _399;
        float3 _401;
        float _403;
        int _405;
        _396 = _Globals.ClothBlendWeight;
        _399 = float3(0.0);
        _401 = float3(0.0);
        _403 = 0.0;
        _405 = 0;
        float _397;
        float _404;
        float3 _400;
        float3 _402;
        int _406;
        for (int _407 = 0; _407 < 1; _396 = _397, _399 = _400, _401 = _402, _403 = _404, _405 = _406, _407++)
        {
            bool _418 = _103[_407].SimulIndices.w < 65535u;
            if (_418)
            {
                int _424 = int(_103[_407].SimulIndices.x) * 3;
                uint _429 = uint(_424 + 1);
                float3 _438 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_424))).xy, ClothSimulVertsPositionsNormals.read(uint(_429)).x, 1.0)).xyz;
                int _441 = int(_103[_407].SimulIndices.y) * 3;
                uint _445 = uint(_441 + 1);
                float3 _452 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_441))).xy, ClothSimulVertsPositionsNormals.read(uint(_445)).x, 1.0)).xyz;
                int _455 = int(_103[_407].SimulIndices.z) * 3;
                uint _459 = uint(_455 + 1);
                float3 _466 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_455))).xy, ClothSimulVertsPositionsNormals.read(uint(_459)).x, 1.0)).xyz;
                float3 _476 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_429)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_424 + 2))).xy, 0.0)).xyz;
                float3 _486 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_445)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_441 + 2))).xy, 0.0)).xyz;
                float3 _496 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_459)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_455 + 2))).xy, 0.0)).xyz;
                _400 = _399 + (((((_438 + (_476 * _103[_407].BaryCoordNormal.w)) * _103[_407].BaryCoordNormal.x) + ((_452 + (_486 * _103[_407].BaryCoordNormal.w)) * _103[_407].BaryCoordNormal.y)) + ((_466 + (_496 * _103[_407].BaryCoordNormal.w)) * _103[_407].BaryCoordNormal.z)) * 1.0);
                _402 = _401 + (((((_438 + (_476 * _103[_407].BaryCoordTangent.w)) * _103[_407].BaryCoordTangent.x) + ((_452 + (_486 * _103[_407].BaryCoordTangent.w)) * _103[_407].BaryCoordTangent.y)) + ((_466 + (_496 * _103[_407].BaryCoordTangent.w)) * _103[_407].BaryCoordTangent.z)) * 1.0);
                _406 = _405 + 1;
            }
            else
            {
                _400 = _399;
                _402 = _401;
                _406 = _405;
            }
            _397 = _418 ? _Globals.ClothBlendWeight : _396;
            _404 = _418 ? 1.0 : _403;
        }
        bool _533 = (_405 > 0) && (_403 > 9.9999997473787516355514526367188e-05);
        float3x3 _557;
        if (_533)
        {
            float _537 = 1.0 / _403;
            float3x3 _552 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _554 = _101;
            _554[0] = _552 * normalize((_401 * _537) - _289);
            float3x3 _556 = _554;
            _556[2] = _552 * normalize((_399 * _537) - _289);
            _557 = _556;
        }
        else
        {
            _557 = _101;
        }
        float3x3 _564 = _557;
        _564[1] = cross(_557[2], _557[0]) * in.in_var_ATTRIBUTE2.w;
        _565 = _533 ? _396 : 0.0;
        _566 = _564;
    }
    else
    {
        _565 = 0.0;
        _566 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _572 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _302);
    float3 _578 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _302);
    float3 _583 = float3(_565);
    float3 _591 = float3(1.0 - _565);
    float4 _666;
    switch (0u)
    {
        default:
        {
            if (_104[0].SimulIndices.w < 65535u)
            {
                _666 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _302) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _289, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _615 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _302) + in.in_var_ATTRIBUTE12;
                _666 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _615.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _615.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _615.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float3x3 _680 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _680[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _683 = _680;
    _683[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _686 = _683;
    _686[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float4 _699 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_666.x, _666.y, _666.z, _666.w);
    float4 _710;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_699.z < 0.0))
    {
        float4 _708 = _699;
        _708.z = 9.9999999747524270787835121154785e-07;
        float4 _709 = _708;
        _709.w = 1.0;
        _710 = _709;
    }
    else
    {
        _710 = _699;
    }
    float _716 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), float4((_686 * float3x3((_566[0] * _583) + (_572 * _591), (_566[1] * _583) + (normalize(cross(_578, _572) * in.in_var_ATTRIBUTE2.w) * _591), (_566[2] * _583) + (_578 * _591)))[2], _100).xyz));
    out.out_var_TEXCOORD6 = _710.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_716) > 0.0) ? (sqrt(fast::clamp(1.0 - (_716 * _716), 0.0, 1.0)) / _716) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _710;
    return out;
}

