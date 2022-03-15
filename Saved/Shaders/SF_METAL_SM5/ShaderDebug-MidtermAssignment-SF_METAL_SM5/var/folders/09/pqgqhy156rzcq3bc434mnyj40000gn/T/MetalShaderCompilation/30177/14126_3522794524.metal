

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

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_0000372e_d1f9941c(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    MainVertexShader_out out = {};
    int _112 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _116 = _112 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _121 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _122 = _116 + _121;
    uint _123 = uint(_122);
    float4 _125 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_123));
    float _126 = _125.x;
    float _129 = float(View.View_FarShadowStaticMeshLODBias);
    float _130 = _126 + _129;
    float _133 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _134 = fast::min(_130, _133);
    float _135 = floor(_134);
    uint _136 = uint(_135);
    int _139 = int(_136);
    int _140 = _139 & 31;
    int _141 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _140;
    int _142 = _141 - 1;
    float _143 = float(_142);
    float _144 = float(_136);
    float _145 = 1.0 / _143;
    float4 _147 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_123));
    float _148 = _147.x;
    float2 _150 = in.in_var_ATTRIBUTE0.xy * _145;
    float2 _152 = _150 + in.in_var_ATTRIBUTE0.zw;
    float _155 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _156 = float2(_155);
    float2 _157 = _152 / _156;
    float _158 = _157.y;
    float _159 = _157.x;
    float _160 = 1.0 - _159;
    float _161 = 1.0 - _158;
    float4 _162 = float4(_158, _159, _160, _161);
    float4 _163 = _162 * 2.0;
    float4 _164 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_123));
    float _165 = _164.x;
    float _166 = _165 + _129;
    float _167 = fast::min(_166, _133);
    float4 _168 = _163 * _167;
    float4 _169 = float4(1.0) - _163;
    spvUnsafeArray<int2, 4> _100;
    _100[0] = int2(0, -1);
    _100[1] = int2(-1, 0);
    _100[2] = int2(1, 0);
    _100[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _101;
    for (int _175 = 0; _175 < 4; )
    {
        int2 _189 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_100[_175] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _101[_175] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_189.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_189.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_123)).x + _129, _133));
        _101[_175] = fast::min(_101[_175] + _129, _133);
        _175++;
        continue;
    }
    float4 _216 = float4(_101[0], _101[1], _101[2], _101[3]);
    float4 _217 = _169 * _216;
    float4 _218 = _168 + _217;
    float _219 = _159 + _158;
    bool _220 = _219 > 1.0;
    bool _221 = _159 < _158;
    float _222 = _218.w;
    float _223 = _218.z;
    float _224 = _221 ? _222 : _223;
    float _225 = _218.y;
    float _226 = _218.x;
    float _227 = _221 ? _225 : _226;
    float _228 = _220 ? _224 : _227;
    float _229 = floor(_228);
    float _230 = _228 - _229;
    float _231 = _229 - _144;
    float _232 = -_231;
    float _233 = pow(2.0, _232);
    float2 _234 = in.in_var_ATTRIBUTE0.xy * _233;
    float2 _235 = floor(_234);
    float _236 = -_229;
    float _237 = pow(2.0, _236);
    float _241 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _237;
    float _242 = _241 - 1.0;
    float _243 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _244 = _243 * _237;
    float _245 = fast::max(_244, 2.0);
    float _246 = _245 - 1.0;
    float2 _247 = float2(_242, _246);
    float2 _250 = _247 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _251 = _250.x;
    float2 _252 = float2(_251);
    float2 _253 = _235 / _252;
    float2 _254 = _235 * 0.5;
    float2 _255 = floor(_254);
    float _256 = _250.y;
    float2 _257 = float2(_256);
    float2 _258 = _255 / _257;
    float2 _262 = _253 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _264 = _262 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _265 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _266 = _264 + _265;
    float2 _270 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _271 = _266 + _270;
    float _274 = _229 - _148;
    float4 _276 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _271, level(_274));
    float _277 = _276.x;
    float _278 = _277 * 65280.0;
    float _279 = _276.y;
    float _280 = _279 * 255.0;
    float _281 = _278 + _280;
    float _282 = _281 - 32768.0;
    float _283 = _282 * 0.0078125;
    float2 _284 = _258 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _285 = _284 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _286 = _285 + _265;
    float2 _287 = _286 + _270;
    float _288 = _229 + 1.0;
    float _289 = _288 - _148;
    float4 _291 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _287, level(_289));
    float _292 = _291.x;
    float _293 = _292 * 65280.0;
    float _294 = _291.y;
    float _295 = _294 * 255.0;
    float _296 = _293 + _295;
    float _297 = _296 - 32768.0;
    float _298 = _297 * 0.0078125;
    float2 _302 = _253 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _304 = _302 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _306 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _307 = _304 + _306;
    float4 _311 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _307, level(_229));
    float2 _312 = _258 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _313 = _312 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _314 = _313 + _306;
    float4 _316 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _314, level(_288));
    float _317 = _311.x;
    float _318 = _317 * 65280.0;
    float _319 = _311.y;
    float _320 = _319 * 255.0;
    float _321 = _318 + _320;
    float _322 = _321 - 32768.0;
    float _323 = _322 * 0.00390625;
    float _324 = _311.z;
    float _325 = _324 * 65280.0;
    float _326 = _311.w;
    float _327 = _326 * 255.0;
    float _328 = _325 + _327;
    float _329 = _328 - 32768.0;
    float _330 = _329 * 0.00390625;
    float2 _331 = float2(_323, _330);
    float _332 = _316.x;
    float _333 = _332 * 65280.0;
    float _334 = _316.y;
    float _335 = _334 * 255.0;
    float _336 = _333 + _335;
    float _337 = _336 - 32768.0;
    float _338 = _337 * 0.00390625;
    float _339 = _316.z;
    float _340 = _339 * 65280.0;
    float _341 = _316.w;
    float _342 = _341 * 255.0;
    float _343 = _340 + _342;
    float _344 = _343 - 32768.0;
    float _345 = _344 * 0.00390625;
    float2 _346 = float2(_338, _345);
    float2 _347 = _253 + _331;
    float2 _348 = _258 + _346;
    float _349 = _347.x;
    float _350 = _347.y;
    float3 _351 = float3(_349, _350, _283);
    float _352 = _348.x;
    float _353 = _348.y;
    float3 _354 = float3(_352, _353, _298);
    float3 _355 = float3(_230);
    float3 _356 = mix(_351, _354, _355);
    float2 _358 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _359 = _358.x;
    float _360 = _358.y;
    float3 _361 = float3(_359, _360, 0.0);
    float3 _362 = _356 + _361;
    float3 _366 = _362.xxx;
    float3 _367 = Primitive.Primitive_LocalToWorld[0u].xyz * _366;
    float3 _371 = _362.yyy;
    float3 _372 = Primitive.Primitive_LocalToWorld[1u].xyz * _371;
    float3 _373 = _367 + _372;
    float3 _377 = _362.zzz;
    float3 _378 = Primitive.Primitive_LocalToWorld[2u].xyz * _377;
    float3 _379 = _373 + _378;
    float3 _383 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _384 = _379 + _383;
    float _385 = _384.x;
    float _386 = _384.y;
    float _387 = _384.z;
    float4 _388 = float4(_385, _386, _387, 1.0);
    float2 _389 = _356.xy;
    float4 _394 = float4(_388.x, _388.y, _388.z, _388.w);
    float4 _395 = View.View_TranslatedWorldToClip * _394;
    float2 _398 = ((_389 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _306;
    float2 _402 = (((_389 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _265) + _270;
    float2 _420 = ((((_389 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_389 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _358;
    out.out_var_TEXCOORD1 = float4(_398.x, _398.y, _402.x, _402.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_420.x, _420.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _394;
    out.gl_Position = _395;
    return out;
}

