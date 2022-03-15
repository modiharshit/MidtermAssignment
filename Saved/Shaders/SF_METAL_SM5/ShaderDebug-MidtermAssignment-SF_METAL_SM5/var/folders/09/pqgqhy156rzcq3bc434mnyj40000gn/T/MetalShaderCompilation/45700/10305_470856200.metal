

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

constant float3x3 _77 = {};
constant float2 _78 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float out_var_TEXCOORD6 [[user(locn2)]];
    float out_var_TEXCOORD8 [[user(locn3)]];
    float3 out_var_TEXCOORD7 [[user(locn4)]];
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

vertex Main_out Main_00002841_1c10b208(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float3 _114 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _118 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _127 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _118), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _135 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _118), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _136 = View.View_WorldCameraOrigin - _114;
    float _137 = dot(_136, _136);
    float3 _140 = _136 * rsqrt(fast::max(_137, 9.9999999392252902907785028219223e-09));
    float3 _210;
    float3 _211;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _156 = cross(_140, float3(0.0, 0.0, 1.0));
        float3 _160 = _156 * rsqrt(fast::max(dot(_156, _156), 9.9999999392252902907785028219223e-09));
        float3 _162 = float3(fast::clamp((_137 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _210 = normalize(mix(_127, _160, _162));
        _211 = normalize(mix(_135, cross(_140, _160), _162));
    }
    else
    {
        float3 _208;
        float3 _209;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _172 = _114 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _176 = _172 * rsqrt(fast::max(dot(_172, _172), 9.9999999392252902907785028219223e-09));
            float3 _177 = cross(_140, _176);
            _208 = _177 * rsqrt(fast::max(dot(_177, _177), 9.9999999392252902907785028219223e-09));
            _209 = -_176;
        }
        else
        {
            float3 _206;
            float3 _207;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _188 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _140);
                _206 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _207 = -(_188 * rsqrt(fast::max(dot(_188, _188), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _204;
                float3 _205;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _198 = cross(_140, float3(0.0, 0.0, 1.0));
                    float3 _202 = _198 * rsqrt(fast::max(dot(_198, _198), 9.9999999392252902907785028219223e-09));
                    _204 = _202;
                    _205 = cross(_140, _202);
                }
                else
                {
                    _204 = _127;
                    _205 = _135;
                }
                _206 = _204;
                _207 = _205;
            }
            _208 = _206;
            _209 = _207;
        }
        _210 = _208;
        _211 = _209;
    }
    float _218 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _219 = sin(_218);
    float _220 = cos(_218);
    float3 _223 = (_211 * _219) + (_210 * _220);
    float3 _226 = (_211 * _220) - (_210 * _219);
    float2 _230 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _272;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _240 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _249 = _230.x;
        float _250 = _230.y;
        uint _257;
        if ((_249 * _250) < 0.0)
        {
            _257 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _240;
        }
        else
        {
            _257 = _240;
        }
        float4 _261 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _257)));
        float _263 = _261.x;
        float2 _266 = _78;
        _266.x = (_249 < 0.0) ? (1.0 - _263) : _263;
        float _268 = _261.y;
        float2 _271 = _266;
        _271.y = (_250 < 0.0) ? (1.0 - _268) : _268;
        _272 = _271;
    }
    else
    {
        _272 = in.in_var_ATTRIBUTE4;
    }
    float2 _278 = abs(in.in_var_ATTRIBUTE2.xy);
    float3x3 _305 = _77;
    _305[0] = _223;
    float3x3 _306 = _305;
    _306[1] = _226;
    bool _309 = SpriteVF.SpriteVF_NormalsType < 0.5;
    float3x3 _340;
    if (_309)
    {
        float3x3 _315 = _306;
        _315[2] = normalize(cross(_223, _226));
        _340 = _315;
    }
    else
    {
        float3x3 _339;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _325 = _306;
            _325[2] = normalize(_114 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _339 = _325;
        }
        else
        {
            float3x3 _338 = _306;
            _338[2] = normalize(_114 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _114 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _339 = _338;
        }
        _340 = _339;
    }
    float4 _344 = float4(((float4(_114 + View.View_PreViewTranslation, 1.0) + (float4(_223, 0.0) * (_278.x * (_272.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_226, 0.0) * (_278.y * (_272.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float3x3 _375;
    if (_309)
    {
        float3x3 _350 = _306;
        _350[2] = normalize(cross(_223, _226));
        _375 = _350;
    }
    else
    {
        float3x3 _374;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _360 = _306;
            _360[2] = normalize(_114 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _374 = _360;
        }
        else
        {
            float3x3 _373 = _306;
            _373[2] = normalize(_114 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _114 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _374 = _373;
        }
        _375 = _374;
    }
    float4 _382 = ShadowDepthPass.ShadowDepthPass_ProjectionMatrix * float4(_344.x, _344.y, _344.z, _344.w);
    float4 _393;
    if ((ShadowDepthPass.ShadowDepthPass_bClampToNearPlane > 0.0) && (_382.z < 0.0))
    {
        float4 _391 = _382;
        _391.z = 9.9999999747524270787835121154785e-07;
        float4 _392 = _391;
        _392.w = 1.0;
        _393 = _392;
    }
    else
    {
        _393 = _382;
    }
    float _399 = abs(dot(float3(ShadowDepthPass.ShadowDepthPass_ViewMatrix[0].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[1].z, ShadowDepthPass.ShadowDepthPass_ViewMatrix[2].z), _375[2]));
    float4 _420 = float4(_340[0].x, _340[0].y, _340[0].z, float4(0.0).w);
    _420.w = fract(in.in_var_ATTRIBUTE2.w);
    out.out_var_TEXCOORD10 = _420;
    out.out_var_TEXCOORD11 = float4(_340[2], float(int(sign(determinant(_340)))));
    out.out_var_TEXCOORD6 = _393.z;
    out.out_var_TEXCOORD8 = (ShadowDepthPass.ShadowDepthPass_ShadowParams.y * fast::clamp((abs(_399) > 0.0) ? (sqrt(fast::clamp(1.0 - (_399 * _399), 0.0, 1.0)) / _399) : ShadowDepthPass.ShadowDepthPass_ShadowParams.z, 0.0, ShadowDepthPass.ShadowDepthPass_ShadowParams.z)) + ShadowDepthPass.ShadowDepthPass_ShadowParams.x;
    out.out_var_TEXCOORD7 = _344.xyz;
    out.gl_Position = _393;
    return out;
}

