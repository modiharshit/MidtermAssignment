

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

constant float3x3 _85 = {};

struct Main_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002738_d646aea3(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _107 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _108 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _109 = _107 + _108;
    uint _112 = _Globals.ParticleIndicesOffset + _109;
    float4 _114 = ParticleIndices.read(uint(_112));
    float2 _115 = _114.xy;
    float4 _119 = PositionTexture.sample(PositionTextureSampler, _115, level(0.0));
    float4 _123 = VelocityTexture.sample(VelocityTextureSampler, _115, level(0.0));
    float4 _127 = AttributesTexture.sample(AttributesTextureSampler, _115, level(0.0));
    float _128 = _119.w;
    float _129 = step(_128, 1.0);
    float3 _130 = _123.xyz;
    float3x3 _139 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _140 = _139 * _130;
    float3 _142 = normalize(_140 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _143 = length(_140);
    float2 _148 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _128;
    float2 _149 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _148;
    float4 _153 = CurveTexture.sample(CurveTextureSampler, _149, level(0.0));
    float4 _156 = _153 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _159 = _156 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _160 = _127.x;
    bool _161 = _160 < 0.5;
    float _162 = _161 ? 0.0 : (-0.5);
    float _163 = _127.y;
    bool _164 = _163 < 0.5;
    float _165 = _164 ? 0.0 : (-0.5);
    float2 _166 = float2(_162, _165);
    float2 _167 = _127.xy;
    float2 _168 = _167 + _166;
    float2 _169 = _168 * float2(2.0);
    float2 _170 = _159.xy;
    float2 _173 = _170 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _177 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _143;
    float2 _178 = fast::max(_177, float2(1.0));
    float2 _180 = fast::min(_178, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _181 = _169 * _173;
    float2 _182 = _181 * _180;
    float2 _183 = float2(_129);
    float2 _184 = _182 * _183;
    float _185 = _127.w;
    float _188 = _185 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _189 = _127.z;
    float _190 = _188 * _128;
    float _191 = _189 + _190;
    float _192 = _191 * 6.283185482025146484375;
    float3 _196 = _119.xxx;
    float3 _197 = Primitive.Primitive_LocalToWorld[0u].xyz * _196;
    float3 _201 = _119.yyy;
    float3 _202 = Primitive.Primitive_LocalToWorld[1u].xyz * _201;
    float3 _203 = _197 + _202;
    float3 _207 = _119.zzz;
    float3 _208 = Primitive.Primitive_LocalToWorld[2u].xyz * _207;
    float3 _209 = _203 + _208;
    float3 _213 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _214 = _209 + _213;
    float _215 = _214.x;
    float _216 = _214.y;
    float _217 = _214.z;
    float4 _218 = float4(_215, _216, _217, 1.0);
    float3 _219 = _218.xyz;
    float3 _222 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _231 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _222), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _239 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _222), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _240 = View.View_TranslatedWorldCameraOrigin - _219;
    float _241 = dot(_240, _240);
    float3 _245 = _240 / float3(sqrt(fast::max(_241, 0.00999999977648258209228515625)));
    float3 _315;
    float3 _316;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _259 = cross(_245, float3(0.0, 0.0, 1.0));
        float3 _264 = _259 / float3(sqrt(fast::max(dot(_259, _259), 0.00999999977648258209228515625)));
        float3 _266 = float3(fast::clamp((_241 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _315 = normalize(mix(_231, _264, _266));
        _316 = normalize(mix(_239, cross(_245, _264), _266));
    }
    else
    {
        float3 _313;
        float3 _314;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _277 = cross(_245, _142);
            _313 = _277 / float3(sqrt(fast::max(dot(_277, _277), 0.00999999977648258209228515625)));
            _314 = -_142;
        }
        else
        {
            float3 _311;
            float3 _312;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _290 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _245);
                _311 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _312 = -(_290 / float3(sqrt(fast::max(dot(_290, _290), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _309;
                float3 _310;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _302 = cross(_245, float3(0.0, 0.0, 1.0));
                    float3 _307 = _302 / float3(sqrt(fast::max(dot(_302, _302), 0.00999999977648258209228515625)));
                    _309 = _307;
                    _310 = cross(_245, _307);
                }
                else
                {
                    _309 = _231;
                    _310 = _239;
                }
                _311 = _309;
                _312 = _310;
            }
            _313 = _311;
            _314 = _312;
        }
        _315 = _313;
        _316 = _314;
    }
    float _319 = _192 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _320 = sin(_319);
    float _321 = cos(_319);
    float3 _322 = _316 * _320;
    float3 _323 = _315 * _321;
    float3 _324 = _322 + _323;
    float3 _325 = _316 * _321;
    float3 _326 = _315 * _320;
    float3 _327 = _325 - _326;
    float _328 = _184.x;
    float _332 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _333 = _328 * _332;
    float3 _334 = _324 * _333;
    float _335 = _184.y;
    float _339 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _340 = _335 * _339;
    float3 _341 = _327 * _340;
    float3 _342 = _334 + _341;
    float3 _343 = _219 + _342;
    float _344 = _343.x;
    float _345 = _343.y;
    float _346 = _343.z;
    float4 _347 = float4(_344, _345, _346, 1.0);
    float4 _348 = float4(_347.x, _347.y, _347.z, _347.w);
    float4 _349 = View.View_TranslatedWorldToClip * _348;
    float3x3 _350 = _85;
    _350[0] = _324;
    float3x3 _351 = _350;
    _351[1] = _327;
    float3 _353 = normalize(cross(_324, _327));
    float3x3 _354 = _351;
    _354[2] = _353;
    out.out_var_TANGENTX = float4(_324, 0.0);
    out.out_var_TANGENTZ = float4(_353, float(int(sign(determinant(_354)))));
    out.gl_Position = _349;
    return out;
}

