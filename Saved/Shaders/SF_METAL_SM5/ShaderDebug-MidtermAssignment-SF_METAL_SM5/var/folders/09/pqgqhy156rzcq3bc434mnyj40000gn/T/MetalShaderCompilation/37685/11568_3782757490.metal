

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

constant float3x3 _90 = {};
constant float2 _91 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD2 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_PARTICLE_SUBUVS [[user(locn4)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
    float out_var_TEXCOORD6 [[user(locn6)]];
    float4 out_var_TEXCOORD7 [[user(locn7)]];
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

vertex MainVS_out Main_00002d30_e1784c72(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _129 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _133 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _142 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _133), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _150 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _133), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _151 = View.View_WorldCameraOrigin - _129;
    float _152 = dot(_151, _151);
    float3 _155 = _151 * rsqrt(fast::max(_152, 9.9999999392252902907785028219223e-09));
    float3 _225;
    float3 _226;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _214 = cross(_155, float3(0.0, 0.0, 1.0));
        float3 _218 = _214 * rsqrt(fast::max(dot(_214, _214), 9.9999999392252902907785028219223e-09));
        float3 _220 = float3(fast::clamp((_152 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _225 = normalize(mix(_142, _218, _220));
        _226 = normalize(mix(_150, cross(_155, _218), _220));
    }
    else
    {
        float3 _205;
        float3 _206;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _194 = _129 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _198 = _194 * rsqrt(fast::max(dot(_194, _194), 9.9999999392252902907785028219223e-09));
            float3 _199 = cross(_155, _198);
            _205 = _199 * rsqrt(fast::max(dot(_199, _199), 9.9999999392252902907785028219223e-09));
            _206 = -_198;
        }
        else
        {
            float3 _192;
            float3 _193;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _186 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _155);
                _192 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _193 = -(_186 * rsqrt(fast::max(dot(_186, _186), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _184;
                float3 _185;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _178 = cross(_155, float3(0.0, 0.0, 1.0));
                    float3 _182 = _178 * rsqrt(fast::max(dot(_178, _178), 9.9999999392252902907785028219223e-09));
                    _184 = _182;
                    _185 = cross(_155, _182);
                }
                else
                {
                    _184 = _142;
                    _185 = _150;
                }
                _192 = _184;
                _193 = _185;
            }
            _205 = _192;
            _206 = _193;
        }
        _225 = _205;
        _226 = _206;
    }
    float _233 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _234 = sin(_233);
    float _235 = cos(_233);
    float3 _238 = (_226 * _234) + (_225 * _235);
    float3 _241 = (_226 * _235) - (_225 * _234);
    float2 _245 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _300;
    float2 _301;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _267 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _276 = _245.x;
        float _277 = _245.y;
        uint _284;
        if ((_276 * _277) < 0.0)
        {
            _284 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _267;
        }
        else
        {
            _284 = _267;
        }
        float4 _288 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _284)));
        float _291 = _288.x;
        float2 _294 = _91;
        _294.x = (_276 < 0.0) ? (1.0 - _291) : _291;
        float _296 = _288.y;
        float2 _299 = _294;
        _299.y = (_277 < 0.0) ? (1.0 - _296) : _296;
        _300 = _288.xy;
        _301 = _299;
    }
    else
    {
        float2 _257 = _91;
        _257.x = (_245.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _263 = _257;
        _263.y = (_245.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _300 = _263;
        _301 = in.in_var_ATTRIBUTE4;
    }
    float2 _307 = abs(in.in_var_ATTRIBUTE2.xy);
    float _333 = fract(in.in_var_ATTRIBUTE2.w);
    float _334 = in.in_var_ATTRIBUTE2.w - _333;
    float _335 = _334 + 1.0;
    float2 _351 = (float2(mod(_334, SpriteVF.SpriteVF_SubImageSize.x), floor(_334 * SpriteVF.SpriteVF_SubImageSize.z)) + _300) * SpriteVF.SpriteVF_SubImageSize.zw;
    float2 _354 = (float2(mod(_335, SpriteVF.SpriteVF_SubImageSize.x), floor(_335 * SpriteVF.SpriteVF_SubImageSize.z)) + _300) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _355 = _90;
    _355[0] = _238;
    float3x3 _356 = _355;
    _356[1] = _241;
    float3x3 _390;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _389 = _356;
        _389[2] = normalize(cross(_238, _241));
        _390 = _389;
    }
    else
    {
        float3x3 _386;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _385 = _356;
            _385[2] = normalize(_129 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _386 = _385;
        }
        else
        {
            float3x3 _379 = _356;
            _379[2] = normalize(_129 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _129 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _386 = _379;
        }
        _390 = _386;
    }
    float _392 = in.in_var_ATTRIBUTE1.w + 10.0;
    float4 _405 = float4(((float4(_129 + View.View_PreViewTranslation, 1.0) + (float4(_238, 0.0) * (_307.x * (_301.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_241, 0.0) * (_307.y * (_301.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _406 = float4(_405.x, _405.y, _405.z, _405.w);
    float4 _409 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _406;
    float4 _420;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_409.z < 0.0))
    {
        float4 _418 = _409;
        _418.z = 9.9999999747524270787835121154785e-07;
        float4 _419 = _418;
        _419.w = 1.0;
        _420 = _419;
    }
    else
    {
        _420 = _409;
    }
    float4 _426 = float4(_390[0].x, _390[0].y, _390[0].z, float4(0.0).w);
    _426.w = _333;
    spvUnsafeArray<float4, 1> _436 = { float4(_351.x, _351.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _426;
    out.out_var_TEXCOORD11 = float4(_390[2], float(int(sign(determinant(_390)))));
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _436;
    out.out_var_PARTICLE_SUBUVS = float4(_351.x, _351.y, _354.x, _354.y);
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_392 * _392)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD6 = _420.z;
    out.out_var_TEXCOORD7 = _406;
    out.gl_Position = _420;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

