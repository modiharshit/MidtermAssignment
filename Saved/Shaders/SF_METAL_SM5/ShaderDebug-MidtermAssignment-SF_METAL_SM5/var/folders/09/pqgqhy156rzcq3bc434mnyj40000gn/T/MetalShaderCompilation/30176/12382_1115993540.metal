

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
    char _m7_pad[1264];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
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

constant float3x3 _98 = {};
constant float2 _99 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
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

vertex Main_out Main_0000305e_4284b5c4(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _122 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _123 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _124 = _122 + _123;
    uint _127 = _Globals.ParticleIndicesOffset + _124;
    float4 _129 = ParticleIndices.read(uint(_127));
    float2 _130 = _129.xy;
    float4 _134 = PositionTexture.sample(PositionTextureSampler, _130, level(0.0));
    float4 _138 = VelocityTexture.sample(VelocityTextureSampler, _130, level(0.0));
    float4 _142 = AttributesTexture.sample(AttributesTextureSampler, _130, level(0.0));
    float _143 = _134.w;
    float _144 = step(_143, 1.0);
    float3 _145 = _138.xyz;
    float3x3 _154 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _155 = _154 * _145;
    float3 _157 = normalize(_155 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _158 = length(_155);
    float2 _163 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _143;
    float2 _164 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _163;
    float4 _168 = CurveTexture.sample(CurveTextureSampler, _164, level(0.0));
    float4 _171 = _168 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _174 = _171 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _175 = _142.x;
    bool _176 = _175 < 0.5;
    float _177 = _176 ? 0.0 : (-0.5);
    float _178 = _142.y;
    bool _179 = _178 < 0.5;
    float _180 = _179 ? 0.0 : (-0.5);
    float2 _181 = float2(_177, _180);
    float2 _182 = _142.xy;
    float2 _183 = _182 + _181;
    float2 _184 = _183 * float2(2.0);
    float2 _185 = _174.xy;
    float2 _188 = _185 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _192 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _158;
    float2 _193 = fast::max(_192, float2(1.0));
    float2 _195 = fast::min(_193, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _196 = _184 * _188;
    float2 _197 = _196 * _195;
    float2 _198 = float2(_144);
    float2 _199 = _197 * _198;
    float2 _204 = _99;
    _204.x = (_177 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _209 = _204;
    _209.y = (_180 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _210 = _174.z;
    float _212 = _210 - fract(_210);
    float2 _225 = (float2(mod(_212, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_212 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _209) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _226 = _142.w;
    float _229 = _226 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _230 = _142.z;
    float _231 = _229 * _143;
    float _232 = _230 + _231;
    float _233 = _232 * 6.283185482025146484375;
    float3 _237 = _134.xxx;
    float3 _238 = Primitive.Primitive_LocalToWorld[0u].xyz * _237;
    float3 _242 = _134.yyy;
    float3 _243 = Primitive.Primitive_LocalToWorld[1u].xyz * _242;
    float3 _244 = _238 + _243;
    float3 _248 = _134.zzz;
    float3 _249 = Primitive.Primitive_LocalToWorld[2u].xyz * _248;
    float3 _250 = _244 + _249;
    float3 _254 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _255 = _250 + _254;
    float _256 = _255.x;
    float _257 = _255.y;
    float _258 = _255.z;
    float4 _259 = float4(_256, _257, _258, 1.0);
    float3 _260 = _259.xyz;
    float3 _263 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _272 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _263), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _280 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _263), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _281 = View.View_TranslatedWorldCameraOrigin - _260;
    float _282 = dot(_281, _281);
    float3 _286 = _281 / float3(sqrt(fast::max(_282, 0.00999999977648258209228515625)));
    float3 _356;
    float3 _357;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _344 = cross(_286, float3(0.0, 0.0, 1.0));
        float3 _349 = _344 / float3(sqrt(fast::max(dot(_344, _344), 0.00999999977648258209228515625)));
        float3 _351 = float3(fast::clamp((_282 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _356 = normalize(mix(_272, _349, _351));
        _357 = normalize(mix(_280, cross(_286, _349), _351));
    }
    else
    {
        float3 _335;
        float3 _336;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _328 = cross(_286, _157);
            _335 = _328 / float3(sqrt(fast::max(dot(_328, _328), 0.00999999977648258209228515625)));
            _336 = -_157;
        }
        else
        {
            float3 _326;
            float3 _327;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _319 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _286);
                _326 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _327 = -(_319 / float3(sqrt(fast::max(dot(_319, _319), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _317;
                float3 _318;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _310 = cross(_286, float3(0.0, 0.0, 1.0));
                    float3 _315 = _310 / float3(sqrt(fast::max(dot(_310, _310), 0.00999999977648258209228515625)));
                    _317 = _315;
                    _318 = cross(_286, _315);
                }
                else
                {
                    _317 = _272;
                    _318 = _280;
                }
                _326 = _317;
                _327 = _318;
            }
            _335 = _326;
            _336 = _327;
        }
        _356 = _335;
        _357 = _336;
    }
    float _360 = _233 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _361 = sin(_360);
    float _362 = cos(_360);
    float3 _363 = _357 * _361;
    float3 _364 = _356 * _362;
    float3 _365 = _363 + _364;
    float3 _366 = _357 * _362;
    float3 _367 = _356 * _361;
    float3 _368 = _366 - _367;
    float _369 = _199.x;
    float _372 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _373 = _369 * _372;
    float3 _374 = _365 * _373;
    float _375 = _199.y;
    float _378 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _379 = _375 * _378;
    float3 _380 = _368 * _379;
    float3 _381 = _374 + _380;
    float3 _382 = _260 + _381;
    float _396 = _382.x;
    float _397 = _382.y;
    float _398 = _382.z;
    float4 _399 = float4(_396, _397, _398, 1.0);
    float4 _400 = float4(_399.x, _399.y, _399.z, _399.w);
    float4 _401 = View.View_TranslatedWorldToClip * _400;
    float3x3 _403 = _98;
    _403[0] = _365;
    float3x3 _404 = _403;
    _404[1] = _368;
    float3 _406 = normalize(cross(_365, _368));
    float3x3 _407 = _404;
    _407[2] = _406;
    spvUnsafeArray<float4, 1> _420 = { float4(_225.x, _225.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _420;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_129.x + 10.0) * (_129.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_365, 0.0);
    out.out_var_TANGENTZ = float4(_406, float(int(sign(determinant(_407)))));
    out.gl_Position = _401;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

