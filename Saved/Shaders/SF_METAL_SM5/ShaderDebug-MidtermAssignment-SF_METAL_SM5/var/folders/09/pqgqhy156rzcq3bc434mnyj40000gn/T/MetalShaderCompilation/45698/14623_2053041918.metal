

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
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
    float4 Primitive_InvNonUniformScaleAndDeterminantSign;
    char _m2_pad[16];
    float4x4 Primitive_WorldToLocal;
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

constant float3x3 _93 = {};
constant float4 _94 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
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

vertex Main_out Main_0000391f_7a5eeefe(Main_in in [[stage_in]], constant type_View& View [[buffer(4)]], constant type_Primitive& Primitive [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<uint> InputWeightStream [[texture(1)]], texture_buffer<float> GPUSkinApexCloth [[texture(2)]], texture_buffer<float> BoneMatrices [[texture(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<FClothVertex, 5> _97;
    for (int _118 = 0; _118 < 5; )
    {
        uint _126 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset.y) - _Globals.GPUSkinApexClothStartIndexOffset.x)) + uint(_118)) * 4u;
        _97[_118].BaryCoordPos = GPUSkinApexCloth.read(uint(_126));
        _97[_118].BaryCoordNormal = GPUSkinApexCloth.read(uint((_126 + 1u)));
        _97[_118].BaryCoordTangent = GPUSkinApexCloth.read(uint((_126 + 2u)));
        uint4 _138 = as_type<uint4>(GPUSkinApexCloth.read(uint((_126 + 3u))));
        uint2 _139 = _138.xy;
        uint2 _142 = (_139 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _97[_118].SimulIndices = uint4(_97[_118].SimulIndices.x, _142.x, _97[_118].SimulIndices.z, _142.y);
        uint2 _146 = _139 & uint2(65535u);
        _97[_118].SimulIndices = uint4(_146.x, _97[_118].SimulIndices.y, _146.y, _97[_118].SimulIndices.w);
        _97[_118].Weight = as_type<float>(_138.z);
        _118++;
        continue;
    }
    float3 _287;
    if (_97[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _98;
        _98 = _97;
        float3 _162;
        float _165;
        int _167;
        _162 = float3(0.0);
        _165 = 0.0;
        _167 = 0;
        float3 _163;
        float _166;
        int _168;
        for (int _169 = 0; _169 < 5; _162 = _163, _165 = _166, _167 = _168, _169++)
        {
            if (_98[_169].SimulIndices.w < 65535u)
            {
                int _186 = int(_98[_169].SimulIndices.x) * 3;
                uint _191 = uint(_186 + 1);
                int _203 = int(_98[_169].SimulIndices.y) * 3;
                uint _207 = uint(_203 + 1);
                int _217 = int(_98[_169].SimulIndices.z) * 3;
                uint _221 = uint(_217 + 1);
                _163 = _162 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_186))).xy, ClothSimulVertsPositionsNormals.read(uint(_191)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_191)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_186 + 2))).xy, 0.0)).xyz * _98[_169].BaryCoordPos.w)) * _98[_169].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_203))).xy, ClothSimulVertsPositionsNormals.read(uint(_207)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_207)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_203 + 2))).xy, 0.0)).xyz * _98[_169].BaryCoordPos.w)) * _98[_169].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_217))).xy, ClothSimulVertsPositionsNormals.read(uint(_221)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_221)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_217 + 2))).xy, 0.0)).xyz * _98[_169].BaryCoordPos.w)) * ((1.0 - _98[_169].BaryCoordPos.x) - _98[_169].BaryCoordPos.y))) * _98[_169].Weight);
                _166 = _165 + _98[_169].Weight;
                _168 = _167 + 1;
            }
            else
            {
                _163 = _162;
                _166 = _165;
                _168 = _167;
            }
        }
        float3 _286;
        if ((_167 > 0) && (_165 > 9.9999997473787516355514526367188e-05))
        {
            _286 = _162 * (1.0 / _165);
        }
        else
        {
            _286 = float3(0.0);
        }
        _287 = _286;
    }
    else
    {
        _287 = in.in_var_ATTRIBUTE0.xyz;
    }
    int _289 = int(in.in_var_ATTRIBUTE3 & 255u);
    uint _292 = uint(int(in.in_var_ATTRIBUTE3 >> 8u));
    int _298 = int(_292 + (_Globals.InputWeightIndexSize * uint(_289)));
    float3x4 _300;
    _300 = float3x4(float4(0.0), float4(0.0), float4(0.0));
    float3x4 _301;
    for (int _303 = 0; _303 < _289; _300 = _301, _303++)
    {
        int _311 = int(_292 + (_Globals.InputWeightIndexSize * uint(_303)));
        int _316 = int(InputWeightStream.read(uint(uint(_311))).x);
        if (_Globals.InputWeightIndexSize > 1u)
        {
            float4 _362 = float4(float(InputWeightStream.read(uint(uint(_298 + _303))).x) * 0.0039215688593685626983642578125);
            int _363 = int((InputWeightStream.read(uint(uint(_311 + 1))).x << 8u) | uint(_316)) * 3;
            _301 = float3x4(_300[0] + (_362 * BoneMatrices.read(uint(uint(_363)))), _300[1] + (_362 * BoneMatrices.read(uint(uint(_363 + 1)))), _300[2] + (_362 * BoneMatrices.read(uint(uint(_363 + 2)))));
        }
        else
        {
            float4 _327 = float4(float(InputWeightStream.read(uint(uint(_298 + _303))).x) * 0.0039215688593685626983642578125);
            int _328 = _316 * 3;
            _301 = float3x4(_300[0] + (_327 * BoneMatrices.read(uint(uint(_328)))), _300[1] + (_327 * BoneMatrices.read(uint(uint(_328 + 1)))), _300[2] + (_327 * BoneMatrices.read(uint(uint(_328 + 2)))));
        }
    }
    spvUnsafeArray<FClothVertex, 5> _96;
    _96 = _97;
    float _565;
    float3x3 _566;
    if (_96[0].SimulIndices.w < 65535u)
    {
        float _394;
        float3 _397;
        float3 _399;
        float _401;
        int _403;
        _394 = _Globals.ClothBlendWeight;
        _397 = float3(0.0);
        _399 = float3(0.0);
        _401 = 0.0;
        _403 = 0;
        float _395;
        float3 _398;
        float3 _400;
        float _402;
        int _404;
        for (int _405 = 0; _405 < 5; _394 = _395, _397 = _398, _399 = _400, _401 = _402, _403 = _404, _405++)
        {
            bool _417 = _96[_405].SimulIndices.w < 65535u;
            if (_417)
            {
                int _423 = int(_96[_405].SimulIndices.x) * 3;
                uint _428 = uint(_423 + 1);
                float3 _437 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_423))).xy, ClothSimulVertsPositionsNormals.read(uint(_428)).x, 1.0)).xyz;
                int _440 = int(_96[_405].SimulIndices.y) * 3;
                uint _444 = uint(_440 + 1);
                float3 _451 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_440))).xy, ClothSimulVertsPositionsNormals.read(uint(_444)).x, 1.0)).xyz;
                int _454 = int(_96[_405].SimulIndices.z) * 3;
                uint _458 = uint(_454 + 1);
                float3 _465 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_454))).xy, ClothSimulVertsPositionsNormals.read(uint(_458)).x, 1.0)).xyz;
                float3 _475 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_428)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_423 + 2))).xy, 0.0)).xyz;
                float3 _485 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_444)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_440 + 2))).xy, 0.0)).xyz;
                float3 _495 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_458)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_454 + 2))).xy, 0.0)).xyz;
                _398 = _397 + (((((_437 + (_475 * _96[_405].BaryCoordNormal.w)) * _96[_405].BaryCoordNormal.x) + ((_451 + (_485 * _96[_405].BaryCoordNormal.w)) * _96[_405].BaryCoordNormal.y)) + ((_465 + (_495 * _96[_405].BaryCoordNormal.w)) * _96[_405].BaryCoordNormal.z)) * _96[_405].Weight);
                _400 = _399 + (((((_437 + (_475 * _96[_405].BaryCoordTangent.w)) * _96[_405].BaryCoordTangent.x) + ((_451 + (_485 * _96[_405].BaryCoordTangent.w)) * _96[_405].BaryCoordTangent.y)) + ((_465 + (_495 * _96[_405].BaryCoordTangent.w)) * _96[_405].BaryCoordTangent.z)) * _96[_405].Weight);
                _402 = _401 + _96[_405].Weight;
                _404 = _403 + 1;
            }
            else
            {
                _398 = _397;
                _400 = _399;
                _402 = _401;
                _404 = _403;
            }
            _395 = _417 ? _Globals.ClothBlendWeight : _394;
        }
        bool _533 = (_403 > 0) && (_401 > 9.9999997473787516355514526367188e-05);
        float3x3 _557;
        if (_533)
        {
            float _537 = 1.0 / _401;
            float3x3 _552 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _554 = _93;
            _554[0] = _552 * normalize((_399 * _537) - _287);
            float3x3 _556 = _554;
            _556[2] = _552 * normalize((_397 * _537) - _287);
            _557 = _556;
        }
        else
        {
            _557 = _93;
        }
        float3x3 _564 = _557;
        _564[1] = cross(_557[2], _557[0]) * in.in_var_ATTRIBUTE2.w;
        _565 = _533 ? _394 : 0.0;
        _566 = _564;
    }
    else
    {
        _565 = 0.0;
        _566 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _572 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _300);
    float3 _578 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _300);
    float3 _583 = float3(_565);
    float3 _591 = float3(1.0 - _565);
    float4 _666;
    switch (0u)
    {
        default:
        {
            if (_97[0].SimulIndices.w < 65535u)
            {
                _666 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _300) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _287, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _615 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _300) + in.in_var_ATTRIBUTE12;
                _666 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _615.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _615.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _615.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _668 = View.View_TranslatedWorldToClip * float4(_666.x, _666.y, _666.z, _666.w);
    float4 _669 = _94;
    _669.w = 0.0;
    float3x3 _683 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _683[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _686 = _683;
    _686[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _689 = _686;
    _689[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _690 = _689 * float3x3((_566[0] * _583) + (_572 * _591), (_566[1] * _583) + (normalize(cross(_578, _572) * in.in_var_ATTRIBUTE2.w) * _591), (_566[2] * _583) + (_578 * _591));
    float3 _691 = _690[0];
    out.out_var_TEXCOORD10_centroid = float4(_691.x, _691.y, _691.z, _669.w);
    out.out_var_TEXCOORD11_centroid = float4(_690[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.gl_Position = _668;
    return out;
}

