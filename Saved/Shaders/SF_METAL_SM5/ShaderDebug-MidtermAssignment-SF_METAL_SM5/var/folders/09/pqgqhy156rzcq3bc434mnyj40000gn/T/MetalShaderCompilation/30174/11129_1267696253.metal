

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

constant float3x3 _82 = {};
constant float2 _83 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD3_0 [[user(locn2)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn3)]];
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

vertex Main_out Main_00002b79_4b8f827d(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _113 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _116 = Primitive.Primitive_LocalToWorld * _113;
    float3 _122 = _116.xyz;
    float3 _126 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _135 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _126), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _143 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _126), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _144 = View.View_WorldCameraOrigin - _122;
    float _145 = dot(_144, _144);
    float3 _148 = _144 * rsqrt(fast::max(_145, 9.9999999392252902907785028219223e-09));
    float3 _218;
    float3 _219;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _207 = cross(_148, float3(0.0, 0.0, 1.0));
        float3 _211 = _207 * rsqrt(fast::max(dot(_207, _207), 9.9999999392252902907785028219223e-09));
        float3 _213 = float3(fast::clamp((_145 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _218 = normalize(mix(_135, _211, _213));
        _219 = normalize(mix(_143, cross(_148, _211), _213));
    }
    else
    {
        float3 _198;
        float3 _199;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _187 = _122 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _191 = _187 * rsqrt(fast::max(dot(_187, _187), 9.9999999392252902907785028219223e-09));
            float3 _192 = cross(_148, _191);
            _198 = _192 * rsqrt(fast::max(dot(_192, _192), 9.9999999392252902907785028219223e-09));
            _199 = -_191;
        }
        else
        {
            float3 _185;
            float3 _186;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _179 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _148);
                _185 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _186 = -(_179 * rsqrt(fast::max(dot(_179, _179), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _177;
                float3 _178;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _171 = cross(_148, float3(0.0, 0.0, 1.0));
                    float3 _175 = _171 * rsqrt(fast::max(dot(_171, _171), 9.9999999392252902907785028219223e-09));
                    _177 = _175;
                    _178 = cross(_148, _175);
                }
                else
                {
                    _177 = _135;
                    _178 = _143;
                }
                _185 = _177;
                _186 = _178;
            }
            _198 = _185;
            _199 = _186;
        }
        _218 = _198;
        _219 = _199;
    }
    float _225 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _226 = _225 + SpriteVF.SpriteVF_RotationBias;
    float _227 = sin(_226);
    float _228 = cos(_226);
    float3 _229 = _219 * _227;
    float3 _230 = _218 * _228;
    float3 _231 = _229 + _230;
    float3 _232 = _219 * _228;
    float3 _233 = _218 * _227;
    float3 _234 = _232 - _233;
    float2 _238 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _293;
    float2 _294;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _260 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _269 = _238.x;
        float _270 = _238.y;
        uint _277;
        if ((_269 * _270) < 0.0)
        {
            _277 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _260;
        }
        else
        {
            _277 = _260;
        }
        float4 _281 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _277)));
        float _284 = _281.x;
        float2 _287 = _83;
        _287.x = (_269 < 0.0) ? (1.0 - _284) : _284;
        float _289 = _281.y;
        float2 _292 = _287;
        _292.y = (_270 < 0.0) ? (1.0 - _289) : _289;
        _293 = _281.xy;
        _294 = _292;
    }
    else
    {
        float2 _250 = _83;
        _250.x = (_238.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _256 = _250;
        _256.y = (_238.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _293 = _256;
        _294 = in.in_var_ATTRIBUTE4;
    }
    float3 _295 = _122 + View.View_PreViewTranslation;
    float _296 = _295.x;
    float _297 = _295.y;
    float _298 = _295.z;
    float4 _299 = float4(_296, _297, _298, 1.0);
    float2 _300 = abs(in.in_var_ATTRIBUTE2.xy);
    float _301 = _231.x;
    float _302 = _231.y;
    float _303 = _231.z;
    float4 _304 = float4(_301, _302, _303, 0.0);
    float _305 = _300.x;
    float _309 = _294.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _310 = _305 * _309;
    float4 _311 = _304 * _310;
    float4 _312 = _299 + _311;
    float _313 = _234.x;
    float _314 = _234.y;
    float _315 = _234.z;
    float4 _316 = float4(_313, _314, _315, 0.0);
    float _317 = _300.y;
    float _321 = _294.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _322 = _317 * _321;
    float4 _323 = _316 * _322;
    float4 _324 = _312 + _323;
    float _326 = fract(in.in_var_ATTRIBUTE2.w);
    float _327 = in.in_var_ATTRIBUTE2.w - _326;
    float2 _340 = (float2(mod(_327, SpriteVF.SpriteVF_SubImageSize.x), floor(_327 * SpriteVF.SpriteVF_SubImageSize.z)) + _293) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _341 = _82;
    _341[0] = _231;
    float3x3 _342 = _341;
    _342[1] = _234;
    float3x3 _376;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _375 = _342;
        _375[2] = normalize(cross(_231, _234));
        _376 = _375;
    }
    else
    {
        float3x3 _372;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _371 = _342;
            _371[2] = normalize(_122 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _372 = _371;
        }
        else
        {
            float3x3 _365 = _342;
            _365[2] = normalize(_122 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _122 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _372 = _365;
        }
        _376 = _372;
    }
    float _378 = in.in_var_ATTRIBUTE1.w + 10.0;
    float _388 = _324.x;
    float _389 = _324.y;
    float _390 = _324.z;
    float4 _391 = float4(_388, _389, _390, 1.0);
    float4 _393 = float4(_391.x, _391.y, _391.z, _391.w);
    float4 _394 = View.View_TranslatedWorldToClip * _393;
    float4 _398 = float4(_376[0].x, _376[0].y, _376[0].z, float4(0.0).w);
    _398.w = _326;
    spvUnsafeArray<float4, 1> _407 = { float4(_340.x, _340.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _398;
    out.out_var_TEXCOORD11 = float4(_376[2], float(int(sign(determinant(_376)))));
    out_var_TEXCOORD3 = _407;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_378 * _378)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.gl_Position = _394;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

