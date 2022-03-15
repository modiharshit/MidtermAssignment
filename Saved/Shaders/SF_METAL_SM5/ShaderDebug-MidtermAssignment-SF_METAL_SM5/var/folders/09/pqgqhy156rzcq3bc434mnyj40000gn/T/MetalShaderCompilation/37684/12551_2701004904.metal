

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

constant float3x3 _107 = {};
constant float2 _108 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn1)]];
    float3 out_var_TEXCOORD4 [[user(locn2)]];
    float4 out_var_TEXCOORD5 [[user(locn3)]];
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

vertex MainVS_out Main_00003107_a0fe1068(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float2 _135 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _139 = PositionTexture.sample(PositionTextureSampler, _135, level(0.0));
    float4 _147 = AttributesTexture.sample(AttributesTextureSampler, _135, level(0.0));
    float _148 = _139.w;
    float3 _160 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _135, level(0.0)).xyz;
    float3 _162 = normalize(_160 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _196 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _148)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _199 = (_147.x < 0.5) ? 0.0 : (-0.5);
    float _202 = (_147.y < 0.5) ? 0.0 : (-0.5);
    float2 _221 = ((((_147.xy + float2(_199, _202)) * float2(2.0)) * (_196.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_160), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_148, 1.0));
    float2 _226 = _108;
    _226.x = (_199 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _231 = _226;
    _231.y = (_202 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _232 = _196.z;
    float _233 = fract(_232);
    float _234 = _232 - _233;
    float _235 = _234 + 1.0;
    float2 _251 = (float2(mod(_234, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_234 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _231) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float2 _254 = (float2(mod(_235, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_235 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _231) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _289 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _139.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _139.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _139.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _292 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _301 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _292), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _309 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _292), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _310 = View.View_TranslatedWorldCameraOrigin - _289;
    float _311 = dot(_310, _310);
    float3 _315 = _310 / float3(sqrt(fast::max(_311, 0.00999999977648258209228515625)));
    float3 _385;
    float3 _386;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _373 = cross(_315, float3(0.0, 0.0, 1.0));
        float3 _378 = _373 / float3(sqrt(fast::max(dot(_373, _373), 0.00999999977648258209228515625)));
        float3 _380 = float3(fast::clamp((_311 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _385 = normalize(mix(_301, _378, _380));
        _386 = normalize(mix(_309, cross(_315, _378), _380));
    }
    else
    {
        float3 _364;
        float3 _365;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _357 = cross(_315, _162);
            _364 = _357 / float3(sqrt(fast::max(dot(_357, _357), 0.00999999977648258209228515625)));
            _365 = -_162;
        }
        else
        {
            float3 _355;
            float3 _356;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _348 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _315);
                _355 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _356 = -(_348 / float3(sqrt(fast::max(dot(_348, _348), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _346;
                float3 _347;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _339 = cross(_315, float3(0.0, 0.0, 1.0));
                    float3 _344 = _339 / float3(sqrt(fast::max(dot(_339, _339), 0.00999999977648258209228515625)));
                    _346 = _344;
                    _347 = cross(_315, _344);
                }
                else
                {
                    _346 = _301;
                    _347 = _309;
                }
                _355 = _346;
                _356 = _347;
            }
            _364 = _355;
            _365 = _356;
        }
        _385 = _364;
        _386 = _365;
    }
    float _389 = ((_147.z + ((_147.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _148)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _390 = sin(_389);
    float _391 = cos(_389);
    float3 _394 = (_386 * _390) + (_385 * _391);
    float3 _397 = (_386 * _391) - (_385 * _390);
    float4 _415 = float4(_289 + ((_394 * (_221.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_397 * (_221.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _416 = float4(_415.x, _415.y, _415.z, _415.w);
    float4 _419 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _416;
    float4 _430;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_419.z < 0.0))
    {
        float4 _428 = _419;
        _428.z = 9.9999999747524270787835121154785e-07;
        float4 _429 = _428;
        _429.w = 1.0;
        _430 = _429;
    }
    else
    {
        _430 = _419;
    }
    float _434 = _430.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _437 = _430;
    _437.z = _434 * _430.w;
    float3 _440 = float3(0.0);
    _440.x = _233;
    float3 _441 = _440;
    _441.y = _148;
    float3 _442 = _441;
    _442.z = 0.0;
    float3x3 _443 = _107;
    _443[0] = _394;
    float3x3 _444 = _443;
    _444[1] = _397;
    float3 _446 = normalize(cross(_394, _397));
    float3x3 _447 = _444;
    _447[2] = _446;
    spvUnsafeArray<float4, 1> _460 = { float4(_251.x, _251.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _460;
    out.out_var_PARTICLE_SUBUVS = float4(_251.x, _251.y, _254.x, _254.y);
    out.out_var_TEXCOORD4 = _442;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _148)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_394, 0.0);
    out.out_var_TANGENTZ = float4(_446, float(int(sign(determinant(_447)))));
    out.out_var_TEXCOORD6 = _434;
    out.out_var_TEXCOORD7 = _416;
    out.gl_Position = _437;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

