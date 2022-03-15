

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

constant float3x3 _95 = {};

struct Main_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002636_450c8771(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    float2 _122 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _126 = PositionTexture.sample(PositionTextureSampler, _122, level(0.0));
    float4 _134 = AttributesTexture.sample(AttributesTextureSampler, _122, level(0.0));
    float _135 = _126.w;
    float3 _147 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _122, level(0.0)).xyz;
    float3 _149 = normalize(_147 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float2 _191 = ((((_134.xy + float2((_134.x < 0.5) ? 0.0 : (-0.5), (_134.y < 0.5) ? 0.0 : (-0.5))) * float2(2.0)) * (((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _135)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias).xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_147), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_135, 1.0));
    float3 _226 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _126.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _126.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _126.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _229 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _238 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _229), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _246 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _229), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _247 = View.View_TranslatedWorldCameraOrigin - _226;
    float _248 = dot(_247, _247);
    float3 _252 = _247 / float3(sqrt(fast::max(_248, 0.00999999977648258209228515625)));
    float3 _322;
    float3 _323;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _266 = cross(_252, float3(0.0, 0.0, 1.0));
        float3 _271 = _266 / float3(sqrt(fast::max(dot(_266, _266), 0.00999999977648258209228515625)));
        float3 _273 = float3(fast::clamp((_248 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _322 = normalize(mix(_238, _271, _273));
        _323 = normalize(mix(_246, cross(_252, _271), _273));
    }
    else
    {
        float3 _320;
        float3 _321;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _284 = cross(_252, _149);
            _320 = _284 / float3(sqrt(fast::max(dot(_284, _284), 0.00999999977648258209228515625)));
            _321 = -_149;
        }
        else
        {
            float3 _318;
            float3 _319;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _297 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _252);
                _318 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _319 = -(_297 / float3(sqrt(fast::max(dot(_297, _297), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _316;
                float3 _317;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _309 = cross(_252, float3(0.0, 0.0, 1.0));
                    float3 _314 = _309 / float3(sqrt(fast::max(dot(_309, _309), 0.00999999977648258209228515625)));
                    _316 = _314;
                    _317 = cross(_252, _314);
                }
                else
                {
                    _316 = _238;
                    _317 = _246;
                }
                _318 = _316;
                _319 = _317;
            }
            _320 = _318;
            _321 = _319;
        }
        _322 = _320;
        _323 = _321;
    }
    float _326 = ((_134.z + ((_134.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _135)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _327 = sin(_326);
    float _328 = cos(_326);
    float3 _331 = (_323 * _327) + (_322 * _328);
    float3 _334 = (_323 * _328) - (_322 * _327);
    float4 _354 = float4(_226 + ((_331 * (_191.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_334 * (_191.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float3x3 _355 = _95;
    _355[0] = _331;
    float3x3 _356 = _355;
    _356[1] = _334;
    float3 _358 = normalize(cross(_331, _334));
    float3x3 _359 = _356;
    _359[2] = _358;
    float4 _365 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_354.x, _354.y, _354.z, _354.w);
    float4 _376;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_365.z < 0.0))
    {
        float4 _374 = _365;
        _374.z = 9.9999999747524270787835121154785e-07;
        float4 _375 = _374;
        _375.w = 1.0;
        _376 = _375;
    }
    else
    {
        _376 = _365;
    }
    float _382 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _358));
    float4 _407 = _376;
    _407.z = ((_376.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_382) > 0.0) ? (sqrt(fast::clamp(1.0 - (_382 * _382), 0.0, 1.0)) / _382) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _376.w;
    out.out_var_TANGENTX = float4(_331, 0.0);
    out.out_var_TANGENTZ = float4(_358, float(int(sign(determinant(_359)))));
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _354.xyz;
    out.gl_Position = _407;
    return out;
}

