

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

constant float3x3 _104 = {};
constant float2 _105 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TEXCOORD5 [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
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

vertex MainVS_out Main_00002dfb_5a497e7f(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float2 _132 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _136 = PositionTexture.sample(PositionTextureSampler, _132, level(0.0));
    float4 _144 = AttributesTexture.sample(AttributesTextureSampler, _132, level(0.0));
    float _145 = _136.w;
    float3 _157 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _132, level(0.0)).xyz;
    float3 _159 = normalize(_157 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _193 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _145)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _196 = (_144.x < 0.5) ? 0.0 : (-0.5);
    float _199 = (_144.y < 0.5) ? 0.0 : (-0.5);
    float2 _218 = ((((_144.xy + float2(_196, _199)) * float2(2.0)) * (_193.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_157), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_145, 1.0));
    float2 _223 = _105;
    _223.x = (_196 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _228 = _223;
    _228.y = (_199 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _229 = _193.z;
    float _231 = _229 - fract(_229);
    float2 _244 = (float2(mod(_231, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_231 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _228) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _279 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _136.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _136.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _136.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _282 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _291 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _282), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _299 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _282), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _300 = View.View_TranslatedWorldCameraOrigin - _279;
    float _301 = dot(_300, _300);
    float3 _305 = _300 / float3(sqrt(fast::max(_301, 0.00999999977648258209228515625)));
    float3 _375;
    float3 _376;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _363 = cross(_305, float3(0.0, 0.0, 1.0));
        float3 _368 = _363 / float3(sqrt(fast::max(dot(_363, _363), 0.00999999977648258209228515625)));
        float3 _370 = float3(fast::clamp((_301 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _375 = normalize(mix(_291, _368, _370));
        _376 = normalize(mix(_299, cross(_305, _368), _370));
    }
    else
    {
        float3 _354;
        float3 _355;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _347 = cross(_305, _159);
            _354 = _347 / float3(sqrt(fast::max(dot(_347, _347), 0.00999999977648258209228515625)));
            _355 = -_159;
        }
        else
        {
            float3 _345;
            float3 _346;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _338 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _305);
                _345 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _346 = -(_338 / float3(sqrt(fast::max(dot(_338, _338), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _336;
                float3 _337;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _329 = cross(_305, float3(0.0, 0.0, 1.0));
                    float3 _334 = _329 / float3(sqrt(fast::max(dot(_329, _329), 0.00999999977648258209228515625)));
                    _336 = _334;
                    _337 = cross(_305, _334);
                }
                else
                {
                    _336 = _291;
                    _337 = _299;
                }
                _345 = _336;
                _346 = _337;
            }
            _354 = _345;
            _355 = _346;
        }
        _375 = _354;
        _376 = _355;
    }
    float _379 = ((_144.z + ((_144.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _145)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _380 = sin(_379);
    float _381 = cos(_379);
    float3 _384 = (_376 * _380) + (_375 * _381);
    float3 _387 = (_376 * _381) - (_375 * _380);
    float4 _405 = float4(_279 + ((_384 * (_218.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_387 * (_218.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _406 = float4(_405.x, _405.y, _405.z, _405.w);
    float4 _409 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _406;
    float4 _420;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_409.z < 0.0))
    {
        float4 _418 = _409;
        _418.z = 9.9999999747524270787835121154785e-07;
        float4 _419 = _418;
        _419.w = 1.0;
        _420 = _419;
    }
    else
    {
        _420 = _409;
    }
    float3x3 _423 = _104;
    _423[0] = _384;
    float3x3 _424 = _423;
    _424[1] = _387;
    float3 _426 = normalize(cross(_384, _387));
    float3x3 _427 = _424;
    _427[2] = _426;
    spvUnsafeArray<float4, 1> _440 = { float4(_244.x, _244.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _440;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _145)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_384, 0.0);
    out.out_var_TANGENTZ = float4(_426, float(int(sign(determinant(_427)))));
    out.out_var_TEXCOORD6 = _420.z;
    out.out_var_TEXCOORD7 = _406;
    out.gl_Position = _420;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

