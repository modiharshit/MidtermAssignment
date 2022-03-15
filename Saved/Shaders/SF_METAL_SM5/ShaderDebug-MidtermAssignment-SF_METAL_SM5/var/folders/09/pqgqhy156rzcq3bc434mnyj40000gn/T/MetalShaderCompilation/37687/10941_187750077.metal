

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

constant float3x3 _74 = {};
constant float2 _75 = {};

struct Main_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD3_0 [[user(locn3)]];
    float4 out_var_TEXCOORD6 [[user(locn4)]];
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
    float4 in_var_ATTRIBUTE1 [[attribute(1)]];
    float4 in_var_ATTRIBUTE2 [[attribute(2)]];
    float2 in_var_ATTRIBUTE4 [[attribute(4)]];
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex Main_out Main_00002abd_0b30d6bd(Main_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_SpriteVF& SpriteVF [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    Main_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float4 _106 = float4(in.in_var_ATTRIBUTE0.xyz, 1.0);
    float4 _109 = Primitive.Primitive_LocalToWorld * _106;
    float3 _115 = _109.xyz;
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
        float3 _200 = cross(_141, float3(0.0, 0.0, 1.0));
        float3 _204 = _200 * rsqrt(fast::max(dot(_200, _200), 9.9999999392252902907785028219223e-09));
        float3 _206 = float3(fast::clamp((_138 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _211 = normalize(mix(_128, _204, _206));
        _212 = normalize(mix(_136, cross(_141, _204), _206));
    }
    else
    {
        float3 _191;
        float3 _192;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _180 = _115 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _184 = _180 * rsqrt(fast::max(dot(_180, _180), 9.9999999392252902907785028219223e-09));
            float3 _185 = cross(_141, _184);
            _191 = _185 * rsqrt(fast::max(dot(_185, _185), 9.9999999392252902907785028219223e-09));
            _192 = -_184;
        }
        else
        {
            float3 _178;
            float3 _179;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _172 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _141);
                _178 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _179 = -(_172 * rsqrt(fast::max(dot(_172, _172), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _170;
                float3 _171;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _164 = cross(_141, float3(0.0, 0.0, 1.0));
                    float3 _168 = _164 * rsqrt(fast::max(dot(_164, _164), 9.9999999392252902907785028219223e-09));
                    _170 = _168;
                    _171 = cross(_141, _168);
                }
                else
                {
                    _170 = _128;
                    _171 = _136;
                }
                _178 = _170;
                _179 = _171;
            }
            _191 = _178;
            _192 = _179;
        }
        _211 = _191;
        _212 = _192;
    }
    float _218 = in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale;
    float _219 = _218 + SpriteVF.SpriteVF_RotationBias;
    float _220 = sin(_219);
    float _221 = cos(_219);
    float3 _222 = _212 * _220;
    float3 _223 = _211 * _221;
    float3 _224 = _222 + _223;
    float3 _225 = _212 * _221;
    float3 _226 = _211 * _220;
    float3 _227 = _225 - _226;
    float2 _231 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _286;
    float2 _287;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _253 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _262 = _231.x;
        float _263 = _231.y;
        uint _270;
        if ((_262 * _263) < 0.0)
        {
            _270 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _253;
        }
        else
        {
            _270 = _253;
        }
        float4 _274 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _270)));
        float _277 = _274.x;
        float2 _280 = _75;
        _280.x = (_262 < 0.0) ? (1.0 - _277) : _277;
        float _282 = _274.y;
        float2 _285 = _280;
        _285.y = (_263 < 0.0) ? (1.0 - _282) : _282;
        _286 = _274.xy;
        _287 = _285;
    }
    else
    {
        float2 _243 = _75;
        _243.x = (_231.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _249 = _243;
        _249.y = (_231.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _286 = _249;
        _287 = in.in_var_ATTRIBUTE4;
    }
    float3 _288 = _115 + View.View_PreViewTranslation;
    float _289 = _288.x;
    float _290 = _288.y;
    float _291 = _288.z;
    float4 _292 = float4(_289, _290, _291, 1.0);
    float2 _293 = abs(in.in_var_ATTRIBUTE2.xy);
    float _294 = _224.x;
    float _295 = _224.y;
    float _296 = _224.z;
    float4 _297 = float4(_294, _295, _296, 0.0);
    float _298 = _293.x;
    float _302 = _287.x + SpriteVF.SpriteVF_PivotOffset.x;
    float _303 = _298 * _302;
    float4 _304 = _297 * _303;
    float4 _305 = _292 + _304;
    float _306 = _227.x;
    float _307 = _227.y;
    float _308 = _227.z;
    float4 _309 = float4(_306, _307, _308, 0.0);
    float _310 = _293.y;
    float _314 = _287.y + SpriteVF.SpriteVF_PivotOffset.y;
    float _315 = _310 * _314;
    float4 _316 = _309 * _315;
    float4 _317 = _305 + _316;
    float _319 = fract(in.in_var_ATTRIBUTE2.w);
    float _320 = in.in_var_ATTRIBUTE2.w - _319;
    float2 _333 = (float2(mod(_320, SpriteVF.SpriteVF_SubImageSize.x), floor(_320 * SpriteVF.SpriteVF_SubImageSize.z)) + _286) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _334 = _74;
    _334[0] = _224;
    float3x3 _335 = _334;
    _335[1] = _227;
    float3x3 _369;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _368 = _335;
        _368[2] = normalize(cross(_224, _227));
        _369 = _368;
    }
    else
    {
        float3x3 _365;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _364 = _335;
            _364[2] = normalize(_115 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _365 = _364;
        }
        else
        {
            float3x3 _358 = _335;
            _358[2] = normalize(_115 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _115 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _365 = _358;
        }
        _369 = _365;
    }
    float _370 = _317.x;
    float _371 = _317.y;
    float _372 = _317.z;
    float4 _373 = float4(_370, _371, _372, 1.0);
    float4 _375 = float4(_373.x, _373.y, _373.z, _373.w);
    float4 _376 = View.View_TranslatedWorldToClip * _375;
    float4 _380 = float4(_369[0].x, _369[0].y, _369[0].z, float4(0.0).w);
    _380.w = _319;
    spvUnsafeArray<float4, 1> _389 = { float4(_333.x, _333.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _380;
    out.out_var_TEXCOORD11 = float4(_369[2], float(int(sign(determinant(_369)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out_var_TEXCOORD3 = _389;
    out.out_var_TEXCOORD6 = _375;
    out.gl_Position = _376;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

