

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
    char _m1_pad[912];
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m5_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m6_pad[16];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_EmitterDynamicUniforms
{
    float2 EmitterDynamicUniforms_LocalToWorldScale;
    float4 EmitterDynamicUniforms_AxisLockRight;
    float4 EmitterDynamicUniforms_AxisLockUp;
};

struct type_EmitterUniforms
{
    char _m0_pad[48];
    float4 EmitterUniforms_MiscCurve;
    float4 EmitterUniforms_MiscScale;
    float4 EmitterUniforms_MiscBias;
    float4 EmitterUniforms_SizeBySpeed;
    float4 EmitterUniforms_SubImageSize;
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m10_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _90 = {};
constant float2 _91 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TANGENTX [[user(locn1)]];
    float4 out_var_TANGENTZ [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00002f1c_6ec268ab(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _114 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _115 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _116 = _114 + _115;
    uint _119 = _Globals.ParticleIndicesOffset + _116;
    float4 _121 = ParticleIndices.read(uint(_119));
    float2 _122 = _121.xy;
    float4 _126 = PositionTexture.sample(PositionTextureSampler, _122, level(0.0));
    float4 _130 = VelocityTexture.sample(VelocityTextureSampler, _122, level(0.0));
    float4 _134 = AttributesTexture.sample(AttributesTextureSampler, _122, level(0.0));
    float _135 = _126.w;
    float _136 = step(_135, 1.0);
    float3 _137 = _130.xyz;
    float3x3 _146 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _147 = _146 * _137;
    float3 _149 = normalize(_147 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _150 = length(_147);
    float2 _155 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _135;
    float2 _156 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _155;
    float4 _160 = CurveTexture.sample(CurveTextureSampler, _156, level(0.0));
    float4 _163 = _160 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _166 = _163 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _167 = _134.x;
    bool _168 = _167 < 0.5;
    float _169 = _168 ? 0.0 : (-0.5);
    float _170 = _134.y;
    bool _171 = _170 < 0.5;
    float _172 = _171 ? 0.0 : (-0.5);
    float2 _173 = float2(_169, _172);
    float2 _174 = _134.xy;
    float2 _175 = _174 + _173;
    float2 _176 = _175 * float2(2.0);
    float2 _177 = _166.xy;
    float2 _180 = _177 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _184 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _150;
    float2 _185 = fast::max(_184, float2(1.0));
    float2 _187 = fast::min(_185, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _188 = _176 * _180;
    float2 _189 = _188 * _187;
    float2 _190 = float2(_136);
    float2 _191 = _189 * _190;
    float2 _196 = _91;
    _196.x = (_169 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _201 = _196;
    _201.y = (_172 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _202 = _166.z;
    float _204 = _202 - fract(_202);
    float2 _217 = (float2(mod(_204, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_204 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _201) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _218 = _134.w;
    float _221 = _218 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _222 = _134.z;
    float _223 = _221 * _135;
    float _224 = _222 + _223;
    float _225 = _224 * 6.283185482025146484375;
    float3 _229 = _126.xxx;
    float3 _230 = Primitive.Primitive_LocalToWorld[0u].xyz * _229;
    float3 _234 = _126.yyy;
    float3 _235 = Primitive.Primitive_LocalToWorld[1u].xyz * _234;
    float3 _236 = _230 + _235;
    float3 _240 = _126.zzz;
    float3 _241 = Primitive.Primitive_LocalToWorld[2u].xyz * _240;
    float3 _242 = _236 + _241;
    float3 _246 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _247 = _242 + _246;
    float _248 = _247.x;
    float _249 = _247.y;
    float _250 = _247.z;
    float4 _251 = float4(_248, _249, _250, 1.0);
    float3 _252 = _251.xyz;
    float3 _255 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _264 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _255), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _272 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _255), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _273 = View.View_TranslatedWorldCameraOrigin - _252;
    float _274 = dot(_273, _273);
    float3 _278 = _273 / float3(sqrt(fast::max(_274, 0.00999999977648258209228515625)));
    float3 _348;
    float3 _349;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _336 = cross(_278, float3(0.0, 0.0, 1.0));
        float3 _341 = _336 / float3(sqrt(fast::max(dot(_336, _336), 0.00999999977648258209228515625)));
        float3 _343 = float3(fast::clamp((_274 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _348 = normalize(mix(_264, _341, _343));
        _349 = normalize(mix(_272, cross(_278, _341), _343));
    }
    else
    {
        float3 _327;
        float3 _328;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _320 = cross(_278, _149);
            _327 = _320 / float3(sqrt(fast::max(dot(_320, _320), 0.00999999977648258209228515625)));
            _328 = -_149;
        }
        else
        {
            float3 _318;
            float3 _319;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _311 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _278);
                _318 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _319 = -(_311 / float3(sqrt(fast::max(dot(_311, _311), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _309;
                float3 _310;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _302 = cross(_278, float3(0.0, 0.0, 1.0));
                    float3 _307 = _302 / float3(sqrt(fast::max(dot(_302, _302), 0.00999999977648258209228515625)));
                    _309 = _307;
                    _310 = cross(_278, _307);
                }
                else
                {
                    _309 = _264;
                    _310 = _272;
                }
                _318 = _309;
                _319 = _310;
            }
            _327 = _318;
            _328 = _319;
        }
        _348 = _327;
        _349 = _328;
    }
    float _352 = _225 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _353 = sin(_352);
    float _354 = cos(_352);
    float3 _355 = _349 * _353;
    float3 _356 = _348 * _354;
    float3 _357 = _355 + _356;
    float3 _358 = _349 * _354;
    float3 _359 = _348 * _353;
    float3 _360 = _358 - _359;
    float _361 = _191.x;
    float _364 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _365 = _361 * _364;
    float3 _366 = _357 * _365;
    float _367 = _191.y;
    float _370 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _371 = _367 * _370;
    float3 _372 = _360 * _371;
    float3 _373 = _366 + _372;
    float3 _374 = _252 + _373;
    float _375 = _374.x;
    float _376 = _374.y;
    float _377 = _374.z;
    float4 _378 = float4(_375, _376, _377, 1.0);
    float4 _379 = float4(_378.x, _378.y, _378.z, _378.w);
    float4 _380 = View.View_TranslatedWorldToClip * _379;
    float3x3 _382 = _90;
    _382[0] = _357;
    float3x3 _383 = _382;
    _383[1] = _360;
    float3 _385 = normalize(cross(_357, _360));
    float3x3 _386 = _383;
    _386[2] = _385;
    spvUnsafeArray<float4, 1> _399 = { float4(_217.x, _217.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _399;
    out.out_var_TANGENTX = float4(_357, 0.0);
    out.out_var_TANGENTZ = float4(_385, float(int(sign(determinant(_386)))));
    out.out_var_TEXCOORD6 = _379;
    out.gl_Position = _380;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

