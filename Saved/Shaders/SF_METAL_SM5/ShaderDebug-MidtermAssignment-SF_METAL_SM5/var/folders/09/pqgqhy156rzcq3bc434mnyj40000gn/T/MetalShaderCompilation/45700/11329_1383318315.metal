

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

constant float3x3 _78 = {};
constant float2 _80 = {};

struct MainForGS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
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

vertex MainForGS_out Main_00002c41_5273c32b(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainForGS_out out = {};
    float4 _107 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _110 = Primitive.Primitive_LocalToWorld * _107;
    float3 _116 = _110.xyz;
    float3 _120 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _129 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _120), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _137 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _120), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _138 = View.View_WorldCameraOrigin - _116;
    float _139 = dot(_138, _138);
    float3 _142 = _138 * rsqrt(fast::max(_139, 9.9999999392252902907785028219223e-09));
    float3 _212;
    float3 _213;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _158 = cross(_142, float3(0.0, 0.0, 1.0));
        float3 _162 = _158 * rsqrt(fast::max(dot(_158, _158), 9.9999999392252902907785028219223e-09));
        float3 _164 = float3(fast::clamp((_139 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _212 = normalize(mix(_129, _162, _164));
        _213 = normalize(mix(_137, cross(_142, _162), _164));
    }
    else
    {
        float3 _210;
        float3 _211;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _174 = _116 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _178 = _174 * rsqrt(fast::max(dot(_174, _174), 9.9999999392252902907785028219223e-09));
            float3 _179 = cross(_142, _178);
            _210 = _179 * rsqrt(fast::max(dot(_179, _179), 9.9999999392252902907785028219223e-09));
            _211 = -_178;
        }
        else
        {
            float3 _208;
            float3 _209;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _190 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _142);
                _208 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _209 = -(_190 * rsqrt(fast::max(dot(_190, _190), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _206;
                float3 _207;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _200 = cross(_142, float3(0.0, 0.0, 1.0));
                    float3 _204 = _200 * rsqrt(fast::max(dot(_200, _200), 9.9999999392252902907785028219223e-09));
                    _206 = _204;
                    _207 = cross(_142, _204);
                }
                else
                {
                    _206 = _129;
                    _207 = _137;
                }
                _208 = _206;
                _209 = _207;
            }
            _210 = _208;
            _211 = _209;
        }
        _212 = _210;
        _213 = _211;
    }
    float _219 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _220 = _219 + SpriteVF.SpriteVF_RotationBias;
    float _221 = sin(_220);
    float _222 = cos(_220);
    float3 _223 = _213 * _221;
    float3 _224 = _212 * _222;
    float3 _225 = _223 + _224;
    float3 _226 = _213 * _222;
    float3 _227 = _212 * _221;
    float3 _228 = _226 - _227;
    float2 _232 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _274;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _242 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _251 = _232.x;
        float _252 = _232.y;
        uint _259;
        if ((_251 * _252) < 0.0)
        {
            _259 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _242;
        }
        else
        {
            _259 = _242;
        }
        float4 _263 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _259)));
        float _265 = _263.x;
        float2 _268 = _80;
        _268.x = (_251 < 0.0) ? (1.0 - _265) : _265;
        float _270 = _263.y;
        float2 _273 = _268;
        _273.y = (_252 < 0.0) ? (1.0 - _270) : _270;
        _274 = _273;
    }
    else
    {
        _274 = in.in_var_ATTRIBUTE4;
    }
    float3 _275 = _116 + View.View_PreViewTranslation;
    float _276 = _275.x;
    float _277 = _275.y;
    float _278 = _275.z;
    float4 _279 = float4(_276, _277, _278, 1.0);
    float2 _280 = abs(in.in_var_ATTRIBUTE2.xy);
    float _281 = _225.x;
    float _282 = _225.y;
    float _283 = _225.z;
    float4 _284 = float4(_281, _282, _283, 0.0);
    float _285 = _280.x;
    float _289 = _274.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _290 = _285 * _289;
    float4 _291 = _284 * _290;
    float4 _292 = _279 + _291;
    float _293 = _228.x;
    float _294 = _228.y;
    float _295 = _228.z;
    float4 _296 = float4(_293, _294, _295, 0.0);
    float _297 = _280.y;
    float _301 = _274.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _302 = _297 * _301;
    float4 _303 = _296 * _302;
    float4 _304 = _292 + _303;
    float3x3 _307 = _78;
    _307[0] = _225;
    float3x3 _308 = _307;
    _308[1] = _228;
    bool _311 = SpriteVF.SpriteVF_NormalsType < 0.5;
    float3x3 _342;
    if (_311)
    {
        float3x3 _317 = _308;
        _317[2] = normalize(cross(_225, _228));
        _342 = _317;
    }
    else
    {
        float3x3 _341;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _327 = _308;
            _327[2] = normalize(_116 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _341 = _327;
        }
        else
        {
            float3x3 _340 = _308;
            _340[2] = normalize(_116 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _116 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _341 = _340;
        }
        _342 = _341;
    }
    float _343 = _304.x;
    float _344 = _304.y;
    float _345 = _304.z;
    float4 _346 = float4(_343, _344, _345, 1.0);
    float3x3 _377;
    if (_311)
    {
        float3x3 _352 = _78;
        _352[2] = normalize(cross(_225, _228));
        _377 = _352;
    }
    else
    {
        float3x3 _376;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _362 = _78;
            _362[2] = normalize(_116 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _376 = _362;
        }
        else
        {
            float3x3 _375 = _78;
            _375[2] = normalize(_116 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _116 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _376 = _375;
        }
        _377 = _376;
    }
    float4 _379 = float4(_346.x, _346.y, _346.z, _346.w);
    float4 _382 = float4(_342[0].x, _342[0].y, _342[0].z, float4(0.0).w);
    _382.w = fract(in.in_var_ATTRIBUTE2.w);
    float4 _397 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _379;
    out.out_var_TEXCOORD10 = _382;
    out.out_var_TEXCOORD11 = float4(_342[2], float(int(sign(determinant(_342)))));
    out.out_var_TEXCOORD7 = _346.xyz;
    out.out_var_TEXCOORD6 = _397;
    out.out_var_TEXCOORD8 = _377[2];
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _397;
    return out;
}

