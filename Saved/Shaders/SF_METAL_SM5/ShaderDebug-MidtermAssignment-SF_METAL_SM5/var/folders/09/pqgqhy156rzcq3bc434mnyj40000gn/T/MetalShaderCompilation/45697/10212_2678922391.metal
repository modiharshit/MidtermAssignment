

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

constant float3x3 _86 = {};

struct MainVertexShader_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainVertexShader_out Main_000027e4_9fad1c97(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVertexShader_out out = {};
    uint _108 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _109 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _110 = _108 + _109;
    uint _113 = _Globals.ParticleIndicesOffset + _110;
    float4 _115 = ParticleIndices.read(uint(_113));
    float2 _116 = _115.xy;
    float4 _120 = PositionTexture.sample(PositionTextureSampler, _116, level(0.0));
    float4 _124 = VelocityTexture.sample(VelocityTextureSampler, _116, level(0.0));
    float4 _128 = AttributesTexture.sample(AttributesTextureSampler, _116, level(0.0));
    float _129 = _120.w;
    float _130 = step(_129, 1.0);
    float3 _131 = _124.xyz;
    float3x3 _140 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _141 = _140 * _131;
    float3 _143 = normalize(_141 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _144 = length(_141);
    float2 _149 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _129;
    float2 _150 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _149;
    float4 _154 = CurveTexture.sample(CurveTextureSampler, _150, level(0.0));
    float4 _157 = _154 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _160 = _157 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _161 = _128.x;
    bool _162 = _161 < 0.5;
    float _163 = _162 ? 0.0 : (-0.5);
    float _164 = _128.y;
    bool _165 = _164 < 0.5;
    float _166 = _165 ? 0.0 : (-0.5);
    float2 _167 = float2(_163, _166);
    float2 _168 = _128.xy;
    float2 _169 = _168 + _167;
    float2 _170 = _169 * float2(2.0);
    float2 _171 = _160.xy;
    float2 _174 = _171 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _178 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _144;
    float2 _179 = fast::max(_178, float2(1.0));
    float2 _181 = fast::min(_179, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _182 = _170 * _174;
    float2 _183 = _182 * _181;
    float2 _184 = float2(_130);
    float2 _185 = _183 * _184;
    float _186 = _128.w;
    float _189 = _186 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _190 = _128.z;
    float _191 = _189 * _129;
    float _192 = _190 + _191;
    float _193 = _192 * 6.283185482025146484375;
    float3 _197 = _120.xxx;
    float3 _198 = Primitive.Primitive_LocalToWorld[0u].xyz * _197;
    float3 _202 = _120.yyy;
    float3 _203 = Primitive.Primitive_LocalToWorld[1u].xyz * _202;
    float3 _204 = _198 + _203;
    float3 _208 = _120.zzz;
    float3 _209 = Primitive.Primitive_LocalToWorld[2u].xyz * _208;
    float3 _210 = _204 + _209;
    float3 _214 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _215 = _210 + _214;
    float _216 = _215.x;
    float _217 = _215.y;
    float _218 = _215.z;
    float4 _219 = float4(_216, _217, _218, 1.0);
    float3 _220 = _219.xyz;
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
    float _320 = _193 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _321 = sin(_320);
    float _322 = cos(_320);
    float3 _323 = _317 * _321;
    float3 _324 = _316 * _322;
    float3 _325 = _323 + _324;
    float3 _326 = _317 * _322;
    float3 _327 = _316 * _321;
    float3 _328 = _326 - _327;
    float _329 = _185.x;
    float _333 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _334 = _329 * _333;
    float3 _335 = _325 * _334;
    float _336 = _185.y;
    float _340 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _341 = _336 * _340;
    float3 _342 = _328 * _341;
    float3 _343 = _335 + _342;
    float3 _344 = _220 + _343;
    float _345 = _344.x;
    float _346 = _344.y;
    float _347 = _344.z;
    float4 _348 = float4(_345, _346, _347, 1.0);
    float4 _349 = float4(_348.x, _348.y, _348.z, _348.w);
    float4 _350 = View.View_TranslatedWorldToClip * _349;
    float3x3 _351 = _86;
    _351[0] = _325;
    float3x3 _352 = _351;
    _352[1] = _328;
    float3 _354 = normalize(cross(_325, _328));
    float3x3 _355 = _352;
    _355[2] = _354;
    out.out_var_TANGENTX = float4(_325, 0.0);
    out.out_var_TANGENTZ = float4(_354, float(int(sign(determinant(_355)))));
    out.out_var_TEXCOORD6 = _349;
    out.gl_Position = _350;
    return out;
}

