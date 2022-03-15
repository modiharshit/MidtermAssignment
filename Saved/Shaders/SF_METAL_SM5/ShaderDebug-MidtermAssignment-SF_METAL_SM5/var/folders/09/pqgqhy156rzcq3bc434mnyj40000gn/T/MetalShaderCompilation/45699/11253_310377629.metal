

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

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002bf5_127ffc9d(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    int _102 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _106 = _102 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _111 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _112 = _106 + _111;
    uint _113 = uint(_112);
    float4 _115 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_113));
    float _116 = _115.x;
    float _119 = float(View.View_FarShadowStaticMeshLODBias);
    float _120 = _116 + _119;
    float _123 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _124 = fast::min(_120, _123);
    float _125 = floor(_124);
    uint _126 = uint(_125);
    int _129 = int(_126);
    int _130 = _129 & 31;
    int _131 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _130;
    int _132 = _131 - 1;
    float _133 = float(_132);
    float _134 = float(_126);
    float _135 = 1.0 / _133;
    float4 _137 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_113));
    float _138 = _137.x;
    float2 _140 = in.in_var_ATTRIBUTE0.xy * _135;
    float2 _142 = _140 + in.in_var_ATTRIBUTE0.zw;
    float _145 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _146 = float2(_145);
    float2 _147 = _142 / _146;
    float _148 = _147.y;
    float _149 = _147.x;
    float _150 = 1.0 - _149;
    float _151 = 1.0 - _148;
    float4 _152 = float4(_148, _149, _150, _151);
    float4 _153 = _152 * 2.0;
    float4 _154 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_113));
    float _155 = _154.x;
    float _156 = _155 + _119;
    float _157 = fast::min(_156, _123);
    float4 _158 = _153 * _157;
    float4 _159 = float4(1.0) - _153;
    spvUnsafeArray<int2, 4> _90;
    _90[0] = int2(0, -1);
    _90[1] = int2(-1, 0);
    _90[2] = int2(1, 0);
    _90[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _91;
    for (int _165 = 0; _165 < 4; )
    {
        int2 _179 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_90[_165] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _91[_165] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_179.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_179.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_113)).x + _119, _123));
        _91[_165] = fast::min(_91[_165] + _119, _123);
        _165++;
        continue;
    }
    float4 _206 = float4(_91[0], _91[1], _91[2], _91[3]);
    float4 _207 = _159 * _206;
    float4 _208 = _158 + _207;
    float _209 = _149 + _148;
    bool _210 = _209 > 1.0;
    bool _211 = _149 < _148;
    float _212 = _208.w;
    float _213 = _208.z;
    float _214 = _211 ? _212 : _213;
    float _215 = _208.y;
    float _216 = _208.x;
    float _217 = _211 ? _215 : _216;
    float _218 = _210 ? _214 : _217;
    float _219 = floor(_218);
    float _220 = _218 - _219;
    float _221 = _219 - _134;
    float _222 = -_221;
    float _223 = pow(2.0, _222);
    float2 _224 = in.in_var_ATTRIBUTE0.xy * _223;
    float2 _225 = floor(_224);
    float _226 = -_219;
    float _227 = pow(2.0, _226);
    float _231 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _227;
    float _232 = _231 - 1.0;
    float _233 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _234 = _233 * _227;
    float _235 = fast::max(_234, 2.0);
    float _236 = _235 - 1.0;
    float2 _237 = float2(_232, _236);
    float2 _240 = _237 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _241 = _240.x;
    float2 _242 = float2(_241);
    float2 _243 = _225 / _242;
    float2 _244 = _225 * 0.5;
    float2 _245 = floor(_244);
    float _246 = _240.y;
    float2 _247 = float2(_246);
    float2 _248 = _245 / _247;
    float2 _252 = _243 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _254 = _252 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _255 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _256 = _254 + _255;
    float2 _260 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _261 = _256 + _260;
    float _264 = _219 - _138;
    float4 _266 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _261, level(_264));
    float _267 = _266.x;
    float _268 = _267 * 65280.0;
    float _269 = _266.y;
    float _270 = _269 * 255.0;
    float _271 = _268 + _270;
    float _272 = _271 - 32768.0;
    float _273 = _272 * 0.0078125;
    float2 _274 = _248 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _275 = _274 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _276 = _275 + _255;
    float2 _277 = _276 + _260;
    float _278 = _219 + 1.0;
    float _279 = _278 - _138;
    float4 _281 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _277, level(_279));
    float _282 = _281.x;
    float _283 = _282 * 65280.0;
    float _284 = _281.y;
    float _285 = _284 * 255.0;
    float _286 = _283 + _285;
    float _287 = _286 - 32768.0;
    float _288 = _287 * 0.0078125;
    float _289 = _243.x;
    float _290 = _243.y;
    float3 _291 = float3(_289, _290, _273);
    float _292 = _248.x;
    float _293 = _248.y;
    float3 _294 = float3(_292, _293, _288);
    float3 _295 = float3(_220);
    float3 _296 = mix(_291, _294, _295);
    float2 _298 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _299 = _298.x;
    float _300 = _298.y;
    float3 _301 = float3(_299, _300, 0.0);
    float3 _302 = _296 + _301;
    float3 _306 = _302.xxx;
    float3 _307 = Primitive.Primitive_LocalToWorld[0u].xyz * _306;
    float3 _311 = _302.yyy;
    float3 _312 = Primitive.Primitive_LocalToWorld[1u].xyz * _311;
    float3 _313 = _307 + _312;
    float3 _317 = _302.zzz;
    float3 _318 = Primitive.Primitive_LocalToWorld[2u].xyz * _317;
    float3 _319 = _313 + _318;
    float3 _323 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _324 = _319 + _323;
    float _325 = _324.x;
    float _326 = _324.y;
    float _327 = _324.z;
    float4 _328 = float4(_325, _326, _327, 1.0);
    float4 _329 = float4(_328.x, _328.y, _328.z, _328.w);
    float4 _330 = View.View_TranslatedWorldToClip * _329;
    float2 _331 = _296.xy;
    float2 _344 = ((_331 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _348 = (((_331 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _255) + _260;
    out.out_var_TEXCOORD0 = (_331 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _298;
    out.out_var_TEXCOORD1 = float4(_344.x, _344.y, _348.x, _348.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _329;
    out.gl_Position = _330;
    return out;
}

