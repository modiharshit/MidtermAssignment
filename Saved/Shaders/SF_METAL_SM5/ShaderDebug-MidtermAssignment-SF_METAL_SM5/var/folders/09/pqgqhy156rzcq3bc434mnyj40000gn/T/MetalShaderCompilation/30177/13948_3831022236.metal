

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

vertex Main_out Main_0000367c_e458c29c(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _111 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _115 = _111 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _120 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _121 = _115 + _120;
    uint _122 = uint(_121);
    float4 _124 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_122));
    float _125 = _124.x;
    float _128 = float(View.View_FarShadowStaticMeshLODBias);
    float _129 = _125 + _128;
    float _132 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _133 = fast::min(_129, _132);
    float _134 = floor(_133);
    uint _135 = uint(_134);
    int _138 = int(_135);
    int _139 = _138 & 31;
    int _140 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _139;
    int _141 = _140 - 1;
    float _142 = float(_141);
    float _143 = float(_135);
    float _144 = 1.0 / _142;
    float4 _146 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_122));
    float _147 = _146.x;
    float2 _149 = in.in_var_ATTRIBUTE0.xy * _144;
    float2 _151 = _149 + in.in_var_ATTRIBUTE0.zw;
    float _154 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _155 = float2(_154);
    float2 _156 = _151 / _155;
    float _157 = _156.y;
    float _158 = _156.x;
    float _159 = 1.0 - _158;
    float _160 = 1.0 - _157;
    float4 _161 = float4(_157, _158, _159, _160);
    float4 _162 = _161 * 2.0;
    float4 _163 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_122));
    float _164 = _163.x;
    float _165 = _164 + _128;
    float _166 = fast::min(_165, _132);
    float4 _167 = _162 * _166;
    float4 _168 = float4(1.0) - _162;
    spvUnsafeArray<int2, 4> _99;
    _99[0] = int2(0, -1);
    _99[1] = int2(-1, 0);
    _99[2] = int2(1, 0);
    _99[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _100;
    for (int _174 = 0; _174 < 4; )
    {
        int2 _188 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_99[_174] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _100[_174] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_188.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_188.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_122)).x + _128, _132));
        _100[_174] = fast::min(_100[_174] + _128, _132);
        _174++;
        continue;
    }
    float4 _215 = float4(_100[0], _100[1], _100[2], _100[3]);
    float4 _216 = _168 * _215;
    float4 _217 = _167 + _216;
    float _218 = _158 + _157;
    bool _219 = _218 > 1.0;
    bool _220 = _158 < _157;
    float _221 = _217.w;
    float _222 = _217.z;
    float _223 = _220 ? _221 : _222;
    float _224 = _217.y;
    float _225 = _217.x;
    float _226 = _220 ? _224 : _225;
    float _227 = _219 ? _223 : _226;
    float _228 = floor(_227);
    float _229 = _227 - _228;
    float _230 = _228 - _143;
    float _231 = -_230;
    float _232 = pow(2.0, _231);
    float2 _233 = in.in_var_ATTRIBUTE0.xy * _232;
    float2 _234 = floor(_233);
    float _235 = -_228;
    float _236 = pow(2.0, _235);
    float _240 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _236;
    float _241 = _240 - 1.0;
    float _242 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _243 = _242 * _236;
    float _244 = fast::max(_243, 2.0);
    float _245 = _244 - 1.0;
    float2 _246 = float2(_241, _245);
    float2 _249 = _246 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _250 = _249.x;
    float2 _251 = float2(_250);
    float2 _252 = _234 / _251;
    float2 _253 = _234 * 0.5;
    float2 _254 = floor(_253);
    float _255 = _249.y;
    float2 _256 = float2(_255);
    float2 _257 = _254 / _256;
    float2 _261 = _252 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _263 = _261 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _264 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _265 = _263 + _264;
    float2 _269 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _270 = _265 + _269;
    float _273 = _228 - _147;
    float4 _275 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _270, level(_273));
    float _276 = _275.x;
    float _277 = _276 * 65280.0;
    float _278 = _275.y;
    float _279 = _278 * 255.0;
    float _280 = _277 + _279;
    float _281 = _280 - 32768.0;
    float _282 = _281 * 0.0078125;
    float2 _283 = _257 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _284 = _283 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _285 = _284 + _264;
    float2 _286 = _285 + _269;
    float _287 = _228 + 1.0;
    float _288 = _287 - _147;
    float4 _290 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _286, level(_288));
    float _291 = _290.x;
    float _292 = _291 * 65280.0;
    float _293 = _290.y;
    float _294 = _293 * 255.0;
    float _295 = _292 + _294;
    float _296 = _295 - 32768.0;
    float _297 = _296 * 0.0078125;
    float2 _301 = _252 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _303 = _301 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _305 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _306 = _303 + _305;
    float4 _310 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _306, level(_228));
    float2 _311 = _257 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _312 = _311 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _313 = _312 + _305;
    float4 _315 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _313, level(_287));
    float _316 = _310.x;
    float _317 = _316 * 65280.0;
    float _318 = _310.y;
    float _319 = _318 * 255.0;
    float _320 = _317 + _319;
    float _321 = _320 - 32768.0;
    float _322 = _321 * 0.00390625;
    float _323 = _310.z;
    float _324 = _323 * 65280.0;
    float _325 = _310.w;
    float _326 = _325 * 255.0;
    float _327 = _324 + _326;
    float _328 = _327 - 32768.0;
    float _329 = _328 * 0.00390625;
    float2 _330 = float2(_322, _329);
    float _331 = _315.x;
    float _332 = _331 * 65280.0;
    float _333 = _315.y;
    float _334 = _333 * 255.0;
    float _335 = _332 + _334;
    float _336 = _335 - 32768.0;
    float _337 = _336 * 0.00390625;
    float _338 = _315.z;
    float _339 = _338 * 65280.0;
    float _340 = _315.w;
    float _341 = _340 * 255.0;
    float _342 = _339 + _341;
    float _343 = _342 - 32768.0;
    float _344 = _343 * 0.00390625;
    float2 _345 = float2(_337, _344);
    float2 _346 = _252 + _330;
    float2 _347 = _257 + _345;
    float _348 = _346.x;
    float _349 = _346.y;
    float3 _350 = float3(_348, _349, _282);
    float _351 = _347.x;
    float _352 = _347.y;
    float3 _353 = float3(_351, _352, _297);
    float3 _354 = float3(_229);
    float3 _355 = mix(_350, _353, _354);
    float2 _357 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _358 = _357.x;
    float _359 = _357.y;
    float3 _360 = float3(_358, _359, 0.0);
    float3 _361 = _355 + _360;
    float3 _365 = _361.xxx;
    float3 _366 = Primitive.Primitive_LocalToWorld[0u].xyz * _365;
    float3 _370 = _361.yyy;
    float3 _371 = Primitive.Primitive_LocalToWorld[1u].xyz * _370;
    float3 _372 = _366 + _371;
    float3 _376 = _361.zzz;
    float3 _377 = Primitive.Primitive_LocalToWorld[2u].xyz * _376;
    float3 _378 = _372 + _377;
    float3 _382 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _383 = _378 + _382;
    float _384 = _383.x;
    float _385 = _383.y;
    float _386 = _383.z;
    float4 _387 = float4(_384, _385, _386, 1.0);
    float2 _388 = _355.xy;
    float4 _393 = float4(_387.x, _387.y, _387.z, _387.w);
    float4 _394 = View.View_TranslatedWorldToClip * _393;
    float2 _397 = ((_388 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _305;
    float2 _401 = (((_388 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _264) + _269;
    float2 _419 = ((((_388 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_388 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _357;
    out.out_var_TEXCOORD1 = float4(_397.x, _397.y, _401.x, _401.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_419.x, _419.y, float2(0.0).x, float2(0.0).y);
    out.gl_Position = _394;
    return out;
}

