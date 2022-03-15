

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
    float4 EmitterUniforms_SubImageSize;
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m10_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _90 = {};
constant float2 _91 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TANGENTX [[user(locn1)]];
    float4 out_var_TANGENTZ [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00002f17_1638adfb(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _112 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _113 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _114 = _112 + _113;
    uint _117 = _Globals.ParticleIndicesOffset + _114;
    float4 _119 = ParticleIndices.read(uint(_117));
    float2 _120 = _119.xy;
    float4 _124 = PositionTexture.sample(PositionTextureSampler, _120, level(0.0));
    float4 _128 = VelocityTexture.sample(VelocityTextureSampler, _120, level(0.0));
    float4 _132 = AttributesTexture.sample(AttributesTextureSampler, _120, level(0.0));
    float _133 = _124.w;
    float _134 = step(_133, 1.0);
    float3 _135 = _128.xyz;
    float3x3 _144 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _145 = _144 * _135;
    float3 _147 = normalize(_145 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _148 = length(_145);
    float2 _153 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _133;
    float2 _154 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _153;
    float4 _158 = CurveTexture.sample(CurveTextureSampler, _154, level(0.0));
    float4 _161 = _158 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _164 = _161 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _165 = _132.x;
    bool _166 = _165 < 0.5;
    float _167 = _166 ? 0.0 : (-0.5);
    float _168 = _132.y;
    bool _169 = _168 < 0.5;
    float _170 = _169 ? 0.0 : (-0.5);
    float2 _171 = float2(_167, _170);
    float2 _172 = _132.xy;
    float2 _173 = _172 + _171;
    float2 _174 = _173 * float2(2.0);
    float2 _175 = _164.xy;
    float2 _178 = _175 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _182 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _148;
    float2 _183 = fast::max(_182, float2(1.0));
    float2 _185 = fast::min(_183, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _186 = _174 * _178;
    float2 _187 = _186 * _185;
    float2 _188 = float2(_134);
    float2 _189 = _187 * _188;
    float2 _194 = _91;
    _194.x = (_167 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _199 = _194;
    _199.y = (_170 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _200 = _164.z;
    float _202 = _200 - fract(_200);
    float2 _215 = (float2(mod(_202, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_202 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _199) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _216 = _132.w;
    float _219 = _216 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _220 = _132.z;
    float _221 = _219 * _133;
    float _222 = _220 + _221;
    float _223 = _222 * 6.283185482025146484375;
    float3 _227 = _124.xxx;
    float3 _228 = Primitive.Primitive_LocalToWorld[0u].xyz * _227;
    float3 _232 = _124.yyy;
    float3 _233 = Primitive.Primitive_LocalToWorld[1u].xyz * _232;
    float3 _234 = _228 + _233;
    float3 _238 = _124.zzz;
    float3 _239 = Primitive.Primitive_LocalToWorld[2u].xyz * _238;
    float3 _240 = _234 + _239;
    float3 _244 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _245 = _240 + _244;
    float _246 = _245.x;
    float _247 = _245.y;
    float _248 = _245.z;
    float4 _249 = float4(_246, _247, _248, 1.0);
    float3 _250 = _249.xyz;
    float3 _253 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _262 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _253), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _270 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _253), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _271 = View.View_TranslatedWorldCameraOrigin - _250;
    float _272 = dot(_271, _271);
    float3 _276 = _271 / float3(sqrt(fast::max(_272, 0.00999999977648258209228515625)));
    float3 _346;
    float3 _347;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _334 = cross(_276, float3(0.0, 0.0, 1.0));
        float3 _339 = _334 / float3(sqrt(fast::max(dot(_334, _334), 0.00999999977648258209228515625)));
        float3 _341 = float3(fast::clamp((_272 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _346 = normalize(mix(_262, _339, _341));
        _347 = normalize(mix(_270, cross(_276, _339), _341));
    }
    else
    {
        float3 _325;
        float3 _326;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _318 = cross(_276, _147);
            _325 = _318 / float3(sqrt(fast::max(dot(_318, _318), 0.00999999977648258209228515625)));
            _326 = -_147;
        }
        else
        {
            float3 _316;
            float3 _317;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _309 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _276);
                _316 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _317 = -(_309 / float3(sqrt(fast::max(dot(_309, _309), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _307;
                float3 _308;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _300 = cross(_276, float3(0.0, 0.0, 1.0));
                    float3 _305 = _300 / float3(sqrt(fast::max(dot(_300, _300), 0.00999999977648258209228515625)));
                    _307 = _305;
                    _308 = cross(_276, _305);
                }
                else
                {
                    _307 = _262;
                    _308 = _270;
                }
                _316 = _307;
                _317 = _308;
            }
            _325 = _316;
            _326 = _317;
        }
        _346 = _325;
        _347 = _326;
    }
    float _350 = _223 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _351 = sin(_350);
    float _352 = cos(_350);
    float3 _353 = _347 * _351;
    float3 _354 = _346 * _352;
    float3 _355 = _353 + _354;
    float3 _356 = _347 * _352;
    float3 _357 = _346 * _351;
    float3 _358 = _356 - _357;
    float _359 = _189.x;
    float _362 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _363 = _359 * _362;
    float3 _364 = _355 * _363;
    float _365 = _189.y;
    float _368 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _369 = _365 * _368;
    float3 _370 = _358 * _369;
    float3 _371 = _364 + _370;
    float3 _372 = _250 + _371;
    float _373 = _372.x;
    float _374 = _372.y;
    float _375 = _372.z;
    float4 _376 = float4(_373, _374, _375, 1.0);
    float4 _377 = float4(_376.x, _376.y, _376.z, _376.w);
    float4 _380 = View.View_TranslatedWorldToClip * _377;
    float3x3 _382 = _90;
    _382[0] = _355;
    float3x3 _383 = _382;
    _383[1] = _358;
    float3 _385 = normalize(cross(_355, _358));
    float3x3 _386 = _383;
    _386[2] = _385;
    spvUnsafeArray<float4, 1> _399 = { float4(_215.x, _215.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _399;
    out.out_var_TANGENTX = float4(_355, 0.0);
    out.out_var_TANGENTZ = float4(_385, float(int(sign(determinant(_386)))));
    out.out_var_TEXCOORD6 = _377;
    out.gl_Position = _380;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

