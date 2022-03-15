

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

constant float3x3 _96 = {};

struct Main_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_0000261b_a9fd805c(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float2 _123 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _127 = PositionTexture.sample(PositionTextureSampler, _123, level(0.0));
    float4 _135 = AttributesTexture.sample(AttributesTextureSampler, _123, level(0.0));
    float _136 = _127.w;
    float3 _148 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _123, level(0.0)).xyz;
    float3 _150 = normalize(_148 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float2 _192 = ((((_135.xy + float2((_135.x < 0.5) ? 0.0 : (-0.5), (_135.y < 0.5) ? 0.0 : (-0.5))) * float2(2.0)) * (((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _136)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias).xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_148), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_136, 1.0));
    float3 _227 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _127.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _127.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _127.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _230 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _239 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _230), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _247 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _230), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _248 = View.View_TranslatedWorldCameraOrigin - _227;
    float _249 = dot(_248, _248);
    float3 _253 = _248 / float3(sqrt(fast::max(_249, 0.00999999977648258209228515625)));
    float3 _323;
    float3 _324;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _267 = cross(_253, float3(0.0, 0.0, 1.0));
        float3 _272 = _267 / float3(sqrt(fast::max(dot(_267, _267), 0.00999999977648258209228515625)));
        float3 _274 = float3(fast::clamp((_249 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _323 = normalize(mix(_239, _272, _274));
        _324 = normalize(mix(_247, cross(_253, _272), _274));
    }
    else
    {
        float3 _321;
        float3 _322;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _285 = cross(_253, _150);
            _321 = _285 / float3(sqrt(fast::max(dot(_285, _285), 0.00999999977648258209228515625)));
            _322 = -_150;
        }
        else
        {
            float3 _319;
            float3 _320;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _298 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _253);
                _319 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _320 = -(_298 / float3(sqrt(fast::max(dot(_298, _298), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _317;
                float3 _318;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _310 = cross(_253, float3(0.0, 0.0, 1.0));
                    float3 _315 = _310 / float3(sqrt(fast::max(dot(_310, _310), 0.00999999977648258209228515625)));
                    _317 = _315;
                    _318 = cross(_253, _315);
                }
                else
                {
                    _317 = _239;
                    _318 = _247;
                }
                _319 = _317;
                _320 = _318;
            }
            _321 = _319;
            _322 = _320;
        }
        _323 = _321;
        _324 = _322;
    }
    float _327 = ((_135.z + ((_135.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _136)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _328 = sin(_327);
    float _329 = cos(_327);
    float3 _332 = (_324 * _328) + (_323 * _329);
    float3 _335 = (_324 * _329) - (_323 * _328);
    float4 _355 = float4(_227 + ((_332 * (_192.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_335 * (_192.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float3x3 _356 = _96;
    _356[0] = _332;
    float3x3 _357 = _356;
    _357[1] = _335;
    float3 _359 = normalize(cross(_332, _335));
    float3x3 _360 = _357;
    _360[2] = _359;
    float4 _366 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_355.x, _355.y, _355.z, _355.w);
    float4 _377;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_366.z < 0.0))
    {
        float4 _375 = _366;
        _375.z = 9.9999999747524270787835121154785e-07;
        float4 _376 = _375;
        _376.w = 1.0;
        _377 = _376;
    }
    else
    {
        _377 = _366;
    }
    float _383 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _359));
    out.out_var_TANGENTX = float4(_332, 0.0);
    out.out_var_TANGENTZ = float4(_359, float(int(sign(determinant(_360)))));
    out.out_var_TEXCOORD6 = _377.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_383) > 0.0) ? (sqrt(fast::clamp(1.0 - (_383 * _383), 0.0, 1.0)) / _383) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _355.xyz;
    out.gl_Position = _377;
    return out;
}

