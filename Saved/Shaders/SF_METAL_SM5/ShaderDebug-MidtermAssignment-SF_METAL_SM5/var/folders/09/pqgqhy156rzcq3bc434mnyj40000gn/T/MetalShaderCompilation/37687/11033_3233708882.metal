

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

constant float3x3 _80 = {};
constant float2 _81 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
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
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVS_out Main_00002b19_c0be7b52(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _118 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _122 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _131 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _122), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _139 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _122), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _140 = View.View_WorldCameraOrigin - _118;
    float _141 = dot(_140, _140);
    float3 _144 = _140 * rsqrt(fast::max(_141, 9.9999999392252902907785028219223e-09));
    float3 _214;
    float3 _215;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _203 = cross(_144, float3(0.0, 0.0, 1.0));
        float3 _207 = _203 * rsqrt(fast::max(dot(_203, _203), 9.9999999392252902907785028219223e-09));
        float3 _209 = float3(fast::clamp((_141 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _214 = normalize(mix(_131, _207, _209));
        _215 = normalize(mix(_139, cross(_144, _207), _209));
    }
    else
    {
        float3 _194;
        float3 _195;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _183 = _118 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _187 = _183 * rsqrt(fast::max(dot(_183, _183), 9.9999999392252902907785028219223e-09));
            float3 _188 = cross(_144, _187);
            _194 = _188 * rsqrt(fast::max(dot(_188, _188), 9.9999999392252902907785028219223e-09));
            _195 = -_187;
        }
        else
        {
            float3 _181;
            float3 _182;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _175 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _144);
                _181 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _182 = -(_175 * rsqrt(fast::max(dot(_175, _175), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _173;
                float3 _174;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _167 = cross(_144, float3(0.0, 0.0, 1.0));
                    float3 _171 = _167 * rsqrt(fast::max(dot(_167, _167), 9.9999999392252902907785028219223e-09));
                    _173 = _171;
                    _174 = cross(_144, _171);
                }
                else
                {
                    _173 = _131;
                    _174 = _139;
                }
                _181 = _173;
                _182 = _174;
            }
            _194 = _181;
            _195 = _182;
        }
        _214 = _194;
        _215 = _195;
    }
    float _222 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _223 = sin(_222);
    float _224 = cos(_222);
    float3 _227 = (_215 * _223) + (_214 * _224);
    float3 _230 = (_215 * _224) - (_214 * _223);
    float2 _234 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _289;
    float2 _290;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _256 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _265 = _234.x;
        float _266 = _234.y;
        uint _273;
        if ((_265 * _266) < 0.0)
        {
            _273 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _256;
        }
        else
        {
            _273 = _256;
        }
        float4 _277 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _273)));
        float _280 = _277.x;
        float2 _283 = _81;
        _283.x = (_265 < 0.0) ? (1.0 - _280) : _280;
        float _285 = _277.y;
        float2 _288 = _283;
        _288.y = (_266 < 0.0) ? (1.0 - _285) : _285;
        _289 = _277.xy;
        _290 = _288;
    }
    else
    {
        float2 _246 = _81;
        _246.x = (_234.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _252 = _246;
        _252.y = (_234.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _289 = _252;
        _290 = in.in_var_ATTRIBUTE4;
    }
    float2 _296 = abs(in.in_var_ATTRIBUTE2.xy);
    float _322 = fract(in.in_var_ATTRIBUTE2.w);
    float _323 = in.in_var_ATTRIBUTE2.w - _322;
    float2 _336 = (float2(mod(_323, SpriteVF.SpriteVF_SubImageSize.x), floor(_323 * SpriteVF.SpriteVF_SubImageSize.z)) + _289) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _337 = _80;
    _337[0] = _227;
    float3x3 _338 = _337;
    _338[1] = _230;
    float3x3 _372;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _371 = _338;
        _371[2] = normalize(cross(_227, _230));
        _372 = _371;
    }
    else
    {
        float3x3 _368;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _367 = _338;
            _367[2] = normalize(_118 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _368 = _367;
        }
        else
        {
            float3x3 _361 = _338;
            _361[2] = normalize(_118 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _118 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _368 = _361;
        }
        _372 = _368;
    }
    float4 _376 = float4(((float4(_118 + View.View_PreViewTranslation, 1.0) + (float4(_227, 0.0) * (_296.x * (_290.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_230, 0.0) * (_296.y * (_290.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _377 = float4(_376.x, _376.y, _376.z, _376.w);
    float4 _380 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _377;
    float4 _391;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_380.z < 0.0))
    {
        float4 _389 = _380;
        _389.z = 9.9999999747524270787835121154785e-07;
        float4 _390 = _389;
        _390.w = 1.0;
        _391 = _390;
    }
    else
    {
        _391 = _380;
    }
    float _395 = _391.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _398 = _391;
    _398.z = _395 * _391.w;
    float4 _402 = float4(_372[0].x, _372[0].y, _372[0].z, float4(0.0).w);
    _402.w = _322;
    spvUnsafeArray<float4, 1> _412 = { float4(_336.x, _336.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _402;
    out.out_var_TEXCOORD11 = float4(_372[2], float(int(sign(determinant(_372)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out_var_TEXCOORD3 = _412;
    out.out_var_TEXCOORD6 = _395;
    out.out_var_TEXCOORD7 = _377;
    out.gl_Position = _398;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

