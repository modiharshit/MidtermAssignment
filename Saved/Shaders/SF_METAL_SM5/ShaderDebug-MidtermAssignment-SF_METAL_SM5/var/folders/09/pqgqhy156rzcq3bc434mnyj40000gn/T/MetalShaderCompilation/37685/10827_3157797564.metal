

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
    char _m4_pad[32];
    float3 View_WorldCameraOrigin;
    char _m5_pad[32];
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

constant float3x3 _79 = {};
constant float2 _80 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float out_var_TEXCOORD6 [[user(locn4)]];
    float4 out_var_TEXCOORD7 [[user(locn5)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVS_out Main_00002a4b_bc382abc(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _117 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _121 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _130 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _121), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _138 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _121), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _139 = View.View_WorldCameraOrigin - _117;
    float _140 = dot(_139, _139);
    float3 _143 = _139 * rsqrt(fast::max(_140, 9.9999999392252902907785028219223e-09));
    float3 _213;
    float3 _214;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _202 = cross(_143, float3(0.0, 0.0, 1.0));
        float3 _206 = _202 * rsqrt(fast::max(dot(_202, _202), 9.9999999392252902907785028219223e-09));
        float3 _208 = float3(fast::clamp((_140 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _213 = normalize(mix(_130, _206, _208));
        _214 = normalize(mix(_138, cross(_143, _206), _208));
    }
    else
    {
        float3 _193;
        float3 _194;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _182 = _117 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _186 = _182 * rsqrt(fast::max(dot(_182, _182), 9.9999999392252902907785028219223e-09));
            float3 _187 = cross(_143, _186);
            _193 = _187 * rsqrt(fast::max(dot(_187, _187), 9.9999999392252902907785028219223e-09));
            _194 = -_186;
        }
        else
        {
            float3 _180;
            float3 _181;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _174 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _143);
                _180 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _181 = -(_174 * rsqrt(fast::max(dot(_174, _174), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _172;
                float3 _173;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _166 = cross(_143, float3(0.0, 0.0, 1.0));
                    float3 _170 = _166 * rsqrt(fast::max(dot(_166, _166), 9.9999999392252902907785028219223e-09));
                    _172 = _170;
                    _173 = cross(_143, _170);
                }
                else
                {
                    _172 = _130;
                    _173 = _138;
                }
                _180 = _172;
                _181 = _173;
            }
            _193 = _180;
            _194 = _181;
        }
        _213 = _193;
        _214 = _194;
    }
    float _221 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _222 = sin(_221);
    float _223 = cos(_221);
    float3 _226 = (_214 * _222) + (_213 * _223);
    float3 _229 = (_214 * _223) - (_213 * _222);
    float2 _233 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _288;
    float2 _289;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _255 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _264 = _233.x;
        float _265 = _233.y;
        uint _272;
        if ((_264 * _265) < 0.0)
        {
            _272 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _255;
        }
        else
        {
            _272 = _255;
        }
        float4 _276 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _272)));
        float _279 = _276.x;
        float2 _282 = _80;
        _282.x = (_264 < 0.0) ? (1.0 - _279) : _279;
        float _284 = _276.y;
        float2 _287 = _282;
        _287.y = (_265 < 0.0) ? (1.0 - _284) : _284;
        _288 = _276.xy;
        _289 = _287;
    }
    else
    {
        float2 _245 = _80;
        _245.x = (_233.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _251 = _245;
        _251.y = (_233.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _288 = _251;
        _289 = in.in_var_ATTRIBUTE4;
    }
    float2 _295 = abs(in.in_var_ATTRIBUTE2.xy);
    float _321 = fract(in.in_var_ATTRIBUTE2.w);
    float _322 = in.in_var_ATTRIBUTE2.w - _321;
    float2 _335 = (float2(mod(_322, SpriteVF.SpriteVF_SubImageSize.x), floor(_322 * SpriteVF.SpriteVF_SubImageSize.z)) + _288) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _336 = _79;
    _336[0] = _226;
    float3x3 _337 = _336;
    _337[1] = _229;
    float3x3 _371;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _370 = _337;
        _370[2] = normalize(cross(_226, _229));
        _371 = _370;
    }
    else
    {
        float3x3 _367;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _366 = _337;
            _366[2] = normalize(_117 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _367 = _366;
        }
        else
        {
            float3x3 _360 = _337;
            _360[2] = normalize(_117 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _117 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _367 = _360;
        }
        _371 = _367;
    }
    float4 _375 = float4(((float4(_117 + View.View_PreViewTranslation, 1.0) + (float4(_226, 0.0) * (_295.x * (_289.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_229, 0.0) * (_295.y * (_289.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _376 = float4(_375.x, _375.y, _375.z, _375.w);
    float4 _379 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _376;
    float4 _390;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_379.z < 0.0))
    {
        float4 _388 = _379;
        _388.z = 9.9999999747524270787835121154785e-07;
        float4 _389 = _388;
        _389.w = 1.0;
        _390 = _389;
    }
    else
    {
        _390 = _379;
    }
    float4 _395 = float4(_371[0].x, _371[0].y, _371[0].z, float4(0.0).w);
    _395.w = _321;
    spvUnsafeArray<float4, 1> _405 = { float4(_335.x, _335.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _395;
    out.out_var_TEXCOORD11 = float4(_371[2], float(int(sign(determinant(_371)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _405;
    out.out_var_TEXCOORD6 = _390.z;
    out.out_var_TEXCOORD7 = _376;
    out.gl_Position = _390;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

