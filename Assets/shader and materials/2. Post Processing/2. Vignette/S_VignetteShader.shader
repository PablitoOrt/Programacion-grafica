// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_VignetteShader"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_MaskScale("_MaskScale", Range( 0 , 2)) = 0.7743408
		_MaskHardness("_MaskHardness", Range( 0 , 1)) = 0
		_MaskPower("_MaskPower", Range( 0 , 1)) = 5
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			

			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float4 _Color0;
			uniform float _MaskScale;
			uniform float _MaskHardness;
			uniform float _MaskPower;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord28 = i.uv.xy * float2( 2,2 ) + float2( -1,-1 );
				float temp_output_1_0_g5 = _MaskScale;
				float lerpResult30 = lerp( 0.0 , _MaskScale , _MaskHardness);
				float4 lerpResult39 = lerp( _Color0 , tex2D( _MainTex, uv_MainTex ) , pow( saturate( ( ( length( texCoord28 ) - temp_output_1_0_g5 ) / ( ( lerpResult30 - 0.001 ) - temp_output_1_0_g5 ) ) ) , _MaskPower ));
				

				finalColor = lerpResult39;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
480;210;1110;598;1047.324;561.1654;1.346823;False;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-658.4002,292.1799;Inherit;False;Property;_MaskHardness;_MaskHardness;1;0;Create;True;0;0;0;False;0;False;0;0.278261;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-673.9073,-22.08574;Inherit;False;Property;_MaskScale;_MaskScale;0;0;Create;True;0;0;0;False;0;False;0.7743408;0.635444;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-837.8534,70.00543;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;2,2;False;1;FLOAT2;-1,-1;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;30;-405.8233,173.1162;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;29;-571.6833,69.08183;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-242.1623,173.116;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;32;-40.91404,19.65016;Inherit;True;Inverse Lerp;-1;;5;09cbe79402f023141a4dc1fddd4c9511;0;3;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;238.1076,19.87736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;151.7876,322.331;Inherit;False;Property;_MaskPower;_MaskPower;2;0;Create;True;0;0;0;False;0;False;5;0.5083548;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;41;-397.6388,-376.7415;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;36;412.0634,89.34729;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3.91;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;42;-262.7047,-369.2101;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;8c4a7fca2884fab419769ccc0355c0c1;8c4a7fca2884fab419769ccc0355c0c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;0,0,0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;40;-346.4967,-163.4877;Inherit;False;Property;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;39;479.3948,-226.7953;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;715.3946,69.03036;Float;False;True;-1;2;ASEMaterialInspector;0;2;S_VignetteShader;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;30;1;27;0
WireConnection;30;2;26;0
WireConnection;29;0;28;0
WireConnection;31;0;30;0
WireConnection;32;1;27;0
WireConnection;32;2;31;0
WireConnection;32;3;29;0
WireConnection;33;0;32;0
WireConnection;36;0;33;0
WireConnection;36;1;35;0
WireConnection;42;0;41;0
WireConnection;39;0;40;0
WireConnection;39;1;42;0
WireConnection;39;2;36;0
WireConnection;0;0;39;0
ASEEND*/
//CHKSM=05AC067C5FA723A20D39DEEFE4B4F60735F966C7