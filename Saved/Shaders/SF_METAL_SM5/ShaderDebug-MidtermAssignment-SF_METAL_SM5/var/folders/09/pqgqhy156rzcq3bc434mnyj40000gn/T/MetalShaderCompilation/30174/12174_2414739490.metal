

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

struct MainVertexShader_out
{
    float2 out_var_TEXCOORD0 [[user(locn0)]];
    float4 out_var_TEXCOORD1 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_00002f8e_8fee0022(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_PrecomputedLightingBuffer& PrecomputedLightingBuffer [[buffer(4)]], constant type_LandscapeContinuousLODParameters& LandscapeContinuousLODParameters [[buffer(5)]], constant type_LandscapeParameters& LandscapeParameters [[buffer(6)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLOD [[texture(0)]], texture_buffer<float> LandscapeContinuousLODParameters_SectionLODBias [[texture(1)]], texture2d<float> LandscapeParameters_HeightmapTexture [[texture(2)]], sampler LandscapeParameters_HeightmapTextureSampler [[sampler(0)]])
{
    MainVertexShader_out out = {};
    int _109 = LandscapeParameters.LandscapeParameters_ComponentBaseY - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y;
    int _113 = _109 * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x;
    int _118 = LandscapeParameters.LandscapeParameters_ComponentBaseX - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x;
    int _119 = _113 + _118;
    uint _120 = uint(_119);
    float4 _122 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_120));
    float _123 = _122.x;
    float _126 = float(View.View_FarShadowStaticMeshLODBias);
    float _127 = _123 + _126;
    float _130 = float(LandscapeParameters.LandscapeParameters_LastLOD);
    float _131 = fast::min(_127, _130);
    float _132 = floor(_131);
    uint _133 = uint(_132);
    int _136 = int(_133);
    int _137 = _136 & 31;
    int _138 = LandscapeParameters.LandscapeParameters_SubsectionSizeVerts >> _137;
    int _139 = _138 - 1;
    float _140 = float(_139);
    float _141 = float(_133);
    float _142 = 1.0 / _140;
    float4 _144 = LandscapeContinuousLODParameters_SectionLODBias.read(uint(_120));
    float _145 = _144.x;
    float2 _147 = in.in_var_ATTRIBUTE0.xy * _142;
    float2 _149 = _147 + in.in_var_ATTRIBUTE0.zw;
    float _152 = float(LandscapeParameters.LandscapeParameters_NumSubsections);
    float2 _153 = float2(_152);
    float2 _154 = _149 / _153;
    float _155 = _154.y;
    float _156 = _154.x;
    float _157 = 1.0 - _156;
    float _158 = 1.0 - _155;
    float4 _159 = float4(_155, _156, _157, _158);
    float4 _160 = _159 * 2.0;
    float4 _161 = LandscapeContinuousLODParameters_SectionLOD.read(uint(_120));
    float _162 = _161.x;
    float _163 = _162 + _126;
    float _164 = fast::min(_163, _130);
    float4 _165 = _160 * _164;
    float4 _166 = float4(1.0) - _160;
    spvUnsafeArray<int2, 4> _97;
    _97[0] = int2(0, -1);
    _97[1] = int2(-1, 0);
    _97[2] = int2(1, 0);
    _97[3] = int2(0, 1);
    spvUnsafeArray<float, 4> _98;
    for (int _172 = 0; _172 < 4; )
    {
        int2 _186 = min(((LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min + LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size) - int2(1)), max(LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min, (_97[_172] + int2(LandscapeParameters.LandscapeParameters_ComponentBaseX, LandscapeParameters.LandscapeParameters_ComponentBaseY))));
        _98[_172] = fast::max(LandscapeContinuousLODParameters_SectionLOD.read(uint(uint(((_186.y - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.y) * LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Size.x) + (_186.x - LandscapeContinuousLODParameters.LandscapeContinuousLODParameters_Min.x)))).x, fast::min(LandscapeContinuousLODParameters_SectionLOD.read(uint(_120)).x + _126, _130));
        _98[_172] = fast::min(_98[_172] + _126, _130);
        _172++;
        continue;
    }
    float4 _213 = float4(_98[0], _98[1], _98[2], _98[3]);
    float4 _214 = _166 * _213;
    float4 _215 = _165 + _214;
    float _216 = _156 + _155;
    bool _217 = _216 > 1.0;
    bool _218 = _156 < _155;
    float _219 = _215.w;
    float _220 = _215.z;
    float _221 = _218 ? _219 : _220;
    float _222 = _215.y;
    float _223 = _215.x;
    float _224 = _218 ? _222 : _223;
    float _225 = _217 ? _221 : _224;
    float _226 = floor(_225);
    float _227 = _225 - _226;
    float _228 = _226 - _141;
    float _229 = -_228;
    float _230 = pow(2.0, _229);
    float2 _231 = in.in_var_ATTRIBUTE0.xy * _230;
    float2 _232 = floor(_231);
    float _233 = -_226;
    float _234 = pow(2.0, _233);
    float _238 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * _234;
    float _239 = _238 - 1.0;
    float _240 = LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.x * 0.5;
    float _241 = _240 * _234;
    float _242 = fast::max(_241, 2.0);
    float _243 = _242 - 1.0;
    float2 _244 = float2(_239, _243);
    float2 _247 = _244 * LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.y;
    float _248 = _247.x;
    float2 _249 = float2(_248);
    float2 _250 = _232 / _249;
    float2 _251 = _232 * 0.5;
    float2 _252 = floor(_251);
    float _253 = _247.y;
    float2 _254 = float2(_253);
    float2 _255 = _252 / _254;
    float2 _259 = _250 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _261 = _259 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _262 = LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy * 0.5;
    float2 _263 = _261 + _262;
    float2 _267 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.xy;
    float2 _268 = _263 + _267;
    float _271 = _226 - _145;
    float4 _273 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _268, level(_271));
    float _274 = _273.x;
    float _275 = _274 * 65280.0;
    float _276 = _273.y;
    float _277 = _276 * 255.0;
    float _278 = _275 + _277;
    float _279 = _278 - 32768.0;
    float _280 = _279 * 0.0078125;
    float2 _281 = _255 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy;
    float2 _282 = _281 + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw;
    float2 _283 = _282 + _262;
    float2 _284 = _283 + _267;
    float _285 = _226 + 1.0;
    float _286 = _285 - _145;
    float4 _288 = LandscapeParameters_HeightmapTexture.sample(LandscapeParameters_HeightmapTextureSampler, _284, level(_286));
    float _289 = _288.x;
    float _290 = _289 * 65280.0;
    float _291 = _288.y;
    float _292 = _291 * 255.0;
    float _293 = _290 + _292;
    float _294 = _293 - 32768.0;
    float _295 = _294 * 0.0078125;
    float _296 = _250.x;
    float _297 = _250.y;
    float3 _298 = float3(_296, _297, _280);
    float _299 = _255.x;
    float _300 = _255.y;
    float3 _301 = float3(_299, _300, _295);
    float3 _302 = float3(_227);
    float3 _303 = mix(_298, _301, _302);
    float2 _305 = in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.ww;
    float _306 = _305.x;
    float _307 = _305.y;
    float3 _308 = float3(_306, _307, 0.0);
    float3 _309 = _303 + _308;
    float3 _313 = _309.xxx;
    float3 _314 = Primitive.Primitive_LocalToWorld[0u].xyz * _313;
    float3 _318 = _309.yyy;
    float3 _319 = Primitive.Primitive_LocalToWorld[1u].xyz * _318;
    float3 _320 = _314 + _319;
    float3 _324 = _309.zzz;
    float3 _325 = Primitive.Primitive_LocalToWorld[2u].xyz * _324;
    float3 _326 = _320 + _325;
    float3 _330 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _331 = _326 + _330;
    float _332 = _331.x;
    float _333 = _331.y;
    float _334 = _331.z;
    float4 _335 = float4(_332, _333, _334, 1.0);
    float2 _336 = _303.xy;
    float4 _341 = float4(_335.x, _335.y, _335.z, _335.w);
    float4 _342 = View.View_TranslatedWorldToClip * _341;
    float2 _351 = ((_336 * LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_WeightmapUVScaleBias.zw) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_SubsectionOffsetParams.zz);
    float2 _355 = (((_336 * LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.xy) + LandscapeParameters.LandscapeParameters_HeightmapUVScaleBias.zw) + _262) + _267;
    float2 _373 = ((((_336 * LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.xy) + LandscapeParameters.LandscapeParameters_LandscapeLightmapScaleBias.wz) + (in.in_var_ATTRIBUTE0.zw * LandscapeParameters.LandscapeParameters_LightmapSubsectionOffsetParams.xy)) * PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.xy) + PrecomputedLightingBuffer.PrecomputedLightingBuffer_LightMapCoordinateScaleBias.zw;
    out.out_var_TEXCOORD0 = (_336 + LandscapeParameters.LandscapeParameters_SubsectionSizeVertsLayerUVPan.zw) + _305;
    out.out_var_TEXCOORD1 = float4(_351.x, _351.y, _355.x, _355.y);
    out.out_var_TEXCOORD2 = float4(0.0);
    out.out_var_TEXCOORD3 = float4(_373.x, _373.y, float2(0.0).x, float2(0.0).y);
    out.out_var_TEXCOORD6 = _341;
    out.gl_Position = _342;
    return out;
}

