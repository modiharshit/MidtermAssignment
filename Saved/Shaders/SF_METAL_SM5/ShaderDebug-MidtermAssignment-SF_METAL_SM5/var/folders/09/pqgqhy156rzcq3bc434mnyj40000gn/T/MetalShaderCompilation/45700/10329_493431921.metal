

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

constant float3x3 _75 = {};
constant float2 _77 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float3 out_var_TEXCOORD7 [[user(locn3)]];
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

vertex Main_out Main_00002859_1d692c71(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float3 _113 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _117 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _126 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _117), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _134 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _117), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _135 = View.View_WorldCameraOrigin - _113;
    float _136 = dot(_135, _135);
    float3 _139 = _135 * rsqrt(fast::max(_136, 9.9999999392252902907785028219223e-09));
    float3 _209;
    float3 _210;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _155 = cross(_139, float3(0.0, 0.0, 1.0));
        float3 _159 = _155 * rsqrt(fast::max(dot(_155, _155), 9.9999999392252902907785028219223e-09));
        float3 _161 = float3(fast::clamp((_136 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _209 = normalize(mix(_126, _159, _161));
        _210 = normalize(mix(_134, cross(_139, _159), _161));
    }
    else
    {
        float3 _207;
        float3 _208;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _171 = _113 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _175 = _171 * rsqrt(fast::max(dot(_171, _171), 9.9999999392252902907785028219223e-09));
            float3 _176 = cross(_139, _175);
            _207 = _176 * rsqrt(fast::max(dot(_176, _176), 9.9999999392252902907785028219223e-09));
            _208 = -_175;
        }
        else
        {
            float3 _205;
            float3 _206;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _187 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _139);
                _205 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _206 = -(_187 * rsqrt(fast::max(dot(_187, _187), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _203;
                float3 _204;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _197 = cross(_139, float3(0.0, 0.0, 1.0));
                    float3 _201 = _197 * rsqrt(fast::max(dot(_197, _197), 9.9999999392252902907785028219223e-09));
                    _203 = _201;
                    _204 = cross(_139, _201);
                }
                else
                {
                    _203 = _126;
                    _204 = _134;
                }
                _205 = _203;
                _206 = _204;
            }
            _207 = _205;
            _208 = _206;
        }
        _209 = _207;
        _210 = _208;
    }
    float _217 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _218 = sin(_217);
    float _219 = cos(_217);
    float3 _222 = (_210 * _218) + (_209 * _219);
    float3 _225 = (_210 * _219) - (_209 * _218);
    float2 _229 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _271;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _239 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _248 = _229.x;
        float _249 = _229.y;
        uint _256;
        if ((_248 * _249) < 0.0)
        {
            _256 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _239;
        }
        else
        {
            _256 = _239;
        }
        float4 _260 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _256)));
        float _262 = _260.x;
        float2 _265 = _77;
        _265.x = (_248 < 0.0) ? (1.0 - _262) : _262;
        float _267 = _260.y;
        float2 _270 = _265;
        _270.y = (_249 < 0.0) ? (1.0 - _267) : _267;
        _271 = _270;
    }
    else
    {
        _271 = in.in_var_ATTRIBUTE4;
    }
    float2 _277 = abs(in.in_var_ATTRIBUTE2.xy);
    float3x3 _304 = _75;
    _304[0] = _222;
    float3x3 _305 = _304;
    _305[1] = _225;
    bool _308 = SpriteVF.SpriteVF_NormalsType < 0.5;
    float3x3 _339;
    if (_308)
    {
        float3x3 _314 = _305;
        _314[2] = normalize(cross(_222, _225));
        _339 = _314;
    }
    else
    {
        float3x3 _338;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _324 = _305;
            _324[2] = normalize(_113 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _338 = _324;
        }
        else
        {
            float3x3 _337 = _305;
            _337[2] = normalize(_113 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _113 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _338 = _337;
        }
        _339 = _338;
    }
    float4 _343 = float4(((float4(_113 + View.View_PreViewTranslation, 1.0) + (float4(_222, 0.0) * (_277.x * (_271.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_225, 0.0) * (_277.y * (_271.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float3x3 _374;
    if (_308)
    {
        float3x3 _349 = _75;
        _349[2] = normalize(cross(_222, _225));
        _374 = _349;
    }
    else
    {
        float3x3 _373;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _359 = _75;
            _359[2] = normalize(_113 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _373 = _359;
        }
        else
        {
            float3x3 _372 = _75;
            _372[2] = normalize(_113 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _113 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _373 = _372;
        }
        _374 = _373;
    }
    float4 _381 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_343.x, _343.y, _343.z, _343.w);
    float4 _392;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_381.z < 0.0))
    {
        float4 _390 = _381;
        _390.z = 9.9999999747524270787835121154785e-07;
        float4 _391 = _390;
        _391.w = 1.0;
        _392 = _391;
    }
    else
    {
        _392 = _381;
    }
    float _398 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _374[2]));
    float4 _423 = _392;
    _423.z = ((_392.z * ShadowDepthPass.ShadowDepthPass_ShadowParams.w) + ((ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_398) > 0.0) ? (sqrt(fast::clamp(1.0 - (_398 * _398), 0.0, 1.0)) / _398) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x)) * _392.w;
    float4 _426 = float4(_339[0].x, _339[0].y, _339[0].z, float4(0.0).w);
    _426.w = fract(in.in_var_ATTRIBUTE2.w);
    out.out_var_TEXCOORD10 = _426;
    out.out_var_TEXCOORD11 = float4(_339[2], float(int(sign(determinant(_339)))));
    out.out_var_TEXCOORD6 = 0.0;
    out.out_var_TEXCOORD7 = _343.xyz;
    out.gl_Position = _423;
    return out;
}

