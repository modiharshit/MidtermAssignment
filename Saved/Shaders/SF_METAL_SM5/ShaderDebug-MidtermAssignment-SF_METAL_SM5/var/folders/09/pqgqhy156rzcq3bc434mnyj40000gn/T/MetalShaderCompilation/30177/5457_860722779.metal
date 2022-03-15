

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct type_View
{
    float4x4 View_TranslatedWorldToClip;
    char _m1_pad[1056];
    float3 View_PreViewTranslation;
};

struct type_Primitive
{
    float4x4 Primitive_LocalToWorld;
};

struct type_Globals
{
    float4 InstancingViewZCompareZero;
    float4 InstancingViewZCompareOne;
    float4 InstancingViewZConstant;
    float4 InstancingWorldViewOriginZero;
    float4 InstancingWorldViewOriginOne;
    float4 InstancingOffset;
    float4 InstancingFadeOutParams;
    uint InstanceOffset;
};

struct Main_out
{
    float4 gl_Position [[position, invariant]];
};

struct Main_in
{
    float4 in_var_ATTRIBUTE0 [[attribute(0)]];
};

vertex Main_out Main_00001551_334d965b(Main_in in [[stage_in]], constant type_View& View [[buffer(2)]], constant type_Primitive& Primitive [[buffer(3)]], constant type_Globals& _Globals [[buffer(4)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceOriginBuffer [[texture(0)]], texture_buffer<float> InstanceVF_VertexFetch_InstanceTransformBuffer [[texture(1)]], uint gl_InstanceIndex [[instance_id]], uint gl_BaseInstance [[base_instance]])
{
    Main_out out = {};
    uint _65 = (gl_InstanceIndex - gl_BaseInstance) + _Globals.InstanceOffset;
    uint _66 = 3u * _65;
    float4 _68 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_66));
    uint _69 = _66 + 1u;
    float4 _70 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_69));
    uint _71 = _66 + 2u;
    float4 _72 = InstanceVF_VertexFetch_InstanceTransformBuffer.read(uint(_71));
    float4 _74 = InstanceVF_VertexFetch_InstanceOriginBuffer.read(uint(_65));
    float _83 = _68.w;
    float _84 = _83 * 0.00390625;
    float _85 = trunc(_84);
    float _86 = _74.w;
    float3 _87 = _74.xyz;
    float3 _91 = _87 + _Globals.InstancingOffset.xyz;
    float3 _92 = _91.xxx;
    float3 _93 = Primitive.Primitive_LocalToWorld[0].xyz * _92;
    float3 _94 = _91.yyy;
    float3 _95 = Primitive.Primitive_LocalToWorld[1].xyz * _94;
    float3 _96 = _93 + _95;
    float3 _97 = _91.zzz;
    float3 _98 = Primitive.Primitive_LocalToWorld[2].xyz * _97;
    float3 _99 = _96 + _98;
    float3 _102 = _99 + Primitive.Primitive_LocalToWorld[3].xyz;
    float _105 = _Globals.InstancingFadeOutParams.z * _85;
    float _108 = 1.0 - _85;
    float _109 = _Globals.InstancingFadeOutParams.w * _108;
    float _110 = _105 + _109;
    float _114 = _Globals.InstancingViewZCompareZero.w * _86;
    float3 _118 = _102 - _Globals.InstancingWorldViewOriginZero.xyz;
    float _119 = length(_118);
    float _120 = _119 + _114;
    float3 _124 = _102 - _Globals.InstancingWorldViewOriginOne.xyz;
    float _125 = length(_124);
    float _126 = _125 + _114;
    float3 _127 = float3(_120);
    bool3 _130 = _127 > _Globals.InstancingViewZCompareZero.xyz;
    float3 _131 = select(float3(0.0), float3(1.0), _130);
    float _135 = dot(_131, _Globals.InstancingViewZConstant.xyz);
    float _138 = _135 * _Globals.InstancingWorldViewOriginZero.w;
    float3 _139 = float3(_126);
    bool3 _143 = _139 > _Globals.InstancingViewZCompareOne.xyz;
    float3 _144 = select(float3(0.0), float3(1.0), _143);
    float _145 = dot(_144, _Globals.InstancingViewZConstant.xyz);
    float _148 = _145 * _Globals.InstancingWorldViewOriginOne.w;
    float _149 = _138 + _148;
    float _150 = abs(_149);
    bool _151 = _150 < 0.999000012874603271484375;
    float _152 = float(_151);
    float _153 = _110 * _152;
    float _154 = _68.x;
    float _155 = _68.y;
    float _156 = _68.z;
    float4 _157 = float4(_154, _155, _156, 0.0);
    float _158 = _70.x;
    float _159 = _70.y;
    float _160 = _70.z;
    float4 _161 = float4(_158, _159, _160, 0.0);
    float _162 = _72.x;
    float _163 = _72.y;
    float _164 = _72.z;
    float4 _165 = float4(_162, _163, _164, 0.0);
    float _166 = _74.x;
    float _167 = _74.y;
    float _168 = _74.z;
    float4 _169 = float4(_166, _167, _168, 1.0);
    float4x4 _170 = float4x4(_157, _161, _165, _169);
    float4 _171 = _170 * in.in_var_ATTRIBUTE0;
    float3 _172 = _171.xxx;
    float3 _173 = Primitive.Primitive_LocalToWorld[0].xyz * _172;
    float3 _174 = _171.yyy;
    float3 _175 = Primitive.Primitive_LocalToWorld[1].xyz * _174;
    float3 _176 = _173 + _175;
    float3 _177 = _171.zzz;
    float3 _178 = Primitive.Primitive_LocalToWorld[2].xyz * _177;
    float3 _179 = _176 + _178;
    float3 _180 = Primitive.Primitive_LocalToWorld[3].xyz + View.View_PreViewTranslation;
    float3 _181 = _179 + _180;
    float _182 = _181.x;
    float _183 = _181.y;
    float _184 = _181.z;
    float4 _185 = float4(_182, _183, _184, 1.0);
    float4 _186 = _185 * _153;
    float4 _187 = float4(_186.x, _186.y, _186.z, _186.w);
    float4 _188 = View.View_TranslatedWorldToClip * _187;
    out.gl_Position = _188;
    return out;
}

