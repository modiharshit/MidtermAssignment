

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

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex Main_out Main_0000309f_2861f152(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _121 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _122 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _123 = _121 + _122;
    uint _126 = _Globals.ParticleIndicesOffset + _123;
    float4 _128 = ParticleIndices.read(uint(_126));
    float2 _129 = _128.xy;
    float4 _133 = PositionTexture.sample(PositionTextureSampler, _129, level(0.0));
    float4 _137 = VelocityTexture.sample(VelocityTextureSampler, _129, level(0.0));
    float4 _141 = AttributesTexture.sample(AttributesTextureSampler, _129, level(0.0));
    float _142 = _133.w;
    float _143 = step(_142, 1.0);
    float3 _144 = _137.xyz;
    float3x3 _153 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _154 = _153 * _144;
    float3 _156 = normalize(_154 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _157 = length(_154);
    float2 _162 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _142;
    float2 _163 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _162;
    float4 _167 = CurveTexture.sample(CurveTextureSampler, _163, level(0.0));
    float4 _170 = _167 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _173 = _170 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _174 = _141.x;
    bool _175 = _174 < 0.5;
    float _176 = _175 ? 0.0 : (-0.5);
    float _177 = _141.y;
    bool _178 = _177 < 0.5;
    float _179 = _178 ? 0.0 : (-0.5);
    float2 _180 = float2(_176, _179);
    float2 _181 = _141.xy;
    float2 _182 = _181 + _180;
    float2 _183 = _182 * float2(2.0);
    float2 _184 = _173.xy;
    float2 _187 = _184 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _191 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _157;
    float2 _192 = fast::max(_191, float2(1.0));
    float2 _194 = fast::min(_192, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _195 = _183 * _187;
    float2 _196 = _195 * _194;
    float2 _197 = float2(_143);
    float2 _198 = _196 * _197;
    float2 _203 = _100;
    _203.x = (_176 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _208 = _203;
    _208.y = (_179 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _209 = _173.z;
    float _211 = _209 - fract(_209);
    float2 _224 = (float2(mod(_211, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_211 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _208) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _225 = _141.w;
    float _228 = _225 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _229 = _141.z;
    float _230 = _228 * _142;
    float _231 = _229 + _230;
    float _232 = _231 * 6.283185482025146484375;
    float3 _236 = _133.xxx;
    float3 _237 = Primitive.Primitive_LocalToWorld[0u].xyz * _236;
    float3 _241 = _133.yyy;
    float3 _242 = Primitive.Primitive_LocalToWorld[1u].xyz * _241;
    float3 _243 = _237 + _242;
    float3 _247 = _133.zzz;
    float3 _248 = Primitive.Primitive_LocalToWorld[2u].xyz * _247;
    float3 _249 = _243 + _248;
    float3 _253 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _254 = _249 + _253;
    float _255 = _254.x;
    float _256 = _254.y;
    float _257 = _254.z;
    float4 _258 = float4(_255, _256, _257, 1.0);
    float3 _259 = _258.xyz;
    float3 _262 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _271 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _262), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _279 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _262), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _280 = View.View_TranslatedWorldCameraOrigin - _259;
    float _281 = dot(_280, _280);
    float3 _285 = _280 / float3(sqrt(fast::max(_281, 0.00999999977648258209228515625)));
    float3 _355;
    float3 _356;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _343 = cross(_285, float3(0.0, 0.0, 1.0));
        float3 _348 = _343 / float3(sqrt(fast::max(dot(_343, _343), 0.00999999977648258209228515625)));
        float3 _350 = float3(fast::clamp((_281 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _355 = normalize(mix(_271, _348, _350));
        _356 = normalize(mix(_279, cross(_285, _348), _350));
    }
    else
    {
        float3 _334;
        float3 _335;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _327 = cross(_285, _156);
            _334 = _327 / float3(sqrt(fast::max(dot(_327, _327), 0.00999999977648258209228515625)));
            _335 = -_156;
        }
        else
        {
            float3 _325;
            float3 _326;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _318 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _285);
                _325 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _326 = -(_318 / float3(sqrt(fast::max(dot(_318, _318), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _316;
                float3 _317;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _309 = cross(_285, float3(0.0, 0.0, 1.0));
                    float3 _314 = _309 / float3(sqrt(fast::max(dot(_309, _309), 0.00999999977648258209228515625)));
                    _316 = _314;
                    _317 = cross(_285, _314);
                }
                else
                {
                    _316 = _271;
                    _317 = _279;
                }
                _325 = _316;
                _326 = _317;
            }
            _334 = _325;
            _335 = _326;
        }
        _355 = _334;
        _356 = _335;
    }
    float _359 = _232 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _360 = sin(_359);
    float _361 = cos(_359);
    float3 _362 = _356 * _360;
    float3 _363 = _355 * _361;
    float3 _364 = _362 + _363;
    float3 _365 = _356 * _361;
    float3 _366 = _355 * _360;
    float3 _367 = _365 - _366;
    float _368 = _198.x;
    float _371 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _372 = _368 * _371;
    float3 _373 = _364 * _372;
    float _374 = _198.y;
    float _377 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _378 = _374 * _377;
    float3 _379 = _367 * _378;
    float3 _380 = _373 + _379;
    float3 _381 = _259 + _380;
    float _395 = _381.x;
    float _396 = _381.y;
    float _397 = _381.z;
    float4 _398 = float4(_395, _396, _397, 1.0);
    float4 _399 = float4(_398.x, _398.y, _398.z, _398.w);
    float4 _402 = View.View_TranslatedWorldToClip * _399;
    float3x3 _404 = _99;
    _404[0] = _364;
    float3x3 _405 = _404;
    _405[1] = _367;
    float3 _407 = normalize(cross(_364, _367));
    float3x3 _408 = _405;
    _408[2] = _407;
    spvUnsafeArray<float4, 1> _421 = { float4(_224.x, _224.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _421;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_128.x + 10.0) * (_128.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_364, 0.0);
    out.out_var_TANGENTZ = float4(_407, float(int(sign(determinant(_408)))));
    out.out_var_TEXCOORD6 = _399;
    out.gl_Position = _402;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

