

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

constant float3x3 _77 = {};
constant float2 _78 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
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

vertex MainVS_out Main_000027b4_df2646c4(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    float3 _115 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _119 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _128 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _119), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _136 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _119), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _137 = View.View_WorldCameraOrigin - _115;
    float _138 = dot(_137, _137);
    float3 _141 = _137 * rsqrt(fast::max(_138, 9.9999999392252902907785028219223e-09));
    float3 _211;
    float3 _212;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _157 = cross(_141, float3(0.0, 0.0, 1.0));
        float3 _161 = _157 * rsqrt(fast::max(dot(_157, _157), 9.9999999392252902907785028219223e-09));
        float3 _163 = float3(fast::clamp((_138 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _211 = normalize(mix(_128, _161, _163));
        _212 = normalize(mix(_136, cross(_141, _161), _163));
    }
    else
    {
        float3 _209;
        float3 _210;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _173 = _115 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _177 = _173 * rsqrt(fast::max(dot(_173, _173), 9.9999999392252902907785028219223e-09));
            float3 _178 = cross(_141, _177);
            _209 = _178 * rsqrt(fast::max(dot(_178, _178), 9.9999999392252902907785028219223e-09));
            _210 = -_177;
        }
        else
        {
            float3 _207;
            float3 _208;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _189 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _141);
                _207 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _208 = -(_189 * rsqrt(fast::max(dot(_189, _189), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _205;
                float3 _206;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _199 = cross(_141, float3(0.0, 0.0, 1.0));
                    float3 _203 = _199 * rsqrt(fast::max(dot(_199, _199), 9.9999999392252902907785028219223e-09));
                    _205 = _203;
                    _206 = cross(_141, _203);
                }
                else
                {
                    _205 = _128;
                    _206 = _136;
                }
                _207 = _205;
                _208 = _206;
            }
            _209 = _207;
            _210 = _208;
        }
        _211 = _209;
        _212 = _210;
    }
    float _219 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _220 = sin(_219);
    float _221 = cos(_219);
    float3 _224 = (_212 * _220) + (_211 * _221);
    float3 _227 = (_212 * _221) - (_211 * _220);
    float2 _231 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _286;
    float2 _287;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _241 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _250 = _231.x;
        float _251 = _231.y;
        uint _258;
        if ((_250 * _251) < 0.0)
        {
            _258 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _241;
        }
        else
        {
            _258 = _241;
        }
        float4 _262 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _258)));
        float _265 = _262.x;
        float2 _268 = _78;
        _268.x = (_250 < 0.0) ? (1.0 - _265) : _265;
        float _270 = _262.y;
        float2 _273 = _268;
        _273.y = (_251 < 0.0) ? (1.0 - _270) : _270;
        _286 = _262.xy;
        _287 = _273;
    }
    else
    {
        float2 _279 = _78;
        _279.x = (_231.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _285 = _279;
        _285.y = (_231.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _286 = _285;
        _287 = in.in_var_ATTRIBUTE4;
    }
    float2 _293 = abs(in.in_var_ATTRIBUTE2.xy);
    float _319 = fract(in.in_var_ATTRIBUTE2.w);
    float _320 = in.in_var_ATTRIBUTE2.w - _319;
    float _321 = _320 + 1.0;
    float2 _337 = (float2(mod(_320, SpriteVF.SpriteVF_SubImageSize.x), floor(_320 * SpriteVF.SpriteVF_SubImageSize.z)) + _286) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _340 = (float2(mod(_321, SpriteVF.SpriteVF_SubImageSize.x), floor(_321 * SpriteVF.SpriteVF_SubImageSize.z)) + _286) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _341 = _77;
    _341[0] = _224;
    float3x3 _342 = _341;
    _342[1] = _227;
    float3x3 _376;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _351 = _342;
        _351[2] = normalize(cross(_224, _227));
        _376 = _351;
    }
    else
    {
        float3x3 _375;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _361 = _342;
            _361[2] = normalize(_115 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _375 = _361;
        }
        else
        {
            float3x3 _374 = _342;
            _374[2] = normalize(_115 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _115 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _375 = _374;
        }
        _376 = _375;
    }
    float4 _380 = float4(((float4(_115 + View.View_PreViewTranslation, 1.0) + (float4(_224, 0.0) * (_293.x * (_287.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_227, 0.0) * (_293.y * (_287.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _381 = float4(_380.x, _380.y, _380.z, _380.w);
    float4 _384 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _381;
    float4 _395;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_384.z < 0.0))
    {
        float4 _393 = _384;
        _393.z = 9.9999999747524270787835121154785e-07;
        float4 _394 = _393;
        _394.w = 1.0;
        _395 = _394;
    }
    else
    {
        _395 = _384;
    }
    float _399 = _395.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _402 = _395;
    _402.z = _399 * _395.w;
    float4 _406 = float4(_376[0].x, _376[0].y, _376[0].z, float4(0.0).w);
    _406.w = _319;
    out.out_var_TEXCOORD10 = _406;
    out.out_var_TEXCOORD11 = float4(_376[2], float(int(sign(determinant(_376)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_337.x, _337.y, _340.x, _340.y);
    out.out_var_TEXCOORD6 = _399;
    out.out_var_TEXCOORD7 = _381;
    out.gl_Position = _402;
    return out;
}

