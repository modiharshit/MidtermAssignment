

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

vertex Main_out Main_0000300a_4e81be74(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _107 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _111 = _107 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _116 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _117 = _111 + _116;
    uint _118 = uint(_117);
    float4 _120 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_118));
    float _121 = _120.x;
    float _124 = float(View.View_FarShadowStaticMeshLODBias);
    float _125 = _121 + _124;
    float _128 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _129 = fast::min(_125, _128);
    float _130 = floor(_129);
    uint _131 = uint(_130);
    int _134 = int(_131);
    int _135 = _134 & 31;
    int _136 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _135;
    int _137 = _136 - 1;
    float _138 = float(_137);
    float _139 = float(_131);
    float _140 = 1.0 / _138;
    float4 _142 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_118));
    float _143 = _142.x;
    float2 _145 = in.in_var_ATTRIBUTE0.xy * _140;
    float2 _147 = _145 + in.in_var_ATTRIBUTE0.zw;
    float _150 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _151 = float2(_150);
    float2 _152 = _147 / _151;
    float _153 = _152.y;
    float _154 = _152.x;
    float _155 = 1.0 - _154;
    float _156 = 1.0 - _153;
    float4 _157 = float4(_153, _154, _155, _156);
    float4 _158 = _157 * 2.0;
    float4 _159 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_118));
    float _160 = _159.x;
    float _161 = _160 + _124;
    float _162 = fast::min(_161, _128);
    float4 _163 = _158 * _162;
    float4 _164 = float4(1.0) - _158;
    spvUnsafeArray<int2, 4> _95;
    _95[0] = int2(0, -1);
    _95[1] = int2(-1, 0);
    _95[2] = int2(1, 0);
    _95[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _96;
    for (int _170 = 0; _170 < 4; )
    {
        int2 _184 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_95[_170] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _96[_170] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_184.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_184.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_118)).x + _124, _128));
        _96[_170] = fast::min(_96[_170] + _124, _128);
        _170++;
        continue;
    }
    float4 _211 = float4(_96[0], _96[1], _96[2], _96[3]);
    float4 _212 = _164 * _211;
    float4 _213 = _163 + _212;
    float _214 = _154 + _153;
    bool _215 = _214 > 1.0;
    bool _216 = _154 < _153;
    float _217 = _213.w;
    float _218 = _213.z;
    float _219 = _216 ? _217 : _218;
    float _220 = _213.y;
    float _221 = _213.x;
    float _222 = _216 ? _220 : _221;
    float _223 = _215 ? _219 : _222;
    float _224 = floor(_223);
    float _225 = _223 - _224;
    float _226 = _224 - _139;
    float _227 = -_226;
    float _228 = pow(2.0, _227);
    float2 _229 = in.in_var_ATTRIBUTE0.xy * _228;
    float2 _230 = floor(_229);
    float _231 = -_224;
    float _232 = pow(2.0, _231);
    float _236 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _232;
    float _237 = _236 - 1.0;
    float _238 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _239 = _238 * _232;
    float _240 = fast::max(_239, 2.0);
    float _241 = _240 - 1.0;
    float2 _242 = float2(_237, _241);
    float2 _245 = _242 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _246 = _245.x;
    float2 _247 = float2(_246);
    float2 _248 = _230 / _247;
    float2 _249 = _230 * 0.5;
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
    float _269 = _224 - _143;
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
    float _283 = _224 + 1.0;
    float _284 = _283 - _143;
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
    float3 _300 = float3(_225);
    float3 _301 = mix(_296, _299, _300);
    float2 _303 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _304 = _303.x;
    float _305 = _303.y;
    float3 _306 = float3(_304, _305, 0.0);
    float3 _307 = _301 + _306;
    float3 _311 = _307.xxx;
    float3 _312 = Primitive.Primitive_LocalToWorld[0u].xyz * _311;
    float3 _316 = _307.yyy;
    float3 _317 = Primitive.Primitive_LocalToWorld[1u].xyz * _316;
    float3 _318 = _312 + _317;
    float3 _322 = _307.zzz;
    float3 _323 = Primitive.Primitive_LocalToWorld[2u].xyz * _322;
    float3 _324 = _318 + _323;
    float3 _328 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _329 = _324 + _328;
    float _330 = _329.x;
    float _331 = _329.y;
    float _332 = _329.z;
    float4 _333 = float4(_330, _331, _332, 1.0);
    float2 _334 = _301.xy;
    float4 _339 = float4(_333.x, _333.y, _333.z, _333.w);
    float4 _340 = View.View_TranslatedWorldToClip * _339;
    float2 _349 = ((_334 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _353 = (((_334 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _260) + _265;
    float2 _364 = ((_334 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy);
    float2 _371 = (_364 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    float2 _377 = (_364 * PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_ShadowMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_334 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _303;
    out.out_var_TEXCOORD1 = float4(_349.x, _349.y, _353.x, _353.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_371.x, _371.y, _377.x, _377.y);
    out.gl_Position = _340;
    return out;
}

