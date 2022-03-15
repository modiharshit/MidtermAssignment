

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
    char _m2_pad[2480];
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

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000331a_dcfb13e9(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _103 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _107 = _103 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _112 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _113 = _107 + _112;
    uint _114 = uint(_113);
    float4 _116 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_114));
    float _117 = _116.x;
    float _120 = float(View.View_FarShadowStaticMeshLODBias);
    float _121 = _117 + _120;
    float _124 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _125 = fast::min(_121, _124);
    float _126 = floor(_125);
    uint _127 = uint(_126);
    int _130 = int(_127);
    int _131 = _130 & 31;
    int _132 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _131;
    int _133 = _132 - 1;
    float _134 = float(_133);
    float _135 = float(_127);
    float _136 = 1.0 / _134;
    float4 _138 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_114));
    float _139 = _138.x;
    float2 _141 = in.in_var_ATTRIBUTE0.xy * _136;
    float2 _143 = _141 + in.in_var_ATTRIBUTE0.zw;
    float _146 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _147 = float2(_146);
    float2 _148 = _143 / _147;
    float _149 = _148.y;
    float _150 = _148.x;
    float _151 = 1.0 - _150;
    float _152 = 1.0 - _149;
    float4 _153 = float4(_149, _150, _151, _152);
    float4 _154 = _153 * 2.0;
    float4 _155 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_114));
    float _156 = _155.x;
    float _157 = _156 + _120;
    float _158 = fast::min(_157, _124);
    float4 _159 = _154 * _158;
    float4 _160 = float4(1.0) - _154;
    spvUnsafeArray<int2, 4> _93;
    _93[0] = int2(0, -1);
    _93[1] = int2(-1, 0);
    _93[2] = int2(1, 0);
    _93[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _94;
    for (int _166 = 0; _166 < 4; )
    {
        int2 _180 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_93[_166] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _94[_166] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_180.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_180.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_114)).x + _120, _124));
        _94[_166] = fast::min(_94[_166] + _120, _124);
        _166++;
        continue;
    }
    float4 _207 = float4(_94[0], _94[1], _94[2], _94[3]);
    float4 _208 = _160 * _207;
    float4 _209 = _159 + _208;
    float _210 = _150 + _149;
    bool _211 = _210 > 1.0;
    bool _212 = _150 < _149;
    float _213 = _209.w;
    float _214 = _209.z;
    float _215 = _212 ? _213 : _214;
    float _216 = _209.y;
    float _217 = _209.x;
    float _218 = _212 ? _216 : _217;
    float _219 = _211 ? _215 : _218;
    float _220 = floor(_219);
    float _221 = _219 - _220;
    float _222 = _220 - _135;
    float _223 = -_222;
    float _224 = pow(2.0, _223);
    float2 _225 = in.in_var_ATTRIBUTE0.xy * _224;
    float2 _226 = floor(_225);
    float _227 = -_220;
    float _228 = pow(2.0, _227);
    float _232 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _228;
    float _233 = _232 - 1.0;
    float _234 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _235 = _234 * _228;
    float _236 = fast::max(_235, 2.0);
    float _237 = _236 - 1.0;
    float2 _238 = float2(_233, _237);
    float2 _241 = _238 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _242 = _241.x;
    float2 _243 = float2(_242);
    float2 _244 = _226 / _243;
    float2 _245 = _226 * 0.5;
    float2 _246 = floor(_245);
    float _247 = _241.y;
    float2 _248 = float2(_247);
    float2 _249 = _246 / _248;
    float2 _253 = _244 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _255 = _253 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _256 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _257 = _255 + _256;
    float2 _261 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _262 = _257 + _261;
    float _265 = _220 - _139;
    float4 _267 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _262, level(_265));
    float _268 = _267.x;
    float _269 = _268 * 65280.0;
    float _270 = _267.y;
    float _271 = _270 * 255.0;
    float _272 = _269 + _271;
    float _273 = _272 - 32768.0;
    float _274 = _273 * 0.0078125;
    float2 _275 = _249 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _276 = _275 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _277 = _276 + _256;
    float2 _278 = _277 + _261;
    float _279 = _220 + 1.0;
    float _280 = _279 - _139;
    float4 _282 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _278, level(_280));
    float _283 = _282.x;
    float _284 = _283 * 65280.0;
    float _285 = _282.y;
    float _286 = _285 * 255.0;
    float _287 = _284 + _286;
    float _288 = _287 - 32768.0;
    float _289 = _288 * 0.0078125;
    float2 _293 = _244 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _295 = _293 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _297 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _298 = _295 + _297;
    float4 _302 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _298, level(_220));
    float2 _303 = _249 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _304 = _303 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _305 = _304 + _297;
    float4 _307 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _305, level(_279));
    float _308 = _302.x;
    float _309 = _308 * 65280.0;
    float _310 = _302.y;
    float _311 = _310 * 255.0;
    float _312 = _309 + _311;
    float _313 = _312 - 32768.0;
    float _314 = _313 * 0.00390625;
    float _315 = _302.z;
    float _316 = _315 * 65280.0;
    float _317 = _302.w;
    float _318 = _317 * 255.0;
    float _319 = _316 + _318;
    float _320 = _319 - 32768.0;
    float _321 = _320 * 0.00390625;
    float2 _322 = float2(_314, _321);
    float _323 = _307.x;
    float _324 = _323 * 65280.0;
    float _325 = _307.y;
    float _326 = _325 * 255.0;
    float _327 = _324 + _326;
    float _328 = _327 - 32768.0;
    float _329 = _328 * 0.00390625;
    float _330 = _307.z;
    float _331 = _330 * 65280.0;
    float _332 = _307.w;
    float _333 = _332 * 255.0;
    float _334 = _331 + _333;
    float _335 = _334 - 32768.0;
    float _336 = _335 * 0.00390625;
    float2 _337 = float2(_329, _336);
    float2 _338 = _244 + _322;
    float2 _339 = _249 + _337;
    float _340 = _338.x;
    float _341 = _338.y;
    float3 _342 = float3(_340, _341, _274);
    float _343 = _339.x;
    float _344 = _339.y;
    float3 _345 = float3(_343, _344, _289);
    float3 _346 = float3(_221);
    float3 _347 = mix(_342, _345, _346);
    float2 _349 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _350 = _349.x;
    float _351 = _349.y;
    float3 _352 = float3(_350, _351, 0.0);
    float3 _353 = _347 + _352;
    float3 _357 = _353.xxx;
    float3 _358 = Primitive.Primitive_LocalToWorld[0u].xyz * _357;
    float3 _362 = _353.yyy;
    float3 _363 = Primitive.Primitive_LocalToWorld[1u].xyz * _362;
    float3 _364 = _358 + _363;
    float3 _368 = _353.zzz;
    float3 _369 = Primitive.Primitive_LocalToWorld[2u].xyz * _368;
    float3 _370 = _364 + _369;
    float3 _374 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _375 = _370 + _374;
    float _376 = _375.x;
    float _377 = _375.y;
    float _378 = _375.z;
    float4 _379 = float4(_376, _377, _378, 1.0);
    float4 _380 = float4(_379.x, _379.y, _379.z, _379.w);
    float4 _383 = View.View_TranslatedWorldToClip * _380;
    float2 _384 = _347.xy;
    float2 _391 = ((_384 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _297;
    float2 _395 = (((_384 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _256) + _261;
    out.out_var_TEXCOORD0 = (_384 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _349;
    out.out_var_TEXCOORD1 = float4(_391.x, _391.y, _395.x, _395.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _380;
    out.gl_Position = _383;
    return out;
}

