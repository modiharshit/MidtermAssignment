

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
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002b88_69e98b6e(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(4)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(5)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    Main_out out = {};
    int _100 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _104 = _100 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _109 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _110 = _104 + _109;
    uint _111 = uint(_110);
    float4 _113 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_111));
    float _114 = _113.x;
    float _117 = float(View.View_FarShadowStaticMeshLODBias);
    float _118 = _114 + _117;
    float _121 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _122 = fast::min(_118, _121);
    float _123 = floor(_122);
    uint _124 = uint(_123);
    int _127 = int(_124);
    int _128 = _127 & 31;
    int _129 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _128;
    int _130 = _129 - 1;
    float _131 = float(_130);
    float _132 = float(_124);
    float _133 = 1.0 / _131;
    float4 _135 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_111));
    float _136 = _135.x;
    float2 _138 = in.in_var_ATTRIBUTE0.xy * _133;
    float2 _140 = _138 + in.in_var_ATTRIBUTE0.zw;
    float _143 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _144 = float2(_143);
    float2 _145 = _140 / _144;
    float _146 = _145.y;
    float _147 = _145.x;
    float _148 = 1.0 - _147;
    float _149 = 1.0 - _146;
    float4 _150 = float4(_146, _147, _148, _149);
    float4 _151 = _150 * 2.0;
    float4 _152 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_111));
    float _153 = _152.x;
    float _154 = _153 + _117;
    float _155 = fast::min(_154, _121);
    float4 _156 = _151 * _155;
    float4 _157 = float4(1.0) - _151;
    spvUnsafeArray<int2, 4> _90;
    _90[0] = int2(0, -1);
    _90[1] = int2(-1, 0);
    _90[2] = int2(1, 0);
    _90[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _91;
    for (int _163 = 0; _163 < 4; )
    {
        int2 _177 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_90[_163] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _91[_163] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_177.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_177.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_111)).x + _117, _121));
        _91[_163] = fast::min(_91[_163] + _117, _121);
        _163++;
        continue;
    }
    float4 _204 = float4(_91[0], _91[1], _91[2], _91[3]);
    float4 _205 = _157 * _204;
    float4 _206 = _156 + _205;
    float _207 = _147 + _146;
    bool _208 = _207 > 1.0;
    bool _209 = _147 < _146;
    float _210 = _206.w;
    float _211 = _206.z;
    float _212 = _209 ? _210 : _211;
    float _213 = _206.y;
    float _214 = _206.x;
    float _215 = _209 ? _213 : _214;
    float _216 = _208 ? _212 : _215;
    float _217 = floor(_216);
    float _218 = _216 - _217;
    float _219 = _217 - _132;
    float _220 = -_219;
    float _221 = pow(2.0, _220);
    float2 _222 = in.in_var_ATTRIBUTE0.xy * _221;
    float2 _223 = floor(_222);
    float _224 = -_217;
    float _225 = pow(2.0, _224);
    float _229 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _225;
    float _230 = _229 - 1.0;
    float _231 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _232 = _231 * _225;
    float _233 = fast::max(_232, 2.0);
    float _234 = _233 - 1.0;
    float2 _235 = float2(_230, _234);
    float2 _238 = _235 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _239 = _238.x;
    float2 _240 = float2(_239);
    float2 _241 = _223 / _240;
    float2 _242 = _223 * 0.5;
    float2 _243 = floor(_242);
    float _244 = _238.y;
    float2 _245 = float2(_244);
    float2 _246 = _243 / _245;
    float2 _250 = _241 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _252 = _250 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _253 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _254 = _252 + _253;
    float2 _258 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _259 = _254 + _258;
    float _262 = _217 - _136;
    float4 _264 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _259, level(_262));
    float _265 = _264.x;
    float _266 = _265 * 65280.0;
    float _267 = _264.y;
    float _268 = _267 * 255.0;
    float _269 = _266 + _268;
    float _270 = _269 - 32768.0;
    float _271 = _270 * 0.0078125;
    float2 _272 = _246 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _273 = _272 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _274 = _273 + _253;
    float2 _275 = _274 + _258;
    float _276 = _217 + 1.0;
    float _277 = _276 - _136;
    float4 _279 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _275, level(_277));
    float _280 = _279.x;
    float _281 = _280 * 65280.0;
    float _282 = _279.y;
    float _283 = _282 * 255.0;
    float _284 = _281 + _283;
    float _285 = _284 - 32768.0;
    float _286 = _285 * 0.0078125;
    float _287 = _241.x;
    float _288 = _241.y;
    float3 _289 = float3(_287, _288, _271);
    float _290 = _246.x;
    float _291 = _246.y;
    float3 _292 = float3(_290, _291, _286);
    float3 _293 = float3(_218);
    float3 _294 = mix(_289, _292, _293);
    float2 _296 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _297 = _296.x;
    float _298 = _296.y;
    float3 _299 = float3(_297, _298, 0.0);
    float3 _300 = _294 + _299;
    float3 _304 = _300.xxx;
    float3 _305 = Primitive.Primitive_LocalToWorld[0u].xyz * _304;
    float3 _309 = _300.yyy;
    float3 _310 = Primitive.Primitive_LocalToWorld[1u].xyz * _309;
    float3 _311 = _305 + _310;
    float3 _315 = _300.zzz;
    float3 _316 = Primitive.Primitive_LocalToWorld[2u].xyz * _315;
    float3 _317 = _311 + _316;
    float3 _321 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _322 = _317 + _321;
    float _323 = _322.x;
    float _324 = _322.y;
    float _325 = _322.z;
    float4 _326 = float4(_323, _324, _325, 1.0);
    float4 _327 = float4(_326.x, _326.y, _326.z, _326.w);
    float4 _330 = View.View_TranslatedWorldToClip * _327;
    float2 _331 = _294.xy;
    float2 _344 = ((_331 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _348 = (((_331 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _253) + _258;
    out.out_var_TEXCOORD0 = (_331 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _296;
    out.out_var_TEXCOORD1 = float4(_344.x, _344.y, _348.x, _348.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD6 = _327;
    out.gl_Position = _330;
    return out;
}

