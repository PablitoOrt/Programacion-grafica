// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Outline"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		[NoScaleOffset]_FlowandMask("Flow and Mask", 2D) = "white" {}
		_ColorChangeSpeed("Color Change Speed", Range( 0 , 10)) = 10
		_OutlineIntensity("Outline Intensity", Range( 0 , 1)) = 1
		_TextureButton("Texture Button", 2D) = "white" {}
		_TextureOutline("Texture Outline", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			#include "UnityShaderVariables.cginc"

			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform sampler2D _TextureOutline;
			uniform sampler2D _FlowandMask;
			uniform float4 _FlowandMask_ST;
			uniform sampler2D _TextureButton;
			uniform float4 _TextureButton_ST;
			uniform float4 _TextureOutline_ST;
			uniform float _ColorChangeSpeed;
			uniform float _OutlineIntensity;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_FlowandMask = IN.texcoord.xy * _FlowandMask_ST.xy + _FlowandMask_ST.zw;
				float4 tex2DNode14_g1 = tex2D( _FlowandMask, uv_FlowandMask );
				float2 appendResult20_g1 = (float2(tex2DNode14_g1.r , tex2DNode14_g1.g));
				float TimeVar197_g1 = _Time.y;
				float2 temp_cast_0 = (TimeVar197_g1).xx;
				float2 temp_output_18_0_g1 = ( appendResult20_g1 - temp_cast_0 );
				float4 tex2DNode72_g1 = tex2D( _TextureOutline, temp_output_18_0_g1 );
				float2 uv_TextureButton = IN.texcoord.xy * _TextureButton_ST.xy + _TextureButton_ST.zw;
				float2 uv_TextureOutline = IN.texcoord.xy * _TextureOutline_ST.xy + _TextureOutline_ST.zw;
				float4 tex2DNode33 = tex2D( _TextureOutline, uv_TextureOutline );
				float4 color35 = IsGammaSpace() ? float4(0.4958488,0.009419684,0.7132075,0) : float4(0.2102189,0.0007290777,0.4670276,0);
				float4 color36 = IsGammaSpace() ? float4(0.007843137,0.01604216,0.7137255,0) : float4(0.0006070539,0.001241653,0.4677838,0);
				float4 lerpResult40 = lerp( color35 , color36 , ( sin( _Time.y ) * _ColorChangeSpeed ));
				float4 lerpResult34 = lerp( tex2D( _TextureButton, uv_TextureButton ) , ( tex2DNode33.a * ( lerpResult40 * _OutlineIntensity ) ) , tex2DNode33.a);
				float4 temp_output_192_0_g1 = lerpResult34;
				
				half4 color = ( ( tex2DNode72_g1 * tex2DNode14_g1.a ) + temp_output_192_0_g1 );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
877.6;73.6;698.8;775.8;1771.443;325.6211;1.957158;False;False
Node;AmplifyShaderEditor.SimpleTimeNode;37;-1644.473,725.0517;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1656.439,840.7148;Inherit;False;Property;_ColorChangeSpeed;Color Change Speed;7;0;Create;True;0;0;0;False;0;False;10;7.004435;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;38;-1475.672,725.0518;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1346.07,725.0519;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-1535.671,328.2512;Inherit;False;Constant;_Color0;Color 0;5;0;Create;True;0;0;0;False;0;False;0.4958488,0.009419684,0.7132075,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-1534.073,530.6518;Inherit;False;Constant;_Color1;Color 1;5;0;Create;True;0;0;0;False;0;False;0.007843137,0.01604216,0.7137255,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;40;-1212.472,389.0513;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1218.073,525.8517;Inherit;False;Property;_OutlineIntensity;Outline Intensity;8;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;32;-1500.393,106.5709;Inherit;True;Property;_TextureOutline;Texture Outline;10;0;Create;True;0;0;0;False;0;False;7a1fd3f5fef75b64385591e1890d1842;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1034.875,318.6512;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;30;-1515.204,-121.0445;Inherit;True;Property;_TextureButton;Texture Button;9;0;Create;True;0;0;0;False;0;False;e4cfc3e93092e704c8e777c6073f65a1;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;33;-1250.073,107.4509;Inherit;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-1261.605,-121.8444;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-865.3551,187.7711;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;34;-697.8361,-56.54918;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1;-430.5126,-55.60592;Inherit;False;UI-Sprite Effect Layer;0;;1;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,0,225,0,242,1,237,0,249,0,186,0,177,0,182,0,229,1,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;0.5849056,0.3614275,0.3614275,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-108.5878,-54.57291;Float;False;True;-1;2;ASEMaterialInspector;0;4;S_Outline;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;38;0;37;0
WireConnection;39;0;38;0
WireConnection;39;1;46;0
WireConnection;40;0;35;0
WireConnection;40;1;36;0
WireConnection;40;2;39;0
WireConnection;41;0;40;0
WireConnection;41;1;42;0
WireConnection;33;0;32;0
WireConnection;31;0;30;0
WireConnection;43;0;33;4
WireConnection;43;1;41;0
WireConnection;34;0;31;0
WireConnection;34;1;43;0
WireConnection;34;2;33;4
WireConnection;1;192;34;0
WireConnection;1;37;32;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=BBC712931DBE6F1C5BBADF9884642E2D27E4CC27