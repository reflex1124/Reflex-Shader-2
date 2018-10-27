// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShaders/ReflexShaderBeta2"
{
	Properties
	{
		_MainTex("Diffuse", 2D) = "white" {}
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,1)
		_EmissionMap("Emission", 2D) = "black" {}
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_Normal("Normal", 2D) = "bump" {}
		[Toggle]_MatcapToggle("Matcap Toggle", Float) = 1
		_Matcap("Matcap", 2D) = "black" {}
		_MatcapColor("Matcap Color", Color) = (1,1,1,1)
		[Toggle]_MatcapShadowToggle("Matcap Shadow Toggle", Float) = 1
		_MatcapShadow("Matcap Shadow", 2D) = "white" {}
		_MatcapShadowColor("Matcap Shadow Color", Color) = (0.7843137,0.7843137,0.7843137,1)
		[Toggle]_MatcapMaskToggle("Matcap Mask Toggle", Float) = 0
		_MatcapMask("Matcap Mask", 2D) = "black" {}
		[Toggle]_ForceMatcap("Force Matcap", Float) = 0
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 1
		_RimLightColor("RimLight Color", Color) = (1,1,1,1)
		_RimLightPower("RimLight Power", Range( 0 , 1)) = 0
		_RimLightContrast("RimLight Contrast", Range( 0 , 10)) = 3
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		[Toggle]_RimLightNormal("Rim Light Normal", Float) = 0
		_OutlineWidth("Outline Width", Range( 0 , 1)) = 0
		_OutlineMask("Outline Mask", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (0.2941176,0.2941176,0.2941176,1)
		[Toggle]_ReflectionToggle("Reflection Toggle", Float) = 0
		_ReflectionIntensity("Reflection Intensity", Range( 0 , 1)) = 1
		_ReflectionMask("Reflection Mask", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 1
		[Toggle]_FresnelToggle("Fresnel Toggle", Float) = 0
		_FresnelPower("Fresnel Power", Range( 0 , 10)) = 1
		_FresnelScale("Fresnel Scale", Range( 0 , 3)) = 3
		[Toggle]_HalfLambertToggle("Half Lambert Toggle", Float) = 0
		_HalfLambertContrast("Half Lambert Contrast", Range( 1 , 20)) = 10
		_ShadowColor("Shadow Color", Color) = (1,1,1,1)
		_Shadow2Color("Shadow 2 Color", Color) = (1,1,1,1)
		_Max("Max", Range( 0 , 1)) = 1
		_Min("Min", Range( 0 , 1)) = 0
		[Toggle]_PosterizeToggle("Posterize Toggle", Float) = 0
		_1stShadowPlace("1st Shadow Place", Range( -1 , 1)) = 0
		_2ndShadowPlace("2nd Shadow Place", Range( -1 , 1)) = 0.1
		_NormalIntensity("Normal Intensity", Range( 0 , 1)) = 0.5
		_ShadowMask("Shadow Mask", 2D) = "white" {}
		_CutoutThreshold("Cutout Threshold", Range( 0 , 1)) = 1
		[Toggle]_OpacityCutoutToggle("Opacity Cutout Toggle", Float) = 0
		_CullMode("Cull Mode", Float) = 2
		[Toggle]_ObjectShadowBeta("Object Shadow Beta", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		ZWrite On
		ZTest Less
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask = v.texcoord * _OutlineMask_ST.xy + _OutlineMask_ST.zw;
			float outlineVar = ( (0.0 + (_OutlineWidth - 0.0) * (0.0002 - 0.0) / (1.0 - 0.0)) * tex2Dlod( _OutlineMask, float4( uv_OutlineMask, 0, 0.0) ) ).r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Diffuse154 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float3 appendResult344 = (float3(_OutlineColor.r , _OutlineColor.g , _OutlineColor.b));
			float3 normal5 = float3(0,1,0);
			float3 localFunction_ShadeSH95 = Function_ShadeSH9( normal5 );
			float4 transform23 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult7 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform23 ) );
			float3 reflVect6 = normalizeResult7.xyz;
			float3 localCubemapReflections6 = CubemapReflections6( reflVect6 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 Lighting177 = saturate( ( float4( localFunction_ShadeSH95 , 0.0 ) + float4( localCubemapReflections6 , 0.0 ) + ase_lightColor ) );
			float4 blendOpSrc306 = _ShadowColor;
			float4 blendOpDest306 = _Shadow2Color;
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode74 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float3 Normal239 = tex2DNode74;
			float3 lerpResult289 = lerp( Normal239 , float3( 0,0,1 ) , _NormalIntensity);
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g1 = dot( WorldNormalVector( i , lerpResult289 ) , ase_worldlightDir );
			float temp_output_243_0 = (dotResult5_g1*0.5 + 0.5);
			float temp_output_250_0 = ( ( ( ( _1stShadowPlace + lerp(temp_output_243_0,saturate( ( temp_output_243_0 * 1 ) ),_ObjectShadowBeta) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_6 = (temp_output_250_0).xxxx;
			float div252=256.0/float((int)255.0);
			float4 posterize252 = ( floor( temp_cast_6 * div252 ) / div252 );
			float4 temp_cast_7 = (temp_output_250_0).xxxx;
			float4 ifLocalVar276 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar276 = posterize252;
			else
				ifLocalVar276 = temp_cast_7;
			float4 temp_cast_8 = (_Min).xxxx;
			float4 temp_cast_9 = (_Max).xxxx;
			float4 clampResult257 = clamp( ifLocalVar276 , temp_cast_8 , temp_cast_9 );
			float4 lerpResult258 = lerp( _ShadowColor , float4( 1,1,1,0 ) , clampResult257.r);
			float temp_output_272_0 = ( ( ( ( _2ndShadowPlace + lerp(temp_output_243_0,saturate( ( temp_output_243_0 * 1 ) ),_ObjectShadowBeta) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_12 = (temp_output_272_0).xxxx;
			float div274=256.0/float((int)255.0);
			float4 posterize274 = ( floor( temp_cast_12 * div274 ) / div274 );
			float4 temp_cast_13 = (temp_output_272_0).xxxx;
			float4 ifLocalVar277 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar277 = posterize274;
			else
				ifLocalVar277 = temp_cast_13;
			float4 temp_cast_14 = (_Min).xxxx;
			float4 temp_cast_15 = (_Max).xxxx;
			float4 clampResult278 = clamp( ifLocalVar277 , temp_cast_14 , temp_cast_15 );
			float4 lerpResult279 = lerp( ( saturate( min( blendOpSrc306 , blendOpDest306 ) )) , lerpResult258 , clampResult278.r);
			float2 uv_ShadowMask = i.uv_texcoord * _ShadowMask_ST.xy + _ShadowMask_ST.zw;
			float4 lerpResult307 = lerp( float4( 1,1,1,1 ) , lerp(float4( 1,1,1,1 ),lerpResult279,_HalfLambertToggle) , tex2D( _ShadowMask, uv_ShadowMask ).r);
			float4 temp_cast_18 = (1.0).xxxx;
			float4 temp_cast_19 = (1.0).xxxx;
			float4 ifLocalVar317 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar317 = temp_cast_19;
			else
				ifLocalVar317 = lerpResult307;
			float4 HalfLambert261 = ifLocalVar317;
			o.Emission = ( float4( ( (Diffuse154).rgb * appendResult344 ) , 0.0 ) * Lighting177 * HalfLambert261 ).rgb;
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite On
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _CullMode;
		uniform float _CutoutThreshold;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float4 _EmissionColor;
		uniform float _OpacityCutoutToggle;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _DiffuseColor;
		uniform float _RimLightToggle;
		uniform float _RimLightNormal;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _RimLightPower;
		uniform float _RimLightContrast;
		uniform float4 _RimLightColor;
		uniform sampler2D _RimLightMask;
		uniform float4 _RimLightMask_ST;
		uniform float _MatcapToggle;
		uniform sampler2D _Matcap;
		uniform float4 _MatcapColor;
		uniform float _MatcapMaskToggle;
		uniform sampler2D _MatcapMask;
		uniform float4 _MatcapMask_ST;
		uniform float _ForceMatcap;
		uniform float _ReflectionToggle;
		uniform float _Smoothness;
		uniform sampler2D _ReflectionMask;
		uniform float4 _ReflectionMask_ST;
		uniform float _ReflectionIntensity;
		uniform float _FresnelToggle;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float _MatcapShadowToggle;
		uniform sampler2D _MatcapShadow;
		uniform float4 _MatcapShadowColor;
		uniform float _HalfLambertToggle;
		uniform float4 _ShadowColor;
		uniform float4 _Shadow2Color;
		uniform float _PosterizeToggle;
		uniform float _1stShadowPlace;
		uniform float _ObjectShadowBeta;
		uniform float _NormalIntensity;
		uniform float _HalfLambertContrast;
		uniform float _Min;
		uniform float _Max;
		uniform float _2ndShadowPlace;
		uniform sampler2D _ShadowMask;
		uniform float4 _ShadowMask_ST;
		uniform float _OutlineWidth;
		uniform sampler2D _OutlineMask;
		uniform float4 _OutlineMask_ST;
		uniform float4 _OutlineColor;


		float3 Function_ShadeSH9( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		float3 CubemapReflections6( float3 reflVect )
		{
			float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
			float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
			return reflCol * 0.02;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += saturate( 0 );
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 Diffuse154 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode74 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult126 = dot( WorldNormalVector( i , lerp(float3( 0,0,1 ),tex2DNode74,_RimLightNormal) ) , ase_worldViewDir );
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float4 lerpResult70 = lerp( ( ( ( ( ( abs( ( 1.0 - dotResult126 ) ) * _RimLightPower ) - 0.5 ) * _RimLightContrast ) + 0.5 ) * _RimLightColor ) , float4( 0,0,0,0 ) , ( 1.0 - tex2D( _RimLightMask, uv_RimLightMask ) ).r);
			float4 RimLight168 = saturate( lerp(float4( 0,0,0,0 ),lerpResult70,_RimLightToggle) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 blendOpSrc77 = tex2DNode74;
			float3 blendOpDest77 = mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz;
			float3 temp_output_33_0 = ( 0.5 + ( 0.5 * ((( blendOpDest77 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest77 - 0.5 ) ) * ( 1.0 - blendOpSrc77 ) ) : ( 2.0 * blendOpDest77 * blendOpSrc77 ) )).xyz ) );
			float4 blendOpSrc44 = lerp(float4( 0,0,0,0 ),tex2D( _Matcap, temp_output_33_0.xy ),_MatcapToggle);
			float4 blendOpDest44 = _MatcapColor;
			float2 uv_MatcapMask = i.uv_texcoord * _MatcapMask_ST.xy + _MatcapMask_ST.zw;
			float4 lerpResult67 = lerp( float4( 0,0,0,0 ) , ( saturate( ( blendOpSrc44 * blendOpDest44 ) )) , lerp(float4( 1,1,1,1 ),tex2D( _MatcapMask, uv_MatcapMask ),_MatcapMaskToggle).r);
			float4 lerpResult233 = lerp( Diffuse154 , float4( 0,0,0,0 ) , lerp(float4( 1,1,1,1 ),tex2D( _MatcapMask, uv_MatcapMask ),_MatcapMaskToggle).r);
			float4 Matcap181 = ( lerpResult67 + lerp(Diffuse154,lerpResult233,_ForceMatcap) );
			float3 indirectNormal212 = WorldNormalVector( i , tex2DNode74 );
			Unity_GlossyEnvironmentData g212 = UnityGlossyEnvironmentSetup( _Smoothness, data.worldViewDir, indirectNormal212, float3(0,0,0));
			float3 indirectSpecular212 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal212, g212 );
			float2 uv_ReflectionMask = i.uv_texcoord * _ReflectionMask_ST.xy + _ReflectionMask_ST.zw;
			float3 lerpResult216 = lerp( float3( 0,0,0 ) , indirectSpecular212 , tex2D( _ReflectionMask, uv_ReflectionMask ).r);
			float3 lerpResult222 = lerp( float3( 0,0,0 ) , lerpResult216 , _ReflectionIntensity);
			float fresnelNdotV225 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode225 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV225, _FresnelPower ) );
			float3 lerpResult227 = lerp( float3( 0,0,0 ) , lerpResult222 , lerp(1.0,fresnelNode225,_FresnelToggle));
			float3 Reflection218 = lerp(float3( 0,0,0 ),lerpResult227,_ReflectionToggle);
			float4 blendOpSrc47 = lerp(float4( 1,1,1,1 ),tex2D( _MatcapShadow, temp_output_33_0.xy ),_MatcapShadowToggle);
			float4 blendOpDest47 = _MatcapShadowColor;
			float4 MatcapShadow174 = ( saturate( ( blendOpSrc47 + blendOpDest47 ) ));
			float3 normal5 = float3(0,1,0);
			float3 localFunction_ShadeSH95 = Function_ShadeSH9( normal5 );
			float4 transform23 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult7 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform23 ) );
			float3 reflVect6 = normalizeResult7.xyz;
			float3 localCubemapReflections6 = CubemapReflections6( reflVect6 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 Lighting177 = saturate( ( float4( localFunction_ShadeSH95 , 0.0 ) + float4( localCubemapReflections6 , 0.0 ) + ase_lightColor ) );
			float4 blendOpSrc306 = _ShadowColor;
			float4 blendOpDest306 = _Shadow2Color;
			float3 Normal239 = tex2DNode74;
			float3 lerpResult289 = lerp( Normal239 , float3( 0,0,1 ) , _NormalIntensity);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g1 = dot( WorldNormalVector( i , lerpResult289 ) , ase_worldlightDir );
			float temp_output_243_0 = (dotResult5_g1*0.5 + 0.5);
			float temp_output_250_0 = ( ( ( ( _1stShadowPlace + lerp(temp_output_243_0,saturate( ( temp_output_243_0 * ase_lightAtten ) ),_ObjectShadowBeta) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_15 = (temp_output_250_0).xxxx;
			float div252=256.0/float((int)255.0);
			float4 posterize252 = ( floor( temp_cast_15 * div252 ) / div252 );
			float4 temp_cast_16 = (temp_output_250_0).xxxx;
			float4 ifLocalVar276 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar276 = posterize252;
			else
				ifLocalVar276 = temp_cast_16;
			float4 temp_cast_17 = (_Min).xxxx;
			float4 temp_cast_18 = (_Max).xxxx;
			float4 clampResult257 = clamp( ifLocalVar276 , temp_cast_17 , temp_cast_18 );
			float4 lerpResult258 = lerp( _ShadowColor , float4( 1,1,1,0 ) , clampResult257.r);
			float temp_output_272_0 = ( ( ( ( _2ndShadowPlace + lerp(temp_output_243_0,saturate( ( temp_output_243_0 * ase_lightAtten ) ),_ObjectShadowBeta) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_21 = (temp_output_272_0).xxxx;
			float div274=256.0/float((int)255.0);
			float4 posterize274 = ( floor( temp_cast_21 * div274 ) / div274 );
			float4 temp_cast_22 = (temp_output_272_0).xxxx;
			float4 ifLocalVar277 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar277 = posterize274;
			else
				ifLocalVar277 = temp_cast_22;
			float4 temp_cast_23 = (_Min).xxxx;
			float4 temp_cast_24 = (_Max).xxxx;
			float4 clampResult278 = clamp( ifLocalVar277 , temp_cast_23 , temp_cast_24 );
			float4 lerpResult279 = lerp( ( saturate( min( blendOpSrc306 , blendOpDest306 ) )) , lerpResult258 , clampResult278.r);
			float2 uv_ShadowMask = i.uv_texcoord * _ShadowMask_ST.xy + _ShadowMask_ST.zw;
			float4 lerpResult307 = lerp( float4( 1,1,1,1 ) , lerp(float4( 1,1,1,1 ),lerpResult279,_HalfLambertToggle) , tex2D( _ShadowMask, uv_ShadowMask ).r);
			float4 temp_cast_27 = (1.0).xxxx;
			float4 temp_cast_28 = (1.0).xxxx;
			float4 ifLocalVar317 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar317 = temp_cast_28;
			else
				ifLocalVar317 = lerpResult307;
			float4 HalfLambert261 = ifLocalVar317;
			c.rgb = saturate( ( ( RimLight168 + Matcap181 + float4( Reflection218 , 0.0 ) ) * MatcapShadow174 * Lighting177 * HalfLambert261 ) ).rgb;
			c.a = 1;
			clip( lerp(1.0,Diffuse154.a,_OpacityCutoutToggle) - _CutoutThreshold );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			o.Emission = ( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
1069;92;851;926;-2089.324;57.33984;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;164;-2177.591,-1367.854;Float;False;4225.036;554.7432;;26;168;62;70;73;51;72;113;52;112;190;109;237;111;103;110;104;128;127;235;126;149;148;74;293;239;315;Rim Light;0,0.7103448,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;240;-999.7175,935.533;Float;False;5505.063;882.4978;Half Lambert Experimental;48;261;307;308;259;279;285;258;306;280;256;278;257;277;276;254;253;274;255;252;249;250;272;248;247;273;271;246;245;270;244;269;267;268;309;263;313;311;243;310;242;289;290;241;317;318;319;347;350;Experimental;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;74;-2146.281,-1255.8;Float;True;Property;_Normal;Normal;4;0;Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;239;-1728.384,-1081.516;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;290;-906.3096,1362.005;Float;False;Property;_NormalIntensity;Normal Intensity;40;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;-817.5385,1270.281;Float;False;239;0;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;289;-587.3091,1321.005;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;242;-312.9203,1321.783;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;310;-79.9082,1545.982;Float;True;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;243;-88.68346,1321.724;Float;True;Half Lambert Term;-1;;1;86299dc21373a954aa5772333626c9c1;0;1;3;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;311;180.7231,1403.874;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;313;332.8926,1403.41;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;268;515.5107,1509.028;Float;False;Property;_2ndShadowPlace;2nd Shadow Place;39;0;Create;True;0;0;False;0;0.1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;309;519.8101,1316.322;Float;False;Property;_ObjectShadowBeta;Object Shadow Beta;45;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;263;497.7073,1177.735;Float;False;Property;_1stShadowPlace;1st Shadow Place;38;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;293;-1749.437,-1267.21;Float;False;Property;_RimLightNormal;Rim Light Normal;19;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;269;859.1844,1514.67;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;267;863.0586,1184.393;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;244;806.9529,1298.618;Float;False;Constant;_Float1;Float 1;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;183;-2172.789,-732.8777;Float;False;3722.722;836.1322;;26;233;150;170;88;174;181;47;46;180;40;67;39;44;45;36;69;34;33;32;31;30;77;29;28;27;236;Matcap;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;149;-1417.724,-1030.24;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;148;-1441.111,-1263.694;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;246;806.8718,1386.156;Float;False;Property;_HalfLambertContrast;Half Lambert Contrast;32;0;Create;True;0;0;False;0;10;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;245;1061.59,1185.533;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;270;1036.511,1515.71;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;235;-1796.745,-1165.122;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;126;-1173.324,-1107.464;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewMatrixNode;27;-2086.737,-430.3694;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-2112.637,-352.5404;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;248;1293.299,1276.658;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;247;1208.548,1186.132;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;273;1304.55,1463.912;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;271;1187.469,1516.309;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;236;-1772.175,-442.3935;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;127;-1005.084,-1226.09;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1873,-388.6219;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;250;1375.848,1185.999;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;249;1192.114,1334.275;Float;False;Constant;_Posterize;Posterize;29;0;Create;True;0;0;False;0;255;0;1;255;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;272;1354.768,1516.176;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;128;-812.902,-1226.385;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;77;-1688.072,-417.4798;Float;False;Overlay;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-968.187,-1128.833;Float;False;Property;_RimLightPower;RimLight Power;16;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;255;1533.107,1346.871;Float;False;Property;_PosterizeToggle;Posterize Toggle;37;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosterizeNode;252;1556.677,1184.918;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosterizeNode;274;1550.168,1556.182;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-587.7396,-1225.358;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-585.2145,-1093.067;Float;False;Constant;_Float9;Float 9;20;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1424.144,-417.1291;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1400.069,-500.3126;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;237;-1911.316,-946.3781;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;254;1928.704,1408.435;Float;False;Property;_Max;Max;35;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;277;1899.826,1504.875;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;276;1890.364,1139.919;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;253;1929.087,1323.027;Float;False;Property;_Min;Min;36;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;173;-2174.466,807.0804;Float;False;1089.884;388.5471;;4;92;93;13;154;Diffuse;0,0.7931037,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-366.6481,-1128.862;Float;False;Property;_RimLightContrast;RimLight Contrast;17;0;Create;True;0;0;False;0;3;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;109;-346.4343,-1233.359;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;159;-72.5424,204.9481;Float;False;1646.334;654.1909;;13;177;12;17;5;6;16;7;15;4;8;23;24;340;Lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1177.664,-435.1183;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;224;-2171.25,207.042;Float;False;1893.696;490.2621;;14;230;229;218;220;227;222;225;216;223;221;212;213;231;232;Reflection;0.9034483,1,0,1;0;0
Node;AmplifyShaderEditor.WireNode;238;-1908.745,129.5771;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;221;-2107.006,377.2619;Float;True;Property;_ReflectionMask;Reflection Mask;26;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;190;-90.76141,-1071.241;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;256;2452.304,1126.027;Float;False;Property;_ShadowColor;Shadow Color;33;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;257;2273.523,1138.546;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;280;2462.892,1342.733;Float;False;Property;_Shadow2Color;Shadow 2 Color;34;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;278;2275.918,1504.772;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-64.43411,-1235.359;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;93;-1815.447,984.6288;Float;False;Property;_DiffuseColor;Diffuse Color;1;0;Create;True;0;0;False;0;1,1,1,1;0.8156863,0.8705882,0.8745098,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-997.074,-495.5633;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;13;-2124.466,887.2708;Float;True;Property;_MainTex;Diffuse;0;0;Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;213;-2108.702,284.3296;Float;False;Property;_Smoothness;Smoothness;27;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;24;-22.54246,385.1451;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;22.48633,553.4836;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-783.8476,-553.8091;Float;True;Property;_Matcap;Matcap;6;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;351.8141,-1102.093;Float;True;Property;_RimLightMask;RimLight Mask;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;285;2713.855,1494.466;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;306;2734.577,1263.973;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;52;70.9248,-1081.43;Float;False;Property;_RimLightColor;RimLight Color;15;0;Create;True;0;0;False;0;1,1,1,1;0.3676468,0.4243406,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;258;2766.953,1133.113;Float;False;3;0;COLOR;1,1,1,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;230;-1803.996,606.5069;Float;False;Property;_FresnelPower;Fresnel Power;29;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;-87.3358,-437.6962;Float;True;Property;_MatcapMask;Matcap Mask;12;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-1533.319,891.0808;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;232;-1546.119,385.2674;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;212;-1776.883,264.7517;Float;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;320.2721,451.7593;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;229;-1803.996,520.507;Float;False;Property;_FresnelScale;Fresnel Scale;30;0;Create;True;0;0;False;0;3;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;150.2805,-1206.675;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;223;-1593.458,430.8602;Float;False;Property;_ReflectionIntensity;Reflection Intensity;25;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;36;-403.5202,-577.3022;Float;False;Property;_MatcapToggle;Matcap Toggle;5;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;279;2972.579,1269.292;Float;False;3;0;COLOR;1,1,1,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;216;-1465.845,261.6745;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;225;-1488.674,512.3372;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-399.919,-460.1464;Float;False;Property;_MatcapColor;Matcap Color;7;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;154;-1327.58,885.5858;Float;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;4;358.6006,266.3255;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;347.8417,-1225.022;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalizeNode;7;506.2734,454.7593;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;73;675.8228,-1097.72;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;88;236.7928,-461.4327;Float;False;Property;_MatcapMaskToggle;Matcap Mask Toggle;11;0;Create;True;0;0;False;0;0;2;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;252.2663,-325.0573;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;231;-1256.637,417.0988;Float;False;Property;_FresnelToggle;Fresnel Toggle;28;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;44;-116.6535,-577.0939;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;308;3140.282,1376.493;Float;True;Property;_ShadowMask;Shadow Mask;41;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;259;3176.226,1241.941;Float;False;Property;_HalfLambertToggle;Half Lambert Toggle;31;0;Create;True;0;0;False;0;0;2;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;222;-1280.058,287.6603;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;233;570.978,-241.7933;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;6;673.2732,452.7594;Float;False;float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7)@$float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR)@$return reflCol * 0.02@;3;False;1;True;reflVect;FLOAT3;0,0,0;In;;Cubemap Reflections;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;70;885.687,-1216.333;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;16;286.3686,637.5099;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;166;1708.025,88.01051;Float;False;1419.646;731.8394;;15;342;161;341;155;207;151;158;163;179;160;157;156;153;344;345;Outline;0.7793107,0,1,1;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;5;605.1161,291.6772;Float;False;return ShadeSH9(half4(normal, 1.0))@$;3;False;1;True;normal;FLOAT3;0,0,0;In;;Function_ShadeSH9;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;959.536,433.0694;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;307;3486.083,1234.66;Float;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;319;3829.85,1400.32;Float;False;Constant;_Float2;Float 2;46;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;318;3775.916,1143.804;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;155;1914.545,157.6265;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;39;-788.9142,-240.9693;Float;True;Property;_MatcapShadow;Matcap Shadow;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;161;1920.873,230.0257;Float;False;Property;_OutlineColor;Outline Color;23;0;Create;True;0;0;False;0;0.2941176,0.2941176,0.2941176,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;62;1171.888,-1209.785;Float;False;Property;_RimLightToggle;RimLight Toggle;14;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;67;559.6579,-590.0699;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;227;-1033.299,306.6462;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;150;831.1585,-318.9073;Float;False;Property;_ForceMatcap;Force Matcap;13;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-403.1573,-156.5209;Float;False;Property;_MatcapShadowColor;Matcap Shadow Color;10;0;Create;True;0;0;False;0;0.7843137,0.7843137,0.7843137,1;0.5607843,0.2784311,0.3215683,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;340;1137.825,450.0106;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;344;2199.38,247.3166;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;317;4024.676,1229.2;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;1067.867,-427.8333;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;167;1981.288,-671.9069;Float;False;943.2012;689.1664;;12;84;314;41;187;178;262;175;185;35;219;182;169;Composite;1,0,0,1;0;0
Node;AmplifyShaderEditor.SaturateNode;315;1463.131,-1203.916;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;40;-408.2112,-264.1084;Float;False;Property;_MatcapShadowToggle;Matcap Shadow Toggle;8;0;Create;True;0;0;False;0;1;2;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;220;-861.4617,271.2718;Float;False;Property;_ReflectionToggle;Reflection Toggle;24;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;341;2128.467,157.0734;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;153;1751.777,416.0663;Float;False;Property;_OutlineWidth;Outline Width;21;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;1245.12,-432.6333;Float;False;Matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;2048.63,-499.9666;Float;False;168;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;179;2351.648,276.9459;Float;False;177;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;345;2309.559,362.2866;Float;False;261;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;261;4294.117,1238.347;Float;False;HalfLambert;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;47;-84.27655,-182.8362;Float;False;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;219;2052.979,-339.193;Float;False;218;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;177;1338.968,477.6392;Float;False;Lighting;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;-553.5941,270.6498;Float;False;Reflection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;2367.267,185.7227;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;2050.686,-418.0836;Float;False;181;0;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;157;1983.385,593.6958;Float;True;Property;_OutlineMask;Outline Mask;22;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;156;2063.527,420.7526;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.0002;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;168;1696.553,-1188.6;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;2052.31,-168.8007;Float;False;177;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;174;174.4035,-183.4281;Float;False;MatcapShadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;2325.387,497.6964;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;175;2052.25,-252.2475;Float;False;174;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;2283.942,-456.3819;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;163;2553.288,241.227;Float;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;262;2054.036,-87.2196;Float;False;261;0;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;165;2252.674,-1255.483;Float;False;609.6152;485.8191;;3;22;95;94;Emission;1,0.3931035,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;2044.974,-600.1266;Float;False;154;0;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;95;2307.026,-977.9225;Float;False;Property;_EmissionColor;Emission Color;3;0;Create;True;0;0;False;0;1,1,1,1;0.8392157,0.8392157,0.8392157,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;199;2243.831,-1648.853;Float;False;358.991;291.938;Properties;2;208;198;Miscellaneous;0.5514706,0.5514706,0.5514706,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;187;2326.755,-594.235;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;22;2326.243,-1177.931;Float;True;Property;_EmissionMap;Emission;2;0;Create;False;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OutlineNode;151;2734.365,233.3293;Float;False;0;False;None;1;1;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2427.689,-386.2887;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;208;2283.522,-1489.476;Float;False;Property;_CutoutThreshold;Cutout Threshold;42;0;Create;True;0;0;True;0;1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;2281.831,-1576.853;Float;False;Property;_CullMode;Cull Mode;44;0;Create;True;0;0;True;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;314;2686.167,-385.5211;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;342;2984.432,215.7406;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;2695.289,-1058.226;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;2599.946,-562.9775;Float;False;Property;_OpacityCutoutToggle;Opacity Cutout Toggle;43;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;728.7861,601.0787;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomStandardSurface;347;-82.28223,1098.703;Float;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;207;2725.111,427.3597;Float;False;Property;_OutlineToggle;Outline Toggle;20;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-253.9404,1092.381;Float;False;Constant;_Float4;Float 4;46;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;15;274.6241,564.9788;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;3367.003,-613.6663;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShaders/ReflexShaderBeta2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0.0001;0.2463776,0.3602941,0.3478668,1;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;198;-1;0;True;208;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;239;0;74;0
WireConnection;289;0;241;0
WireConnection;289;2;290;0
WireConnection;242;0;289;0
WireConnection;243;3;242;0
WireConnection;311;0;243;0
WireConnection;311;1;310;0
WireConnection;313;0;311;0
WireConnection;309;0;243;0
WireConnection;309;1;313;0
WireConnection;293;1;74;0
WireConnection;269;0;268;0
WireConnection;269;1;309;0
WireConnection;267;0;263;0
WireConnection;267;1;309;0
WireConnection;148;0;293;0
WireConnection;245;0;267;0
WireConnection;245;1;244;0
WireConnection;270;0;269;0
WireConnection;270;1;244;0
WireConnection;235;0;74;0
WireConnection;126;0;148;0
WireConnection;126;1;149;0
WireConnection;248;0;244;0
WireConnection;247;0;245;0
WireConnection;247;1;246;0
WireConnection;273;0;244;0
WireConnection;271;0;270;0
WireConnection;271;1;246;0
WireConnection;236;0;235;0
WireConnection;127;0;126;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;250;0;247;0
WireConnection;250;1;248;0
WireConnection;272;0;271;0
WireConnection;272;1;273;0
WireConnection;128;0;127;0
WireConnection;77;0;236;0
WireConnection;77;1;29;0
WireConnection;252;1;250;0
WireConnection;252;0;249;0
WireConnection;274;1;272;0
WireConnection;274;0;249;0
WireConnection;103;0;128;0
WireConnection;103;1;104;0
WireConnection;30;0;77;0
WireConnection;237;0;74;0
WireConnection;277;0;255;0
WireConnection;277;2;274;0
WireConnection;277;3;274;0
WireConnection;277;4;272;0
WireConnection;276;0;255;0
WireConnection;276;2;252;0
WireConnection;276;3;252;0
WireConnection;276;4;250;0
WireConnection;109;0;103;0
WireConnection;109;1;110;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;238;0;237;0
WireConnection;190;0;110;0
WireConnection;257;0;276;0
WireConnection;257;1;253;0
WireConnection;257;2;254;0
WireConnection;278;0;277;0
WireConnection;278;1;253;0
WireConnection;278;2;254;0
WireConnection;112;0;109;0
WireConnection;112;1;111;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;34;1;33;0
WireConnection;285;0;278;0
WireConnection;306;0;256;0
WireConnection;306;1;280;0
WireConnection;258;0;256;0
WireConnection;258;2;257;0
WireConnection;92;0;13;0
WireConnection;92;1;93;0
WireConnection;232;0;221;0
WireConnection;212;0;238;0
WireConnection;212;1;213;0
WireConnection;8;0;24;0
WireConnection;8;1;23;0
WireConnection;113;0;112;0
WireConnection;113;1;190;0
WireConnection;36;1;34;0
WireConnection;279;0;306;0
WireConnection;279;1;258;0
WireConnection;279;2;285;0
WireConnection;216;1;212;0
WireConnection;216;2;232;0
WireConnection;225;2;229;0
WireConnection;225;3;230;0
WireConnection;154;0;92;0
WireConnection;51;0;113;0
WireConnection;51;1;52;0
WireConnection;7;0;8;0
WireConnection;73;0;72;0
WireConnection;88;1;69;0
WireConnection;231;1;225;0
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;259;1;279;0
WireConnection;222;1;216;0
WireConnection;222;2;223;0
WireConnection;233;0;170;0
WireConnection;233;2;88;0
WireConnection;6;0;7;0
WireConnection;70;0;51;0
WireConnection;70;2;73;0
WireConnection;5;0;4;0
WireConnection;12;0;5;0
WireConnection;12;1;6;0
WireConnection;12;2;16;0
WireConnection;307;1;259;0
WireConnection;307;2;308;0
WireConnection;39;1;33;0
WireConnection;62;1;70;0
WireConnection;67;1;44;0
WireConnection;67;2;88;0
WireConnection;227;1;222;0
WireConnection;227;2;231;0
WireConnection;150;0;170;0
WireConnection;150;1;233;0
WireConnection;340;0;12;0
WireConnection;344;0;161;1
WireConnection;344;1;161;2
WireConnection;344;2;161;3
WireConnection;317;0;318;2
WireConnection;317;2;307;0
WireConnection;317;3;319;0
WireConnection;317;4;319;0
WireConnection;180;0;67;0
WireConnection;180;1;150;0
WireConnection;315;0;62;0
WireConnection;40;1;39;0
WireConnection;220;1;227;0
WireConnection;341;0;155;0
WireConnection;181;0;180;0
WireConnection;261;0;317;0
WireConnection;47;0;40;0
WireConnection;47;1;46;0
WireConnection;177;0;340;0
WireConnection;218;0;220;0
WireConnection;160;0;341;0
WireConnection;160;1;344;0
WireConnection;156;0;153;0
WireConnection;168;0;315;0
WireConnection;174;0;47;0
WireConnection;158;0;156;0
WireConnection;158;1;157;0
WireConnection;35;0;169;0
WireConnection;35;1;182;0
WireConnection;35;2;219;0
WireConnection;163;0;160;0
WireConnection;163;1;179;0
WireConnection;163;2;345;0
WireConnection;187;0;185;0
WireConnection;151;0;163;0
WireConnection;151;1;158;0
WireConnection;41;0;35;0
WireConnection;41;1;175;0
WireConnection;41;2;178;0
WireConnection;41;3;262;0
WireConnection;314;0;41;0
WireConnection;342;0;151;0
WireConnection;94;0;22;0
WireConnection;94;1;95;0
WireConnection;84;1;187;3
WireConnection;17;0;15;0
WireConnection;17;1;16;1
WireConnection;347;0;350;0
WireConnection;65;2;94;0
WireConnection;65;10;84;0
WireConnection;65;13;314;0
WireConnection;65;11;342;0
ASEEND*/
//CHKSM=5F97E38D337947AB613F5304B652AA3F90D920DF