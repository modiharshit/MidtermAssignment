

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
    char _m5_pad[1452];
    int View_FarShadowStaticMeshLODBias;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_LandscapeContinuousLODParameters
{
    int2 LandscapeContinuousLODParameters_Min;
    int2 LandscapeContinuousLODParameters_Size;
};

struct type_LandscapeParameters
{
    int LandscapeParameters_ComponentBaseX;
    int LandscapeParameters_ComponentBaseY;
    int LandscapeParameters_SubsectionSizeVerts;
    int LandscapeParameters_NumSubsections;
    int LandscapeParameters_LastLOD;
    float4 LandscapeParameters_HeightmapUVScaleBias;
    float4 LandscapeParameters_WeightmapUVScaleBias;
    char _m7_pad[16];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float2 out_var_TEXCOORD0 [[user(locn2)]];
    float4 out_var_TEXCOORD1 [[user(locn3)]];
    float4 out_var_TEXCOORD2 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002446_7192dd77(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    uint _119 = uint(((LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x));
    float _125 = float(View.View_FarShadowStaticMeshLODBias);
    float _129 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    uint _132 = uint(floor(fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_119)).x + _125, _129)));
    float4 _143 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_119));
    float _144 = _143.x;
    float2 _153 = ((in.in_var_ATTRIBUTE0.xy * (1.0 / float((LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> (int(_132) & 31)) - 1))) + in.in_var_ATTRIBUTE0.zw) / float2(float(LandscapeParameters.LandscapeParameters_NumSubsections));
    float _154 = _153.y;
    float _155 = _153.x;
    float4 _159 = float4(_154, _155, 1.0 - _155, 1.0 - _154) * 2.0;
    spvUnsafeArray<int2, 4> _92;
    _92[0] = int2(0, -1);
    _92[1] = int2(-1, 0);
    _92[2] = int2(1, 0);
    _92[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _93;
    for (int _171 = 0; _171 < 4; )
    {
        int2 _185 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_92[_171] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _93[_171] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_185.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_185.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_119)).x + _125, _129));
        _93[_171] = fast::min(_93[_171] + _125, _129);
        _171++;
        continue;
    }
    float4 _214 = (_159 * fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_119)).x + _125, _129)) + ((float4(1.0) - _159) * float4(_93[0], _93[1], _93[2], _93[3]));
    bool _217 = _155 < _154;
    float _224 = ((_155 + _154) > 1.0) ? (_217 ? _214.w : _214.z) : (_217 ? _214.y : _214.x);
    float _225 = floor(_224);
    float2 _231 = floor(in.in_var_ATTRIBUTE0.xy * pow(2.0, -(_225 - float(_132))));
    float _233 = pow(2.0, -_225);
    float2 _246 = float2((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _233) - 1.0, fast::max((LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5) * _233, 2.0) - 1.0) * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float2 _249 = _231 / float2(_246.x);
    float2 _254 = floor(_231 * 0.5) / float2(_246.y);
    float2 _261 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _266 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float4 _272 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_249 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _261) + _266), level(_225 - _144));
    float4 _287 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, ((((_254 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _261) + _266), level((_225 + 1.0) - _144));
    float3 _302 = mix(float3(_249, (((_272.x * 65280.0) + (_272.y * 255.0)) - 32768.0) * 0.0078125), float3(_254, (((_287.x * 65280.0) + (_287.y * 255.0)) - 32768.0) * 0.0078125), float3(_224 - _225));
    float2 _304 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float3 _308 = _302 + float3(_304, 0.0);
    float3 _325 = ((Primitive.Primitive_LocalToWorld[0u].xyz * _308.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _308.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _308.zzz);
    float2 _334 = _302.xy;
    float2 _347 = ((_334 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _351 = (((_334 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _261) + _266;
    float4 _361 = View.View_TranslatedWorldToClip * float4(_325 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0);
    float4 _370 = _361;
    _370.z = _361.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _361.w) : 0.0);
    out.gl_Position = _370;
    out.out_var_TEXCOORD6 = _361;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * float4(_325 + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PrevPreViewTranslation), 1.0);
    out.out_var_TEXCOORD0 = (_334 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _304;
    out.out_var_TEXCOORD1 = float4(_347.x, _347.y, _351.x, _351.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    return out;
}

