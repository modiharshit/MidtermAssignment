

#pragma clang diagnostic ignored "-Wmissing-prototypes"

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
    char _m5_pad[32];
    float3 View_WorldCameraOrigin;
    char _m6_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_SpriteVF
{
    float4 SpriteVF_AxisLockRight;
    float4 SpriteVF_AxisLockUp;
    float4 SpriteVF_TangentSelector;
    char _m3_pad[32];
    float4 SpriteVF_SubImageSize;
    packed_float3 SpriteVF_CameraFacingBlend;
    float SpriteVF_RemoveHMDRoll;
    char _m6_pad[16];
    float SpriteVF_RotationScale;
    float SpriteVF_RotationBias;
    char _m8_pad[8];
    float2 SpriteVF_PivotOffset;
};

struct type_Globals
{
    uint NumCutoutVerticesPerFrame;
};

constant float2 _58 = {};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00001df5_c34f587f(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _86 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _89 = Primitive.Primitive_LocalToWorld * _86;
    float3 _95 = _89.xyz;
    float3 _99 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _108 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _99), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _116 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _99), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _117 = View.View_WorldCameraOrigin - _95;
    float _118 = dot(_117, _117);
    float3 _121 = _117 * rsqrt(fast::max(_118, 9.9999999392252902907785028219223e-09));
    float3 _191;
    float3 _192;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _137 = cross(_121, float3(0.0, 0.0, 1.0));
        float3 _141 = _137 * rsqrt(fast::max(dot(_137, _137), 9.9999999392252902907785028219223e-09));
        float3 _143 = float3(fast::clamp((_118 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _191 = normalize(mix(_108, _141, _143));
        _192 = normalize(mix(_116, cross(_121, _141), _143));
    }
    else
    {
        float3 _189;
        float3 _190;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _153 = _95 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _157 = _153 * rsqrt(fast::max(dot(_153, _153), 9.9999999392252902907785028219223e-09));
            float3 _158 = cross(_121, _157);
            _189 = _158 * rsqrt(fast::max(dot(_158, _158), 9.9999999392252902907785028219223e-09));
            _190 = -_157;
        }
        else
        {
            float3 _187;
            float3 _188;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _169 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _121);
                _187 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _188 = -(_169 * rsqrt(fast::max(dot(_169, _169), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _185;
                float3 _186;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _179 = cross(_121, float3(0.0, 0.0, 1.0));
                    float3 _183 = _179 * rsqrt(fast::max(dot(_179, _179), 9.9999999392252902907785028219223e-09));
                    _185 = _183;
                    _186 = cross(_121, _183);
                }
                else
                {
                    _185 = _108;
                    _186 = _116;
                }
                _187 = _185;
                _188 = _186;
            }
            _189 = _187;
            _190 = _188;
        }
        _191 = _189;
        _192 = _190;
    }
    float _198 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _199 = _198 + SpriteVF.SpriteVF_RotationBias;
    float _200 = sin(_199);
    float _201 = cos(_199);
    float3 _202 = _192 * _200;
    float3 _203 = _191 * _201;
    float3 _204 = _202 + _203;
    float3 _205 = _192 * _201;
    float3 _206 = _191 * _200;
    float3 _207 = _205 - _206;
    float2 _211 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _253;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _221 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _230 = _211.x;
        float _231 = _211.y;
        uint _238;
        if ((_230 * _231) < 0.0)
        {
            _238 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _221;
        }
        else
        {
            _238 = _221;
        }
        float4 _242 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _238)));
        float _244 = _242.x;
        float2 _247 = _58;
        _247.x = (_230 < 0.0) ? (1.0 - _244) : _244;
        float _249 = _242.y;
        float2 _252 = _247;
        _252.y = (_231 < 0.0) ? (1.0 - _249) : _249;
        _253 = _252;
    }
    else
    {
        _253 = in.in_var_ATTRIBUTE4;
    }
    float3 _254 = _95 + View.View_PreViewTranslation;
    float _255 = _254.x;
    float _256 = _254.y;
    float _257 = _254.z;
    float4 _258 = float4(_255, _256, _257, 1.0);
    float2 _259 = abs(in.in_var_ATTRIBUTE2.xy);
    float _260 = _204.x;
    float _261 = _204.y;
    float _262 = _204.z;
    float4 _263 = float4(_260, _261, _262, 0.0);
    float _264 = _259.x;
    float _268 = _253.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _269 = _264 * _268;
    float4 _270 = _263 * _269;
    float4 _271 = _258 + _270;
    float _272 = _207.x;
    float _273 = _207.y;
    float _274 = _207.z;
    float4 _275 = float4(_272, _273, _274, 0.0);
    float _276 = _259.y;
    float _280 = _253.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _281 = _276 * _280;
    float4 _282 = _275 * _281;
    float4 _283 = _271 + _282;
    float _284 = _283.x;
    float _285 = _283.y;
    float _286 = _283.z;
    float4 _287 = float4(_284, _285, _286, 1.0);
    float4 _288 = float4(_287.x, _287.y, _287.z, _287.w);
    float4 _289 = View.View_TranslatedWorldToClip * _288;
    out.gl_Position = _289;
    return out;
}

