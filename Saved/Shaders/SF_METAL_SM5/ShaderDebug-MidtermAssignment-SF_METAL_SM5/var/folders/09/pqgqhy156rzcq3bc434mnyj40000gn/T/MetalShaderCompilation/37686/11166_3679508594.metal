

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

constant float3x3 _81 = {};
constant float2 _82 = {};

struct MainVS_out
{
    float4 out_var_TEXCOORD10 [[user(locn0)]];
    float4 out_var_TEXCOORD11 [[user(locn1)]];
    float4 out_var_TEXCOORD1 [[user(locn2)]];
    float4 out_var_TEXCOORD2 [[user(locn3)]];
    float4 out_var_TEXCOORD3_0 [[user(locn4)]];
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
    float4 in_var_ATTRIBUTE5 [[attribute(5)]];
};

// Implementation of the GLSL mod() function, which is slightly different than Metal fmod()
template<typename Tx, typename Ty>
inline Tx mod(Tx x, Ty y)
{
    return x - y * floor(x / y);
}

vertex MainVS_out Main_00002b9e_db50d872(MainVS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_TranslucentDepthPass& TranslucentDepthPass [[buffer(3)]], constant type_SpriteVF& SpriteVF [[buffer(4)]], constant type_Globals& _Globals [[buffer(5)]], texture_buffer<float> CutoutGeometry [[texture(0)]], uint gl_VertexIndex [[vertex_id]], uint gl_BaseVertex [[base_vertex]])
{
    MainVS_out out = {};
    spvUnsafeArray<float4, 1> out_var_TEXCOORD3 = {};
    float3 _120 = (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE0.xyz, 1.0)).xyz;
    float3 _124 = float3(SpriteVF.SpriteVF_RemoveHMDRoll);
    float3 _133 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _124), SpriteVF.SpriteVF_AxisLockRight.xyz, float3(SpriteVF.SpriteVF_AxisLockRight.w));
    float3 _141 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _124), SpriteVF.SpriteVF_AxisLockUp.xyz, float3(SpriteVF.SpriteVF_AxisLockUp.w));
    float3 _142 = View.View_WorldCameraOrigin - _120;
    float _143 = dot(_142, _142);
    float3 _146 = _142 * rsqrt(fast::max(_143, 9.9999999392252902907785028219223e-09));
    float3 _216;
    float3 _217;
    if (SpriteVF.SpriteVF_CameraFacingBlend[0] > 0.0)
    {
        float3 _205 = cross(_146, float3(0.0, 0.0, 1.0));
        float3 _209 = _205 * rsqrt(fast::max(dot(_205, _205), 9.9999999392252902907785028219223e-09));
        float3 _211 = float3(fast::clamp((_143 * SpriteVF.SpriteVF_CameraFacingBlend[1]) - SpriteVF.SpriteVF_CameraFacingBlend[2], 0.0, 1.0));
        _216 = normalize(mix(_133, _209, _211));
        _217 = normalize(mix(_141, cross(_146, _209), _211));
    }
    else
    {
        float3 _196;
        float3 _197;
        if (SpriteVF.SpriteVF_TangentSelector.y > 0.0)
        {
            float3 _185 = _120 - (Primitive.Primitive_LocalToWorld * float4(in.in_var_ATTRIBUTE1.xyz, 1.0)).xyz;
            float3 _189 = _185 * rsqrt(fast::max(dot(_185, _185), 9.9999999392252902907785028219223e-09));
            float3 _190 = cross(_146, _189);
            _196 = _190 * rsqrt(fast::max(dot(_190, _190), 9.9999999392252902907785028219223e-09));
            _197 = -_189;
        }
        else
        {
            float3 _183;
            float3 _184;
            if (SpriteVF.SpriteVF_TangentSelector.z > 0.0)
            {
                float3 _177 = cross(SpriteVF.SpriteVF_AxisLockRight.xyz, _146);
                _183 = SpriteVF.SpriteVF_AxisLockRight.xyz;
                _184 = -(_177 * rsqrt(fast::max(dot(_177, _177), 9.9999999392252902907785028219223e-09)));
            }
            else
            {
                float3 _175;
                float3 _176;
                if (SpriteVF.SpriteVF_TangentSelector.w > 0.0)
                {
                    float3 _169 = cross(_146, float3(0.0, 0.0, 1.0));
                    float3 _173 = _169 * rsqrt(fast::max(dot(_169, _169), 9.9999999392252902907785028219223e-09));
                    _175 = _173;
                    _176 = cross(_146, _173);
                }
                else
                {
                    _175 = _133;
                    _176 = _141;
                }
                _183 = _175;
                _184 = _176;
            }
            _196 = _183;
            _197 = _184;
        }
        _216 = _196;
        _217 = _197;
    }
    float _224 = (in.in_var_ATTRIBUTE2.z * SpriteVF.SpriteVF_RotationScale) + SpriteVF.SpriteVF_RotationBias;
    float _225 = sin(_224);
    float _226 = cos(_224);
    float3 _229 = (_217 * _225) + (_216 * _226);
    float3 _232 = (_217 * _226) - (_216 * _225);
    float2 _236 = float2(int2(sign(in.in_var_ATTRIBUTE2.xy)));
    float2 _291;
    float2 _292;
    if (_Globals.NumCutoutVerticesPerFrame > 0u)
    {
        uint _258 = uint(mod(float((gl_VertexIndex - gl_BaseVertex)), float(_Globals.NumCutoutVerticesPerFrame)));
        float _267 = _236.x;
        float _268 = _236.y;
        uint _275;
        if ((_267 * _268) < 0.0)
        {
            _275 = (_Globals.NumCutoutVerticesPerFrame - 1u) - _258;
        }
        else
        {
            _275 = _258;
        }
        float4 _279 = CutoutGeometry.read(uint(((uint(mod(in.in_var_ATTRIBUTE2.w, SpriteVF.SpriteVF_SubImageSize.x * SpriteVF.SpriteVF_SubImageSize.y)) * _Globals.NumCutoutVerticesPerFrame) + _275)));
        float _282 = _279.x;
        float2 _285 = _82;
        _285.x = (_267 < 0.0) ? (1.0 - _282) : _282;
        float _287 = _279.y;
        float2 _290 = _285;
        _290.y = (_268 < 0.0) ? (1.0 - _287) : _287;
        _291 = _279.xy;
        _292 = _290;
    }
    else
    {
        float2 _248 = _82;
        _248.x = (_236.x < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.x) : in.in_var_ATTRIBUTE4.x;
        float2 _254 = _248;
        _254.y = (_236.y < 0.0) ? (1.0 - in.in_var_ATTRIBUTE4.y) : in.in_var_ATTRIBUTE4.y;
        _291 = _254;
        _292 = in.in_var_ATTRIBUTE4;
    }
    float2 _298 = abs(in.in_var_ATTRIBUTE2.xy);
    float _324 = fract(in.in_var_ATTRIBUTE2.w);
    float _325 = in.in_var_ATTRIBUTE2.w - _324;
    float2 _338 = (float2(mod(_325, SpriteVF.SpriteVF_SubImageSize.x), floor(_325 * SpriteVF.SpriteVF_SubImageSize.z)) + _291) * SpriteVF.SpriteVF_SubImageSize.zw;
    float3x3 _339 = _81;
    _339[0] = _229;
    float3x3 _340 = _339;
    _340[1] = _232;
    float3x3 _374;
    if (SpriteVF.SpriteVF_NormalsType < 0.5)
    {
        float3x3 _373 = _340;
        _373[2] = normalize(cross(_229, _232));
        _374 = _373;
    }
    else
    {
        float3x3 _370;
        if (SpriteVF.SpriteVF_NormalsType < 1.5)
        {
            float3x3 _369 = _340;
            _369[2] = normalize(_120 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz);
            _370 = _369;
        }
        else
        {
            float3x3 _363 = _340;
            _363[2] = normalize(_120 - (SpriteVF.SpriteVF_NormalsSphereCenter.xyz + (SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz * dot(SpriteVF.SpriteVF_NormalsCylinderUnitDirection.xyz, _120 - SpriteVF.SpriteVF_NormalsSphereCenter.xyz))));
            _370 = _363;
        }
        _374 = _370;
    }
    float4 _378 = float4(((float4(_120 + View.View_PreViewTranslation, 1.0) + (float4(_229, 0.0) * (_298.x * (_292.x + SpriteVF.SpriteVF_PivotOffset.x)))) + (float4(_232, 0.0) * (_298.y * (_292.y + SpriteVF.SpriteVF_PivotOffset.y)))).xyz, 1.0);
    float4 _379 = float4(_378.x, _378.y, _378.z, _378.w);
    float4 _382 = TranslucentDepthPass.TranslucentDepthPass_ProjectionMatrix * _379;
    float4 _393;
    if ((TranslucentDepthPass.TranslucentDepthPass_bClampToNearPlane != 0.0) && (_382.z < 0.0))
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
    float _397 = _393.z * TranslucentDepthPass.TranslucentDepthPass_InvMaxSubjectDepth;
    float4 _400 = _393;
    _400.z = _397 * _393.w;
    float4 _404 = float4(_374[0].x, _374[0].y, _374[0].z, float4(0.0).w);
    _404.w = _324;
    spvUnsafeArray<float4, 1> _414 = { float4(_338.x, _338.y, float4(0.0).z, float4(0.0).w) };
    out.out_var_TEXCOORD10 = _404;
    out.out_var_TEXCOORD11 = float4(_374[2], float(int(sign(determinant(_374)))));
    out.out_var_TEXCOORD1 = in.in_var_ATTRIBUTE5;
    out.out_var_TEXCOORD2 = in.in_var_ATTRIBUTE3;
    out_var_TEXCOORD3 = _414;
    out.out_var_TEXCOORD6 = _397;
    out.out_var_TEXCOORD7 = _379;
    out.gl_Position = _400;
    out.out_var_TEXCOORD3_0 = out_var_TEXCOORD3[0];
    return out;
}

