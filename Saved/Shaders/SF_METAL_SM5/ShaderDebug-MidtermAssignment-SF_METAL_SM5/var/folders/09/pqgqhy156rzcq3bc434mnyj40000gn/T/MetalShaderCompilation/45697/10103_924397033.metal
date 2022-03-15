

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

struct Main_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float4 out_var_TEXCOORD6 [[user(locn2)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00002777_37192de9(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _106 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _107 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _108 = _106 + _107;
    uint _111 = _Globals.ParticleIndicesOffset + _108;
    float4 _113 = ParticleIndices.read(uint(_111));
    float2 _114 = _113.xy;
    float4 _118 = PositionTexture.sample(PositionTextureSampler, _114, level(0.0));
    float4 _122 = VelocityTexture.sample(VelocityTextureSampler, _114, level(0.0));
    float4 _126 = AttributesTexture.sample(AttributesTextureSampler, _114, level(0.0));
    float _127 = _118.w;
    float _128 = step(_127, 1.0);
    float3 _129 = _122.xyz;
    float3x3 _138 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _139 = _138 * _129;
    float3 _141 = normalize(_139 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _142 = length(_139);
    float2 _147 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _127;
    float2 _148 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _147;
    float4 _152 = CurveTexture.sample(CurveTextureSampler, _148, level(0.0));
    float4 _155 = _152 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _158 = _155 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _159 = _126.x;
    bool _160 = _159 < 0.5;
    float _161 = _160 ? 0.0 : (-0.5);
    float _162 = _126.y;
    bool _163 = _162 < 0.5;
    float _164 = _163 ? 0.0 : (-0.5);
    float2 _165 = float2(_161, _164);
    float2 _166 = _126.xy;
    float2 _167 = _166 + _165;
    float2 _168 = _167 * float2(2.0);
    float2 _169 = _158.xy;
    float2 _172 = _169 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _176 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _142;
    float2 _177 = fast::max(_176, float2(1.0));
    float2 _179 = fast::min(_177, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _180 = _168 * _172;
    float2 _181 = _180 * _179;
    float2 _182 = float2(_128);
    float2 _183 = _181 * _182;
    float _184 = _126.w;
    float _187 = _184 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _188 = _126.z;
    float _189 = _187 * _127;
    float _190 = _188 + _189;
    float _191 = _190 * 6.283185482025146484375;
    float3 _195 = _118.xxx;
    float3 _196 = Primitive.Primitive_LocalToWorld[0u].xyz * _195;
    float3 _200 = _118.yyy;
    float3 _201 = Primitive.Primitive_LocalToWorld[1u].xyz * _200;
    float3 _202 = _196 + _201;
    float3 _206 = _118.zzz;
    float3 _207 = Primitive.Primitive_LocalToWorld[2u].xyz * _206;
    float3 _208 = _202 + _207;
    float3 _212 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _213 = _208 + _212;
    float _214 = _213.x;
    float _215 = _213.y;
    float _216 = _213.z;
    float4 _217 = float4(_214, _215, _216, 1.0);
    float3 _218 = _217.xyz;
    float3 _221 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _230 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _221), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _238 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _221), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _239 = View.View_TranslatedWorldCameraOrigin - _218;
    float _240 = dot(_239, _239);
    float3 _244 = _239 / float3(sqrt(fast::max(_240, 0.00999999977648258209228515625)));
    float3 _314;
    float3 _315;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _258 = cross(_244, float3(0.0, 0.0, 1.0));
        float3 _263 = _258 / float3(sqrt(fast::max(dot(_258, _258), 0.00999999977648258209228515625)));
        float3 _265 = float3(fast::clamp((_240 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _314 = normalize(mix(_230, _263, _265));
        _315 = normalize(mix(_238, cross(_244, _263), _265));
    }
    else
    {
        float3 _312;
        float3 _313;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _276 = cross(_244, _141);
            _312 = _276 / float3(sqrt(fast::max(dot(_276, _276), 0.00999999977648258209228515625)));
            _313 = -_141;
        }
        else
        {
            float3 _310;
            float3 _311;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _289 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _244);
                _310 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _311 = -(_289 / float3(sqrt(fast::max(dot(_289, _289), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _308;
                float3 _309;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _301 = cross(_244, float3(0.0, 0.0, 1.0));
                    float3 _306 = _301 / float3(sqrt(fast::max(dot(_301, _301), 0.00999999977648258209228515625)));
                    _308 = _306;
                    _309 = cross(_244, _306);
                }
                else
                {
                    _308 = _230;
                    _309 = _238;
                }
                _310 = _308;
                _311 = _309;
            }
            _312 = _310;
            _313 = _311;
        }
        _314 = _312;
        _315 = _313;
    }
    float _318 = _191 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _319 = sin(_318);
    float _320 = cos(_318);
    float3 _321 = _315 * _319;
    float3 _322 = _314 * _320;
    float3 _323 = _321 + _322;
    float3 _324 = _315 * _320;
    float3 _325 = _314 * _319;
    float3 _326 = _324 - _325;
    float _327 = _183.x;
    float _331 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _332 = _327 * _331;
    float3 _333 = _323 * _332;
    float _334 = _183.y;
    float _338 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _339 = _334 * _338;
    float3 _340 = _326 * _339;
    float3 _341 = _333 + _340;
    float3 _342 = _218 + _341;
    float _343 = _342.x;
    float _344 = _342.y;
    float _345 = _342.z;
    float4 _346 = float4(_343, _344, _345, 1.0);
    float4 _347 = float4(_346.x, _346.y, _346.z, _346.w);
    float4 _350 = View.View_TranslatedWorldToClip * _347;
    float3x3 _351 = _86;
    _351[0] = _323;
    float3x3 _352 = _351;
    _352[1] = _326;
    float3 _354 = normalize(cross(_323, _326));
    float3x3 _355 = _352;
    _355[2] = _354;
    out.out_var_TANGENTX = float4(_323, 0.0);
    out.out_var_TANGENTZ = float4(_354, float(int(sign(determinant(_355)))));
    out.out_var_TEXCOORD6 = _347;
    out.gl_Position = _350;
    return out;
}

