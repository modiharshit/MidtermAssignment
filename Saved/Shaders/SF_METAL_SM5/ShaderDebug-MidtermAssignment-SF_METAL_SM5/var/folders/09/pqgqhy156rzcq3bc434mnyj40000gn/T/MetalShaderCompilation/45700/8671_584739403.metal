

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
    char _m7_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m8_pad[640];
    int View_NumSceneColorMSAASamples;
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
constant float2 _74 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10 [[user(locn2)]];
    float4 out_var_TEXCOORD11 [[user(locn3)]];
    float4 gl_Position [[position, invariant]];
};

struct MainVertexShader_in
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

vertex MainVertexShader_out Main_000021df_22da6a4b(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
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
        float3 _159 = cross(_143, float3(0.0, 0.0, 1.0));
        float3 _163 = _159 * rsqrt(fast::max(dot(_159, _159), 9.9999999392252902907785028219223e-09));
        float3 _165 = float3(fast::clamp((_140 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _213 = normalize(mix(_130, _163, _165));
        _214 = normalize(mix(_138, cross(_143, _163), _165));
    }
    else
    {
        float3 _211;
        float3 _212;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _175 = _117 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _179 = _175 * rsqrt(fast::max(dot(_175, _175), 9.9999999392252902907785028219223e-09));
            float3 _180 = cross(_143, _179);
            _211 = _180 * rsqrt(fast::max(dot(_180, _180), 9.9999999392252902907785028219223e-09));
            _212 = -_179;
        }
        else
        {
            float3 _209;
            float3 _210;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _191 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _143);
                _209 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _210 = -(_191 * rsqrt(fast::max(dot(_191, _191), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _207;
                float3 _208;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _201 = cross(_143, float3(0.0, 0.0, 1.0));
                    float3 _205 = _201 * rsqrt(fast::max(dot(_201, _201), 9.9999999392252902907785028219223e-09));
                    _207 = _205;
                    _208 = cross(_143, _205);
                }
                else
                {
                    _207 = _130;
                    _208 = _138;
                }
                _209 = _207;
                _210 = _208;
            }
            _211 = _209;
            _212 = _210;
        }
        _213 = _211;
        _214 = _212;
    }
    float _221 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _222 = sin(_221);
    float _223 = cos(_221);
    float3 _226 = (_214 * _222) + (_213 * _223);
    float3 _229 = (_214 * _223) - (_213 * _222);
    float2 _233 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _275;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _243 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _252 = _233.x;
        float _253 = _233.y;
        uint _260;
        if ((_252 * _253) < 0.0)
        {
            _260 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _243;
        }
        else
        {
            _260 = _243;
        }
        float4 _264 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _260)));
        float _266 = _264.x;
        float2 _269 = _74;
        _269.x = (_252 < 0.0) ? (1.0 - _266) : _266;
        float _271 = _264.y;
        float2 _274 = _269;
        _274.y = (_253 < 0.0) ? (1.0 - _271) : _271;
        _275 = _274;
    }
    else
    {
        _275 = in.in_var_ATTRIBUTE4;
    }
    float2 _281 = abs(in.in_var_ATTRIBUTE2.xy);
    float3x3 _308 = _72;
    _308[0] = _226;
    float3x3 _309 = _308;
    _309[1] = _229;
    float3x3 _343;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _318 = _309;
        _318[2] = normalize(cross(_226, _229));
        _343 = _318;
    }
    else
    {
        float3x3 _342;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _328 = _309;
            _328[2] = normalize(_117 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _342 = _328;
        }
        else
        {
            float3x3 _341 = _309;
            _341[2] = normalize(_117 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _117 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _342 = _341;
        }
        _343 = _342;
    }
    float4 _349 = float4(_343[0].x, _343[0].y, _343[0].z, float4(0.0).w);
    _349.w = fract(in.in_var_ATTRIBUTE2.w);
    float4 _359 = float4(((float4(_117 + View.View_PreViewTranslation, 1.0) + (float4(_226, 0.0) * (_281.x * (_275.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_229, 0.0) * (_281.y * (_275.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _361 = View.View_TranslatedWorldToClip * _359;
    float4 _368 = _361;
    _368.z = _361.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _361.w) : 0.0);
    out.gl_Position = _368;
    out.out_var_TEXCOORD6 = _361;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _359;
    out.out_var_TEXCOORD10 = _349;
    out.out_var_TEXCOORD11 = float4(_343[2], float(int(sign(determinant(_343)))));
    return out;
}

