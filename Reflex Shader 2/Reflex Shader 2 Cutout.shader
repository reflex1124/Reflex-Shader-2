// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Reflex Shader 2/Reflex Shader 2 Cutout"
{
	Properties
	{
		[NoScaleOffset]_EmissiveScrollTex("Emissive Scroll Tex", 2D) = "black" {}
		[Toggle]_ScanLineToggle("Scan Line Toggle", Float) = 0
		[NoScaleOffset]_ScanLineTex("Scan Line Tex", 2D) = "white" {}
		_MainTex("Diffuse", 2D) = "white" {}
		[NoScaleOffset]_EmissiveScrollMask("Emissive Scroll Mask", 2D) = "white" {}
		_EmissiveScrollColor("Emissive Scroll Color", Color) = (1,1,1,1)
		_ScanLineColor("Scan Line Color", Color) = (0,0.710345,1,0)
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,1)
		_EmissionMap("Emission", 2D) = "black" {}
		_ScanLinePosition("Scan Line Position", Float) = 0
		_EmissiveScrollSpeed("Emissive Scroll Speed", Vector) = (1,0,0,0)
		_EmissiveScrollTiling("Emissive Scroll Tiling", Float) = 1
		_ScanLineWidth("Scan Line Width", Range( 0 , 1)) = 1
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		[Toggle]_EmissiveScrollGradient("Emissive Scroll Gradient", Float) = 1
		_ScanLineSpeed("Scan Line Speed", Float) = 1
		[Normal]_BumpMap("Normal Map", 2D) = "bump" {}
		[Toggle]_MatcapToggle("Matcap Toggle", Float) = 1
		_GradientCotrast("Gradient Cotrast", Float) = 1
		_Matcap("Matcap", 2D) = "black" {}
		_Strength("Strength", Float) = 0
		_MatcapColor("Matcap Color", Color) = (1,1,1,1)
		[Toggle]_MatcapShadowToggle("Matcap Shadow Toggle", Float) = 1
		_MatcapShadow("Matcap Shadow", 2D) = "white" {}
		_MatcapShadowColor("Matcap Shadow Color", Color) = (0.7843137,0.7843137,0.7843137,1)
		[Toggle]_MatcapMaskToggle("Matcap Mask Toggle", Float) = 0
		[NoScaleOffset]_MatcapMask("Matcap Mask", 2D) = "black" {}
		[Toggle]_ForceMatcap("Force Matcap", Float) = 0
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 1
		_RimLightColor("RimLight Color", Color) = (1,1,1,1)
		_RimLightPower("RimLight Power", Range( 0 , 1)) = 0
		_RimLightContrast("RimLight Contrast", Range( 0 , 10)) = 3
		[NoScaleOffset]_RimLightMask("RimLight Mask", 2D) = "white" {}
		[Toggle]_RimLightNormal("RimLight Normal", Float) = 0
		[Toggle]_OutlineToggle("Outline Toggle", Float) = 1
		_OutlineWidth("Outline Width", Range( 0 , 1)) = 0
		_OutlineColor("Outline Color", Color) = (0.2941176,0.2941176,0.2941176,1)
		[NoScaleOffset]_OutlineMask("Outline Mask", 2D) = "white" {}
		[Toggle]_HalfLambertToggle("Half Lambert Toggle", Float) = 1
		[Toggle]_ObjectShadow("Object Shadow", Float) = 1
		_HalfLambertContrast("Half Lambert Contrast", Range( 1 , 20)) = 10
		_Shadow1Color("Shadow 1 Color", Color) = (0.8627451,0.8627451,0.8627451,1)
		_Shadow2Color("Shadow 2 Color", Color) = (0.7843137,0.7843137,0.7843137,1)
		_Shadow1Place("Shadow 1 Place", Range( -1 , 1)) = 0
		_Shadow2Place("Shadow 2 Place", Range( -1 , 1)) = 0.1
		_ShadowDarknessMin("Shadow Darkness Min", Range( 0 , 1)) = 0
		[Toggle]_PosterizeToggle("Posterize Toggle", Float) = 0
		_NormalIntensity("Normal Intensity", Range( 0 , 1)) = 0.5
		[NoScaleOffset]_ShadowMask("Shadow Mask", 2D) = "white" {}
		_VDirLight("V Dir Light", Vector) = (0,0.6,1,0)
		[Toggle]_EmissiveScrollToggle("Emissive Scroll Toggle", Float) = 0
		[Toggle]_ForceEmissiveToogle("Force Emissive Toogle", Float) = 0
		_CullMode("Cull Mode", Float) = 2
		_CutoutThreshold("Cutout Threshold", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask389_g70 = v.texcoord;
			float outlineVar = ( (0.0 + (_OutlineWidth - 0.0) * (0.002 - 0.0) / (1.0 - 0.0)) * tex2Dlod( _OutlineMask, float4( uv_OutlineMask389_g70, 0, 0.0) ) ).r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0,1); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_84_0_g70 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float4 Diffuse105_g70 = temp_output_84_0_g70;
			float3 appendResult387_g70 = (float3(_OutlineColor.r , _OutlineColor.g , _OutlineColor.b));
			float3 localFunction_ShadeSH9411_g70 = Function_ShadeSH9();
			float3 localFunction_ShadeSH9410_g70 = Function_ShadeSH9();
			float3 blendOpSrc412_g70 = localFunction_ShadeSH9411_g70;
			float3 blendOpDest412_g70 = localFunction_ShadeSH9410_g70;
			float3 localFunction_ShadeSH9197_g70 = Function_ShadeSH9();
			float3 blendOpSrc409_g70 = ( saturate( 	max( blendOpSrc412_g70, blendOpDest412_g70 ) ));
			float3 blendOpDest409_g70 = localFunction_ShadeSH9197_g70;
			float4 transform189_g70 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult193_g70 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform189_g70 ) );
			float3 reflVect198_g70 = normalizeResult193_g70.xyz;
			float3 localCubemapReflections198_g70 = CubemapReflections198_g70( reflVect198_g70 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 ifLocalVar196_g70 = 0;
			if( _WorldSpaceLightPos0.w <= 0.0 )
				ifLocalVar196_g70 = ase_lightColor;
			else
				ifLocalVar196_g70 = ( 1 * ase_lightColor );
			float4 temp_output_200_0_g70 = saturate( ( float4( ( saturate( 	max( blendOpSrc409_g70, blendOpDest409_g70 ) )) , 0.0 ) + float4( localCubemapReflections198_g70 , 0.0 ) + ifLocalVar196_g70 ) );
			float4 Lighting201_g70 = temp_output_200_0_g70;
			float4 blendOpSrc365_g70 = _Shadow1Color;
			float4 blendOpDest365_g70 = _Shadow2Color;
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode207_g70 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 NormalMap208_g70 = tex2DNode207_g70;
			float3 lerpResult333_g70 = lerp( NormalMap208_g70 , float3( 0,0,1 ) , _NormalIntensity);
			float3 newWorldNormal334_g70 = (WorldNormalVector( i , lerpResult333_g70 ));
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g72 = dot( newWorldNormal334_g70 , ase_worldlightDir );
			float temp_output_335_0_g70 = (dotResult5_g72*0.5 + 0.5);
			float4 transform434_g70 = mul(unity_ObjectToWorld,float4( _VDirLight , 0.0 ));
			float dotResult441_g70 = dot( transform434_g70 , float4( newWorldNormal334_g70 , 0.0 ) );
			float ifLocalVar431_g70 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar431_g70 = dotResult441_g70;
			else
				ifLocalVar431_g70 = lerp(temp_output_335_0_g70,saturate( ( temp_output_335_0_g70 * 1 ) ),_ObjectShadow);
			float temp_output_351_0_g70 = ( ( ( ( _Shadow1Place + ifLocalVar431_g70 ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_8 = (temp_output_351_0_g70).xxxx;
			float div354_g70=256.0/float((int)255.0);
			float4 posterize354_g70 = ( floor( temp_cast_8 * div354_g70 ) / div354_g70 );
			float4 temp_cast_9 = (temp_output_351_0_g70).xxxx;
			float4 ifLocalVar358_g70 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar358_g70 = posterize354_g70;
			else
				ifLocalVar358_g70 = temp_cast_9;
			float4 temp_cast_10 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_11 = (1.0).xxxx;
			float4 clampResult364_g70 = clamp( ifLocalVar358_g70 , temp_cast_10 , temp_cast_11 );
			float4 lerpResult366_g70 = lerp( _Shadow1Color , float4( 1,1,1,0 ) , clampResult364_g70);
			float temp_output_353_0_g70 = ( ( ( ( _Shadow2Place + ifLocalVar431_g70 ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_13 = (temp_output_353_0_g70).xxxx;
			float div356_g70=256.0/float((int)255.0);
			float4 posterize356_g70 = ( floor( temp_cast_13 * div356_g70 ) / div356_g70 );
			float4 temp_cast_14 = (temp_output_353_0_g70).xxxx;
			float4 ifLocalVar360_g70 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar360_g70 = posterize356_g70;
			else
				ifLocalVar360_g70 = temp_cast_14;
			float4 temp_cast_15 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_16 = (1.0).xxxx;
			float4 clampResult363_g70 = clamp( ifLocalVar360_g70 , temp_cast_15 , temp_cast_16 );
			float4 lerpResult368_g70 = lerp( ( saturate( min( blendOpSrc365_g70 , blendOpDest365_g70 ) )) , lerpResult366_g70 , clampResult363_g70);
			float2 uv_ShadowMask369_g70 = i.uv_texcoord;
			float4 lerpResult372_g70 = lerp( float4( 1,1,1,1 ) , lerp(float4( 1,1,1,1 ),lerpResult368_g70,_HalfLambertToggle) , tex2D( _ShadowMask, uv_ShadowMask369_g70 ));
			float4 Shadow375_g70 = lerpResult372_g70;
			o.Emission = ( float4( ( (Diffuse105_g70).rgb * appendResult387_g70 ) , 0.0 ) * Lighting201_g70 * Shadow375_g70 ).rgb;
			clip( lerp(0.0,(Diffuse105_g70).a,_OutlineToggle) - _CutoutThreshold );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull [_CullMode]
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
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
		uniform float _ScanLineToggle;
		uniform sampler2D _ScanLineTex;
		uniform float _ScanLinePosition;
		uniform float _ScanLineSpeed;
		uniform float _ScanLineWidth;
		uniform float4 _ScanLineColor;
		uniform float _EmissiveScrollToggle;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionMap_ST;
		uniform float4 _EmissionColor;
		uniform float _EmissiveScrollGradient;
		uniform sampler2D _EmissiveScrollTex;
		uniform float _EmissiveScrollTiling;
		uniform float2 _EmissiveScrollSpeed;
		uniform sampler2D _EmissiveScrollMask;
		uniform float4 _EmissiveScrollColor;
		uniform float _Strength;
		uniform float _GradientCotrast;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _DiffuseColor;
		uniform float _RimLightToggle;
		uniform float _RimLightNormal;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _RimLightPower;
		uniform float _RimLightContrast;
		uniform float4 _RimLightColor;
		uniform sampler2D _RimLightMask;
		uniform float _MatcapToggle;
		uniform sampler2D _Matcap;
		uniform float4 _MatcapColor;
		uniform float _MatcapMaskToggle;
		uniform sampler2D _MatcapMask;
		uniform float _ForceMatcap;
		uniform float _MatcapShadowToggle;
		uniform sampler2D _MatcapShadow;
		uniform float4 _MatcapShadowColor;
		uniform float _HalfLambertToggle;
		uniform float4 _Shadow1Color;
		uniform float4 _Shadow2Color;
		uniform float _PosterizeToggle;
		uniform float _Shadow1Place;
		uniform float _ObjectShadow;
		uniform float _NormalIntensity;
		uniform float3 _VDirLight;
		uniform float _HalfLambertContrast;
		uniform float _ShadowDarknessMin;
		uniform float _Shadow2Place;
		uniform sampler2D _ShadowMask;
		uniform float _ForceEmissiveToogle;
		uniform float _OutlineWidth;
		uniform sampler2D _OutlineMask;
		uniform float4 _OutlineColor;
		uniform float _OutlineToggle;


		float3 Function_ShadeSH9(  )
		{
			return ShadeSH9(half4(0,0,0,1));
		}


		float3 CubemapReflections198_g70( float3 reflVect )
		{
			float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
			float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
			return reflCol * 0.02;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
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
			float4 temp_output_84_0_g70 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode207_g70 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult214_g70 = dot( (WorldNormalVector( i , lerp(float3( 0,0,1 ),tex2DNode207_g70,_RimLightNormal) )) , ase_worldViewDir );
			float2 uv_RimLightMask225_g70 = i.uv_texcoord;
			float4 lerpResult230_g70 = lerp( ( ( ( ( ( abs( ( 1.0 - dotResult214_g70 ) ) * _RimLightPower ) - 0.5 ) * _RimLightContrast ) + 0.5 ) * _RimLightColor ) , float4( 0,0,0,0 ) , ( 1.0 - tex2D( _RimLightMask, uv_RimLightMask225_g70 ) ));
			float4 RimLight233_g70 = saturate( lerp(float4( 0,0,0,0 ),lerpResult230_g70,_RimLightToggle) );
			float3 NormalMap208_g70 = tex2DNode207_g70;
			float3 temp_output_244_0_g70 = ( 0.5 + ( 0.5 * (mul( UNITY_MATRIX_V, float4( (WorldNormalVector( i , NormalMap208_g70 )) , 0.0 ) ).xyz).xyz ) );
			float4 blendOpSrc251_g70 = lerp(float4( 0,0,0,0 ),tex2D( _Matcap, temp_output_244_0_g70.xy ),_MatcapToggle);
			float4 blendOpDest251_g70 = _MatcapColor;
			float2 uv_MatcapMask246_g70 = i.uv_texcoord;
			float4 lerpResult254_g70 = lerp( float4( 0,0,0,0 ) , ( saturate( ( blendOpSrc251_g70 * blendOpDest251_g70 ) )) , lerp(float4( 1,1,1,1 ),tex2D( _MatcapMask, uv_MatcapMask246_g70 ),_MatcapMaskToggle));
			float4 Diffuse105_g70 = temp_output_84_0_g70;
			float4 lerpResult252_g70 = lerp( Diffuse105_g70 , float4( 0,0,0,0 ) , lerp(float4( 1,1,1,1 ),tex2D( _MatcapMask, uv_MatcapMask246_g70 ),_MatcapMaskToggle));
			float4 Matcap260_g70 = ( lerpResult254_g70 + lerp(Diffuse105_g70,lerpResult252_g70,_ForceMatcap) );
			float4 blendOpSrc259_g70 = lerp(float4( 1,1,1,1 ),tex2D( _MatcapShadow, temp_output_244_0_g70.xy ),_MatcapShadowToggle);
			float4 blendOpDest259_g70 = _MatcapShadowColor;
			float4 MatcapShadow261_g70 = ( saturate( ( blendOpSrc259_g70 + blendOpDest259_g70 ) ));
			float3 localFunction_ShadeSH9411_g70 = Function_ShadeSH9();
			float3 localFunction_ShadeSH9410_g70 = Function_ShadeSH9();
			float3 blendOpSrc412_g70 = localFunction_ShadeSH9411_g70;
			float3 blendOpDest412_g70 = localFunction_ShadeSH9410_g70;
			float3 localFunction_ShadeSH9197_g70 = Function_ShadeSH9();
			float3 blendOpSrc409_g70 = ( saturate( 	max( blendOpSrc412_g70, blendOpDest412_g70 ) ));
			float3 blendOpDest409_g70 = localFunction_ShadeSH9197_g70;
			float4 transform189_g70 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult193_g70 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform189_g70 ) );
			float3 reflVect198_g70 = normalizeResult193_g70.xyz;
			float3 localCubemapReflections198_g70 = CubemapReflections198_g70( reflVect198_g70 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 ifLocalVar196_g70 = 0;
			if( _WorldSpaceLightPos0.w <= 0.0 )
				ifLocalVar196_g70 = ase_lightColor;
			else
				ifLocalVar196_g70 = ( ase_lightAtten * ase_lightColor );
			float4 temp_output_200_0_g70 = saturate( ( float4( ( saturate( 	max( blendOpSrc409_g70, blendOpDest409_g70 ) )) , 0.0 ) + float4( localCubemapReflections198_g70 , 0.0 ) + ifLocalVar196_g70 ) );
			float4 Lighting201_g70 = temp_output_200_0_g70;
			float4 blendOpSrc365_g70 = _Shadow1Color;
			float4 blendOpDest365_g70 = _Shadow2Color;
			float3 lerpResult333_g70 = lerp( NormalMap208_g70 , float3( 0,0,1 ) , _NormalIntensity);
			float3 newWorldNormal334_g70 = (WorldNormalVector( i , lerpResult333_g70 ));
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g72 = dot( newWorldNormal334_g70 , ase_worldlightDir );
			float temp_output_335_0_g70 = (dotResult5_g72*0.5 + 0.5);
			float4 transform434_g70 = mul(unity_ObjectToWorld,float4( _VDirLight , 0.0 ));
			float dotResult441_g70 = dot( transform434_g70 , float4( newWorldNormal334_g70 , 0.0 ) );
			float ifLocalVar431_g70 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar431_g70 = dotResult441_g70;
			else
				ifLocalVar431_g70 = lerp(temp_output_335_0_g70,saturate( ( temp_output_335_0_g70 * ase_lightAtten ) ),_ObjectShadow);
			float temp_output_351_0_g70 = ( ( ( ( _Shadow1Place + ifLocalVar431_g70 ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_13 = (temp_output_351_0_g70).xxxx;
			float div354_g70=256.0/float((int)255.0);
			float4 posterize354_g70 = ( floor( temp_cast_13 * div354_g70 ) / div354_g70 );
			float4 temp_cast_14 = (temp_output_351_0_g70).xxxx;
			float4 ifLocalVar358_g70 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar358_g70 = posterize354_g70;
			else
				ifLocalVar358_g70 = temp_cast_14;
			float4 temp_cast_15 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_16 = (1.0).xxxx;
			float4 clampResult364_g70 = clamp( ifLocalVar358_g70 , temp_cast_15 , temp_cast_16 );
			float4 lerpResult366_g70 = lerp( _Shadow1Color , float4( 1,1,1,0 ) , clampResult364_g70);
			float temp_output_353_0_g70 = ( ( ( ( _Shadow2Place + ifLocalVar431_g70 ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_18 = (temp_output_353_0_g70).xxxx;
			float div356_g70=256.0/float((int)255.0);
			float4 posterize356_g70 = ( floor( temp_cast_18 * div356_g70 ) / div356_g70 );
			float4 temp_cast_19 = (temp_output_353_0_g70).xxxx;
			float4 ifLocalVar360_g70 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar360_g70 = posterize356_g70;
			else
				ifLocalVar360_g70 = temp_cast_19;
			float4 temp_cast_20 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_21 = (1.0).xxxx;
			float4 clampResult363_g70 = clamp( ifLocalVar360_g70 , temp_cast_20 , temp_cast_21 );
			float4 lerpResult368_g70 = lerp( ( saturate( min( blendOpSrc365_g70 , blendOpDest365_g70 ) )) , lerpResult366_g70 , clampResult363_g70);
			float2 uv_ShadowMask369_g70 = i.uv_texcoord;
			float4 lerpResult372_g70 = lerp( float4( 1,1,1,1 ) , lerp(float4( 1,1,1,1 ),lerpResult368_g70,_HalfLambertToggle) , tex2D( _ShadowMask, uv_ShadowMask369_g70 ));
			float4 Shadow375_g70 = lerpResult372_g70;
			float2 uv_EmissiveScrollMask5_g71 = i.uv_texcoord;
			float4 tex2DNode5_g71 = tex2D( _EmissiveScrollMask, uv_EmissiveScrollMask5_g71 );
			float4 lerpResult451_g70 = lerp( saturate( ( ( RimLight233_g70 + Matcap260_g70 ) * MatcapShadow261_g70 * Lighting201_g70 * Shadow375_g70 ) ) , float4( 0,0,0,0 ) , lerp(float4( 0,0,0,0 ),tex2DNode5_g71,_ForceEmissiveToogle));
			c.rgb = lerpResult451_g70.rgb;
			c.a = 1;
			clip( temp_output_84_0_g70.a - _CutoutThreshold );
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
			float2 uv_ScanLineTex14_g73 = i.uv_texcoord;
			float3 ase_worldPos = i.worldPos;
			float3 worldToObj29_g73 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float lerpResult11_g73 = lerp( 0.0 ,  ( tex2D( _ScanLineTex, uv_ScanLineTex14_g73 ).r - 0.0 > 0.1 ? 1.0 : tex2D( _ScanLineTex, uv_ScanLineTex14_g73 ).r - 0.0 <= 0.1 && tex2D( _ScanLineTex, uv_ScanLineTex14_g73 ).r + 0.0 >= 0.1 ? 0.0 : 0.0 )  ,  ( ( worldToObj29_g73.y + _ScanLinePosition ) - (0.0 + (_ScanLineWidth - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) > ( (0.0 + (frac( ( ( _Time.y / 3.0 ) * _ScanLineSpeed ) ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0)) - 1.0 ) ? 0.0 : ( worldToObj29_g73.y + _ScanLinePosition ) - (0.0 + (_ScanLineWidth - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) <= ( (0.0 + (frac( ( ( _Time.y / 3.0 ) * _ScanLineSpeed ) ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0)) - 1.0 ) && ( worldToObj29_g73.y + _ScanLinePosition ) + (0.0 + (_ScanLineWidth - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) >= ( (0.0 + (frac( ( ( _Time.y / 3.0 ) * _ScanLineSpeed ) ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0)) - 1.0 ) ? 1.0 : 0.0 ) );
			float2 uv_EmissionMap = i.uv_texcoord * _EmissionMap_ST.xy + _EmissionMap_ST.zw;
			float2 temp_cast_0 = (_EmissiveScrollTiling).xx;
			float2 uv_TexCoord1_g71 = i.uv_texcoord * temp_cast_0 + ( _Time.x * _EmissiveScrollSpeed );
			float2 uv_EmissiveScrollMask5_g71 = i.uv_texcoord;
			float4 tex2DNode5_g71 = tex2D( _EmissiveScrollMask, uv_EmissiveScrollMask5_g71 );
			float4 lerpResult6_g71 = lerp( float4( 0,0,0,0 ) , tex2D( _EmissiveScrollTex, uv_TexCoord1_g71 ) , tex2DNode5_g71);
			float2 ScrollDir59_g71 = _EmissiveScrollSpeed;
			float dotResult78_g71 = dot( i.uv_texcoord , ScrollDir59_g71 );
			float2 break53_g71 = cos( ( UNITY_PI * ( ( dotResult78_g71 + _Time.y ) * ScrollDir59_g71 ) ) );
			float4 lerpResult50_g71 = lerp( float4( 0,0,0,0 ) , ( _EmissiveScrollColor * ( 1.0 - saturate( ( ( ( ( ( break53_g71.x + break53_g71.y ) + _Strength ) - 0.5 ) * _GradientCotrast ) + 0.5 ) ) ) ) , tex2DNode5_g71);
			o.Emission = ( lerp(float4( 0,0,0,0 ),( lerpResult11_g73 * _ScanLineColor ),_ScanLineToggle) + lerp(( tex2D( _EmissionMap, uv_EmissionMap ) * _EmissionColor ),saturate( lerp(( lerpResult6_g71 * _EmissiveScrollColor ),lerpResult50_g71,_EmissiveScrollGradient) ),_EmissiveScrollToggle) ).rgb;
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
Version=15800
819;92;1101;926;550.2584;756.1608;1.502612;False;False
Node;AmplifyShaderEditor.FunctionNode;89;-411.4024,126.0497;Float;False;Reflex Shader Function;0;;70;f5d8f584674c8984ab029c8868eb5bf3;0;0;6;COLOR;186;FLOAT;265;COLOR;0;COLOR;402;FLOAT;403;COLOR;404
Node;AmplifyShaderEditor.CommentaryNode;46;338.6193,-381.5405;Float;False;354.991;331.938;Properties;2;48;47;Miscellaneous;0.5514706,0.5514706,0.5514706,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;47;378.3102,-222.1641;Float;False;Property;_CutoutThreshold;Cutout Threshold;47;0;Create;True;0;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;31;-7.553241,256.6598;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;48;376.6192,-309.541;Float;False;Property;_CullMode;Cull Mode;46;0;Create;True;0;0;True;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;324,-10;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;Reflex Shader 2/Reflex Shader 2 Cutout;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;48;-1;0;True;47;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;89;402
WireConnection;31;2;89;403
WireConnection;31;1;89;404
WireConnection;0;2;89;186
WireConnection;0;10;89;265
WireConnection;0;13;89;0
WireConnection;0;11;31;0
ASEEND*/
//CHKSM=A2542C32E4730B5210E6B8F3FE3793F0D2852C01