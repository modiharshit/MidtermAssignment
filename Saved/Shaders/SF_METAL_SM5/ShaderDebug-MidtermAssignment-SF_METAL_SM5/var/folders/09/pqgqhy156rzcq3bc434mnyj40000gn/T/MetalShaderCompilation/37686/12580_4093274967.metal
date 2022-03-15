

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

constant float3x3 _98 = {};
constant float2 _99 = {};

struct Main_out
{
    float4 out_var_TEXCOORD0_0 [[user(locn0)]];
    float4 out_var_TEXCOORD5 [[user(locn1)]];
    float4 out_var_TANGENTX [[user(locn2)]];
    float4 out_var_TANGENTZ [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex Main_out Main_00003124_f3fa6b57(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(3)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD0 = {};
    uint _121 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _122 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _123 = _121 + _122;
    uint _126 = _Globals.ParticleIndicesOffset + _123;
    float4 _128 = ParticleIndices.read(uint(_126));
    float2 _129 = _128.xy;
    float4 _133 = PositionTexture.sample(PositionTextureSampler, _129, level(0.0));
    float4 _137 = VelocityTexture.sample(VelocityTextureSampler, _129, level(0.0));
    float4 _141 = AttributesTexture.sample(AttributesTextureSampler, _129, level(0.0));
    float _142 = _133.w;
    float _143 = step(_142, 1.0);
    float3 _144 = _137.xyz;
    float3x3 _153 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _154 = _153 * _144;
    float3 _156 = normalize(_154 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _157 = length(_154);
    float2 _181 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _142;
    float2 _182 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _181;
    float4 _184 = CurveTexture.sample(CurveTextureSampler, _182, level(0.0));
    float4 _187 = _184 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _190 = _187 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _191 = _141.x;
    bool _192 = _191 < 0.5;
    float _193 = _192 ? 0.0 : (-0.5);
    float _194 = _141.y;
    bool _195 = _194 < 0.5;
    float _196 = _195 ? 0.0 : (-0.5);
    float2 _197 = float2(_193, _196);
    float2 _198 = _141.xy;
    float2 _199 = _198 + _197;
    float2 _200 = _199 * float2(2.0);
    float2 _201 = _190.xy;
    float2 _204 = _201 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _208 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _157;
    float2 _209 = fast::max(_208, float2(1.0));
    float2 _211 = fast::min(_209, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _212 = _200 * _204;
    float2 _213 = _212 * _211;
    float2 _214 = float2(_143);
    float2 _215 = _213 * _214;
    float2 _220 = _99;
    _220.x = (_193 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.x) : in.in_var_ATTRIBUTE0.x;
    float2 _225 = _220;
    _225.y = (_196 == 0.0) ? (1.0 - in.in_var_ATTRIBUTE0.y) : in.in_var_ATTRIBUTE0.y;
    float _226 = _190.z;
    float _228 = _226 - fract(_226);
    float2 _241 = (float2(mod(_228, EmitterUniforms.EmitterUniforms_SubImageSize.x), floor(_228 * EmitterUniforms.EmitterUniforms_SubImageSize.z)) + _225) * EmitterUniforms.EmitterUniforms_SubImageSize.zw;
    float _242 = _141.w;
    float _245 = _242 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _246 = _141.z;
    float _247 = _245 * _142;
    float _248 = _246 + _247;
    float _249 = _248 * 6.283185482025146484375;
    float3 _253 = _133.xxx;
    float3 _254 = Primitive.Primitive_LocalToWorld[0u].xyz * _253;
    float3 _258 = _133.yyy;
    float3 _259 = Primitive.Primitive_LocalToWorld[1u].xyz * _258;
    float3 _260 = _254 + _259;
    float3 _264 = _133.zzz;
    float3 _265 = Primitive.Primitive_LocalToWorld[2u].xyz * _264;
    float3 _266 = _260 + _265;
    float3 _270 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _271 = _266 + _270;
    float _272 = _271.x;
    float _273 = _271.y;
    float _274 = _271.z;
    float4 _275 = float4(_272, _273, _274, 1.0);
    float3 _276 = _275.xyz;
    float3 _279 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _288 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _279), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _296 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _279), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _297 = View.View_TranslatedWorldCameraOrigin - _276;
    float _298 = dot(_297, _297);
    float3 _302 = _297 / float3(sqrt(fast::max(_298, 0.00999999977648258209228515625)));
    float3 _372;
    float3 _373;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _360 = cross(_302, float3(0.0, 0.0, 1.0));
        float3 _365 = _360 / float3(sqrt(fast::max(dot(_360, _360), 0.00999999977648258209228515625)));
        float3 _367 = float3(fast::clamp((_298 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _372 = normalize(mix(_288, _365, _367));
        _373 = normalize(mix(_296, cross(_302, _365), _367));
    }
    else
    {
        float3 _351;
        float3 _352;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _344 = cross(_302, _156);
            _351 = _344 / float3(sqrt(fast::max(dot(_344, _344), 0.00999999977648258209228515625)));
            _352 = -_156;
        }
        else
        {
            float3 _342;
            float3 _343;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _335 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _302);
                _342 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _343 = -(_335 / float3(sqrt(fast::max(dot(_335, _335), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _333;
                float3 _334;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _326 = cross(_302, float3(0.0, 0.0, 1.0));
                    float3 _331 = _326 / float3(sqrt(fast::max(dot(_326, _326), 0.00999999977648258209228515625)));
                    _333 = _331;
                    _334 = cross(_302, _331);
                }
                else
                {
                    _333 = _288;
                    _334 = _296;
                }
                _342 = _333;
                _343 = _334;
            }
            _351 = _342;
            _352 = _343;
        }
        _372 = _351;
        _373 = _352;
    }
    float _376 = _249 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _377 = sin(_376);
    float _378 = cos(_376);
    float3 _379 = _373 * _377;
    float3 _380 = _372 * _378;
    float3 _381 = _379 + _380;
    float3 _382 = _373 * _378;
    float3 _383 = _372 * _377;
    float3 _384 = _382 - _383;
    float _385 = _215.x;
    float _388 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _389 = _385 * _388;
    float3 _390 = _381 * _389;
    float _391 = _215.y;
    float _394 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _395 = _391 * _394;
    float3 _396 = _384 * _395;
    float3 _397 = _390 + _396;
    float3 _398 = _276 + _397;
    float _399 = _398.x;
    float _400 = _398.y;
    float _401 = _398.z;
    float4 _402 = float4(_399, _400, _401, 1.0);
    float4 _403 = float4(_402.x, _402.y, _402.z, _402.w);
    float4 _404 = View.View_TranslatedWorldToClip * _403;
    float3x3 _406 = _98;
    _406[0] = _381;
    float3x3 _407 = _406;
    _407[1] = _384;
    float3 _409 = normalize(cross(_381, _384));
    float3x3 _410 = _407;
    _410[2] = _409;
    spvUnsafeArray<float4, 1> _423 = { float4(_241.x, _241.y, float4(0.0).z, float4(0.0).w) };
    out_var_TEXCOORD0 = _423;
    out.out_var_TEXCOORD5 = ((CurveTexture.sample(CurveTextureSampler, (EmitterUniforms.EmitterUniforms_ColorCurve.xy + (EmitterUniforms.EmitterUniforms_ColorCurve.zw * _142)), level(0.0)) * EmitterUniforms.EmitterUniforms_ColorScale) + EmitterUniforms.EmitterUniforms_ColorBias) * EmitterDynamicUniforms.EmitterDynamicUniforms_DynamicColor;
    out.out_var_TANGENTX = float4(_381, 0.0);
    out.out_var_TANGENTZ = float4(_409, float(int(sign(determinant(_410)))));
    out.out_var_TEXCOORD6 = _403;
    out.gl_Position = _404;
    out.out_var_TEXCOORD0_0 = out_var_TEXCOORD0[0];
    return out;
}

