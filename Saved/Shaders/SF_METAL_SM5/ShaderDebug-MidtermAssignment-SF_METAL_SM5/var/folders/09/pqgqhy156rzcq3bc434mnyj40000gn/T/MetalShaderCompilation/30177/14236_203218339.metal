

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

struct type_PrecomputedLightingBuffer
{
    char _m0_pad[32];
    float4 PrecomputedLightingBuffer_LightMapCoordinateScaleBias;
    float4 PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias;
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
    float4 LandscapeParameters_LandscapeLightmapScaleBias;
    float4 LandscapeParameters_SubsectionSizeVertsLayerUVPan;
    float4 LandscapeParameters_SubsectionOffsetParams;
    float4 LandscapeParameters_LightmapSubsectionOffsetParams;
};

struct Main_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000379c_0c1cdda3(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _110 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _114 = _110 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _119 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _120 = _114 + _119;
    uint _121 = uint(_120);
    float4 _123 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_121));
    float _124 = _123.x;
    float _127 = float(View.View_FarShadowStaticMeshLODBias);
    float _128 = _124 + _127;
    float _131 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _132 = fast::min(_128, _131);
    float _133 = floor(_132);
    uint _134 = uint(_133);
    int _137 = int(_134);
    int _138 = _137 & 31;
    int _139 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _138;
    int _140 = _139 - 1;
    float _141 = float(_140);
    float _142 = float(_134);
    float _143 = 1.0 / _141;
    float4 _145 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_121));
    float _146 = _145.x;
    float2 _148 = in.in_var_ATTRIBUTE0.xy * _143;
    float2 _150 = _148 + in.in_var_ATTRIBUTE0.zw;
    float _153 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _154 = float2(_153);
    float2 _155 = _150 / _154;
    float _156 = _155.y;
    float _157 = _155.x;
    float _158 = 1.0 - _157;
    float _159 = 1.0 - _156;
    float4 _160 = float4(_156, _157, _158, _159);
    float4 _161 = _160 * 2.0;
    float4 _162 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_121));
    float _163 = _162.x;
    float _164 = _163 + _127;
    float _165 = fast::min(_164, _131);
    float4 _166 = _161 * _165;
    float4 _167 = float4(1.0) - _161;
    spvUnsafeArray<int2, 4> _98;
    _98[0] = int2(0, -1);
    _98[1] = int2(-1, 0);
    _98[2] = int2(1, 0);
    _98[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _99;
    for (int _173 = 0; _173 < 4; )
    {
        int2 _187 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_98[_173] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _99[_173] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_187.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_187.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_121)).x + _127, _131));
        _99[_173] = fast::min(_99[_173] + _127, _131);
        _173++;
        continue;
    }
    float4 _214 = float4(_99[0], _99[1], _99[2], _99[3]);
    float4 _215 = _167 * _214;
    float4 _216 = _166 + _215;
    float _217 = _157 + _156;
    bool _218 = _217 > 1.0;
    bool _219 = _157 < _156;
    float _220 = _216.w;
    float _221 = _216.z;
    float _222 = _219 ? _220 : _221;
    float _223 = _216.y;
    float _224 = _216.x;
    float _225 = _219 ? _223 : _224;
    float _226 = _218 ? _222 : _225;
    float _227 = floor(_226);
    float _228 = _226 - _227;
    float _229 = _227 - _142;
    float _230 = -_229;
    float _231 = pow(2.0, _230);
    float2 _232 = in.in_var_ATTRIBUTE0.xy * _231;
    float2 _233 = floor(_232);
    float _234 = -_227;
    float _235 = pow(2.0, _234);
    float _239 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _235;
    float _240 = _239 - 1.0;
    float _241 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _242 = _241 * _235;
    float _243 = fast::max(_242, 2.0);
    float _244 = _243 - 1.0;
    float2 _245 = float2(_240, _244);
    float2 _248 = _245 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _249 = _248.x;
    float2 _250 = float2(_249);
    float2 _251 = _233 / _250;
    float2 _252 = _233 * 0.5;
    float2 _253 = floor(_252);
    float _254 = _248.y;
    float2 _255 = float2(_254);
    float2 _256 = _253 / _255;
    float2 _260 = _251 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _262 = _260 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _263 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _264 = _262 + _263;
    float2 _268 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _269 = _264 + _268;
    float _272 = _227 - _146;
    float4 _274 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _269, level(_272));
    float _275 = _274.x;
    float _276 = _275 * 65280.0;
    float _277 = _274.y;
    float _278 = _277 * 255.0;
    float _279 = _276 + _278;
    float _280 = _279 - 32768.0;
    float _281 = _280 * 0.0078125;
    float2 _282 = _256 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _283 = _282 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _284 = _283 + _263;
    float2 _285 = _284 + _268;
    float _286 = _227 + 1.0;
    float _287 = _286 - _146;
    float4 _289 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _285, level(_287));
    float _290 = _289.x;
    float _291 = _290 * 65280.0;
    float _292 = _289.y;
    float _293 = _292 * 255.0;
    float _294 = _291 + _293;
    float _295 = _294 - 32768.0;
    float _296 = _295 * 0.0078125;
    float2 _300 = _251 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _302 = _300 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _304 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _305 = _302 + _304;
    float4 _309 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _305, level(_227));
    float2 _310 = _256 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _311 = _310 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _312 = _311 + _304;
    float4 _314 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _312, level(_286));
    float _315 = _309.x;
    float _316 = _315 * 65280.0;
    float _317 = _309.y;
    float _318 = _317 * 255.0;
    float _319 = _316 + _318;
    float _320 = _319 - 32768.0;
    float _321 = _320 * 0.00390625;
    float _322 = _309.z;
    float _323 = _322 * 65280.0;
    float _324 = _309.w;
    float _325 = _324 * 255.0;
    float _326 = _323 + _325;
    float _327 = _326 - 32768.0;
    float _328 = _327 * 0.00390625;
    float2 _329 = float2(_321, _328);
    float _330 = _314.x;
    float _331 = _330 * 65280.0;
    float _332 = _314.y;
    float _333 = _332 * 255.0;
    float _334 = _331 + _333;
    float _335 = _334 - 32768.0;
    float _336 = _335 * 0.00390625;
    float _337 = _314.z;
    float _338 = _337 * 65280.0;
    float _339 = _314.w;
    float _340 = _339 * 255.0;
    float _341 = _338 + _340;
    float _342 = _341 - 32768.0;
    float _343 = _342 * 0.00390625;
    float2 _344 = float2(_336, _343);
    float2 _345 = _251 + _329;
    float2 _346 = _256 + _344;
    float _347 = _345.x;
    float _348 = _345.y;
    float3 _349 = float3(_347, _348, _281);
    float _350 = _346.x;
    float _351 = _346.y;
    float3 _352 = float3(_350, _351, _296);
    float3 _353 = float3(_228);
    float3 _354 = mix(_349, _352, _353);
    float2 _356 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _357 = _356.x;
    float _358 = _356.y;
    float3 _359 = float3(_357, _358, 0.0);
    float3 _360 = _354 + _359;
    float3 _364 = _360.xxx;
    float3 _365 = Primitive.Primitive_LocalToWorld[0u].xyz * _364;
    float3 _369 = _360.yyy;
    float3 _370 = Primitive.Primitive_LocalToWorld[1u].xyz * _369;
    float3 _371 = _365 + _370;
    float3 _375 = _360.zzz;
    float3 _376 = Primitive.Primitive_LocalToWorld[2u].xyz * _375;
    float3 _377 = _371 + _376;
    float3 _381 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _382 = _377 + _381;
    float _383 = _382.x;
    float _384 = _382.y;
    float _385 = _382.z;
    float4 _386 = float4(_383, _384, _385, 1.0);
    float2 _387 = _354.xy;
    float4 _392 = float4(_386.x, _386.y, _386.z, _386.w);
    float4 _393 = View.View_TranslatedWorldToClip * _392;
    float2 _396 = ((_387 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _304;
    float2 _400 = (((_387 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _263) + _268;
    float2 _411 = ((_387 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy);
    float2 _418 = (_411 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _424 = (_411 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_387 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _356;
    out.out_var_TEXCOORD1 = float4(_396.x, _396.y, _400.x, _400.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_418.x, _418.y, _424.x, _424.y);
    out.gl_Position = _393;
    return out;
}

