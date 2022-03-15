

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
    uint NumBoneInfluencesParam;
    float4x4 ClothLocalToWorld;
    char _m2_pad[64];
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

constant float3x3 _90 = {};
constant float4 _91 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD10_centroid [[user(locn0)]];
    float4 out_var_TEXCOORD11_centroid [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
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

vertex MainVertexShader_out Main_00003df4_1c3ad9f3(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(3)]], constant type_Primitive& Primitive [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ClothSimulVertsPositionsNormals [[texture(0)]], texture_buffer<float> GPUSkinApexCloth [[texture(1)]], texture_buffer<float> BoneMatrices [[texture(2)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<FClothVertex, 5> _94;
    for (int _118 = 0; _118 < 5; )
    {
        uint _126 = ((5u * (((gl_VertexIndex - gl_BaseVertex) + _Globals.GPUSkinApexClothStartIndexOffset[1]) - _Globals.GPUSkinApexClothStartIndexOffset[0])) + uint(_118)) * 4u;
        _94[_118].BaryCoordPos = GPUSkinApexCloth.read(uint(_126));
        _94[_118].BaryCoordNormal = GPUSkinApexCloth.read(uint((_126 + 1u)));
        _94[_118].BaryCoordTangent = GPUSkinApexCloth.read(uint((_126 + 2u)));
        uint4 _138 = as_type<uint4>(GPUSkinApexCloth.read(uint((_126 + 3u))));
        uint2 _139 = _138.xy;
        uint2 _142 = (_139 >> (uint2(16u) & uint2(31u))) & uint2(65535u);
        _94[_118].SimulIndices = uint4(_94[_118].SimulIndices.x, _142.x, _94[_118].SimulIndices.z, _142.y);
        uint2 _146 = _139 & uint2(65535u);
        _94[_118].SimulIndices = uint4(_146.x, _94[_118].SimulIndices.y, _146.y, _94[_118].SimulIndices.w);
        _94[_118].Weight = as_type<float>(_138.z);
        _118++;
        continue;
    }
    float3 _287;
    if (_94[0].SimulIndices.w < 65535u)
    {
        spvUnsafeArray<FClothVertex, 5> _95;
        _95 = _94;
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
            if (_95[_169].SimulIndices.w < 65535u)
            {
                int _186 = int(_95[_169].SimulIndices.x) * 3;
                uint _191 = uint(_186 + 1);
                int _203 = int(_95[_169].SimulIndices.y) * 3;
                uint _207 = uint(_203 + 1);
                int _217 = int(_95[_169].SimulIndices.z) * 3;
                uint _221 = uint(_217 + 1);
                _163 = _162 + ((((((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_186))).xy, ClothSimulVertsPositionsNormals.read(uint(_191)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_191)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_186 + 2))).xy, 0.0)).xyz * _95[_169].BaryCoordPos.w)) * _95[_169].BaryCoordPos.x) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_203))).xy, ClothSimulVertsPositionsNormals.read(uint(_207)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_207)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_203 + 2))).xy, 0.0)).xyz * _95[_169].BaryCoordPos.w)) * _95[_169].BaryCoordPos.y)) + (((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_217))).xy, ClothSimulVertsPositionsNormals.read(uint(_221)).x, 1.0)).xyz + ((_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_221)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_217 + 2))).xy, 0.0)).xyz * _95[_169].BaryCoordPos.w)) * ((1.0 - _95[_169].BaryCoordPos.x) - _95[_169].BaryCoordPos.y))) * _95[_169].Weight);
                _166 = _165 + _95[_169].Weight;
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
    float4 _289 = float4(in.in_var_ATTRIBUTE4.x);
    int _292 = int(in.in_var_ATTRIBUTE3.x) * 3;
    float4 _306 = float4(in.in_var_ATTRIBUTE4.y);
    int _309 = int(in.in_var_ATTRIBUTE3.y) * 3;
    float4 _325 = float4(in.in_var_ATTRIBUTE4.z);
    int _328 = int(in.in_var_ATTRIBUTE3.z) * 3;
    float4 _344 = float4(in.in_var_ATTRIBUTE4.w);
    int _347 = int(in.in_var_ATTRIBUTE3.w) * 3;
    float4 _359 = (((_289 * BoneMatrices.read(uint(uint(_292)))) + (_306 * BoneMatrices.read(uint(uint(_309))))) + (_325 * BoneMatrices.read(uint(uint(_328))))) + (_344 * BoneMatrices.read(uint(uint(_347))));
    float4 _360 = (((_289 * BoneMatrices.read(uint(uint(_292 + 1)))) + (_306 * BoneMatrices.read(uint(uint(_309 + 1))))) + (_325 * BoneMatrices.read(uint(uint(_328 + 1))))) + (_344 * BoneMatrices.read(uint(uint(_347 + 1))));
    float4 _361 = (((_289 * BoneMatrices.read(uint(uint(_292 + 2)))) + (_306 * BoneMatrices.read(uint(uint(_309 + 2))))) + (_325 * BoneMatrices.read(uint(uint(_328 + 2))))) + (_344 * BoneMatrices.read(uint(uint(_347 + 2))));
    float3x4 _445;
    if (_Globals.NumBoneInfluencesParam > 4u)
    {
        float4 _369 = float4(in.in_var_ATTRIBUTE15.x);
        int _372 = int(in.in_var_ATTRIBUTE14.x) * 3;
        float4 _388 = float4(in.in_var_ATTRIBUTE15.y);
        int _391 = int(in.in_var_ATTRIBUTE14.y) * 3;
        float4 _407 = float4(in.in_var_ATTRIBUTE15.z);
        int _410 = int(in.in_var_ATTRIBUTE14.z) * 3;
        float4 _426 = float4(in.in_var_ATTRIBUTE15.w);
        int _429 = int(in.in_var_ATTRIBUTE14.w) * 3;
        _445 = float3x4((((_359 + (_369 * BoneMatrices.read(uint(uint(_372))))) + (_388 * BoneMatrices.read(uint(uint(_391))))) + (_407 * BoneMatrices.read(uint(uint(_410))))) + (_426 * BoneMatrices.read(uint(uint(_429)))), (((_360 + (_369 * BoneMatrices.read(uint(uint(_372 + 1))))) + (_388 * BoneMatrices.read(uint(uint(_391 + 1))))) + (_407 * BoneMatrices.read(uint(uint(_410 + 1))))) + (_426 * BoneMatrices.read(uint(uint(_429 + 1)))), (((_361 + (_369 * BoneMatrices.read(uint(uint(_372 + 2))))) + (_388 * BoneMatrices.read(uint(uint(_391 + 2))))) + (_407 * BoneMatrices.read(uint(uint(_410 + 2))))) + (_426 * BoneMatrices.read(uint(uint(_429 + 2)))));
    }
    else
    {
        _445 = float3x4(_359, _360, _361);
    }
    spvUnsafeArray<FClothVertex, 5> _93;
    _93 = _94;
    float _628;
    float3x3 _629;
    if (_93[0].SimulIndices.w < 65535u)
    {
        float _457;
        float3 _460;
        float3 _462;
        float _464;
        int _466;
        _457 = _Globals.ClothBlendWeight;
        _460 = float3(0.0);
        _462 = float3(0.0);
        _464 = 0.0;
        _466 = 0;
        float _458;
        float3 _461;
        float3 _463;
        float _465;
        int _467;
        for (int _468 = 0; _468 < 5; _457 = _458, _460 = _461, _462 = _463, _464 = _465, _466 = _467, _468++)
        {
            bool _480 = _93[_468].SimulIndices.w < 65535u;
            if (_480)
            {
                int _486 = int(_93[_468].SimulIndices.x) * 3;
                uint _491 = uint(_486 + 1);
                float3 _500 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_486))).xy, ClothSimulVertsPositionsNormals.read(uint(_491)).x, 1.0)).xyz;
                int _503 = int(_93[_468].SimulIndices.y) * 3;
                uint _507 = uint(_503 + 1);
                float3 _514 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_503))).xy, ClothSimulVertsPositionsNormals.read(uint(_507)).x, 1.0)).xyz;
                int _517 = int(_93[_468].SimulIndices.z) * 3;
                uint _521 = uint(_517 + 1);
                float3 _528 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(uint(_517))).xy, ClothSimulVertsPositionsNormals.read(uint(_521)).x, 1.0)).xyz;
                float3 _538 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_491)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_486 + 2))).xy, 0.0)).xyz;
                float3 _548 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_507)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_503 + 2))).xy, 0.0)).xyz;
                float3 _558 = (_Globals.ClothLocalToWorld * float4(ClothSimulVertsPositionsNormals.read(uint(_521)).y, ClothSimulVertsPositionsNormals.read(uint(uint(_517 + 2))).xy, 0.0)).xyz;
                _461 = _460 + (((((_500 + (_538 * _93[_468].BaryCoordNormal.w)) * _93[_468].BaryCoordNormal.x) + ((_514 + (_548 * _93[_468].BaryCoordNormal.w)) * _93[_468].BaryCoordNormal.y)) + ((_528 + (_558 * _93[_468].BaryCoordNormal.w)) * _93[_468].BaryCoordNormal.z)) * _93[_468].Weight);
                _463 = _462 + (((((_500 + (_538 * _93[_468].BaryCoordTangent.w)) * _93[_468].BaryCoordTangent.x) + ((_514 + (_548 * _93[_468].BaryCoordTangent.w)) * _93[_468].BaryCoordTangent.y)) + ((_528 + (_558 * _93[_468].BaryCoordTangent.w)) * _93[_468].BaryCoordTangent.z)) * _93[_468].Weight);
                _465 = _464 + _93[_468].Weight;
                _467 = _466 + 1;
            }
            else
            {
                _461 = _460;
                _463 = _462;
                _465 = _464;
                _467 = _466;
            }
            _458 = _480 ? _Globals.ClothBlendWeight : _457;
        }
        bool _596 = (_466 > 0) && (_464 > 9.9999997473787516355514526367188e-05);
        float3x3 _620;
        if (_596)
        {
            float _600 = 1.0 / _464;
            float3x3 _615 = float3x3(Primitive.Primitive_WorldToLocal[0].xyz, Primitive.Primitive_WorldToLocal[1].xyz, Primitive.Primitive_WorldToLocal[2].xyz);
            float3x3 _617 = _90;
            _617[0] = _615 * normalize((_462 * _600) - _287);
            float3x3 _619 = _617;
            _619[2] = _615 * normalize((_460 * _600) - _287);
            _620 = _619;
        }
        else
        {
            _620 = _90;
        }
        float3x3 _627 = _620;
        _627[1] = cross(_620[2], _620[0]) * in.in_var_ATTRIBUTE2.w;
        _628 = _596 ? _457 : 0.0;
        _629 = _627;
    }
    else
    {
        _628 = 0.0;
        _629 = float3x3(float3(1.0, 0.0, 0.0), float3(0.0, 1.0, 0.0), float3(0.0, 0.0, 1.0));
    }
    float3 _635 = normalize(float4(in.in_var_ATTRIBUTE1, 0.0) * _445);
    float3 _641 = normalize(float4(in.in_var_ATTRIBUTE2.xyz, 0.0) * _445);
    float3 _646 = float3(_628);
    float3 _654 = float3(1.0 - _628);
    float4 _729;
    switch (0u)
    {
        default:
        {
            if (_94[0].SimulIndices.w < 65535u)
            {
                _729 = float4(mix((Primitive.Primitive_LocalToWorld * float4((float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _445) + in.in_var_ATTRIBUTE12, 1.0)).xyz, _287, float3(_Globals.ClothBlendWeight)) + View.View_PreViewTranslation, 1.0);
                break;
            }
            else
            {
                float3 _678 = (float4(in.in_var_ATTRIBUTE0.xyz + in.in_var_ATTRIBUTE11, 1.0) * _445) + in.in_var_ATTRIBUTE12;
                _729 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _678.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _678.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _678.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
                break;
            }
        }
    }
    float4 _731 = View.View_TranslatedWorldToClip * float4(_729.x, _729.y, _729.z, _729.w);
    float4 _732 = _91;
    _732.w = 0.0;
    float3x3 _746 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    _746[0] = Primitive.Primitive_LocalToWorld[0].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.x;
    float3x3 _749 = _746;
    _749[1] = Primitive.Primitive_LocalToWorld[1].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.y;
    float3x3 _752 = _749;
    _752[2] = Primitive.Primitive_LocalToWorld[2].xyz * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.z;
    float3x3 _753 = _752 * float3x3((_629[0] * _646) + (_635 * _654), (_629[1] * _646) + (normalize(cross(_641, _635) * in.in_var_ATTRIBUTE2.w) * _654), (_629[2] * _646) + (_641 * _654));
    float3 _754 = _753[0];
    out.out_var_TEXCOORD10_centroid = float4(_754.x, _754.y, _754.z, _732.w);
    out.out_var_TEXCOORD11_centroid = float4(_753[2], in.in_var_ATTRIBUTE2.w * Primitive.Primitive_InvNonUniformScaleAndDeterminantSign.w);
    out.out_var_TEXCOORD6 = float4(_729.x, _729.y, _729.z, _729.w);
    out.gl_Position = _731;
    return out;
}

