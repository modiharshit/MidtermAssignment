

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

constant float3x3 _72 = {};
constant float2 _73 = {};

struct Main_out
{
    float out_var_TEXCOORD6 [[user(locn0)]];
    float out_var_TEXCOORD8 [[user(locn1)]];
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

vertex Main_out Main_00002337_4cdbde78(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float3 _109 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _113 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _122 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _113), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _130 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _113), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _131 = View.View_WorldCameraOrigin - _109;
    float _132 = dot(_131, _131);
    float3 _135 = _131 * rsqrt(fast::max(_132, 9.9999999392252902907785028219223e-09));
    float3 _205;
    float3 _206;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _151 = cross(_135, float3(0.0, 0.0, 1.0));
        float3 _155 = _151 * rsqrt(fast::max(dot(_151, _151), 9.9999999392252902907785028219223e-09));
        float3 _157 = float3(fast::clamp((_132 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _205 = normalize(mix(_122, _155, _157));
        _206 = normalize(mix(_130, cross(_135, _155), _157));
    }
    else
    {
        float3 _203;
        float3 _204;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _167 = _109 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _171 = _167 * rsqrt(fast::max(dot(_167, _167), 9.9999999392252902907785028219223e-09));
            float3 _172 = cross(_135, _171);
            _203 = _172 * rsqrt(fast::max(dot(_172, _172), 9.9999999392252902907785028219223e-09));
            _204 = -_171;
        }
        else
        {
            float3 _201;
            float3 _202;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _183 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _135);
                _201 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _202 = -(_183 * rsqrt(fast::max(dot(_183, _183), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _199;
                float3 _200;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _193 = cross(_135, float3(0.0, 0.0, 1.0));
                    float3 _197 = _193 * rsqrt(fast::max(dot(_193, _193), 9.9999999392252902907785028219223e-09));
                    _199 = _197;
                    _200 = cross(_135, _197);
                }
                else
                {
                    _199 = _122;
                    _200 = _130;
                }
                _201 = _199;
                _202 = _200;
            }
            _203 = _201;
            _204 = _202;
        }
        _205 = _203;
        _206 = _204;
    }
    float _213 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _214 = sin(_213);
    float _215 = cos(_213);
    float3 _218 = (_206 * _214) + (_205 * _215);
    float3 _221 = (_206 * _215) - (_205 * _214);
    float2 _225 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _267;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _235 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _244 = _225.x;
        float _245 = _225.y;
        uint _252;
        if ((_244 * _245) < 0.0)
        {
            _252 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _235;
        }
        else
        {
            _252 = _235;
        }
        float4 _256 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _252)));
        float _258 = _256.x;
        float2 _261 = _73;
        _261.x = (_244 < 0.0) ? (1.0 - _258) : _258;
        float _263 = _256.y;
        float2 _266 = _261;
        _266.y = (_245 < 0.0) ? (1.0 - _263) : _263;
        _267 = _266;
    }
    else
    {
        _267 = in.in_var_ATTRIBUTE4;
    }
    float2 _273 = abs(in.in_var_ATTRIBUTE2.xy);
    float4 _301 = float4(((float4(_109 + View.View_PreViewTranslation, 1.0) + (float4(_218, 0.0) * (_273.x * (_267.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_221, 0.0) * (_273.y * (_267.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float3x3 _335;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _310 = _72;
        _310[2] = normalize(cross(_218, _221));
        _335 = _310;
    }
    else
    {
        float3x3 _334;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _320 = _72;
            _320[2] = normalize(_109 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _334 = _320;
        }
        else
        {
            float3x3 _333 = _72;
            _333[2] = normalize(_109 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _109 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _334 = _333;
        }
        _335 = _334;
    }
    float4 _342 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_301.x, _301.y, _301.z, _301.w);
    float4 _353;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_342.z < 0.0))
    {
        float4 _351 = _342;
        _351.z = 9.9999999747524270787835121154785e-07;
        float4 _352 = _351;
        _352.w = 1.0;
        _353 = _352;
    }
    else
    {
        _353 = _342;
    }
    float _359 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _335[2]));
    out.out_var_TEXCOORD6 = _353.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_359) > 0.0) ? (sqrt(fast::clamp(1.0 - (_359 * _359), 0.0, 1.0)) / _359) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.gl_Position = _353;
    return out;
}

