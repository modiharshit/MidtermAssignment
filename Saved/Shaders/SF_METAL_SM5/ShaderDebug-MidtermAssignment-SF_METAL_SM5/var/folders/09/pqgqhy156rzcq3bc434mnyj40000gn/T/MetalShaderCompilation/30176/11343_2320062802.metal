

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
    char _m7_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m8_pad[640];
    int View_NumSceneColorMSAASamples;
    char _m9_pad[224];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
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

constant float3x3 _102 = {};
constant float2 _103 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD0_0 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 out_var_TANGENTX [[user(locn4)]];
    float4 out_var_TANGENTZ [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVertexShader_out Main_00002c4f_8a495952(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float4 _135 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u)))));
    float2 _136 = _135.xy;
    float4 _140 = PositionTexture.sample(PositionTextureSampler, _136, level(0.0));
    float4 _148 = AttributesTexture.sample(AttributesTextureSampler, _136, level(0.0));
    float _149 = _140.w;
    float3 _161 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _136, level(0.0)).xyz;
    float3 _163 = normalize(_161 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _180 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _149)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _183 = (_148.x < 0.5) ? 0.0 : (-0.5);
    float _186 = (_148.y < 0.5) ? 0.0 : (-0.5);
    float2 _205 = ((((_148.xy + float2(_183, _186)) * float2(2.0)) * (_180.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_161), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_149, 1.0));
    float2 _210 = _103;
    _210.x = (_183 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _215 = _210;
    _215.y = (_186 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _216 = _180.z;
    float _218 = _216 - fract(_216);
    float2 _231 = (float2(mod(_218, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_218 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _215) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _266 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _140.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _140.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _140.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _269 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _278 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _269), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _286 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _269), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _287 = View.View_TranslatedWorldCameraOrigin - _266;
    float _288 = dot(_287, _287);
    float3 _292 = _287 / float3(sqrt(fast::max(_288, 0.00999999977648258209228515625)));
    float3 _362;
    float3 _363;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _350 = cross(_292, float3(0.0, 0.0, 1.0));
        float3 _355 = _350 / float3(sqrt(fast::max(dot(_350, _350), 0.00999999977648258209228515625)));
        float3 _357 = float3(fast::clamp((_288 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _362 = normalize(mix(_278, _355, _357));
        _363 = normalize(mix(_286, cross(_292, _355), _357));
    }
    else
    {
        float3 _341;
        float3 _342;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _334 = cross(_292, _163);
            _341 = _334 / float3(sqrt(fast::max(dot(_334, _334), 0.00999999977648258209228515625)));
            _342 = -_163;
        }
        else
        {
            float3 _332;
            float3 _333;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _325 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _292);
                _332 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _333 = -(_325 / float3(sqrt(fast::max(dot(_325, _325), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _323;
                float3 _324;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _316 = cross(_292, float3(0.0, 0.0, 1.0));
                    float3 _321 = _316 / float3(sqrt(fast::max(dot(_316, _316), 0.00999999977648258209228515625)));
                    _323 = _321;
                    _324 = cross(_292, _321);
                }
                else
                {
                    _323 = _278;
                    _324 = _286;
                }
                _332 = _323;
                _333 = _324;
            }
            _341 = _332;
            _342 = _333;
        }
        _362 = _341;
        _363 = _342;
    }
    float _366 = ((_148.z + ((_148.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _149)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _367 = sin(_366);
    float _368 = cos(_366);
    float3 _371 = (_363 * _367) + (_362 * _368);
    float3 _374 = (_363 * _368) - (_362 * _367);
    float3x3 _406 = _102;
    _406[0] = _371;
    float3x3 _407 = _406;
    _407[1] = _374;
    float3 _409 = normalize(cross(_371, _374));
    float3x3 _410 = _407;
    _410[2] = _409;
    spvUnsafeArray<float4, 1> _423 = { float4(_231.x, _231.y, float4(0.0).z, float4(0.0).w) };
    float4 _424 = float4(_266 + ((_371 * (_205.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_374 * (_205.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _426 = View.View_TranslatedWorldToClip * _424;
    float4 _435 = _426;
    _435.z = _426.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _426.w) : 0.0);
    out.gl_Position = _435;
    out.out_var_TEXCOORD6 = _426;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _424;
    out_var_TEXCOORD0 = _423;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_135.x + 10.0) * (_135.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_371, 0.0);
    out.out_var_TANGENTZ = float4(_409, float(int(sign(determinant(_410)))));
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

