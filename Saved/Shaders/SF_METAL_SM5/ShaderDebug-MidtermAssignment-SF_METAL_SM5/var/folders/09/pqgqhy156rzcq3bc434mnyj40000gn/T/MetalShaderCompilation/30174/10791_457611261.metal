

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
    char _m7_pad[320];
    float4x4 View_PrevTranslatedWorldToClip;
    char _m8_pad[640];
    int View_NumSceneColorMSAASamples;
    char _m9_pad[224];
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

constant float3x3 _86 = {};
constant float2 _87 = {};

struct MainVertexShader_out
{
    float4 out_var_TEXCOORD6 [[user(locn0)]];
    float4 out_var_TEXCOORD7 [[user(locn1)]];
    float4 out_var_TEXCOORD10 [[user(locn2)]];
    float4 out_var_TEXCOORD11 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
    float3 out_var_PARTICLE_LIGHTING_OFFSET [[user(locn5)]];
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

vertex MainVertexShader_out Main_00002a27_1b4697fd(MainVertexShader_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVertexShader_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _130 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _134 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _143 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _134), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _151 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _134), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _152 = View.View_WorldCameraOrigin - _130;
    float _153 = dot(_152, _152);
    float3 _156 = _152 * rsqrt(fast::max(_153, 9.9999999392252902907785028219223e-09));
    float3 _226;
    float3 _227;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _215 = cross(_156, float3(0.0, 0.0, 1.0));
        float3 _219 = _215 * rsqrt(fast::max(dot(_215, _215), 9.9999999392252902907785028219223e-09));
        float3 _221 = float3(fast::clamp((_153 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _226 = normalize(mix(_143, _219, _221));
        _227 = normalize(mix(_151, cross(_156, _219), _221));
    }
    else
    {
        float3 _206;
        float3 _207;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _195 = _130 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _199 = _195 * rsqrt(fast::max(dot(_195, _195), 9.9999999392252902907785028219223e-09));
            float3 _200 = cross(_156, _199);
            _206 = _200 * rsqrt(fast::max(dot(_200, _200), 9.9999999392252902907785028219223e-09));
            _207 = -_199;
        }
        else
        {
            float3 _193;
            float3 _194;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _187 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _156);
                _193 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _194 = -(_187 * rsqrt(fast::max(dot(_187, _187), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _185;
                float3 _186;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _179 = cross(_156, float3(0.0, 0.0, 1.0));
                    float3 _183 = _179 * rsqrt(fast::max(dot(_179, _179), 9.9999999392252902907785028219223e-09));
                    _185 = _183;
                    _186 = cross(_156, _183);
                }
                else
                {
                    _185 = _143;
                    _186 = _151;
                }
                _193 = _185;
                _194 = _186;
            }
            _206 = _193;
            _207 = _194;
        }
        _226 = _206;
        _227 = _207;
    }
    float _234 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _235 = sin(_234);
    float _236 = cos(_234);
    float3 _239 = (_227 * _235) + (_226 * _236);
    float3 _242 = (_227 * _236) - (_226 * _235);
    float2 _246 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _301;
    float2 _302;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _268 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _277 = _246.x;
        float _278 = _246.y;
        uint _285;
        if ((_277 * _278) < 0.0)
        {
            _285 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _268;
        }
        else
        {
            _285 = _268;
        }
        float4 _289 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _285)));
        float _292 = _289.x;
        float2 _295 = _87;
        _295.x = (_277 < 0.0) ? (1.0 - _292) : _292;
        float _297 = _289.y;
        float2 _300 = _295;
        _300.y = (_278 < 0.0) ? (1.0 - _297) : _297;
        _301 = _289.xy;
        _302 = _300;
    }
    else
    {
        float2 _258 = _87;
        _258.x = (_246.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _264 = _258;
        _264.y = (_246.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _301 = _264;
        _302 = in.in_var_ATTRIBUTE4;
    }
    float2 _308 = abs(in.in_var_ATTRIBUTE2.xy);
    float _334 = fract(in.in_var_ATTRIBUTE2.w);
    float _335 = in.in_var_ATTRIBUTE2.w - _334;
    float2 _348 = (float2(mod(_335, SpriteVF.SpriteVF_SubImageSize.x), floor(_335 * SpriteVF.SpriteVF_SubImageSize.z)) + _301) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _349 = _86;
    _349[0] = _239;
    float3x3 _350 = _349;
    _350[1] = _242;
    float3x3 _384;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _383 = _350;
        _383[2] = normalize(cross(_239, _242));
        _384 = _383;
    }
    else
    {
        float3x3 _380;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _379 = _350;
            _379[2] = normalize(_130 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _380 = _379;
        }
        else
        {
            float3x3 _373 = _350;
            _373[2] = normalize(_130 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _130 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _380 = _373;
        }
        _384 = _380;
    }
    float _386 = in.in_var_ATTRIBUTE1.w + 10.0;
    float4 _403 = float4(_384[0].x, _384[0].y, _384[0].z, float4(0.0).w);
    _403.w = _334;
    spvUnsafeArray<float4, 1> _412 = { float4(_348.x, _348.y, float4(0.0).z, float4(0.0).w) };
    float4 _413 = float4(((float4(_130 + View.View_PreViewTranslation, 1.0) + (float4(_239, 0.0) * (_308.x * (_302.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_242, 0.0) * (_308.y * (_302.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _415 = View.View_TranslatedWorldToClip * _413;
    float4 _422 = _415;
    _422.z = _415.z + ((View.View_NumSceneColorMSAASamples > 1) ? (0.001000000047497451305389404296875 * _415.w) : 0.0);
    out.gl_Position = _422;
    out.out_var_TEXCOORD6 = _415;
    out.out_var_TEXCOORD7 = View.View_PrevTranslatedWorldToClip * _413;
    out.out_var_TEXCOORD10 = _403;
    out.out_var_TEXCOORD11 = float4(_384[2], float(int(sign(determinant(_384)))));
    out_var_TEXCOORD3 = _412;
    out.out_var_PARTICLE_LIGHTING_OFFSET = ((fract(float3(1361.456298828125, 2333.577880859375, 3623.98291015625) * (_386 * _386)) * 2.0) - float3(1.0)) * (0.5 * View.View_TranslucencyLightingVolumeInvSize[0].w);
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

