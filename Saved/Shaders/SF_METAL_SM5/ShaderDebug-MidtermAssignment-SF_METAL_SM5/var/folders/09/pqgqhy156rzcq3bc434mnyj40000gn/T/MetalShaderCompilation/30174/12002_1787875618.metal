

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

vertex Main_out Main_00002ee2_6a90d122(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
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
    spvUnsafeArray<int2, 4> _96;
    _96[0] = int2(0, -1);
    _96[1] = int2(-1, 0);
    _96[2] = int2(1, 0);
    _96[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _97;
    for (int _171 = 0; _171 < 4; )
    {
        int2 _185 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_96[_171] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _97[_171] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_185.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_185.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_119)).x + _125, _129));
        _97[_171] = fast::min(_97[_171] + _125, _129);
        _171++;
        continue;
    }
    float4 _212 = float4(_97[0], _97[1], _97[2], _97[3]);
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
    float _237 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _233;
    float _238 = _237 - 1.0;
    float _239 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _240 = _239 * _233;
    float _241 = fast::max(_240, 2.0);
    float _242 = _241 - 1.0;
    float2 _243 = float2(_238, _242);
    float2 _246 = _243 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _247 = _246.x;
    float2 _248 = float2(_247);
    float2 _249 = _231 / _248;
    float2 _250 = _231 * 0.5;
    float2 _251 = floor(_250);
    float _252 = _246.y;
    float2 _253 = float2(_252);
    float2 _254 = _251 / _253;
    float2 _258 = _249 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _260 = _258 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _261 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _262 = _260 + _261;
    float2 _266 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _267 = _262 + _266;
    float _270 = _225 - _144;
    float4 _272 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _267, level(_270));
    float _273 = _272.x;
    float _274 = _273 * 65280.0;
    float _275 = _272.y;
    float _276 = _275 * 255.0;
    float _277 = _274 + _276;
    float _278 = _277 - 32768.0;
    float _279 = _278 * 0.0078125;
    float2 _280 = _254 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _281 = _280 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _282 = _281 + _261;
    float2 _283 = _282 + _266;
    float _284 = _225 + 1.0;
    float _285 = _284 - _144;
    float4 _287 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _283, level(_285));
    float _288 = _287.x;
    float _289 = _288 * 65280.0;
    float _290 = _287.y;
    float _291 = _290 * 255.0;
    float _292 = _289 + _291;
    float _293 = _292 - 32768.0;
    float _294 = _293 * 0.0078125;
    float _295 = _249.x;
    float _296 = _249.y;
    float3 _297 = float3(_295, _296, _279);
    float _298 = _254.x;
    float _299 = _254.y;
    float3 _300 = float3(_298, _299, _294);
    float3 _301 = float3(_226);
    float3 _302 = mix(_297, _300, _301);
    float2 _304 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _305 = _304.x;
    float _306 = _304.y;
    float3 _307 = float3(_305, _306, 0.0);
    float3 _308 = _302 + _307;
    float3 _312 = _308.xxx;
    float3 _313 = Primitive.Primitive_LocalToWorld[0u].xyz * _312;
    float3 _317 = _308.yyy;
    float3 _318 = Primitive.Primitive_LocalToWorld[1u].xyz * _317;
    float3 _319 = _313 + _318;
    float3 _323 = _308.zzz;
    float3 _324 = Primitive.Primitive_LocalToWorld[2u].xyz * _323;
    float3 _325 = _319 + _324;
    float3 _329 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _330 = _325 + _329;
    float _331 = _330.x;
    float _332 = _330.y;
    float _333 = _330.z;
    float4 _334 = float4(_331, _332, _333, 1.0);
    float2 _335 = _302.xy;
    float4 _340 = float4(_334.x, _334.y, _334.z, _334.w);
    float4 _341 = View.View_TranslatedWorldToClip * _340;
    float2 _350 = ((_335 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _354 = (((_335 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _261) + _266;
    float2 _372 = ((((_335 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_335 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _304;
    out.out_var_TEXCOORD1 = float4(_350.x, _350.y, _354.x, _354.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_372.x, _372.y, float2(0.0).x, float2(0.0).y);
    out.gl_Position = _341;
    return out;
}

