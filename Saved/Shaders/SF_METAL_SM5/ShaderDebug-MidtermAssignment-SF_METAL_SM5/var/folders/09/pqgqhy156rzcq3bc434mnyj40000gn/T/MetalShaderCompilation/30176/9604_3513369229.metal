

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

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002584_d169c28d(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _104 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _105 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _106 = _104 + _105;
    uint _109 = _Globals.ParticleIndicesOffset + _106;
    float4 _111 = ParticleIndices.read(uint(_109));
    float2 _112 = _111.xy;
    float4 _116 = PositionTexture.sample(PositionTextureSampler, _112, level(0.0));
    float4 _120 = VelocityTexture.sample(VelocityTextureSampler, _112, level(0.0));
    float4 _124 = AttributesTexture.sample(AttributesTextureSampler, _112, level(0.0));
    float _125 = _116.w;
    float _126 = step(_125, 1.0);
    float3 _127 = _120.xyz;
    float3x3 _136 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _137 = _136 * _127;
    float3 _139 = normalize(_137 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _140 = length(_137);
    float2 _145 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _125;
    float2 _146 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _145;
    float4 _150 = CurveTexture.sample(CurveTextureSampler, _146, level(0.0));
    float4 _153 = _150 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _156 = _153 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _157 = _124.x;
    bool _158 = _157 < 0.5;
    float _159 = _158 ? 0.0 : (-0.5);
    float _160 = _124.y;
    bool _161 = _160 < 0.5;
    float _162 = _161 ? 0.0 : (-0.5);
    float2 _163 = float2(_159, _162);
    float2 _164 = _124.xy;
    float2 _165 = _164 + _163;
    float2 _166 = _165 * float2(2.0);
    float2 _167 = _156.xy;
    float2 _170 = _167 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _174 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _140;
    float2 _175 = fast::max(_174, float2(1.0));
    float2 _177 = fast::min(_175, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _178 = _166 * _170;
    float2 _179 = _178 * _177;
    float2 _180 = float2(_126);
    float2 _181 = _179 * _180;
    float _182 = _124.w;
    float _185 = _182 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _186 = _124.z;
    float _187 = _185 * _125;
    float _188 = _186 + _187;
    float _189 = _188 * 6.283185482025146484375;
    float3 _193 = _116.xxx;
    float3 _194 = Primitive.Primitive_LocalToWorld[0u].xyz * _193;
    float3 _198 = _116.yyy;
    float3 _199 = Primitive.Primitive_LocalToWorld[1u].xyz * _198;
    float3 _200 = _194 + _199;
    float3 _204 = _116.zzz;
    float3 _205 = Primitive.Primitive_LocalToWorld[2u].xyz * _204;
    float3 _206 = _200 + _205;
    float3 _210 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _211 = _206 + _210;
    float _212 = _211.x;
    float _213 = _211.y;
    float _214 = _211.z;
    float4 _215 = float4(_212, _213, _214, 1.0);
    float3 _216 = _215.xyz;
    float3 _219 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _228 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _219), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _236 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _219), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _237 = View.View_TranslatedWorldCameraOrigin - _216;
    float _238 = dot(_237, _237);
    float3 _242 = _237 / float3(sqrt(fast::max(_238, 0.00999999977648258209228515625)));
    float3 _312;
    float3 _313;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _256 = cross(_242, float3(0.0, 0.0, 1.0));
        float3 _261 = _256 / float3(sqrt(fast::max(dot(_256, _256), 0.00999999977648258209228515625)));
        float3 _263 = float3(fast::clamp((_238 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _312 = normalize(mix(_228, _261, _263));
        _313 = normalize(mix(_236, cross(_242, _261), _263));
    }
    else
    {
        float3 _310;
        float3 _311;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _274 = cross(_242, _139);
            _310 = _274 / float3(sqrt(fast::max(dot(_274, _274), 0.00999999977648258209228515625)));
            _311 = -_139;
        }
        else
        {
            float3 _308;
            float3 _309;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _287 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _242);
                _308 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _309 = -(_287 / float3(sqrt(fast::max(dot(_287, _287), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _306;
                float3 _307;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _299 = cross(_242, float3(0.0, 0.0, 1.0));
                    float3 _304 = _299 / float3(sqrt(fast::max(dot(_299, _299), 0.00999999977648258209228515625)));
                    _306 = _304;
                    _307 = cross(_242, _304);
                }
                else
                {
                    _306 = _228;
                    _307 = _236;
                }
                _308 = _306;
                _309 = _307;
            }
            _310 = _308;
            _311 = _309;
        }
        _312 = _310;
        _313 = _311;
    }
    float _316 = _189 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _317 = sin(_316);
    float _318 = cos(_316);
    float3 _319 = _313 * _317;
    float3 _320 = _312 * _318;
    float3 _321 = _319 + _320;
    float3 _322 = _313 * _318;
    float3 _323 = _312 * _317;
    float3 _324 = _322 - _323;
    float _325 = _181.x;
    float _329 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _330 = _325 * _329;
    float3 _331 = _321 * _330;
    float _332 = _181.y;
    float _336 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _337 = _332 * _336;
    float3 _338 = _324 * _337;
    float3 _339 = _331 + _338;
    float3 _340 = _216 + _339;
    float _341 = _340.x;
    float _342 = _340.y;
    float _343 = _340.z;
    float4 _344 = float4(_341, _342, _343, 1.0);
    float4 _345 = float4(_344.x, _344.y, _344.z, _344.w);
    float4 _346 = View.View_TranslatedWorldToClip * _345;
    out.gl_Position = _346;
    return out;
}

