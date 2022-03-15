

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
    char _m7_pad[1264];
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

constant float3x3 _99 = {};
constant float2 _100 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex MainVertexShader_out Main_0000310c_d9676035(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _123 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _124 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _125 = _123 + _124;
    uint _128 = _Globals.ParticleIndicesOffset + _125;
    float4 _130 = ParticleIndices.read(uint(_128));
    float2 _131 = _130.xy;
    float4 _135 = PositionTexture.sample(PositionTextureSampler, _131, level(0.0));
    float4 _139 = VelocityTexture.sample(VelocityTextureSampler, _131, level(0.0));
    float4 _143 = AttributesTexture.sample(AttributesTextureSampler, _131, level(0.0));
    float _144 = _135.w;
    float _145 = step(_144, 1.0);
    float3 _146 = _139.xyz;
    float3x3 _155 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _156 = _155 * _146;
    float3 _158 = normalize(_156 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _159 = length(_156);
    float2 _164 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _144;
    float2 _165 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _164;
    float4 _169 = CurveTexture.sample(CurveTextureSampler, _165, level(0.0));
    float4 _172 = _169 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _175 = _172 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _176 = _143.x;
    bool _177 = _176 < 0.5;
    float _178 = _177 ? 0.0 : (-0.5);
    float _179 = _143.y;
    bool _180 = _179 < 0.5;
    float _181 = _180 ? 0.0 : (-0.5);
    float2 _182 = float2(_178, _181);
    float2 _183 = _143.xy;
    float2 _184 = _183 + _182;
    float2 _185 = _184 * float2(2.0);
    float2 _186 = _175.xy;
    float2 _189 = _186 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _193 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _159;
    float2 _194 = fast::max(_193, float2(1.0));
    float2 _196 = fast::min(_194, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _197 = _185 * _189;
    float2 _198 = _197 * _196;
    float2 _199 = float2(_145);
    float2 _200 = _198 * _199;
    float2 _205 = _100;
    _205.x = (_178 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _210 = _205;
    _210.y = (_181 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _211 = _175.z;
    float _213 = _211 - fract(_211);
    float2 _226 = (float2(mod(_213, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_213 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _210) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _227 = _143.w;
    float _230 = _227 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _231 = _143.z;
    float _232 = _230 * _144;
    float _233 = _231 + _232;
    float _234 = _233 * 6.283185482025146484375;
    float3 _238 = _135.xxx;
    float3 _239 = Primitive.Primitive_LocalToWorld[0u].xyz * _238;
    float3 _243 = _135.yyy;
    float3 _244 = Primitive.Primitive_LocalToWorld[1u].xyz * _243;
    float3 _245 = _239 + _244;
    float3 _249 = _135.zzz;
    float3 _250 = Primitive.Primitive_LocalToWorld[2u].xyz * _249;
    float3 _251 = _245 + _250;
    float3 _255 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _256 = _251 + _255;
    float _257 = _256.x;
    float _258 = _256.y;
    float _259 = _256.z;
    float4 _260 = float4(_257, _258, _259, 1.0);
    float3 _261 = _260.xyz;
    float3 _264 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _273 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _264), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _281 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _264), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _282 = View.View_TranslatedWorldCameraOrigin - _261;
    float _283 = dot(_282, _282);
    float3 _287 = _282 / float3(sqrt(fast::max(_283, 0.00999999977648258209228515625)));
    float3 _357;
    float3 _358;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _345 = cross(_287, float3(0.0, 0.0, 1.0));
        float3 _350 = _345 / float3(sqrt(fast::max(dot(_345, _345), 0.00999999977648258209228515625)));
        float3 _352 = float3(fast::clamp((_283 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _357 = normalize(mix(_273, _350, _352));
        _358 = normalize(mix(_281, cross(_287, _350), _352));
    }
    else
    {
        float3 _336;
        float3 _337;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _329 = cross(_287, _158);
            _336 = _329 / float3(sqrt(fast::max(dot(_329, _329), 0.00999999977648258209228515625)));
            _337 = -_158;
        }
        else
        {
            float3 _327;
            float3 _328;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _320 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _287);
                _327 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _328 = -(_320 / float3(sqrt(fast::max(dot(_320, _320), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _318;
                float3 _319;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _311 = cross(_287, float3(0.0, 0.0, 1.0));
                    float3 _316 = _311 / float3(sqrt(fast::max(dot(_311, _311), 0.00999999977648258209228515625)));
                    _318 = _316;
                    _319 = cross(_287, _316);
                }
                else
                {
                    _318 = _273;
                    _319 = _281;
                }
                _327 = _318;
                _328 = _319;
            }
            _336 = _327;
            _337 = _328;
        }
        _357 = _336;
        _358 = _337;
    }
    float _361 = _234 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _362 = sin(_361);
    float _363 = cos(_361);
    float3 _364 = _358 * _362;
    float3 _365 = _357 * _363;
    float3 _366 = _364 + _365;
    float3 _367 = _358 * _363;
    float3 _368 = _357 * _362;
    float3 _369 = _367 - _368;
    float _370 = _200.x;
    float _373 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _374 = _370 * _373;
    float3 _375 = _366 * _374;
    float _376 = _200.y;
    float _379 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _380 = _376 * _379;
    float3 _381 = _369 * _380;
    float3 _382 = _375 + _381;
    float3 _383 = _261 + _382;
    float _397 = _383.x;
    float _398 = _383.y;
    float _399 = _383.z;
    float4 _400 = float4(_397, _398, _399, 1.0);
    float4 _401 = float4(_400.x, _400.y, _400.z, _400.w);
    float4 _402 = View.View_TranslatedWorldToClip * _401;
    float3x3 _404 = _99;
    _404[0] = _366;
    float3x3 _405 = _404;
    _405[1] = _369;
    float3 _407 = normalize(cross(_366, _369));
    float3x3 _408 = _405;
    _408[2] = _407;
    spvUnsafeArray<float4, 1> _421 = { float4(_226.x, _226.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _421;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_130.x + 10.0) * (_130.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_366, 0.0);
    out.out_var_TANGENTZ = float4(_407, float(int(sign(determinant(_408)))));
    out.out_var_TEXCOORD6 = _401;
    out.gl_Position = _402;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

