// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Move"
{
	Properties
	{
		_MoveHeight("MoveHeight", Range( 0 , 0.8)) = 0.4
		_Epicenter("Epicenter", Vector) = (0,0,0,0)
		_MoveFrequency("MoveFrequency", Range( 1 , 3)) = 2
		_MoveSpeed("MoveSpeed", Range( 0 , 5)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float3 _Epicenter;
		uniform float _MoveSpeed;
		uniform float _MoveFrequency;
		uniform float _MoveHeight;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 objToWorld19 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float4 transform17 = mul(unity_WorldToObject,float4( objToWorld19 , 0.0 ));
			float mulTime3 = _Time.y * _MoveSpeed;
			float temp_output_8_0 = sin( ( ( distance( float4( _Epicenter , 0.0 ) , transform17 ) + mulTime3 ) * _MoveFrequency ) );
			float3 temp_output_15_0 = ( temp_output_8_0 * float3(0,1,0) * _MoveHeight );
			v.vertex.xyz += temp_output_15_0;
			v.vertex.w = 1;
			v.normal = temp_output_15_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color12 = IsGammaSpace() ? float4(0.4575472,1,0.9213525,0) : float4(0.1768298,1,0.8303288,0);
			float4 color13 = IsGammaSpace() ? float4(1,0.3066038,0.3481497,0) : float4(1,0.07655142,0.09938328,0);
			float3 objToWorld19 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float4 transform17 = mul(unity_WorldToObject,float4( objToWorld19 , 0.0 ));
			float mulTime3 = _Time.y * _MoveSpeed;
			float temp_output_8_0 = sin( ( ( distance( float4( _Epicenter , 0.0 ) , transform17 ) + mulTime3 ) * _MoveFrequency ) );
			float4 lerpResult14 = lerp( color12 , color13 , (0.0 + (temp_output_8_0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			o.Albedo = lerpResult14.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
598;73;1013;645;1389.311;-125.0199;1.008958;False;False
Node;AmplifyShaderEditor.TransformPositionNode;19;-1700.461,260.4706;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;1;-1417.18,105.2847;Inherit;False;Property;_Epicenter;Epicenter;1;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,10;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldToObjectTransfNode;17;-1441.885,265.3248;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1418.368,476.6904;Inherit;False;Property;_MoveSpeed;MoveSpeed;3;0;Create;True;0;0;0;False;0;False;1;2.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-1155.395,228.5988;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1131.32,363.0873;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1091.874,480.7238;Inherit;False;Property;_MoveFrequency;MoveFrequency;2;0;Create;True;0;0;0;False;0;False;2;1;1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-951.9168,242.823;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-782.9176,245.423;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;8;-624.3176,246.7229;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;11;-644.0176,346.123;Inherit;False;Constant;_DeformationVector;DeformationVector;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCRemapNode;10;-466.9178,61.62261;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-801.4297,-70.18044;Inherit;False;Constant;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;1,0.3066038,0.3481497,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-797.5298,-254.0804;Inherit;False;Constant;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0.4575472,1,0.9213525,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-666.1768,514.3472;Inherit;False;Property;_MoveHeight;MoveHeight;0;0;Create;True;0;0;0;False;0;False;0.4;0.4;0;0.8;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;14;-247.5238,-96.85609;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-381.1176,293.0228;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;S_Move;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;19;0
WireConnection;4;0;1;0
WireConnection;4;1;17;0
WireConnection;3;0;18;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;8;0;7;0
WireConnection;10;0;8;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;14;2;10;0
WireConnection;15;0;8;0
WireConnection;15;1;11;0
WireConnection;15;2;9;0
WireConnection;0;0;14;0
WireConnection;0;11;15;0
WireConnection;0;12;15;0
ASEEND*/
//CHKSM=9E4DD98065B3A181E17FA528BD4477FB6365FC18