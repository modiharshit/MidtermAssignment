

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
    char _m4_pad[32];
    float3 View_WorldCameraOrigin;
    char _m5_pad[32];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_ShadowDepthPass
{
    char _m0_pad[304];
    float4x4 ShadowDepthPass_ProjectionMatrix;
    float4x4 ShadowDepthPass_ViewMatrix;
    float4 ShadowDepthPass_ShadowParams;
    float ShadowDepthPass_bClampToNearPlane;
};

struct type_SpriteVF
{
    float4 SpriteVF_AxisLockRight;
    float4 SpriteVF_AxisLockUp;
    float4 SpriteVF_TangentSelector;
    float4 SpriteVF_NormalsSphereCenter;
    float4 SpriteVF_NormalsCylinderUnitDirection;
    float4 SpriteVF_SubImageSize;
    packed_float3 SpriteVF_CameraFacingBlend;
    float SpriteVF_RemoveHMDRoll;
    char _m8_pad[16];
    float SpriteVF_RotationScale;
    float SpriteVF_RotationBias;
    float SpriteVF_NormalsType;
    float2 SpriteVF_PivotOffset;
};

struct type_Globals
{
    uint NumCutoutVerticesPerFrame;
};

constant float3x3 _71 = {};
constant float2 _72 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
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

vertex Main_out Main_00002352_c1139c1e(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float3 _108 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _112 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _121 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _112), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _129 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _112), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _130 = View.View_WorldCameraOrigin - _108;
    float _131 = dot(_130, _130);
    float3 _134 = _130 * rsqrt(fast::max(_131, 9.9999999392252902907785028219223e-09));
    float3 _204;
    float3 _205;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _150 = cross(_134, float3(0.0, 0.0, 1.0));
        float3 _154 = _150 * rsqrt(fast::max(dot(_150, _150), 9.9999999392252902907785028219223e-09));
        float3 _156 = float3(fast::clamp((_131 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _204 = normalize(mix(_121, _154, _156));
        _205 = normalize(mix(_129, cross(_134, _154), _156));
    }
    else
    {
        float3 _202;
        float3 _203;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _166 = _108 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _170 = _166 * rsqrt(fast::max(dot(_166, _166), 9.9999999392252902907785028219223e-09));
            float3 _171 = cross(_134, _170);
            _202 = _171 * rsqrt(fast::max(dot(_171, _171), 9.9999999392252902907785028219223e-09));
            _203 = -_170;
        }
        else
        {
            float3 _200;
            float3 _201;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _182 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _134);
                _200 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _201 = -(_182 * rsqrt(fast::max(dot(_182, _182), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _198;
                float3 _199;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _192 = cross(_134, float3(0.0, 0.0, 1.0));
                    float3 _196 = _192 * rsqrt(fast::max(dot(_192, _192), 9.9999999392252902907785028219223e-09));
                    _198 = _196;
                    _199 = cross(_134, _196);
                }
                else
                {
                    _198 = _121;
                    _199 = _129;
                }
                _200 = _198;
                _201 = _199;
            }
            _202 = _200;
            _203 = _201;
        }
        _204 = _202;
        _205 = _203;
    }
    float _212 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _213 = sin(_212);
    float _214 = cos(_212);
    float3 _217 = (_205 * _213) + (_204 * _214);
    float3 _220 = (_205 * _214) - (_204 * _213);
    float2 _224 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _266;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _234 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _243 = _224.x;
        float _244 = _224.y;
        uint _251;
        if ((_243 * _244) < 0.0)
        {
            _251 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _234;
        }
        else
        {
            _251 = _234;
        }
        float4 _255 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _251)));
        float _257 = _255.x;
        float2 _260 = _72;
        _260.x = (_243 < 0.0) ? (1.0 - _257) : _257;
        float _262 = _255.y;
        float2 _265 = _260;
        _265.y = (_244 < 0.0) ? (1.0 - _262) : _262;
        _266 = _265;
    }
    else
    {
        _266 = in.in_var_ATTRIBUTE4;
    }
    float2 _272 = abs(in.in_var_ATTRIBUTE2.xy);
    float4 _303 = float4(((float4(_108 + View.View_PreViewTranslation, 1.0) + (float4(_217, 0.0) * (_272.x * (_266.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_220, 0.0) * (_272.y * (_266.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float3x3 _334;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _309 = _71;
        _309[2] = normalize(cross(_217, _220));
        _334 = _309;
    }
    else
    {
        float3x3 _333;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _319 = _71;
            _319[2] = normalize(_108 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _333 = _319;
        }
        else
        {
            float3x3 _332 = _71;
            _332[2] = normalize(_108 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _108 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _333 = _332;
        }
        _334 = _333;
    }
    float4 _341 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_303.x, _303.y, _303.z, _303.w);
    float4 _352;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_341.z < 0.0))
    {
        float4 _350 = _341;
        _350.z = 9.9999999747524270787835121154785e-07;
        float4 _351 = _350;
        _351.w = 1.0;
        _352 = _351;
    }
    else
    {
        _352 = _341;
    }
    float _358 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _334[2]));
    float4 _383 = _352;
    _383.z = ((_352.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_358) > 0.0) ? (sqrt(fast::clamp(1.0 - (_358 * _358), 0.0, 1.0)) / _358) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _352.w;
    out.out_var_TEXCOORD6 = 0.0;
    out.gl_Position = _383;
    return out;
}

