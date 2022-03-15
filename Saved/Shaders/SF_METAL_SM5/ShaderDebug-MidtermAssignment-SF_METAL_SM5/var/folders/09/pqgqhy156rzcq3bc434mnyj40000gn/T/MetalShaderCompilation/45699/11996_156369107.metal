

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
    float4 LandscapeParameters_WeightmapUVScaleBias;
    char _m7_pad[16];
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
};

struct type_Globals
{
    uint LayerId;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float3 out_var_TEXCOORD8 [[user(locn5)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002edc_095200d3(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _115 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _119 = _115 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _124 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _125 = _119 + _124;
    uint _126 = uint(_125);
    float4 _128 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_126));
    float _129 = _128.x;
    float _132 = float(View.View_FarShadowStaticMeshLODBias);
    float _133 = _129 + _132;
    float _136 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _137 = fast::min(_133, _136);
    float _138 = floor(_137);
    uint _139 = uint(_138);
    int _142 = int(_139);
    int _143 = _142 & 31;
    int _144 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _143;
    int _145 = _144 - 1;
    float _146 = float(_145);
    float _147 = float(_139);
    float _148 = 1.0 / _146;
    float4 _150 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_126));
    float _151 = _150.x;
    float2 _153 = in.in_var_ATTRIBUTE0.xy * _148;
    float2 _155 = _153 + in.in_var_ATTRIBUTE0.zw;
    float _158 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _159 = float2(_158);
    float2 _160 = _155 / _159;
    float _161 = _160.y;
    float _162 = _160.x;
    float _163 = 1.0 - _162;
    float _164 = 1.0 - _161;
    float4 _165 = float4(_161, _162, _163, _164);
    float4 _166 = _165 * 2.0;
    float4 _167 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_126));
    float _168 = _167.x;
    float _169 = _168 + _132;
    float _170 = fast::min(_169, _136);
    float4 _171 = _166 * _170;
    float4 _172 = float4(1.0) - _166;
    spvUnsafeArray<int2, 4> _105;
    _105[0] = int2(0, -1);
    _105[1] = int2(-1, 0);
    _105[2] = int2(1, 0);
    _105[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _106;
    for (int _178 = 0; _178 < 4; )
    {
        int2 _192 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_105[_178] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _106[_178] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_192.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_192.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_126)).x + _132, _136));
        _106[_178] = fast::min(_106[_178] + _132, _136);
        _178++;
        continue;
    }
    float4 _219 = float4(_106[0], _106[1], _106[2], _106[3]);
    float4 _220 = _172 * _219;
    float4 _221 = _171 + _220;
    float _222 = _162 + _161;
    bool _223 = _222 > 1.0;
    bool _224 = _162 < _161;
    float _225 = _221.w;
    float _226 = _221.z;
    float _227 = _224 ? _225 : _226;
    float _228 = _221.y;
    float _229 = _221.x;
    float _230 = _224 ? _228 : _229;
    float _231 = _223 ? _227 : _230;
    float _232 = floor(_231);
    float _233 = _231 - _232;
    float _234 = _232 - _147;
    float _235 = -_234;
    float _236 = pow(2.0, _235);
    float2 _237 = in.in_var_ATTRIBUTE0.xy * _236;
    float2 _238 = floor(_237);
    float _239 = -_232;
    float _240 = pow(2.0, _239);
    float _244 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _240;
    float _245 = _244 - 1.0;
    float _246 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _247 = _246 * _240;
    float _248 = fast::max(_247, 2.0);
    float _249 = _248 - 1.0;
    float2 _250 = float2(_245, _249);
    float2 _253 = _250 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _254 = _253.x;
    float2 _255 = float2(_254);
    float2 _256 = _238 / _255;
    float2 _257 = _238 * 0.5;
    float2 _258 = floor(_257);
    float _259 = _253.y;
    float2 _260 = float2(_259);
    float2 _261 = _258 / _260;
    float2 _265 = _256 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _267 = _265 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _268 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _269 = _267 + _268;
    float2 _273 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _274 = _269 + _273;
    float _277 = _232 - _151;
    float4 _279 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _274, level(_277));
    float _280 = _279.x;
    float _281 = _280 * 65280.0;
    float _282 = _279.y;
    float _283 = _282 * 255.0;
    float _284 = _281 + _283;
    float _285 = _284 - 32768.0;
    float _286 = _285 * 0.0078125;
    float2 _287 = _261 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _288 = _287 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _289 = _288 + _268;
    float2 _290 = _289 + _273;
    float _291 = _232 + 1.0;
    float _292 = _291 - _151;
    float4 _294 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _290, level(_292));
    float _295 = _294.x;
    float _296 = _295 * 65280.0;
    float _297 = _294.y;
    float _298 = _297 * 255.0;
    float _299 = _296 + _298;
    float _300 = _299 - 32768.0;
    float _301 = _300 * 0.0078125;
    float _302 = _256.x;
    float _303 = _256.y;
    float3 _304 = float3(_302, _303, _286);
    float _305 = _261.x;
    float _306 = _261.y;
    float3 _307 = float3(_305, _306, _301);
    float3 _308 = float3(_233);
    float3 _309 = mix(_304, _307, _308);
    float2 _319 = (mix(float2(_279.zw), float2(_294.zw), float2(_233)) * float2(2.0)) - float2(1.0);
    float2 _328 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _329 = _328.x;
    float _330 = _328.y;
    float3 _331 = float3(_329, _330, 0.0);
    float3 _332 = _309 + _331;
    float3 _336 = _332.xxx;
    float3 _337 = Primitive.Primitive_LocalToWorld[0u].xyz * _336;
    float3 _341 = _332.yyy;
    float3 _342 = Primitive.Primitive_LocalToWorld[1u].xyz * _341;
    float3 _343 = _337 + _342;
    float3 _347 = _332.zzz;
    float3 _348 = Primitive.Primitive_LocalToWorld[2u].xyz * _347;
    float3 _349 = _343 + _348;
    float3 _353 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _354 = _349 + _353;
    float _355 = _354.x;
    float _356 = _354.y;
    float _357 = _354.z;
    float4 _358 = float4(_355, _356, _357, 1.0);
    float4 _359 = float4(_358.x, _358.y, _358.z, _358.w);
    float2 _360 = _309.xy;
    float2 _373 = ((_360 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _377 = (((_360 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _268) + _273;
    float4 _384 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _359;
    out.out_var_TEXCOORD0 = (_360 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _328;
    out.out_var_TEXCOORD1 = float4(_373.x, _373.y, _377.x, _377.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD7 = _358.xyz;
    out.out_var_TEXCOORD6 = _384;
    out.out_var_TEXCOORD8 = float3(_319, sqrt(fast::max(1.0 - dot(_319, _319), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _384;
    return out;
}

