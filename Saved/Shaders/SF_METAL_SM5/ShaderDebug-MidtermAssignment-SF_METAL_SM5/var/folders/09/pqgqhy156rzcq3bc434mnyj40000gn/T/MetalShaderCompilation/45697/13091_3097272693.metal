

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

vertex Main_out Main_00003323_b89ca175(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _105 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _109 = _105 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _114 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _115 = _109 + _114;
    uint _116 = uint(_115);
    float4 _118 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_116));
    float _119 = _118.x;
    float _122 = float(View.View_FarShadowStaticMeshLODBias);
    float _123 = _119 + _122;
    float _126 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _127 = fast::min(_123, _126);
    float _128 = floor(_127);
    uint _129 = uint(_128);
    int _132 = int(_129);
    int _133 = _132 & 31;
    int _134 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _133;
    int _135 = _134 - 1;
    float _136 = float(_135);
    float _137 = float(_129);
    float _138 = 1.0 / _136;
    float4 _140 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_116));
    float _141 = _140.x;
    float2 _143 = in.in_var_ATTRIBUTE0.xy * _138;
    float2 _145 = _143 + in.in_var_ATTRIBUTE0.zw;
    float _148 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _149 = float2(_148);
    float2 _150 = _145 / _149;
    float _151 = _150.y;
    float _152 = _150.x;
    float _153 = 1.0 - _152;
    float _154 = 1.0 - _151;
    float4 _155 = float4(_151, _152, _153, _154);
    float4 _156 = _155 * 2.0;
    float4 _157 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_116));
    float _158 = _157.x;
    float _159 = _158 + _122;
    float _160 = fast::min(_159, _126);
    float4 _161 = _156 * _160;
    float4 _162 = float4(1.0) - _156;
    spvUnsafeArray<int2, 4> _93;
    _93[0] = int2(0, -1);
    _93[1] = int2(-1, 0);
    _93[2] = int2(1, 0);
    _93[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _94;
    for (int _168 = 0; _168 < 4; )
    {
        int2 _182 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_93[_168] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _94[_168] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_182.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_182.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_116)).x + _122, _126));
        _94[_168] = fast::min(_94[_168] + _122, _126);
        _168++;
        continue;
    }
    float4 _209 = float4(_94[0], _94[1], _94[2], _94[3]);
    float4 _210 = _162 * _209;
    float4 _211 = _161 + _210;
    float _212 = _152 + _151;
    bool _213 = _212 > 1.0;
    bool _214 = _152 < _151;
    float _215 = _211.w;
    float _216 = _211.z;
    float _217 = _214 ? _215 : _216;
    float _218 = _211.y;
    float _219 = _211.x;
    float _220 = _214 ? _218 : _219;
    float _221 = _213 ? _217 : _220;
    float _222 = floor(_221);
    float _223 = _221 - _222;
    float _224 = _222 - _137;
    float _225 = -_224;
    float _226 = pow(2.0, _225);
    float2 _227 = in.in_var_ATTRIBUTE0.xy * _226;
    float2 _228 = floor(_227);
    float _229 = -_222;
    float _230 = pow(2.0, _229);
    float _234 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _230;
    float _235 = _234 - 1.0;
    float _236 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _237 = _236 * _230;
    float _238 = fast::max(_237, 2.0);
    float _239 = _238 - 1.0;
    float2 _240 = float2(_235, _239);
    float2 _243 = _240 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _244 = _243.x;
    float2 _245 = float2(_244);
    float2 _246 = _228 / _245;
    float2 _247 = _228 * 0.5;
    float2 _248 = floor(_247);
    float _249 = _243.y;
    float2 _250 = float2(_249);
    float2 _251 = _248 / _250;
    float2 _255 = _246 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _257 = _255 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _258 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _259 = _257 + _258;
    float2 _263 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _264 = _259 + _263;
    float _267 = _222 - _141;
    float4 _269 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _264, level(_267));
    float _270 = _269.x;
    float _271 = _270 * 65280.0;
    float _272 = _269.y;
    float _273 = _272 * 255.0;
    float _274 = _271 + _273;
    float _275 = _274 - 32768.0;
    float _276 = _275 * 0.0078125;
    float2 _277 = _251 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _278 = _277 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _279 = _278 + _258;
    float2 _280 = _279 + _263;
    float _281 = _222 + 1.0;
    float _282 = _281 - _141;
    float4 _284 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _280, level(_282));
    float _285 = _284.x;
    float _286 = _285 * 65280.0;
    float _287 = _284.y;
    float _288 = _287 * 255.0;
    float _289 = _286 + _288;
    float _290 = _289 - 32768.0;
    float _291 = _290 * 0.0078125;
    float2 _295 = _246 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _297 = _295 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _299 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _300 = _297 + _299;
    float4 _304 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _300, level(_222));
    float2 _305 = _251 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _306 = _305 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _307 = _306 + _299;
    float4 _309 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _307, level(_281));
    float _310 = _304.x;
    float _311 = _310 * 65280.0;
    float _312 = _304.y;
    float _313 = _312 * 255.0;
    float _314 = _311 + _313;
    float _315 = _314 - 32768.0;
    float _316 = _315 * 0.00390625;
    float _317 = _304.z;
    float _318 = _317 * 65280.0;
    float _319 = _304.w;
    float _320 = _319 * 255.0;
    float _321 = _318 + _320;
    float _322 = _321 - 32768.0;
    float _323 = _322 * 0.00390625;
    float2 _324 = float2(_316, _323);
    float _325 = _309.x;
    float _326 = _325 * 65280.0;
    float _327 = _309.y;
    float _328 = _327 * 255.0;
    float _329 = _326 + _328;
    float _330 = _329 - 32768.0;
    float _331 = _330 * 0.00390625;
    float _332 = _309.z;
    float _333 = _332 * 65280.0;
    float _334 = _309.w;
    float _335 = _334 * 255.0;
    float _336 = _333 + _335;
    float _337 = _336 - 32768.0;
    float _338 = _337 * 0.00390625;
    float2 _339 = float2(_331, _338);
    float2 _340 = _246 + _324;
    float2 _341 = _251 + _339;
    float _342 = _340.x;
    float _343 = _340.y;
    float3 _344 = float3(_342, _343, _276);
    float _345 = _341.x;
    float _346 = _341.y;
    float3 _347 = float3(_345, _346, _291);
    float3 _348 = float3(_223);
    float3 _349 = mix(_344, _347, _348);
    float2 _351 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _352 = _351.x;
    float _353 = _351.y;
    float3 _354 = float3(_352, _353, 0.0);
    float3 _355 = _349 + _354;
    float3 _359 = _355.xxx;
    float3 _360 = Primitive.Primitive_LocalToWorld[0u].xyz * _359;
    float3 _364 = _355.yyy;
    float3 _365 = Primitive.Primitive_LocalToWorld[1u].xyz * _364;
    float3 _366 = _360 + _365;
    float3 _370 = _355.zzz;
    float3 _371 = Primitive.Primitive_LocalToWorld[2u].xyz * _370;
    float3 _372 = _366 + _371;
    float3 _376 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _377 = _372 + _376;
    float _378 = _377.x;
    float _379 = _377.y;
    float _380 = _377.z;
    float4 _381 = float4(_378, _379, _380, 1.0);
    float4 _382 = float4(_381.x, _381.y, _381.z, _381.w);
    float4 _383 = View.View_TranslatedWorldToClip * _382;
    float2 _384 = _349.xy;
    float2 _391 = ((_384 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _299;
    float2 _395 = (((_384 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _258) + _263;
    out.gl_Position = _383;
    out.out_var_TEXCOORD0 = (_384 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _351;
    out.out_var_TEXCOORD1 = float4(_391.x, _391.y, _395.x, _395.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _382;
    return out;
}

