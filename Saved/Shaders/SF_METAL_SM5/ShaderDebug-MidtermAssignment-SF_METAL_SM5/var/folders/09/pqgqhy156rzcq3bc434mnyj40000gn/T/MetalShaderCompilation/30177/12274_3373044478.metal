

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
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002ff2_c90c92fe(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
    int _99 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _103 = _99 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _108 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _109 = _103 + _108;
    uint _110 = uint(_109);
    float4 _112 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_110));
    float _113 = _112.x;
    float _116 = float(View.View_FarShadowStaticMeshLODBias);
    float _117 = _113 + _116;
    float _120 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _121 = fast::min(_117, _120);
    float _122 = floor(_121);
    uint _123 = uint(_122);
    int _126 = int(_123);
    int _127 = _126 & 31;
    int _128 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _127;
    int _129 = _128 - 1;
    float _130 = float(_129);
    float _131 = float(_123);
    float _132 = 1.0 / _130;
    float4 _134 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_110));
    float _135 = _134.x;
    float2 _137 = in.in_var_ATTRIBUTE0.xy * _132;
    float2 _139 = _137 + in.in_var_ATTRIBUTE0.zw;
    float _142 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _143 = float2(_142);
    float2 _144 = _139 / _143;
    float _145 = _144.y;
    float _146 = _144.x;
    float _147 = 1.0 - _146;
    float _148 = 1.0 - _145;
    float4 _149 = float4(_145, _146, _147, _148);
    float4 _150 = _149 * 2.0;
    float4 _151 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_110));
    float _152 = _151.x;
    float _153 = _152 + _116;
    float _154 = fast::min(_153, _120);
    float4 _155 = _150 * _154;
    float4 _156 = float4(1.0) - _150;
    spvUnsafeArray<int2, 4> _87;
    _87[0] = int2(0, -1);
    _87[1] = int2(-1, 0);
    _87[2] = int2(1, 0);
    _87[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _88;
    for (int _162 = 0; _162 < 4; )
    {
        int2 _176 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_87[_162] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _88[_162] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_176.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_176.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_110)).x + _116, _120));
        _88[_162] = fast::min(_88[_162] + _116, _120);
        _162++;
        continue;
    }
    float4 _203 = float4(_88[0], _88[1], _88[2], _88[3]);
    float4 _204 = _156 * _203;
    float4 _205 = _155 + _204;
    float _206 = _146 + _145;
    bool _207 = _206 > 1.0;
    bool _208 = _146 < _145;
    float _209 = _205.w;
    float _210 = _205.z;
    float _211 = _208 ? _209 : _210;
    float _212 = _205.y;
    float _213 = _205.x;
    float _214 = _208 ? _212 : _213;
    float _215 = _207 ? _211 : _214;
    float _216 = floor(_215);
    float _217 = _215 - _216;
    float _218 = _216 - _131;
    float _219 = -_218;
    float _220 = pow(2.0, _219);
    float2 _221 = in.in_var_ATTRIBUTE0.xy * _220;
    float2 _222 = floor(_221);
    float _223 = -_216;
    float _224 = pow(2.0, _223);
    float _227 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _224;
    float _228 = _227 - 1.0;
    float _229 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _230 = _229 * _224;
    float _231 = fast::max(_230, 2.0);
    float _232 = _231 - 1.0;
    float2 _233 = float2(_228, _232);
    float2 _236 = _233 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _237 = _236.x;
    float2 _238 = float2(_237);
    float2 _239 = _222 / _238;
    float2 _240 = _222 * 0.5;
    float2 _241 = floor(_240);
    float _242 = _236.y;
    float2 _243 = float2(_242);
    float2 _244 = _241 / _243;
    float2 _248 = _239 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _250 = _248 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _251 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _252 = _250 + _251;
    float2 _256 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _257 = _252 + _256;
    float _260 = _216 - _135;
    float4 _262 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _257, level(_260));
    float _263 = _262.x;
    float _264 = _263 * 65280.0;
    float _265 = _262.y;
    float _266 = _265 * 255.0;
    float _267 = _264 + _266;
    float _268 = _267 - 32768.0;
    float _269 = _268 * 0.0078125;
    float2 _270 = _244 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _271 = _270 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _272 = _271 + _251;
    float2 _273 = _272 + _256;
    float _274 = _216 + 1.0;
    float _275 = _274 - _135;
    float4 _277 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _273, level(_275));
    float _278 = _277.x;
    float _279 = _278 * 65280.0;
    float _280 = _277.y;
    float _281 = _280 * 255.0;
    float _282 = _279 + _281;
    float _283 = _282 - 32768.0;
    float _284 = _283 * 0.0078125;
    float2 _288 = _239 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _290 = _288 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _292 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz;
    float2 _293 = _290 + _292;
    float4 _297 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _293, level(_216));
    float2 _298 = _244 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy;
    float2 _299 = _298 + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw;
    float2 _300 = _299 + _292;
    float4 _302 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _300, level(_274));
    float _303 = _297.x;
    float _304 = _303 * 65280.0;
    float _305 = _297.y;
    float _306 = _305 * 255.0;
    float _307 = _304 + _306;
    float _308 = _307 - 32768.0;
    float _309 = _308 * 0.00390625;
    float _310 = _297.z;
    float _311 = _310 * 65280.0;
    float _312 = _297.w;
    float _313 = _312 * 255.0;
    float _314 = _311 + _313;
    float _315 = _314 - 32768.0;
    float _316 = _315 * 0.00390625;
    float2 _317 = float2(_309, _316);
    float _318 = _302.x;
    float _319 = _318 * 65280.0;
    float _320 = _302.y;
    float _321 = _320 * 255.0;
    float _322 = _319 + _321;
    float _323 = _322 - 32768.0;
    float _324 = _323 * 0.00390625;
    float _325 = _302.z;
    float _326 = _325 * 65280.0;
    float _327 = _302.w;
    float _328 = _327 * 255.0;
    float _329 = _326 + _328;
    float _330 = _329 - 32768.0;
    float _331 = _330 * 0.00390625;
    float2 _332 = float2(_324, _331);
    float2 _333 = _239 + _317;
    float2 _334 = _244 + _332;
    float _335 = _333.x;
    float _336 = _333.y;
    float3 _337 = float3(_335, _336, _269);
    float _338 = _334.x;
    float _339 = _334.y;
    float3 _340 = float3(_338, _339, _284);
    float3 _341 = float3(_217);
    float3 _342 = mix(_337, _340, _341);
    float2 _344 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _345 = _344.x;
    float _346 = _344.y;
    float3 _347 = float3(_345, _346, 0.0);
    float3 _348 = _342 + _347;
    float3 _352 = _348.xxx;
    float3 _353 = Primitive.Primitive_LocalToWorld[0u].xyz * _352;
    float3 _357 = _348.yyy;
    float3 _358 = Primitive.Primitive_LocalToWorld[1u].xyz * _357;
    float3 _359 = _353 + _358;
    float3 _363 = _348.zzz;
    float3 _364 = Primitive.Primitive_LocalToWorld[2u].xyz * _363;
    float3 _365 = _359 + _364;
    float3 _369 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _370 = _365 + _369;
    float _371 = _370.x;
    float _372 = _370.y;
    float _373 = _370.z;
    float4 _374 = float4(_371, _372, _373, 1.0);
    float4 _375 = float4(_374.x, _374.y, _374.z, _374.w);
    float4 _376 = View.View_TranslatedWorldToClip * _375;
    out.gl_Position = _376;
    return out;
}

