

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
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000332c_c4da79c6(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], constant type_Globals& _Globals [[buffer(7)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], texture2d<float> LandscapeParameters_XYOffsetmapTexture [[texture(3)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]], sampler LandscapeParameters_XYOffsetmapTextureSampler [[sampler(1)]])
{
    Main_out out = {};
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
    spvUnsafeArray<int2, 4> _102;
    _102[0] = int2(0, -1);
    _102[1] = int2(-1, 0);
    _102[2] = int2(1, 0);
    _102[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _103;
    for (int _175 = 0; _175 < 4; )
    {
        int2 _189 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_102[_175] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _103[_175] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_189.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_189.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_123)).x + _129, _133));
        _103[_175] = fast::min(_103[_175] + _129, _133);
        _175++;
        continue;
    }
    float4 _216 = float4(_103[0], _103[1], _103[2], _103[3]);
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
    float _240 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _237;
    float _241 = _240 - 1.0;
    float _242 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _243 = _242 * _237;
    float _244 = fast::max(_243, 2.0);
    float _245 = _244 - 1.0;
    float2 _246 = float2(_241, _245);
    float2 _249 = _246 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _250 = _249.x;
    float2 _251 = float2(_250);
    float2 _252 = _235 / _251;
    float2 _253 = _235 * 0.5;
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
    float _273 = _229 - _148;
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
    float _287 = _229 + 1.0;
    float _288 = _287 - _148;
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
    float4 _310 = LandscapeParameters_XYOffsetmapTexture.sample(LandscapeParameters_XYOffsetmapTextureSampler, _306, level(_229));
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
    float3 _354 = float3(_230);
    float3 _355 = mix(_350, _353, _354);
    float2 _365 = (mix(float2(_275.zw), float2(_290.zw), float2(_230)) * float2(2.0)) - float2(1.0);
    float2 _374 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _375 = _374.x;
    float _376 = _374.y;
    float3 _377 = float3(_375, _376, 0.0);
    float3 _378 = _355 + _377;
    float3 _382 = _378.xxx;
    float3 _383 = Primitive.Primitive_LocalToWorld[0u].xyz * _382;
    float3 _387 = _378.yyy;
    float3 _388 = Primitive.Primitive_LocalToWorld[1u].xyz * _387;
    float3 _389 = _383 + _388;
    float3 _393 = _378.zzz;
    float3 _394 = Primitive.Primitive_LocalToWorld[2u].xyz * _393;
    float3 _395 = _389 + _394;
    float3 _399 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _400 = _395 + _399;
    float _401 = _400.x;
    float _402 = _400.y;
    float _403 = _400.z;
    float4 _404 = float4(_401, _402, _403, 1.0);
    float4 _405 = float4(_404.x, _404.y, _404.z, _404.w);
    float4 _410 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _405;
    out.out_var_TEXCOORD6 = _405;
    out.out_var_TEXCOORD8 = float3(_365, sqrt(fast::max(1.0 - dot(_365, _365), 0.0)));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _410;
    return out;
}

