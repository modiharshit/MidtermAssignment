

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
    char _m6_pad[1264];
    spvUnsafeArray<float4, 2> View_TranslucencyLightingVolumeInvSize;
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

constant float3x3 _87 = {};
constant float2 _88 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn3)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn4)]];
    float out_var_TEXCOORD6 [[user(locn5)]];
    float4 out_var_TEXCOORD7 [[user(locn6)]];
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

vertex MainVS_out Main_00002cce_38e5ac28(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    float3 _126 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _130 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _139 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _130), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _147 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _130), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _148 = View.View_WorldCameraOrigin - _126;
    float _149 = dot(_148, _148);
    float3 _152 = _148 * rsqrt(fast::max(_149, 9.9999999392252902907785028219223e-09));
    float3 _222;
    float3 _223;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _168 = cross(_152, float3(0.0, 0.0, 1.0));
        float3 _172 = _168 * rsqrt(fast::max(dot(_168, _168), 9.9999999392252902907785028219223e-09));
        float3 _174 = float3(fast::clamp((_149 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _222 = normalize(mix(_139, _172, _174));
        _223 = normalize(mix(_147, cross(_152, _172), _174));
    }
    else
    {
        float3 _220;
        float3 _221;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _184 = _126 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _188 = _184 * rsqrt(fast::max(dot(_184, _184), 9.9999999392252902907785028219223e-09));
            float3 _189 = cross(_152, _188);
            _220 = _189 * rsqrt(fast::max(dot(_189, _189), 9.9999999392252902907785028219223e-09));
            _221 = -_188;
        }
        else
        {
            float3 _218;
            float3 _219;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _200 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _152);
                _218 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _219 = -(_200 * rsqrt(fast::max(dot(_200, _200), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _216;
                float3 _217;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _210 = cross(_152, float3(0.0, 0.0, 1.0));
                    float3 _214 = _210 * rsqrt(fast::max(dot(_210, _210), 9.9999999392252902907785028219223e-09));
                    _216 = _214;
                    _217 = cross(_152, _214);
                }
                else
                {
                    _216 = _139;
                    _217 = _147;
                }
                _218 = _216;
                _219 = _217;
            }
            _220 = _218;
            _221 = _219;
        }
        _222 = _220;
        _223 = _221;
    }
    float _230 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _231 = sin(_230);
    float _232 = cos(_230);
    float3 _235 = (_223 * _231) + (_222 * _232);
    float3 _238 = (_223 * _232) - (_222 * _231);
    float2 _242 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _297;
    float2 _298;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _252 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _261 = _242.x;
        float _262 = _242.y;
        uint _269;
        if ((_261 * _262) < 0.0)
        {
            _269 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _252;
        }
        else
        {
            _269 = _252;
        }
        float4 _273 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _269)));
        float _276 = _273.x;
        float2 _279 = _88;
        _279.x = (_261 < 0.0) ? (1.0 - _276) : _276;
        float _281 = _273.y;
        float2 _284 = _279;
        _284.y = (_262 < 0.0) ? (1.0 - _281) : _281;
        _297 = _273.xy;
        _298 = _284;
    }
    else
    {
        float2 _290 = _88;
        _290.x = (_242.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _296 = _290;
        _296.y = (_242.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _297 = _296;
        _298 = in.in_var_ATTRIBUTE4;
    }
    float2 _304 = abs(in.in_var_ATTRIBUTE2.xy);
    float _330 = fract(in.in_var_ATTRIBUTE2.w);
    float _331 = in.in_var_ATTRIBUTE2.w - _330;
    float _332 = _331 + 1.0;
    float2 _348 = (float2(mod(_331, SpriteVF.SpriteVF_SubImageSize.x), floor(_331 * SpriteVF.SpriteVF_SubImageSize.z)) + _297) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _351 = (float2(mod(_332, SpriteVF.SpriteVF_SubImageSize.x), floor(_332 * SpriteVF.SpriteVF_SubImageSize.z)) + _297) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _352 = _87;
    _352[0] = _235;
    float3x3 _353 = _352;
    _353[1] = _238;
    float3x3 _387;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _362 = _353;
        _362[2] = normalize(cross(_235, _238));
        _387 = _362;
    }
    else
    {
        float3x3 _386;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _372 = _353;
            _372[2] = normalize(_126 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _386 = _372;
        }
        else
        {
            float3x3 _385 = _353;
            _385[2] = normalize(_126 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _126 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _386 = _385;
        }
        _387 = _386;
    }
    float _389 = in.in_var_ATTRIBUTE1.w + 10.0;
    float4 _402 = float4(((float4(_126 + View.View_PreViewTranslation, 1.0) + (float4(_235, 0.0) * (_304.x * (_298.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_238, 0.0) * (_304.y * (_298.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _403 = float4(_402.x, _402.y, _402.z, _402.w);
    float4 _406 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _403;
    float4 _417;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_406.z < 0.0))
    {
        float4 _415 = _406;
        _415.z = 9.9999999747524270787835121154785e-07;
        float4 _416 = _415;
        _416.w = 1.0;
        _417 = _416;
    }
    else
    {
        _417 = _406;
    }
    float _421 = _417.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _424 = _417;
    _424.z = _421 * _417.w;
    float4 _428 = float4(_387[0].x, _387[0].y, _387[0].z, float4(0.0).w);
    _428.w = _330;
    out.out_var_TEXCOORD10 = _428;
    out.out_var_TEXCOORD11 = float4(_387[2], float(int(sign(determinant(_387)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out.out_var_PARTICLE_SUBUVS = float4(_348.x, _348.y, _351.x, _351.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_389 * _389)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD6 = _421;
    out.out_var_TEXCOORD7 = _403;
    out.gl_Position = _424;
    return out;
}

