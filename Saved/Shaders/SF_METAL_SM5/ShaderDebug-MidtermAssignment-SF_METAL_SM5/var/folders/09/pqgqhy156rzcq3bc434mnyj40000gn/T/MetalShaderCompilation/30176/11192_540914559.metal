

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
    char _m7_pad[1264];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
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

constant float3x3 _83 = {};
constant float2 _84 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD3_0 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
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

vertex Main_out Main_00002bb8_203db37f(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _114 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _117 = Primitive.Primitive_LocalToWorld * _114;
    float3 _123 = _117.xyz;
    float3 _127 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _136 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _127), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _144 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _127), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _145 = View.View_WorldCameraOrigin - _123;
    float _146 = dot(_145, _145);
    float3 _149 = _145 * rsqrt(fast::max(_146, 9.9999999392252902907785028219223e-09));
    float3 _219;
    float3 _220;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _208 = cross(_149, float3(0.0, 0.0, 1.0));
        float3 _212 = _208 * rsqrt(fast::max(dot(_208, _208), 9.9999999392252902907785028219223e-09));
        float3 _214 = float3(fast::clamp((_146 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _219 = normalize(mix(_136, _212, _214));
        _220 = normalize(mix(_144, cross(_149, _212), _214));
    }
    else
    {
        float3 _199;
        float3 _200;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _188 = _123 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _192 = _188 * rsqrt(fast::max(dot(_188, _188), 9.9999999392252902907785028219223e-09));
            float3 _193 = cross(_149, _192);
            _199 = _193 * rsqrt(fast::max(dot(_193, _193), 9.9999999392252902907785028219223e-09));
            _200 = -_192;
        }
        else
        {
            float3 _186;
            float3 _187;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _180 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _149);
                _186 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _187 = -(_180 * rsqrt(fast::max(dot(_180, _180), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _178;
                float3 _179;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _172 = cross(_149, float3(0.0, 0.0, 1.0));
                    float3 _176 = _172 * rsqrt(fast::max(dot(_172, _172), 9.9999999392252902907785028219223e-09));
                    _178 = _176;
                    _179 = cross(_149, _176);
                }
                else
                {
                    _178 = _136;
                    _179 = _144;
                }
                _186 = _178;
                _187 = _179;
            }
            _199 = _186;
            _200 = _187;
        }
        _219 = _199;
        _220 = _200;
    }
    float _226 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _227 = _226 + SpriteVF.SpriteVF_RotationBias;
    float _228 = sin(_227);
    float _229 = cos(_227);
    float3 _230 = _220 * _228;
    float3 _231 = _219 * _229;
    float3 _232 = _230 + _231;
    float3 _233 = _220 * _229;
    float3 _234 = _219 * _228;
    float3 _235 = _233 - _234;
    float2 _239 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _294;
    float2 _295;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _261 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _270 = _239.x;
        float _271 = _239.y;
        uint _278;
        if ((_270 * _271) < 0.0)
        {
            _278 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _261;
        }
        else
        {
            _278 = _261;
        }
        float4 _282 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _278)));
        float _285 = _282.x;
        float2 _288 = _84;
        _288.x = (_270 < 0.0) ? (1.0 - _285) : _285;
        float _290 = _282.y;
        float2 _293 = _288;
        _293.y = (_271 < 0.0) ? (1.0 - _290) : _290;
        _294 = _282.xy;
        _295 = _293;
    }
    else
    {
        float2 _251 = _84;
        _251.x = (_239.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _257 = _251;
        _257.y = (_239.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _294 = _257;
        _295 = in.in_var_ATTRIBUTE4;
    }
    float3 _296 = _123 + View.View_PreViewTranslation;
    float _297 = _296.x;
    float _298 = _296.y;
    float _299 = _296.z;
    float4 _300 = float4(_297, _298, _299, 1.0);
    float2 _301 = abs(in.in_var_ATTRIBUTE2.xy);
    float _302 = _232.x;
    float _303 = _232.y;
    float _304 = _232.z;
    float4 _305 = float4(_302, _303, _304, 0.0);
    float _306 = _301.x;
    float _310 = _295.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _311 = _306 * _310;
    float4 _312 = _305 * _311;
    float4 _313 = _300 + _312;
    float _314 = _235.x;
    float _315 = _235.y;
    float _316 = _235.z;
    float4 _317 = float4(_314, _315, _316, 0.0);
    float _318 = _301.y;
    float _322 = _295.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _323 = _318 * _322;
    float4 _324 = _317 * _323;
    float4 _325 = _313 + _324;
    float _327 = fract(in.in_var_ATTRIBUTE2.w);
    float _328 = in.in_var_ATTRIBUTE2.w - _327;
    float2 _341 = (float2(mod(_328, SpriteVF.SpriteVF_SubImageSize.x), floor(_328 * SpriteVF.SpriteVF_SubImageSize.z)) + _294) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _342 = _83;
    _342[0] = _232;
    float3x3 _343 = _342;
    _343[1] = _235;
    float3x3 _377;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _376 = _343;
        _376[2] = normalize(cross(_232, _235));
        _377 = _376;
    }
    else
    {
        float3x3 _373;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _372 = _343;
            _372[2] = normalize(_123 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _373 = _372;
        }
        else
        {
            float3x3 _366 = _343;
            _366[2] = normalize(_123 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _123 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _373 = _366;
        }
        _377 = _373;
    }
    float _379 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _389 = _325.x;
    float _390 = _325.y;
    float _391 = _325.z;
    float4 _392 = float4(_389, _390, _391, 1.0);
    float4 _394 = float4(_392.x, _392.y, _392.z, _392.w);
    float4 _395 = View.View_TranslatedWorldToClip * _394;
    float4 _399 = float4(_377[0].x, _377[0].y, _377[0].z, float4(0.0).w);
    _399.w = _327;
    spvUnsafeArray<float4, 1> _408 = { float4(_341.x, _341.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _399;
    out.out_var_TEXCOORD11 = float4(_377[2], float(int(sign(determinant(_377)))));
    out_var_TEXCOORD3 = _408;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_379 * _379)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD6 = _394;
    out.gl_Position = _395;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

