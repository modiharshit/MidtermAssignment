

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

constant float3x3 _67 = {};
constant float2 _69 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
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

vertex Main_out Main_0000232e_6fdd75b0(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _99 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _102 = Primitive.Primitive_LocalToWorld * _99;
    float3 _108 = _102.xyz;
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
    float _211 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _212 = _211 + SpriteVF.SpriteVF_RotationBias;
    float _213 = sin(_212);
    float _214 = cos(_212);
    float3 _215 = _205 * _213;
    float3 _216 = _204 * _214;
    float3 _217 = _215 + _216;
    float3 _218 = _205 * _214;
    float3 _219 = _204 * _213;
    float3 _220 = _218 - _219;
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
        float2 _260 = _69;
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
    float3 _267 = _108 + View.View_PreViewTranslation;
    float _268 = _267.x;
    float _269 = _267.y;
    float _270 = _267.z;
    float4 _271 = float4(_268, _269, _270, 1.0);
    float2 _272 = abs(in.in_var_ATTRIBUTE2.xy);
    float _273 = _217.x;
    float _274 = _217.y;
    float _275 = _217.z;
    float4 _276 = float4(_273, _274, _275, 0.0);
    float _277 = _272.x;
    float _281 = _266.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _282 = _277 * _281;
    float4 _283 = _276 * _282;
    float4 _284 = _271 + _283;
    float _285 = _220.x;
    float _286 = _220.y;
    float _287 = _220.z;
    float4 _288 = float4(_285, _286, _287, 0.0);
    float _289 = _272.y;
    float _293 = _266.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _294 = _289 * _293;
    float4 _295 = _288 * _294;
    float4 _296 = _284 + _295;
    float3x3 _299 = _67;
    _299[0] = _217;
    float3x3 _300 = _299;
    _300[1] = _220;
    float3x3 _334;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _309 = _300;
        _309[2] = normalize(cross(_217, _220));
        _334 = _309;
    }
    else
    {
        float3x3 _333;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _319 = _300;
            _319[2] = normalize(_108 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _333 = _319;
        }
        else
        {
            float3x3 _332 = _300;
            _332[2] = normalize(_108 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _108 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _333 = _332;
        }
        _334 = _333;
    }
    float _335 = _296.x;
    float _336 = _296.y;
    float _337 = _296.z;
    float4 _338 = float4(_335, _336, _337, 1.0);
    float4 _339 = float4(_338.x, _338.y, _338.z, _338.w);
    float4 _340 = View.View_TranslatedWorldToClip * _339;
    float4 _343 = float4(_334[0].x, _334[0].y, _334[0].z, float4(0.0).w);
    _343.w = fract(in.in_var_ATTRIBUTE2.w);
    out.out_var_TEXCOORD10 = _343;
    out.out_var_TEXCOORD11 = float4(_334[2], float(int(sign(determinant(_334)))));
    out.gl_Position = _340;
    return out;
}

