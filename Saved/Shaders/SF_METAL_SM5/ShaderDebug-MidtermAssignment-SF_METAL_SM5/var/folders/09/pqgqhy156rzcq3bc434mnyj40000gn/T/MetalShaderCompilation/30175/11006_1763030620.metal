

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
    char _m1_pad[2480];
    int View_FarShadowStaticMeshLODBias;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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
    char _m6_pad[32];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002afe_6915b65c(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _108 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _112 = _108 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _117 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _118 = _112 + _117;
    uint _119 = uint(_118);
    float4 _121 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_119));
    float _122 = _121.x;
    float _125 = float(View.View_FarShadowStaticMeshLODBias);
    float _126 = _122 + _125;
    float _129 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _130 = fast::min(_126, _129);
    float _131 = floor(_130);
    uint _132 = uint(_131);
    int _135 = int(_132);
    int _136 = _135 & 31;
    int _137 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _136;
    int _138 = _137 - 1;
    float _139 = float(_138);
    float _140 = float(_132);
    float _141 = 1.0 / _139;
    float4 _143 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_119));
    float _144 = _143.x;
    float2 _146 = in.in_var_ATTRIBUTE0.xy * _141;
    float2 _148 = _146 + in.in_var_ATTRIBUTE0.zw;
    float _151 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _152 = float2(_151);
    float2 _153 = _148 / _152;
    float _154 = _153.y;
    float _155 = _153.x;
    float _156 = 1.0 - _155;
    float _157 = 1.0 - _154;
    float4 _158 = float4(_154, _155, _156, _157);
    float4 _159 = _158 * 2.0;
    float4 _160 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_119));
    float _161 = _160.x;
    float _162 = _161 + _125;
    float _163 = fast::min(_162, _129);
    float4 _164 = _159 * _163;
    float4 _165 = float4(1.0) - _159;
    spvUnsafeArray<int2, 4> _98;
    _98[0] = int2(0, -1);
    _98[1] = int2(-1, 0);
    _98[2] = int2(1, 0);
    _98[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _99;
    for (int _171 = 0; _171 < 4; )
    {
        int2 _185 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_98[_171] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _99[_171] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_185.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_185.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_119)).x + _125, _129));
        _99[_171] = fast::min(_99[_171] + _125, _129);
        _171++;
        continue;
    }
    float4 _212 = float4(_99[0], _99[1], _99[2], _99[3]);
    float4 _213 = _165 * _212;
    float4 _214 = _164 + _213;
    float _215 = _155 + _154;
    bool _216 = _215 > 1.0;
    bool _217 = _155 < _154;
    float _218 = _214.w;
    float _219 = _214.z;
    float _220 = _217 ? _218 : _219;
    float _221 = _214.y;
    float _222 = _214.x;
    float _223 = _217 ? _221 : _222;
    float _224 = _216 ? _220 : _223;
    float _225 = floor(_224);
    float _226 = _224 - _225;
    float _227 = _225 - _140;
    float _228 = -_227;
    float _229 = pow(2.0, _228);
    float2 _230 = in.in_var_ATTRIBUTE0.xy * _229;
    float2 _231 = floor(_230);
    float _232 = -_225;
    float _233 = pow(2.0, _232);
    float _236 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _233;
    float _237 = _236 - 1.0;
    float _238 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _239 = _238 * _233;
    float _240 = fast::max(_239, 2.0);
    float _241 = _240 - 1.0;
    float2 _242 = float2(_237, _241);
    float2 _245 = _242 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _246 = _245.x;
    float2 _247 = float2(_246);
    float2 _248 = _231 / _247;
    float2 _249 = _231 * 0.5;
    float2 _250 = floor(_249);
    float _251 = _245.y;
    float2 _252 = float2(_251);
    float2 _253 = _250 / _252;
    float2 _257 = _248 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _259 = _257 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _260 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _261 = _259 + _260;
    float2 _265 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _266 = _261 + _265;
    float _269 = _225 - _144;
    float4 _271 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _266, level(_269));
    float _272 = _271.x;
    float _273 = _272 * 65280.0;
    float _274 = _271.y;
    float _275 = _274 * 255.0;
    float _276 = _273 + _275;
    float _277 = _276 - 32768.0;
    float _278 = _277 * 0.0078125;
    float2 _279 = _253 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _280 = _279 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _281 = _280 + _260;
    float2 _282 = _281 + _265;
    float _283 = _225 + 1.0;
    float _284 = _283 - _144;
    float4 _286 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _282, level(_284));
    float _287 = _286.x;
    float _288 = _287 * 65280.0;
    float _289 = _286.y;
    float _290 = _289 * 255.0;
    float _291 = _288 + _290;
    float _292 = _291 - 32768.0;
    float _293 = _292 * 0.0078125;
    float _294 = _248.x;
    float _295 = _248.y;
    float3 _296 = float3(_294, _295, _278);
    float _297 = _253.x;
    float _298 = _253.y;
    float3 _299 = float3(_297, _298, _293);
    float3 _300 = float3(_226);
    float3 _301 = mix(_296, _299, _300);
    float2 _311 = (mix(float2(_271.zw), float2(_286.zw), float2(_226)) * float2(2.0)) - float2(1.0);
    float2 _320 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _321 = _320.x;
    float _322 = _320.y;
    float3 _323 = float3(_321, _322, 0.0);
    float3 _324 = _301 + _323;
    float3 _328 = _324.xxx;
    float3 _329 = Primitive.Primitive_LocalToWorld[0u].xyz * _328;
    float3 _333 = _324.yyy;
    float3 _334 = Primitive.Primitive_LocalToWorld[1u].xyz * _333;
    float3 _335 = _329 + _334;
    float3 _339 = _324.zzz;
    float3 _340 = Primitive.Primitive_LocalToWorld[2u].xyz * _339;
    float3 _341 = _335 + _340;
    float3 _345 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _346 = _341 + _345;
    float _347 = _346.x;
    float _348 = _346.y;
    float _349 = _346.z;
    float4 _350 = float4(_347, _348, _349, 1.0);
    float4 _351 = float4(_350.x, _350.y, _350.z, _350.w);
    float4 _356 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _351;
    out.out_var_TEXCOORD6 = _351;
    out.out_var_TEXCOORD8 = float3(_311, sqrt(fast::max(1.0 - dot(_311, _311), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _356;
    return out;
}

