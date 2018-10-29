// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShaders/ReflexShader_2_Cutout"
{
	Properties
	{
		_MainTex("Diffuse", 2D) = "white" {}
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,1)
		[Normal]_BumpMap("Normal Map", 2D) = "bump" {}
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
		
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		
		
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};
		uniform float _OutlineWidth;
		uniform sampler2D _OutlineMask;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _DiffuseColor;
		uniform float4 _OutlineColor;
		uniform float _HalfLambertToggle;
		uniform float4 _Shadow1Color;
		uniform float4 _Shadow2Color;
		uniform float _PosterizeToggle;
		uniform float _Shadow1Place;
		uniform float _ObjectShadow;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _NormalIntensity;
		uniform float _HalfLambertContrast;
		uniform float _ShadowDarknessMin;
		uniform float _Shadow2Place;
		uniform sampler2D _ShadowMask;
		uniform float _OutlineToggle;
		uniform float _CutoutThreshold;
		
		float3 Function_ShadeSH9(  )
		{
			return ShadeSH9(half4(0,0,0,1));
		}


		float3 CubemapReflections198_g1( float3 reflVect )
		{
			float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
			float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
			return reflCol * 0.02;
		}


		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OutlineMask389_g1 = v.texcoord;
			float outlineVar = ( (0.0 + (_OutlineWidth - 0.0) * (0.0002 - 0.0) / (1.0 - 0.0)) * tex2Dlod( _OutlineMask, float4( uv_OutlineMask389_g1, 0, 0.0) ) ).r;
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_84_0_g1 = ( tex2D( _MainTex, uv_MainTex ) * _DiffuseColor );
			float4 Diffuse105_g1 = temp_output_84_0_g1;
			float3 appendResult387_g1 = (float3(_OutlineColor.r , _OutlineColor.g , _OutlineColor.b));
			float3 localFunction_ShadeSH9411_g1 = Function_ShadeSH9();
			float3 localFunction_ShadeSH9410_g1 = Function_ShadeSH9();
			float3 blendOpSrc412_g1 = localFunction_ShadeSH9411_g1;
			float3 blendOpDest412_g1 = localFunction_ShadeSH9410_g1;
			float3 localFunction_ShadeSH9197_g1 = Function_ShadeSH9();
			float3 blendOpSrc409_g1 = ( saturate( 	max( blendOpSrc412_g1, blendOpDest412_g1 ) ));
			float3 blendOpDest409_g1 = localFunction_ShadeSH9197_g1;
			float4 transform189_g1 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult193_g1 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform189_g1 ) );
			float3 reflVect198_g1 = normalizeResult193_g1.xyz;
			float3 localCubemapReflections198_g1 = CubemapReflections198_g1( reflVect198_g1 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 ifLocalVar196_g1 = 0;
			if( _WorldSpaceLightPos0.w <= 0.0 )
				ifLocalVar196_g1 = ase_lightColor;
			else
				ifLocalVar196_g1 = ( 1 * ase_lightColor );
			float4 Lighting201_g1 = saturate( ( float4( ( saturate( 	max( blendOpSrc409_g1, blendOpDest409_g1 ) )) , 0.0 ) + float4( localCubemapReflections198_g1 , 0.0 ) + ifLocalVar196_g1 ) );
			float4 blendOpSrc365_g1 = _Shadow1Color;
			float4 blendOpDest365_g1 = _Shadow2Color;
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 tex2DNode207_g1 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap ) );
			float3 NormalMap208_g1 = tex2DNode207_g1;
			float3 lerpResult333_g1 = lerp( NormalMap208_g1 , float3( 0,0,1 ) , _NormalIntensity);
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5_g2 = dot( WorldNormalVector( i , lerpResult333_g1 ) , ase_worldlightDir );
			float temp_output_335_0_g1 = (dotResult5_g2*0.5 + 0.5);
			float temp_output_351_0_g1 = ( ( ( ( _Shadow1Place + lerp(temp_output_335_0_g1,saturate( ( temp_output_335_0_g1 * 1 ) ),_ObjectShadow) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_6 = (temp_output_351_0_g1).xxxx;
			float div354_g1=256.0/float((int)255.0);
			float4 posterize354_g1 = ( floor( temp_cast_6 * div354_g1 ) / div354_g1 );
			float4 temp_cast_7 = (temp_output_351_0_g1).xxxx;
			float4 ifLocalVar358_g1 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar358_g1 = posterize354_g1;
			else
				ifLocalVar358_g1 = temp_cast_7;
			float4 temp_cast_8 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_9 = (1.0).xxxx;
			float4 clampResult364_g1 = clamp( ifLocalVar358_g1 , temp_cast_8 , temp_cast_9 );
			float4 lerpResult366_g1 = lerp( _Shadow1Color , float4( 1,1,1,0 ) , clampResult364_g1.r);
			float temp_output_353_0_g1 = ( ( ( ( _Shadow2Place + lerp(temp_output_335_0_g1,saturate( ( temp_output_335_0_g1 * 1 ) ),_ObjectShadow) ) - 0.5 ) * _HalfLambertContrast ) + 0.5 );
			float4 temp_cast_12 = (temp_output_353_0_g1).xxxx;
			float div356_g1=256.0/float((int)255.0);
			float4 posterize356_g1 = ( floor( temp_cast_12 * div356_g1 ) / div356_g1 );
			float4 temp_cast_13 = (temp_output_353_0_g1).xxxx;
			float4 ifLocalVar360_g1 = 0;
			if( lerp(0.0,1.0,_PosterizeToggle) >= 0.5 )
				ifLocalVar360_g1 = posterize356_g1;
			else
				ifLocalVar360_g1 = temp_cast_13;
			float4 temp_cast_14 = (_ShadowDarknessMin).xxxx;
			float4 temp_cast_15 = (1.0).xxxx;
			float4 clampResult363_g1 = clamp( ifLocalVar360_g1 , temp_cast_14 , temp_cast_15 );
			float4 lerpResult368_g1 = lerp( ( saturate( min( blendOpSrc365_g1 , blendOpDest365_g1 ) )) , lerpResult366_g1 , clampResult363_g1.r);
			float2 uv_ShadowMask369_g1 = i.uv_texcoord;
			float4 lerpResult372_g1 = lerp( float4( 1,1,1,1 ) , lerp(float4( 1,1,1,1 ),lerpResult368_g1,_HalfLambertToggle) , tex2D( _ShadowMask, uv_ShadowMask369_g1 ).r);
			float4 temp_cast_18 = (1.0).xxxx;
			float4 temp_cast_19 = (1.0).xxxx;
			float4 ifLocalVar428_g1 = 0;
			if( ase_lightColor.a <= 0.0 )
				ifLocalVar428_g1 = temp_cast_19;
			else
				ifLocalVar428_g1 = lerpResult372_g1;
			float4 Shadow375_g1 = ifLocalVar428_g1;
			o.Emission = ( float4( ( (Diffuse105_g1).rgb * appendResult387_g1 ) , 0.0 ) * Lighting201_g1 * Shadow375_g1 ).rgb;
			clip( lerp(0.0,(Diffuse105_g1).a,_OutlineToggle) - _CutoutThreshold );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
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

		uniform float _CutoutThreshold;
		uniform float _CullMode;

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
			c.rgb = 0;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
843;92;1077;926;857.8137;357.1116;1;True;False
Node;AmplifyShaderEditor.FunctionNode;65;-612.7683,171.738;Float;False;Reflex Shader Function;0;;1;f5d8f584674c8984ab029c8868eb5bf3;0;0;6;COLOR;186;FLOAT;265;COLOR;0;COLOR;402;FLOAT;403;COLOR;404
Node;AmplifyShaderEditor.RangedFloatNode;47;-559.4156,-43.45108;Float;False;Property;_CutoutThreshold;Cutout Threshold;44;0;Create;True;0;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-561.1066,-130.828;Float;False;Property;_CullMode;Cull Mode;43;0;Create;True;0;0;True;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OutlineNode;31;-300.7683,301.7381;Float;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShaders/ReflexShader_2_Cutout;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;48;-1;0;True;47;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;46;-599.1066,-202.8279;Float;False;358.991;291.938;Properties;0;Miscellaneous;0.5514706,0.5514706,0.5514706,1;0;0
WireConnection;31;0;65;402
WireConnection;31;2;65;403
WireConnection;31;1;65;404
WireConnection;0;11;31;0
ASEEND*/
//CHKSM=D4803B3E59EC42641704A8B6B0A2AE7195409351