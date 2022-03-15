

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
    char _m0_pad[976];
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m4_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m5_pad[16];
    float3 View_PreViewTranslation;
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
    char _m4_pad[16];
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m9_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
    uint LayerId;
};

struct MainForGS_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainForGS_out Main_00002b8c_0f6db6cc(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainForGS_out out = {};
    uint _111 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _112 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _113 = _111 + _112;
    uint _116 = _Globals.ParticleIndicesOffset + _113;
    float4 _118 = ParticleIndices.read(uint(_116));
    float2 _119 = _118.xy;
    float4 _123 = PositionTexture.sample(PositionTextureSampler, _119, level(0.0));
    float4 _127 = VelocityTexture.sample(VelocityTextureSampler, _119, level(0.0));
    float4 _131 = AttributesTexture.sample(AttributesTextureSampler, _119, level(0.0));
    float _132 = _123.w;
    float _133 = step(_132, 1.0);
    float3 _134 = _127.xyz;
    float3x3 _143 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _144 = _143 * _134;
    float3 _146 = normalize(_144 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _147 = length(_144);
    float2 _152 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _132;
    float2 _153 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _152;
    float4 _157 = CurveTexture.sample(CurveTextureSampler, _153, level(0.0));
    float4 _160 = _157 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _163 = _160 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _164 = _131.x;
    bool _165 = _164 < 0.5;
    float _166 = _165 ? 0.0 : (-0.5);
    float _167 = _131.y;
    bool _168 = _167 < 0.5;
    float _169 = _168 ? 0.0 : (-0.5);
    float2 _170 = float2(_166, _169);
    float2 _171 = _131.xy;
    float2 _172 = _171 + _170;
    float2 _173 = _172 * float2(2.0);
    float2 _174 = _163.xy;
    float2 _177 = _174 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _181 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _147;
    float2 _182 = fast::max(_181, float2(1.0));
    float2 _184 = fast::min(_182, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _185 = _173 * _177;
    float2 _186 = _185 * _184;
    float2 _187 = float2(_133);
    float2 _188 = _186 * _187;
    float _189 = _131.w;
    float _192 = _189 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _193 = _131.z;
    float _194 = _192 * _132;
    float _195 = _193 + _194;
    float _196 = _195 * 6.283185482025146484375;
    float3 _200 = _123.xxx;
    float3 _201 = Primitive.Primitive_LocalToWorld[0u].xyz * _200;
    float3 _205 = _123.yyy;
    float3 _206 = Primitive.Primitive_LocalToWorld[1u].xyz * _205;
    float3 _207 = _201 + _206;
    float3 _211 = _123.zzz;
    float3 _212 = Primitive.Primitive_LocalToWorld[2u].xyz * _211;
    float3 _213 = _207 + _212;
    float3 _217 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _218 = _213 + _217;
    float _219 = _218.x;
    float _220 = _218.y;
    float _221 = _218.z;
    float4 _222 = float4(_219, _220, _221, 1.0);
    float3 _223 = _222.xyz;
    float3 _226 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _235 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _226), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _243 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _226), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _244 = View.View_TranslatedWorldCameraOrigin - _223;
    float _245 = dot(_244, _244);
    float3 _249 = _244 / float3(sqrt(fast::max(_245, 0.00999999977648258209228515625)));
    float3 _319;
    float3 _320;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _263 = cross(_249, float3(0.0, 0.0, 1.0));
        float3 _268 = _263 / float3(sqrt(fast::max(dot(_263, _263), 0.00999999977648258209228515625)));
        float3 _270 = float3(fast::clamp((_245 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _319 = normalize(mix(_235, _268, _270));
        _320 = normalize(mix(_243, cross(_249, _268), _270));
    }
    else
    {
        float3 _317;
        float3 _318;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _281 = cross(_249, _146);
            _317 = _281 / float3(sqrt(fast::max(dot(_281, _281), 0.00999999977648258209228515625)));
            _318 = -_146;
        }
        else
        {
            float3 _315;
            float3 _316;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _294 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _249);
                _315 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _316 = -(_294 / float3(sqrt(fast::max(dot(_294, _294), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _313;
                float3 _314;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _306 = cross(_249, float3(0.0, 0.0, 1.0));
                    float3 _311 = _306 / float3(sqrt(fast::max(dot(_306, _306), 0.00999999977648258209228515625)));
                    _313 = _311;
                    _314 = cross(_249, _311);
                }
                else
                {
                    _313 = _235;
                    _314 = _243;
                }
                _315 = _313;
                _316 = _314;
            }
            _317 = _315;
            _318 = _316;
        }
        _319 = _317;
        _320 = _318;
    }
    float _323 = _196 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _324 = sin(_323);
    float _325 = cos(_323);
    float3 _326 = _320 * _324;
    float3 _327 = _319 * _325;
    float3 _328 = _326 + _327;
    float3 _329 = _320 * _325;
    float3 _330 = _319 * _324;
    float3 _331 = _329 - _330;
    float _332 = _188.x;
    float _336 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _337 = _332 * _336;
    float3 _338 = _328 * _337;
    float _339 = _188.y;
    float _343 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _344 = _339 * _343;
    float3 _345 = _331 * _344;
    float3 _346 = _338 + _345;
    float3 _347 = _223 + _346;
    float _348 = _347.x;
    float _349 = _347.y;
    float _350 = _347.z;
    float4 _351 = float4(_348, _349, _350, 1.0);
    float4 _354 = float4(_351.x, _351.y, _351.z, _351.w);
    float4 _359 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _354;
    out.out_var_TEXCOORD6 = _354;
    out.out_var_TEXCOORD8 = normalize(cross(_328, _331));
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _359;
    return out;
}

