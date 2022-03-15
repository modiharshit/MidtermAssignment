

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
    char _m6_pad[32];
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

vertex Main_out Main_000027d0_54f82e7d(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _95 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _99 = _95 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _104 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _105 = _99 + _104;
    uint _106 = uint(_105);
    float4 _108 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_106));
    float _109 = _108.x;
    float _112 = float(View.View_FarShadowStaticMeshLODBias);
    float _113 = _109 + _112;
    float _116 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _117 = fast::min(_113, _116);
    float _118 = floor(_117);
    uint _119 = uint(_118);
    int _122 = int(_119);
    int _123 = _122 & 31;
    int _124 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _123;
    int _125 = _124 - 1;
    float _126 = float(_125);
    float _127 = float(_119);
    float _128 = 1.0 / _126;
    float4 _130 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_106));
    float _131 = _130.x;
    float2 _133 = in.in_var_ATTRIBUTE0.xy * _128;
    float2 _135 = _133 + in.in_var_ATTRIBUTE0.zw;
    float _138 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _139 = float2(_138);
    float2 _140 = _135 / _139;
    float _141 = _140.y;
    float _142 = _140.x;
    float _143 = 1.0 - _142;
    float _144 = 1.0 - _141;
    float4 _145 = float4(_141, _142, _143, _144);
    float4 _146 = _145 * 2.0;
    float4 _147 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_106));
    float _148 = _147.x;
    float _149 = _148 + _112;
    float _150 = fast::min(_149, _116);
    float4 _151 = _146 * _150;
    float4 _152 = float4(1.0) - _146;
    spvUnsafeArray<int2, 4> _83;
    _83[0] = int2(0, -1);
    _83[1] = int2(-1, 0);
    _83[2] = int2(1, 0);
    _83[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _84;
    for (int _158 = 0; _158 < 4; )
    {
        int2 _172 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_83[_158] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _84[_158] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_172.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_172.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_106)).x + _112, _116));
        _84[_158] = fast::min(_84[_158] + _112, _116);
        _158++;
        continue;
    }
    float4 _199 = float4(_84[0], _84[1], _84[2], _84[3]);
    float4 _200 = _152 * _199;
    float4 _201 = _151 + _200;
    float _202 = _142 + _141;
    bool _203 = _202 > 1.0;
    bool _204 = _142 < _141;
    float _205 = _201.w;
    float _206 = _201.z;
    float _207 = _204 ? _205 : _206;
    float _208 = _201.y;
    float _209 = _201.x;
    float _210 = _204 ? _208 : _209;
    float _211 = _203 ? _207 : _210;
    float _212 = floor(_211);
    float _213 = _211 - _212;
    float _214 = _212 - _127;
    float _215 = -_214;
    float _216 = pow(2.0, _215);
    float2 _217 = in.in_var_ATTRIBUTE0.xy * _216;
    float2 _218 = floor(_217);
    float _219 = -_212;
    float _220 = pow(2.0, _219);
    float _223 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _220;
    float _224 = _223 - 1.0;
    float _225 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _226 = _225 * _220;
    float _227 = fast::max(_226, 2.0);
    float _228 = _227 - 1.0;
    float2 _229 = float2(_224, _228);
    float2 _232 = _229 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _233 = _232.x;
    float2 _234 = float2(_233);
    float2 _235 = _218 / _234;
    float2 _236 = _218 * 0.5;
    float2 _237 = floor(_236);
    float _238 = _232.y;
    float2 _239 = float2(_238);
    float2 _240 = _237 / _239;
    float2 _244 = _235 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _246 = _244 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _247 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _248 = _246 + _247;
    float2 _252 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _253 = _248 + _252;
    float _256 = _212 - _131;
    float4 _258 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _253, level(_256));
    float _259 = _258.x;
    float _260 = _259 * 65280.0;
    float _261 = _258.y;
    float _262 = _261 * 255.0;
    float _263 = _260 + _262;
    float _264 = _263 - 32768.0;
    float _265 = _264 * 0.0078125;
    float2 _266 = _240 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _267 = _266 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _268 = _267 + _247;
    float2 _269 = _268 + _252;
    float _270 = _212 + 1.0;
    float _271 = _270 - _131;
    float4 _273 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _269, level(_271));
    float _274 = _273.x;
    float _275 = _274 * 65280.0;
    float _276 = _273.y;
    float _277 = _276 * 255.0;
    float _278 = _275 + _277;
    float _279 = _278 - 32768.0;
    float _280 = _279 * 0.0078125;
    float _281 = _235.x;
    float _282 = _235.y;
    float3 _283 = float3(_281, _282, _265);
    float _284 = _240.x;
    float _285 = _240.y;
    float3 _286 = float3(_284, _285, _280);
    float3 _287 = float3(_213);
    float3 _288 = mix(_283, _286, _287);
    float2 _290 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _291 = _290.x;
    float _292 = _290.y;
    float3 _293 = float3(_291, _292, 0.0);
    float3 _294 = _288 + _293;
    float3 _298 = _294.xxx;
    float3 _299 = Primitive.Primitive_LocalToWorld[0u].xyz * _298;
    float3 _303 = _294.yyy;
    float3 _304 = Primitive.Primitive_LocalToWorld[1u].xyz * _303;
    float3 _305 = _299 + _304;
    float3 _309 = _294.zzz;
    float3 _310 = Primitive.Primitive_LocalToWorld[2u].xyz * _309;
    float3 _311 = _305 + _310;
    float3 _315 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _316 = _311 + _315;
    float _317 = _316.x;
    float _318 = _316.y;
    float _319 = _316.z;
    float4 _320 = float4(_317, _318, _319, 1.0);
    float4 _321 = float4(_320.x, _320.y, _320.z, _320.w);
    float4 _322 = View.View_TranslatedWorldToClip * _321;
    out.gl_Position = _322;
    return out;
}

