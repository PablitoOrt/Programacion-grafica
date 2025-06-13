// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Bloom"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Bloomintensity("_Bloomintensity", Range( -0.1 , 0.3)) = 0
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
			
			uniform float _Bloomintensity;


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
				float4 tex2DNode8 = tex2D( _MainTex, uv_MainTex );
				float luminance4 = Luminance(tex2DNode8.rgb);
				float4 ScreenTexSample19 = tex2DNode8;
				

				finalColor = ( ( tex2DNode8 * step( luminance4 , 1.0 ) ) + ( ( ScreenTexSample19 + ScreenTexSample19 + ScreenTexSample19 + ScreenTexSample19 + ScreenTexSample19 ) * _Bloomintensity ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
360;1;1110;598;1326.063;226.2469;1.396802;False;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;7;-1247.197,-109.3448;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1099.555,-113.7223;Inherit;True;Property;_TextureSample;Texture Sample ;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-777.4847,-167.7224;Inherit;False;ScreenTexSample;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LuminanceNode;4;-684.2988,-6.130579;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-687.8627,92.30299;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-889.8596,255.6124;Inherit;False;19;ScreenTexSample;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;3;-500.1785,-1.38448;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-594.7546,224.9258;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-543.84,423.3416;Inherit;False;Property;_Bloomintensity;_Bloomintensity;0;0;Create;False;0;0;0;False;0;False;0;-0.01568185;-0.1;0.3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-257.2586,-93.77132;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-320.2957,233.5565;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-11.21503,176.2751;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;215.7675,157.0788;Float;False;True;-1;2;ASEMaterialInspector;0;2;Bloom;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;8;0;7;0
WireConnection;19;0;8;0
WireConnection;4;0;8;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;15;0;21;0
WireConnection;15;1;21;0
WireConnection;15;2;21;0
WireConnection;15;3;21;0
WireConnection;15;4;21;0
WireConnection;6;0;8;0
WireConnection;6;1;3;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;18;0;6;0
WireConnection;18;1;16;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=060D98825484F3536013AABB1EA6C2CFCD054D73