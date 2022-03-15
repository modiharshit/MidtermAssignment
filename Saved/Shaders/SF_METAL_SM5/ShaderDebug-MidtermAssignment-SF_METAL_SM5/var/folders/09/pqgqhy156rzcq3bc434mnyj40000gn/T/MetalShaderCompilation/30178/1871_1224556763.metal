

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_GeomCache
{
    float3 GeomCache_MeshOrigin;
    float3 GeomCache_MeshExtension;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000074f_48fd40db(Main_in in [[stage_in]], constant type_View& View [[buffer(0)]], constant type_Primitive& Primitive [[buffer(1)]], constant type_GeomCache& GeomCache [[buffer(2)]])
{
    Main_out out = {};
    float3 _51 = in.in_var_ATTRIBUTE0.xyz * GeomCache.GeomCache_MeshExtension;
    float3 _54 = _51 + GeomCache.GeomCache_MeshOrigin;
    float3 _58 = _54.xxx;
    float3 _59 = Primitive.Primitive_LocalToWorld[0u].xyz * _58;
    float3 _63 = _54.yyy;
    float3 _64 = Primitive.Primitive_LocalToWorld[1u].xyz * _63;
    float3 _65 = _59 + _64;
    float3 _69 = _54.zzz;
    float3 _70 = Primitive.Primitive_LocalToWorld[2u].xyz * _69;
    float3 _71 = _65 + _70;
    float3 _75 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _76 = _71 + _75;
    float _77 = _76.x;
    float _78 = _76.y;
    float _79 = _76.z;
    float4 _80 = float4(_77, _78, _79, 1.0);
    float4 _81 = float4(_80.x, _80.y, _80.z, _80.w);
    float4 _82 = View.View_TranslatedWorldToClip * _81;
    out.gl_Position = _82;
    return out;
}

