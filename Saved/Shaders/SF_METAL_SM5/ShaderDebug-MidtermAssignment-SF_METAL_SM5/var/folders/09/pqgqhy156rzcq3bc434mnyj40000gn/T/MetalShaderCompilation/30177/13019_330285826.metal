

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
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_000032db_13afc302(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _104 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _108 = _104 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _113 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _114 = _108 + _113;
    uint _115 = uint(_114);
    float4 _117 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_115));
    float _118 = _117.x;
    float _121 = float(View.View_FarShadowStaticMeshLODBias);
    float _122 = _118 + _121;
    float _125 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _126 = fast::min(_122, _125);
    float _127 = floor(_126);
    uint _128 = uint(_127);
    int _131 = int(_128);
    int _132 = _131 & 31;
    int _133 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _132;
    int _134 = _133 - 1;
    float _135 = float(_134);
    float _136 = float(_128);
    float _137 = 1.0 / _135;
    float4 _139 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_115));
    float _140 = _139.x;
    float2 _142 = in.in_var_ATTRIBUTE0.xy * _137;
    float2 _144 = _142 + in.in_var_ATTRIBUTE0.zw;
    float _147 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _148 = float2(_147);
    float2 _149 = _144 / _148;
    float _150 = _149.y;
    float _151 = _149.x;
    float _152 = 1.0 - _151;
    float _153 = 1.0 - _150;
    float4 _154 = float4(_150, _151, _152, _153);
    float4 _155 = _154 * 2.0;
    float4 _156 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_115));
    float _157 = _156.x;
    float _158 = _157 + _121;
    float _159 = fast::min(_158, _125);
    float4 _160 = _155 * _159;
    float4 _161 = float4(1.0) - _155;
    spvUnsafeArray<int2, 4> _92;
    _92[0] = int2(0, -1);
    _92[1] = int2(-1, 0);
    _92[2] = int2(1, 0);
    _92[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _93;
    for (int _167 = 0; _167 < 4; )
    {
        int2 _181 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_92[_167] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _93[_167] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_181.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_181.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_115)).x + _121, _125));
        _93[_167] = fast::min(_93[_167] + _121, _125);
        _167++;
        continue;
    }
    float4 _208 = float4(_93[0], _93[1], _93[2], _93[3]);
    float4 _209 = _161 * _208;
    float4 _210 = _160 + _209;
    float _211 = _151 + _150;
    bool _212 = _211 > 1.0;
    bool _213 = _151 < _150;
    float _214 = _210.w;
    float _215 = _210.z;
    float _216 = _213 ? _214 : _215;
    float _217 = _210.y;
    float _218 = _210.x;
    float _219 = _213 ? _217 : _218;
    float _220 = _212 ? _216 : _219;
    float _221 = floor(_220);
    float _222 = _220 - _221;
    float _223 = _221 - _136;
    float _224 = -_223;
    float _225 = pow(2.0, _224);
    float2 _226 = in.in_var_ATTRIBUTE0.xy * _225;
    float2 _227 = floor(_226);
    float _228 = -_221;
    float _229 = pow(2.0, _228);
    float _233 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _229;
    float _234 = _233 - 1.0;
    float _235 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _236 = _235 * _229;
    float _237 = fast::max(_236, 2.0);
    float _238 = _237 - 1.0;
    float2 _239 = float2(_234, _238);
    float2 _242 = _239 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _243 = _242.x;
    float2 _244 = float2(_243);
    float2 _245 = _227 / _244;
    float2 _246 = _227 * 0.5;
    float2 _247 = floor(_246);
    float _248 = _242.y;
    float2 _249 = float2(_248);
    float2 _250 = _247 / _249;
    float2 _254 = _245 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _256 = _254 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _257 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _258 = _256 + _257;
    float2 _262 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _263 = _258 + _262;
    float _266 = _221 - _140;
    float4 _268 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _263, level(_266));
    float _269 = _268.x;
    float _270 = _269 * 65280.0;
    float _271 = _268.y;
    float _272 = _271 * 255.0;
    float _273 = _270 + _272;
    float _274 = _273 - 32768.0;
    float _275 = _274 * 0.0078125;
    float2 _276 = _250 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _277 = _276 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _278 = _277 + _257;
    float2 _279 = _278 + _262;
    float _280 = _221 + 1.0;
    float _281 = _280 - _140;
    float4 _283 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _279, level(_281));
    float _284 = _283.x;
    float _285 = _284 * 65280.0;
    float _286 = _283.y;
    float _287 = _286 * 255.0;
    float _288 = _285 + _287;
    float _289 = _288 - 32768.0;
    float _290 = _289 * 0.0078125;
    float2 _294 = _245 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _296 = _294 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _298 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _299 = _296 + _298;
    float4 _303 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _299, level(_221));
    float2 _304 = _250 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _305 = _304 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _306 = _305 + _298;
    float4 _308 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _306, level(_280));
    float _309 = _303.x;
    float _310 = _309 * 65280.0;
    float _311 = _303.y;
    float _312 = _311 * 255.0;
    float _313 = _310 + _312;
    float _314 = _313 - 32768.0;
    float _315 = _314 * 0.00390625;
    float _316 = _303.z;
    float _317 = _316 * 65280.0;
    float _318 = _303.w;
    float _319 = _318 * 255.0;
    float _320 = _317 + _319;
    float _321 = _320 - 32768.0;
    float _322 = _321 * 0.00390625;
    float2 _323 = float2(_315, _322);
    float _324 = _308.x;
    float _325 = _324 * 65280.0;
    float _326 = _308.y;
    float _327 = _326 * 255.0;
    float _328 = _325 + _327;
    float _329 = _328 - 32768.0;
    float _330 = _329 * 0.00390625;
    float _331 = _308.z;
    float _332 = _331 * 65280.0;
    float _333 = _308.w;
    float _334 = _333 * 255.0;
    float _335 = _332 + _334;
    float _336 = _335 - 32768.0;
    float _337 = _336 * 0.00390625;
    float2 _338 = float2(_330, _337);
    float2 _339 = _245 + _323;
    float2 _340 = _250 + _338;
    float _341 = _339.x;
    float _342 = _339.y;
    float3 _343 = float3(_341, _342, _275);
    float _344 = _340.x;
    float _345 = _340.y;
    float3 _346 = float3(_344, _345, _290);
    float3 _347 = float3(_222);
    float3 _348 = mix(_343, _346, _347);
    float2 _350 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _351 = _350.x;
    float _352 = _350.y;
    float3 _353 = float3(_351, _352, 0.0);
    float3 _354 = _348 + _353;
    float3 _358 = _354.xxx;
    float3 _359 = Primitive.Primitive_LocalToWorld[0u].xyz * _358;
    float3 _363 = _354.yyy;
    float3 _364 = Primitive.Primitive_LocalToWorld[1u].xyz * _363;
    float3 _365 = _359 + _364;
    float3 _369 = _354.zzz;
    float3 _370 = Primitive.Primitive_LocalToWorld[2u].xyz * _369;
    float3 _371 = _365 + _370;
    float3 _375 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _376 = _371 + _375;
    float _377 = _376.x;
    float _378 = _376.y;
    float _379 = _376.z;
    float4 _380 = float4(_377, _378, _379, 1.0);
    float2 _381 = _348.xy;
    float4 _386 = float4(_380.x, _380.y, _380.z, _380.w);
    float4 _387 = View.View_TranslatedWorldToClip * _386;
    float2 _390 = ((_381 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + _298;
    float2 _394 = (((_381 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _257) + _262;
    out.out_var_TEXCOORD0 = (_381 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _350;
    out.out_var_TEXCOORD1 = float4(_390.x, _390.y, _394.x, _394.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.gl_Position = _387;
    return out;
}

