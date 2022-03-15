

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
    float out_var_TEXCOORD8 [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002433_8c8b51eb(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float2 _117 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _121 = PositionTexture.sample(PositionTextureSampler, _117, level(0.0));
    float4 _129 = AttributesTexture.sample(AttributesTextureSampler, _117, level(0.0));
    float _130 = _121.w;
    float3 _142 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _117, level(0.0)).xyz;
    float3 _144 = normalize(_142 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float2 _186 = ((((_129.xy + float2((_129.x < 0.5) ? 0.0 : (-0.5), (_129.y < 0.5) ? 0.0 : (-0.5))) * float2(2.0)) * (((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _130)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias).xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_142), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_130, 1.0));
    float3 _221 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _121.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _121.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _121.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _224 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _233 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _224), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _241 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _224), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _242 = View.View_TranslatedWorldCameraOrigin - _221;
    float _243 = dot(_242, _242);
    float3 _247 = _242 / float3(sqrt(fast::max(_243, 0.00999999977648258209228515625)));
    float3 _317;
    float3 _318;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _261 = cross(_247, float3(0.0, 0.0, 1.0));
        float3 _266 = _261 / float3(sqrt(fast::max(dot(_261, _261), 0.00999999977648258209228515625)));
        float3 _268 = float3(fast::clamp((_243 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _317 = normalize(mix(_233, _266, _268));
        _318 = normalize(mix(_241, cross(_247, _266), _268));
    }
    else
    {
        float3 _315;
        float3 _316;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _279 = cross(_247, _144);
            _315 = _279 / float3(sqrt(fast::max(dot(_279, _279), 0.00999999977648258209228515625)));
            _316 = -_144;
        }
        else
        {
            float3 _313;
            float3 _314;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _292 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _247);
                _313 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _314 = -(_292 / float3(sqrt(fast::max(dot(_292, _292), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _311;
                float3 _312;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _304 = cross(_247, float3(0.0, 0.0, 1.0));
                    float3 _309 = _304 / float3(sqrt(fast::max(dot(_304, _304), 0.00999999977648258209228515625)));
                    _311 = _309;
                    _312 = cross(_247, _309);
                }
                else
                {
                    _311 = _233;
                    _312 = _241;
                }
                _313 = _311;
                _314 = _312;
            }
            _315 = _313;
            _316 = _314;
        }
        _317 = _315;
        _318 = _316;
    }
    float _321 = ((_129.z + ((_129.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _130)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _322 = sin(_321);
    float _323 = cos(_321);
    float3 _326 = (_318 * _322) + (_317 * _323);
    float3 _329 = (_318 * _323) - (_317 * _322);
    float4 _349 = float4(_221 + ((_326 * (_186.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_329 * (_186.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _357 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_349.x, _349.y, _349.z, _349.w);
    float4 _368;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_357.z < 0.0))
    {
        float4 _366 = _357;
        _366.z = 9.9999999747524270787835121154785e-07;
        float4 _367 = _366;
        _367.w = 1.0;
        _368 = _367;
    }
    else
    {
        _368 = _357;
    }
    float _374 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), normalize(cross(_326, _329))));
    out.out_var_TEXCOORD6 = _368.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_374) > 0.0) ? (sqrt(fast::clamp(1.0 - (_374 * _374), 0.0, 1.0)) / _374) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _368;
    return out;
}

