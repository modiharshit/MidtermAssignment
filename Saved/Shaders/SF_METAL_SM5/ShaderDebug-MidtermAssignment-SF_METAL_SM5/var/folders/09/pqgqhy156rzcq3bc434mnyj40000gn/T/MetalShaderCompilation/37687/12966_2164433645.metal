

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
    float TranslucentDepthPass_InvMaxSubjectDepth;
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

constant float3x3 _115 = {};
constant float2 _116 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 out_var_TEXCOORD4 [[user(locn2)]];
    float4 out_var_TEXCOORD5 [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float4 out_var_TANGENTX [[user(locn5)]];
    float4 out_var_TANGENTZ [[user(locn6)]];
    float out_var_TEXCOORD6 [[user(locn7)]];
    float4 out_var_TEXCOORD7 [[user(locn8)]];
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

vertex MainVS_out Main_000032a6_8102a2ed(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float4 _143 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u)))));
    float2 _144 = _143.xy;
    float4 _148 = PositionTexture.sample(PositionTextureSampler, _144, level(0.0));
    float4 _156 = AttributesTexture.sample(AttributesTextureSampler, _144, level(0.0));
    float _157 = _148.w;
    float3 _169 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _144, level(0.0)).xyz;
    float3 _171 = normalize(_169 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _205 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _157)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _208 = (_156.x < 0.5) ? 0.0 : (-0.5);
    float _211 = (_156.y < 0.5) ? 0.0 : (-0.5);
    float2 _230 = ((((_156.xy + float2(_208, _211)) * float2(2.0)) * (_205.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_169), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_157, 1.0));
    float2 _235 = _116;
    _235.x = (_208 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _240 = _235;
    _240.y = (_211 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _241 = _205.z;
    float _242 = fract(_241);
    float _243 = _241 - _242;
    float _244 = _243 + 1.0;
    float2 _260 = (float2(mod(_243, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_243 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _240) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _263 = (float2(mod(_244, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_244 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _240) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _298 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _148.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _148.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _148.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _301 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _310 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _301), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _318 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _301), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _319 = View.View_TranslatedWorldCameraOrigin - _298;
    float _320 = dot(_319, _319);
    float3 _324 = _319 / float3(sqrt(fast::max(_320, 0.00999999977648258209228515625)));
    float3 _394;
    float3 _395;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _382 = cross(_324, float3(0.0, 0.0, 1.0));
        float3 _387 = _382 / float3(sqrt(fast::max(dot(_382, _382), 0.00999999977648258209228515625)));
        float3 _389 = float3(fast::clamp((_320 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _394 = normalize(mix(_310, _387, _389));
        _395 = normalize(mix(_318, cross(_324, _387), _389));
    }
    else
    {
        float3 _373;
        float3 _374;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _366 = cross(_324, _171);
            _373 = _366 / float3(sqrt(fast::max(dot(_366, _366), 0.00999999977648258209228515625)));
            _374 = -_171;
        }
        else
        {
            float3 _364;
            float3 _365;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _357 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _324);
                _364 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _365 = -(_357 / float3(sqrt(fast::max(dot(_357, _357), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _355;
                float3 _356;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _348 = cross(_324, float3(0.0, 0.0, 1.0));
                    float3 _353 = _348 / float3(sqrt(fast::max(dot(_348, _348), 0.00999999977648258209228515625)));
                    _355 = _353;
                    _356 = cross(_324, _353);
                }
                else
                {
                    _355 = _310;
                    _356 = _318;
                }
                _364 = _355;
                _365 = _356;
            }
            _373 = _364;
            _374 = _365;
        }
        _394 = _373;
        _395 = _374;
    }
    float _398 = ((_156.z + ((_156.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _157)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _399 = sin(_398);
    float _400 = cos(_398);
    float3 _403 = (_395 * _399) + (_394 * _400);
    float3 _406 = (_395 * _400) - (_394 * _399);
    float4 _437 = float4(_298 + ((_403 * (_230.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_406 * (_230.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _438 = float4(_437.x, _437.y, _437.z, _437.w);
    float4 _441 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _438;
    float4 _452;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_441.z < 0.0))
    {
        float4 _450 = _441;
        _450.z = 9.9999999747524270787835121154785e-07;
        float4 _451 = _450;
        _451.w = 1.0;
        _452 = _451;
    }
    else
    {
        _452 = _441;
    }
    float _456 = _452.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _459 = _452;
    _459.z = _456 * _452.w;
    float3 _462 = float3(0.0);
    _462.x = _242;
    float3 _463 = _462;
    _463.y = _157;
    float3 _464 = _463;
    _464.z = 0.0;
    float3x3 _465 = _115;
    _465[0] = _403;
    float3x3 _466 = _465;
    _466[1] = _406;
    float3 _468 = normalize(cross(_403, _406));
    float3x3 _469 = _466;
    _469[2] = _468;
    spvUnsafeArray<float4, 1> _482 = { float4(_260.x, _260.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _482;
    out.out_var_PARTICLE_SUBUVS = float4(_260.x, _260.y, _263.x, _263.y);
    out.out_var_TEXCOORD4 = _464;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _157)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1341.456298828125, 2633.577880859375, 5623.98291015625) * ((_143.x + 10.0) * (_143.y + 10.0))) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TANGENTX = float4(_403, 0.0);
    out.out_var_TANGENTZ = float4(_468, float(int(sign(determinant(_469)))));
    out.out_var_TEXCOORD6 = _456;
    out.out_var_TEXCOORD7 = _438;
    out.gl_Position = _459;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

