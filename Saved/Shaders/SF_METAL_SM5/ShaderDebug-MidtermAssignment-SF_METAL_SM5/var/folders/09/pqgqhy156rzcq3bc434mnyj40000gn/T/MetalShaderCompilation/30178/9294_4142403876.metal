

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
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
};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000244e_f6e81124(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float2 _116 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _120 = PositionTexture.sample(PositionTextureSampler, _116, level(0.0));
    float4 _128 = AttributesTexture.sample(AttributesTextureSampler, _116, level(0.0));
    float _129 = _120.w;
    float3 _141 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _116, level(0.0)).xyz;
    float3 _143 = normalize(_141 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float2 _185 = ((((_128.xy + float2((_128.x < 0.5) ? 0.0 : (-0.5), (_128.y < 0.5) ? 0.0 : (-0.5))) * float2(2.0)) * (((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _129)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias).xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_141), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_129, 1.0));
    float3 _220 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _120.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _120.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _120.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _223 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _232 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _223), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _240 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _223), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _241 = View.View_TranslatedWorldCameraOrigin - _220;
    float _242 = dot(_241, _241);
    float3 _246 = _241 / float3(sqrt(fast::max(_242, 0.00999999977648258209228515625)));
    float3 _316;
    float3 _317;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _260 = cross(_246, float3(0.0, 0.0, 1.0));
        float3 _265 = _260 / float3(sqrt(fast::max(dot(_260, _260), 0.00999999977648258209228515625)));
        float3 _267 = float3(fast::clamp((_242 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _316 = normalize(mix(_232, _265, _267));
        _317 = normalize(mix(_240, cross(_246, _265), _267));
    }
    else
    {
        float3 _314;
        float3 _315;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _278 = cross(_246, _143);
            _314 = _278 / float3(sqrt(fast::max(dot(_278, _278), 0.00999999977648258209228515625)));
            _315 = -_143;
        }
        else
        {
            float3 _312;
            float3 _313;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _291 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _246);
                _312 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _313 = -(_291 / float3(sqrt(fast::max(dot(_291, _291), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _310;
                float3 _311;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _303 = cross(_246, float3(0.0, 0.0, 1.0));
                    float3 _308 = _303 / float3(sqrt(fast::max(dot(_303, _303), 0.00999999977648258209228515625)));
                    _310 = _308;
                    _311 = cross(_246, _308);
                }
                else
                {
                    _310 = _232;
                    _311 = _240;
                }
                _312 = _310;
                _313 = _311;
            }
            _314 = _312;
            _315 = _313;
        }
        _316 = _314;
        _317 = _315;
    }
    float _320 = ((_128.z + ((_128.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _129)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _321 = sin(_320);
    float _322 = cos(_320);
    float3 _325 = (_317 * _321) + (_316 * _322);
    float3 _328 = (_317 * _322) - (_316 * _321);
    float4 _348 = float4(_220 + ((_325 * (_185.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_328 * (_185.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _356 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_348.x, _348.y, _348.z, _348.w);
    float4 _367;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_356.z < 0.0))
    {
        float4 _365 = _356;
        _365.z = 9.9999999747524270787835121154785e-07;
        float4 _366 = _365;
        _366.w = 1.0;
        _367 = _366;
    }
    else
    {
        _367 = _356;
    }
    float _373 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), normalize(cross(_325, _328))));
    float4 _398 = _367;
    _398.z = ((_367.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_373) > 0.0) ? (sqrt(fast::clamp(1.0 - (_373 * _373), 0.0, 1.0)) / _373) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _367.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _398;
    return out;
}

