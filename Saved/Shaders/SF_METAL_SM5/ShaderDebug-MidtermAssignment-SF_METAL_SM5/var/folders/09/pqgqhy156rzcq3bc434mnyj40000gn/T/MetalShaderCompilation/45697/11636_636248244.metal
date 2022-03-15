

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
    char _m4_pad[48];
    float3 View_TranslatedWorldCameraOrigin;
    char _m5_pad[16];
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

struct type_EmitterDynamicUniforms
{
    float2 EmitterDynamicUniforms_LocalToWorldScale;
    float4 EmitterDynamicUniforms_AxisLockRight;
    float4 EmitterDynamicUniforms_AxisLockUp;
};

struct type_EmitterUniforms
{
    char _m0_pad[48];
    float4 EmitterUniforms_MiscCurve;
    float4 EmitterUniforms_MiscScale;
    float4 EmitterUniforms_MiscBias;
    float4 EmitterUniforms_SizeBySpeed;
    char _m4_pad[16];
    float4 EmitterUniforms_TangentSelector;
    packed_float3 EmitterUniforms_CameraFacingBlend;
    float EmitterUniforms_RemoveHMDRoll;
    float EmitterUniforms_RotationRateScale;
    float EmitterUniforms_RotationBias;
    char _m9_pad[8];
    float2 EmitterUniforms_PivotOffset;
};

struct type_Globals
{
    uint ParticleIndicesOffset;
    uint LayerId;
};

constant float3x3 _97 = {};

struct MainForGS_out
{
    float4 out_var_TANGENTX [[user(locn0)]];
    float4 out_var_TANGENTZ [[user(locn1)]];
    float3 out_var_TEXCOORD7 [[user(locn2)]];
    float4 out_var_TEXCOORD6 [[user(locn3)]];
    float3 out_var_TEXCOORD8 [[user(locn4)]];
    uint gl_Layer [[render_target_array_index]];
    float4 gl_Position [[position, invariant]];
};

