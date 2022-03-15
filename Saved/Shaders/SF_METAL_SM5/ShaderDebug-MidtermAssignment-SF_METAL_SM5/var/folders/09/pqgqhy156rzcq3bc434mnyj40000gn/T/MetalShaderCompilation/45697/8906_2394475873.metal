

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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

constant float3x3 _89 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_000022ca_8eb8cd61(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    float2 _121 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _125 = PositionTexture.sample(PositionTextureSampler, _121, level(0.0));
    float4 _133 = AttributesTexture.sample(AttributesTextureSampler, _121, level(0.0));
    float _134 = _125.w;
    float3 _146 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _121, level(0.0)).xyz;
    float3 _148 = normalize(_146 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float2 _190 = ((((_133.xy + float2((_133.x < 0.5) ? 0.0 : (-0.5), (_133.y < 0.5) ? 0.0 : (-0.5))) * float2(2.0)) * (((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _134)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias).xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_146), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_134, 1.0));
    float3 _225 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _125.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _125.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _125.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _228 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _237 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _228), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _245 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _228), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _246 = View.View_TranslatedWorldCameraOrigin - _225;
    float _247 = dot(_246, _246);
    float3 _251 = _246 / float3(sqrt(fast::max(_247, 0.00999999977648258209228515625)));
    float3 _321;
    float3 _322;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _265 = cross(_251, float3(0.0, 0.0, 1.0));
        float3 _270 = _265 / float3(sqrt(fast::max(dot(_265, _265), 0.00999999977648258209228515625)));
        float3 _272 = float3(fast::clamp((_247 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _321 = normalize(mix(_237, _270, _272));
        _322 = normalize(mix(_245, cross(_251, _270), _272));
    }
    else
    {
        float3 _319;
        float3 _320;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _283 = cross(_251, _148);
            _319 = _283 / float3(sqrt(fast::max(dot(_283, _283), 0.00999999977648258209228515625)));
            _320 = -_148;
        }
        else
        {
            float3 _317;
            float3 _318;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _296 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _251);
                _317 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _318 = -(_296 / float3(sqrt(fast::max(dot(_296, _296), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _315;
                float3 _316;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _308 = cross(_251, float3(0.0, 0.0, 1.0));
                    float3 _313 = _308 / float3(sqrt(fast::max(dot(_308, _308), 0.00999999977648258209228515625)));
                    _315 = _313;
                    _316 = cross(_251, _313);
                }
                else
                {
                    _315 = _237;
                    _316 = _245;
                }
                _317 = _315;
                _318 = _316;
            }
            _319 = _317;
            _320 = _318;
        }
        _321 = _319;
        _322 = _320;
    }
    float _325 = ((_133.z + ((_133.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _134)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _326 = sin(_325);
    float _327 = cos(_325);
    float3 _330 = (_322 * _326) + (_321 * _327);
    float3 _333 = (_322 * _327) - (_321 * _326);
    float3x3 _353 = _89;
    _353[0] = _330;
    float3x3 _354 = _353;
    _354[1] = _333;
    float3 _356 = normalize(cross(_330, _333));
    float3x3 _357 = _354;
    _357[2] = _356;
    float4 _370 = float4(_225 + ((_330 * (_190.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_333 * (_190.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _372 = View.View_TranslatedWorldToClip * _370;
    float4 _381 = _372;
    _381.z = _372.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _372.w) : 0.0);
    out.gl_Position = _381;
    out.out_var_TEXCOORD6 = _372;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _370;
    out.out_var_TANGENTX = float4(_330, 0.0);
    out.out_var_TANGENTZ = float4(_356, float(int(sign(determinant(_357)))));
    return out;
}

