

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

constant float3x3 _96 = {};
constant float2 _97 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TANGENTX [[user(locn1)]];
    float4 out_var_TANGENTZ [[user(locn2)]];
    float out_var_TEXCOORD6 [[user(locn3)]];
    float4 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex MainVS_out Main_00002c9f_e9cf160b(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    float2 _126 = ParticleIndices.read(uint((_Globals.ParticleIndicesOffset + (((gl_InstanceIndex - gl_BaseInstance) * 16u) + ((gl_VertexIndex - gl_BaseVertex) / 4u))))).xy;
    float4 _130 = PositionTexture.sample(PositionTextureSampler, _126, level(0.0));
    float4 _138 = AttributesTexture.sample(AttributesTextureSampler, _126, level(0.0));
    float _139 = _130.w;
    float3 _151 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz) * VelocityTexture.sample(VelocityTextureSampler, _126, level(0.0)).xyz;
    float3 _153 = normalize(_151 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float4 _170 = (CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_MiscCurve.xy + (EmitterUniforms.EmitterUniforms_MiscCurve.zw * _139)), level(0.0)) * EmitterUniforms.EmitterUniforms_MiscScale) + EmitterUniforms.EmitterUniforms_MiscBias;
    float _173 = (_138.x < 0.5) ? 0.0 : (-0.5);
    float _176 = (_138.y < 0.5) ? 0.0 : (-0.5);
    float2 _195 = ((((_138.xy + float2(_173, _176)) * float2(2.0)) * (_170.xy * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale)) * fast::min(fast::max(EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * length(_151), float2(1.0)), EmitterUniforms.EmitterUniforms_SizeBySpeed.zw)) * float2(step(_139, 1.0));
    float2 _200 = _97;
    _200.x = (_173 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _205 = _200;
    _205.y = (_176 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _206 = _170.z;
    float _208 = _206 - fract(_206);
    float2 _221 = (float2(mod(_208, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_208 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _205) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float3 _256 = float4((((Primitive.Primitive_LocalToWorld[0u].xyz * _130.xxx) + (Primitive.Primitive_LocalToWorld[1u].xyz * _130.yyy)) + (Primitive.Primitive_LocalToWorld[2u].xyz * _130.zzz)) + (Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation), 1.0).xyz;
    float3 _259 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _268 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _259), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _276 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _259), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _277 = View.View_TranslatedWorldCameraOrigin - _256;
    float _278 = dot(_277, _277);
    float3 _282 = _277 / float3(sqrt(fast::max(_278, 0.00999999977648258209228515625)));
    float3 _352;
    float3 _353;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _340 = cross(_282, float3(0.0, 0.0, 1.0));
        float3 _345 = _340 / float3(sqrt(fast::max(dot(_340, _340), 0.00999999977648258209228515625)));
        float3 _347 = float3(fast::clamp((_278 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _352 = normalize(mix(_268, _345, _347));
        _353 = normalize(mix(_276, cross(_282, _345), _347));
    }
    else
    {
        float3 _331;
        float3 _332;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _324 = cross(_282, _153);
            _331 = _324 / float3(sqrt(fast::max(dot(_324, _324), 0.00999999977648258209228515625)));
            _332 = -_153;
        }
        else
        {
            float3 _322;
            float3 _323;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _315 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _282);
                _322 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _323 = -(_315 / float3(sqrt(fast::max(dot(_315, _315), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _313;
                float3 _314;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _306 = cross(_282, float3(0.0, 0.0, 1.0));
                    float3 _311 = _306 / float3(sqrt(fast::max(dot(_306, _306), 0.00999999977648258209228515625)));
                    _313 = _311;
                    _314 = cross(_282, _311);
                }
                else
                {
                    _313 = _268;
                    _314 = _276;
                }
                _322 = _313;
                _323 = _314;
            }
            _331 = _322;
            _332 = _323;
        }
        _352 = _331;
        _353 = _332;
    }
    float _356 = ((_138.z + ((_138.w * EmitterUniforms.EmitterUniforms_RotationRateScale) * _139)) * 6.283185482025146484375) + EmitterUniforms.EmitterUniforms_RotationBias;
    float _357 = sin(_356);
    float _358 = cos(_356);
    float3 _361 = (_353 * _357) + (_352 * _358);
    float3 _364 = (_353 * _358) - (_352 * _357);
    float4 _382 = float4(_256 + ((_361 * (_195.x * (in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x))) + (_364 * (_195.y * (in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y)))), 1.0);
    float4 _383 = float4(_382.x, _382.y, _382.z, _382.w);
    float4 _386 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _383;
    float4 _397;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_386.z < 0.0))
    {
        float4 _395 = _386;
        _395.z = 9.9999999747524270787835121154785e-07;
        float4 _396 = _395;
        _396.w = 1.0;
        _397 = _396;
    }
    else
    {
        _397 = _386;
    }
    float _401 = _397.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _404 = _397;
    _404.z = _401 * _397.w;
    float3x3 _406 = _96;
    _406[0] = _361;
    float3x3 _407 = _406;
    _407[1] = _364;
    float3 _409 = normalize(cross(_361, _364));
    float3x3 _410 = _407;
    _410[2] = _409;
    spvUnsafeArray<float4, 1> _423 = { float4(_221.x, _221.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _423;
    out.out_var_TANGENTX = float4(_361, 0.0);
    out.out_var_TANGENTZ = float4(_409, float(int(sign(determinant(_410)))));
    out.out_var_TEXCOORD6 = _401;
    out.out_var_TEXCOORD7 = _383;
    out.gl_Position = _404;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