struct MainForGS_in
{
    float2 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex MainForGS_out Main_00002d74_25ec60b4(MainForGS_in in [[stage_in]], constant type_View& View [[buffer(1)]], constant type_Primitive& Primitive [[buffer(2)]], constant type_ShadowDepthPass& ShadowDepthPass [[buffer(3)]], constant type_EmitterDynamicUniforms& EmitterDynamicUniforms [[buffer(4)]], constant type_EmitterUniforms& EmitterUniforms [[buffer(5)]], constant type_Globals& _Globals [[buffer(6)]], texture_buffer<float> ParticleIndices [[texture(0)]], texture2d<float> PositionTexture [[texture(1)]], texture2d<float> VelocityTexture [[texture(2)]], texture2d<float> AttributesTexture [[texture(3)]], texture2d<float> CurveTexture [[texture(4)]], sampler PositionTextureSampler [[sampler(0)]], sampler VelocityTextureSampler [[sampler(1)]], sampler AttributesTextureSampler [[sampler(2)]], sampler CurveTextureSampler [[sampler(3)]], uint gl_VertexIndex [[vertex_id]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseVertex [[base_vertex]], uint gl_BaseInstance [[base_instance]])
{
    MainForGS_out out = {};
    uint _116 = (gl_InstanceIndex - gl_BaseInstance) * 16u;
    uint _117 = (gl_VertexIndex - gl_BaseVertex) / 4u;
    uint _118 = _116 + _117;
    uint _121 = _Globals.ParticleIndicesOffset + _118;
    float4 _123 = ParticleIndices.read(uint(_121));
    float2 _124 = _123.xy;
    float4 _128 = PositionTexture.sample(PositionTextureSampler, _124, level(0.0));
    float4 _132 = VelocityTexture.sample(VelocityTextureSampler, _124, level(0.0));
    float4 _136 = AttributesTexture.sample(AttributesTextureSampler, _124, level(0.0));
    float _137 = _128.w;
    float _138 = step(_137, 1.0);
    float3 _139 = _132.xyz;
    float3x3 _148 = float3x3(Primitive.Primitive_LocalToWorld[0].xyz, Primitive.Primitive_LocalToWorld[1].xyz, Primitive.Primitive_LocalToWorld[2].xyz);
    float3 _149 = _148 * _139;
    float3 _151 = normalize(_149 + float3(0.0, 0.0, 9.9999997473787516355514526367188e-05));
    float _152 = length(_149);
    float2 _157 = EmitterUniforms.EmitterUniforms_MiscCurve.zw * _137;
    float2 _158 = EmitterUniforms.EmitterUniforms_MiscCurve.xy + _157;
    float4 _162 = CurveTexture.sample(CurveTextureSampler, _158, level(0.0));
    float4 _165 = _162 * EmitterUniforms.EmitterUniforms_MiscScale;
    float4 _168 = _165 + EmitterUniforms.EmitterUniforms_MiscBias;
    float _169 = _136.x;
    bool _170 = _169 < 0.5;
    float _171 = _170 ? 0.0 : (-0.5);
    float _172 = _136.y;
    bool _173 = _172 < 0.5;
    float _174 = _173 ? 0.0 : (-0.5);
    float2 _175 = float2(_171, _174);
    float2 _176 = _136.xy;
    float2 _177 = _176 + _175;
    float2 _178 = _177 * float2(2.0);
    float2 _179 = _168.xy;
    float2 _182 = _179 * EmitterDynamicUniforms.EmitterDynamicUniforms_LocalToWorldScale;
    float2 _186 = EmitterUniforms.EmitterUniforms_SizeBySpeed.xy * _152;
    float2 _187 = fast::max(_186, float2(1.0));
    float2 _189 = fast::min(_187, EmitterUniforms.EmitterUniforms_SizeBySpeed.zw);
    float2 _190 = _178 * _182;
    float2 _191 = _190 * _189;
    float2 _192 = float2(_138);
    float2 _193 = _191 * _192;
    float _194 = _136.w;
    float _197 = _194 * EmitterUniforms.EmitterUniforms_RotationRateScale;
    float _198 = _136.z;
    float _199 = _197 * _137;
    float _200 = _198 + _199;
    float _201 = _200 * 6.283185482025146484375;
    float3 _205 = _128.xxx;
    float3 _206 = Primitive.Primitive_LocalToWorld[0u].xyz * _205;
    float3 _210 = _128.yyy;
    float3 _211 = Primitive.Primitive_LocalToWorld[1u].xyz * _210;
    float3 _212 = _206 + _211;
    float3 _216 = _128.zzz;
    float3 _217 = Primitive.Primitive_LocalToWorld[2u].xyz * _216;
    float3 _218 = _212 + _217;
    float3 _222 = Primitive.Primitive_LocalToWorld[3u].xyz + View.View_PreViewTranslation;
    float3 _223 = _218 + _222;
    float _224 = _223.x;
    float _225 = _223.y;
    float _226 = _223.z;
    float4 _227 = float4(_224, _225, _226, 1.0);
    float3 _228 = _227.xyz;
    float3 _231 = float3(EmitterUniforms.EmitterUniforms_RemoveHMDRoll);
    float3 _240 = mix(mix(View.View_ViewRight, View.View_HMDViewNoRollRight, _231), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.w));
    float3 _248 = mix(-mix(View.View_ViewUp, View.View_HMDViewNoRollUp, _231), EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.xyz, float3(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockUp.w));
    float3 _249 = View.View_TranslatedWorldCameraOrigin - _228;
    float _250 = dot(_249, _249);
    float3 _254 = _249 / float3(sqrt(fast::max(_250, 0.00999999977648258209228515625)));
    float3 _324;
    float3 _325;
    if (EmitterUniforms.EmitterUniforms_CameraFacingBlend[0] > 0.0)
    {
        float3 _268 = cross(_254, float3(0.0, 0.0, 1.0));
        float3 _273 = _268 / float3(sqrt(fast::max(dot(_268, _268), 0.00999999977648258209228515625)));
        float3 _275 = float3(fast::clamp((_250 * EmitterUniforms.EmitterUniforms_CameraFacingBlend[1]) - EmitterUniforms.EmitterUniforms_CameraFacingBlend[2], 0.0, 1.0));
        _324 = normalize(mix(_240, _273, _275));
        _325 = normalize(mix(_248, cross(_254, _273), _275));
    }
    else
    {
        float3 _322;
        float3 _323;
        if (EmitterUniforms.EmitterUniforms_TangentSelector.y > 0.0)
        {
            float3 _286 = cross(_254, _151);
            _322 = _286 / float3(sqrt(fast::max(dot(_286, _286), 0.00999999977648258209228515625)));
            _323 = -_151;
        }
        else
        {
            float3 _320;
            float3 _321;
            if (EmitterUniforms.EmitterUniforms_TangentSelector.z > 0.0)
            {
                float3 _299 = cross(EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz, _254);
                _320 = EmitterDynamicUniforms.EmitterDynamicUniforms_AxisLockRight.xyz;
                _321 = -(_299 / float3(sqrt(fast::max(dot(_299, _299), 0.00999999977648258209228515625))));
            }
            else
            {
                float3 _318;
                float3 _319;
                if (EmitterUniforms.EmitterUniforms_TangentSelector.w > 0.0)
                {
                    float3 _311 = cross(_254, float3(0.0, 0.0, 1.0));
                    float3 _316 = _311 / float3(sqrt(fast::max(dot(_311, _311), 0.00999999977648258209228515625)));
                    _318 = _316;
                    _319 = cross(_254, _316);
                }
                else
                {
                    _318 = _240;
                    _319 = _248;
                }
                _320 = _318;
                _321 = _319;
            }
            _322 = _320;
            _323 = _321;
        }
        _324 = _322;
        _325 = _323;
    }
    float _328 = _201 + EmitterUniforms.EmitterUniforms_RotationBias;
    float _329 = sin(_328);
    float _330 = cos(_328);
    float3 _331 = _325 * _329;
    float3 _332 = _324 * _330;
    float3 _333 = _331 + _332;
    float3 _334 = _325 * _330;
    float3 _335 = _324 * _329;
    float3 _336 = _334 - _335;
    float _337 = _193.x;
    float _341 = in.in_var_ATTRIBUTE0.x + EmitterUniforms.EmitterUniforms_PivotOffset.x;
    float _342 = _337 * _341;
    float3 _343 = _333 * _342;
    float _344 = _193.y;
    float _348 = in.in_var_ATTRIBUTE0.y + EmitterUniforms.EmitterUniforms_PivotOffset.y;
    float _349 = _344 * _348;
    float3 _350 = _336 * _349;
    float3 _351 = _343 + _350;
    float3 _352 = _228 + _351;
    float _353 = _352.x;
    float _354 = _352.y;
    float _355 = _352.z;
    float4 _356 = float4(_353, _354, _355, 1.0);
    float3x3 _357 = _97;
    _357[0] = _333;
    float3x3 _358 = _357;
    _358[1] = _336;
    float3 _360 = normalize(cross(_333, _336));
    float3x3 _361 = _358;
    _361[2] = _360;
    float4 _362 = float4(_356.x, _356.y, _356.z, _356.w);
    float4 _380 = ShadowDepthPass.ShadowDepthPass_ShadowViewProjectionMatrices[_Globals.LayerId] * _362;
    out.out_var_TANGENTX = float4(_333, 0.0);
    out.out_var_TANGENTZ = float4(_360, float(int(sign(determinant(_361)))));
    out.out_var_TEXCOORD7 = _356.xyz;
    out.out_var_TEXCOORD6 = _380;
    out.out_var_TEXCOORD8 = _360;
    out.gl_Layer = _Globals.LayerId;
    out.gl_Position = _380;
    return out;
}

