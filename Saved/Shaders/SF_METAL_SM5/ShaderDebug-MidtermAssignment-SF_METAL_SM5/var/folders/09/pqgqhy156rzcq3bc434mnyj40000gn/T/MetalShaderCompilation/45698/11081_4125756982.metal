

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

vertex Main_out Main_00002b49_f5ea0e36(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _101 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _105 = _101 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _110 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _111 = _105 + _110;
    uint _112 = uint(_111);
    float4 _114 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_112));
    float _115 = _114.x;
    float _118 = float(View.View_FarShadowStaticMeshLODBias);
    float _119 = _115 + _118;
    float _122 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _123 = fast::min(_119, _122);
    float _124 = floor(_123);
    uint _125 = uint(_124);
    int _128 = int(_125);
    int _129 = _128 & 31;
    int _130 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _129;
    int _131 = _130 - 1;
    float _132 = float(_131);
    float _133 = float(_125);
    float _134 = 1.0 / _132;
    float4 _136 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_112));
    float _137 = _136.x;
    float2 _139 = in.in_var_ATTRIBUTE0.xy * _134;
    float2 _141 = _139 + in.in_var_ATTRIBUTE0.zw;
    float _144 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _145 = float2(_144);
    float2 _146 = _141 / _145;
    float _147 = _146.y;
    float _148 = _146.x;
    float _149 = 1.0 - _148;
    float _150 = 1.0 - _147;
    float4 _151 = float4(_147, _148, _149, _150);
    float4 _152 = _151 * 2.0;
    float4 _153 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_112));
    float _154 = _153.x;
    float _155 = _154 + _118;
    float _156 = fast::min(_155, _122);
    float4 _157 = _152 * _156;
    float4 _158 = float4(1.0) - _152;
    spvUnsafeArray<int2, 4> _89;
    _89[0] = int2(0, -1);
    _89[1] = int2(-1, 0);
    _89[2] = int2(1, 0);
    _89[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _90;
    for (int _164 = 0; _164 < 4; )
    {
        int2 _178 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_89[_164] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _90[_164] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_178.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_178.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_112)).x + _118, _122));
        _90[_164] = fast::min(_90[_164] + _118, _122);
        _164++;
        continue;
    }
    float4 _205 = float4(_90[0], _90[1], _90[2], _90[3]);
    float4 _206 = _158 * _205;
    float4 _207 = _157 + _206;
    float _208 = _148 + _147;
    bool _209 = _208 > 1.0;
    bool _210 = _148 < _147;
    float _211 = _207.w;
    float _212 = _207.z;
    float _213 = _210 ? _211 : _212;
    float _214 = _207.y;
    float _215 = _207.x;
    float _216 = _210 ? _214 : _215;
    float _217 = _209 ? _213 : _216;
    float _218 = floor(_217);
    float _219 = _217 - _218;
    float _220 = _218 - _133;
    float _221 = -_220;
    float _222 = pow(2.0, _221);
    float2 _223 = in.in_var_ATTRIBUTE0.xy * _222;
    float2 _224 = floor(_223);
    float _225 = -_218;
    float _226 = pow(2.0, _225);
    float _230 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _226;
    float _231 = _230 - 1.0;
    float _232 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _233 = _232 * _226;
    float _234 = fast::max(_233, 2.0);
    float _235 = _234 - 1.0;
    float2 _236 = float2(_231, _235);
    float2 _239 = _236 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _240 = _239.x;
    float2 _241 = float2(_240);
    float2 _242 = _224 / _241;
    float2 _243 = _224 * 0.5;
    float2 _244 = floor(_243);
    float _245 = _239.y;
    float2 _246 = float2(_245);
    float2 _247 = _244 / _246;
    float2 _251 = _242 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _253 = _251 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _254 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _255 = _253 + _254;
    float2 _259 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _260 = _255 + _259;
    float _263 = _218 - _137;
    float4 _265 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _260, level(_263));
    float _266 = _265.x;
    float _267 = _266 * 65280.0;
    float _268 = _265.y;
    float _269 = _268 * 255.0;
    float _270 = _267 + _269;
    float _271 = _270 - 32768.0;
    float _272 = _271 * 0.0078125;
    float2 _273 = _247 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _274 = _273 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _275 = _274 + _254;
    float2 _276 = _275 + _259;
    float _277 = _218 + 1.0;
    float _278 = _277 - _137;
    float4 _280 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _276, level(_278));
    float _281 = _280.x;
    float _282 = _281 * 65280.0;
    float _283 = _280.y;
    float _284 = _283 * 255.0;
    float _285 = _282 + _284;
    float _286 = _285 - 32768.0;
    float _287 = _286 * 0.0078125;
    float _288 = _242.x;
    float _289 = _242.y;
    float3 _290 = float3(_288, _289, _272);
    float _291 = _247.x;
    float _292 = _247.y;
    float3 _293 = float3(_291, _292, _287);
    float3 _294 = float3(_219);
    float3 _295 = mix(_290, _293, _294);
    float2 _297 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _298 = _297.x;
    float _299 = _297.y;
    float3 _300 = float3(_298, _299, 0.0);
    float3 _301 = _295 + _300;
    float3 _305 = _301.xxx;
    float3 _306 = Primitive.Primitive_LocalToWorld[0u].xyz * _305;
    float3 _310 = _301.yyy;
    float3 _311 = Primitive.Primitive_LocalToWorld[1u].xyz * _310;
    float3 _312 = _306 + _311;
    float3 _316 = _301.zzz;
    float3 _317 = Primitive.Primitive_LocalToWorld[2u].xyz * _316;
    float3 _318 = _312 + _317;
    float3 _322 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _323 = _318 + _322;
    float _324 = _323.x;
    float _325 = _323.y;
    float _326 = _323.z;
    float4 _327 = float4(_324, _325, _326, 1.0);
    float4 _328 = float4(_327.x, _327.y, _327.z, _327.w);
    float4 _329 = View.View_TranslatedWorldToClip * _328;
    float2 _330 = _295.xy;
    float2 _343 = ((_330 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _347 = (((_330 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _254) + _259;
    out.out_var_TEXCOORD0 = (_330 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _297;
    out.out_var_TEXCOORD1 = float4(_343.x, _343.y, _347.x, _347.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.gl_Position = _329;
    return out;
}

