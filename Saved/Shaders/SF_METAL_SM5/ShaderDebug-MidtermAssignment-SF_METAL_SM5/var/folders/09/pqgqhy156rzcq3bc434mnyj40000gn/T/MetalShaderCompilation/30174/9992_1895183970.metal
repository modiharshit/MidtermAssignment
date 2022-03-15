

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

struct type_ShadowDepthPass
{
    char _m0_pad[464];
    spvUnsafeArray<float4x4, 6> ShadowDepthPass_ShadowViewProjectionMatrices;
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
    uint LayerId;
};

constant float3x3 _75 = {};
constant float2 _76 = {};

struct Main_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float3 out_var_TEXCOORD8 [[user(locn1)]];
    uint gl_Layer [[render_target_array_index]];
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

vertex Main_out Main_00002708_70f63662(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    float4 _103 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _106 = Primitive.Primitive_LocalToWorld * _103;
    float3 _112 = _106.xyz;
    float3 _116 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _125 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _116), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _133 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _116), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _134 = View.View_WorldCameraOrigin - _112;
    float _135 = dot(_134, _134);
    float3 _138 = _134 * rsqrt(fast::max(_135, 9.9999999392252902907785028219223e-09));
    float3 _208;
    float3 _209;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _154 = cross(_138, float3(0.0, 0.0, 1.0));
        float3 _158 = _154 * rsqrt(fast::max(dot(_154, _154), 9.9999999392252902907785028219223e-09));
        float3 _160 = float3(fast::clamp((_135 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _208 = normalize(mix(_125, _158, _160));
        _209 = normalize(mix(_133, cross(_138, _158), _160));
    }
    else
    {
        float3 _206;
        float3 _207;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _170 = _112 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _174 = _170 * rsqrt(fast::max(dot(_170, _170), 9.9999999392252902907785028219223e-09));
            float3 _175 = cross(_138, _174);
            _206 = _175 * rsqrt(fast::max(dot(_175, _175), 9.9999999392252902907785028219223e-09));
            _207 = -_174;
        }
        else
        {
            float3 _204;
            float3 _205;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _186 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _138);
                _204 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _205 = -(_186 * rsqrt(fast::max(dot(_186, _186), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _202;
                float3 _203;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _196 = cross(_138, float3(0.0, 0.0, 1.0));
                    float3 _200 = _196 * rsqrt(fast::max(dot(_196, _196), 9.9999999392252902907785028219223e-09));
                    _202 = _200;
                    _203 = cross(_138, _200);
                }
                else
                {
                    _202 = _125;
                    _203 = _133;
                }
                _204 = _202;
                _205 = _203;
            }
            _206 = _204;
            _207 = _205;
        }
        _208 = _206;
        _209 = _207;
    }
    float _215 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _216 = _215 + SpriteVF.SpriteVF_RotationBias;
    float _217 = sin(_216);
    float _218 = cos(_216);
    float3 _219 = _209 * _217;
    float3 _220 = _208 * _218;
    float3 _221 = _219 + _220;
    float3 _222 = _209 * _218;
    float3 _223 = _208 * _217;
    float3 _224 = _222 - _223;
    float2 _228 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _270;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _238 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _247 = _228.x;
        float _248 = _228.y;
        uint _255;
        if ((_247 * _248) < 0.0)
        {
            _255 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _238;
        }
        else
        {
            _255 = _238;
        }
        float4 _259 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _255)));
        float _261 = _259.x;
        float2 _264 = _76;
        _264.x = (_247 < 0.0) ? (1.0 - _261) : _261;
        float _266 = _259.y;
        float2 _269 = _264;
        _269.y = (_248 < 0.0) ? (1.0 - _266) : _266;
        _270 = _269;
    }
    else
    {
        _270 = in.in_var_ATTRIBUTE4;
    }
    float3 _271 = _112 + View.View_PreViewTranslation;
    float _272 = _271.x;
    float _273 = _271.y;
    float _274 = _271.z;
    float4 _275 = float4(_272, _273, _274, 1.0);
    float2 _276 = abs(in.in_var_ATTRIBUTE2.xy);
    float _277 = _221.x;
    float _278 = _221.y;
    float _279 = _221.z;
    float4 _280 = float4(_277, _278, _279, 0.0);
    float _281 = _276.x;
    float _285 = _270.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _286 = _281 * _285;
    float4 _287 = _280 * _286;
    float4 _288 = _275 + _287;
    float _289 = _224.x;
    float _290 = _224.y;
    float _291 = _224.z;
    float4 _292 = float4(_289, _290, _291, 0.0);
    float _293 = _276.y;
    float _297 = _270.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _298 = _293 * _297;
    float4 _299 = _292 * _298;
    float4 _300 = _288 + _299;
    float _304 = _300.x;
    float _305 = _300.y;
    float _306 = _300.z;
    float4 _307 = float4(_304, _305, _306, 1.0);
    float3x3 _338;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _313 = _75;
        _313[2] = normalize(cross(_221, _224));
        _338 = _313;
    }
    else
    {
        float3x3 _337;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _323 = _75;
            _323[2] = normalize(_112 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _337 = _323;
        }
        else
        {
            float3x3 _336 = _75;
            _336[2] = normalize(_112 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _112 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _337 = _336;
        }
        _338 = _337;
    }
    float4 _340 = float4(_307.x, _307.y, _307.z, _307.w);
    float4 _345 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _340;
    out.out_var_TEXCOORD6 = _340;
    out.out_var_TEXCOORD8 = _338[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _345;
    return out;
}

