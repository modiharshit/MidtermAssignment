

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
    char _m0_pad[976];
    float3 View_ViewUp;
    float3 View_ViewRight;
    float3 View_HMDViewNoRollUp;
    float3 View_HMDViewNoRollRight;
    char _m4_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m5_pad[16];
    float3 View_PreViewTranslation;
    char _m6_pad[1264];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_TranslucentDepthPass
{
    char _m0_pad[112];
    float4x4 TranslucentDepthPass_ProjectionMatrix;
    float TranslucentDepthPass_bClampToNearPlane;
};

struct type_EmitterDynamicUniforms
{
    float2 EmitterDynamicUniforms_LocalToWorldScale;
    float4 EmitterDynamicUniforms_AxisLockRight;
    float4 EmitterDynamicUniforms_AxisLockUp;
    float4 EmitterDynamicUniforms_DynamicColor;
};

struct type_EmitterUniforms
{
    float4 EmitterUniforms_ColorCurve;
    float4 EmitterUniforms_ColorScale;
    float4 EmitterUniforms_ColorBias;
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
    char _m13_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
};

constant float3x3 _111 = {};
constant float2 _112 = {};

struct MainVS_out
{
    float4 out_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 out_var_TEXCOORD4 [[user(locn1)]];
    float4 out_var_TEXCOORD5 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 out_var_TANGENTX [[user(locn4)]];
    float4 out_var_TANGENTZ [[user(locn5)]];
    float out_var_TEXCOORD6 [[user(locn6)]];
    float4 out_var_TEXCOORD7 [[user(locn7)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVS_out Main_000030de_db50f5ae(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    float4 _139 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u)))));
    float2 _140 = _139.xy;
    float4 _144 = PositionTexture.sample(PositionTextureSampler, _140, level(0.0));
    float4 _152 = AttributesTexture.sample(AttributesTextureSampler, _140, level(0.0));
    float _153 = _144.w;
    float3 _165 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _140, level(0.0)).xyz;
    float3 _167 = normalize(_165 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _201 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _153)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _204 = (_152.x < 0.5) ? 0.0 : (-0.5);
    float _207 = (_152.y < 0.5) ? 0.0 : (-0.5);
    float2 _226 = ((((_152.xy + float2(_204, _207)) * float2(2.0)) * (_201.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_165), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_153, 1.0));
    float2 _231 = _112;
    _231.x = (_204 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _236 = _231;
    _236.y = (_207 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _237 = _201.z;
    float _238 = fract(_237);
    float _239 = _237 - _238;
    float _240 = _239 + 1.0;
    float2 _256 = (float2(mod(_239, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_239 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _236) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _259 = (float2(mod(_240, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_240 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _236) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _294 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _144.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _144.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _144.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _297 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _306 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _297), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _314 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _297), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _315 = View.View_TranslatedWorldCameraOrigin - _294;
    float _316 = dot(_315, _315);
    float3 _320 = _315 / float3(sqrt(fast::max(_316, 0.00999999977648258209228515625)));
    float3 _390;
    float3 _391;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _334 = cross(_320, float3(0.0, 0.0, 1.0));
        float3 _339 = _334 / float3(sqrt(fast::max(dot(_334, _334), 0.00999999977648258209228515625)));
        float3 _341 = float3(fast::clamp((_316 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _390 = normalize(mix(_306, _339, _341));
        _391 = normalize(mix(_314, cross(_320, _339), _341));
    }
    else
    {
        float3 _388;
        float3 _389;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _352 = cross(_320, _167);
            _388 = _352 / float3(sqrt(fast::max(dot(_352, _352), 0.00999999977648258209228515625)));
            _389 = -_167;
        }
        else
        {
            float3 _386;
            float3 _387;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _365 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _320);
                _386 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _387 = -(_365 / float3(sqrt(fast::max(dot(_365, _365), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _384;
                float3 _385;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _377 = cross(_320, float3(0.0, 0.0, 1.0));
                    float3 _382 = _377 / float3(sqrt(fast::max(dot(_377, _377), 0.00999999977648258209228515625)));
                    _384 = _382;
                    _385 = cross(_320, _382);
                }
                else
                {
                    _384 = _306;
                    _385 = _314;
                }
                _386 = _384;
                _387 = _385;
            }
            _388 = _386;
            _389 = _387;
        }
        _390 = _388;
        _391 = _389;
    }
    float _394 = ((_152.z + ((_152.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _153)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _395 = sin(_394);
    float _396 = cos(_394);
    float3 _399 = (_391 * _395) + (_390 * _396);
    float3 _402 = (_391 * _396) - (_390 * _395);
    float4 _433 = float4(_294 + ((_399 * (_226.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_402 * (_226.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _434 = float4(_433.x, _433.y, _433.z, _433.w);
    float4 _437 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _434;
    float4 _448;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_437.z < 0.0))
    {
        float4 _446 = _437;
        _446.z = 9.9999999747524270787835121154785e-07;
        float4 _447 = _446;
        _447.w = 1.0;
        _448 = _447;
    }
    else
    {
        _448 = _437;
    }
    float3 _451 = float3(0.0);
    _451.x = _238;
    float3 _452 = _451;
    _452.y = _153;
    float3 _453 = _452;
    _453.z = 0.0;
    float3x3 _454 = _111;
    _454[0] = _399;
    float3x3 _455 = _454;
    _455[1] = _402;
    float3 _457 = normalize(cross(_399, _402));
    float3x3 _458 = _455;
    _458[2] = _457;
    out.out_var_PARTICLE_SUBUVS = float4(_256.x, _256.y, _259.x, _259.y);
    out.out_var_TEXCOORD4 = _453;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _153)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_139.x + 10.0) * (_139.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_399, 0.0);
    out.out_var_TANGENTZ = float4(_457, float(int(sign(determinant(_458)))));
    out.out_var_TEXCOORD6 = _448.z;
    out.out_var_TEXCOORD7 = _434;
    out.gl_Position = _448;
    return out;
}

