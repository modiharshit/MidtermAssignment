

#pragma clang diagnostic ignored "-Wmissing-prototypes"

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

constant float3x3 _103 = {};
constant float2 _104 = {};

struct MainVS_out
{
    float4 out_var_PARTICLE_SUBUVS [[user(locn0)]];
    float3 out_var_TEXCOORD4 [[user(locn1)]];
    float4 out_var_TEXCOORD5 [[user(locn2)]];
    float4 out_var_TANGENTX [[user(locn3)]];
    float4 out_var_TANGENTZ [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
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

vertex MainVS_out Main_00002bc6_59723e73(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    float2 _131 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _135 = PositionTexture.sample(PositionTextureSampler, _131, level(0.0));
    float4 _143 = AttributesTexture.sample(AttributesTextureSampler, _131, level(0.0));
    float _144 = _135.w;
    float3 _156 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _131, level(0.0)).xyz;
    float3 _158 = normalize(_156 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _192 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _144)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _195 = (_143.x < 0.5) ? 0.0 : (-0.5);
    float _198 = (_143.y < 0.5) ? 0.0 : (-0.5);
    float2 _217 = ((((_143.xy + float2(_195, _198)) * float2(2.0)) * (_192.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_156), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_144, 1.0));
    float2 _222 = _104;
    _222.x = (_195 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _227 = _222;
    _227.y = (_198 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _228 = _192.z;
    float _229 = fract(_228);
    float _230 = _228 - _229;
    float _231 = _230 + 1.0;
    float2 _247 = (float2(mod(_230, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_230 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _227) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _250 = (float2(mod(_231, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_231 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _227) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _285 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _135.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _135.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _135.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _288 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _297 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _288), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _305 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _288), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _306 = View.View_TranslatedWorldCameraOrigin - _285;
    float _307 = dot(_306, _306);
    float3 _311 = _306 / float3(sqrt(fast::max(_307, 0.00999999977648258209228515625)));
    float3 _381;
    float3 _382;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _325 = cross(_311, float3(0.0, 0.0, 1.0));
        float3 _330 = _325 / float3(sqrt(fast::max(dot(_325, _325), 0.00999999977648258209228515625)));
        float3 _332 = float3(fast::clamp((_307 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _381 = normalize(mix(_297, _330, _332));
        _382 = normalize(mix(_305, cross(_311, _330), _332));
    }
    else
    {
        float3 _379;
        float3 _380;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _343 = cross(_311, _158);
            _379 = _343 / float3(sqrt(fast::max(dot(_343, _343), 0.00999999977648258209228515625)));
            _380 = -_158;
        }
        else
        {
            float3 _377;
            float3 _378;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _356 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _311);
                _377 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _378 = -(_356 / float3(sqrt(fast::max(dot(_356, _356), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _375;
                float3 _376;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _368 = cross(_311, float3(0.0, 0.0, 1.0));
                    float3 _373 = _368 / float3(sqrt(fast::max(dot(_368, _368), 0.00999999977648258209228515625)));
                    _375 = _373;
                    _376 = cross(_311, _373);
                }
                else
                {
                    _375 = _297;
                    _376 = _305;
                }
                _377 = _375;
                _378 = _376;
            }
            _379 = _377;
            _380 = _378;
        }
        _381 = _379;
        _382 = _380;
    }
    float _385 = ((_143.z + ((_143.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _144)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _386 = sin(_385);
    float _387 = cos(_385);
    float3 _390 = (_382 * _386) + (_381 * _387);
    float3 _393 = (_382 * _387) - (_381 * _386);
    float4 _411 = float4(_285 + ((_390 * (_217.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_393 * (_217.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _412 = float4(_411.x, _411.y, _411.z, _411.w);
    float4 _415 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _412;
    float4 _426;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_415.z < 0.0))
    {
        float4 _424 = _415;
        _424.z = 9.9999999747524270787835121154785e-07;
        float4 _425 = _424;
        _425.w = 1.0;
        _426 = _425;
    }
    else
    {
        _426 = _415;
    }
    float3 _429 = float3(0.0);
    _429.x = _229;
    float3 _430 = _429;
    _430.y = _144;
    float3 _431 = _430;
    _431.z = 0.0;
    float3x3 _432 = _103;
    _432[0] = _390;
    float3x3 _433 = _432;
    _433[1] = _393;
    float3 _435 = normalize(cross(_390, _393));
    float3x3 _436 = _433;
    _436[2] = _435;
    out.out_var_PARTICLE_SUBUVS = float4(_247.x, _247.y, _250.x, _250.y);
    out.out_var_TEXCOORD4 = _431;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _144)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_390, 0.0);
    out.out_var_TANGENTZ = float4(_435, float(int(sign(determinant(_436)))));
    out.out_var_TEXCOORD6 = _426.z;
    out.out_var_TEXCOORD7 = _412;
    out.gl_Position = _426;
    return out;
}

