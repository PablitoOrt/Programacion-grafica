// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_MetallicButton"
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
		_Speed("Speed", Range( 0 , 1)) = 0.1
		_Sharpness("Sharpness", Range( 1 , 4)) = 1.326831
		_Angle("Angle", Range( 0 , 90)) = 20.70817
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_lineColor("lineColor", Color) = (0,0,0,1)

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
			uniform float4 _BaseColor;
			uniform float4 _lineColor;
			uniform float _Angle;
			uniform float _Speed;
			uniform float _Sharpness;

			
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

				float2 break27 = IN.texcoord.xy;
				float temp_output_58_0 = radians( _Angle );
				float proyeccionHorizontal64 = ( ( break27.x * cos( temp_output_58_0 ) ) + ( break27.y * sin( temp_output_58_0 ) ) );
				float Brillo51 = pow( ( 1.0 - ( abs( ( frac( ( proyeccionHorizontal64 + ( _Time.y * _Speed ) ) ) - 0.5 ) ) * 2.0 ) ) , _Sharpness );
				float4 lerpResult67 = lerp( _BaseColor , _lineColor , Brillo51);
				
				half4 color = lerpResult67;
				
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
876;73;709;645;534.1944;1362.291;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;63;-2045.155,-1307.078;Inherit;False;1325.706;362.853;angulo de la linea;10;64;56;57;58;60;59;62;61;27;26;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1998.562,-1040.818;Inherit;False;Property;_Angle;Angle;2;0;Create;True;0;0;0;False;0;False;20.70817;28;0;90;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;26;-1874.518,-1257.052;Inherit;True;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;58;-1723.211,-1036.219;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;27;-1633.207,-1257.078;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CosOpNode;59;-1563.642,-1128.992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;60;-1561.047,-1037.907;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-1369.478,-1258.06;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1372.478,-1154.572;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-1172.329,-1235.146;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;50;-2050.309,-1758.049;Inherit;False;1735.207;420.0276;brillo;13;65;25;13;24;51;47;46;48;45;43;42;39;28;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-2000.238,-1590.897;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2097.418,-1460.332;Inherit;False;Property;_Speed;Speed;0;0;Create;True;0;0;0;False;0;False;0.1;0.35;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-975.5809,-1240.887;Inherit;False;proyeccionHorizontal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-1900.428,-1697.515;Inherit;False;64;proyeccionHorizontal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1808.738,-1573.197;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-1631.851,-1604.55;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;39;-1484.794,-1604.966;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;42;-1326.348,-1604.254;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;43;-1194.928,-1603.517;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1063.088,-1603.812;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;46;-926.2877,-1604.513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1069.287,-1483.215;Inherit;False;Property;_Sharpness;Sharpness;1;0;Create;True;0;0;0;False;0;False;1.326831;2.315066;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;47;-769.9875,-1603.813;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-532.6081,-1607.827;Inherit;False;Brillo;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-609.8335,-918.5216;Inherit;False;51;Brillo;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;66;-646.7541,-1286.297;Inherit;False;Property;_BaseColor;BaseColor;3;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.5566037,0.4665493,0.1706567,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;31;-648.6221,-1110.623;Inherit;False;Property;_lineColor;lineColor;4;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.9433962,0.9115677,0.4138482,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;67;-342.4911,-1082.008;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-155.2882,-1082.558;Float;False;True;-1;2;ASEMaterialInspector;0;4;S_MetallicButton;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;58;0;57;0
WireConnection;27;0;26;0
WireConnection;59;0;58;0
WireConnection;60;0;58;0
WireConnection;61;0;27;0
WireConnection;61;1;59;0
WireConnection;62;0;27;1
WireConnection;62;1;60;0
WireConnection;56;0;61;0
WireConnection;56;1;62;0
WireConnection;64;0;56;0
WireConnection;25;0;24;0
WireConnection;25;1;13;0
WireConnection;28;0;65;0
WireConnection;28;1;25;0
WireConnection;39;0;28;0
WireConnection;42;0;39;0
WireConnection;43;0;42;0
WireConnection;45;0;43;0
WireConnection;46;0;45;0
WireConnection;47;0;46;0
WireConnection;47;1;48;0
WireConnection;51;0;47;0
WireConnection;67;0;66;0
WireConnection;67;1;31;0
WireConnection;67;2;52;0
WireConnection;0;0;67;0
ASEEND*/
//CHKSM=805454A11A8EF7BE343932199B521D9F562EA4FD