

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

vertex Main_out Main_0000366e_7e48b46d(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _118 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _122 = _118 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _127 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _128 = _122 + _127;
    uint _129 = uint(_128);
    float4 _131 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_129));
    float _132 = _131.x;
    float _135 = float(View.View_FarShadowStaticMeshLODBias);
    float _136 = _132 + _135;
    float _139 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _140 = fast::min(_136, _139);
    float _141 = floor(_140);
    uint _142 = uint(_141);
    int _145 = int(_142);
    int _146 = _145 & 31;
    int _147 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _146;
    int _148 = _147 - 1;
    float _149 = float(_148);
    float _150 = float(_142);
    float _151 = 1.0 / _149;
    float4 _153 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_129));
    float _154 = _153.x;
    float2 _156 = in.in_var_ATTRIBUTE0.xy * _151;
    float2 _158 = _156 + in.in_var_ATTRIBUTE0.zw;
    float _161 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _162 = float2(_161);
    float2 _163 = _158 / _162;
    float _164 = _163.y;
    float _165 = _163.x;
    float _166 = 1.0 - _165;
    float _167 = 1.0 - _164;
    float4 _168 = float4(_164, _165, _166, _167);
    float4 _169 = _168 * 2.0;
    float4 _170 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_129));
    float _171 = _170.x;
    float _172 = _171 + _135;
    float _173 = fast::min(_172, _139);
    float4 _174 = _169 * _173;
    float4 _175 = float4(1.0) - _169;
    spvUnsafeArray<int2, 4> _108;
    _108[0] = int2(0, -1);
    _108[1] = int2(-1, 0);
    _108[2] = int2(1, 0);
    _108[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _109;
    for (int _181 = 0; _181 < 4; )
    {
        int2 _195 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_108[_181] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _109[_181] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_195.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_195.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_129)).x + _135, _139));
        _109[_181] = fast::min(_109[_181] + _135, _139);
        _181++;
        continue;
    }
    float4 _222 = float4(_109[0], _109[1], _109[2], _109[3]);
    float4 _223 = _175 * _222;
    float4 _224 = _174 + _223;
    float _225 = _165 + _164;
    bool _226 = _225 > 1.0;
    bool _227 = _165 < _164;
    float _228 = _224.w;
    float _229 = _224.z;
    float _230 = _227 ? _228 : _229;
    float _231 = _224.y;
    float _232 = _224.x;
    float _233 = _227 ? _231 : _232;
    float _234 = _226 ? _230 : _233;
    float _235 = floor(_234);
    float _236 = _234 - _235;
    float _237 = _235 - _150;
    float _238 = -_237;
    float _239 = pow(2.0, _238);
    float2 _240 = in.in_var_ATTRIBUTE0.xy * _239;
    float2 _241 = floor(_240);
    float _242 = -_235;
    float _243 = pow(2.0, _242);
    float _247 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _243;
    float _248 = _247 - 1.0;
    float _249 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _250 = _249 * _243;
    float _251 = fast::max(_250, 2.0);
    float _252 = _251 - 1.0;
    float2 _253 = float2(_248, _252);
    float2 _256 = _253 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _257 = _256.x;
    float2 _258 = float2(_257);
    float2 _259 = _241 / _258;
    float2 _260 = _241 * 0.5;
    float2 _261 = floor(_260);
    float _262 = _256.y;
    float2 _263 = float2(_262);
    float2 _264 = _261 / _263;
    float2 _268 = _259 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _270 = _268 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _271 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _272 = _270 + _271;
    float2 _276 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _277 = _272 + _276;
    float _280 = _235 - _154;
    float4 _282 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _277, level(_280));
    float _283 = _282.x;
    float _284 = _283 * 65280.0;
    float _285 = _282.y;
    float _286 = _285 * 255.0;
    float _287 = _284 + _286;
    float _288 = _287 - 32768.0;
    float _289 = _288 * 0.0078125;
    float2 _290 = _264 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _291 = _290 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _292 = _291 + _271;
    float2 _293 = _292 + _276;
    float _294 = _235 + 1.0;
    float _295 = _294 - _154;
    float4 _297 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _293, level(_295));
    float _298 = _297.x;
    float _299 = _298 * 65280.0;
    float _300 = _297.y;
    float _301 = _300 * 255.0;
    float _302 = _299 + _301;
    float _303 = _302 - 32768.0;
    float _304 = _303 * 0.0078125;
    float2 _308 = _259 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _310 = _308 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _312 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _313 = _310 + _312;
    float4 _317 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _313, level(_235));
    float2 _318 = _264 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _319 = _318 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _320 = _319 + _312;
    float4 _322 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _320, level(_294));
    float _323 = _317.x;
    float _324 = _323 * 65280.0;
    float _325 = _317.y;
    float _326 = _325 * 255.0;
    float _327 = _324 + _326;
    float _328 = _327 - 32768.0;
    float _329 = _328 * 0.00390625;
    float _330 = _317.z;
    float _331 = _330 * 65280.0;
    float _332 = _317.w;
    float _333 = _332 * 255.0;
    float _334 = _331 + _333;
    float _335 = _334 - 32768.0;
    float _336 = _335 * 0.00390625;
    float2 _337 = float2(_329, _336);
    float _338 = _322.x;
    float _339 = _338 * 65280.0;
    float _340 = _322.y;
    float _341 = _340 * 255.0;
    float _342 = _339 + _341;
    float _343 = _342 - 32768.0;
    float _344 = _343 * 0.00390625;
    float _345 = _322.z;
    float _346 = _345 * 65280.0;
    float _347 = _322.w;
    float _348 = _347 * 255.0;
    float _349 = _346 + _348;
    float _350 = _349 - 32768.0;
    float _351 = _350 * 0.00390625;
    float2 _352 = float2(_344, _351);
    float2 _353 = _259 + _337;
    float2 _354 = _264 + _352;
    float _355 = _353.x;
    float _356 = _353.y;
    float3 _357 = float3(_355, _356, _289);
    float _358 = _354.x;
    float _359 = _354.y;
    float3 _360 = float3(_358, _359, _304);
    float3 _361 = float3(_236);
    float3 _362 = mix(_357, _360, _361);
    float2 _372 = (mix(float2(_282.zw), float2(_297.zw), float2(_236)) * float2(2.0)) - float2(1.0);
    float2 _381 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _382 = _381.x;
    float _383 = _381.y;
    float3 _384 = float3(_382, _383, 0.0);
    float3 _385 = _362 + _384;
    float3 _389 = _385.xxx;
    float3 _390 = Primitive.Primitive_LocalToWorld[0u].xyz * _389;
    float3 _394 = _385.yyy;
    float3 _395 = Primitive.Primitive_LocalToWorld[1u].xyz * _394;
    float3 _396 = _390 + _395;
    float3 _400 = _385.zzz;
    float3 _401 = Primitive.Primitive_LocalToWorld[2u].xyz * _400;
    float3 _402 = _396 + _401;
    float3 _406 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _407 = _402 + _406;
    float _408 = _407.x;
    float _409 = _407.y;
    float _410 = _407.z;
    float4 _411 = float4(_408, _409, _410, 1.0);
    float4 _412 = float4(_411.x, _411.y, _411.z, _411.w);
    float2 _413 = _362.xy;
    float2 _420 = ((_413 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _312;
    float2 _424 = (((_413 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _271) + _276;
    float4 _431 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _412;
    out.out_var_TEXCOORD0 = (_413 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _381;
    out.out_var_TEXCOORD1 = float4(_420.x, _420.y, _424.x, _424.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD7 = _411.xyz;
    out.out_var_TEXCOORD6 = _431;
    out.out_var_TEXCOORD8 = float3(_372, sqrt(fast::max(1.0 - dot(_372, _372), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _431;
    return out;
}

