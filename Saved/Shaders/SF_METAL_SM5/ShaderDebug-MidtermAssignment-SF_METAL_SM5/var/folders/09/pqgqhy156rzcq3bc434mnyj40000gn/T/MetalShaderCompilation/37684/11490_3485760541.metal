

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
    float TranslucentDepthPass_InvMaxSubjectDepth;
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

constant float3x3 _82 = {};
constant float2 _83 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn5)]];
    float out_var_TEXCOORD6 [[user(locn6)]];
    float4 out_var_TEXCOORD7 [[user(locn7)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVS_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float4 in_var_ATTRIBUTE3 [[attribute(3)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVS_out Main_00002ce2_cfc47c1d(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _121 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _125 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _134 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _125), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _142 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _125), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _143 = View.View_WorldCameraOrigin - _121;
    float _144 = dot(_143, _143);
    float3 _147 = _143 * rsqrt(fast::max(_144, 9.9999999392252902907785028219223e-09));
    float3 _217;
    float3 _218;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _206 = cross(_147, float3(0.0, 0.0, 1.0));
        float3 _210 = _206 * rsqrt(fast::max(dot(_206, _206), 9.9999999392252902907785028219223e-09));
        float3 _212 = float3(fast::clamp((_144 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _217 = normalize(mix(_134, _210, _212));
        _218 = normalize(mix(_142, cross(_147, _210), _212));
    }
    else
    {
        float3 _197;
        float3 _198;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _186 = _121 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _190 = _186 * rsqrt(fast::max(dot(_186, _186), 9.9999999392252902907785028219223e-09));
            float3 _191 = cross(_147, _190);
            _197 = _191 * rsqrt(fast::max(dot(_191, _191), 9.9999999392252902907785028219223e-09));
            _198 = -_190;
        }
        else
        {
            float3 _184;
            float3 _185;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _178 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _147);
                _184 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _185 = -(_178 * rsqrt(fast::max(dot(_178, _178), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _176;
                float3 _177;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _170 = cross(_147, float3(0.0, 0.0, 1.0));
                    float3 _174 = _170 * rsqrt(fast::max(dot(_170, _170), 9.9999999392252902907785028219223e-09));
                    _176 = _174;
                    _177 = cross(_147, _174);
                }
                else
                {
                    _176 = _134;
                    _177 = _142;
                }
                _184 = _176;
                _185 = _177;
            }
            _197 = _184;
            _198 = _185;
        }
        _217 = _197;
        _218 = _198;
    }
    float _225 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _226 = sin(_225);
    float _227 = cos(_225);
    float3 _230 = (_218 * _226) + (_217 * _227);
    float3 _233 = (_218 * _227) - (_217 * _226);
    float2 _237 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _292;
    float2 _293;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _259 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _268 = _237.x;
        float _269 = _237.y;
        uint _276;
        if ((_268 * _269) < 0.0)
        {
            _276 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _259;
        }
        else
        {
            _276 = _259;
        }
        float4 _280 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _276)));
        float _283 = _280.x;
        float2 _286 = _83;
        _286.x = (_268 < 0.0) ? (1.0 - _283) : _283;
        float _288 = _280.y;
        float2 _291 = _286;
        _291.y = (_269 < 0.0) ? (1.0 - _288) : _288;
        _292 = _280.xy;
        _293 = _291;
    }
    else
    {
        float2 _249 = _83;
        _249.x = (_237.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _255 = _249;
        _255.y = (_237.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _292 = _255;
        _293 = in.in_var_ATTRIBUTE4;
    }
    float2 _299 = abs(in.in_var_ATTRIBUTE2.xy);
    float _325 = fract(in.in_var_ATTRIBUTE2.w);
    float _326 = in.in_var_ATTRIBUTE2.w - _325;
    float _327 = _326 + 1.0;
    float2 _343 = (float2(mod(_326, SpriteVF.SpriteVF_SubImageSize.x), floor(_326 * SpriteVF.SpriteVF_SubImageSize.z)) + _292) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _346 = (float2(mod(_327, SpriteVF.SpriteVF_SubImageSize.x), floor(_327 * SpriteVF.SpriteVF_SubImageSize.z)) + _292) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _347 = _82;
    _347[0] = _230;
    float3x3 _348 = _347;
    _348[1] = _233;
    float3x3 _382;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _381 = _348;
        _381[2] = normalize(cross(_230, _233));
        _382 = _381;
    }
    else
    {
        float3x3 _378;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _377 = _348;
            _377[2] = normalize(_121 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _378 = _377;
        }
        else
        {
            float3x3 _371 = _348;
            _371[2] = normalize(_121 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _121 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _378 = _371;
        }
        _382 = _378;
    }
    float4 _386 = float4(((float4(_121 + View.View_PreViewTranslation, 1.0) + (float4(_230, 0.0) * (_299.x * (_293.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_233, 0.0) * (_299.y * (_293.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _387 = float4(_386.x, _386.y, _386.z, _386.w);
    float4 _390 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _387;
    float4 _401;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_390.z < 0.0))
    {
        float4 _399 = _390;
        _399.z = 9.9999999747524270787835121154785e-07;
        float4 _400 = _399;
        _400.w = 1.0;
        _401 = _400;
    }
    else
    {
        _401 = _390;
    }
    float _405 = _401.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _408 = _401;
    _408.z = _405 * _401.w;
    float4 _413 = float4(_382[0].x, _382[0].y, _382[0].z, float4(0.0).w);
    _413.w = _325;
    spvUnsafeArray<float4, 1> _423 = { float4(_343.x, _343.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _413;
    out.out_var_TEXCOORD11 = float4(_382[2], float(int(sign(determinant(_382)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _423;
    out.out_var_PARTICLE_SUBUVS = float4(_343.x, _343.y, _346.x, _346.y);
    out.out_var_TEXCOORD6 = _405;
    out.out_var_TEXCOORD7 = _387;
    out.gl_Position = _408;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

