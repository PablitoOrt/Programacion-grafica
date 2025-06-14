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
		[NoScaleOffset]_FXTexture("FX Texture", 2D) = "white" {}
		_Color0("Color 0", Color) = (0.4958488,0.009419684,0.7132075,1)
		_Color1("Color 1", Color) = (0.007843137,0.01604216,0.7137255,1)
		_ColorSpeed("ColorSpeed", Range( 0 , 10)) = 10
		_OutlineIntensity("OutlineIntensity", Range( 0 , 3)) = 1
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
			uniform sampler2D _FXTexture;
			uniform sampler2D _TextureOutline;
			uniform float4 _TextureOutline_ST;
			uniform sampler2D _TextureButton;
			uniform float4 _TextureButton_ST;
			uniform float4 _Color0;
			uniform float4 _Color1;
			uniform float _ColorSpeed;
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

				float2 uv_TextureOutline = IN.texcoord.xy * _TextureOutline_ST.xy + _TextureOutline_ST.zw;
				float4 tex2DNode14_g1 = tex2D( _TextureOutline, uv_TextureOutline );
				float2 appendResult20_g1 = (float2(tex2DNode14_g1.r , tex2DNode14_g1.g));
				float TimeVar197_g1 = _Time.y;
				float2 temp_cast_0 = (TimeVar197_g1).xx;
				float2 temp_output_18_0_g1 = ( appendResult20_g1 - temp_cast_0 );
				float4 tex2DNode72_g1 = tex2D( _FXTexture, temp_output_18_0_g1 );
				float2 uv_TextureButton = IN.texcoord.xy * _TextureButton_ST.xy + _TextureButton_ST.zw;
				float4 tex2DNode33 = tex2D( _TextureOutline, uv_TextureOutline );
				float4 lerpResult40 = lerp( _Color0 , _Color1 , ( ( sin( ( _Time.y * _ColorSpeed ) ) + 1.0 ) / 2.0 ));
				float4 ColorOscillation49 = ( lerpResult40 * _OutlineIntensity );
				float4 lerpResult34 = lerp( tex2D( _TextureButton, uv_TextureButton ) , ( tex2DNode33.a * ColorOscillation49 ) , tex2DNode33.a);
				float4 temp_output_192_0_g1 = lerpResult34;
				
				half4 color = ( ( ( tex2DNode72_g1 * tex2DNode14_g1.a ) * float4( 0,0,0,1 ) ) + temp_output_192_0_g1 );
				
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
1160;73;392;689;1026.114;-610.7887;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;50;-1684.623,384.0835;Inherit;False;1691.215;723.4813;Outline color and oscillation;12;39;37;46;38;47;48;40;41;42;35;36;49;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1634.623,882.8824;Inherit;False;Property;_ColorSpeed;ColorSpeed;9;0;Create;True;0;0;0;False;0;False;10;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;37;-1533.887,797.2191;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1351.773,798.2767;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;38;-1183.085,797.2192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1059.798,797.5192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-926.4002,434.0833;Inherit;False;Property;_Color0;Color 0;7;0;Create;True;0;0;0;False;0;False;0.4958488,0.009419684,0.7132075,1;0.9433962,0.8591385,0.3159488,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-934.5876,615.8788;Inherit;False;Property;_Color1;Color 1;8;0;Create;True;0;0;0;False;0;False;0.007843137,0.01604216,0.7137255,1;0.8490566,0.244304,0.2501648,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;48;-928.7977,797.0573;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-705.7596,926.5637;Inherit;False;Property;_OutlineIntensity;OutlineIntensity;10;0;Create;True;0;0;0;False;0;False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;40;-618.5219,714.7656;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-422.1438,714.3644;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-223.406,710.1373;Inherit;False;ColorOscillation;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;32;-1523.781,-94.9101;Inherit;True;Property;_TextureOutline;Texture Outline;12;0;Create;True;0;0;0;False;0;False;7a1fd3f5fef75b64385591e1890d1842;7a1fd3f5fef75b64385591e1890d1842;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;33;-1273.461,-94.03011;Inherit;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;30;-1524.541,-301.1714;Inherit;True;Property;_TextureButton;Texture Button;11;0;Create;True;0;0;0;False;0;False;e4cfc3e93092e704c8e777c6073f65a1;427bbc6cfb32dee4ba8b077d52d2f7ab;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.GetLocalVarNode;51;-1173.899,124.187;Inherit;False;49;ColorOscillation;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-938.8303,103.6529;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;31;-1272.088,-302.7074;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;53;-1274.347,222.625;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.LerpOp;34;-716.4822,-142.1862;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;52;-526.8481,233.0249;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1;-434.434,-141.2414;Inherit;False;UI-Sprite Effect Layer;0;;1;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,1,225,0,242,1,237,0,249,0,186,0,177,0,182,0,229,1,92,1,98,0,234,0,126,0,129,1,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;0,0,0,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-76.57502,-138.4201;Float;False;True;-1;2;ASEMaterialInspector;0;4;S_Outline;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;True;True;True;True;True;0;True;-9;False;False;False;False;False;False;False;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;39;0;37;0
WireConnection;39;1;46;0
WireConnection;38;0;39;0
WireConnection;47;0;38;0
WireConnection;48;0;47;0
WireConnection;40;0;35;0
WireConnection;40;1;36;0
WireConnection;40;2;48;0
WireConnection;41;0;40;0
WireConnection;41;1;42;0
WireConnection;49;0;41;0
WireConnection;33;0;32;0
WireConnection;43;0;33;4
WireConnection;43;1;51;0
WireConnection;31;0;30;0
WireConnection;53;0;32;0
WireConnection;34;0;31;0
WireConnection;34;1;43;0
WireConnection;34;2;33;4
WireConnection;52;0;53;0
WireConnection;1;192;34;0
WireConnection;1;33;52;0
WireConnection;0;0;1;0
ASEEND*/
//CHKSM=D96E985796237F046ED437353CBDFE32A89F77B0